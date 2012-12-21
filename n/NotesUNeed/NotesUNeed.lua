


-- Saved Data

NuNData = {};
NuNSettings = {};




-- Arrays

local dfltHeadings = NUN_DFLTHEADINGS;
local HRaces = NUN_HRACES;
local ARaces = NUN_ARACES;
local AllClasses = NUN_ALLCLASSES;
local HClasses = NUN_HCLASSES;
local AClasses = NUN_ACLASSES;
local HRanks = NUN_HRANKS;
local ARanks = NUN_ARANKS;
local Professions = NUN_PROFESSIONS;
local Sexes = NUN_SEXES;
local searchFor = NUN_SEARCHFOR;
local transmitTo = NUN_TRANSMITTO;
local invSlotList = NUN_INVENTORY_SLOT_LIST;
local noteTypes = NUN_NOTETYPES;

local Races = {};
local Ranks = {};
local Classes = {};

local foundNuN = {};
local c_continents = {};
local foundHNuN = {};
local foundANuN = {};
local foundNNuN = {};
local NuNQuestLog = {};

local NuN_Filtered = {};

local NuN_MapNotesValidVersions = {
	"1800.7",
};
local NuN_MapNotesPlayedVersions = {};

local NuN_LastOpen = {};



-- Local Variables

local bttnChanges = {};
local uBttns = getn(dfltHeadings);
local detlOffset = uBttns;
local hdngOffset = (uBttns * 2);
local pHead = "~Hdng";
local pDetl = "~Detl";
local discard;
local c_name;
local prevName;
local c_class;
local c_race;
local c_guild;
local c_route;
local c_text;
local c_text_len;
local g_text;
local g_text_len;
local txtTxt = "txt";
local pName;
local pKey;
local pFaction;
local hdNbr;
local nameHdNbr;
local nameDtNbr;
local oriTxt;
local isTitle;
local bttnNumb;
local lastDD;
local switch;
local parm1;
local Notes = "notes~";
local itmIndex = "ItmIndex~";
local mrgIndex = "merged~";
local c_note;
local c_type;
local prevNote;
local tryI;
local lastBttn;
local lastBttnIndex;
local deletedE;
local visibles;
local lastVisible;
local lastBttnDetl;
local NuN_importing;
local updateInterval = 10;
local popUpUpdateInterval = 1;
local timeSinceLastUpdate = 0;
local popUpTimeSinceLastUpdate = 0;
local NuNRaceDropDown;
local NuNClassDropDown;
local NuNCRankDropDown;
local NuNHRankDropDown;
local unitTest;
local NuN_rType;
local ttName;
local gtName;
local NuN_Fade = "False";
local NuN_TT_Y_Offset = 0;
local NUN_TT_LEN = 80;
local NuN_GNote_OriTitle = nil;
local prevLink;
local NuN_PinUpHeader = false;
local lastPinned;
local pinnedTTMoved = true;
local typeIndex;
local NuN_Fingers;
local NuN_Trinkets;
local NuN_Hand;
local sendTo;
local msgSeq = 0;
local NuNSearchTitle = NUN_SEARCH;
local NuN_Parties = "parties~";
local NuN_MouseOver = false;
local NuN_QuestsUpdating = "False";
local oneDone = false;
local NuN_AtStartup = "True";
local popUpHide = true;
local NuN_IgnoreNextQUpdate = nil;
local qTriggs = 0;
local noTipAnchor = nil;
local inBG = false;
local NuN_FirstTime = true;
local NuN_QuestAccepted = nil;




-- Local Function Hooks

local NuNOri_FriendsFrameFriendButton_OnClick;
local NuNOri_FriendsFrameIgnoreButton_OnClick;
local NuNOri_FriendsFrameGuildPlayerStatusButton_OnClick;
local NuNOri_FriendsFrameGuildStatusButton_OnClick;
local NuNOri_FriendsFrameWhoButton_OnClick;

local NuNOri_FriendsList_Update;
local NuNOri_IgnoreList_Update;
local NuNOri_GuildStatus_Update;
local NuNOri_WhoList_Update;
local NuNOri_ContainerFrameItemButton_OnClick;
local NuNOri_SetItemRef;
local NuNOri_PaperDollItemSlotButton_OnClick;
local NuNOri_QuestLog_Update;
local NuNOri_QuestLogRewardItem_OnClick;
local NuNOri_QuestItem_OnClick;
local NuNOri_QuestRewardItem_OnClick;
local NuNOri_AbandonQuest;
local NuNOri_QuestDetailAcceptButton_OnClick;
local NuNOri_QuestRewardCompleteButton_OnClick;

-- Hook the MapNotes Function
local NuNOri_MapNotes_OnEnter;
local NuNOri_MapNotes_OnLeave;
local NuNOri_MapNotes_DeleteNote;
local NuNOri_MetaMapNotes_OnEnter;
local NuNOri_MetaMapNotes_OnLeave;
local NuNOri_MetaMapNotes_DeleteNote;
local NuN_GetZoneTableSize;



-- Constants

NUN_VERSION = "3.21";
NUN_MAX_PARTY_MEMBERS = 4;
NUN_AUTO_C = "A";
NUN_SELF_C = "S";
NUN_MANU_C = "M";
NUN_HORD_C = "H";
NUN_ALLI_C = "A";
NUN_NOTE_C = "N";
NUN_QUEST_C = "Q";
NUN_PARTY_C = "P";
NUN_MAX_ADD_TXT = 4;
NUN_MAX_TXT_CHR = 1012;
NUN_MAX_TXT_LIM = (NUN_MAX_ADD_TXT + 1) * NUN_MAX_TXT_CHR;
NUN_MAX_TXT_C = tostring(NUN_MAX_TXT_LIM);
NUN_MAX_TXT_BUF = NUN_MAX_TXT_LIM - 225;
NUN_SEP = " ";
NUN_OFF = "Offline";
NUN_TT_HDNG = "tooltip";
NUN_TT_MAX = 1012;
NUN_TT_KEYPHRASE = "TT::";
NUN_TT_END = "::";
NUN_TT_LINES_TRIGGER = 6;
NUN_TT_Y_SHIFT = 12;
NUN_TT_KEYPHRASE_LEN = string.len(NUN_TT_KEYPHRASE);
NUN_TT_ETC = " .....";
NUN_TXT_LABEL = "0 / "..NUN_MAX_TXT_LIM;
NUN_SPEED = "Speed";
NUN_GOLD = "|cffffB300|h";
NUN_GREEN = "|cff00ee00|h";
NUN_WHITE = "|cffffffff|h";
NUN_C_END = "|h|r";
NUN_PINNED_TT_PADDING = "           ";
NUN_PLACE_HOLDER = "<Place Holder>";
NUN_CHAT_LIMIT = 180;
NUN_FRAMESCALE_MIN = 0.75;
NUN_FRAMESCALE_MAX = 1.75;
NUN_FRAMESCALE_STEP = 0.01;
NUN_TT_FONTSCALE_MIN = 0.90;
NUN_TT_FONTSCALE_MAX = 2.00;
NUN_FONTSCALE_STEP = 0.01;
NUN_TT_MAPFONTSCALE_MIN = 0.25;
NUN_TT_MAPFONTSCALE_MAX = 1.75;
NUN_MAPFONTSCALE_STEP = 0.01;
NUN_FRAMESCALE_MIN_TXT = tostring( NUN_FRAMESCALE_MIN * 100 ) .. "%";
NUN_FRAMESCALE_MAX_TXT = tostring( NUN_FRAMESCALE_MAX * 100 ) .. "%";
NUN_TT_FONTSCALE_MIN_TXT = tostring ( NUN_TT_FONTSCALE_MIN * 100 ) .. "%";
NUN_TT_FONTSCALE_MAX_TXT = tostring ( NUN_TT_FONTSCALE_MAX * 100 ) .. "%";
NUN_TT_MAPFONTSCALE_MIN_TXT = tostring ( NUN_TT_MAPFONTSCALE_MIN * 100 ) .. "%";
NUN_TT_MAPFONTSCALE_MAX_TXT = tostring ( NUN_TT_MAPFONTSCALE_MAX * 100 ) .. "%";
NUN_REPLACEQNAME_TXT = "$N";
NUN_REPLACEQCLASS_TXT = "$C";





-- MapNotes Version Warning

StaticPopupDialogs["NUN_MAPNOTES_VERSION_ALERT"] = {
	text = TEXT(NUN_MAPNOTESVERSION_WARNING),
	button1 = TEXT(OKAY),
	showAlert = 1,
	timeout = 0,
};

-- NotesUNeed Note Limit Exceeded

StaticPopupDialogs["NUN_NOTELIMIT_EXCEEDED"] = {
	text = TEXT(NUN_TEXTLIM1..NUN_MAX_TXT_LIM..NUN_TEXTLIM2),
	button1 = TEXT(OKAY),
	showAlert = 1,
	timeout = 0,
};








-- Mod Functions


function NuN_OnLoad()
	local continentID, zoneID, continent, zone;
	local c_zones = {};

	NuNOri_FriendsFrameFriendButton_OnClick = FriendsFrameFriendButton_OnClick;
	FriendsFrameFriendButton_OnClick = NuNNew_FriendsFrameFriendButton_OnClick;
	NuNOri_FriendsFrameIgnoreButton_OnClick = FriendsFrameIgnoreButton_OnClick;
	FriendsFrameIgnoreButton_OnClick = NuNNew_FriendsFrameIgnoreButton_OnClick;
	NuNOri_FriendsFrameGuildPlayerStatusButton_OnClick = FriendsFrameGuildPlayerStatusButton_OnClick;
	FriendsFrameGuildPlayerStatusButton_OnClick = NuNNew_FriendsFrameGuildPlayerStatusButton_OnClick;
	NuNOri_FriendsFrameGuildStatusButton_OnClick = FriendsFrameGuildStatusButton_OnClick;
	FriendsFrameGuildStatusButton_OnClick = NuNNew_FriendsFrameGuildStatusButton_OnClick;
	NuNOri_FriendsFrameWhoButton_OnClick = FriendsFrameWhoButton_OnClick;
	FriendsFrameWhoButton_OnClick = NuNNew_FriendsFrameWhoButton_OnClick;

	NuNOri_FriendsList_Update = FriendsList_Update;
	FriendsList_Update = NuNNew_FriendsList_Update;
	NuNOri_IgnoreList_Update = IgnoreList_Update;
	IgnoreList_Update = NuNNew_IgnoreList_Update;
	NuNOri_GuildStatus_Update = GuildStatus_Update;
	GuildStatus_Update = NuNNew_GuildStatus_Update;
	NuNOri_WhoList_Update = WhoList_Update;
	WhoList_Update = NuNNew_WhoList_Update;
	NuNOri_ContainerFrameItemButton_OnClick = ContainerFrameItemButton_OnClick;
	ContainerFrameItemButton_OnClick = NuNNew_ContainerFrameItemButton_OnClick;
	NuNOri_SetItemRef = SetItemRef;
	SetItemRef = NuNNew_SetItemRef;
	NuNOri_PaperDollItemSlotButton_OnClick = PaperDollItemSlotButton_OnClick;
	PaperDollItemSlotButton_OnClick = NuNNew_PaperDollItemSlotButton_OnClick;
	NuNOri_QuestLog_Update = QuestLog_Update;
	QuestLog_Update = NuNNew_QuestLog_Update;
	NuNOri_QuestLogRewardItem_OnClick = QuestLogRewardItem_OnClick;
	QuestLogRewardItem_OnClick = NuNNew_QuestLogRewardItem_OnClick;
	NuNOri_QuestItem_OnClick = QuestItem_OnClick;
	QuestItem_OnClick = NuNNew_QuestItem_OnClick;
	NuNOri_QuestRewardItem_OnClick = QuestRewardItem_OnClick;
	QuestRewardItem_OnClick = NuNNew_QuestRewardItem_OnClick;
	NuNOri_AbandonQuest = AbandonQuest;
	AbandonQuest = NuNNew_AbandonQuest;
	NuNOri_QuestDetailAcceptButton_OnClick = QuestDetailAcceptButton_OnClick;
	QuestDetailAcceptButton_OnClick = NuNNew_QuestDetailAcceptButton_OnClick;
	NuNOri_QuestRewardCompleteButton_OnClick = QuestRewardCompleteButton_OnClick;
	QuestRewardCompleteButton_OnClick = NuNNew_QuestRewardCompleteButton_OnClick;

	this:RegisterEvent("IGNORELIST_UPDATE");
	this:RegisterEvent("FRIENDLIST_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("QUEST_LOG_UPDATE");
	this:RegisterEvent("UPDATE_FACTION");
	this:RegisterEvent("UNIT_QUEST_LOG_CHANGED");
	this:RegisterEvent("QUEST_PROGRESS");
	this:RegisterEvent("QUEST_COMPLETE");
	this:RegisterEvent("QUEST_FINISHED");
	this:RegisterEvent("QUEST_ITEM_UPDATE");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");

	SlashCmdList["NOTEUN"] = function(pList)
		local gap = string.find(pList, NUN_SEP);
		if ( gap ) then
			switch = string.sub(pList, 1, (gap - 1));
			parm1 = string.sub(pList, (gap + 1));
		else
			switch = pList;
			parm1 = nil;
		end
		NuN_CmdLine(switch, parm1, pList);
	end
	SLASH_NOTEUN1 = "/nun";

	tryI = true;
	pName = UnitName("player");

	NuN_InitialiseSavedVariables();

	ClearButtonChanges();

	c_continents[1] = {};
	c_continents[2] = {};
	for continentID, continent in ipairs{GetMapContinents()} do
		c_zones = {};
		c_continents[continentID].name = continent;
		for zoneID, zone in ipairs{GetMapZones(continentID)} do
			c_zones[zoneID] = zone;
		end
		c_continents[continentID].zones = c_zones;
	end
end



function NuN_CmdLine(option, parm1, pList)
	local index;
	local value;
	local initial;
	local remainder;
	local contactName;
	local switch;
	local theUnitID = "target";

	if ( ( option == "" ) or ( option == nil ) ) then
		NuN_Options();
	else
		switch = string.lower(option);
		if ( switch == "-h" ) then
			DEFAULT_CHAT_FRAME:AddMessage(NUN_HELP_TEXT);
			index = 0;
			value = getglobal("NUN_HELP_TEXT"..index);
			while( value ) do
				DEFAULT_CHAT_FRAME:AddMessage(value);
				index = index + 1;
				value = getglobal("NUN_HELP_TEXT"..index);
			end
			DEFAULT_CHAT_FRAME:AddMessage(NUN_HELP_TEXT);
		elseif ( switch == NUN_HTT ) then
			NuN_ToggleToolTips();
		elseif  ( ( switch == "-ca" ) or ( switch == "-ch" ) ) then
			initial = string.upper( string.sub(parm1, 1, 1) );
			remainder = string.lower( string.sub(parm1,2) );
			contactName = initial..remainder;
			if ( NuNData[pKey][contactName] ) then
				if ( NuNFrame:IsVisible() ) then
					NuN_HideFrame();
				end
				NuN_ShowSavedNote(contactName);
			else
				NuN_CreateContact(contactName, switch);
			end
		elseif ( switch == "-a" ) then
			NuN_DisplayAll();
		elseif ( switch == "-micro" ) then
			NuN_ToggleMicroButtons();
		elseif ( switch == "-g" ) then
			if ( ( parm1 ~= nil ) and ( parm1 ~= "") ) then
				NuN_GNoteExists(parm1);
				NuNGNoteFrame.fromQuest = nil;
				if ( c_note ) then
					NuN_ShowSavedGNote();
				else
					c_note = parm1;
					c_type = NuNGet_CommandID(noteTypes, "   ");
					NuN_ShowTitledGNote("");
				end
			else
				NuN_ShowNewGNote();
			end
		elseif ( switch == "-t" ) then
			NuN_FromTarget(false);
		elseif ( ( switch == "->de" ) or ( switch == "->en" ) ) then
			NuN_LangPatch(switch);
		else
			initial = string.upper( string.sub(switch, 1, 1) );
			remainder = string.lower( string.sub(switch,2) );
			contactName = initial..remainder;
			if ( NuNData[pKey][contactName] ) then
				if ( NuNFrame:IsVisible() ) then
					NuN_HideFrame();
				end
				NuN_ShowSavedNote(contactName);
			elseif ( NuN_GNoteExists(pList) ) then
				NuNGNoteFrame.fromQuest = nil;
				NuN_ShowSavedGNote();
			else
				c_name = contactName;
				unitTest = true;
				theUnitID = NuN_Target();
				if ( theUnitID ~= nil ) then
					NuN_NewContact(theUnitID);
				else
					NuN_Options();
				end
			end
		end
	end
end


function NuN_FromTarget(autoHide)
	local tstValue = NuN_CheckTarget();
	local theUnitID = "target";
	local npcText;

	if ( IsAltKeyDown() ) then
		NuN_LastOpen.type = "Contact";
		NuN_ReOpen();
		return;
	end

	if ( IsShiftKeyDown() ) then
		autoHide = true;
	end

	if ( tstValue == "N" ) then
		NuNGNoteFrame.fromQuest = nil;
		if ( ( NuNData[pKey][Notes][c_note] ) or ( NuNData[Notes][c_note] ) ) then
			if ( autoHide ~= true ) then
				NuN_ShowSavedGNote();
			end
		else
			npcText = NuN_NPCInfo();
			c_type = NuNGet_CommandID(noteTypes, "NPC");
			NuN_ShowTitledGNote(npcText);
			if ( autoHide == true ) then
				NuNGNote_WriteNote();
				if ( not NuN_ConfirmFrame:IsVisible() ) then
					HideUIPanel(NuNGNoteFrame);
					NuN_Message(c_note..NUN_AUTONOTED);
				end
			end
		end
	else
		if ( NuNData[pKey][c_name] ) then
			if ( autoHide ~= true ) then
				NuN_ShowSavedNote(c_name);
			end
		else
			NuN_NewContact(theUnitID);
			if ( autoHide == true ) then
				NuN_WriteNote();
				HideUIPanel(NuNFrame);
				NuN_Message(c_name..NUN_AUTONOTED);
			end
		end
	end
end


function NuN_CheckTarget()
	local chkName = UnitName("target");

	if ( ( ( UnitPlayerControlled("target") )  and (not UnitIsUnit("player", "target") ) ) or ( UnitInParty("target") ) or ( UnitInRaid("target") ) )then
		c_name = chkName;
		return "F";
	elseif ( ( not UnitPlayerControlled("target") ) and ( chkName ) ) then
		c_note = chkName;
		return "N";
	else
		c_name = pName;
		return "S";
	end
end



function NuN_DisplayAll()
	if ( NuNSearchFrame:IsVisible() ) then
		NuNSearchFrame:Hide();
	else
		NuNSearchFrameBackButton:Disable();
		NuNSearchFrame.backEnabled = nil;
		ddSearch = NuNGet_CommandID(searchFor, "All");
		searchType = searchFor[ddSearch].Command;
		NuNOptions_Search();
	end
end



function NuN_Options()
	if ( NuNOptionsFrame:IsVisible() ) then
		HideUIPanel(NuNOptionsFrame);
	else
		if ( ( MapNotes_OnLoad ) or ( MetaMapNotes_OnLoad ) ) then
			NuN_AutoMapCheckBox:Enable();
			if ( NuNSettings[pKey].autoMapNotes ) then
				NuN_AutoMapCheckBox:SetChecked(1);
			else
				NuN_AutoMapCheckBox:SetChecked(0);
			end
		else
			NuN_AutoMapCheckBox:SetChecked(0);
			NuN_AutoMapCheckBoxLabel:SetText(NUN_NOMAPNOTES);
			NuN_AutoMapCheckBox:Disable();
		end
		if ( NuNFrame:IsVisible() ) then
			NuN_HideFrame();
		end
		if ( NuNSearchFrame:IsVisible() ) then
			HideUIPanel(NuNSearchFrame);
		end
		if ( NuNGNoteFrame:IsVisible() ) then
			HideUIPanel(NuNGNoteFrame);
		end
		UIDropDownMenu_SetSelectedID(NuNOptionsSearchDropDown, 1);
		UIDropDownMenu_SetText(searchFor[1].Display, NuNOptionsSearchDropDown);
		ddSearch = NuNGet_CommandID(searchFor, "All");
		if ( NuNSettings[pKey].autoG ) then
			NuNOptionsGuildCheckButton:SetChecked(1);
		else
			NuNOptionsGuildCheckButton:SetChecked(0);
		end
		if ( NuNSettings[pKey].autoA ) then
			NuNOptionsAddCheckButton:SetChecked(1);
		else
			NuNOptionsAddCheckButton:SetChecked(0);
		end
		if ( NuNSettings[pKey].autoD ) then
			NuNOptionsDeleteCheckButton:SetChecked(1);
		else
			NuNOptionsDeleteCheckButton:SetChecked(0);
		end
		if ( NuNSettings[pKey].autoQ ) then
			NuN_AutoQuestCheckBox:SetChecked(1);
		else
			NuN_AutoQuestCheckBox:SetChecked(0);
		end
		if ( NuNSettings[pKey].autoN ) then
			NuN_AutoNoteCheckBox:SetChecked(1);
		else
			NuN_AutoNoteCheckBox:SetChecked(0);
		end
		if ( NuNSettings[pKey].dLevel ) then
			NuN_DefaultLevelCheckBox:SetChecked(1);
		else
			NuN_DefaultLevelCheckBox:SetChecked(0);
		end
		if ( NuNSettings[pKey].toolTips ) then
			NuN_HelpTTCheckBox:SetChecked(1);
		else
			NuN_HelpTTCheckBox:SetChecked(0);
		end
		if ( NuNSettings[pKey].autoP ) then
			NuN_AutoPartyCheckBox:SetChecked(1);
		else
			NuN_AutoPartyCheckBox:SetChecked(0);
		end
		if ( NuNSettings[pKey].minOver ) then
			NuN_OverTTCheckBox:SetChecked(1);
		else
			NuN_OverTTCheckBox:SetChecked(0);
		end
		if ( NuNSettings[pKey].bHave ) then
			NuN_BehaveCheckBox:SetChecked(1);
		else
			NuN_BehaveCheckBox:SetChecked(0);
		end
		NuNOptionsTTLengthTextBox:SetText( NuNSettings[pKey].ttLen );
		NuNOptionsTTLineLengthTextBox:SetText( NuNSettings[pKey].ttLLen );
		NuNSearchFrameBackButton:Enable();
		NuNSearchFrame.backEnabled = true;
		NuNOptionsFrame:SetScale(NuNSettings[pKey].pScale);
		ShowUIPanel(NuNOptionsFrame);
	end
end



function ClearButtonChanges()
	for i = 1, (uBttns * 2), 1 do
		bttnChanges[i] = "";
	end
end


function NuN_ShowSavedNote(cName)
	c_name = cName;
	c_class = nil;
	c_race = nil;
	c_guild = nil;
	gRank = nil;
	gRankIndex = nil;
	gNote = nil;
	gOfficerNote = nil;
	c_route = "Saved";
	if ( NuNData[pKey][c_name].faction == "Horde" ) then
		NuN_HordeSetup();
	else
		NuN_AllianceSetup();
	end
	NuN_ShowNote();
end



function NuN_ShowWhoNote(cName)
	c_name = cName;
	c_class = nil;
	c_race = nil;
	c_guild = nil;
	gRank = nil;
	gRankIndex = nil;
	gNote = nil;
	gOfficerNote = nil;
	c_route = "Who";
	if ( horde ) then
		NuN_HordeSetup();
	else
		NuN_AllianceSetup();
	end
	NuN_ShowNote();
end



function NuN_ShowNote()
	local hText;
	local theText;

	if ( ( NuNFrame:IsVisible() ) and ( prevName == c_name ) ) then
		NuNFrame:Hide();
	else
		prevName = c_name;

		if ( NuNOptionsFrame:IsVisible() ) then
			HideUIPanel(NuNOptionsFrame);
		end

		lastDD = nil;
		NuNButtonClrDD:Disable();

		ClearButtonChanges();

		NuNHeader:SetText(c_name);

		if ( NuNData[pKey][c_name] ) then
			c_text = NuN_GetCText(c_name);
			if ( ( c_text == nil ) or ( c_text == "" ) ) then
				c_text = "\n";
			end
			NuNText:SetText( c_text );
			NuNButtonDelete:Enable();
			NuNCOpenChatButton:Enable();
			NuNCTTCheckBoxLabel:Show();
			NuN_CTTCheckBox:Show();
			NuN_CTTCheckBox:SetChecked(0);
			if ( NuN_PinnedTooltip.type == "Contact" ) then
				NuN_CTTCheckBox:SetChecked( NuN_CheckPinnedBox(c_name) );
			end
			if ( c_name == pName ) then
				NuNHeader:SetText(NUN_PLAYER.." : "..c_name);
			elseif ( NuNData[pKey][c_name].type == NUN_AUTO_C ) then
				NuNHeader:SetText(NUN_AUTO.." : "..c_name);
			elseif ( NuNData[pKey][c_name].type == NUN_MANU_C ) then
				NuNHeader:SetText(NUN_MANU.." : "..c_name);
			elseif ( NuNData[pKey][c_name].type == NUN_PARTY_C ) then
				NuNHeader:SetText(NUN_PARTY.." : "..c_name );
			elseif ( NuNData[pKey][c_name].type == NUN_SELF_C ) then
				NuNHeader:SetText(NUN_SELF.." : "..c_name);
			else
				NuNHeader:SetText(c_name);
			end
		else
			theText = "";
			NuNHeader:SetText(NUN_NEW.." : "..c_name);
			if ( gNote ~= nil ) then
				theText = "\n"..gNote;
			end
			if ( gOfficerNote ~= nil ) then
				theText = theText.."\n"..gOfficerNote;
			end
			if ( theText == "" ) then
				theText = "\n";
			end
			NuNText:SetText(theText);
			NuNButtonDelete:Disable();
			NuNCOpenChatButton:Disable();
			NuNCTTCheckBoxLabel:Hide();
			NuN_CTTCheckBox:Hide();
		end

		UserButtons_Initialise();
		DropDowns_Initialise();

		ddRace = nil;
		ddClass = nil;
		ddSex = nil;
		ddProf1 = nil;
		ddProf2 = nil;
		ddCRank = nil;
		ddHRank = nil;

		if ( NuNEditDetailsFrame:IsVisible() ) then
			HideUIPanel(NuNEditDetailsFrame);
		end
		if ( NuNcDeleteFrame:IsVisible() ) then
			HideUIPanel(NuNcDeleteFrame);
		end

		if ( ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name][pName] ) and ( NuNData[pKey][c_name][pName].partied ) ) then
			NuNPartiedLabel:Show();
			NuNPartiedNumberLabel:SetText("(x"..tostring(NuNData[pKey][c_name][pName].partied)..")");
			NuNPartiedNumberLabel:Show();
			NuNFramePartyDownButton:Show();
		else
			NuNPartiedLabel:Hide();
			NuNPartiedNumberLabel:SetText("(0)");
			NuNPartiedNumberLabel:Hide();
			NuNFramePartyDownButton:Hide();
		end

		NuNFrame:SetScale(NuNSettings[pKey].pScale);
		ShowUIPanel(NuNFrame);
		if ( not NuNSettings[pKey].bHave ) then
			NuNText:SetFocus();
		else
			NuNText:ClearFocus();
		end
	end
end




function NuN_Update_Ignored()
	local index;
	local value;
	local x;
	local iName;

	if ( pFaction ~= nil ) then
		-- Check every Ignored player to make sure we have a Saved note

		if ( NuNSettings[pKey].autoA ) then
			for i = 1, GetNumIgnores(), 1 do
				iName = GetIgnoreName(i);
				if ( ( iName ~= nil ) and ( not NuNData[pKey][iName] ) ) then
					NuNData[pKey][iName] = {};
					NuNData[pKey][iName].type = NUN_AUTO_C;
					NuNData[pKey][iName].faction = pFaction;
					NuNData[pKey][iName][txtTxt] = NUN_AUTO_IGNORE..NuN_GetDateStamp();
					NuNData[pKey][iName].ignoreLst = {};
					NuNData[pKey][iName].ignoreLst[1] = pName;
				end
			end
		end



		-- Check every Saved entry to see if it is ignored, and upated Saved inofrmation on that basis

		for index, value in NuNData[pKey] do
			if ( ( NuNData[pKey][index].faction) and ( NuNData[pKey][index].faction == pFaction ) and ( index ~= pName ) ) then
				if ( NuN_Is_Ignored(index) ) then
					if ( not NuNData[pKey][index].ignoreLst ) then		-- Ignored but no ignore list currently
						x = 1;
						NuNData[pKey][index].ignoreLst = {};
						NuNData[pKey][index].ignoreLst[x] = pName;
					else								-- Ignored but not on ignore list yet
						if (not NuNGet_TableID(NuNData[pKey][index].ignoreLst, pName) ) then
						x = getn( NuNData[pKey][index].ignoreLst ) + 1;
							NuNData[pKey][index].ignoreLst[x] = pName;
						end
					end
				else
					if ( NuNData[pKey][index].ignoreLst ) then
						x = NuNGet_TableID(NuNData[pKey][index].ignoreLst, pName);
						if ( x ~= nil ) then					-- Not ignored, but on ignore list > come off list
						    local tmpTable = Remove_Entry(NuNData[pKey][index].ignoreLst, x);
						    NuNData[pKey][index].ignoreLst = tmpTable;
						    if ( getn(NuNData[pKey][index].ignoreLst) == 0 ) then
						    	-- If no more ignore list, and auto-deleting, and Auto-note, then delete note entirely
							if ((NuNData[pKey][index].type == NUN_AUTO_C) and (NuNSettings[pKey].autoD) and (not NuNData[pKey][index].friendLst)) then
							    NuNData[pKey][index] = nil;
							else
							    NuNData[pKey][index].ignoreLst = nil;
							end
						    end
						elseif ( getn(NuNData[pKey][index].ignoreLst) > 0 ) then

							-- If (Not Ignored) & (There is an Ignore List we are NOT On) & (Settings say we should try to Ignore)
							--  & (Only 1 attempt per 'log on'  OR  Manual refresh ) then....

							if ( ( tryI == true ) and ( NuN_NotInfiniteIgored(index) ) ) then
								if ( AddIgnore(index) ) then
									x = getn(NuNData[pKey][index].ignoreLst) + 1;
									NuNData[pKey][index].ignoreLst[x] = pName;
								end
							end
						end
					end
				end
			end
		end
	tryI = false;
	end
end



function NuN_Update_Friends()
	local index;
	local value;
	local x;
	local iName;

	if ( pFaction ~= nil ) then
		if ( NuNSettings[pKey].autoA ) then
			for i = 1, GetNumFriends(), 1 do
				iName = GetFriendInfo(i);
				if ( ( iName ~= nil ) and ( not NuNData[pKey][iName] ) ) then
					NuNData[pKey][iName] = {};
					NuNData[pKey][iName].type = NUN_AUTO_C;
					NuNData[pKey][iName].faction = pFaction;
					NuNData[pKey][iName][txtTxt] = NUN_AUTO_FRIEND..NuN_GetDateStamp();
					NuNData[pKey][iName].friendLst = {};
					NuNData[pKey][iName].friendLst[1] = pName;
				end
			end
		end

		-- Check every Saved entry to see if it is friendly, and upated Saved information on that basis

		for index, value in NuNData[pKey] do
			if  ( index == pName ) then
				NuNData[pKey][index].type = NUN_SELF_C;
			elseif ( ( NuNData[pKey][index].faction ) and ( NuNData[pKey][index].faction == pFaction ) ) then
				if ( NuN_Is_Friendly(index) ) then
					if ( not NuNData[pKey][index].friendLst ) then
						x = 1;
						NuNData[pKey][index].friendLst = {};
						NuNData[pKey][index].friendLst[x] = pName;
					else
						if (not NuNGet_TableID(NuNData[pKey][index].friendLst, pName) ) then
							x = getn( NuNData[pKey][index].friendLst ) + 1;
							NuNData[pKey][index].friendLst[x] = pName;
						end
					end
				else
					if ( NuNData[pKey][index].friendLst ) then
						x = NuNGet_TableID(NuNData[pKey][index].friendLst, pName);
						if ( x ~= nil ) then
						    local tmpTable = Remove_Entry(NuNData[pKey][index].friendLst, x);
						    NuNData[pKey][index].friendLst = tmpTable;
						    if ( getn(NuNData[pKey][index].friendLst) == 0 ) then
							if ((NuNData[pKey][index].type == NUN_AUTO_C) and (NuNSettings[pKey].autoD) and (not NuNData[pKey][index].ignoreLst)) then
								NuNData[pKey][index] = nil;
							else
								NuNData[pKey][index].friendLst = nil;
							end
						    end
						end
					end
				end
			end
		end

	end
end



function Remove_Entry(table, entry)
	local sorted = {};
	local innerI = 0;
	for i = 1, getn(table), 1 do
		if ( i ~= entry ) then
			innerI = innerI + 1;
			sorted[innerI] = table[i];
		end
	end
	return sorted;
end

function NuN_Is_Ignored(aName)
	for i = 1, GetNumIgnores(), 1 do
		iName = GetIgnoreName(i);
		if ( aName == GetIgnoreName(i) ) then
			return true;
		end
	end
	return false;
end

function NuN_Is_Friendly(aName)
	local iName;
	for i = 1, GetNumFriends(), 1 do
		iName = GetFriendInfo(i);
		if ( iName == aName ) then
			return true;
		end
	end
	return false;
end



function UserButtons_Initialise()
	for n = 1, uBttns, 1 do
		bttnHeadingText = getglobal("NuNTitleButton"..n.."ButtonTextHeading");
		bttnDetailText = getglobal("NuNInforButton"..n.."ButtonTextDetail");
		bttnDetail = getglobal("NuNInforButton"..n);
		hdNbr = pHead..n;
		nameHdNbr = c_name..hdNbr;
		nameDtNbr = c_name..pDetl..n;
		if ( NuNData[pKey][nameHdNbr] ) then
			bttnHeadingText:SetText(NuNData[pKey][nameHdNbr].txt);
		elseif (NuNSettings[pKey][hdNbr]) then
			bttnHeadingText:SetText(NuNSettings[pKey][hdNbr].txt);
		else
			bttnHeadingText:SetText(dfltHeadings[n]);
		end
		if ( bttnHeadingText:GetText() == nil ) then
			bttnDetailText:SetText("");
			bttnDetail:Disable();
		else
			bttnDetail:Enable();
			if ( NuNData[pKey][nameDtNbr] ) then
				bttnDetailText:SetText(NuNData[pKey][nameDtNbr].txt);
			else
				bttnDetailText:SetText("");
			end
		end

		if ( n == 1 ) and ( c_guild ~= nil ) then
			if ( bttnHeadingText:GetText() == dfltHeadings[n] ) and ( (bttnDetailText:GetText() == "") or (bttnDetailText:GetText() == nil) ) then
				bttnDetailText:SetText(c_guild);
				bttnChanges[n+detlOffset] = c_guild;
			end
		end
		if ( n == 2 ) and ( gRank ~= nil ) then
			if ( bttnHeadingText:GetText() == dfltHeadings[n] ) and ( (bttnDetailText:GetText() == "") or (bttnDetailText:GetText() == nil) ) then
				if ( gRankIndex == 0 ) then
					GuildRank = ("GM : "..gRank);
				else
					GuildRank = (gRankIndex.." : "..gRank);
				end
				bttnDetailText:SetText(GuildRank);
				bttnChanges[n+detlOffset] = GuildRank;
			end
		end
	end
end



function DropDowns_Initialise()
	if ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].race ~= nil ) then
		UIDropDownMenu_SetSelectedID(NuNRaceDropDown, NuNData[pKey][c_name].race);
		UIDropDownMenu_SetText(Races[ (NuNData[pKey][c_name].race) ], NuNRaceDropDown);
	elseif ( c_race ~= nil ) then
		ddRace = NuNGet_TableID(Races, c_race);
		UIDropDownMenu_SetSelectedID(NuNRaceDropDown, ddRace);
		UIDropDownMenu_SetText(c_race, NuNRaceDropDown);
	else
		UIDropDownMenu_ClearAll(NuNRaceDropDown);
	end

	if ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].cls ~= nil ) then
		UIDropDownMenu_SetSelectedID(NuNClassDropDown, NuNData[pKey][c_name].cls);
		UIDropDownMenu_SetText(Classes[ (NuNData[pKey][c_name].cls) ], NuNClassDropDown);
	elseif ( c_class ~= nil ) then
		ddClass = NuNGet_TableID(Classes, c_class);
		UIDropDownMenu_SetSelectedID(NuNClassDropDown, ddClass);
		UIDropDownMenu_SetText(c_class, NuNClassDropDown);
	else
		UIDropDownMenu_ClearAll(NuNClassDropDown);
	end

	if ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].sex ~= nil ) then
		UIDropDownMenu_SetSelectedID(NuNSexDropDown, NuNData[pKey][c_name].sex);
		UIDropDownMenu_SetText(Sexes[ (NuNData[pKey][c_name].sex) ], NuNSexDropDown);
	else
		UIDropDownMenu_ClearAll(NuNSexDropDown);
	end

	if ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].prof1 ~= nil ) then
		UIDropDownMenu_SetSelectedID(NuNProf1DropDown, NuNData[pKey][c_name].prof1);
		UIDropDownMenu_SetText(Professions[ (NuNData[pKey][c_name].prof1) ], NuNProf1DropDown);
	else
		UIDropDownMenu_ClearAll(NuNProf1DropDown);
	end

	if ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].prof2 ~= nil ) then
		UIDropDownMenu_SetSelectedID(NuNProf2DropDown, NuNData[pKey][c_name].prof2);
		UIDropDownMenu_SetText(Professions[ (NuNData[pKey][c_name].prof2) ], NuNProf2DropDown);
	else
		UIDropDownMenu_ClearAll(NuNProf2DropDown);
	end

	if ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].crank ~= nil ) then
		UIDropDownMenu_SetSelectedID(NuNCRankDropDown, NuNData[pKey][c_name].crank);
		UIDropDownMenu_SetText(Ranks[ (NuNData[pKey][c_name].crank) ], NuNCRankDropDown);
	else
		UIDropDownMenu_ClearAll(NuNCRankDropDown);
	end

	if ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].hrank ~= nil ) then
		UIDropDownMenu_SetSelectedID(NuNHRankDropDown, NuNData[pKey][c_name].hrank);
		UIDropDownMenu_SetText(Ranks[ (NuNData[pKey][c_name].hrank) ], NuNHRankDropDown);
	else
		UIDropDownMenu_ClearAll(NuNHRankDropDown);
	end
end



function NuNGet_TableID(tab, txt)
	for i = 1, getn(tab), 1 do
		if ( tab[i] == txt ) then return i; end
	end
	return nil;
end


function NuNGet_CommandID(tab, txt)
	for i = 1, getn(tab), 1 do
		if ( tab[i].Command == txt ) then return i; end
	end
	return nil;
end


function NuN_WriteNote()
	if (not NuNData[pKey][c_name]) then
		NuNData[pKey][c_name] = {};
	end

	if ( c_name == pName ) then
		NuNData[pKey][c_name].type = NUN_SELF_C;
		NuNHeader:SetText(NUN_PLAYER.." : "..c_name);
	elseif ( ( not NuNData[pKey][c_name].type ) or ( NuNData[pKey][c_name].type == NUN_AUTO_C ) ) then
		NuNData[pKey][c_name].type = NUN_MANU_C;
		NuNHeader:SetText(NUN_MANU.." : "..c_name);
	end

	if ( not NuNData[pKey][c_name].faction ) then
		if ( ( c_route == "Target" ) or ( c_route == "Create" ) ) then
			NuNData[pKey][c_name].faction = c_faction;
		else
			NuNData[pKey][c_name].faction = pFaction;
		end
	end

	if ( FriendsListFrame:IsVisible() ) then
		NuNNew_FriendsList_Update();
	elseif ( IgnoreListFrame:IsVisible() ) then
		NuNNew_IgnoreList_Update();
	elseif ( GuildPlayerStatusFrame:IsVisible() ) then
		NuNNew_GuildStatus_Update();
	elseif ( GuildStatusFrame:IsVisible() ) then
		NuNNew_GuildStatus_Update();
	elseif ( WhoFrame:IsVisible() ) then
		NuNNew_WhoList_Update();
	end

	if ( c_guild ~= nil ) then
		NuNData[pKey][c_name].guild = c_guild;
	end
	if ( not NuNData[pKey][c_name].guild ) then
		NuNData[pKey][c_name].guild = "";
	end

	if ( NuN_Is_Ignored(c_name) ) then
		if ( not NuNData[pKey][c_name].ignoreLst ) then
			NuNData[pKey][c_name].ignoreLst = {};
		end
		if (not NuNGet_TableID(NuNData[pKey][c_name].ignoreLst, pName) ) then
			local x = getn(NuNData[pKey][c_name].ignoreLst) + 1;
			NuNData[pKey][c_name].ignoreLst[x] = pName;
		end
	end

	if ( NuN_Is_Friendly(c_name) ) then
		if ( not NuNData[pKey][c_name].friendLst ) then
			NuNData[pKey][c_name].friendLst = {};
		end
		if ( not NuNGet_TableID(NuNData[pKey][c_name].friendLst, pName) ) then
			local x = getn(NuNData[pKey][c_name].friendLst) + 1;
			NuNData[pKey][c_name].friendLst[x] = pName;
		end
	end

	if (ddRace) then
		if ( ddRace == -1 ) then
			NuNData[pKey][c_name].race = nil;
		else
			NuNData[pKey][c_name].race = ddRace;
		end
		ddRace = nil;
	elseif ( c_race ~= nil ) then
		NuNData[pKey][c_name].race = NuNGet_TableID(Races, c_race);
	end
	if (ddClass) then
		if ( ddClass == -1 ) then
			NuNData[pKey][c_name].cls = nil;
		else
			NuNData[pKey][c_name].cls = ddClass;
		end
		ddClass = nil;
	elseif ( c_class ~= nil )  then
		NuNData[pKey][c_name].cls = NuNGet_TableID(Classes, c_class);
	end
	if (ddSex) then
		if ( ddSex == -1 ) then
			NuNData[pKey][c_name].sex = nil;
		else
			NuNData[pKey][c_name].sex = ddSex;
		end
		ddSex = nil;
	end
	if (ddProf1) then
		if ( ddProf1 == -1 ) then
			NuNData[pKey][c_name].prof1 = nil;
		else
			NuNData[pKey][c_name].prof1 = ddProf1;
		end
		ddProf1 = nil;
	end
	if (ddProf2) then
		if ( ddProf2 == -1 ) then
			NuNData[pKey][c_name].prof2 = nil;
		else
			NuNData[pKey][c_name].prof2 = ddProf2;
		end
		ddProf2 = nil;
	end
	if (ddCRank) then
		if ( ddCRank == -1 ) then
			NuNData[pKey][c_name].crank = nil;
		else
			NuNData[pKey][c_name].crank = ddCRank;
		end
		ddCRank = nil;
	end
	if (ddHRank) then
		if ( ddHRank == -1 ) then
			NuNData[pKey][c_name].hrank = nil;
		else
			NuNData[pKey][c_name].hrank = ddHRank;
		end
		ddHRank = nil;
	end

	c_text = NuNText:GetText();
	NuN_SetCText(c_name);

	for n = 1, uBttns, 1 do
		if (bttnChanges[n] ~= "") and (bttnChanges[n] ~= nil) then
			hdNbr = pHead..n;
			nameHdNbr = c_name..hdNbr;
			if (not NuNData[pKey][nameHdNbr]) then
				NuNData[pKey][nameHdNbr] = {};
			end
			if (bttnChanges[n] == 1) then
				NuNData[pKey][nameHdNbr].txt = "";
			else
				NuNData[pKey][nameHdNbr].txt = bttnChanges[n];
			end
		end
	end

	for n = 1, uBttns, 1 do
		b = n + detlOffset;
		if (bttnChanges[b] ~= "") and (bttnChanges[b] ~= nil) then
			nameDtNbr = c_name..pDetl..n;
			if (not NuNData[pKey][nameDtNbr]) then
				NuNData[pKey][nameDtNbr] = {};
			end
			if (bttnChanges[b] == 1) then
				NuNData[pKey][nameDtNbr].txt = nil;
			else
				NuNData[pKey][nameDtNbr].txt = bttnChanges[b];
			end
		end
	end

	if ( ( NuNSearchFrame:IsVisible() ) and ( not string.find(NuNSearchTitleText:GetText(), NUN_QUESTS_TEXT) ) ) then
		NuNSearch_Search();
	end

	ClearButtonChanges();
	NuNButtonDelete:Enable();
	NuNCOpenChatButton:Enable();
	NuNCTTCheckBoxLabel:Show();
	NuN_CTTCheckBox:Show();
end



function NuNGNote_WriteNote()
	local conflict = false;
	local value, index, pad;
	local conflicts = 0;
	local saveLvl;
	local NuN_Creating = nil;

	if ( NuNGNoteTitleButton:IsVisible() ) then
		c_note = NuNGNoteTitleButtonText:GetText();
	else
		c_note = NuNGNoteTextBox:GetText();
	end

	NuNConflictedRealmsLabel:SetText(" ");
	if ( ( NuN_GLevel_CheckBox:GetChecked() ) and ( not NuNGNoteFrame.confirmed ) ) then
		for index, value in NuNData do
			if ( ( index ~= pKey ) and ( NuNData[index][Notes] ) ) then
				if ( NuNData[index][Notes][c_note] ) then
					conflicts = conflicts + 1;
					if ( conflicts == 1 ) then
						pad = "";
					else
						pad = ", ";
					end
					if ( conflicts < 5 ) then
						NuNConflictedRealmsLabel:SetText( NuNConflictedRealmsLabel:GetText()..pad..index );
					end
					conflict = true;
				end
			end
		end
	end

	if ( ( conflict ) and ( not NuNGNoteFrame.confirmed ) ) then
		if ( conflicts > 4 ) then
			NuNConflictedRealmsLabel:SetText( NuNConflictedRealmsLabel:GetText().."..." );
		end
		ShowUIPanel(NuN_ConfirmFrame);
	else
		if ( NuN_ConfirmFrame:IsVisible() ) then
			HideUIPanel(NuN_ConfirmFrame);
		end
		if ( not NuN_GNote_OriTitle ) then
			NuN_Creating = true;
		end
		if ( ( ( NuN_GNote_OriTitle ) and ( NuN_GNote_OriTitle ~= c_note ) ) or ( not NuN_GNote_OriTitle ) ) then
			if ( ( NuNData[pKey][Notes][c_note] ) or ( NuNData[Notes][c_note] ) ) then
				message(NUN_DUPLICATE);
				return;
			else
				if ( NuNData[pKey][Notes][NuN_GNote_OriTitle] ) then
					NuNData[pKey][Notes][NuN_GNote_OriTitle] = nil;
				elseif ( NuNData[Notes][NuN_GNote_OriTitle] ) then
					NuNData[Notes][NuN_GNote_OriTitle] = nil;
				end
			end
		end

		NuN_GNote_OriTitle = c_note;
		g_text = NuNGNoteTextScroll:GetText();
		if ( g_text == nil ) then
			g_text = "";
		end

		if ( NuN_GLevel_CheckBox:GetChecked() ) then
			saveLvl = "Account";
			NuNData[Notes][c_note] = {};
			for index, value in NuNData do
				if ( NuNData[index][Notes] ) then
					if ( NuNData[index][Notes][c_note] ) then
						NuNData[index][Notes][c_note] = nil;
					end
				end
			end
		else
			saveLvl = "Realm";
			NuNData[pKey][Notes][c_note] = {};
			if ( NuNData[Notes][c_note] ) then
				NuNData[Notes][c_note] = nil;
			end
		end
		NuN_SetGText(saveLvl);

		if ( string.find(c_note, "|Hitem:") ) then
			simpleName = NuN_GetSimpleName(c_note);
			if ( simpleName ~= nil ) then
				NuNData[itmIndex][simpleName] = c_note;
			end
		end
		if ( NuNGNoteFrame.type ) then
			if ( NuN_GLevel_CheckBox:GetChecked() ) then
				NuNData[Notes][c_note].type = NuNGNoteFrame.type;
			else
				NuNData[pKey][Notes][c_note].type = NuNGNoteFrame.type;
			end
			if ( noteTypes[NuNGNoteFrame.type].Command == "QST"  ) then
				if ( not NuNData[pKey].QuestHistory[pName][c_note] ) then
					NuNData[pKey].QuestHistory[pName][c_note] = {};
					NuNData[pKey].QuestHistory[pName][c_note].sortDate = tostring(date("%Y%m%d%H%M%S"));
					NuNData[pKey].QuestHistory[pName][c_note].pLevel = UnitLevel("player");
					NuNData[pKey].QuestHistory[pName][c_note].txt = NUN_CREATED.."\n    "..NuN_GetDateStamp().."\n    "..NuN_GetLoc().."\n";
					NuN_UpdateQuestNotes("Write");
				end
			elseif ( ( noteTypes[NuNGNoteFrame.type].Command == "NPC" ) and ( NuN_Creating ) and ( NuNSettings[pKey].autoMapNotes ) ) then
				NuN_MapNote("Target", "", "", nil);
			end
		end

		if ( QuestLogFrame:IsVisible() ) then
			NuNNew_QuestLog_Update();
		end

		if ( ( NuNSearchFrame:IsVisible() ) and ( NuNGNoteFrame.fromQuest ) ) then
			NuN_FetchQuestHistory();
		elseif ( ( NuNSearchFrame:IsVisible() ) and ( not string.find(NuNSearchTitleText:GetText(), NUN_QUESTS_TEXT) ) ) then
			NuNSearch_Search();
		end

		NuNGNoteButtonDelete:Enable();
		if ( ( MapNotes_OnLoad ) or ( MetaMapNotes_OnLoad ) ) then
			NuNMapNoteButton:Enable();
		end
		NuNGOpenChatButton:Enable();
		NuN_GTTCheckBox:Show();
		NuN_GTTCheckBox:SetChecked(0);
		if ( NuN_PinnedTooltip.type == "General" ) then
			NuN_GTTCheckBox:SetChecked( NuN_CheckPinnedBox(c_note) );
		end
		NuNGTTCheckBoxLabel:Show();
		NuNGNoteTitleButtonText:SetText(c_note);
		NuNGNoteTextBox:Hide();
		NuNGNoteTitleButton:Show();
		NuNGNoteHeader:SetText(NUN_SAVED_NOTE);
	end
end



function NuN_HideFrame()
	HideUIPanel(NuNEditDetailsFrame);
	HideUIPanel(NuNFrame);
end

function NuNGNote_HideFrame()
	HideUIPanel(NuNGNoteFrame);
end



function NuN_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		--NuN_Message("NotesUNeed "..NUN_VERSION.." "..NUN_LOADED);

	elseif ( ( event == "IGNORELIST_UPDATE" ) and ( not NuN_importing ) )then
		NuN_Update_Ignored();

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		pFaction = UnitFactionGroup("player");
		if ( pFaction == "Horde" ) then
			horde = true;
		else
			horde = false;
		end

		tryI = true;
		pName = UnitName("player");

		NuN_InitialiseSavedVariables();

		if ( not NuNData[pKey][pName] ) then
			NuN_AutoNote();
		end
		NuN_Update_Friends();
		NuN_Update_Ignored();
		if ( not NuNSettings[pKey].hideMicro ) then
			ShowUIPanel(NuNMicroFrame);
		else
			HideUIPanel(NuNMicroFrame);
		end
		NuN_PinnedTooltip:SetScale(NuNSettings[pKey].tScale);
		NuN_Tooltip:SetScale(NuNSettings[pKey].tScale);
		WorldMapTooltip:SetScale(NuNSettings[pKey].mScale);
		NuN_MapTooltip:SetScale(NuNSettings[pKey].mScale);
		NuNPopup:SetScale(NuNSettings[pKey].mScale);
		if ( ( MapNotes_OnLoad ) or ( MetaMapNotes_OnLoad ) ) then
			NuN_MapIndexHouseKeeping();
		end
		NuN_AtStartup = "True";

		if ( NuN_FirstTime ) then
			NuN_FirstTime = nil;
			if ( MetaMapNotes_OnLoad ) then
				NuNOri_MetaMapNotes_OnEnter = MetaMapNotes_OnEnter;
				MetaMapNotes_OnEnter = NuNNew_MetaMapNotes_OnEnter;
				NuNOri_MetaMapNotes_OnLeave = MetaMapNotes_OnLeave;
				MetaMapNotes_OnLeave = NuNNew_MetaMapNotes_OnLeave;
				NuNOri_MetaMapNotes_DeleteNote = MetaMapNotes_DeleteNote;
				MetaMapNotes_DeleteNote = NuNNew_MetaMapNotes_DeleteNote;
				NuN_GetZoneTableSize = MetaMapNotes_GetZoneTableSize;
			elseif ( MapNotes_OnLoad ) then
				NuNOri_MapNotes_OnEnter = MapNotes_OnEnter;
				MapNotes_OnEnter = NuNNew_MapNotes_OnEnter;
				NuNOri_MapNotes_OnLeave = MapNotes_OnLeave;
				MapNotes_OnLeave = NuNNew_MapNotes_OnLeave;
				NuNOri_MapNotes_DeleteNote = MapNotes_DeleteNote;
				MapNotes_DeleteNote = NuNNew_MapNotes_DeleteNote;
				NuN_GetZoneTableSize = MapNotes_GetZoneTableSize;
			end
		end

	elseif ( ( event == "FRIENDLIST_UPDATE" ) and ( not NuN_importing ) ) then
		NuN_Update_Friends();

	elseif( event == "PLAYER_LEVEL_UP" ) then
		if ( NuNData[pKey][pName] ) then
			local lvl = UnitLevel("player");
			local cxp = UnitXP("player");
			local nxp = UnitXPMax("player");
			if ( cxp ) and ( nxp ) then
				local diff = nxp - cxp;
				if ( cxp > diff ) then
					lvl = lvl + 1;
				end
			end
			c_text = NuN_GetCText(pName);
			local len = string.len(c_text);
			if ( len < NUN_MAX_TXT_BUF ) then
				c_text = c_text..NUN_LVL_REACHED..lvl.." : ";
				c_text = c_text.."\n    "..NuN_GetDateStamp();
				c_text = c_text.."\n    "..NuN_GetLoc();
				NuN_SetCText(pName);
			end
		end

--	elseif ( event == "CHAT_MSG_SYSTEM" ) then
--		if ( arg1 ) then
--			local p = string.find(arg1, NUN_COMPLETED);
--			if ( p ) then
--				local q = string.sub(arg1, 1, (p-1));
--				NuN_QuestHandIn(q);
--				timeSinceLastUpdate = 0;
--				NuN_IgnoreNextQUpdate = true;
--			end
--		end

	elseif ( ( event == "PARTY_MEMBERS_CHANGED" ) or ( event == "RAID_ROSTER_UPDATE" ) ) then
		if ( NuNSettings[pKey].autoP ) then
			NuN_ProcessParty();
		end

	elseif ( ( NuN_QuestsUpdating == "False" ) and ( NuN_AtStartup == "False" ) and ( event == "QUEST_LOG_UPDATE" ) ) then
		if ( ( NuNGNoteFrame:IsVisible() ) and ( noteTypes[NuNGNoteFrame.type].Command == "QST" ) ) then
			HideUIPanel(NuNGNoteFrame);
		end
		if ( NuN_QuestAccepted ) then
			local qHeader = nil;
			local qCollapsed = nil;
			local qIndex, qLevel, qTag, qComplete = NuN_CheckQuestList(NuN_QuestAccepted);
			if ( qIndex > 0 ) then
				NuN_ProcessQuest(NuN_QuestAccepted, qLevel, qTag, qHeader, qCollapsed, qComplete, qIndex);
			end
			NuN_QuestAccepted = nil;
			return;
		end
		if ( NuN_IgnoreNextQUpdate ) then
			NuN_IgnoreNextQUpdate = nil;
		else
			NuN_UpdateQuestNotes(event);
		end
	end
end



function NuNHRaceDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNHRaceDropDown, NuNHRaceDropDown_Initialise);
	UIDropDownMenu_SetWidth(75);
end

function NuNHRaceDropDown_Initialise()
	local info;
	for i=1, getn(HRaces), 1 do
		info = {};
		info.text = HRaces[i];
		info.func = NuNHRaceButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNHRaceButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNHRaceDropDown, this:GetID());
	ddRace = this:GetID();
	lastDD = "Race";
	NuNButtonClrDD:Enable();
end

function NuNARaceDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNARaceDropDown, NuNARaceDropDown_Initialise);
	UIDropDownMenu_SetWidth(75);
end

function NuNARaceDropDown_Initialise()
	local info;
	for i=1, getn(ARaces), 1 do
		info = {};
		info.text = ARaces[i];
		info.func = NuNARaceButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNARaceButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNARaceDropDown, this:GetID());
	ddRace = this:GetID();
	lastDD = "Race";
	NuNButtonClrDD:Enable();
end



function NuNHClassDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNHClassDropDown, NuNHClassDropDown_Initialise);
	UIDropDownMenu_SetWidth(75);
end

function NuNHClassDropDown_Initialise()
	local info;
	for i=1, getn(HClasses), 1 do
		info = {};
		info.text = HClasses[i];
		info.func = NuNHClassButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNHClassButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNHClassDropDown, this:GetID());
	ddClass = this:GetID();
	lastDD = "Class";
	NuNButtonClrDD:Enable();
end

function NuNAClassDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNAClassDropDown, NuNAClassDropDown_Initialise);
	UIDropDownMenu_SetWidth(75);
end

function NuNAClassDropDown_Initialise()
	local info;
	for i=1, getn(AClasses), 1 do
		info = {};
		info.text = AClasses[i];
		info.func = NuNAClassButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNAClassButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNAClassDropDown, this:GetID());
	ddClass = this:GetID();
	lastDD = "Class";
	NuNButtonClrDD:Enable();
end



function NuNSexDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNSexDropDown, NuNSexDropDown_Initialise);
	UIDropDownMenu_SetWidth(75);
end

function NuNSexDropDown_Initialise()
	local info;
	for i=1, getn(Sexes), 1 do
		info = {};
		info.text = Sexes[i];
		info.func = NuNSexButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNSexButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNSexDropDown, this:GetID());
	ddSex = this:GetID();
	lastDD = "Sex";
	NuNButtonClrDD:Enable();
end



function NuNProf1DropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNProf1DropDown, NuNProf1DropDown_Initialise);
	UIDropDownMenu_SetWidth(210);
end

function NuNProf1DropDown_Initialise()
	local info;
	for i=1, getn(Professions), 1 do
		info = {};
		info.text = Professions[i];
		info.func = NuNProf1Button_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNProf1Button_OnClick()
	UIDropDownMenu_SetSelectedID(NuNProf1DropDown, this:GetID());
	ddProf1 = this:GetID();
	lastDD = "Prof1";
	NuNButtonClrDD:Enable();
end



function NuNProf2DropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNProf2DropDown, NuNProf2DropDown_Initialise);
	UIDropDownMenu_SetWidth(210);
end

function NuNProf2DropDown_Initialise()
	local info;
	for i=1, getn(Professions), 1 do
		info = {};
		info.text = Professions[i];
		info.func = NuNProf2Button_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNProf2Button_OnClick()
	UIDropDownMenu_SetSelectedID(NuNProf2DropDown, this:GetID());
	ddProf2 = this:GetID();
	lastDD = "Prof2";
	NuNButtonClrDD:Enable();
end



function NuNHCRankDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNHCRankDropDown, NuNHCRankDropDown_Initialise);
	UIDropDownMenu_SetWidth(125);
end

function NuNHCRankDropDown_Initialise()
	local info;
	for i=1, getn(HRanks), 1 do
		info = {};
		info.text = HRanks[i];
		info.func = NuNHCRankButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNHCRankButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNHCRankDropDown, this:GetID());
	ddCRank = this:GetID();
	lastDD = "CRank";
	NuNButtonClrDD:Enable();
end

function NuNACRankDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNACRankDropDown, NuNACRankDropDown_Initialise);
	UIDropDownMenu_SetWidth(125);
end

function NuNACRankDropDown_Initialise()
	local info;
	for i=1, getn(ARanks), 1 do
		info = {};
		info.text = ARanks[i];
		info.func = NuNACRankButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNACRankButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNACRankDropDown, this:GetID());
	ddCRank = this:GetID();
	lastDD = "CRank";
	NuNButtonClrDD:Enable();
end



function NuNHHRankDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNHHRankDropDown, NuNHHRankDropDown_Initialise);
	UIDropDownMenu_SetWidth(125);
end

function NuNHHRankDropDown_Initialise()
	local info;
	for i=1, getn(HRanks), 1 do
		info = {};
		info.text = HRanks[i];
		info.func = NuNHHRankButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNHHRankButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNHHRankDropDown, this:GetID());
	ddHRank = this:GetID();
	lastDD = "HRank";
	NuNButtonClrDD:Enable();
end

function NuNAHRankDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNAHRankDropDown, NuNAHRankDropDown_Initialise);
	UIDropDownMenu_SetWidth(125);
end

function NuNAHRankDropDown_Initialise()
	local info;
	for i=1, getn(ARanks), 1 do
		info = {};
		info.text = ARanks[i];
		info.func = NuNAHRankButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNAHRankButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNAHRankDropDown, this:GetID());
	ddHRank = this:GetID();
	lastDD = "HRank";
	NuNButtonClrDD:Enable();
end


function NuNOptionsSearchDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNOptionsSearchDropDown, NuNOptionsSearchDropDown_Initialise);
	UIDropDownMenu_SetWidth(165);
end

function NuNOptionsSearchDropDown_Initialise()
	local info;
	for i=1, getn(searchFor), 1 do
		info = {};
		info.text = searchFor[i].Display;
		info.func = NuNOptionsSearchDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNOptionsSearchDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(NuNOptionsSearchDropDown, this:GetID());
	ddSearch = this:GetID();
end



function NuNSearchClassDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNSearchClassDropDown, NuNSearchClassDropDown_Initialise);
	UIDropDownMenu_SetWidth(204);
end

function NuNSearchClassDropDown_Initialise()
	local info;
	for i=1, getn(AllClasses), 1 do
		info = {};
		info.text = AllClasses[i];
		info.func = NuNSearchClassButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNSearchClassButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNSearchClassDropDown, this:GetID());
	ddClassSearch = this:GetID();
end



function NuNSearchProfDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNSearchProfDropDown, NuNSearchProfDropDown_Initialise);
	UIDropDownMenu_SetWidth(204);
end

function NuNSearchProfDropDown_Initialise()
	local info;
	for i=1, getn(Professions), 1 do
		info = {};
		info.text = Professions[i];
		info.func = NuNSearchProfButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNSearchProfButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNSearchProfDropDown, this:GetID());
	ddProfSearch = this:GetID();
end

function NuNChatDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNChatDropDown, NuNChatDropDown_Initialise);
	UIDropDownMenu_SetWidth(110);
end

function NuNChatDropDown_Initialise()
	local info;
	for i=1, getn(transmitTo), 1 do
		info = {};
		info.text = transmitTo[i].Display;
		info.func = NuNChatButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNChatButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNChatDropDown, this:GetID());
	sendTo = transmitTo[this:GetID()].Command;
	if ( sendTo == "WHISPER" ) or ( sendTo == "NuN" ) then
		NuNChatTextBox:SetText("");
		NuNChatTextBox:Show();
		NuNTransmit:Disable();
	else
		if ( NuNChatTextBox:IsVisible() ) then
			NuNChatTextBox:Hide();
		end
		NuNTransmit:Enable();
	end
end

function NuNGTypeDropDown_OnLoad()
	UIDropDownMenu_Initialize(NuNGTypeDropDown, NuNGTypeDropDown_Initialise);
	UIDropDownMenu_SetWidth(70);
end

function NuNGTypeDropDown_Initialise()
	local info;
	for i=1, getn(noteTypes), 1 do
		info = {};
		info.text = noteTypes[i].Display;
		info.func = NuNGTypeButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function NuNGTypeButton_OnClick()
	UIDropDownMenu_SetSelectedID(NuNGTypeDropDown, this:GetID());
	NuNGNoteFrame.type = this:GetID();
	if ( noteTypes[NuNGNoteFrame.type].Command == "NPC" ) then
		NuNNPCTargetButton:Show();
	else
		NuNNPCTargetButton:Hide();
	end
end



function NuNEditDetails()
	local prntObj;
	local prntTxtObj;

	newTxt = (NuNEditDetailsBox:GetText());

	if (newTxt ~= oriTxt) then
		chldObj = getglobal("NuNInforButton"..bttnNumb);
		if ((newTxt == "") and (isTitle)) or ((newTxt == nil) and (isTitle)) then
			chldTxtObj = getglobal("NuNInforButton"..bttnNumb.."ButtonTextDetail");
			chldTxt = chldTxtObj:SetText("");
			chldObj:Disable();
		else
			chldObj:Enable();
		end
		bttnTxtObj:SetText(newTxt);

		if (isTitle) then
			if ( NuNEditDetail_CheckButton:GetChecked() ) then
				hdNbr = pHead..bttnNumb;
				nameHdNbr = c_name..hdNbr;
				if (not NuNSettings[pKey][hdNbr]) then
					NuNSettings[pKey][hdNbr] = {};
				end
				NuNSettings[pKey][hdNbr].txt = newTxt;
				if ( NuNData[pKey][nameHdNbr] ) then
					NuNData[pKey][nameHdNbr] = nil;
				end
			else
				index = tonumber(bttnNumb);
				if ( ( newTxt == "" ) or ( newTxt == nil ) )then
					bttnChanges[index] = 1;
				else
					bttnChanges[index] = newTxt;
				end
			end
		else
			index = bttnNumb + detlOffset;
			if ( newTxt == "" ) then
				bttnChanges[index] = 1;
			else
				bttnChanges[index] = newTxt;
			end
			if ( index == (detlOffset + 1) ) then
				prntTxtObj = getglobal("NuNTitleButton"..bttnNumb.."ButtonTextHeading");
				if ( prntTxtObj:GetText() == dfltHeadings[1] ) then
					c_guild = newTxt;
				end
			end
		end
		NuNEditDetails_HideFrame();
	else
		NuNEditDetails_HideFrame();
	end
end



function NuNEditDetails_HideFrame()
	NuNButtonSaveNote:Enable();
	HideUIPanel(NuNEditDetailsFrame);
end



function NuNUserButton_OnClick(bttn)
	local bttnName = bttn:GetName();
	local prfx = (string.sub(bttnName,  1, 8));

	bttnNumb = (string.sub(bttnName, 15,  15));

	if (prfx == "NuNTitle") then
		isTitle = true;
		bttnTxtObj = getglobal(bttnName.."ButtonTextHeading");
	else
		isTitle = false;
		bttnTxtObj = getglobal(bttnName.."ButtonTextDetail");
	end
	oriTxt = bttnTxtObj:GetText();

	NuNEditDetails_ShowFrame(isTitle);
end



function NuNEditDetails_ShowFrame(isTitle)
	NuNButtonSaveNote:Disable();

	NuNText:ClearFocus();
	if (oriTxt == nil) then
		NuNEditDetailsBox:SetText("");
	else
		NuNEditDetailsBox:SetText(oriTxt);
	end
	if (isTitle) then
		NuNCheckBoxLabel:SetText("Save as Default");
		NuNEditDetail_CheckButton:SetChecked(0);
		NuNEditDetailsRestoreButton:Enable();
		NuNEditDetail_CheckButton:Show();
		NuNEditDetailsRestoreButton:Show();
	else
		NuNCheckBoxLabel:SetText("");
		NuNEditDetail_CheckButton:Hide();
		NuNEditDetailsRestoreButton:Hide();
	end
	ShowUIPanel(NuNEditDetailsFrame);
	NuNEditDetailsBox:SetFocus();
end



function NuN_EditDetailCheckButtonOnClick()
	if ( NuNEditDetail_CheckButton:GetChecked() ) then
		NuNEditDetailsRestoreButton:Disable();
	else
		NuNEditDetailsRestoreButton:Enable();
	end
end



function NuNEditDetailsRestore()
	nameHdNbr = c_name..pHead..bttnNumb;
	if ( NuNData[pKey][nameHdNbr] ) then
		NuNData[pKey][nameHdNbr] = nil;
	end
	NuNEditDetails_HideFrame();
	NuN_HideFrame();
	NuN_ShowNote();
end





-------------------------------------------------------------------------------------------
-- Succesful Function Hooks



function NuNNew_FriendsFrameFriendButton_OnClick(button)
	NuNOri_FriendsFrameFriendButton_OnClick(button);
 	if ( ( button == "LeftButton" ) and ( NuNFrame:IsVisible() ) ) then
 		NuN_HideFrame();
 		NuN_ShowFriendNote();
 	end
end

function NuNNew_FriendsFrameIgnoreButton_OnClick()
	NuNOri_FriendsFrameIgnoreButton_OnClick();
	if ( ( button == "LeftButton" ) and ( NuNFrame:IsVisible() ) ) then
		NuN_HideFrame();
		NuN_ShowIgnoreNote();
	end
end

function NuNNew_FriendsFrameGuildPlayerStatusButton_OnClick(button)
	NuNOri_FriendsFrameGuildPlayerStatusButton_OnClick(button);
	if ( ( button == "LeftButton" ) and ( NuNFrame:IsVisible() ) ) then
		NuN_HideFrame();
		NuN_ShowGuildNote();
	end
end

function NuNNew_FriendsFrameGuildStatusButton_OnClick(button)
	NuNOri_FriendsFrameGuildStatusButton_OnClick(button);
	if ( ( button == "LeftButton" ) and ( NuNFrame:IsVisible() ) ) then
		NuN_HideFrame();
		NuN_ShowGuildNote();
	end
end

function NuNNew_FriendsFrameWhoButton_OnClick(button)
	NuNOri_FriendsFrameWhoButton_OnClick(button);
	if ( ( button == "LeftButton" ) and ( NuNFrame:IsVisible() ) ) then
		NuN_HideFrame();
		NuN_ShowWhoNote(WhoFrame.selectedName);
	end
end

function NuNNew_FriendsList_Update()
	local bttnIndx;

	NuNOri_FriendsList_Update();

	for i = 1, 10, 1 do
		bttnIndx = getglobal("NuN_FriendNotesButton"..i);
		NuN_UpdateNoteButton(bttnIndx, i, "F");
	end
end

function NuNNew_IgnoreList_Update()
	local bttnIndx;

	NuNOri_IgnoreList_Update();

	for i = 1, 20, 1 do
		bttnIndx = getglobal("NuN_IgnoreNotesButton"..i);
		NuN_UpdateNoteButton(bttnIndx, i, "I");
	end
end

function NuNNew_GuildStatus_Update()
	local bttnIndx;

	NuNOri_GuildStatus_Update();

	for i = 1, 13, 1 do
		bttnIndx = getglobal("NuN_GuildSNotesButton"..i);
		NuN_UpdateNoteButton(bttnIndx, i, "GS");
		bttnIndx = getglobal("NuN_GuildNotesButton"..i);
		NuN_UpdateNoteButton(bttnIndx, i, "G");
	end
end

function NuNNew_WhoList_Update()
	local bttnIndx;

	NuNOri_WhoList_Update();

	for i = 1, 17, 1 do
		bttnIndx = getglobal("NuN_WhoNotesButton"..i);
		NuN_UpdateNoteButton(bttnIndx, i, "W");
	end
end

function NuNNew_QuestLog_Update()
	local bttnIndx;

	NuNOri_QuestLog_Update();

	for i = 1, 6, 1 do
		bttnIndx = getglobal("NuN_QuestNotesButton"..i);
		NuN_UpdateNoteButton(bttnIndx, i, NUN_QUEST_C);
	end
end

function NuNNew_ContainerFrameItemButton_OnClick(button, ignoreShift)
	if ( ( IsAltKeyDown() ) and ( IsShiftKeyDown() ) ) then
		local itmLink = GetContainerItemLink( this:GetParent():GetID(), this:GetID() );
		if ( ( itmLink ~= nil ) and ( itmLink ~= "" ) ) then
			if ( button == "LeftButton" ) then
				if ( ( NuNGNoteFrame:IsVisible() ) or ( NuNFrame:IsVisible() ) ) then
					if ( NuNGNoteFrame:IsVisible() ) then
						local cText = NuNGNoteTextScroll:GetText().."\n"..itmLink;
						NuNGNoteTextScroll:SetText(cText);
						return;
					elseif ( NuNFrame:IsVisible() ) then
						local cText = NuNText:GetText().."\n"..itmLink;
						NuNText:SetText(cText);
						return;
					end
				else
					NuNGNoteFrame.fromQuest = nil;
					if ( ( NuNData[pKey][Notes][itmLink] ) or ( NuNData[Notes][itmLink] ) ) then
						c_note = itmLink;
						NuN_ShowSavedGNote();
					else
						NuN_GNoteFromItem(itmLink, "GameTooltip");
					end
					return;
				end
			end
		end
	end

	NuNOri_ContainerFrameItemButton_OnClick(button, ignoreShift);
end

function NuNNew_SetItemRef(link, text, button)
	if ( strsub(link, 1, 6) == "player" ) then
		local name = string.sub(link, 8);
		if ( name and (string.len(name) > 0) ) then
			name = string.gsub(name, "([^%s]*)%s+([^%s]*)%s+([^%s]*)", "%3");
			name = string.gsub(name, "([^%s]*)%s+([^%s]*)", "%2");
			if ( IsShiftKeyDown() ) then
				local NuN_staticPopup = StaticPopup_Visible("ADD_IGNORE");
				if ( not NuN_staticPopup ) then
					if ( IsAltKeyDown() ) then
						if ( NuNData[pKey][name] ) then
							NuN_ShowSavedNote(name);
						else
							NuN_CreateContact(name, pFaction);
						end
					else
						ttName = name;
						NuN_ClearPinnedTT();
						NuN_PinnedTooltip:SetOwner(this, "ANCHOR_RIGHT");
						NuN_PinUpHeader = true;
						NuN_PinnedTooltip.type = "Contact";
						NuN_BuildTT(NuN_PinnedTooltip);
						NuN_PinUpHeader = false;
						NuN_PinnedTooltip:Show();
					end
				end
			end
		end
	elseif ( IsShiftKeyDown() ) and ( IsAltKeyDown() ) then
		if ( button == "LeftButton" ) then
			if ( ( NuNGNoteFrame:IsVisible() ) or ( NuNFrame:IsVisible() ) ) then
				if ( NuNGNoteFrame:IsVisible() ) then
					local cText = NuNGNoteTextScroll:GetText().."\n"..text;
					NuNGNoteTextScroll:SetText(cText);
					return;
				elseif ( NuNFrame:IsVisible() ) then
					local cText = NuNText:GetText().."\n"..text;
					NuNText:SetText(cText);
					return;
				end
			else
				NuNGNoteFrame.fromQuest = nil;
				if ( ( NuNData[pKey][Notes][text] ) or ( NuNData[Notes][text] ) ) then
					c_note = text;
					NuN_ShowSavedGNote();
				else
					ItemRefTooltip:SetHyperlink(link);
					NuN_GNoteFromItem(text, "ItemRefTooltip");
				end
				return;
			end
		end
	end

	NuNOri_SetItemRef(link, text, button);

	if ( ItemRefTooltip:IsVisible() ) then
		NuN_ItemRefTooltip_OnShow();
	end
end

function NuNNew_PaperDollItemSlotButton_OnClick(button)
	local itmLink;
	if ( ( IsShiftKeyDown() ) and ( IsAltKeyDown() ) ) then
		if ( ( InspectFrame ) and ( InspectFrame:IsVisible() ) ) then
			itmLink = GetInventoryItemLink("target", this:GetID());
		else
			itmLink = GetInventoryItemLink("player", this:GetID());
		end
		if ( ( itmLink ~= nil ) and ( itmLink ~= "" ) ) then
			if ( button == "LeftButton" ) then
				if ( ( NuNGNoteFrame:IsVisible() ) or ( NuNFrame:IsVisible() ) ) then
					if ( NuNGNoteFrame:IsVisible() ) then
						local cText = NuNGNoteTextScroll:GetText().."\n"..itmLink;
						NuNGNoteTextScroll:SetText(cText);
						return;
					elseif ( NuNFrame:IsVisible() ) then
						local cText = NuNText:GetText().."\n"..itmLink;
						NuNText:SetText(cText);
						return;
					end
				else
					NuNGNoteFrame.fromQuest = nil;
					if ( ( NuNData[pKey][Notes][itmLink] ) or ( NuNData[Notes][itmLink] ) ) then
						c_note = itmLink;
						NuN_ShowSavedGNote();
					else
						NuN_GNoteFromItem(itmLink, "GameTooltip");
					end
					return;
				end
			end
		end
	end

	NuNOri_PaperDollItemSlotButton_OnClick(button);
end

function NuNNew_QuestLogRewardItem_OnClick()
	if ( ( IsShiftKeyDown() ) and ( IsAltKeyDown() ) and ( this.rewardType ~= "spell" ) ) then
		local itmLink = GetQuestLogItemLink(this.type, this:GetID());
		if ( ( itmLink ~= nil ) and ( itmLink ~= "" ) ) then
			local sLink = NuN_GetSimpleName(itmLink);
			if ( ( NuNGNoteFrame:IsVisible() ) and ( sLink == prevLink ) ) then
				HideUIPanel(NuNGNoteFrame);
			else
				prevLink = sLink;
				NuNGNoteFrame.fromQuest = nil;
				if ( ( NuNData[pKey][Notes][itmLink] ) or ( NuNData[Notes][itmLink] ) ) then
					c_note = itmLink;
					NuN_ShowSavedGNote();
				else
					NuN_GNoteFromItem(itmLink, "GameTooltip");
					local q = GetQuestLogSelection();
					if ( q ) then
						q = GetQuestLogTitle(q);
						if ( q ) then
							if ( NuNGNoteFrame:IsVisible() ) then
								NuNGNoteTextScroll:SetText( NuNGNoteTextScroll:GetText().."\n"..NUN_QUEST..q );
							end
						end
					end
				end
			end
			return;
		end
	end

	NuNOri_QuestLogRewardItem_OnClick();
end

function NuNNew_QuestItem_OnClick()
	if ( ( IsShiftKeyDown() ) and ( IsAltKeyDown() ) and ( this.rewardType ~= "spell" ) ) then
		local itmLink = GetQuestItemLink(this.type, this:GetID());
		if ( ( itmLink ~= nil ) and ( itmLink ~= "" ) ) then
			local sLink = NuN_GetSimpleName(itmLink);
			if ( ( NuNGNoteFrame:IsVisible() ) and ( sLink == prevLink ) ) then
				HideUIPanel(NuNGNoteFrame);
			else
				prevLink = sLink;
				NuNGNoteFrame.fromQuest = nil;
				if ( ( NuNData[pKey][Notes][itmLink] ) or ( NuNData[Notes][itmLink] ) ) then
					c_note = itmLink;
					NuN_ShowSavedGNote();
				else
					NuN_GNoteFromItem(itmLink, "GameTooltip");
					local giver = QuestFrameNpcNameText:GetText();
					local quest = QuestTitleText:GetText();
					if ( giver ) then
						giver = "\n"..giver.."\n"..NuN_GetLoc();
					end
					if ( quest ) then
						giver = giver.."\n"..NUN_QUEST..quest;
					end
					if ( giver ) then
						NuNGNoteTextScroll:SetText( NuNGNoteTextScroll:GetText()..giver );
					end
				end
			end
			return;
		end
	end

	NuNOri_QuestItem_OnClick();
end

function NuNNew_QuestRewardItem_OnClick()
	if ( ( IsShiftKeyDown() ) and ( IsAltKeyDown() ) and ( this.rewardType ~= "spell" ) ) then
		local itmLink = GetQuestItemLink(this.type, this:GetID());
		if ( ( itmLink ~= nil ) and ( itmLink ~= "" ) ) then
			local sLink = NuN_GetSimpleName(itmLink);
			if ( ( NuNGNoteFrame:IsVisible() ) and ( sLink == prevLink ) ) then
				HideUIPanel(NuNGNoteFrame);
			else
				prevLink = sLink;
				NuNGNoteFrame.fromQuest = nil;
				if ( ( NuNData[pKey][Notes][itmLink] ) or ( NuNData[Notes][itmLink] ) ) then
					c_note = itmLink;
					NuN_ShowSavedGNote();
				else
					NuN_GNoteFromItem(itmLink, "GameTooltip");
				end
			end
			return;
		end
	end

	NuNOri_QuestRewardItem_OnClick();
end

function NuNNew_AbandonQuest()
	local qN = GetAbandonQuestName();
	timeSinceLastUpdate = 0;
	NuN_IgnoreNextQUpdate = true;
	NuN_AbandonQuest(qN);
	NuNOri_AbandonQuest();
end

function NuNNew_QuestDetailAcceptButton_OnClick()
	NuNOri_QuestDetailAcceptButton_OnClick();
	NuN_QuestAccepted = GetTitleText();
end

function NuNNew_QuestRewardCompleteButton_OnClick()
	local qN = GetTitleText();
	NuN_QuestHandIn(qN);
	NuNOri_QuestRewardCompleteButton_OnClick();
end

-------------------------------------------------------------------------------------------
-- Attempt to Hook MapNotes functions

function NuNNew_MapNotes_OnEnter(id)
	if ( NuNPopup:IsVisible() ) then
		return;
	end
	NuNOri_MapNotes_OnEnter(id);
	NuN_WorldMapTooltip_OnShow(id);
end

function NuNNew_MapNotes_OnLeave(id)
	if ( NuNPopup:IsVisible() ) then
		popUpHide = true;
		return;
	end
	NuNOri_MapNotes_OnLeave(id);
end

function NuNNew_MapNotes_DeleteNote(id, cont, zone)
	local lId = id;
	local lCont, lZone, lLst;
	if ( id > 0 ) then
		lCont, lZone, lLst = NuN_PreDeleteMapIndex(id, cont, zone);
	end
	NuNOri_MapNotes_DeleteNote(id, cont, zone);
	if ( ( lId > 0 ) and ( cont ~= 0 ) ) then
		NuN_DeleteMapIndex(lId, lCont, lZone, lLst);
	end
end

-------------------------------------------------------------------------------------------
-- Attempt to Hook MetaMapNotes functions

function NuNNew_MetaMapNotes_OnEnter(id)
	if ( NuNPopup:IsVisible() ) then
		return;
	end
	NuNOri_MetaMapNotes_OnEnter(id);
	WorldMapTooltip:SetScale(NuNSettings[pKey].mScale);
	WorldMapTooltip:Show();
	NuN_WorldMapTooltip_OnShow(id);
end

function NuNNew_MetaMapNotes_OnLeave(id)
	if ( NuNPopup:IsVisible() ) then
		popUpHide = true;
		return;
	end
	NuNOri_MetaMapNotes_OnLeave(id);
end

function NuNNew_MetaMapNotes_DeleteNote(id, cont, zone)
	local lId = id;
	local lCont, lZone, lLst;
	if ( id > 0 ) then
		lCont, lZone, lLst = NuN_PreDeleteMapIndex(id, cont, zone);
	end
	NuNOri_MetaMapNotes_DeleteNote(id, cont, zone);
	if ( ( lId > 0 ) and ( cont ~= 0 ) ) then
		NuN_DeleteMapIndex(lId, lCont, lZone, lLst);
	end
end

-------------------------------------------------------------------------------------------


function NuN_GNoteFromItem(link, theTT)
	local catTxt = "";

	catTxt = NuN_ExtractTooltipInfo(catTxt, theTT);
	c_note = link;
	c_type = NuNGet_CommandID(noteTypes, "ITM");
	NuN_ShowTitledGNote(catTxt);
end


function NuN_ExtractTooltipInfo(xTTText, theTT)
	local lftTxt, rgtTxt, needRight;
	local endLine = "\n";
	local tmpTxt;
	local foundTTInfo = false;
	local ttLLen = NUN_TT_LEN;

	if ( NuNSettings[pKey].ttLLen ) then
		if ( NuNSettings[pKey].ttLLen == "" ) then
			ttLLen = 0;
		else
			ttLLen = tonumber( NuNSettings[pKey].ttLLen );
		end
	end

	for i=2, 23, 1 do
		lftTxt = getglobal(theTT.."TextLeft"..i):GetText();
		rgtTxt = getglobal(theTT.."TextRight"..i):GetText();
		needRight = false;
		tmpTxt = "";
		if ( lftTxt ~= nil ) then
			if ( ( string.find(lftTxt, "\"" ) ) or ( ( string.find(lftTxt, "/") ) and ( string.find(lftTxt, "\)") ) ) ) then
				tmpTxt = NUN_GOLD..lftTxt;
			elseif ( string.find(lftTxt, ":") ) then
				tmpTxt = NUN_GREEN..lftTxt;
			else
				tmpTxt = NUN_WHITE..lftTxt;
			end
			if ( rgtTxt ~= nil ) then
				needRight = NuN_TestLeftTT(lftTxt);
				if ( needRight ) then
					local lLen = string.len(lftTxt);
					local rLen = string.len(rgtTxt);
					local spaces = ttLLen - (lLen + rLen) - 10;
					local pad = string.rep(" ", spaces);
					tmpTxt = tmpTxt..pad..rgtTxt;
				end
			end
			xTTText = xTTText..tmpTxt..NUN_C_END..endLine;
			foundTTInfo = true;
		end
	end

	return xTTText;
end



function NuN_TestLeftTT(lftTxt)
	if ( string.find(lftTxt, NUN_HAND ) ) or ( string.find(lftTxt, NUN_HAND2) ) or ( string.find(lftTxt, NUN_FEET ) ) or ( string.find(lftTxt, NUN_LEGS ) ) or ( string.find(lftTxt, NUN_HEAD ) ) or ( string.find(lftTxt, NUN_WAIST ) ) or ( string.find(lftTxt, NUN_SHOULDER ) ) or ( string.find(lftTxt, NUN_CHEST ) ) or ( string.find(lftTxt, NUN_WRIST ) ) or ( string.find(lftTxt, NUN_DAMAGE ) ) then
		return true;
	else
		return false;
	end
end



function NuN_Who()
	local wName = nil;
	local wGuildName = nil;
	local wRace = nil;
	local wClass = nil;
	local bttnHeadingText1;
	local bttnDetailText1;

	SendWho(c_name);

	local n = GetNumWhoResults();
	for i = 1, n, 1 do
		wName = GetWhoInfo(i);
		if ( wName == c_name ) then
			wName, wGuildName, wLvl, wRace, wClass, wZone = GetWhoInfo(i);
			if ( wGuildName ~= nil ) then
				c_guild = wGuildName;
			end
			bttnHeadingText1 = getglobal("NuNTitleButton1ButtonTextHeading");
			bttnDetailText1 = getglobal("NuNInforButton1ButtonTextDetail");
			if ( bttnHeadingText1:GetText() == dfltHeadings[1] ) and ( wGuildName ~= nil) then
				bttnDetailText1:SetText(wGuildName);
				c_guild = wGuildName;
				if ( wGuildName == "" ) then
					bttnChanges[6] = 1;
				else
					bttnChanges[6] = wGuildName;
				end
			end
			if ( wClass ~= nil ) then
				c_class = wClass;
				ddClass = NuNGet_TableID(Classes, c_class);
				UIDropDownMenu_SetSelectedID(NuNClassDropDown, ddClass);
				UIDropDownMenu_SetText(c_class, NuNClassDropDown);
			end
			if ( wRace ~= nil ) then
				c_race = wRace;
				ddRace = NuNGet_TableID(Races, c_race);
				UIDropDownMenu_SetSelectedID(NuNRaceDropDown, ddRace);
				UIDropDownMenu_SetText(c_race, NuNRaceDropDown);
			end
		end
	end
end



function NuN_Target()
	local lName;
	local lRace;
	local lClass;
	local lSex;
	local lPvPRank;
	local lPvPRankID;
	local lgName;
	local lgRank;
	local lgRankIndex;
	local theUnitID = nil;

	if ( ( UnitInParty("target") ) or ( UnitInRaid("target") ) ) then
		theUnitID = "target";
	end

	if ( theUnitID == nil ) then
		theUnitID = NuN_CheckPartyByName(c_name);
	end

	if ( theUnitID ==  nil ) then
		theUnitID = NuN_CheckRaidByName(c_name);
	end

	if ( theUnitID == nil ) then
		TargetByName(c_name);
		lName = UnitName("target");
		if ( lName == c_name ) then
			theUnitID = "target";
		else
			ClearTarget();
		end
	end

	if ( unitTest == true ) then
		unitTest = false;
	else
		if ( theUnitID ~= nil ) then
			lRace = UnitRace(theUnitID);
			if ( lRace ~= nil ) then
				c_race = lRace;
				ddRace = NuNGet_TableID(Races, c_race);
				UIDropDownMenu_SetSelectedID(NuNRaceDropDown, ddRace);
				UIDropDownMenu_SetText(c_race, NuNRaceDropDown);
			end

			lClass = UnitClass(theUnitID);
			if ( lClass ~= nil ) then
				c_class = lClass;
				ddClass = NuNGet_TableID(Classes, c_class);
				UIDropDownMenu_SetSelectedID(NuNClassDropDown, ddClass);
				UIDropDownMenu_SetText(c_class, NuNClassDropDown);
			end

			lSex = UnitSex(theUnitID);
			if ( lSex ~= nil ) then
				if ( lSex == 0 ) then
					lsex = NUN_MALE;
				else
					lsex = NUN_FEMALE;
				end
				ddSex = NuNGet_TableID(Sexes, lsex);
				UIDropDownMenu_SetSelectedID(NuNSexDropDown, ddSex);
				UIDropDownMenu_SetText(lsex, NuNSexDropDown);
			end

			lPvPRankID = UnitPVPRank(theUnitID);
			if ( lPvPRankID ~= nil ) and ( lPvPRankID > 0 ) then
				lPvPRank = GetPVPRankInfo(lPvPRankID);
				ddCRank = NuNGet_TableID(Ranks, lPvPRank);
				UIDropDownMenu_SetSelectedID(NuNCRankDropDown, ddCRank);
				UIDropDownMenu_SetText(lPvPRank, NuNCRankDropDown);
			end

			lgName, lgRank, lgRankIndex = GetGuildInfo(theUnitID);
			if ( lgName ~= nil ) then
				c_guild = lgName;
			end
			bttnHeadingText1 = getglobal("NuNTitleButton1ButtonTextHeading");
			bttnDetailText1 = getglobal("NuNInforButton1ButtonTextDetail");
			bttnHeadingText2 = getglobal("NuNTitleButton2ButtonTextHeading");
			bttnDetailText2 = getglobal("NuNInforButton2ButtonTextDetail");
			if ( lgName ~= "" ) and ( lgName ~= nil ) then
				if ( bttnHeadingText1:GetText() == dfltHeadings[1] ) then
					bttnDetailText1:SetText(lgName);
					bttnChanges[6] = lgName;
				end
				if ( bttnHeadingText2:GetText() == dfltHeadings[2] ) then
					if ( lgRankIndex == 0 ) then
						lgRankTxt = ( "GM : "..lgRank );
					else
						lgRankTxt = ( lgRankIndex.." : "..lgRank );
					end
					bttnDetailText2:SetText(lgRankTxt);
					bttnChanges[7] = lgRankTxt;
				end
			end

			if ( theUnitID == "target" ) then
				for index = 1, getn(invSlotList), 1 do
					local text = GetInventoryItemLink(theUnitID, index);
					if ( text ) then
						local link = NuN_GetLink(text);
						if ( link ) then
							ItemRefTooltip:SetHyperlink(link);
							NuN_CheckSlot();
							if ( typeIndex ) then
								NuNText:SetText( NuNText:GetText() .. "\n" .. invSlotList[typeIndex].name .. text );
							else
								NuNText:SetText( NuNText:GetText() .. "\n" .. text );
							end
						end
					end
				end
			end

		end
	end
	return theUnitID;
end



function NuN_CheckSlot()
	local lftTxt;

	typeIndex = nil;
	NuN_Fingers = 0;
	NuN_Trinkets = 0;
	NuN_Hand = 0;
	for i=2, 5, 1 do
		lftTxt = getglobal("ItemRefTooltipTextLeft"..i):GetText();
		if ( lftTxt ) then
			typeIndex = NuN_Wearable(lftTxt);
			if ( typeIndex ~= nil ) then
				break;
			end
		end
	end
end



function NuN_Wearable(txt)
	if ( string.find(txt, NUN_HEAD) ) then
		return  1;
	elseif ( string.find(txt, NUN_NECK) ) then
		return  2;
	elseif ( string.find(txt, NUN_SHOULDER) ) then
		return  3;
	elseif ( string.find(txt, NUN_SHIRT) ) then
		return  4;
	elseif ( string.find(txt, NUN_CHEST) ) then
		return  5;
	elseif ( string.find(txt, NUN_WAIST) ) then
		return  6;
	elseif ( string.find(txt, NUN_LEGS) ) then
		return  7;
	elseif ( string.find(txt, NUN_FEET) ) then
		return  8;
	elseif ( string.find(txt, NUN_WRIST) ) then
		return  9;
	elseif ( string.find(txt, NUN_HANDS) ) then
		return 10;
	elseif ( string.find(txt, NUN_FINGER) ) then
		NuN_Fingers = NuN_Fingers + 1;
		return 11 + NuN_Fingers;
	elseif ( string.find(txt, NUN_TRINKET) ) then
		NuN_Trinkets = NuN_Trinkets + 1;
		return 13 + NuN_Trinkets;
	elseif ( string.find(txt, NUN_BACK) ) then
		return 15;
	elseif ( string.find(txt, NUN_HAND) ) then
		NuN_Hand = NuN_Hand + 1;
		return 16 + NuN_Hand;
	elseif ( string.find(txt, NUN_HAND2) ) then
		return 16;
	elseif ( string.find(txt, NUN_GUN) ) or ( string.find(txt, NUN_RANGED) ) or ( string.find(txt, NUN_BOW_U) ) or ( string.find(txt, NUN_BOW_L) ) or ( string.find(txt, NUN_WAND) or ( string.find(txt, NUN_THROWN) ) ) then
		return 18;
	elseif ( string.find(txt, NUN_TABARD) ) then
		return 19;
	else
		return nil;
	end
end



function NuN_Delete()
	if ( NuNData[pKey][c_name] ) then
		NuNData[pKey][c_name] = nil;
	end

	for n = 1, uBttns, 1 do
		nameHdNbr = c_name..pHead..n;
		nameDtNbr = c_name..pDetl..n;
		if ( NuNData[pKey][nameHdNbr] ) then
			NuNData[pKey][nameHdNbr] = nil;
		end
		if ( NuNData[pKey][nameDtNbr] ) then
			NuNData[pKey][nameDtNbr] = nil;
		end
	end
	if ( NuN_CTTCheckBox:GetChecked() ) then
		NuN_ClearPinnedTT();
	end
	NuN_HideFrame();
	if ( ( NuNSearchFrame:IsVisible() ) and ( not string.find(NuNSearchTitleText:GetText(), NUN_QUESTS_TEXT) ) ) then
		deletedE = true;
		NuNSearch_Search();
	end
	if ( FriendsListFrame:IsVisible() ) then
		NuNNew_FriendsList_Update();
	elseif ( IgnoreListFrame:IsVisible() ) then
		NuNNew_IgnoreList_Update();
	elseif ( GuildPlayerStatusFrame:IsVisible() ) then
		NuNNew_GuildStatus_Update();
	elseif ( GuildStatusFrame:IsVisible() ) then
		NuNNew_GuildStatus_Update();
	elseif ( WhoFrame:IsVisible() ) then
		NuNNew_WhoList_Update();
	end
end

function NuNGNote_Delete()
	local c_note = NuNGNoteTitleButtonText:GetText();
	if ( NuNGNoteFrame.fromQuest ) then
		NuNData[pKey].QuestHistory[pName][c_note] = nil;
		HideUIPanel(NuNGNoteFrame);
		if ( NuNSearchFrame:IsVisible() ) then
			deletedE = true;
			NuN_FetchQuestHistory();
		end
	else
		if ( string.find(c_note, "|Hitem:") ) then
			NuN_DeleteItem(c_note);
		end
		if ( NuNData[pKey][Notes][c_note] ) then
			NuNData[pKey][Notes][c_note] = nil;
		elseif ( NuNData[Notes][c_note] ) then
			NuNData[Notes][c_note] = nil;
		end
		if ( NuN_GTTCheckBox:GetChecked() ) then
			NuN_ClearPinnedTT();
		end
		HideUIPanel(NuNGNoteFrame);
		if ( NuNSearchFrame:IsVisible() ) then
			deletedE = true;
			NuNSearch_Search();
		end
		if ( ( QuestLogFrame:IsVisible() ) and ( not NuNGNoteFrame.fromQuest ) ) then
			NuNNew_QuestLog_Update();
		end
		NuN_UpdateMapNotesIndex(c_note);
	end
end



function NuNOptions_ResetDefaults()
	NuNSettings[pKey] = {};
	NuNSettings[pKey].autoG = nil;
	NuNSettings[pKey].autoA = nil;
	NuNSettings[pKey].autoD = nil;
	NuNSettings[pKey].toolTips = "1";
	NuNSettings[pKey].pScale = 1.00;
	NuNSettings[pKey].tScale = 1.00;
	NuNSettings[pKey].mScale = 1.00;
	NuN_PinnedTooltip:SetScale(1);
	NuN_Tooltip:SetScale(1);
	WorldMapTooltip:SetScale(1);
	NuN_MapTooltip:SetScale(1);
	NuNPopup:SetScale(1);
	NuNSettings[pKey].dLevel = "1";
	NuNSettings[pKey].autoQ = nil;
	NuNSettings[pKey].autoN = nil;
	NuNSettings[pKey].autoP = nil;
	NuNSettings[pKey].minOver = "1";
	NuNSettings[pKey].ttLen = NUN_TT_MAX;
	NuNSettings[pKey].ttLLen = NUN_TT_LEN;
	NuNSettings[pKey].hideMicro = nil;
	HideUIPanel(NuNOptionsFrame);
	NuNFrame:SetUserPlaced(0);
	NuNFrame:ClearAllPoints();
	NuNFrame:SetPoint("CENTER", UIParent, "CENTER", 220, 15);
	NuNGNoteFrame:SetUserPlaced(0);
	NuNGNoteFrame:ClearAllPoints();
	NuNGNoteFrame:SetPoint("CENTER", UIParent, "CENTER", 250, -15);
	NuNSearchFrame:SetUserPlaced(0);
	NuNSearchFrame:ClearAllPoints();
	NuNSearchFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 60, -144);
	if ( NuNMicroFrame:IsVisible() ) then
		HideUIPanel(NuNMicroFrame);
	end
	NuNMicroFrame:SetUserPlaced(0);
	NuNMicroFrame:ClearAllPoints();
	NuNMicroFrame:SetPoint("TOP", UIParent, "TOP", 0, -30);
	ShowUIPanel(NuNMicroFrame);
	NuN_Options();
end



function NuNOptions_Import()
	local x;
	local index;
	local value;
	local isInGuild = false;
	local lGuild = GetGuildInfo("player");
	if ( lGuild ~= nil ) then
		isInGuild = true;
	end

	NuN_importing = true;
	for index, value in NuNData[pKey] do
		if ( ( NuNData[pKey][index].faction ) and ( index == pName ) ) then
			NuNData[pKey][index].type = NUN_SELF_C;
		elseif ( ( NuNData[pKey][index].faction == pFaction ) and ( index ~= pName ) ) then
			if ( NuNData[pKey][index].ignoreLst ) then
				if ( not NuN_Is_Ignored(index) ) then
					if ( NuN_NotInfiniteIgored(index) ) then
						if ( AddIgnore(index) ) then
							x = getn(NuNData[pKey][index].ignoreLst) + 1;
							NuNData[pKey][index].ignoreLst[x] = pName;
						end
					end
				end
			elseif  ( ( isInGuild ) and ( NuNData[pKey][index].guild == lGuild ) and ( not NuNSettings[pKey].autoG ) ) then
				-- Forget this entry as they are guild mates with current player and settings say not to add as friend
			elseif ( NuNData[pKey][index].friendLst ) then
				if ( not NuN_Is_Friendly(index) ) then
					AddFriend(index);
					if ( not NuNData[pKey][index].friendLst ) then
						NuNData[pKey][index].friendLst = {};
					end
					if ( not NuNGet_TableID(NuNData[pKey][index].friendLst, pName) ) then
						x = getn( NuNData[pKey][index].friendLst) + 1;
						NuNData[pKey][index].friendLst[x] = pName;
					end
				end
			end
		end
	end
	NuN_importing = false;
end

function NuNOptions_Export()
	local iName;
	for i = 1, GetNumFriends(), 1 do
		iName = GetFriendInfo(i);
		if ( not NuNData[pKey][iName] ) then
			NuNData[pKey][iName] = {};
			NuNData[pKey][iName].type = NUN_AUTO_C;
			NuNData[pKey][iName].faction = pFaction;
			NuNData[pKey][iName][txtTxt] = NUN_AUTO_FRIEND..NuN_GetDateStamp();
			NuNData[pKey][iName].friendLst = {};
			NuNData[pKey][iName].friendLst[1] = pName;
		end
	end
	for i = 1, GetNumIgnores(), 1 do
		iName = GetIgnoreName(i);
		if ( not NuNData[pKey][iName] ) then
			NuNData[pKey][iName] = {};
			NuNData[pKey][iName].type = NUN_AUTO_C;
			NuNData[pKey][iName].faction = pFaction;
			NuNData[pKey][iName][txtTxt] = NUN_AUTO_IGNORE..NuN_GetDateStamp();
			NuNData[pKey][iName].ignoreLst = {};
			NuNData[pKey][iName].ignoreLst[1] = pName;
		end
	end
end



function NuNOptions_Search()
	local lDisplay = searchFor[ddSearch].Display;
	local lCommand = searchFor[ddSearch].Command;

	ddClassSearch = nil;
	ddProfSearch = nil;
	ddText = nil;
	lastBttnIndex = 0;
	lastBttn = nil;
	lastBttnDetl = nil;
	NuN_Filtered = nil;
	foundNuN = {};
	NuNSearchFrame:SetScale(NuNSettings[pKey].pScale);
	ShowUIPanel(NuNSearchFrame);
	HideUIPanel(NuNOptionsFrame);
	NuNSearchFrame.searchType = lDisplay;
	NuNSearchTitleText:SetText(lDisplay);
	NuNSearchFrameSearchButton:Enable();

	if ( ( lCommand == "All" ) or ( string.find(lCommand, "Notes") ) ) then
		NuNSearchClassDropDown:Hide();
		NuNSearchProfDropDown:Hide();
		NuNSearchTextBox:Hide();
		NuNSearch_Search();
	elseif ( lCommand == "Class" ) then
		UIDropDownMenu_ClearAll(NuNSearchClassDropDown);
		NuNSearchClassDropDown:Show();
		NuNSearchProfDropDown:Hide();
		NuNSearchTextBox:Hide();
		NuNSearch_Update();
	elseif ( lCommand == "Profession" ) then
		NuNSearchClassDropDown:Hide();
		UIDropDownMenu_ClearAll(NuNSearchProfDropDown);
		NuNSearchProfDropDown:Show();
		NuNSearchTextBox:Hide();
		NuNSearch_Update();
	elseif ( lCommand == "Quest History" ) then
		NuNSearchFrameSearchButton:Disable();
		NuNSearchClassDropDown:Hide();
		NuNSearchProfDropDown:Hide();
		NuNSearchTextBox:Hide();
		NuNSearchTitleText:SetText(NUN_QUESTS_TEXT.." : "..pName);
		NuN_FetchQuestHistory();
	else
		NuNSearchClassDropDown:Hide();
		NuNSearchProfDropDown:Hide();
--		NuNSearchTextBox:SetText("");
		NuNSearchTextBox:Show();
		NuNSearchTextBox:SetFocus();
--		NuNSearch_Update();
		NuNSearch_Search();
	end
end



function NuNSearch_Search()
	local index;
	local value;
	local tstTxt;
	local srchText;
	local countH = 0;
	local countA = 0;
	local countN = 0;
	local classType;
	local searchType = searchFor[ddSearch].Command;
	local subType = "";
	local noteType = 0;
	local results = 0;
	if ( searchType == "Class" ) then
		classType = AllClasses[ddClassSearch];
	end
	if ( string.find(searchType, "Notes:") ) then
		subType = string.sub(searchType, 7);
		searchType = string.sub(searchType, 1, 5);
	end

	foundNuN = {};
	foundHNuN = {};
	foundANuN = {};
	foundNNuN = {};

	for index, value in NuNData[pKey] do
		if ( searchType == "All" ) then
			if ( NuNData[pKey][index].faction == "Horde" ) then
				countH = countH + 1;
				foundHNuN[countH] = index;
			elseif ( NuNData[pKey][index].faction == "Alliance" ) then
				countA = countA + 1;
				foundANuN[countA] = index;
			end
		elseif ( searchType == "Class" ) then
			if ( NuNData[pKey][index].faction == "Horde" ) then
				if ( HClasses[NuNData[pKey][index].cls] == classType ) then
					countH = countH + 1;
					foundHNuN[countH] = index;
				end
			elseif ( NuNData[pKey][index].faction == "Alliance" ) then
				if ( AClasses[NuNData[pKey][index].cls] == classType ) then
					countA = countA + 1;
					foundANuN[countA] = index;
				end
			end
		elseif ( searchType == "Profession" ) then
			if ( NuNData[pKey][index].faction == "Horde" ) then
				if ( ( NuNData[pKey][index].prof1 == ddProfSearch ) or ( NuNData[pKey][index].prof2 == ddProfSearch ) ) then
					countH = countH + 1;
					foundHNuN[countH] = index;
				end
			elseif ( NuNData[pKey][index].faction == "Alliance" ) then
				if ( ( NuNData[pKey][index].prof1 == ddProfSearch ) or ( NuNData[pKey][index].prof2 == ddProfSearch ) ) then
					countA = countA + 1;
					foundANuN[countA] = index;
				end
			end
		elseif ( searchType == "Text" ) then
			tstTxt = NuNSearchTextBox:GetText();
			if ( NuNData[pKey][index].txt ) then
				srchText = NuN_GetCText(index);
				if ( srchText == nil ) then
					srchText = "";
				end
				if ( ( string.find(srchText, tstTxt) ) or ( string.find(NuNData[pKey][index].txt, tstTxt) ) or ( string.find(index, tstTxt) ) ) then
					local tName = index;
					if ( not NuNData[pKey][index].faction ) then
						tName = nil;
						local pos = string.find(index, pDetl);
						if ( pos == nil ) then
							pos = string.find(index, pHead);
							if ( pos ~= nil ) then
								tName = string.sub(index, 1, (pos - 1));
							end
						else
							tName = string.sub(index, 1, (pos - 1));
						end
					end
					if ( tName ~= nil ) then
						if ( NuNData[pKey][tName].faction == "Horde" ) then
							if ( NuNGet_TableID(foundHNuN, tName) == nil ) then
								countH = countH + 1;
								foundHNuN[countH] = tName;
							end
						else
							if ( NuNGet_TableID(foundANuN, tName) == nil ) then
								countA = countA + 1;
								foundANuN[countA] = tName;
							end
						end
					end
				end
			end
		end
	end

	for index, value in NuNData[pKey][Notes] do
		if ( ( NuNData[pKey][Notes][index] ) and ( NuNData[pKey][Notes][index].type ) ) then
			noteType = NuNData[pKey][Notes][index].type;
		else
			noteType = 1;
		end
		if ( ( searchType == "All" ) or ( searchType == "Notes" ) ) then
			if ( ( subType == "" ) or ( ( subType == "Generic" ) and ( noteType == 1 ) ) or ( ( subType == "Items" ) and ( noteType == 2 ) ) or ( ( subType == "Logs" ) and ( noteType == 3 ) ) or ( ( subType == "NPCs" ) and ( noteType == 4 ) ) or ( ( subType == "Quests" ) and ( noteType == 5 ) ) ) then
				countN = countN + 1;
				foundNNuN[countN] = index;
			end
		elseif ( searchType == "Text" ) then
			tstTxt = NuNSearchTextBox:GetText();
			srchText = NuN_GetGText(index);
			if ( srchText == nil ) then
				srchText = "";
			end
			if ( ( string.find(srchText, tstTxt)) or ( string.find(index, tstTxt ) ) ) then
				countN = countN + 1;
				foundNNuN[countN] = index;
			end
		end
	end

	for index, value in NuNData[Notes] do
		if ( ( NuNData[Notes][index] ) and ( NuNData[Notes][index].type ) ) then
			noteType = NuNData[Notes][index].type;
		else
			noteType = 1;
		end
		if ( ( searchType == "All" ) or ( searchType == "Notes" ) ) then
			if ( ( subType == "" ) or ( ( subType == "Generic" ) and ( noteType == 1 ) ) or ( ( subType == "Items" ) and ( noteType == 2 ) ) or ( ( subType == "Logs" ) and ( noteType == 3 ) ) or ( ( subType == "NPCs" ) and ( noteType == 4 ) ) or ( ( subType == "Quests" ) and ( noteType == 5 ) ) ) then
				countN = countN + 1;
				foundNNuN[countN] = index;
			end
		elseif ( searchType == "Text" ) then
			tstTxt = NuNSearchTextBox:GetText();
			srchText = NuN_GetGText(index);
			if ( srchText == nil ) then
				srchText = "";
			end
			if ( ( string.find(srchText, tstTxt)) or ( string.find(index, tstTxt ) ) ) then
				countN = countN + 1;
				foundNNuN[countN] = index;
			end
		end
	end

	table.sort(foundANuN);
	table.sort(foundHNuN);
	table.sort(foundNNuN);
	NuN_DefaultSort();

	if ( ( searchType ~= "Class" ) and ( searchType ~= "Profession" ) ) then
		NuNSearchTextBox:Show();
		ddSearch = NuNGet_CommandID(searchFor, "Text");
		if ( NuN_Filtered ) then
			local tmpNuN = {};
			local c = 0;

			for i=1, getn(foundNuN), 1 do
				if ( NuNGet_TableID(NuN_Filtered, foundNuN[i]) ) then
					c = c + 1;
					tmpNuN[c] = foundNuN[i];
				end
			end
			foundNuN = tmpNuN;
		else
			NuN_Filtered = foundNuN;
		end
	end

	results = getn(foundNuN);
	NuNSearchTitleText:SetText(NuNSearchFrame.searchType.." ("..results..")");

	NuNSearch_Update();
	if ( ( deletedE ) and ( visibles > 0 ) and ( lastBttn ~= nil ) ) then
		deletedE = false;
		if ( lastBttnIndex > visibles ) then
			NuNSearch_HighlightRefresh(lastVisible);
			NuNSearchNote_OnClick(lastVisible);
		else
			NuNSearch_HighlightRefresh(lastBttn);
			NuNSearchNote_OnClick(lastBttn);
		end
	else
		NuNSearch_HighlightRefresh(nil);
	end
end



function NuN_DefaultSort()
	if ( horde ) then
		NuN_copyT(foundNuN, foundHNuN, NUN_HORD_C);
		NuN_copyT(foundNuN, foundANuN, NUN_ALLI_C);
		NuN_copyT(foundNuN, foundNNuN, NUN_NOTE_C);
	else
		NuN_copyT(foundNuN, foundANuN, NUN_ALLI_C);
		NuN_copyT(foundNuN, foundHNuN, NUN_HORD_C);
		NuN_copyT(foundNuN, foundNNuN, NUN_NOTE_C);
	end
end



function NuN_copyT(t1, t2, c_prefix)
	local i1 = getn(t1);
	for i2=1, getn(t2), 1 do
		i1 = i1 + 1;
		t1[i1] = c_prefix..t2[i2];
	end
end



function NuNSearch_Back()
	if ( NuNFrame:IsVisible() ) then
		NuN_HideFrame();
	end
	if ( NuNGNoteFrame:IsVisible() ) then
		HideUIPanel(NuNGNoteFrame);
	end
	HideUIPanel(NuNSearchFrame);
	NuNOptionsFrame:SetScale(NuNSettings[pKey].pScale);
	NuN_Options();
end



function NuNSearch_Update()
	local theNoteIndex;
	local theOffsetNoteIndex;
	local theNote;
	local theNoteHFlag;
	local theNoteAFlag;
	local theNoteNFlag;
	local numNuNFound = getn(foundNuN);

	NuN_CheckQuestList();

	visibles = 0;
	FauxScrollFrame_Update(NuNSearchListScrollFrame, numNuNFound, NUN_SHOWN, NUN_NOTE_HEIGHT);
	for theNoteIndex=1, NUN_SHOWN, 1 do
		theOffsetNoteIndex = theNoteIndex + FauxScrollFrame_GetOffset(NuNSearchListScrollFrame);
		theNote = getglobal( "NuNSearchNote"..theNoteIndex );
		if ( theOffsetNoteIndex > numNuNFound ) then
			theNote:Hide();
		else
			theNote:SetTextColor(1, 0.82, 0, 1);
			theNoteHFlag = getglobal( "NuNSearchNote"..theNoteIndex.."FrameHFlag" );
			theNoteAFlag = getglobal( "NuNSearchNote"..theNoteIndex.."FrameAFlag" );
			theNoteNFlag = getglobal( "NuNSearchNote"..theNoteIndex.."FrameNFlag" );
			theNoteLFlag = getglobal( "NuNSearchNote"..theNoteIndex.."FrameLFlag" );
			theNoteType = getglobal( "NuNSearchNote"..theNoteIndex.."FrameType" );
			theNoteLFlag:Hide();
			local typ = string.sub(foundNuN[theOffsetNoteIndex], 1, 1);
			local noteName = string.sub(foundNuN[theOffsetNoteIndex], 2);
			theNote:SetText( noteName );
			if ( typ == NUN_HORD_C ) then
				theNoteAFlag:Hide();
				theNoteNFlag:Hide();
				theNoteHFlag:Show();
			elseif ( typ == NUN_ALLI_C ) then
				theNoteHFlag:Hide();
				theNoteNFlag:Hide();
				theNoteAFlag:Show();
			elseif ( typ == NUN_QUEST_C ) then
				theNoteHFlag:Hide();
				theNoteAFlag:Hide();
				if ( ( NuNData[Notes][noteName] ) or ( NuNData[pKey][Notes][noteName] ) ) then
					theNoteNFlag:Show();
				else
					theNoteNFlag:Hide();
				end
			else
				theNoteHFlag:Hide();
				theNoteAFlag:Hide();
				theNoteNFlag:Show();
			end
			theNote.type = typ;
			if ( typ == NUN_HORD_C ) or ( typ == NUN_ALLI_C ) then
				if ( NuNData[pKey][noteName].type ) then
					typ = NuNData[pKey][noteName].type;
					if ( typ == NUN_AUTO_C ) then
						theNoteType:SetText(NUN_AUTO);
					elseif ( noteName == pName ) then
						theNoteType:SetText(NUN_PLAYER);
					elseif ( typ == NUN_SELF_C ) then
						theNoteType:SetText(NUN_SELF);
					elseif ( typ == NUN_MANU_C ) then
						theNoteType:SetText(NUN_MANU);
					elseif ( typ == NUN_PARTY_C ) then
						theNoteType:SetText(NUN_PARTY);
					else
						theNoteType:SetText("   ");
					end
				else
					theNoteType:SetText("   ");
				end
			elseif ( typ == NUN_QUEST_C ) then
				theNoteLFlag:Hide();
				if ( ( not NuNQuestLog[noteName] ) and ( ( NuNData[pKey].QuestHistory[pName][noteName].handedIn ) or ( NuNData[pKey].QuestHistory[pName][noteName].complete ) ) ) then
					theNoteLFlag:Show();
				elseif ( ( NuNData[pKey].QuestHistory[pName][noteName] ) and ( NuNData[pKey].QuestHistory[pName][noteName].abandoned ) ) then
					theNote:SetTextColor(0.9, 0, 0, 0.9);
				elseif ( NuNQuestLog[noteName] ) then
					theNote:SetTextColor(0, 0.9, 0, 0.9);
				end
				theNoteType:SetText(NuNData[pKey].QuestHistory[pName][noteName].pLevel);
			else
				if ( ( NuNData[pKey][Notes][noteName] ) and ( NuNData[pKey][Notes][noteName].type ) ) then
					typ = NuNData[pKey][Notes][noteName].type;
				elseif ( NuNData[Notes][noteName] ) then
					theNoteLFlag:Show();
					if ( NuNData[Notes][noteName].type ) then
						typ = NuNData[Notes][noteName].type;
					end
				else
					typ = 1;
				end
				theNoteType:SetText(noteTypes[typ].Display);
				if ( noteTypes[typ].Command == "QST" ) then
					if ( NuNQuestLog[noteName] ) then
						theNote:SetTextColor(0, 0.9, 0, 0.9);
					elseif ( ( NuNData[pKey].QuestHistory[pName][noteName] ) and ( NuNData[pKey].QuestHistory[pName][noteName].abandoned ) ) then
						theNote:SetTextColor(0.9, 0, 0, 0.9);
					end
				end
			end
			theNote:Show();
			visibles = visibles + 1;
			lastVisible = theNote;
			if ( theOffsetNoteIndex == lastBttnDetl ) then
				theNote:LockHighlight();
			else
				theNote:UnlockHighlight();
			end
		end
	end
end



function NuNSearchNote_OnEnter(bttnNote)
	local bttnName = bttnNote:GetName();
	local storePinned = NuN_PinnedTooltip.type;

	local x, y = GetCursorPosition();
	if ( x > 500 ) then
		NuN_Tooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		NuN_Tooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	ttName = bttnNote:GetText();
	NuN_Tooltip:ClearLines();
	if ( bttnNote.type == "N" ) then
		NuN_PinnedTooltip.type = "General";
	elseif ( bttnNote.type == "A" ) or ( bttnNote.type == "H" ) then
		NuN_PinnedTooltip.type = "Contact";
	elseif ( bttnNote.type == NUN_QUEST_C ) then
		NuN_PinnedTooltip.type = "QuestHistory";
	end
	NuN_BuildTT(NuN_Tooltip);
	NuN_PinnedTooltip.type = storePinned;
	NuN_Fade = "False";
	NuN_Tooltip:Show();
end



function NuNSearchNote_OnClick(bttnNote)
	local noteName = bttnNote:GetText();
	local lclNote;
	local lclNoteHFlag;
	local lclNoteAFlag;
	local lclNoteNFlag;
	local lastBttnDetlN;
	local nType;

	if ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(noteName);
		elseif ( NuNGNoteFrame:IsVisible() ) then
			local cText = NuNGNoteTextScroll:GetText().."\n"..noteName;
			NuNGNoteTextScroll:SetText(cText);
		elseif ( NuNFrame:IsVisible() ) then
			local cText = NuNText:GetText().."\n"..noteName;
			NuNText:SetText(cText);
		end
	else
		lastBttn = bttnNote;
		lastBttnIndex = bttnNote:GetID();
		lastBttnDetlN = bttnNote.type..noteName;
		lastBttnDetl = NuNGet_TableID(foundNuN, lastBttnDetlN);

		NuNSearch_HighlightRefresh(bttnNote);

		if ( ( bttnNote.type == NUN_HORD_C ) or ( bttnNote.type == NUN_ALLI_C ) ) then
			c_name = noteName;
			NuN_ShowSavedNote( c_name );
		else
			if ( bttnNote.type == NUN_QUEST_C ) then
				NuNGNoteFrame.fromQuest = "1";
				c_type = NuNGet_CommandID(noteTypes, "QST");
			else
				NuNGNoteFrame.fromQuest = nil;
			end
			c_note = noteName;
			if ( ( NuNData[Notes][c_note] ) or ( NuNData[pKey][Notes][c_note] ) ) then
				NuN_ShowSavedGNote();
			else
				NuN_ShowTitledGNote("");
			end
		end
	end
end



function NuNSearch_HighlightRefresh(tstNote)
	local theNote;
	for i=1, NUN_SHOWN, 1 do
		theNote = getglobal("NuNSearchNote"..i);
		if ( ( theNote == tstNote ) and ( theNote:IsVisible() ) ) then
			theNote:LockHighlight();
		else
			theNote:UnlockHighlight();
		end
	end
end



function NuN_DateStamp()
	NuNText:SetText(NuNText:GetText().."\n"..NuN_GetDateStamp());
end

function NuNGNote_DateStamp()
	NuNGNoteTextScroll:SetText(NuNGNoteTextScroll:GetText().."\n"..NuN_GetDateStamp());
end

function NuN_GetDateStamp()
	local dateStamp = date("%A, %d %B %Y  %H:%M:%S");
	dateStamp = NuN_LocaliseDateStamp(dateStamp);
	return dateStamp;
end



function NuN_Loc()
	NuNText:SetText(NuNText:GetText().."\n"..NuN_GetLoc());
end

function NuNGNote_Loc()
	NuNGNoteTextScroll:SetText(NuNGNoteTextScroll:GetText().."\n"..NuN_GetLoc());
end

function NuN_GetLoc()
	local locData = pName.."'s "..NUN_LOC.." : ";
	local myCID, myC, mySubZ, myZID, myZ, px, py, coords;
	local loc = false;

	myCID = GetCurrentMapContinent();
	if ( ( myCID ~= nil) and ( myCID > 0 ) ) then
		myC = c_continents[myCID].name;
	end
	if ( myC ~= nil ) then
		locData = locData..myC..", ";
		loc = true;
	end

	myZ = GetZoneText();
	if ( ( myZ == nil ) or ( myZ == "" ) ) then
		myZID = GetCurrentMapZone();
		if ( ( myZID ~= nil ) and ( myCID ~= nil ) and ( myCID > 0 ) ) then
			myZ = c_continents[myCID].zones[myZID];
		end
	end
	if ( ( myZ ~= nil ) and ( myZ ~= "" ) ) then
		locData = locData..myZ..", ";
	end


	mySubZ = GetSubZoneText();
	if ( ( mySubZ == nil ) or ( mySubZ == "" ) ) then
		mySubZ = GetMinimapZoneText();
	end
	if ( mySubZ ~= nil ) then
		locData = locData..mySubZ..", ";
		loc = true;
	end

	px, py = GetPlayerMapPosition("player");
    	if ( ( px ~= nil ) and ( py ~= nil ) ) then
        	coords = format("(%d, %d)", px * 100.0, py * 100.0);
		locData = locData..coords;
		loc = true; 
    	end
    	if ( loc == true ) then
		return locData;
	else
		return "";
	end
end



function NuN_AutoNote()
	if ( NuNSettings[pKey].autoN ) then
		local lName;
		local lRace;
		local lClass;
		local lSex;
		local lPvPRank;
		local lPvPRankID;
		local lgName;
		local lgRank;
		local lgRankIndex;
		local bttnKey;

		if ( pFaction ~= nil ) then
			NuNData[pKey][pName] = {};
			NuNData[pKey][pName].type = NUN_SELF_C;
			NuNData[pKey][pName].faction = pFaction;
			NuNData[pKey][pName][txtTxt] = "";
			lRace = UnitRace("player");
			if ( lRace ~= nil ) then
				ddRace = NuNGet_TableID(Races, lRace);
				NuNData[pKey][pName].race = ddRace;
			end
			lClass = UnitClass("player");
			if ( lClass ~= nil ) then
				ddClass = NuNGet_TableID(Classes, lClass);
				NuNData[pKey][pName].cls = ddClass;
			end
			lSex = UnitSex("player");
			if ( lSex ~= nil ) then
				NuNData[pKey][pName].sex = lSex + 1;
			end
			lPvPRankID = UnitPVPRank("player");
			if ( lPvPRankID ~= nil ) and ( lPvPRankID > 0 ) then
				lPvPRank = GetPVPRankInfo(lPvPRankID);
				ddCRank = NuNGet_TableID(Ranks, lPvPRank);
				NuNData[pKey][pName].crank = ddCRank;
			end
			lgName, lgRank, lgRankIndex = GetGuildInfo("player");
			if ( lgName ~= "" ) and ( lgName ~= nil ) then
				bttnKey = pName..pDetl.."1";
				NuNData[pKey][bttnKey] = {};
				NuNData[pKey][bttnKey].txt = lgName;
				bttnKey = pName..pDetl.."2";
				NuNData[pKey][bttnKey] = {};
				if ( lgRankIndex == 0 ) then
					NuNData[pKey][bttnKey].txt = ( "GM : "..lgRank );
				else
					NuNData[pKey][bttnKey].txt = ( lgRankIndex.." : "..lgRank );
				end
			end
		end
	end
end



function NuN_ClrDD()
	if ( lastDD == "Race" ) then
		UIDropDownMenu_ClearAll(NuNRaceDropDown);
		if ( ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].race ) ) then
			ddRace = -1;
		else
			ddRace = nil;
		end
	elseif ( lastDD == "Class" ) then
		UIDropDownMenu_ClearAll(NuNClassDropDown);
		if ( ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].cls ) ) then
			ddClass = -1;
		else
			ddClass = nil;
		end
	elseif ( lastDD == "Sex" ) then
		UIDropDownMenu_ClearAll(NuNSexDropDown);
		if ( ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].sex ) ) then
			ddSex = -1;
		else
			ddSex = nil;
		end
	elseif ( lastDD == "Prof1" ) then
		UIDropDownMenu_ClearAll(NuNProf1DropDown);
		if ( ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].prof1 ) ) then
			ddProf1 = -1;
		else
			ddProf1 = nil;
		end
	elseif ( lastDD == "Prof2" ) then
		UIDropDownMenu_ClearAll(NuNProf2DropDown);
		if ( ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].prof2 ) ) then
			ddProf2 = -1;
		else
			ddProf2 = nil;
		end
	elseif ( lastDD == "CRank" ) then
		UIDropDownMenu_ClearAll(NuNCRankDropDown);
		if ( ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].crank ) ) then
			ddCRank = -1;
		else
			ddCRank = nil;
		end
	elseif ( lastDD == "HRank" ) then
		UIDropDownMenu_ClearAll(NuNHRankDropDown);
		if ( ( NuNData[pKey][c_name] ) and ( NuNData[pKey][c_name].hrank ) ) then
			ddHRank = -1;
		else
			ddHRank = nil;
		end
	end
	lastDD = nil;
	NuNButtonClrDD:Disable();
end


function NuN_GTypeDependant_Setup()
	UIDropDownMenu_SetSelectedID(NuNGTypeDropDown, c_type);
	UIDropDownMenu_SetText(noteTypes[c_type].Display, NuNGTypeDropDown);
	if ( noteTypes[c_type].Command == "NPC" ) then
		NuNNPCTargetButton:Show();
	else
		NuNNPCTargetButton:Hide();
	end
end


function NuN_ShowSavedGNote()
	if ( ( NuNGNoteFrame:IsVisible() ) and ( prevNote == c_note ) ) then
		NuNGNoteFrame:Hide();
	else
		if ( ( NuNData[pKey][Notes][c_note] ) and ( NuNData[pKey][Notes][c_note].type ) ) then
			c_type = NuNData[pKey][Notes][c_note].type;
			NuNGNoteFrame.type = c_type;
			NuN_GTypeDependant_Setup();
		elseif ( ( NuNData[Notes][c_note] ) and ( NuNData[Notes][c_note].type ) ) then
			c_type = NuNData[Notes][c_note].type;
			NuNGNoteFrame.type = c_type;
			NuN_GTypeDependant_Setup();
		else
			c_type = NuNGet_CommandID(noteTypes, "   ");
			NuNGNoteFrame.type = c_type;
			NuN_GTypeDependant_Setup();
		end
		if ( NuNData[pKey][Notes][c_note] ) then
			NuN_GLevel_CheckBox:SetChecked(0);
		elseif ( NuNData[Notes][c_note] ) then
			NuN_GLevel_CheckBox:SetChecked(1);
		end
		NuN_GNote_OriTitle = c_note;
		prevNote = c_note;
		if ( NuNOptionsFrame:IsVisible() ) then
			HideUIPanel(NuNOptionsFrame);
		end
		if ( NuNcDeleteFrame:IsVisible() ) then
			HideUIPanel(NuNcDeleteFrame);
		end
		NuNGNoteFrame:SetScale(NuNSettings[pKey].pScale);
		ShowUIPanel(NuNGNoteFrame);
		NuNGNoteTextBox:Hide();
		g_text = NuN_GetGText(c_note);
		if ( g_text == "" ) then
			g_text = "\n";
		end
		NuNGNoteTextScroll:SetText(g_text);
		NuNGNoteTitleButtonText:SetText(c_note);
		NuNGNoteTitleButton:Show();
		if ( not NuNSettings[pKey].bHave ) then
			NuNGNoteTextScroll:SetFocus();
		end
		if ( NuNGNoteFrame.fromQuest ) then
			NuNGNoteHeader:SetText(NUN_QUEST_NOTE);
			NuNGNoteButtonDelete:Enable();
			NuNGNoteTitleButton:Disable();
			NuNGNoteButtonSaveNote:Disable();
		else
			NuNGNoteHeader:SetText(NUN_SAVED_NOTE);
			NuNGNoteButtonDelete:Disable();
			NuNGNoteTitleButton:Enable();
			NuNGNoteButtonSaveNote:Enable();
		end
		NuNGNoteButtonDateStamp:Enable();
		NuNGNoteButtonLoc:Enable();
		NuNGNoteButtonDelete:Enable();
		if ( ( MapNotes_OnLoad ) or ( MetaMapNotes_OnLoad ) ) then
			NuNMapNoteButton:Enable();
		end
		NuNGOpenChatButton:Enable();
		NuNGTTCheckBoxLabel:Show();
		NuN_GTTCheckBox:Show();
		NuN_GTTCheckBox:SetChecked(0);
		if ( NuN_PinnedTooltip.type == "General" ) then
			NuN_GTTCheckBox:SetChecked( NuN_CheckPinnedBox(c_note) );
		end
	end
end

function NuN_ShowTitledGNote(GNoteText)
	if ( ( NuNGNoteFrame:IsVisible() ) and ( prevNote == c_note ) ) then
		NuNGNoteFrame:Hide();
	else
		if ( NuNSettings[pKey].dLevel ) then
			NuN_GLevel_CheckBox:SetChecked(1);
		else
			NuN_GLevel_CheckBox:SetChecked(0);
		end
		prevNote = c_note;
		NuNGNoteFrame.type = c_type;
		NuN_GTypeDependant_Setup();
		NuN_GNote_OriTitle = nil;
		if ( NuNOptionsFrame:IsVisible() ) then
			HideUIPanel(NuNOptionsFrame);
		end
		if ( NuNcDeleteFrame:IsVisible() ) then
			HideUIPanel(NuNcDeleteFrame);
		end
		NuNGNoteFrame:SetScale(NuNSettings[pKey].pScale);
		ShowUIPanel(NuNGNoteFrame);
		NuNGNoteTextScroll:SetText(GNoteText);
		NuNGNoteTextBox:Hide();
		NuNGNoteTitleButtonText:SetText(c_note);
		NuNGNoteTitleButton:Show();
		if ( not NuNSettings[pKey].bHave ) then
			NuNGNoteTextScroll:SetFocus();
		end
		NuNGNoteButtonDateStamp:Enable();
		NuNGNoteButtonLoc:Enable();
		if ( NuNGNoteFrame.fromQuest ) then
			NuNGNoteHeader:SetText(NUN_QUEST_NOTE);
			NuNGNoteButtonDelete:Enable();
			if ( ( MapNotes_OnLoad ) or ( MetaMapNotes_OnLoad ) ) then
				NuNMapNoteButton:Enable();
			end
			NuNGNoteTitleButton:Disable();
			NuNGNoteButtonSaveNote:Disable();
		else
			NuNGNoteHeader:SetText(NUN_NEW_NOTE);
			NuNGNoteButtonDelete:Disable();
			NuNMapNoteButton:Disable();
			NuNGNoteTitleButton:Enable();
			NuNGNoteButtonSaveNote:Enable();
		end
		NuNGOpenChatButton:Disable();
		NuNGTTCheckBoxLabel:Hide();
		NuN_GTTCheckBox:Hide();
	end
end

function NuN_ShowNewGNote()
	local tstTxt = NuNGNoteTextBox:GetText();
	if ( ( NuNGNoteFrame:IsVisible() ) and ( NuNGNoteTextBox:IsVisible() ) and ( tstTxt == "" ) ) then
		NuNGNoteFrame:Hide();
	else
		if ( IsAltKeyDown() ) then
			NuN_LastOpen.type = "General";
			NuN_ReOpen();
			return;
		end

		if ( NuNSettings[pKey].dLevel ) then
			NuN_GLevel_CheckBox:SetChecked(1);
		else
			NuN_GLevel_CheckBox:SetChecked(0);
		end
		c_type = NuNGet_CommandID(noteTypes, "   ");
		NuNGNoteFrame.type = c_type;
		NuNGNoteFrame.fromQuest = nil;
		NuN_GTypeDependant_Setup();
		NuN_GNote_OriTitle = nil;
		if ( NuNOptionsFrame:IsVisible() ) then
			HideUIPanel(NuNOptionsFrame);
		end
		if ( NuNcDeleteFrame:IsVisible() ) then
			HideUIPanel(NuNcDeleteFrame);
		end
		if ( NuNGNoteFrame.fromQuest ) then
			NuNGNoteHeader:SetText(NUN_QUEST_NOTE);
		else
			NuNGNoteHeader:SetText(NUN_NEW_NOTE);
		end
		NuNGNoteButtonSaveNote:Disable();
		NuNGNoteFrame:SetScale(NuNSettings[pKey].pScale);
		ShowUIPanel(NuNGNoteFrame);
		NuNGNoteTextScroll:SetText("");
		NuNGNoteTitleButton:Hide();
		NuNGNoteTextBox:SetText("");
		NuNGNoteTextBox:Show();
		NuNGNoteTextBox:SetFocus();
		NuNGNoteButtonDelete:Disable();
		NuNMapNoteButton:Disable();
		NuNGOpenChatButton:Disable();
		NuNGTTCheckBoxLabel:Hide();
		NuN_GTTCheckBox:Hide();
	end
end



function NuN_OptionsGuildCheckBox_OnClick()
	if ( NuNOptionsGuildCheckButton:GetChecked() ) then
		NuNSettings[pKey].autoG = "1";
	else
		NuNSettings[pKey].autoG = nil;
	end
end

function NuN_OptionsAddCheckBox_OnClick()
	if ( NuNOptionsAddCheckButton:GetChecked() ) then
		NuNSettings[pKey].autoA = "1";
		NuN_Update_Friends();
		NuN_Update_Ignored();
	else
		NuNSettings[pKey].autoA = nil;
	end
end

function NuN_OptionsDeleteCheckBox_OnClick()
	if ( NuNOptionsDeleteCheckButton:GetChecked() ) then
		NuNSettings[pKey].autoD = "1";
		NuN_Update_Friends();
		NuN_Update_Ignored();
	else
		NuNSettings[pKey].autoD = nil;
	end
end

function NuN_DefaultLevelCheckBox_OnClick()
	if ( NuN_DefaultLevelCheckBox:GetChecked() ) then
		NuNSettings[pKey].dLevel = "1";
	else
		NuNSettings[pKey].dLevel = nil;
	end
end

function NuN_HelpTTCheckBox_OnClick()
	if ( NuN_HelpTTCheckBox:GetChecked() ) then
		NuNSettings[pKey].toolTips = "1";
	else
		NuNSettings[pKey].toolTips = nil;
	end
end

function NuN_AutoQuestCheckBox_OnClick()
	if ( NuN_AutoQuestCheckBox:GetChecked() ) then
		NuNSettings[pKey].autoQ = "1";
		NuN_UpdateQuestNotes("SwitchedOn");
	else
		NuNSettings[pKey].autoQ = nil;
	end
end

function NuN_AutoNoteCheckBox_OnClick()
	if ( NuN_AutoNoteCheckBox:GetChecked() ) then
		NuNSettings[pKey].autoN = "1";
		if ( not NuNData[pKey][pName] ) then
			NuN_AutoNote();
		end
	else
		NuNSettings[pKey].autoN = nil;
	end
end


function NuN_OnUpdate(arg1)
	if ( ( NuNMicroFrame:IsVisible() ) and ( MouseIsOver(NuNMicroFrame) ) ) then
		NuNMicroBorder:Show();
	else
		NuNMicroBorder:Hide();
	end

	if ( noTipAnchor ) then
		NuN_GameTooltip_OnShow();
	end

	timeSinceLastUpdate = timeSinceLastUpdate + arg1;
	if ( ( timeSinceLastUpdate > updateInterval ) and ( not UnitAffectingCombat("player") ) ) then
		if ( not NuNData[pKey][pName] ) then
			NuN_AutoNote();
		end
		if ( oneDone == true ) then
			oneDone = false;
			NuN_AtStartup = "False";
			NuN_QuestsUpdating = "False";
			if ( InfinateIgnore_Config ) then
				NuN_Update_Ignored();
			end
		else
			oneDone = true;
			if ( not QuestLogFrame:IsVisible() ) then
				NuN_CheckQuestList();
				if ( not NuN_IgnoreNextQUpdate ) then
					NuN_UpdateQuestNotes("Timed");
				end
			end
		end
		timeSinceLastUpdate = 0;
	end
end



function NuN_NewContact(unitType)
	local Friendly;

	if ( ( unitType == "target" ) and ( c_name ~= pName ) ) then
		if ( UnitIsFriend("player", "target") ) then
			Friendly = true;
		else
			Friendly = false;
		end
	else
		Friendly = true;
	end
	if ( ((horde) and (Friendly))  or  ((not horde) and (not Friendly)) ) then
		c_faction = "Horde";
		NuN_HordeSetup();
	else
		c_faction = "Alliance";
		NuN_AllianceSetup();
	end
	c_route = "Target";
	c_race = nil;
	c_class = nil;
	c_guild = nil;
	gRank = nil;
	gRankIndex = nil;
	gNote = nil;
	gOfficerNote = nil;
	NuN_ShowNote();
	NuN_Target();
	if ( c_name == pName ) then
		ClearTarget();
	end
end


function NuN_CreateContact(contactName, tFaction)
	c_name = contactName;
	c_route = "Create";
	if ( ( tFaction == "-ch" ) or ( tFaction == "Horde" ) ) then
		c_faction = "Horde";
		NuN_HordeSetup();
	else
		c_faction = "Alliance";
		NuN_AllianceSetup();
	end
	c_race = nil;
	c_class = nil;
	c_guild = nil;
	gRank = nil;
	gRankIndex = nil;
	gNote = nil;
	gOfficerNote = nil;
	NuN_ShowNote();
end


function NuN_HordeSetup()
	NuNRaceDropDown = NuNHRaceDropDown;
	NuNClassDropDown = NuNHClassDropDown;
	NuNCRankDropDown = NuNHCRankDropDown;
	NuNHRankDropDown = NuNHHRankDropDown;
	NuNARaceDropDown:Hide();
	NuNHRaceDropDown:Show();
	NuNAClassDropDown:Hide();
	NuNHClassDropDown:Show();
	NuNACRankDropDown:Hide();
	NuNHCRankDropDown:Show();
	NuNAHRankDropDown:Hide();
	NuNHHRankDropDown:Show();
	Classes = HClasses;
	Races = HRaces;
	Ranks = HRanks;
	NuNAFlag:Hide();
	NuNHFlag:Show();
end

function NuN_AllianceSetup()
	NuNRaceDropDown = NuNARaceDropDown;
	NuNClassDropDown = NuNAClassDropDown;
	NuNCRankDropDown = NuNACRankDropDown;
	NuNHRankDropDown = NuNAHRankDropDown;
	NuNHRaceDropDown:Hide();
	NuNARaceDropDown:Show();
	NuNHClassDropDown:Hide();
	NuNAClassDropDown:Show();
	NuNHCRankDropDown:Hide();
	NuNACRankDropDown:Show();
	NuNHHRankDropDown:Hide();
	NuNAHRankDropDown:Show();
	Classes = AClasses;
	Races = ARaces;
	Ranks = ARanks;
	NuNHFlag:Hide();
	NuNAFlag:Show();
end


function NuN_CheckPartyByName(parmN)
	local partym;

	for groupIndex = 1, NUN_MAX_PARTY_MEMBERS, 1 do
 		if (GetPartyMember(groupIndex)) then
 			partym = "party"..groupIndex;
 			lName = UnitName(partym);
 			if ( lName == parmN) then
 				return partym;
 			end
 		end
	end
	return nil;
end

function NuN_CheckRaidByName(parmN)
	local raidm;
	local lclName;
	local numRaid = GetNumRaidMembers();

	for raidIndex = 1, numRaid, 1 do
		lclName = GetRaidRosterInfo(raidIndex);
		if ( lclName == parmN ) then
			raidm = "raid"..raidIndex;
			return raidm;
		end
	end
	return nil;
end



function NuN_GetCText(gLclName)
	local txtIndex;
	local catText;

	catText = "";
	if ( NuNData[pKey][gLclName][txtTxt] ) then
		catText = NuNData[pKey][gLclName][txtTxt];
	end
	for i = 1, NUN_MAX_ADD_TXT, 1 do
		txtIndex = txtTxt..i;
		if ( NuNData[pKey][gLclName][txtIndex] ) then
			catText = catText..NuNData[pKey][gLclName][txtIndex];
		end
	end
	return catText;
end



function NuN_GetGText(gLclNote)
	local txtIndex;
	local catText;

	catText = "";
	if ( ( NuNData[pKey][Notes][gLclNote] ) and ( NuNData[pKey][Notes][gLclNote][txtTxt] ) ) then
		catText = NuNData[pKey][Notes][gLclNote][txtTxt];
	elseif ( ( NuNData[Notes][gLclNote] ) and ( NuNData[Notes][gLclNote][txtTxt] ) ) then
		catText = NuNData[Notes][gLclNote][txtTxt];
	end
	for i = 1, NUN_MAX_ADD_TXT, 1 do
		txtIndex = txtTxt..i;
		if ( ( NuNData[pKey][Notes][gLclNote] ) and ( NuNData[pKey][Notes][gLclNote][txtIndex] ) ) then
			catText = catText..NuNData[pKey][Notes][gLclNote][txtIndex];
		elseif ( ( NuNData[Notes][gLclNote] ) and ( NuNData[Notes][gLclNote][txtIndex] ) ) then
			catText = catText..NuNData[Notes][gLclNote][txtIndex];
		end
	end
	return catText;
end



function NuN_SetCText(sLclName)
	local cLower;
	local cUpper;
	local txtIndex;

	c_text_len = string.len(c_text);
	if ( c_text_len < NUN_MAX_TXT_CHR ) then
		cUpper = c_text_len;
	else
		cUpper = NUN_MAX_TXT_CHR;
	end
	NuNData[pKey][sLclName][txtTxt] = string.sub(c_text, 1, cUpper);
	for i = 1, NUN_MAX_ADD_TXT, 1 do
		cLower = NUN_MAX_TXT_CHR * i;
		txtIndex = txtTxt..i;
		if ( c_text_len > cLower ) then
			cLower = cLower + 1;
			cUpper = NUN_MAX_TXT_CHR * ( i + 1 );
			if ( c_text_len < cUpper ) then
				cUpper = c_text_len;
			end
			NuNData[pKey][sLclName][txtIndex] = string.sub(c_text, cLower, cUpper);
		else
			NuNData[pKey][sLclName][txtIndex] = "";
		end
	end
end



function NuN_SetGText(saveLvl)
	local cLower;
	local cUpper;
	local txtIndex;

	g_text_len = string.len(g_text);
	if ( g_text_len < NUN_MAX_TXT_CHR ) then
		cUpper = g_text_len;
	else
		cUpper = NUN_MAX_TXT_CHR;
	end

	if ( saveLvl == "Realm" ) then
		NuNData[pKey][Notes][c_note][txtTxt] = string.sub(g_text, 1, NUN_MAX_TXT_CHR);
		for i = 1, NUN_MAX_ADD_TXT, 1 do
			cLower = NUN_MAX_TXT_CHR * i;
			txtIndex = txtTxt..i;
			if ( g_text_len > cLower ) then
				cLower = cLower + 1;
				cUpper = NUN_MAX_TXT_CHR * ( i + 1 );
				if ( g_text_len < cUpper ) then
					cUpper = g_text_len;
				end
				NuNData[pKey][Notes][c_note][txtIndex] = string.sub(g_text, cLower, cUpper);
			else
				NuNData[pKey][Notes][c_note][txtIndex] = "";
			end
		end
	else
		NuNData[Notes][c_note][txtTxt] = string.sub(g_text, 1, NUN_MAX_TXT_CHR);
		for i = 1, NUN_MAX_ADD_TXT, 1 do
			cLower = NUN_MAX_TXT_CHR * i;
			txtIndex = txtTxt..i;
			if ( g_text_len > cLower ) then
				cLower = cLower + 1;
				cUpper = NUN_MAX_TXT_CHR * ( i + 1 );
				if ( g_text_len < cUpper ) then
					cUpper = g_text_len;
				end
				NuNData[Notes][c_note][txtIndex] = string.sub(g_text, cLower, cUpper);
			else
				NuNData[Notes][c_note][txtIndex] = "";
			end
		end
	end
end



function NuN_TextWarning(box, tLabel)
	local lenTxt, lenTxtL, oLabel;

	lenTxt = box:GetText();
	lenTxtL = string.len(lenTxt);
	oLabel = getglobal(tLabel);
	if ( ( lenTxtL == nil ) or ( lenTxtL == 0 ) ) then
		oLabel:SetText("0 / "..NUN_MAX_TXT_LIM);
	else
		oLabel:SetText(lenTxtL.." / "..NUN_MAX_TXT_LIM);
	end
	if ( lenTxtL > NUN_MAX_TXT_LIM ) then
		StaticPopup_Show("NUN_NOTELIMIT_EXCEEDED");
	end
end



function NuN_OptionsButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_MICROOPTIONS_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_MICROOPTIONS_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_BrowseButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_MICROBROWSEA_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_MICROBROWSEA_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_ContactButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_MICROCONTACT_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_MICROCONTACT_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_MICROCONTACT_TOOLTIP_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_GNoteButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_MICROGENNOTE_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_MICROGENNOTE_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_ResetButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_RESETBUTTON_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_RESETBUTTON_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_LocButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_LOCBUTTON_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_LOCBUTTON_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_GNoteTitle_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_GNOTETITLE_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_GNOTETITLE_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_SaveDefCheck_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_SAVEDEF_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_SAVEDEF_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_RestoreDefButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_RESTOREDEF_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_RESTOREDEF_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_RESTOREDEF_TOOLTIP_TXT3, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_RESTOREDEF_TOOLTIP_TXT4, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_TargetButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TARGETBUTTON_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TARGETBUTTON_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TARGETBUTTON_TOOLTIP_TXT3, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TARGETBUTTON_TOOLTIP_TXT4, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_NPCTargetButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_NPCTARGETBUTTON_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_NPCTARGETBUTTON_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_WhoButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_WHOBUTTON_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_WHOBUTTON_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_WHOBUTTON_TOOLTIP_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_UserButtons_OnEnter(owner)
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_USERBUTTON_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_USERBUTTON_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_USERBUTTON_TOOLTIP_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_ClearDD_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_CLEARDD_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_CLEARDD_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end


function NuN_FFButton_OnEnter()
	NuN_FFButton_StateLit:Show();
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		NuN_Tooltip:SetOwner(this, "ANCHOR_RIGHT");
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_FFBUTTON_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_FFBUTTON_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end


function NuNMapNoteButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_MAPNOTES_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_MAPNOTES_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_MAPNOTES_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_PinnedTT_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_PIN_EDIT_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_PIN_EDIT_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_PIN_EDIT_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_OpenChat_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_OPENCHAT_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_OPENCHAT_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_OPENCHAT_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end


function NuN_GNoteButtonDelete_OnEnter()
	if ( ( NuNSettings[pKey].toolTips ) and ( NuNGNoteFrame.fromQuest ) ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_GDELETE_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_GDELETE_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_GDELETE_TXT3, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_GDELETE_TXT4, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end



function NuN_FFButton_OnLeave()
	NuN_FFButton_StateLit:Hide();
	NuN_Tooltip:Hide();
end

function NuN_TTButton_OnLeave()
	NuN_Tooltip:Hide();
end

function NuN_ToggleToolTips()
	if ( NuNSettings[pKey].toolTips ) then
		NuNSettings[pKey].toolTips = nil;
	else
		NuNSettings[pKey].toolTips = "1";
	end
end



function NuN_NPCInfo()
	local NPCInfo = "";
	local NPCloc;
	local NPCtimed;
	local someInfo = false;
	local listText = nil;

	NPClvl = UnitLevel("target");
	NPCcls = UnitClass("target");
	NPCclsXtra = UnitClassification("target");
	NPCtype = UnitCreatureType("target");
	NPCsex = UnitSex("target");
	if ( NPClvl ~= nil ) then
		if ( NPClvl == -1 ) then
			NPCInfo = NUN_LEVEL.." : ??     ";
		else
			NPCInfo = NUN_LEVEL.." : "..NPClvl.."     ";
		end
	end
	if ( NPCcls ~= nil ) then
		NPCInfo = NPCInfo..NUN_CLASS.." : "..NPCcls..",  ";
	end
	if ( NPCsex ~= nil ) then
		local sex = Sexes[NPCsex + 1];
		if ( sex ) then
			NPCInfo = NPCInfo..sex..",  ";
		end
	end
	if ( NPCtype ~= nil ) then
		NPCInfo = NPCInfo..NPCtype.."     ";
	end
	if ( NPCclsXtra ~= "normal" ) then
		NPCInfo = NPCInfo..( string.upper(NPCclsXtra) );
	end

	GameTooltip:SetUnit("target");
	NPCprof = GameTooltipTextLeft2:GetText();
	if ( ( string.find(NPCprof, NUN_LEVEL) or ( NPCprof == nil ) ) ) then
		-- skip
	else
		NPCInfo = NPCInfo.."\n"..NUN_PROF.." : "..NPCprof.."    ";
	end

	NPCtimed = NuN_GetDateStamp();
	NPCloc = NuN_GetLoc();

	NPCInfo = NPCInfo.."\n\n"..NPCtimed.."\n"..NPCloc;

	if ( MerchantFrame:IsVisible() ) then
		listText = NuN_BuildShoppingList();
	end

	if ( listText ) then
		NPCInfo = NPCInfo.."\n\n"..listText;
	end

	return NPCInfo;
end





function NuN_ShowFriendNote()
	local numFriends = GetNumFriends();
	if (numFriends ~= nil) and (numFriends > 0) then
		if ( FriendsFrame.selectedFriend ) then
			FriendsFrame.selectedFriend = GetSelectedFriend();
			c_name, discard, c_class, discard, connected = GetFriendInfo(FriendsFrame.selectedFriend);
			if ( c_class == "Unknown" ) then
				c_class = nil;
			end;
			c_race = nil;
			c_guild = nil;
			gRank = nil;
			gRankIndex = nil;
			gNote = nil;
			gOfficerNote = nil;
			c_route = "Friend";
			if ( horde ) then
				NuN_HordeSetup();
			else
				NuN_AllianceSetup();
			end
			NuN_ShowNote();
		end
	end
end



function NuN_ShowIgnoreNote()
	local numIgnores = GetNumIgnores();
	if (numIgnores ~= nil) and (numIgnores > 0) then
		if ( FriendsFrame.selectedIgnore ) then
			FriendsFrame.selectedIgnore = GetSelectedIgnore();
			c_name = GetIgnoreName(FriendsFrame.selectedIgnore);
			c_class = nil;
			c_race = nil;
			c_guild = nil;
			gRank = nil;
			gRankIndex = nil;
			gNote = nil;
			gOfficerNote = nil;
			c_route = "Ignore";
			if ( horde ) then
				NuN_HordeSetup();
			else
				NuN_AllianceSetup();
			end
			NuN_ShowNote();
		end
	end
end



function NuN_ShowGuildNote()
	local numGuildMembers = GetNumGuildMembers();
	if (numGuildMembers ~= nil) and (numGuildMembers > 0) then
		c_class = nil;
		c_race = nil;
		c_name, gRank, gRankIndex, discard, c_class, discard, discard, gNote, gOfficerNote, discard = GetGuildRosterInfo( GetGuildRosterSelection() );
		if ( c_name ~= nil ) then
			c_guild = GetGuildInfo("player");
			c_route = "Guild";
			if ( horde ) then
				NuN_HordeSetup();
			else
				NuN_AllianceSetup();
			end
			NuN_ShowNote();
		end
	end
end


function NuN_UpdateNoteButton(nBttn, nBttnID, NuN_rType)
	local bName = nBttn:GetName();
	local pBttnTxt, discard, qHeader;
	local bttnNoteHFlag = getglobal(bName.."FrameHFlag");
	local bttnNoteAFlag = getglobal(bName.."FrameAFlag");
	local bttnNoteNFlag = getglobal(bName.."FrameNFlag");
	local bttnNoteQFlag = getglobal(bName.."FrameQFlag");

	if ( NuN_rType == "A" ) then
		if ( FriendsListFrame:IsVisible() ) then
			NuN_rType = "F";
		elseif ( IgnoreListFrame:IsVisible() ) then
			NuN_rType = "I";
		elseif ( GuildPlayerStatusFrame:IsVisible() ) then
			NuN_rType = "G";
		elseif ( GuildStatusFrame:IsVisible() ) then
			NuN_rType = "GS";
		elseif ( WhoFrame:IsVisible() ) then
			NuN_rType = "W";
		elseif ( QuestFrame:IsVisible() ) then
			NuN_rType = NUN_QUEST_C;
		end
	end

	if ( ( FriendsFrame:IsVisible() ) and ( bttnNoteAFlag ) and ( bttnNoteHFlag ) and ( bttnNoteNFlag ) ) then
		pBttnTxt = NuN_GetName_FrameButton(nBttnID, NuN_rType);
		if ( NuNData[pKey][pBttnTxt] ) then
			if ( NuNData[pKey][pBttnTxt].faction == "Horde" ) then
				bttnNoteAFlag:Hide();
				bttnNoteNFlag:Hide();
				bttnNoteHFlag:Show();
			else
				bttnNoteHFlag:Hide();
				bttnNoteNFlag:Hide();
				bttnNoteAFlag:Show();
			end
		else
			bttnNoteAFlag:Hide();
			bttnNoteHFlag:Hide();
			bttnNoteNFlag:Show();
		end
	elseif ( ( QuestLogFrame:IsVisible() ) and ( bttnNoteQFlag ) and ( bttnNoteNFlag ) ) then
		local lOffset = nBttnID + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
		pBttnTxt, discard, discard, qHeader = GetQuestLogTitle(lOffset);
		if ( qHeader ) then
			nBttn:Hide();
		elseif ( pBttnTxt ) then
			nBttn:Show();
			if ( ( NuNData[pKey][Notes][pBttnTxt] ) or ( NuNData[Notes][pBttnTxt] ) ) then
				bttnNoteNFlag:Hide();
				bttnNoteQFlag:Show();
			else
				bttnNoteQFlag:Hide();
				bttnNoteNFlag:Show();
			end
		end
	end
end



function NuN_NoteButton_OnInteract(nBttnID, uAction)
	local pBttnTxt;
	local lOffset;
	local qLevel, qTag, qHeader, qCollapsed, qComplete;
	local qText = "";

	if ( FriendsListFrame:IsVisible() ) then
		pBttnTxt = NuN_GetName_FrameButton(nBttnID, "F");
		if ( uAction == "Click" ) then
			lOffset = FauxScrollFrame_GetOffset(FriendsFrameFriendsScrollFrame);
			SetSelectedFriend( (tonumber(nBttnID)+lOffset) );
			NuNOri_FriendsList_Update();
			if ( NuNData[pKey][pBttnTxt] ) then
				NuN_ShowSavedNote(pBttnTxt);
			else
				NuN_ShowFriendNote();
			end
		elseif ( uAction == "MouseOver" ) then
			ttName = pBttnTxt;
			NuN_StaticTT();
		end
	elseif ( IgnoreListFrame:IsVisible() ) then
		pBttnTxt = NuN_GetName_FrameButton(nBttnID, "I");
		if ( uAction == "Click" ) then
			lOffset = FauxScrollFrame_GetOffset(FriendsFrameIgnoreScrollFrame);
			SetSelectedIgnore( (tonumber(nBttnID)+lOffset) );
			NuNOri_IgnoreList_Update();
			if ( NuNData[pKey][pBttnTxt] ) then
				NuN_ShowSavedNote(pBttnTxt);
			else
				NuN_ShowIgnoreNote();
			end
		elseif ( uAction == "MouseOver" ) then
			ttName = pBttnTxt;
			NuN_StaticTT();
		end
	elseif ( GuildPlayerStatusFrame:IsVisible() ) then
		pBttnTxt = NuN_GetName_FrameButton(nBttnID, "G");
		if ( uAction == "Click" ) then
			GuildFrame.selectedGuildMember = getglobal("GuildFrameButton"..nBttnID).guildIndex;
			GuildFrame.selectedName = getglobal("GuildFrameButton"..nBttnID.."Name"):GetText();
			SetGuildRosterSelection(GuildFrame.selectedGuildMember);
			NuNNew_GuildStatus_Update();
			if ( NuNData[pKey][pBttnTxt] ) then
				NuN_ShowSavedNote(pBttnTxt);
			else
				NuN_ShowGuildNote();
			end
		elseif ( uAction == "MouseOver" ) then
			ttName = pBttnTxt;
			NuN_StaticTT();
		end
	elseif ( GuildStatusFrame:IsVisible() ) then
		pBttnTxt = NuN_GetName_FrameButton(nBttnID, "GS");
		if ( uAction == "Click" ) then
			GuildFrame.selectedGuildMember = getglobal("GuildFrameGuildStatusButton"..nBttnID).guildIndex;
			GuildFrame.selectedName = getglobal("GuildFrameGuildStatusButton"..nBttnID.."Name"):GetText();
			SetGuildRosterSelection(GuildFrame.selectedGuildMember);
			NuNOri_GuildStatus_Update();
			if ( NuNData[pKey][pBttnTxt] ) then
				NuN_ShowSavedNote(pBttnTxt);
			else
				NuN_ShowGuildNote();
			end
		elseif ( uAction == "MouseOver" ) then
			ttName = pBttnTxt;
			NuN_StaticTT();
		end
	elseif ( WhoFrame:IsVisible() ) then
		pBttnTxt = NuN_GetName_FrameButton(nBttnID, "W");
		if ( uAction == "Click" ) then
			WhoFrame.selectedWho = getglobal("WhoFrameButton"..nBttnID).whoIndex;
			WhoFrame.selectedName = getglobal("WhoFrameButton"..nBttnID.."Name"):GetText();
			NuNOri_WhoList_Update();
			if ( NuNData[pKey][pBttnTxt] ) then
				NuN_ShowSavedNote(pBttnTxt);
			else
				NuN_ShowWhoNote(pBttnTxt);
			end
		elseif ( uAction == "MouseOver" ) then
			ttName = pBttnTxt;
			NuN_StaticTT();
		end
	elseif ( QuestLogFrame:IsVisible() ) then
		lOffset = nBttnID + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
		pBttnTxt, qLevel, qTag, qHeader, qCollapsed, qComplete = GetQuestLogTitle(lOffset);
		c_note = pBttnTxt;
		if ( uAction == "Click" ) then
			QuestLog_SetSelection(lOffset);
			NuNOri_QuestLog_Update();
			if ( qHeader ) then
				qText = "";
			else
				NuNGNoteFrame.fromQuest = nil;
				if ( ( NuNData[pKey][Notes][c_note] ) or ( NuNData[Notes][c_note] ) ) then
					NuN_ShowSavedGNote();
				else
					if ( qLevel == nil ) then
						qLevel = "--";
					end
					if ( qTag == nil ) then
						qTag = "";
					end
					qText = "\n"..c_note.."     "..NUN_QLVL..qLevel.."     "..qTag.."     ".."\n\n"..NuN_BuildQuestText().."\n";
					if ( qHeader ) then
						c_type = NuNGet_CommandID(noteTypes, "   ");
					else
						c_type = NuNGet_CommandID(noteTypes, "QST");
					end
					NuN_ShowTitledGNote( qText );
				end
			end
		elseif ( uAction == "MouseOver" ) then
			ttName = c_note;
			NuN_StaticTT();
		end
	end
end



function NuN_GetName_FrameButton(lBttnID, NuN_rType)
	local lBttn, lBttnTxt;

	if ( NuN_rType == "F" ) then
		lBttn = getglobal("FriendsFrameFriendButton"..lBttnID.."ButtonTextNameLocation");
		lBttnTxt = lBttn:GetText();
		local pos = string.find(lBttnTxt, NUN_SEP);
		if ( string.find(lBttnTxt, NUN_OFF) ) then
			lBttnTxt = string.sub(lBttnTxt, 11, (pos - 1));
		else
			lBttnTxt = string.sub(lBttnTxt, 1, (pos - 1));
		end
	elseif ( NuN_rType == "I" ) then
		lBttn = getglobal("FriendsFrameIgnoreButton"..lBttnID.."ButtonTextName");
		lBttnTxt = lBttn:GetText();
	elseif ( NuN_rType == "G" ) then
		lBttn = getglobal("GuildFrameButton"..lBttnID.."Name");
		lBttnTxt = lBttn:GetText();
	elseif ( NuN_rType == "GS" ) then
		lBttn = getglobal("GuildFrameGuildStatusButton"..lBttnID.."Name");
		lBttnTxt = lBttn:GetText();
	elseif ( NuN_rType == "W" ) then
		lBttn = getglobal("WhoFrameButton"..lBttnID.."Name");
		lBttnTxt = lBttn:GetText();
	elseif ( NuN_rType == NUN_QUEST_C ) then
		lBttn = getglobal("QuestLogTitle"..lBttnID.."NormalText");
		lBttnTxt = lBttn:GetText();
	end

	return lBttnTxt;
end


function NuN_StaticTT()
	local storePinned = NuN_PinnedTooltip.type;

	NuN_Tooltip:ClearLines();
	NuN_PinnedTooltip.type = "Nil";
	NuN_BuildTT(NuN_Tooltip);
	NuN_PinnedTooltip.type = storePinned;
	NuN_Fade = "False";
	NuN_Tooltip:Show();
end


function NuN_BuildTT(nunTT)
	local lGuild = nil;
	local lGuildR = nil;
	local lprof = "";
	local tt = {};
	local tti = 0;
	local srchText, sStart, sStop, tipText;
	local lineCount = 0;
	local finalTipText;
	local txtLines;
	local NuN_trunc = false;
	local gttLines = 0;
	local ttLinesDiff = 0;
	local ttLen = NUN_TT_MAX;
	local ttLLen = NUN_TT_LEN;

	if ( ( NuNSettings[pKey].toolTips ) or ( nunTT == NuN_PinnedTooltip ) ) then
		if ( NuN_PinnedTooltip.type ~= "General" ) and ( NuN_PinnedTooltip.type ~= "QuestHistory" ) and ( NuNData[pKey][ttName] ) then
			nunTT:AddLine(NUN_NOTESUNEED_INFO..NUN_PINNED_TT_PADDING, 1, 0.7, 0);
			lineCount = lineCount + 1;

			if ( NuN_PinUpHeader == true ) then
				nunTT:AddLine(ttName);
				lastPinned = ttName;
				lineCount = lineCount + 1;
			end

			for n = 1, uBttns, 1 do
				hdNbr = pHead..n
				nameHdNbr = ttName..hdNbr;
				nameDtNbr = ttName..pDetl..n;
				if ( ( (n == 1) and (not NuNData[pKey][nameHdNbr]) ) or ( (n==1) and ( NuNData[pKey][nameHdNbr].txt == dfltHeadings[n] ) ) ) then
					if ( NuNData[pKey][nameDtNbr] ) then
						lGuild = NuNData[pKey][nameDtNbr].txt;
					end
				elseif ( ( (n == 2) and (not NuNData[pKey][nameHdNbr]) ) or ( (n==2) and ( NuNData[pKey][nameHdNbr].txt == dfltHeadings[n] ) ) ) then
					if ( NuNData[pKey][nameDtNbr] ) then
						lGuildR = NuNData[pKey][nameDtNbr].txt;
					end
				elseif ( NuNData[pKey][nameHdNbr] ) then
					local ttDetl = (string.lower(NuNData[pKey][nameHdNbr].txt));
					if ( string.find(ttDetl, NUN_TT_HDNG) ) then
						if ( NuNData[pKey][nameDtNbr] ) then
							tti = tti + 1;
							tt[tti] = NuNData[pKey][nameDtNbr].txt;
						end
					end
				elseif ( NuNSettings[pKey][hdNbr] ) then
					local ttDetl = (string.lower(NuNSettings[pKey][hdNbr].txt));
					if ( string.find(ttDetl, NUN_TT_HDNG) ) then
						if ( NuNData[pKey][nameDtNbr] ) then
							tti = tti + 1;
							tt[tti] = NuNData[pKey][nameDtNbr].txt;
						end
					end
				end
			end

			for i = 1, getn(tt), 1 do
				nunTT:AddLine(tt[i], 0.9, 0.2, 0.2);
				lineCount = lineCount + 1;
			end

			if ( ( lGuild ~= nil) and ( lGuild ~= "" ) ) then
				if ( ( lGuildR ~= nil ) and ( lGuildR ~= "" ) ) then
					lGuild = lGuild.." : "..lGuildR;
				end
				nunTT:AddLine(lGuild, 0.9, 0.9, 0);
				lineCount = lineCount + 1;
			end

			if ( NuNData[pKey][ttName].prof1 ) then
				lprof = Professions[NuNData[pKey][ttName].prof1];
			end
			if ( NuNData[pKey][ttName].prof2 ) then
				if (lprof == "") then
					lprof = Professions[NuNData[pKey][ttName].prof2];
				else
					lprof = lprof.." - "..Professions[NuNData[pKey][ttName].prof2];
				end
			end
			if ( lprof ~= "" ) then
				nunTT:AddLine(lprof, 0.8, 0.2, 0.8);
				lineCount = lineCount + 1;
			end

			srchText = NuN_GetCText(ttName);
		elseif ( ( NuN_PinnedTooltip.type ~= "Contact" ) and ( NuN_PinnedTooltip.type ~= "QuestHistory" ) and ( ( NuNData[pKey][Notes][ttName] ) or ( NuNData[Notes][ttName] ) ) ) then
			nunTT:AddLine(NUN_NOTESUNEED_INFO..NUN_PINNED_TT_PADDING, 1, 0.7, 0);
			lineCount = lineCount + 1;

			if ( NuN_PinUpHeader == true ) then
				nunTT:AddLine(ttName);
				lastPinned = ttName;
				lineCount = lineCount + 1;
			end

			srchText = NuN_GetGText(ttName);
		elseif ( ( NuN_PinnedTooltip.type == "QuestHistory" ) and ( NuNData[pKey].QuestHistory[pName][ttName] ) ) then
			nunTT:AddLine(NUN_NOTESUNEED_INFO..NUN_PINNED_TT_PADDING, 1, 0.7, 0);
			lineCount = lineCount + 1;

			if ( NuN_PinUpHeader == true ) then
				nunTT:AddLine(ttName);
				lastPinned = ttName;
				lineCount = lineCount + 1;
			end

			srchText = NuNData[pKey].QuestHistory[pName][ttName].txt;
		end

		if ( NuN_PinnedTooltip.type ~= "QuestHistory" ) then
			if ( NuNSettings[pKey].ttLen ) then
				if ( NuNSettings[pKey].ttLen == "" ) then
					ttLen = 0;
				else
					ttLen = tonumber( NuNSettings[pKey].ttLen );
				end
			end
			if ( NuNSettings[pKey].ttLLen ) then
				if ( NuNSettings[pKey].ttLLen == "" ) then
					ttLLen = 0;
				else
					ttLLen = tonumber( NuNSettings[pKey].ttLLen );
				end
			end
		end

		if ( ( NuN_MouseOver == true ) and ( NuNSettings[pKey].minOver ) ) then
			srchText = "";
		end

		if ( ( srchText ~= nil ) and ( srchText ~= "" ) ) then
			sStart = string.find(srchText, NUN_TT_KEYPHRASE);
			if ( sStart ~= nil ) then
				sStart = sStart + NUN_TT_KEYPHRASE_LEN;
				sStop = string.find(srchText, NUN_TT_END, sStart);
				if ( sStop == nil ) then
					sStop = sStart + ttLen - 1;
				else
					sStop = sStop - 1;
					local sDiff = sStop - sStart;
					if ( ( sDiff > ttLen ) or ( sDiff < 0 ) ) then
						sStop = sStart + ttLen - 1;
						NuN_trunc = true;
					end
				end
				tipText = string.sub(srchText, sStart, sStop);
			else
				if ( string.len(srchText) > ttLen ) then
					NuN_trunc = true;
				end
				tipText = string.sub(srchText, 1, ttLen);
			end
			if ( string.len(tipText) > ttLLen ) then
				finalTipText, txtLines = NuN_ParseTT(tipText, ttLLen);
			else
				finalTipText = tipText;
				txtLines = 1;
			end
			if ( NuN_trunc == true ) then
				finalTipText = finalTipText..NUN_TT_ETC;
			end
			nunTT:AddLine(finalTipText, 0, 1, 0);
			lineCount = lineCount + txtLines;
		end

		local gttLines = GameTooltip:NumLines();
		local ttLinesDiff = lineCount - gttLines;
		if ( ttLinesDiff > NUN_TT_LINES_TRIGGER ) then
			local scaleUp = math.floor( 4 * (NuNSettings[pKey].tScale - 1) );
			NuN_TT_Y_Offset = ( ( ttLinesDiff - NUN_TT_LINES_TRIGGER ) * ( NUN_TT_Y_SHIFT + scaleUp ) );
			NuN_TT_Y_Offset = math.floor( NuN_TT_Y_Offset );
		end
	end
end


function NuN_ParseTT(txtIn, fragLen)
	local p1 = 0;
	local p2 = 0;
	local txtOut = "";
	local txtTmp = "";
	local xtraLines = "";
	local parsedLines = 1;

	while ( true ) do
		p2 = string.find(txtIn, "\n", ( p1 + 1 ) );
		if ( p2 == nil ) then
			break;
		end
		txtTmp = string.sub(txtIn, ( p1 + 1 ), p2);
		txtTmpL = string.len(txtTmp);
		if ( txtTmpL > ( fragLen + 10 ) ) then
			txtTmp, xtraLines = NuN_Fragment(txtTmp, fragLen);
		else
			xtraLines = 1;
		end
		p1 = p2;
		parsedLines = parsedLines + xtraLines;
		txtOut = txtOut..txtTmp;
	end
	txtTmp = string.sub(txtIn, ( p1 + 1 ) );
	txtTmpL = string.len(txtTmp);
	if ( txtTmpL > fragLen ) then
		txtTmp, xtraLines = NuN_Fragment(txtTmp, fragLen);
	else
		xtraLines = 1;
	end
	parsedLines = parsedLines + xtraLines;
	txtOut = txtOut..txtTmp;

	return txtOut, parsedLines;
end


function NuN_Fragment(txtWhole, fragLen)
	local p1 = 0;
	local p2 = 0;
	local lst = 0;
	local txtFrags = "";
	local count = 1;

	while ( true ) do
		p2 = string.find(txtWhole, " ", ( p1 + 1 ) )
		if ( p2 == nil ) then
			break
		end
		if ( p2 > ( lst + fragLen ) ) then
			lst = p1;
			txtFrags = txtFrags.."\n";
			count = count + 1;
		end
		txtFrags = txtFrags..string.sub(txtWhole, ( p1 + 1 ), p2);
		p1 = p2;
	end
	txtFrags = txtFrags..string.sub(txtWhole, ( p1 + 1 ) );

	return txtFrags, count;
end


function NuN_Tooltip_OnUpdate()
	if ( ( NuN_Fade == "True" ) and ( not UnitExists("mouseover") ) ) then
		local gt = GameTooltipTextLeft1:GetText();
		if ( gt ~= gtName ) then
			this:Hide();
			return;
		end
		if ( this.fadeStartTime == 0 ) then
			this.fadeStartTime = GetTime();
		end
		local elapsed = GetTime() - this.fadeStartTime;
		local fadeHoldTime = this.fadeHoldTime;
		local fadeOutTime = this.fadeOutTime;
		if ( elapsed >= ( fadeHoldTime + fadeOutTime ) ) then
			this:ClearLines();
			this:Hide();
		elseif  ( elapsed > fadeHoldTime ) then
			local alpha = 1 - ( ( elapsed - fadeHoldTime ) / fadeOutTime );
			this:SetAlpha(alpha);
		end
	end
end


function NuN_FFButton_OnShow()
	NuN_FFButton_Up();
end


function NuN_FFButton_Down()
	if ( pFaction == "Horde" ) then
		NuN_FFButton_StateADown:Hide();
		NuN_FFButton_StateAUp:Hide();
		NuN_FFButton_StateHUp:Hide();
		NuN_FFButton_StateHDown:Show();
	else
		NuN_FFButton_StateHDown:Hide();
		NuN_FFButton_StateHUp:Hide();
		NuN_FFButton_StateAUp:Hide();
		NuN_FFButton_StateADown:Show();
	end

	if ( FriendsListFrame:IsVisible() ) then
		NuN_ShowFriendNote();
	elseif ( IgnoreListFrame:IsVisible() ) then
		NuN_ShowIgnoreNote();
	elseif ( GuildPlayerStatusFrame:IsVisible() ) then
		NuN_ShowGuildNote();
	elseif ( GuildStatusFrame:IsVisible() ) then
		NuN_ShowGuildNote();
	elseif ( WhoFrame:IsVisible() ) then
		if ( WhoFrame.selectedName ) then
			NuN_ShowWhoNote(WhoFrame.selectedName);
		end
	elseif ( RaidFrame:IsVisible() ) then
		local tstValue = NuN_CheckTarget();
		if ( UnitInRaid("target") ) then
			c_name = UnitName("target");
			if ( NuNData[pKey][c_name] ) then
				NuN_ShowSavedNote(c_name);
			else
				NuN_NewContact("target");
			end
		end
	end
end

function NuN_FFButton_Up()
	if ( pFaction == "Horde" ) then
		NuN_FFButton_StateADown:Hide();
		NuN_FFButton_StateAUp:Hide();
		NuN_FFButton_StateHDown:Hide();
		NuN_FFButton_StateHUp:Show();
	else
		NuN_FFButton_StateHDown:Hide();
		NuN_FFButton_StateHUp:Hide();
		NuN_FFButton_StateADown:Hide();
		NuN_FFButton_StateAUp:Show();
	end
end



function NuN_GNoteTitle_OnClick()
	NuN_ClearPinnedTT();
	NuNGTTCheckBoxLabel:Hide();
	NuN_GTTCheckBox:Hide();
	NuNGNoteTextBox:SetText( NuNGNoteTitleButtonText:GetText() );
	NuNGNoteTitleButton:Hide();
	NuNGNoteTextBox:Show();
	NuNGNoteTextBox:SetFocus();
end

function NuN_GNoteTitleSet()
	NuNGNoteTitleButtonText:SetText( NuNGNoteTextBox:GetText() );
	NuNGNoteTextBox:Hide();
	NuNGNoteTitleButton:Show();
end


function NuN_GetSimpleName(cmplxName)
	local smplName, posB, posE;

	posB = string.find(cmplxName, "|h");
	posE = string.find(cmplxName, "]|h");
	if ( posB ~= nil ) and ( posE ~= nil ) and ( posB < posE ) then
		smplName = string.sub(cmplxName, (posB + 3), (posE - 1));
		return smplName
	else
		return nil;
	end
end


function NuN_GetLink(cmplxName)
	local link, posB, posE;

	posB = string.find(cmplxName, "|Hitem:");
	posE = string.find(cmplxName, "|h");
	if ( posB ~= nil ) and ( posE ~= nil ) and ( posB < posE ) then
		link = string.sub(cmplxName, (posB + 2), (posE - 1));
		return link;
	else
		return nil;
	end
end


function NuN_GNoteExists(tstNote)
	local cmplxName;

	if ( ( NuNData[pKey][Notes][tstNote] ) or ( NuNData[Notes][tstNote] ) ) then
		c_note = tstNote;
		return true;
	elseif ( NuNData[itmIndex][tstNote] ) then
		cmplxName = NuNData[itmIndex][tstNote];
		if ( ( NuNData[pKey][Notes][cmplxName] ) or ( NuNData[Notes][cmplxName] ) ) then
			c_note = cmplxName;
			return true;
		end
	end
	c_note = nil;
	return false;
end


function NuN_DeleteItem(toDelete)
	local index;
	local value;

	for index, value in NuNData[itmIndex] do
		if ( NuNData[itmIndex][index] == toDelete ) then
			NuNData[itmIndex][index] = nil;
			return;
		end
	end
end



function NuN_GameTooltip_OnShow()
	local storePinned = NuN_PinnedTooltip.type;
	local p1 = 1;
	local strippedName = "";
	local sNLen = 0;
	local anchorBy, anchorTo;

	local tx, ty;
	tx, ty = GameTooltip:GetCenter();
	if ( ( not tx ) or ( not ty ) ) then
		noTipAnchor = true;
		return;
	end

	gtName = GameTooltipTextLeft1:GetText();
	if ( not UnitExists("mouseover") ) then
		sNLen = string.len(gtName);
		for i=sNLen, 1, -1 do
			local tstChar = string.sub(gtName, i, i);
			if ( tstChar == " " ) then
				p1 = i + 1;
				break;
			end
		end
		strippedName = string.sub(gtName, p1);
		if ( NuNData[pKey][strippedName] ) then
			gtName = strippedName;
		end
	end

	if ( ( UnitExists("mouseover") ) or ( ( RaidFrame:IsVisible() ) and ( MouseIsOver(RaidFrame) ) ) or ( ( TargetFrame:IsVisible() ) and ( MouseIsOver(TargetFrame) ) ) ) then
		if ( UnitExists("mouseover") ) then
			ttName = UnitName("mouseover");
			NuN_Fade = "True";
		else
			ttName = gtName;
			NuN_Fade = "False";
		end
		if ( ( ttName ~= nil ) and ( ( NuNData[pKey][ttName] ) or ( NuNData[pKey][Notes][ttName] ) or ( NuNData[Notes][ttName] ) ) ) then
			anchorBy, anchorTo = NuN_GetTipAnchor(GameTooltip);
			NuN_Tooltip:Hide();
			NuN_Tooltip:SetOwner(this, "ANCHOR_NONE");
			NuN_TT_Y_Offset = 0;
			NuN_PinnedTooltip.type = "Nil";
			NuN_MouseOver = true;
			NuN_BuildTT(NuN_Tooltip);
			NuN_MouseOver = false;
			NuN_PinnedTooltip.type = storePinned;
			NuN_Tooltip:SetPoint(anchorBy, "GameTooltip", anchorTo, -1, 0);
			NuN_Tooltip:Show();
		else
			NuN_Tooltip:ClearLines();
			NuN_Tooltip:Hide();
		end
	else
		ttName = gtName;
		if ( NuNData[itmIndex][ttName] ) then
			ttName = ( NuNData[itmIndex][ttName] );
		end
		if ( ( ttName ~= nil ) and  ( ( NuNData[pKey][ttName] ) or ( NuNData[pKey][Notes][ttName] ) or ( NuNData[Notes][ttName] ) ) ) then
			NuN_Fade = "False";
			NuN_Tooltip:ClearLines();
			NuN_Tooltip:Hide();
			NuN_Tooltip:SetOwner(this, "ANCHOR_NONE");
			NuN_TT_Y_Offset = 0;
			NuN_PinnedTooltip.type = "Nil";
			NuN_BuildTT(NuN_Tooltip);
			NuN_PinnedTooltip.type = storePinned;
			local num1 = ShoppingTooltip1:NumLines();
			local num2 = ShoppingTooltip2:NumLines();
			if ( num2 and ( num2 > 0 ) and ShoppingTooltip2 and MerchantFrame and ( MerchantFrame:IsVisible() ) and ( MouseIsOver(MerchantFrame) ) ) or ( num2 and ( num2 > 0 ) and ShoppingTooltip2 and AuctionFrame and ( AuctionFrame:IsVisible() ) and ( MouseIsOver(AuctionFrame) ) ) then
				anchorBy, anchorTo = NuN_GetTipAnchor(ShoppingTooltip2);
				NuN_Tooltip:SetPoint(anchorBy, "ShoppingTooltip2", anchorTo, 0, 0);
			elseif ( num1 and ( num1 > 0 ) ) and ( ShoppingTooltip1 and MerchantFrame and ( MerchantFrame:IsVisible() ) and ( MouseIsOver(MerchantFrame) ) ) or ( num1 and ( num1 > 0 ) ) and ( ShoppingTooltip1 and AuctionFrame and ( AuctionFrame:IsVisible() ) and ( MouseIsOver(AuctionFrame) ) ) then
				anchorBy, anchorTo = NuN_GetTipAnchor(ShoppingTooltip1);
				NuN_Tooltip:SetPoint(anchorBy, "ShoppingTooltip1", anchorTo, 0, 0);
			else
				anchorBy, anchorTo = NuN_GetTipAnchor(GameTooltip);
				NuN_Tooltip:SetPoint(anchorBy, "GameTooltip", anchorTo, 1, 0);
			end
			NuN_Tooltip:Show();
		else
			NuN_Tooltip:ClearLines();
			NuN_Tooltip:Hide();
		end
	end
end



function NuN_WorldMapTooltip_OnShow(id)
	local noPopup = true;
	local MapNoting = true;
	local nName = WorldMapTooltipTextLeft1:GetText();

	NuNPopup:Hide();
	if ( NuNData[itmIndex][nName] ) then
		nName = ( NuNData[itmIndex][nName] );
	end

	local MNCont = nil;
	local MNZone = nil;
	local NuN_Key = nil;
	MNCont = GetCurrentMapContinent();
	if ( MNCont == -1 ) then
		MNCont = GetRealZoneText();
		MNZone = 0;
	else
		if  ( MetaMapNotes_OnLoad ) then
			MNZone = MetaMapNotes_ZoneShift[MNCont][GetCurrentMapZone()];
		elseif ( MapNotes_OnLoad ) then
			MNZone = MapNotes_ZoneShift[MNCont][GetCurrentMapZone()];
		else
			MapNoting = nil;
		end
		if ( ( MapNoting ) and ( ( not MNZone ) or ( MNZone < 1 ) ) ) then
			return;
		end
	end

	if ( id ) then
		NuN_Key = MNCont.."-"..MNZone.."-"..id;
	end

	if ( NuN_Key ) then
		if ( ( NuNData[mrgIndex] ) and ( NuNData[mrgIndex][NuN_Key] ) ) then
			local index, value, lBttn, lHeight;
			local lWidth = NuNPopupTitle:GetWidth();
			local lCount = 0;
			NuNPopupButton1:SetText("");
			NuNPopupButton1:Hide();
			NuNPopupButton2:SetText("");
			NuNPopupButton2:Hide();
			NuNPopupButton3:SetText("");
			NuNPopupButton3:Hide();
			NuNPopupButton4:SetText("");
			NuNPopupButton4:Hide();
			NuNPopupButton5:SetText("");
			NuNPopupButton5:Hide();
			for index, value in NuNData[mrgIndex][NuN_Key] do
				if ( index ~= "noteCounter" ) then
					if ( ( NuNData[Notes][index] ) or ( NuNData[pKey][Notes][index] ) ) then
						lCount = lCount + 1;
						lBttn = getglobal("NuNPopupButton"..lCount);
						lBttn.note = index;
						lBttn:SetText(index);
						lBttn:Show();
						local tWidth = lBttn:GetTextWidth();
						if ( ( tWidth ) and ( tWidth > lWidth ) ) then
							lWidth = tWidth;
						end
					end
				end
			end
			if ( lCount > 0 ) then
				local lHeight = math.ceil( ((20*(lCount + 1)) + 10) );
				lWidth = math.ceil( (lWidth) * 1.15 );
				if ( lCount > 2 ) then
					lHeight = lHeight - (lCount * lCount);
				end
				NuNPopup:SetHeight(lHeight);
				NuNPopup:SetWidth(lWidth);
				NuNPopupButton1:SetWidth(lWidth - 4);
				NuNPopupButton2:SetWidth(lWidth - 4);
				NuNPopupButton3:SetWidth(lWidth - 4);
				NuNPopupButton4:SetWidth(lWidth - 4);
				NuNPopupButton5:SetWidth(lWidth - 4);
				NuNPopup:ClearAllPoints();
				NuNPopup.id = id;
				local x, y = GetCursorPosition();
				if ( y > 300 ) then
					if ( x > 500 ) then
						NuNPopup:SetPoint("TOPRIGHT", "WorldMapTooltip", "BOTTOMRIGHT", 0, 0);
						NuNPopup.point = "TOPRIGHT";
						NuNPopup.relativePoint = "BOTTOMRIGHT";
					else
						NuNPopup:SetPoint("TOPLEFT", "WorldMapTooltip", "BOTTOMLEFT", 0, 0);
						NuNPopup.point = "TOPLEFT";
						NuNPopup.relativePoint = "BOTTOMLEFT";
					end
				else
					if ( x > 500 ) then
						NuNPopup:SetPoint("BOTTOMRIGHT", "WorldMapTooltip", "TOPRIGHT", 0, 0);
						NuNPopup.point = "BOTTOMRIGHT";
						NuNPopup.relativePoint = "TOPRIGHT";
					else
						NuNPopup:SetPoint("BOTTOMLEFT", "WorldMapTooltip", "TOPLEFT", 0, 0);
						NuNPopup.point = "BOTTOMLEFT";
						NuNPopup.relativePoint = "TOPLEFT";
					end
				end
				NuNPopupTitle:SetTextColor(0.1, 0.9, 0.1, 0.9);
				popUpHide = nil;
				NuNPopup:SetAlpha(1);
				NuNPopup:Show();
				NuN_MapTooltipShow(NuNPopupButton1.note, "NuNPopup", NuNPopup.point, NuNPopup.relativePoint);
				NuNPopupButton1:LockHighlight();
				noPopup = nil;
			end
		end
	end

	if ( noPopup ) then
		if ( ( NuNData[pKey][nName] ) or ( NuNData[pKey][Notes][nName] ) or ( NuNData[Notes][nName] ) ) then
			NuN_MapTooltipShow(nName, "WorldMapTooltip", nil, nil);
		end
	end
end


function NuN_MapTooltipShow(nName, relativeTo, point, relativePoint)
	local storePinned = NuN_PinnedTooltip.type;

	NuNPopupButton1:UnlockHighlight();
	if ( not nName ) then
		return;
	end
	gtName = nName;
	ttName = gtName;
	if ( ( ttName ~= nil ) and  ( ( NuNData[pKey][ttName] ) or ( NuNData[pKey][Notes][ttName] ) or ( NuNData[Notes][ttName] ) ) ) then
		NuN_Fade = "False";
		NuN_MapTooltip:ClearLines();
		NuN_MapTooltip:Hide();
		NuN_MapTooltip:SetOwner(this, "ANCHOR_NONE");
		NuN_PinnedTooltip.type = "Nil";
		NuN_BuildTT(NuN_MapTooltip);
		NuN_PinnedTooltip.type = storePinned;
		if ( ( point ) and ( relativePoint ) ) then
			NuN_MapTooltip:SetPoint(point, relativeTo, relativePoint, 0, 0);
		else
			local x, y = GetCursorPosition();
			if ( y > 300 ) then
				if ( x > 500 ) then
					NuN_MapTooltip:SetPoint("TOPRIGHT", "WorldMapTooltip", "BOTTOMRIGHT", 0, 0);
				else
					NuN_MapTooltip:SetPoint("TOPLEFT", "WorldMapTooltip", "BOTTOMLEFT", 0, 0);
				end
			else
				if ( x > 500 ) then
					NuN_MapTooltip:SetPoint("BOTTOMRIGHT", "WorldMapTooltip", "TOPRIGHT", 0, 0);
				else
					NuN_MapTooltip:SetPoint("BOTTOMLEFT", "WorldMapTooltip", "TOPLEFT", 0, 0);
				end
			end
		end
		NuN_MapTooltip:SetFrameLevel( WorldMapTooltip:GetFrameLevel() );
		NuN_MapTooltip:Show();
	else
		NuN_MapTooltip:ClearLines();
		NuN_MapTooltip:Hide();
	end
end


function NuN_WorldMapTooltip_OnHide()
	NuNPopup:Hide();
	NuN_MapTooltip:ClearLines();
	NuN_MapTooltip:Hide();
end





function NuN_ItemRefTooltip_OnShow()
	gtName = ItemRefTooltipTextLeft1:GetText();
	ttName = gtName;

	if ( NuNData[itmIndex][ttName] ) then
		ttName = ( NuNData[itmIndex][ttName] );
	end
	if ( ( ttName ~= nil ) and ( ( NuNData[pKey][Notes][ttName] ) or ( NuNData[Notes][ttName] ) ) ) then
		NuN_Fade = "False";
		NuN_ClearPinnedTT();
		NuN_PinnedTooltip:SetOwner(ItemRefTooltip, "ANCHOR_TOPLEFT");
		NuN_PinUpHeader = true;
		NuN_PinnedTooltip.type = "General";
		NuN_BuildTT(NuN_PinnedTooltip);
		NuN_PinUpHeader = false;
		NuN_PinnedTooltip:Show();
		pinnedTTMoved = false;
	elseif ( not pinnedTTMoved ) then
		NuN_ClearPinnedTT();
	end
end


function NuN_ItemRefTooltip_OnHide()
	if ( not pinnedTTMoved ) then
		NuN_ClearPinnedTT();
		pinnedTTMoved = true;
	end
end


function NuN_FlagMoved()
	pinnedTTMoved = true;
end


function NuN_GameTooltip_OnHide()
	noTipAnchor = nil;
	if ( NuN_Fade == "False" ) then
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:Hide();
	end
end


function NuN_TTCheckBox_OnClick(frameType)
	if ( frameType == "Contact" ) then
		if ( NuN_CTTCheckBox:GetChecked() ) then
			ttName = c_name;
			NuN_ClearPinnedTT();
			NuN_PinnedTooltip:SetOwner(this, ANCHOR_BOTTOMRIGHT);
			NuN_PinUpHeader = true;
			NuN_PinnedTooltip.type = frameType;
			NuN_BuildTT(NuN_PinnedTooltip);
			NuN_PinUpHeader = false;
			NuN_PinnedTooltip:Show();
		else
			NuN_ClearPinnedTT();
		end
	elseif ( frameType == "General" ) then
		if ( NuN_GTTCheckBox:GetChecked() ) then
			ttName = c_note;
			NuN_ClearPinnedTT();
			NuN_PinnedTooltip:SetOwner(this, ANCHOR_BOTTOMRIGHT);
			NuN_PinUpHeader = true;
			NuN_PinnedTooltip.type = frameType;
			NuN_BuildTT(NuN_PinnedTooltip);
			NuN_PinUpHeader = false;
			NuN_PinnedTooltip:Show();
		else
			NuN_ClearPinnedTT();
		end
	end
end

function NuN_TTCheckBox_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_PIN_TOOLTIP_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_PIN_TOOLTIP_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_PIN_TOOLTIP_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end


function NuN_ClearPinnedTT()
	if ( NuN_PinnedTooltip:IsVisible() ) then
		NuN_PinnedTooltip:ClearLines();
		NuN_PinnedTooltip:Hide();
	end
end


function NuN_CheckPinnedBox(tst)
	if ( NuN_PinnedTooltip:IsVisible() ) then
		if ( tst == lastPinned ) then
			return 1;
		else
			return 0;
		end
	else
		return 0;
	end
end



function NuN_PinnedTT_OnClick()
	local ttTitle = NuN_PinnedTooltipTextLeft2:GetText();

	if ( NuN_PinnedTooltip.type == "Contact" ) then
		if ( NuNData[pKey][ttTitle] ) then
			NuN_ShowSavedNote(ttTitle);
		end
	elseif ( NuN_PinnedTooltip.type == "General" ) then
		if ( NuNData[itmIndex][ttTitle] ) then
			ttTitle = NuNData[itmIndex][ttTitle];
		end
		if ( ( NuNData[pKey][Notes][ttTitle] ) or ( NuNData[Notes][ttTitle] ) ) then
			c_note = ttTitle;
			NuNGNoteFrame.fromQuest = nil;
			NuN_ShowSavedGNote();
		end
	end
end


function NuN_PinnedTT_OnHide()
	if ( NuN_PinnedTooltip.type == "Contact" ) then
		if ( ( NuNFrame:IsVisible() ) and ( NuN_CTTCheckBox:GetChecked() ) ) then
			NuN_CTTCheckBox:SetChecked(0);
		end
	elseif ( NuN_PinnedTooltip.type == "General" ) then
		if ( ( NuNGNoteFrame:IsVisible() ) and ( NuN_GTTCheckBox:GetChecked() ) ) then
			NuN_GTTCheckBox:SetChecked(0);
		end
	end
end


function NuN_OpenChat(noteType)
	local dspText, dspTextL;
	local hdrMax = 29;

	UIDropDownMenu_ClearAll(NuNChatDropDown);
	NuNTransmit:Disable();
	NuNChatTextBox:Hide();
	NuN_ChatFrame.type = noteType;
	if ( noteType == "Contact" ) then
		dspText = c_name;
		NuN_ChatCheckBox:Show();
	elseif ( noteType == "General" ) then
		dspText = c_note;
		NuN_ChatCheckBox:Hide();
	end
	if ( string.find(dspText, "|Hitem:") ) then
		hdrMax = hdrMax + 50;
	end
	dspTextL = string.len(dspText);
	if ( dspTextL > hdrMax ) then
		dspText = string.sub(dspText, 1, hdrMax).."...";
	end
	NuNChatNoteTitle:SetText(dspText);
	ShowUIPanel(NuN_ChatFrame);

end


function NuN_Transmit()
	local dfltLang;
	local user = nil;
	local error = nil;
	local singleLine;
	local parsedArray = {};
	local contents = nil;
	local linesInError = {};
	local nonCriticalError = false;
	local e = 0;
	local tLog = "Transmit Log ";
	local chatTarget;
	local prfx;
	local logText = "";
	local saveLvl;

	NuNTransmit:Disable();

	msgSeq = msgSeq + 1;
	if ( msgSeq > 9 ) then
		msgSeq = 1;
	end
	msgKey = pName..msgSeq..":";
	tLog = tLog..msgKey;

	if ( NuNSettings[pKey].dLevel ) then
		NuNData[Notes][tLog] = {};
		logText = NuN_GetDateStamp().."\n";
		NuNData[Notes][tLog].type = 3;
		saveLvl = "Account";
	else
		NuNData[pKey][Notes][tLog] = {};
		logText = NuN_GetDateStamp().."\n";
		NuNData[pKey][Notes][tLog].type = 3;
		saveLvl = "Realm";
	end

	if ( NuNChatTextBox:IsVisible() ) then
		user = NuNChatTextBox:GetText();
	end

	if ( sendTo == "WHISPER" ) or ( sendTo == "NuN" ) then
		chatTarget = user;
	else
		chatTarget = sendTo;
	end

	if ( horde ) then
		dfltLang = "Orcish";
	else
		dfltLang = "Common";
	end

	prfx = msgKey..NUN_TRANSMISSION_PREFIX1..pName.."  --->  "..chatTarget;
	logText = logText.."\n"..prfx;

	if ( NuN_ChatFrame.type == "Contact" ) then
		parsedArray, error = NuN_TransmitContact(dfltLang, user);
	else
		parsedArray, error = NuN_TransmitGeneral(dfltLang, user);
	end

	if ( parsedArray ) then
		local tmp_c_note = c_note;
		local tmp_g_text = g_text;
		contents = getn(parsedArray);
		local lineCount = 0;
		local flagged = nil;
		for i=1, contents, 1 do
			singleLine = parsedArray[i];
			singleLine = string.gsub(singleLine, "\n", " ");
			singleLine = string.gsub(singleLine, "\\n", " ");
			if ( string.len(singleLine) > 255 ) then
				error = "Err02";
				break;
			end
			local beginnings = NuN_Validate(singleLine, "|c");
			local endings = NuN_Validate(singleLine, "|h|r");
			if ( beginnings == endings ) then
				parsedArray[i] = singleLine;
				lineCount = lineCount + 1;
				if ( ( string.len(logText) < (NUN_MAX_TXT_LIM - 360) ) and ( lineCount < 109 ) ) then
					logText = logText.."\n"..singleLine;
				elseif ( not flagged ) then
					flagged = true;
					logText = logText.."\n"..NUN_NOROOM;
				end
			else
				parsedArray[i] = "";
				nonCriticalError = true;
				e = e + 1;
				linesInError[e] = NUN_LINEERROR_TEXT.."----->"..i.." : \n";
				e = e + 1;
				linesInError[e] = singleLine.."\n";
			end
		end
		c_note = tLog;
		g_text = logText;
		NuN_SetGText(saveLvl);
		c_note = tmp_c_note;
		g_text = tmp_g_text;
	end

	if ( contents ) and ( not error ) then
		if ( sendTo == "SELF" ) then
			DEFAULT_CHAT_FRAME:AddMessage(prfx);
		else
			SendChatMessage(prfx, sendTo, dfltLang, user);
		end
		for i=1, contents, 1 do
			if ( sendTo == "SELF" ) then
				DEFAULT_CHAT_FRAME:AddMessage(msgKey..parsedArray[i]);
			else
				SendChatMessage(msgKey..parsedArray[i], sendTo, dfltLang, user);
			end
		end
	elseif ( error ) then
		NuN_Message(NUN_TRANSMISSION_ERROR..error);
	else
		NuN_Message(NUN_TRANSMISSION_MISSING);
	end

	if ( nonCriticalError ) then
		if ( NuNSettings[pKey].dLevel ) then
			NuNData[Notes][msgKey] = {};
			NuNData[Notes][msgKey].txt = "";
		else
			NuNData[pKey][Notes][msgKey] = {};
			NuNData[pKey][Notes][msgKey].txt = "";
		end
		for i=1, getn(linesInError), 1 do
			if ( NuNSettings[pKey].dLevel ) then
				NuNData[Notes][msgKey].txt = NuNData[Notes][msgKey].txt..linesInError[i].."\n";
			else
				NuNData[pKey][Notes][msgKey].txt = NuNData[pKey][Notes][msgKey].txt..linesInError[i].."\n";
			end
		end
		NuN_Message(NUN_NONCRITICAL_ERROR..msgKey);
	end

	NuNTransmit:Enable();
end



function NuN_TransmitContact(dfltLang, user)
	local parsedArray = {};
	local singleLine = "";


	if ( NuNData[pKey][c_name] ) then
		local parsedArray = {};
		local singleLine = "";
		local arrayCounter = 1;
		local parseText = "";
		local txtArray = {};

		parsedArray[arrayCounter] = NUN_TRANSMISSION_PREFIX2.."Contact : "..c_name;

		if ( not NuN_ChatCheckBox:GetChecked() ) then
			singleLine = NuNData[pKey][c_name].faction.."  ";
			if ( NuNData[pKey][c_name].race ) then
				if ( horde ) then
					singleLine = singleLine..HRaces[NuNData[pKey][c_name].race].."  ";
				else
					singleLine = singleLine..ARaces[NuNData[pKey][c_name].race].."  ";
				end
			end
			if ( NuNData[pKey][c_name].cls ) then
				if ( horde ) then
					singleLine = singleLine..HClasses[NuNData[pKey][c_name].cls].."  ";
				else
					singleLine = singleLine..AClasses[NuNData[pKey][c_name].cls].."  ";
				end
			end
			if ( NuNData[pKey][c_name].sex ) then
				singleLine = singleLine..Sexes[NuNData[pKey][c_name].sex].."  ";
			end
			if ( NuNData[pKey][c_name].prof1 ) then
				singleLine = singleLine..Professions[NuNData[pKey][c_name].prof1].."  ";
			end
			if ( NuNData[pKey][c_name].prof2 ) then
				singleLine = singleLine..Professions[NuNData[pKey][c_name].prof2].."  ";
			end
			if ( NuNData[pKey][c_name].crank ) then
				if ( horde ) then
					singleLine = singleLine..HRanks[NuNData[pKey][c_name].crank].."  ";
				else
					singleLine = singleLine..ARanks[NuNData[pKey][c_name].crank].."  ";
				end
			end
			if ( NuNData[pKey][c_name].hrank ) then
				if ( horde ) then
					singleLine = singleLine..HRanks[NuNData[pKey][c_name].hrank].."  ";
				else
					singleLine = singleLine..ARanks[NuNData[pKey][c_name].hrank].."  ";
				end
			end

			if ( singleLine ~= "" ) then
				singleLine = "G:"..singleLine;
				arrayCounter = arrayCounter + 1;
				parsedArray[arrayCounter] = singleLine;
			end

			for n = 1, uBttns, 1 do
				singleLine = "";
				hdNbr = pHead..n;
				nameHdNbr = c_name..hdNbr;
				nameDtNbr = c_name..pDetl..n;
				if ( NuNData[pKey][nameHdNbr] ) then
					singleLine = NuNData[pKey][nameHdNbr].txt.."~    ";
				elseif ( NuNSettings[pKey][hdNbr] ) then
					singleLine = NuNSettings[pKey][hdNbr].txt.."~    ";
				else
					singleLine = dfltHeadings[n].."~    ";
				end
				if ( NuNData[pKey][nameDtNbr] ) then
					singleLine = singleLine.."~"..NuNData[pKey][nameDtNbr].txt;
				end
				if ( singleLine ~= "" ) then
					arrayCounter = arrayCounter + 1;
					singleLine = "U"..n..":"..singleLine;
					parsedArray[arrayCounter] = singleLine;
				end
			end
		end

--		parseText = NuN_GetCText(c_name);
		parseText = NuNText:GetText();
		txtArray = NuN_ParseNote(parseText);
		if ( txtArray ) then
			for i=1, getn(txtArray), 1 do
				arrayCounter = arrayCounter + 1;
				parsedArray[arrayCounter] = "T:"..txtArray[i];
			end
		end

		arrayCounter = arrayCounter + 1;
		parsedArray[arrayCounter] = NUN_TRANSMISSION_POSTFIX.."Contact : "..c_name;

		return parsedArray, nil;
	else
		return nil, "Err01";
	end
end



function NuN_TransmitGeneral(dfltLang, user)
	local ref = c_note;

	if ( NuNData[itmIndex][ref] ) then
		ref = NuNData[itmIndex][ref];
	end

	if ( ( NuNData[pKey][Notes][ref] ) or ( NuNData[Notes][ref] ) ) then
		local parsedArray = {};
		local singleLine = "";
		local arrayCounter = 1;
		local parseText = "";
		local txtArray = {};

		parsedArray[arrayCounter] = NUN_TRANSMISSION_PREFIX2.."General : "..c_note;

--		parseText = NuN_GetGText(c_note);
		parseText = NuNGNoteTextScroll:GetText();
		txtArray = NuN_ParseNote(parseText);
		if ( txtArray ) then
			for i=1, getn(txtArray), 1 do
				arrayCounter = arrayCounter + 1;
				parsedArray[arrayCounter] = "T:"..txtArray[i];
			end
		end

		arrayCounter = arrayCounter + 1;
		parsedArray[arrayCounter] = NUN_TRANSMISSION_POSTFIX.."General : "..c_note;

		return parsedArray, nil;
	else
		return nil, "Err01";
	end
end



function NuN_ParseNote(parseText)
	local parsedArray = {};
	local arrayCounter = 0;
	local p1 = 0;
	local p2 = 0;
	local txtTmp = "";

	parseText = NuN_RemoveColours(parseText);
	parseText = NuN_CheckHyperlinkPositions(parseText);

	local parseTextLen = string.len(parseText);
	local negOffset = -1 * (parseTextLen);

	while ( negOffset < 0 ) do
		p2 = string.find(parseText, "\n", (p1+1) );
		if ( ( p2 == nil ) or ( p2 > ( NUN_CHAT_LIMIT + p1 ) ) ) then
			negOffset = p1 + NUN_CHAT_LIMIT - parseTextLen;
			if ( negOffset < 0 ) then
				p2 = string.find(parseText, " ", negOffset);
				if ( ( p2 == nil ) or ( p2 <= p1 ) ) then
					txtTmp = string.sub(parseText, (p1+1), (p1+NUN_CHAT_LIMIT));
				else
					txtTmp = string.sub(parseText, (p1+1), p2);
				end
			else
				txtTmp = string.sub(parseText, (p1+1));
			end
		else
			txtTmp = string.sub(parseText, (p1+1), p2);
		end
		if ( p2 ) then
			p1 = p2;
		else
			p1 = parseTextLen;
		end
		if ( txtTmp ~= "" ) and ( txtTmp ~= " " ) then
			arrayCounter = arrayCounter + 1;
			parsedArray[arrayCounter] = txtTmp;
		end
	end

	return parsedArray;
end


function NuN_RemoveColours(colouredText)
	local gp1 = 0;
	local gp2a = 0;
	local gp2b = 0;
	local gp3 = 0;
	local plainText="";
	local malformed = false;
	local postfix = "";

	while ( true ) do
		gp2a = string.find(colouredText, "|c", (gp1+1));
		if ( gp2a == nil ) then
			break;
		else
			if ( gp2a ~= (gp1+1) ) then
				plainText = plainText..string.sub(colouredText, (gp1+1), (gp2a-1));
			end
			gp2b = string.find(colouredText, "|Hitem:", (gp1+1));
			gp3 = string.find(colouredText, "|h|r", gp2a);
			if ( gp3 == nil ) then
				malformed = true;
				break;
			end
			if ( gp2b == nil ) or ( gp2b > gp3 ) then
				plainText = plainText..string.sub(colouredText, (gp2a+12), (gp3-1));
			elseif ( (gp2b-gp2a) == 10 ) then
				plainText = plainText..string.sub(colouredText, gp2a, (gp3+3));
			else
				malformed = true;
				break;
			end
			gp1 = gp3 + 3;
		end
	end
	if ( not malformed ) then
		postfix = string.sub(colouredText, (gp1+1));
		if ( postfix ) then
			plainText = plainText..postfix;
		end
	else
		plainText = "";
		NuN_Message(NUN_COLOUR_ERROR_REPORT);
	end

	return plainText;
end


function NuN_Validate(txt, tst)
	local p1 = 0;
	local p2 = 0;
	local count = 0;

	while ( true ) do
		p2 = string.find(txt, tst, (p1+1));
		if ( p2 == nil ) then
			break;
		else
			count = count + 1;
			p1 = p2;
		end
	end

	return count;
end


function NuN_ChatCheckBox_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_CHATCHECK_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_CHATCHECK_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_CHATCHECK_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end



function NuN_CheckHyperlinkPositions(theText)
	local hypBegs = {};
	local p1 = 0;
	local p2 = 0;
	local counter = 0;
	local Begs = 0;
	local rtrnText = "";

	while ( true ) do
		p2 = string.find(theText, "|Hitem:", (p1+1) );
		if ( p2 == nil ) then
			break;
		else
			counter = counter + 1;
			hypBegs[counter] = p2 - 10;
			p1 = p2;
		end
	end

	if ( hypBegs ) then
		local base = 1;
		local preText = "";
		local len = 0;
		for i=1, getn(hypBegs), 1 do
			preText = string.sub(theText, base, (hypBegs[i] - 1));
			len = string.len(preText);
			local p3 = 0;
			local p4 = 0;
			p2 = nil;
			while ( true ) do
				p4 = string.find(preText, "\n", (p3+1));
				if ( p4 == nil ) then
					break;
				else
					p2 = p4;
					p3 = p4;
				end
			end
			if ( p2 == nil ) and ( len > 120 ) then
				rtrnText = rtrnText..preText.."\n";
				base = base + len;
			elseif ( p2 ) and ( (len - p2) > 120 ) then
				rtrnText = rtrnText..preText.."\n";
				base = base + len;
			elseif ( p2 ) then
				rtrnText = rtrnText..string.sub(theText, base, (base + p2));
				base = base + p2 + 1;
			end
		end
		rtrnText = rtrnText..string.sub(theText, base);
	end

	return rtrnText;
end



function NuN_Level_CheckBox_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_LEVEL_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_LEVEL_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_LEVEL_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end



function NuNGTypeDropDown_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_GTYPE_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_GTYPE_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_GTYPE_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end



function NuNScaleFrameButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_SCALE_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_SCALE_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_SCALE_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end



function NuN_NPCTarget()
	local chkName = UnitName("target");
	local npcText = "";

	if ( ( chkName ) and ( not UnitPlayerControlled("target") ) ) then
		npcText = NuN_NPCInfo();
		NuNGNoteTextScroll:SetText( NuNGNoteTextScroll:GetText().."\n"..npcText );
	end
end


function NuNScaleFrameShow()
	if ( NuN_ScaleFrame:IsVisible() ) then
		HideUIPanel(NuN_ScaleFrame);
	else
		ShowUIPanel(NuN_ScaleFrame);
	end
end


function NuNFrameScaleSlider_OnShow()
	local pScale = NuNSettings[pKey].pScale;

	NuNFrameScaleSliderCurrent:SetText( string.format("%d", (pScale * 100)) .. "%");
	this:SetMinMaxValues(NUN_FRAMESCALE_MIN, NUN_FRAMESCALE_MAX);
	this:SetValueStep(NUN_FRAMESCALE_STEP);
	this:SetValue(NUN_FRAMESCALE_MIN + NUN_FRAMESCALE_MAX - pScale);
	this.previousValue = this:GetValue();
end


function NuNFrameScaleSlider_OnValueChanged()
	local pScale;

	if (this:GetValue() ~= this.previousValue) then
		this.previousValue = this:GetValue();
		pScale = (NUN_FRAMESCALE_MIN + NUN_FRAMESCALE_MAX - this:GetValue());
		NuNSettings[pKey].pScale = pScale;
		NuNFrameScaleSliderCurrent:SetText( string.format("%d", (pScale * 100)) .. "%");
		if ( NuNOptionsFrame:IsVisible() ) then
			NuNOptionsFrame:SetScale(NuNSettings[pKey].pScale);
		end
		if ( NuNFrame:IsVisible() ) then
			NuNFrame:SetScale(NuNSettings[pKey].pScale);
		end
		if ( NuNGNoteFrame:IsVisible() ) then
			NuNGNoteFrame:SetScale(NuNSettings[pKey].pScale);
		end
		if ( NuNSearchFrame:IsVisible() ) then
			NuNSearchFrame:SetScale(NuNSettings[pKey].pScale);
		end
	end
end


function NuNFontScaleSlider_OnShow()
	local tScale = NuNSettings[pKey].tScale;

	NuNFontScaleSliderCurrent:SetText( string.format("%d", (tScale * 100)) .. "%");
	this:SetMinMaxValues(NUN_TT_FONTSCALE_MIN, NUN_TT_FONTSCALE_MAX);
	this:SetValueStep(NUN_FONTSCALE_STEP);
	this:SetValue(NUN_TT_FONTSCALE_MIN + NUN_TT_FONTSCALE_MAX - tScale);
	this.previousValue = this:GetValue();
end


function NuNFontScaleSlider_OnValueChanged()
	local tScale;

	if (this:GetValue() ~= this.previousValue) then
		this.previousValue = this:GetValue();
		tScale = (NUN_TT_FONTSCALE_MIN + NUN_TT_FONTSCALE_MAX - this:GetValue());
		NuNSettings[pKey].tScale = tScale;
		NuNFontScaleSliderCurrent:SetText( string.format("%d", (tScale * 100)) .. "%");
		NuN_PinnedTooltip:SetScale(NuNSettings[pKey].tScale);
		NuN_Tooltip:SetScale(NuNSettings[pKey].tScale);
	end
end


function NuNMapFontScaleSlider_OnShow()
	local mScale = NuNSettings[pKey].mScale;

	NuNMapFontScaleSliderCurrent:SetText( string.format("%d", (mScale * 100)) .. "%");
	this:SetMinMaxValues(NUN_TT_MAPFONTSCALE_MIN, NUN_TT_MAPFONTSCALE_MAX);
	this:SetValueStep(NUN_MAPFONTSCALE_STEP);
	this:SetValue(NUN_TT_MAPFONTSCALE_MIN + NUN_TT_MAPFONTSCALE_MAX - mScale);
	this.previousValue = this:GetValue();
end


function NuNMapFontScaleSlider_OnValueChanged()
	local mScale;

	if (this:GetValue() ~= this.previousValue) then
		this.previousValue = this:GetValue();
		mScale = (NUN_TT_MAPFONTSCALE_MIN + NUN_TT_MAPFONTSCALE_MAX - this:GetValue());
		NuNSettings[pKey].mScale = mScale;
		NuNMapFontScaleSliderCurrent:SetText( string.format("%d", (mScale * 100)) .. "%");
		mScale = UIParent:GetScale() * NuNSettings[pKey].mScale;
		WorldMapTooltip:SetScale(NuNSettings[pKey].mScale);
		NuN_MapTooltip:SetScale(NuNSettings[pKey].mScale);
		NuNPopup:SetScale(NuNSettings[pKey].mScale);
	end
end



function NuN_BuildQuestText()
	local numQuestRewards, numQuestChoices, numQuestSpellRewards;
	local QuestRewardMoney, QuestRequiredMoney;
	local qText = "\n";
	local obj, objTxt, objType, itm, itmTxt;
	local gold, silver, copper, moneyTxt;
	local tmpQText1 = "";
	local tmpQText2 = "";
	local questItem = "QuestLogItem";
	local error = false;

	numQuestRewards = GetNumQuestLogRewards();
	numQuestChoices = GetNumQuestLogChoices();
	if ( GetQuestLogRewardSpell() ) then
		numQuestSpellRewards = 1;
	end
	QuestRewardMoney = GetQuestLogRewardMoney();
	QuestRequiredMoney = GetQuestLogRequiredMoney();

	tmpQText1, tmpQText2 = GetQuestLogQuestText();
	qText = tmpQText2.."\n\n";

	if ( GetQuestLogTimeLeft() ) then
		qText = qText.."\nTimed Quest\n";
	end

	if ( QuestRequiredMoney ) and ( QuestRequiredMoney > 0 ) then
		if ( QuestRequiredMoney > 9999 ) then
			gold = ( QuestRequiredMoney / 10000 );
			gold = string.format("%d", gold);
			QuestRequiredMoney = QuestRequiredMoney - ( gold * 10000 );
		else
			gold = 0;
		end
		if ( QuestRequiredMoney > 99 ) then
			silver = ( QuestRequiredMoney / 100 );
			silver = string.format("%d", silver);
			QuestRequiredMoney = QuestRequiredMoney - ( silver * 100 );
		else
			silver = 0;
		end
		copper = QuestRequiredMoney;
		QuestRequiredMoneyTxt = string.format("\n%dg %ds %dc", gold, silver, copper);
		qText = qText..QuestRequiredMoneyTxt.."\n\n";
	end

	qText = qText.."\n\n"..tmpQText1.."\n";

	if ( ( QuestRewardMoney ) and ( QuestRewardMoney > 0 ) ) or ( numQuestRewards > 0 ) then
		qText = qText.."\n"..NUN_REWARDS.."\n";
	end

	if ( QuestRewardMoney ) and ( QuestRewardMoney > 0 ) then
		QuestRewardMoneyTxt = NuN_BuildMoneyString(QuestRewardMoney);
		qText = qText..QuestRewardMoneyTxt.."\n";
	end

	for i=1, numQuestRewards, 1 do
		bttn = getglobal("QuestLogItem"..i + numQuestChoices);
		if ( bttn.type ) then
			local link = GetQuestLogItemLink(bttn.type, bttn:GetID());
			if ( link ) then
				qText = qText..link.."\n";
			else
				link = GetQuestLogItemLink(bttn.type, ( i + numQuestChoices ) );
				if ( link ) then
					qText = qText..link.."\n";
				else
					error = true;
					qText = NUN_SLOWSERVER.." : NuN Err03";
					return qText, error;
				end
			end
		end
	end

	if ( numQuestChoices > 1 ) then
		qText = qText.."\n"..NUN_CHOICES.."\n";
	end

	for i=1, numQuestChoices, 1 do
		bttn = getglobal("QuestLogItem"..i);
		if ( bttn.type ) then
			local link = GetQuestLogItemLink(bttn.type, bttn:GetID());
			if ( link ) then
				if ( i > 1 ) then
					qText = qText.." / "..link;
				else
					qText = qText..link;
				end
			else
				link = GetQuestLogItemLink(bttn.type, i);
				if ( link ) then
					if ( i > 1 ) then
						qText = qText.." / "..link;
					else
						qText = qText..link;
					end
				else
					error = true;
					qText = NUN_SLOWSERVER.." : NuN Err03";
					return qText, error;
				end
			end
		end
	end

	if ( qText ) then
		qText = NuN_CleanQuestText(qText);
	end

	return qText, error;
end

function NuN_CheckQuestList(findName)
	local qTitle, qLevel, qTag, qHeader, qCollapsed, qComplete;
	local foundIndex = -1;
	local rLevel, rTag, rComplete;

	NuNQuestLog = {};

	for i = 1, GetNumQuestLogEntries(), 1 do
		qTitle, qLevel, qTag, qHeader, qCollapsed, qComplete = GetQuestLogTitle(i);
		if ( ( qTitle ) and ( not qHeader ) ) then
			NuNQuestLog[qTitle] = 1;
			if ( ( findName ) and ( findName == qTitle ) ) then
				foundIndex = i;
				rLevel = qLevel;
				rTag = qTag;
				rComplete = qComplete;
			end
		end
	end

	return foundIndex, rLevel, rTag, rComplete;
end

function NuN_UpdateQuestNotes(qEvent)
	local quest, qLevel, qTag, qHeader, qCollapsed, qComplete;

	qTriggs = 0;

	if ( pFaction ) then
		for qI=1, GetNumQuestLogEntries(), 1 do
			quest, qLevel, qTag, qHeader, qCollapsed, qComplete = GetQuestLogTitle(qI);
			if ( ( quest ) and ( not qHeader ) ) then
				NuN_ProcessQuest(quest, qLevel, qTag, qHeader, qCollapsed, qComplete, qI);
			end
		end
	end

	if ( qTriggs > 2 ) then
		timeSinceLastUpdate = 0;
		NuN_QuestsUpdating = "True";
	end
end

function NuN_ProcessQuest(quest, qLevel, qTag, qHeader, qCollapsed, qComplete, qI)
	local saveLvl = nil;
	local qText;
	local location = NuN_GetLoc();

	local l_c_note = c_note;
	local l_g_text = g_text;
	local l_c_name = c_name;

	if ( ( NuNData[pKey].QuestHistory[pName][quest] ) and ( NuNData[pKey].QuestHistory[pName][quest].abandoned ) ) then
		NuNData[pKey].QuestHistory[pName][quest].abandoned = nil;
		return;
	end

	QuestLog_SetSelection(qI);

	local qChar = NuN_CheckTarget();
	if ( qChar == "N" ) then
		qChar = c_note;
	else
		qChar = "";
	end
	if ( ( not NuNData[pKey].QuestHistory[pName][quest] ) and ( NuNSettings[pKey].autoQ ) ) then
		NuNData[pKey].QuestHistory[pName][quest] = {};
		NuNData[pKey].QuestHistory[pName][quest].sortDate = tostring(date("%Y%m%d%H%M%S"))..":"..qI;
		NuNData[pKey].QuestHistory[pName][quest].pLevel = UnitLevel("player");
		NuNData[pKey].QuestHistory[pName][quest].txt = NUN_CREATED.."   "..qChar.."\n    "..NuN_GetDateStamp().."\n    "..location.."\n";
		qTriggs = qTriggs + 1;
	end

	local chk = NuN_CleanQuestText( GetQuestLogQuestText() );
	if ( qLevel == nil ) then
		qLevel = "--";
	end
	if ( qTag == nil ) then
		qTag = "";
	end
	if ( qChar ~= "" ) then
		qChar = qChar.."   "..NuN_LocStrip(location);
	end
	qText = "\n"..quest.."     "..NUN_QLVL..qLevel.."     "..qTag.."\n"..qChar.."\n\n"..NuN_BuildQuestText().."\n";

	if ( not string.find(chk, "Unknown Entity") ) then
		if ( ( qComplete ) and ( NuNData[pKey].QuestHistory[pName][quest] ) and ( ( not NuNData[pKey].QuestHistory[pName][quest].complete ) or ( ( NuNData[pKey].QuestHistory[pName][quest].complete ~= chk ) and ( string.find(qText, chk) ) ) ) ) then
			NuNData[pKey].QuestHistory[pName][quest].complete = chk;
			NuNData[pKey].QuestHistory[pName][quest].txt = NuNData[pKey].QuestHistory[pName][quest].txt.."\n\n"..NUN_COMPLETE.."\n    "..NuN_GetDateStamp().."\n    "..location.."\n";
		end
		if ( NuNData[Notes][quest] ) then
			c_note = quest;
			g_text = NuN_GetGText(c_note);
			if ( ( not string.find( g_text, chk) ) and ( string.find(qText, chk) ) ) then
				if ( ( NuNGNoteFrame:IsVisible() ) and ( noteTypes[NuNGNoteFrame.type].Command == "QST" ) ) then
					HideUIPanel(NuNGNoteFrame);
				end
				g_text = g_text.."\n\n".."--------------".."\n\n"..qText;
				NuN_SetGText("Account");
			end
		elseif ( NuNData[pKey][Notes][quest] ) then
			c_note = quest;
			g_text = NuN_GetGText(c_note);
			if ( ( not string.find( g_text, chk ) ) and ( string.find(qText, chk) ) ) then
				if ( ( NuNGNoteFrame:IsVisible() ) and ( noteTypes[NuNGNoteFrame.type].Command == "QST" ) ) then
					HideUIPanel(NuNGNoteFrame);
				end
				g_text = g_text.."\n\n".."--------------".."\n\n"..qText;
				NuN_SetGText("Realm");
			end
		elseif ( ( not NuNData[Notes][quest] ) and ( not NuNData[pKey][Notes][quest] ) and ( NuNSettings[pKey].autoQ ) ) then
			if ( NuNSettings[pKey].dLevel ) then
				NuNData[Notes][quest] = {};
				NuNData[Notes][quest].type = 5;
				saveLvl = "Account";
			else
				NuNData[pKey][Notes][quest] = {};
				NuNData[pKey][Notes][quest].type = 5;
				saveLvl = "Realm";
			end
			c_note = quest;
			g_text = qText;
			NuN_SetGText(saveLvl);
			if ( ( qChar ~= "" ) and ( NuNSettings[pKey].autoMapNotes ) ) then
				NuN_MapNote("Target", NUN_QUEST_GIVER, "", 9);
			end
		end
	end

	c_note = l_c_note;
	g_text = l_g_text;
	c_name = l_c_name;
end

function NuN_AbandonQuest(qTitle)
	if ( NuNData[pKey].QuestHistory[pName][qTitle] ) then
		NuNData[pKey].QuestHistory[pName][qTitle].abandoned = true;
		if ( NuNQuestLog[qTitle] ) then
			NuNQuestLog[qTitle] = nil;
		end
	end
end

function NuN_QuestHandIn(q)
	if ( NuNData[pKey].QuestHistory[pName][q] ) then
		local l_c_note = c_note;
		local l_c_name = c_name;
		local qChar = NuN_CheckTarget();
		if ( qChar == "N" ) then
			qChar = c_note;
		else
			qChar = "";
		end
		NuNData[pKey].QuestHistory[pName][q].handedIn = 1;
		NuNData[pKey].QuestHistory[pName][q].txt = NuNData[pKey].QuestHistory[pName][q].txt.."\n\n"..NUN_FINISHED.."   "..qChar.."\n    "..NuN_GetDateStamp().."\n    "..NuN_GetLoc().."\n";
		c_note = l_c_note;
		c_name = l_c_name;
	end
end



function NuN_InitialiseSavedVariables()
	local index, value;

	pKey = GetCVar("realmName");
	if (not NuNData[pKey]) then
		NuNData[pKey] = {};
		NuNSettings[pKey] = {};
		NuNSettings[pKey].toolTips = "1";
		NuNSettings[pKey].pScale = 1.00;
		NuNSettings[pKey].tScale = 1.00;
		NuNSettings[pKey].mScale = 1.00;
		NuNSettings[pKey].ttLen = NUN_TT_MAX;
		NuNSettings[pKey].ttLLen = NUN_TT_LEN;
		NuNData[pKey][Notes] = {};
		NuNSettings[pKey].minOver = "1";
		NuNSettings[pKey].dLevel = "1";
	end
	if ( not NuNSettings.Version ) then
		for index, value in NuNSettings do
			if ( index ~= "Version" ) then
				NuNSettings[index].toolTips = "1";
				NuNSettings[index].pScale = 1.00;
				NuNSettings[index].tScale = 1.00;
				NuNSettings[index].mScale = 1.00;
				NuNSettings[index].ttLen = NUN_TT_MAX;
				NuNSettings[index].ttLLen = NUN_TT_LEN;
				NuNSettings[index].minOver = "1";
				NuNSettings[pKey].dLevel = "1";
			end
		end
		NuNSettings.Version = NUN_VERSION;
	end
	if ( NuNSettings.Version < "2.51" ) then
		for index, value in NuNSettings do
			if ( index ~= "Version" ) then
				NuNSettings[index].mScale = 1.00;
				NuNSettings[index].minOver = "1";
			end
		end
		NuNSettings.Version = NUN_VERSION;
	end
	if ( NuNSettings.Version < "3.00" ) then
		for index, value in NuNSettings do
			if ( index ~= "Version" ) then
				NuNSettings[index].mScale = 1.00;
			end
		end
		NuNSettings.Version = NUN_VERSION;
	end
	if ( NuNSettings.Version < NUN_VERSION ) then
		NuNSettings.Version = NUN_VERSION;
	end
	if ( not NuNData[itmIndex] ) then
		NuNData[itmIndex] = {};
	end
	if ( not NuNData[Notes] ) then
		NuNData[Notes] = {};
	end
	if ( not NuNData[pKey].QuestHistory ) then
		NuNData[pKey].QuestHistory = {};
	end
	if ( not NuNData[pKey].QuestHistory[pName] ) then
		NuNData[pKey].QuestHistory[pName] = {};
	end
	if ( not NuNData[mrgIndex] ) then
		NuNData[mrgIndex] = {};
	end
end



function NuN_OptionsTextLengthSet()
	local len = this:GetText();

	if ( len ) then
		NuNSettings[pKey].ttLen = len;
	else
		NuNSettings[pKey].ttLen = "0";
	end
end



function NuN_OptionsTextLineLengthSet()
	local len = this:GetText();

	if ( len ) then
		NuNSettings[pKey].ttLLen = len;
	else
		NuNSettings[pKey].ttLLen = "0";
	end
end



function NuN_FetchQuestHistory()
	local index, value;
	local counter = 0;
	local results = 0;

	foundNuN = {};
	for index, value in NuNData[pKey].QuestHistory[pName] do
		counter = counter + 1;
		foundNuN[counter] = NUN_QUEST_C..index;
	end

	table.sort(foundNuN, NuN_SortQuestHistory);
	results = getn(foundNuN);
	NuNSearchTitleText:SetText(pName.."'s "..NUN_QUESTS_TEXT.." ("..results..")");

	NuNSearch_Update();
	if ( ( deletedE ) and ( visibles > 0 ) and ( lastBttn ~= nil ) ) then
		deletedE = false;
		if ( lastBttnIndex > visibles ) then
			NuNSearch_HighlightRefresh(lastVisible);
			NuNSearchNote_OnClick(lastVisible);
		else
			NuNSearch_HighlightRefresh(lastBttn);
			NuNSearchNote_OnClick(lastBttn);
		end
	else
		NuNSearch_HighlightRefresh(nil);
	end
end



function NuN_SortQuestHistory(ele1, ele2)
	ele1 = string.sub(ele1, 2);
	ele2 = string.sub(ele2, 2);
	if ( NuNData[pKey].QuestHistory[pName][ele1].sortDate > NuNData[pKey].QuestHistory[pName][ele2].sortDate ) then
		return true;
	end

	return false;
end



function NuN_CleanQuestText(dirtyText)
	local cleanText = string.gsub(dirtyText, pName, NUN_REPLACEQNAME_TXT);
	cleanText = string.gsub(cleanText, "$N", NUN_REPLACEQNAME_TXT);

	local class = UnitClass("player");
	cleanText = string.gsub(cleanText, class, NUN_REPLACEQCLASS_TXT);
	cleanText = string.gsub(cleanText, strlower(class), NUN_REPLACEQCLASS_TXT);

	return cleanText;
end


function NuN_ToggleMicroButtons()
	if ( NuNMicroFrame:IsVisible() ) then
		HideUIPanel(NuNMicroFrame);
		NuNSettings[pKey].hideMicro = "1";
	else
		ShowUIPanel(NuNMicroFrame);
		NuNSettings[pKey].hideMicro = nil;
	end
end


function NuN_ProcessParty()
	local pChanged = nil;
	local lMember, index, value;
	local partyA = {};
	local lMembers = GetNumPartyMembers();

	if ( not NuNData[pKey][NuN_Parties] ) then
		NuNData[pKey][NuN_Parties] = {};
	end
	if ( ( not NuNData[pKey][NuN_Parties][pName] ) or ( ( not UnitInRaid("player") ) and ( lMembers == 0 ) ) ) then
		NuNData[pKey][NuN_Parties][pName] = {};
	end

	for i = 1, lMembers, 1 do
		lMember = UnitName("party"..i);
		if ( lMember == "Unknown Entity" ) then
			return;
		end
		if ( lMember ) then
			partyA[lMember] = {};
			partyA[lMember].pos = i;
			if ( not NuNData[pKey][NuN_Parties][pName][lMember] ) then
				NuNData[pKey][NuN_Parties][pName][lMember] = {};
				NuNData[pKey][NuN_Parties][pName][lMember].pos = i;
				if ( not NuNData[pKey][lMember] ) then
					NuNData[pKey][lMember] = {};
					NuNData[pKey][lMember].type = NUN_PARTY_C;
					NuNData[pKey][lMember].faction = pFaction;
					NuNData[pKey][lMember][txtTxt] = NUN_AUTO_PARTIED..NuN_GetDateStamp();
					NuNData[pKey][lMember][pName] = {};
					NuNData[pKey][lMember][pName].partied = 1;
				else
					if ( not NuNData[pKey][lMember][pName] ) then
						NuNData[pKey][lMember][pName] = {};
						NuNData[pKey][lMember][pName].partied = 1;
					elseif ( not NuNData[pKey][lMember][pName].partied ) then
						NuNData[pKey][lMember][pName].partied = 1;
					else
						NuNData[pKey][lMember][pName].partied = NuNData[pKey][lMember][pName].partied + 1;
					end
				end
			end
		end
	end

	for index, value in NuNData[pKey][NuN_Parties][pName] do
		if ( not partyA[index] ) then
			if ( UnitInRaid("player") ) then
				local rID = NuN_CheckRaidByName(index);
				if ( not rID ) then
					NuNData[pKey][NuN_Parties][pName][index] = nil;
				end
			else
				NuNData[pKey][NuN_Parties][pName][index] = nil;
			end
		end
	end
end



function NuN_PartyDownButton_OnClick()
	local lParties = NuNData[pKey][c_name][pName].partied;

	lParties = lParties - 1;
	if ( lParties < 1 ) then
		NuNData[pKey][c_name][pName].partied = nil;
		NuNPartiedLabel:Hide();
		NuNPartiedNumberLabel:SetText("(0)");
		NuNPartiedNumberLabel:Hide();
		NuNFramePartyDownButton:Hide();
	else
		NuNData[pKey][c_name][pName].partied = lParties;
		NuNPartiedNumberLabel:SetText("(x"..tostring(lParties)..")");
	end
end


function NuN_PartyDownButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_PDOWN_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_PDOWN_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_PDOWN_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_bHaveTTCheckBox_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		NuN_Tooltip:SetOwner(this);
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_BHAVE_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_BHAVE_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_BHAVE_TXT3, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_BHAVE_TXT4, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_BHAVE_TXT5, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end

function NuN_BuildShoppingList()
	local listText = "";
	local mName = MerchantNameText:GetText();

	if ( mName == c_note ) then
		local iPrice, iPriceTxt, iQuant, iNumAvail, iLink, iDiscard;
		local numMerchantItems = GetMerchantNumItems();

		for i=1, numMerchantItems, 1 do
			iLink = GetMerchantItemLink(i);
			if ( iLink ) then
				listText = listText.."\n"..iLink;
			end
			iDiscard, iDiscard, iPrice, iQuant, iNumAvail = GetMerchantItemInfo(i);
			if ( ( iQuant ) and ( iQuant > 1 ) ) then
				listText = listText.." ("..iQuant..") ";
			end
			if ( ( iPrice ) and ( iPrice > 0 ) ) then
				iPriceTxt = NuN_BuildMoneyString(iPrice);
				listText = listText.."   "..iPriceTxt;
			end
			if ( ( iNumAvail ) and ( iNumAvail > 0 ) ) then
				listText = listText.."        "..NUN_LIMITED;
			end
		end
	end

	if ( listText == "" ) then
		return nil;
	else
		return listText;
	end
end


function NuN_BuildMoneyString(moneyVal)
	local moneyTxt = nil;
	local gold, silver, copper;

	if ( ( moneyVal ) and ( moneyVal > 0 ) ) then
		if ( moneyVal > 9999 ) then
			gold = ( moneyVal / 10000 );
			gold = string.format("%d", gold);
			moneyVal = moneyVal - ( gold * 10000 );
		else
			gold = 0;
		end
		if ( moneyVal > 99 ) then
			silver = ( moneyVal / 100 );
			silver = string.format("%d", silver);
			moneyVal = moneyVal - ( silver * 100 );
		else
			silver = 0;
		end
		copper = moneyVal;
		moneyTxt = string.format("%dg %ds %dc", gold, silver, copper);
	end

	return moneyTxt;
end


function NuN_SaveOpen()
	if ( NuNFrame:IsVisible() ) then
		NuN_WriteNote();
	end
	if ( NuNGNoteFrame:IsVisible() ) then
		NuNGNote_WriteNote();
	end
end


function NuN_TextEscape(lFrame, lText)
	if ( NuNSettings[pKey].bHave ) then
		lText:ClearFocus();
		if ( ( lText:GetText() == nil ) or ( lText:GetText() == "" ) ) then
			lText:SetText("\n");
		end
	else
		HideUIPanel(lFrame);
	end
end



function NuN_OverTTCheckBox_OnClick()
	if ( NuN_OverTTCheckBox:GetChecked() ) then
		NuNSettings[pKey].minOver = "1";
	else
		NuNSettings[pKey].minOver = nil;
	end
end



function NuN_AutoPartyCheckBox_OnClick()
	if ( NuN_AutoPartyCheckBox:GetChecked() ) then
		NuNSettings[pKey].autoP = "1";
		NuN_ProcessParty();
	else
		NuNSettings[pKey].autoP = nil;

	end
end


function NuN_BehaveCheckBox_OnClick()
	if ( NuN_BehaveCheckBox:GetChecked() ) then
		NuNSettings[pKey].bHave = "1";
	else
		NuNSettings[pKey].bHave = nil;
	end
end


function NuN_DeleteNote(dType)
	if ( NuNcDeleteFrame:IsVisible() ) then
		NuNcDeleteFrame:Hide();
	end
	NuNcDeleteFrame.type = dType;
	if ( dType == "Contact" ) then
		NuNcDeleteLabel:SetText(NUN_CONTACT_TXT.." :\n"..c_name);
		ShowUIPanel(NuNcDeleteFrame);
		NuNText:ClearFocus();
		NuNcDeleteGhostTextBox:SetFocus();
	else
		if ( NuNGNoteFrame.fromQuest ) then
			NuNcDeleteLabel:SetText(NUN_QUEST_NOTE.." :\n"..c_note);
		else
			NuNcDeleteLabel:SetText(NUN_GENERAL_TXT.." :\n"..c_note);
		end
		ShowUIPanel(NuNcDeleteFrame);
		NuNGNoteTextScroll:ClearFocus();
		NuNcDeleteGhostTextBox:SetFocus();
	end
end


function NuNcDeleteButton_OnClick()
	if ( NuNcDeleteFrame.type == "Contact" ) then
		HideUIPanel(NuNcDeleteFrame);
		NuN_Delete();
	elseif ( NuNcDeleteFrame.type == "General" ) then
		HideUIPanel(NuNcDeleteFrame);
		NuNGNote_Delete();
	end
end


function NuN_LocStrip(locData)
	if ( locData ) then
		local p = string.find(locData, " : ");
		if ( p ) then
			locData = string.sub(locData, (p+3));
		end
	end

	return locData;
end




function NuN_MapNote(MNType, MNxtra1, MNxtra2, MNColour)
	local MNCont, MNZone, x, y;
	local checknote = nil;
	local nKey = nil;

	if ( ( MetaMapNotes_OnLoad ) or ( MapNotes_OnLoad ) ) then
	else
		return;
	end

	MNCont, MNZone, x, y, checknote, nKey = NuN_GetMapNotesKey();
	if ( ( not MNCont ) or ( ( x == 0 ) and ( y == 0 ) ) ) then
		if ( MetaMapNotes_OnLoad ) then
			MetaMap_StatusPrint(METAMAPNOTES_QUICKNOTE_NOPOSITION);
		elseif ( MapNotes_OnLoad ) then
			MapNotes_StatusPrint(MAPNOTES_QUICKNOTE_NOPOSITION);
		end
        	return;
	end

	local MNLine1, MNLine2, MNAuthor, NuN_Reaction;
	local MNName;
	local tName = UnitName("target");
	if ( ( MNType == "Target" ) and ( tName ) and ( not UnitPlayerControlled("target") ) ) then
		NuN_Reaction = UnitReaction("player", "target");
		if ( not MNColour ) then
			if ( NuN_Reaction < 4 ) then
				MNColour = 1;
			elseif ( NuN_Reaction == 4 ) then
				MNColour = 0;
			end
		end
		MNName = UnitName("target");
	else
		MNName = c_note;
	end
	if ( not MNColour ) then
		MNColour = 3;
	end

	local theData;
	if ( MetaMapNotes_OnLoad ) then
		theData = MetaMapNotes_Data[MNCont];
	elseif ( MapNotes_OnLoad ) then
		theData = MapNotes_Data[MNCont];
	end

	if (checknote) then
		if ( ( inBG ) and ( MNName == theData[checknote].name ) ) then
			NuN_ReLinkMapNote(MNName, MNCont, MNZone, checknote);
			return;
		elseif ( ( not inBG ) and ( MNName == theData[MNZone][checknote].name ) ) then
			NuN_ReLinkMapNote(MNName, MNCont, MNZone, checknote);
			return;
		end
		local mergeFailed = NuN_MergeMapNote(MNCont, MNZone, checknote, MNName, nKey, MNxtra1, MNxtra2);
		if ( mergeFailed ) then
			local repName;
			if ( inBG ) then
				repName = theData[checknote].name;
			else
				repName = theData[zone][checknote].name;
			end
			if ( MetaMapNotes_OnLoad ) then
				MetaMap_StatusPrint( format(METAMAPNOTES_QUICKNOTE_NOTETONEAR, repName));
			elseif ( MapNotes_OnLoad ) then
				MapNotes_StatusPrint( format(MAPNOTES_QUICKNOTE_NOTETONEAR, repName));
			end
			NuN_Message( NUN_MAX_MERGED );
		end
	else
		MNLine1 = MNxtra1;
		MNLine2 = MNxtra2;
		MNAuthor = "NotesUNeed - "..pName;
		NuN_WriteMapNote(MNCont, MNZone, x, y, MNColour, MNName, MNLine1, MNLine2, MNAuthor);
	end
end

function NuN_ReLinkMapNote(MNName, MNCont, MNZone, tmpID)
	local NuN_Key = MNCont.."-"..MNZone.."-"..tmpID;
	if ( not NuNData[mrgIndex] ) then
		NuNData[mrgIndex] = {};
	end
	if ( not NuNData[mrgIndex][NuN_Key] ) then
		NuNData[mrgIndex][NuN_Key] = {};
		NuNData[mrgIndex][NuN_Key].noteCounter = 0;
	end
	if ( NuNData[mrgIndex][NuN_Key][MNName] ) then
		NuN_Message(NUN_NOTESUNEED_INFO);
		return;
	end
	if ( not NuNData[mrgIndex][NuN_Key].noteCounter ) then
		NuNData[mrgIndex][NuN_Key].noteCounter = 0;
	end
	NuNData[mrgIndex][NuN_Key].noteCounter = NuNData[mrgIndex][NuN_Key].noteCounter + 1;
	NuNData[mrgIndex][NuN_Key][MNName] = "1";
	if ( MetaMapNotes_OnLoad ) then
		NuN_Message("NotesUNeed <> MetaMapNote");
	elseif ( MapNotes_OnLoad ) then
		NuN_Message("NotesUNeed <> MapNote");
	end
end

function NuN_MergeMapNote(MNCont, MNZone, id, MNName, NuN_Key, MNxtra1, MNxtra2)
	local Merged = nil;
	local MNLine1, MNLine2, MNAuthor;
	local mrgEntry = nil;
	local oriNote;
	local mapNoted = true;
	local theData;

	if ( MetaMapNotes_OnLoad ) then
		if ( inBG ) then
			theData = MetaMapNotes_Data[MNCont];
		else
			theData = MetaMapNotes_Data[MNCont][MNZone];
		end
	elseif ( MapNotes_OnLoad ) then
		if ( inBG ) then
			theData = MapNotes_Data[MNCont];
		else
			theData = MapNotes_Data[MNCont][MNZone];
		end
	else
		return;
	end
	oriNote = theData[id].name;

	if ( not string.find(oriNote, MNName) ) then
		mapNoted = nil;
	end

	if ( not NuNData[mrgIndex] ) then
		NuNData[mrgIndex] = {};
	end
	if ( not NuNData[mrgIndex][NuN_Key] ) then
		NuNData[mrgIndex][NuN_Key] = {};
	else
		mrgEntry = true;
	end

	if ( mrgEntry ) then
		if ( not NuNData[mrgIndex][NuN_Key].noteCounter ) then
			local counter = 0;
			local index, value;
			for index, value in NuNData[mrgIndex][NuN_Key] do
				counter = counter + 1;
			end
			NuNData[mrgIndex][NuN_Key].noteCounter = counter;
		end
		if ( NuNData[mrgIndex][NuN_Key].noteCounter > 4 ) then
			return "Failed";
		end
		if ( NuNData[mrgIndex][NuN_Key][MNName] ) then
			return nil;
		else
			NuNData[mrgIndex][NuN_Key].noteCounter = NuNData[mrgIndex][NuN_Key].noteCounter + 1;
			NuNData[mrgIndex][NuN_Key][MNName] = "1";
		end
	elseif ( mapNoted ) then
		NuN_ReLinkMapNote(MNName, MNCont, MNZone, id);
	else
		if ( ( not NuNData[Notes][oriNote] ) and ( not NuNData[pKey][Notes][oriNote] ) ) then
			NuNData[mrgIndex][NuN_Key].noteCounter = 1;
			NuNData[mrgIndex][NuN_Key][MNName] = "1";
		else
			NuNData[mrgIndex][NuN_Key].noteCounter = 2;
			NuNData[mrgIndex][NuN_Key][MNName] = "1";
			NuNData[mrgIndex][NuN_Key][oriNote] = "1";
		end
	end

	if ( not mapNoted ) then
		theData[id].name = theData[id].name.." | "..MNName;
		theData[id].inf1 = theData[id].inf1.." | "..MNxtra1;
		theData[id].inf2 = theData[id].inf2.." | "..MNxtra2;
		theData[id].creator = NUN_POPUP_TITLE.." - "..pName;
	end

	if ( MetaMapNotes_OnLoad ) then
			MetaMap_StatusPrint( format(NUN_MERGING.." "..theData[id].name) );
	elseif ( MapNotes_OnLoad ) then
			MapNotes_StatusPrint( format(NUN_MERGING.." "..theData[id].name) );
	end

	return nil;
end


function NuN_WriteMapNote(MNCont, MNZone, x, y, MNColour, MNName, MNLine1, MNLine2, MNAuthor)
	local id = 0;
	local NuN_Key;
	local theData, theMiniData;
	local NuN_SetNextAsMiniNote;
	local numNotes, i, j, tmpID;

	if ( MetaMapNotes_OnLoad ) then
		if ( inBG ) then
			theData = MetaMapNotes_Data[MNCont];
		else
			theData = MetaMapNotes_Data[MNCont][MNZone];
		end
		theMiniData = MetaMapNotes_MiniNote_Data;
		NuN_SetNextAsMiniNote = MetaMapNotes_SetNextAsMiniNote;
		numNotes = MetaMapNotes_NotesPerZone;
		i = MetaMapNotes_GetZoneTableSize(theData);
	elseif ( MapNotes_OnLoad ) then
		if ( inBG ) then
			theData = MapNotes_Data[MNCont];
		else
			theData = MapNotes_Data[MNCont][MNZone];
		end
		theMiniData = MapNotes_MiniNote_Data;
		NuN_SetNextAsMiniNote = MapNotes_SetNextAsMiniNote;
		numNotes = MapNotes_NotesPerZone;
		i = 0;
		for j, value in MapNotes_Data[MNCont][MNZone] do
			i = i + 1;
		end
	else
		return;
	end

	if (NuN_SetNextAsMiniNote ~= 2) then
		if (i < numNotes) then
			tmpID = i + 1;
			theData[tmpID] = {};
			theData[tmpID].name = MNName;
			theData[tmpID].ncol = 0;
			theData[tmpID].inf1 = MNLine1;
			theData[tmpID].in1c = 0;
			theData[tmpID].inf2 = MNLine2;
			theData[tmpID].in2c = 0;
			theData[tmpID].creator = MNAuthor;
			theData[tmpID].icon = MNColour;
			theData[tmpID].xPos = x;
			theData[tmpID].yPos = y;
			if ( MetaMapNotes_OnLoad ) then
				MetaMap_StatusPrint(format(METAMAPNOTES_QUICKNOTE_OK, GetRealZoneText()));
			else
				MapNotes_StatusPrint(format(MAPNOTES_QUICKNOTE_OK, GetRealZoneText()));
			end

			NuN_Key = MNCont.."-"..MNZone.."-"..tmpID;
			if ( not NuNData[mrgIndex] ) then
				NuNData[mrgIndex] = {};
			end
			if ( not NuNData[mrgIndex][NuN_Key] ) then
				NuNData[mrgIndex][NuN_Key] = {};
			end
			NuNData[mrgIndex][NuN_Key].noteCounter = 1;
			NuNData[mrgIndex][NuN_Key][MNName] = "1";
		else
			if ( MetaMapNotes_OnLoad ) then
				MetaMap_StatusPrint(format(METAMAPNOTES_QUICKNOTE_TOOMANY, GetRealZoneText()));
			elseif ( MapNotes_OnLoad ) then
				MapNotes_StatusPrint(format(MAPNOTES_QUICKNOTE_TOOMANY, GetRealZoneText()));
			end
		end
	end

	if (NuN_SetNextAsMiniNote ~= 0) then
		theMiniData.xPos = x;
		theMiniData.yPos = y;
		theMiniData.MNCont = MNCont;
		theMiniData.MNZone = MNZone;
		theMiniData.id = id;
		theMiniData.name = MNName;
		theMiniData.color = 0;
		theMiniData.icon = MNColour;
		MiniNotePOITexture:SetTexture("Interface\\AddOns\\MapNotes\\POIIcons\\Icon"..MNColour);
		MiniNotePOI:Show();
		if ( MetaMapNotes_OnLoad ) then
			MetaMapNotes_SetNextAsMiniNote = 0;
			MetaMap_StatusPrint(METAMAPNOTES_SETMININOTE.." - "..MNName);
		elseif ( MapNotes_OnLoad ) then
			MapNotes_SetNextAsMiniNote = 0;
			MapNotes_StatusPrint(MAPNOTES_SETMININOTE.." - "..MNName);
		end
	end
end


function NuN_GetMapNotesKey()
	local id = nil;
	local nKey = nil;
	local x, y;
	local MNCont = nil;
	local MNZone = nil;

	inBG = false;

	SetMapToCurrentZone();
	MNCont = GetCurrentMapContinent();

	if ( MetaMapNotes_OnLoad ) then
		if ( MNCont == -1 ) then
			if ( not MetaMapNotes_Data[GetRealZoneText()] ) then
				MetaMapNotes_Data[GetRealZoneText()] = {};
			end
			MNCont = GetRealZoneText();
			MNZone = 0;
			inBG = true;
		else
			MNZone = MetaMapNotes_ZoneShift[MNCont][GetCurrentMapZone()];
			if ( not MetaMapNotes_Data[MNCont][MNZone] ) then
				MetaMapNotes_Data[MNCont][MNZone] = {};
			end
		end
	elseif ( MapNotes_OnLoad ) then
		if ( MNCont == -1 ) then
			if ( not MapNotes_Data[GetRealZoneText()] ) then
				MapNotes_Data[GetRealZoneText()] = {};
			end
			MNCont = GetRealZoneText();
			MNZone = 0;
			inBG = true;
		else
			MNZone = MapNotes_ZoneShift[MNCont][GetCurrentMapZone()];
			if ( not MapNotes_Data[MNCont][MNZone] ) then
				MapNotes_Data[MNCont][MNZone] = {};
			end
		end
	end

	x, y = GetPlayerMapPosition("player");
	if ( ( ( x == 0 ) and ( y == 0 ) ) or ( MNCont == 0 ) ) then
		return nil;
	end

	if ( inBG ) then
		id = NuN_ProximityCheck(MNCont, x, y);
	elseif ( MetaMapNotes_OnLoad ) then
		id = MetaMapNotes_CheckNearNotes(MNCont, MNZone, x, y);
	elseif ( MapNotes_OnLoad ) then
		id = MapNotes_CheckNearNotes(MNCont, MNZone, x, y);
	end

	if ( id ) then
		nKey = MNCont.."-"..MNZone.."-"..id;
	end

	return MNCont, MNZone, x, y, id, nKey;
end

function NuN_ProximityCheck(theBG, xPos, yPos)
	local chkData = {};
	local minDiff;

	local chkData = {};

	if ( MetaMapNotes_OnLoad ) then
		chkData = MetaMapNotes_Data[theBG];
		minDiff = MetaMapNotes_MinDiff;
	elseif ( MapNotes_OnLoad ) then
		chkData = MapNotes_Data[theBG];
		minDiff = MapNotes_MinDiff;
	end

	if ( ( not minDiff ) or ( minDiff == 0 ) ) then
		minDiff = 7;
	end

	if ( not chkData ) then
		return;
	end

	local i = 1;
	for j, value in chkData do
		local deltax = abs(chkData[i].xPos - xPos);
		local deltay = abs(chkData[i].yPos - yPos);
		if(deltax <= 0.0009765625 * minDiff and deltay <= 0.0013020833 * minDiff) then
			return i;
		end
		i = i + 1;
	end

	return nil;
end



function NuN_AutoMapCheckBox_OnClick()
	if ( NuN_AutoMapCheckBox:GetChecked() ) then
		NuNSettings[pKey].autoMapNotes = "1";
	else
		NuNSettings[pKey].autoMapNotes = nil;
	end
end


function NuN_AutoMapCheckBox_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_MAPCHECK_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_MAPCHECK_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_MAPCHECK_TXT3, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_MAPCHECK_TXT4, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_MAPCHECK_TXT5, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end



function NuN_HyperButton_OnClick(nType)
	local p1, p2;
	local linkA = {};
	local aCounter = 0;
	local lText, lTextLen;

	if ( nType == "Contact" ) then
		lText = NuNText:GetText();
	elseif ( nType == "General" ) then
		lText = NuNGNoteTextScroll:GetText();
	else
		NuN_Message(NUN_LINKFAILURE);
		return;
	end

	lTextLen = string.len(lText);

	p1 = string.find(lText, "|Hitem");
	while ( ( p1 ) and ( p1 > 10 ) ) do
		p2 = string.find(lText, "|h|r", p1);
		if ( ( not p2 ) or ( (p2+3) > lTextLen ) ) then
			break;
		end
		p1 = p1 - 10;
		p2 = p2 + 3;
		local link = string.sub(lText, p1, p2);
		aCounter = aCounter + 1;
		linkA[aCounter] = link;
		p1 = string.find(lText, "|Hitem", (p2+1));
	end

	local loops = getn(linkA);
	if ( loops ) and ( loops > 0 ) then
		for i=1, loops, 1 do
			DEFAULT_CHAT_FRAME:AddMessage(linkA[i]);
		end
	else
		NuN_Message(NUN_NOLINKS);
	end
end



function NuN_HyperButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_HYPERLINKS_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_HYPERLINKS_TXT2, 0, 1, 0);
		NuN_Tooltip:AddLine(NUN_TT_HYPERLINKS_TXT3, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end




function NuNPopup_OnClick(bttn, noteN)
	if ( IsAltKeyDown() ) then
		if ( bttn == "LeftButton" ) then
			HideUIPanel(WorldMapFrame);
			if ( NuNGNoteFrame:IsVisible() ) then
				if ( c_note == noteN ) then
					return;
				end
				NuNGNoteFrame:Hide();
			end
			NuNGNoteFrame.fromQuest = nil;
			c_note = noteN;
			NuN_ShowSavedGNote();
		elseif ( bttn == "RightButton" ) then
			NuN_DeleteMapIndexNote(NuNPopup.id, noteN);
		end
	end
end

function NuNPopup_OnShow()
	popUpHide = nil;
end

function NuNPopup_OnUpdate(arg1)
	popUpTimeSinceLastUpdate = popUpTimeSinceLastUpdate + arg1;
	if ( popUpTimeSinceLastUpdate > popUpUpdateInterval ) then
		if ( ( popUpHide ) and ( not MouseIsOver(NuNPopup) )  ) then
			NuNPopup:Hide();
		end
		popUpTimeSinceLastUpdate = 0;
	end
end


function NuN_Message(msg)
	msg = "NotesUNeed : "..msg;
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 0.64, 0.21, 0.93);
	end
end



function NuN_UpdateMapNotesIndex(deletedNote)
	local MNindex, MNvalue, nIndex, nValue;

	for MNindex, MNvalue in NuNData[mrgIndex] do
		for nIndex, nValue in NuNData[mrgIndex][MNindex] do
			if ( nIndex == deletedNote ) then
				NuNData[mrgIndex][MNindex][nIndex] = nil;
				NuNData[mrgIndex][MNindex].noteCounter = NuNData[mrgIndex][MNindex].noteCounter - 1;
				break;
			end
			if ( NuNData[mrgIndex][MNindex].noteCounter < 1 ) then
				NuNData[mrgIndex][MNindex] = nil;
			end
		end
	end
end



function NuN_PreDeleteMapIndex(id, cont, zone)
	local nKey, lstKey, curZ, lstEntry;

	if ( MetaMapNotes_OnLoad ) then
		curZ = MetaMapNotes_Data;
	elseif ( MapNotes_OnLoad ) then
		curZ = MapNotes_Data;
	end

	if ( ( not cont ) or ( cont < 1 ) or ( not zone ) or ( zone < 1 ) ) then
		cont = GetCurrentMapContinent();
		if ( cont == -1 ) then
			cont = GetRealZoneText();
			zone = 0;
			curZ = curZ[cont];
		elseif ( cont == 0 ) then
			return 0, 0, 0;
		else
			if  ( MetaMapNotes_OnLoad ) then
				zone = MetaMapNotes_ZoneShift[cont][GetCurrentMapZone()];
			elseif ( MapNotes_OnLoad ) then
				zone = MapNotes_ZoneShift[cont][GetCurrentMapZone()];
			end
			if ( ( not zone ) or ( zone < 1 ) ) then
				return 0, 0, 0;
			end
			curZ = curZ[cont][zone];
		end
	end

	lstEntry = NuN_GetZoneTableSize(curZ);
	return cont, zone, lstEntry;
end

-- Called when a MapNote is deleted

function NuN_DeleteMapIndex(id, cont, zone, lstEntry)
	local nKey = cont.."-"..zone.."-"..id;
	local lstKey = cont.."-"..zone.."-"..lstEntry;
	if ( NuNData[mrgIndex][nKey] ) then
		NuNData[mrgIndex][nKey] = nil;
	end
	if ( ( lstEntry ~= 0 ) and ( nKey ~= lstKey ) and ( NuNData[mrgIndex][lstKey] ) ) then
		local index, value;
		NuNData[mrgIndex][nKey] = {};
		for index, value in NuNData[mrgIndex][lstKey] do
			NuNData[mrgIndex][nKey][index] = NuNData[mrgIndex][lstKey][index];
		end
		NuNData[mrgIndex][lstKey] = nil;
	end
end



-- Called when Alt-Right Clicking on a button in the Popup to remove a single NuN - MapNote link

function NuN_DeleteMapIndexNote(id, noteN)
	local cont = GetCurrentMapContinent();
	if ( cont == -1 ) then
		cont = GetRealZoneText();
		zone = 0;
	elseif ( cont == 0 ) then
		return;
	else
		if  ( MetaMapNotes_OnLoad ) then
			zone = MetaMapNotes_ZoneShift[cont][GetCurrentMapZone()];
		elseif ( MapNotes_OnLoad ) then
			zone = MapNotes_ZoneShift[cont][GetCurrentMapZone()];
		end
		if ( ( not zone ) or ( zone < 1 ) ) then
			return;
		end
	end
	local nKey = cont.."-"..zone.."-"..id;
	if ( ( NuNData[mrgIndex][nKey] ) and ( NuNData[mrgIndex][nKey][noteN] ) ) then
		NuNData[mrgIndex][nKey][noteN] = nil;
		NuNData[mrgIndex][nKey].noteCounter = NuNData[mrgIndex][nKey].noteCounter - 1;
		if ( NuNData[mrgIndex][nKey].noteCounter < 1 ) then
			NuNData[mrgIndex][nKey] = nil;
		end
	end
	WorldMapTooltip:Hide();
	NuNPopup:Hide();
	NuN_MapTooltip:Hide();
end



function NuN_MapIndexHouseKeeping()
	local MNindex, MNvalue;

	if ( ( MetaMapNotes_OnLoad ) and ( MapNotes_OnLoad ) ) then
		return;
	end

	for MNindex, MNvalue in NuNData[mrgIndex] do
		local valid = NuN_ExtractMapNotesInfo(MNindex);
		if ( not valid ) then
			NuNData[mrgIndex][MNindex] = nil;
		end
	end
end


function NuN_ExtractMapNotesInfo(nKey)
	local cont, zone, id;
	local sep = "-";
	local p, q;

	p = string.find(nKey, sep);
	if ( not p ) then
		return nil;
	end
	q = string.find(nKey, sep, (p+1));
	if ( not q ) then
		return nil;
	end

	cont = tonumber( string.sub(nKey, 1, (p-1)) );
	zone = tonumber( string.sub(nKey, (p+1), (q-1)) );
	id = tonumber( string.sub(nKey, (q+1)) );

	if ( MetaMapNotes_OnLoad ) then
		theData = MetaMapNotes_Data;
	elseif ( MapNotes_OnLoad ) then
		theData = MapNotes_Data;
	end
	if ( ( zone == 0 ) and ( theData[cont] ) and ( theData[cont][id] ) ) then
		return true;
	elseif ( ( theData[cont] ) and ( theData[cont][zone] ) and ( theData[cont][zone][id] ) ) then
		return true;
	else
		return nil;
	end
end



function NuN_ValidateMapNotesVersion()
	if ( MAPNOTES_VERSION ) then
		local MNVersion = MAPNOTES_VERSION;
		for i = 1, getn(NuN_MapNotesValidVersions), 1 do
			if ( NuN_MapNotesValidVersions[1] == MNVersion ) then
				return true;
			end
		end
		if ( NuNSettings[pKey].mapNotesPlayedVersions ) then
			local vs = getn(NuNSettings[pKey].mapNotesPlayedVersions);
			for i = 1, vs, 1 do
				if ( NuNSettings[pKey].mapNotesPlayedVersions[i] == MNVersion ) then
					return true;
				end
			end
			vs = vs + 1;
			NuNSettings[pKey].mapNotesPlayedVersions[vs] = MNVersion;
		else
			NuNSettings[pKey].mapNotesPlayedVersions = {};
			NuNSettings[pKey].mapNotesPlayedVersions[1] = MNVersion;
		end
	end
	return nil;
end



function NuN_NotInfiniteIgored(ctact)
	ctact = string.lower(ctact);
	if ( ( InfinateIgnore_Config ) and ( InfinateIgnore_Config[pKey] ) and ( InfinateIgnore_Config[pKey].Ignoring ) and ( InfinateIgnore_Config[pKey].Ignoring[ctact] ) ) then
		return nil;
	end
	return true;
end




function NuN_SaveLast(saveType)
	NuN_LastOpen.type = saveType;
	if ( saveType == "Contact" ) then
		NuN_LastOpen.name = c_name;
	elseif ( saveType == "General" ) then
		NuN_LastOpen.note = c_note;
	end
end


function NuN_ReOpen()
	if ( NuN_LastOpen.type ) then
		if ( NuN_LastOpen.type == "Contact" ) then
			if ( NuNData[pKey][NuN_LastOpen.name] ) then
				NuN_ShowSavedNote(NuN_LastOpen.name);
			end
		elseif ( NuN_LastOpen.type == "General" ) then
			if ( ( NuNData[pKey][Notes][NuN_LastOpen.note] ) or ( NuNData[Notes][NuN_LastOpen.note] ) ) then
				c_note = NuN_LastOpen.note;
				NuN_ShowSavedGNote();
			end
		end
	end
end



function NuN_RunButton_OnClick()
	local script = NuNGNoteTextScroll:GetText();

	RunScript(script);
end

function NuN_RunButton_OnEnter()
	if ( NuNSettings[pKey].toolTips ) then
		NuN_Fade = "False";
		local x, y = GetCursorPosition();
		if ( x > 500 ) then
			NuN_Tooltip:SetOwner(this, "ANCHOR_RIGHT");
		else
			NuN_Tooltip:SetOwner(this, "ANCHOR_LEFT");
		end
		NuN_Tooltip:ClearLines();
		NuN_Tooltip:AddLine(NUN_TT_RUN_TXT1, 1, 0.7, 0);
		NuN_Tooltip:AddLine(NUN_TT_RUN_TXT2, 0, 1, 0);
		NuN_Tooltip:Show();
	end
end



function NuN_GetTipAnchor(theTT)
	local anchorBy, anchorTo;
	local x1, y1 = theTT:GetCenter();
	local x2, y2 = UIParent:GetCenter();

	if ( theTT == ShoppingTooltip1 ) then
		anchorBy = "TOPLEFT";
		anchorTo = "TOPRIGHT";
		return anchorBy, anchorTo;
	elseif ( theTT == ShoppingTooltip2 ) then
		anchorBy = "TOPLEFT";
		anchorTo = "BOTTOMLEFT";
		return anchorBy, anchorTo;
	end

	if ( ( not x1 ) or ( not y1 ) ) then
		anchorBy = "BOTTOMRIGHT";
		anchorTo = "BOTTOMLEFT";
	else
		if ( y1 > y2 ) then
			if ( x1 > x2 ) then
				anchorBy = "TOPRIGHT";
				anchorTo = "TOPLEFT";
			else
				anchorBy = "TOPLEFT";
				anchorTo = "TOPRIGHT";
			end
		else
			if ( x1 > x2 ) then
				anchorBy = "BOTTOMRIGHT";
				anchorTo = "BOTTOMLEFT";
			else
				anchorBy = "BOTTOMLEFT";
				anchorTo = "BOTTOMRIGHT";
			end
		end
	end

	return anchorBy, anchorTo;
end




--------------------------------------------------------------------------------

function NuN_LocaliseDateStamp(dateStamp)
	if ( ( GetLocale() ~= "enUS" ) and ( NUN_DAY_LIST ) and ( NUN_MONTH_LIST ) ) then
		dateStamp = string.gsub(dateStamp, "Monday", NUN_DAY_LIST[1]);
		dateStamp = string.gsub(dateStamp, "Tuesday", NUN_DAY_LIST[2]);
		dateStamp = string.gsub(dateStamp, "Wednesday", NUN_DAY_LIST[3]);
		dateStamp = string.gsub(dateStamp, "Thursday", NUN_DAY_LIST[4]);
		dateStamp = string.gsub(dateStamp, "Friday", NUN_DAY_LIST[5]);
		dateStamp = string.gsub(dateStamp, "Saturday", NUN_DAY_LIST[6]);
		dateStamp = string.gsub(dateStamp, "Sunday", NUN_DAY_LIST[7]);
		dateStamp = string.gsub(dateStamp, "January", NUN_MONTH_LIST[1]);
		dateStamp = string.gsub(dateStamp, "February", NUN_MONTH_LIST[2]);
		dateStamp = string.gsub(dateStamp, "March", NUN_MONTH_LIST[3]);
		dateStamp = string.gsub(dateStamp, "April", NUN_MONTH_LIST[4]);
		dateStamp = string.gsub(dateStamp, "May", NUN_MONTH_LIST[5]);
		dateStamp = string.gsub(dateStamp, "June", NUN_MONTH_LIST[6]);
		dateStamp = string.gsub(dateStamp, "July", NUN_MONTH_LIST[7]);
		dateStamp = string.gsub(dateStamp, "August", NUN_MONTH_LIST[8]);
		dateStamp = string.gsub(dateStamp, "September", NUN_MONTH_LIST[9]);
		dateStamp = string.gsub(dateStamp, "October", NUN_MONTH_LIST[10]);
		dateStamp = string.gsub(dateStamp, "November", NUN_MONTH_LIST[11]);
		dateStamp = string.gsub(dateStamp, "December", NUN_MONTH_LIST[12]);
	end
	return dateStamp;
end

--------------------------------------------------------------------------------

function NuN_LangPatch(langDirection)
	local toDeutschAR = {
		4,
		1,
		2,
		3
	}

	local toDeutschHC = {
		1,
		3,
		5,
		6,
		8,
		7,
		2,
		4
	}

	local toDeutschAC = {
		1,
		3,
		5,
		6,
		7,
		8,
		2,
		4
	}

	local toDeutschP = {
		1,
		12,
		13,
		14,
		15,
		16,
		18,
		3,
		4,
		5,
		6,
		8,
		9,
		10,
		11,
		2,
		7,
		17
	}
	local index, value;

	if ( NuNData[pKey] ) then
		if ( langDirection == "->de" ) then
			for index, value in NuNData[pKey] do
				if ( NuNData[pKey][index].faction ) then
					if ( NuNData[pKey][index].faction == "Horde" ) then
						if ( NuNData[pKey][index].cls ) then
							NuNData[pKey][index].cls = toDeutschHC[NuNData[pKey][index].cls];
						end
					else
						if ( NuNData[pKey][index].race ) then
							NuNData[pKey][index].race = toDeutschAR[NuNData[pKey][index].race];
						end
						if ( NuNData[pKey][index].cls ) then
							NuNData[pKey][index].cls = toDeutschAC[NuNData[pKey][index].cls];
						end
					end
					if ( NuNData[pKey][index].prof1 ) then
						NuNData[pKey][index].prof1 = toDeutschP[NuNData[pKey][index].prof1];
					end
					if ( NuNData[pKey][index].prof2 ) then
						NuNData[pKey][index].prof2 = toDeutschP[NuNData[pKey][index].prof2];
					end
				end
			end
		elseif ( langDirection == "->en" ) then
			for index, value in NuNData[pKey] do
				if ( NuNData[pKey][index].faction ) then
					if ( NuNData[pKey][index].faction == "Horde" ) then
						if ( NuNData[pKey][index].cls ) then
							NuNData[pKey][index].cls = NuNGet_TableID(toDeutschHC, NuNData[pKey][index].cls);
						end
					else
						if ( NuNData[pKey][index].race ) then
							NuNData[pKey][index].race = NuNGet_TableID(toDeutschAR, NuNData[pKey][index].race);
						end
						if ( NuNData[pKey][index].cls ) then
							NuNData[pKey][index].cls = NuNGet_TableID(toDeutschAC, NuNData[pKey][index].cls);
						end
					end
					if ( NuNData[pKey][index].prof1 ) then
						NuNData[pKey][index].prof1 = NuNGet_TableID(toDeutschP, NuNData[pKey][index].prof1);
					end
					if ( NuNData[pKey][index].prof2 ) then
						NuNData[pKey][index].prof2 = NuNGet_TableID(toDeutschP, NuNData[pKey][index].prof2);
					end
				end
			end
		end
	end
end



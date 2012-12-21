BGBUDDY_TITLE = "BGBuddy";
BGBUDDY_VERSION = "v2.2";

local lastkill = 0;
local sessionhonor = 0;
local sessionkillhonor = 0;
local bonusHonor = -1;

local current_line = 1;
local debug_enable = 0;

local last_GameTime = 0;
local this_GameTime = 0;
local timer_nextRes = nil;
local resTimeSet = false;

local lines = { };
local kill_log = { };

local soundplayed = { };
local honorshown = false;

function BGBuddy_OnLoad()
	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UPDATE_WORLD_STATES");
	this:RegisterEvent("BATTLEFIELDS_SHOW");
	this:RegisterEvent("BATTLEFIELDS_CLOSED");
	this:RegisterEvent("UPDATE_BATTLEFIELD_SCORE");
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	this:RegisterEvent("PLAYER_PVP_KILLS_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
	this:RegisterEvent("PLAYER_DEAD");
end

function BGBuddy_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		BGBuddy_Init();
		return;
	end

	if ( BGBuddy_SavedVars["config"]["isEnabled"] == 0 ) then 
		return;
	end

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		RequestBattlefieldScoreData();
		BGBuddy_Initialize();
	end

	if ( event == "UPDATE_BATTLEFIELD_SCORE" ) then
		RequestBattlefieldScoreData();
	end
	
	if ( event == "UPDATE_BATTLEFIELD_STATUS" ) then
		RequestBattlefieldScoreData();
	end

	if ( event == "PLAYER_DEAD" ) then
		BGBuddy_AutoRelease();
	end

	if ( event == "PLAYER_PVP_KILLS_CHANGED" ) then
		RequestBattlefieldScoreData();
	end

	if ( event == "CHAT_MSG_COMBAT_HONOR_GAIN" ) then
		_, _, _, _, lastchathonor = string.find(arg1, "^(.+) ([^:]+:[^:]+): (%d+)");
		_, _, _, _, lastchatkill = string.find(arg1, "a" );

		-- update honor with the new estimate
		if ( lastchathonor == nil ) then
			return;
		else
			sessionhonor = sessionhonor + lastchathonor;
			sessionkillhonor = sessionkillhonor + lastchathonor;
			lastkill = lastchathonor;
		end
	end

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		if ( bonusHonor ~= nil and bonusHonor >= 0 ) then
			BGBuddy_ChatReport( BGBUDDY_MSG_ENDOFBATTLE_REPORT );
			BGBuddy_ChatReport( BGBUDDY_MSG_ENDOFBATTLE_KILLHONOR..sessionhonor..
			                     " "..BGBUDDY_MSG_ENDOFBATTLE_BONUSHONOR..bonusHonor );
			sessionhonor = sessionhonor + bonusHonor;
			BGBuddy_ChatReport( BGBUDDY_MSG_ENDOFBATTLE_TOTALHONOR..sessionhonor );
		end
		bonusHonor = -1;
	end
end

function BGBuddy_HandleSlashes(arg1)
	arg1 = string.lower(arg1);
	if( arg1 == "debug" or arg1 == "db" ) then
		BGBuddy_ToggleDebug();
	else
		ShowUIPanel(BGBuddy_ConfigPanel_CustomizeDisplay);
	end
end

function BGBuddy_Init()
	if(myAddOnsFrame) then
		myAddOnsList.BGBuddy = {
			name = 'BGBuddy',
			description = BGBUDDY_ABOUT_DESCRIPTION,
			version = BGBUDDY_VERSION,
			category = MYADDONS_CATEGORY_OTHERS,
			frame = 'BGBuddy_StandardFrame',
			optionsframe = 'BGBuddy_ConfigPanel'
		};
	end

	PanelTemplates_SetNumTabs(BGBuddy_ConfigPanel_CustomizeDisplay, 3);
	BGBuddy_ConfigPanel_CustomizeDisplay.selectedTab = 1;
	PanelTemplates_UpdateTabs(BGBuddy_ConfigPanel_CustomizeDisplay);
	
	BGBuddy_ConfigPanel_AboutTitle:SetText(BGBUDDY_TITLE.." "..BGBUDDY_VERSION);

	SLASH_BGBuddy1 = "/bgbuddy";
	SLASH_BGBuddy2 = "/bgb";
	SlashCmdList["BGBuddy"] = BGBuddy_HandleSlashes;

	if (BGBuddy_SavedVars == nil) then
		BGBuddy_SavedVars = {
			config = { },
			alterac_valley = { 
				customizeText = nil,
			},
			warsong_gulch = { 
				customizeText = nil,
			},
			arathi_basin = { 
				customizeText = nil,
			},
			not_queued = {
				customizeText = nil,
			},
			queued = {
				customizeText = nil,
				showQueuedSeconds = nil,
			},
		};
	end

	-- Now handle upgrades, data format has changed.
	if (BGBuddy_SavedVars["config"] == nil) then
		BGBuddy_SavedVars["config"] = { };
	end
	if (BGBuddy_SavedVars["alterac_valley"] == nil) then
		BGBuddy_SavedVars["alterac_valley"] = { 
			customizeText = nil,
		};
	end
	if (BGBuddy_SavedVars["warsong_gulch"] == nil) then
		BGBuddy_SavedVars["warsong_gulch"] = { 
			customizeText = nil,
		};
	end
	if (BGBuddy_SavedVars["arathi_basin"] == nil) then
		BGBuddy_SavedVars["arathi_basin"] = { 
			customizeText = nil,
		};
	end
	if (BGBuddy_SavedVars["not_queued"] == nil) then
		BGBuddy_SavedVars["not_queued"] = { 
			customizeText = nil,
		};
	end
	if (BGBuddy_SavedVars["queued"] == nil) then
		BGBuddy_SavedVars["queued"] = { 
			customizeText = nil,
			showQueuedSeconds = nil,
		};
	end

	BGBuddy_SavedVars["version"] = BGBUDDY_VERSION;

	if ( BGBuddy_SavedVars["daily_honor"] == nil
		or BGBuddy_SavedVars["daily_honor_expire"] == nil) then
		BGBuddy_SavedVars["daily_honor"] = 0;
		BGBuddy_SavedVars["daily_honor_expire"] = "???";
	end
    --if ( BGBuddy_SavedVars["daily_honor_expire"] 

	--
	-- General Config
	--
	if (BGBuddy_SavedVars["config"]["isEnabled"] == nil) then
		BGBuddy_SavedVars["config"]["isEnabled"] = 1;
	end
	if (BGBuddy_SavedVars["config"]["isLocked"] == nil) then
		BGBuddy_SavedVars["config"]["isLocked"] = 0;
	end
	if (BGBuddy_SavedVars["config"]["isAlwaysVisible"] == nil) then
		BGBuddy_SavedVars["config"]["isAlwaysVisible"] = 1;
	end
	if (BGBuddy_SavedVars["config"]["playSound"] == nil) then
		BGBuddy_SavedVars["config"]["playSound"] = 1;
	end
	if (BGBuddy_SavedVars["config"]["backgroundAlpha"] == nil) then
		BGBuddy_SavedVars["config"]["backgroundAlpha"] = 50;
	end
	if (BGBuddy_SavedVars["config"]["borderAlpha"] == nil) then
		BGBuddy_SavedVars["config"]["borderAlpha"] = 50;
	end
	if (BGBuddy_SavedVars["config"]["hideBGIcon"] == nil) then
		BGBuddy_SavedVars["config"]["hideBGIcon"] = 1;
	end
	if (BGBuddy_SavedVars["config"]["AutoJoin"] == nil) then
		BGBuddy_SavedVars["config"]["AutoJoin"] = 1;
	end
        if ( BGBuddy_SavedVars["config"]["delayedAutoJoin"] == nil ) then
		BGBuddy_SavedVars["config"]["delayedAutoJoin"] = 1;
	end
	if (BGBuddy_SavedVars["config"]["AutoRes"] == nil) then
		BGBuddy_SavedVars["config"]["AutoRes"] = 1;
	end
	if (BGBuddy_SavedVars["config"]["AutoRelease"] == nil) then
		BGBuddy_SavedVars["config"]["AutoRelease"] = 1;
	end
	if (BGBuddy_SavedVars["config"]["displayRank"] == nil) then
		BGBuddy_SavedVars["config"]["displayRank"] = 1;
	end
	if (BGBuddy_SavedVars["config"]["hideDisplay"] == nil) then
		BGBuddy_SavedVars["config"]["hideDisplay"] = 0;
	end
	if ( BGBuddy_SavedVars["config"]["alwaysShowHonor"] == nil ) then
		BGBuddy_SavedVars["config"]["alwaysShowHonor"] = 1;
	end
	if ( BGBuddy_SavedVars["config"]["autoLeaveBG"] == nil ) then
		BGBuddy_SavedVars["config"]["autoLeaveBG"] = 0;
	end
	if ( BGBuddy_SavedVars["config"]["uiScale"] == nil ) then
		BGBuddy_SavedVars["config"]["uiScale"] = 0;
	end

	--
	-- Alterac Valley Defaults
	--
	if( BGBuddy_SavedVars["alterac_valley"]["customizeText"] == nil ) then
		BGBuddy_SavedVars["alterac_valley"]["customizeText"] = "#: ~S K: ~K KB: ~KB D: ~D\n"..
		"GYA: ~GYA GYD: ~GYD TA: ~TA TD: ~TD\nHonor: ~SH Last Kill: ~LKH\n"..
		"MC: ~MC LDK: ~LDK SO: ~SO\nNext Res: ~RES\nCurrently In: ~BG\nNext Res: ~RES";
	end

	--
	-- Warsong Gulch Defaults
	--
	if( BGBuddy_SavedVars["warsong_gulch"]["customizeText"] == nil ) then
		BGBuddy_SavedVars["warsong_gulch"]["customizeText"] = "#: ~S K: ~K KB: ~KB D: ~D\n"..
		"Honor Totals\nKills: ~KH Bonus: ~BH\nTotal: ~SH  Last Kill: ~LKH\nNext Res: ~RES\n"..
		"Currently In: ~BG";
	end

	--
	-- Arathi Basin Defaults
	--
	if( BGBuddy_SavedVars["arathi_basin"]["customizeText"] == nil ) then
		BGBuddy_SavedVars["arathi_basin"]["customizeText"] = "#: ~S K: ~K KB: ~KB D: ~D\n"..
		"Honor Totals\nKills: ~KH Bonus: ~BH\nTotal: ~SH  Last Kill: ~LKH\nNext Res: ~RES\n"..
		"Currently In: ~BG";
		
	end
	--
	-- Not Queued Defaults
	--
	if( BGBuddy_SavedVars["not_queued"]["customizeText"] == nil ) then
		BGBuddy_SavedVars["not_queued"]["customizeText"] = "~NQ";
	end
	--
	-- Queued Defaults
	--
	if( BGBuddy_SavedVars["queued"]["customizeText"] == nil ) then
		BGBuddy_SavedVars["queued"]["customizeText"] = "~Q";
	end
	
	-- Set the default ui up
	BGBuddy_Config_ChangeCustomDisplay("AV");
	BGBuddy_Config_SetButtonState(BGBuddy_ConfigPanel_Button_AV);
end


function BGBuddy_OnUpdate()
    -- Update time
    this_GameTime = GetTime();
    
	if ( BGBuddy_SavedVars["config"]["isEnabled"] == 1 ) then 
		BGBuddy_UpdateDisplay();
		BGBuddy_AutoRelease();
		
		-- Auto leave
		if( GetBattlefieldWinner() ~= nil ) then
			if ( BGBuddy_SavedVars["config"]["autoLeaveBG"] == 1 ) then
				LeaveBattlefield();
			end
		end
	
		if ( BGBuddy_SavedVars["config"]["displayRank"] == 1 ) then
			BGBuddy_RankFrame:Show();
		else
			BGBuddy_RankFrame:Hide();
		end
	else
		BGBuddy_StandardFrame:Hide();
	end
end

function BGBuddy_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, BGBuddy_DropDown_Initialize, "MENU");
end

function BGBuddy_DropDown_Initialize()
--[[	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName, instanceID = GetBattlefieldStatus(i)
	end
	
	local status, _, _ = GetBattlefieldStatus();
	local info;
	if ( status == "queued" ) then
		info = {};
		info.text = BGBUDDY_DROPDOWN_CHANGEINSTANCE;
		info.func = ShowBattlefieldList;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		info = {};
		info.text = BGBUDDY_DROPDOWN_LEAVEQUEUE;
		info.func = AcceptBattlefieldPort;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	elseif ( status == "confirm" ) then
		info = {};
		info.text = BGBUDDY_DROPDOWN_ACCEPTPORT;
		info.func = BattlefieldFrame_EnterBattlefield;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		info = {};
		info.text = BGBUDDY_DROPDOWN_LEAVEQUEUE;
		info.func = AcceptBattlefieldPort;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end]]
end


function BGBuddy_OnEnter()
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	GameTooltip:SetText(BGBUDDY_TITLE.." "..BGBUDDY_VERSION, 255/255, 209/255, 0/255);
	GameTooltip:AddLine(BGBUDDY_TOOLTIP_DEFAULT, 1.00, 1.00, 1.00);	
	GameTooltip:Show();

end


function BGBuddy_OnEnterScoreFrame()
	if ( BGBuddy_StandardFrame.status == "queued" or BGBuddy_StandardFrame.status == "confirm" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetText(BGBUDDY_TOOLTIP_BUTTON, 1, 1, 1);
		GameTooltip:Show();
	elseif ( BGBuddy_StandardFrame.status == "active" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetText(BGBUDDY_TOOLTIP_BUTTON_ACTIVE_LN1..BGBuddy_StandardFrame.mapName.." "..
					BGBuddy_StandardFrame.instanceID, 255/255, 209/255, 0/255);
		GameTooltip:AddLine(BGBUDDY_TOOLTIP_BUTTON_ACTIVE_LN2, 1.00, 1.00, 1.00);	
		GameTooltip:Show();
	end
end


function BGBuddy_Initialize()
	BGBuddy_SetRankInfo(GetPVPRankInfo(UnitPVPRank("player")));
	BGBuddy_UpdateDisplay();
	BGBuddy_Config_SetAlpha();

	if ( BGBuddy_SavedVars["config"]["hideDisplay"] == 1 ) then
		BGBuddy_StandardFrame:Hide();
	else
		BGBuddy_StandardFrame:Show();
	end
end


function BGBuddy_SetRankInfo(rankName, rankNumber)
	if ( rankNumber < 1 ) then
		BGBuddy_RankName:SetText(BGBUDDY_PLAYER_RANK_UNRANKED);
		BGBuddy_RankFrameIcon:Hide();
	else
		BGBuddy_RankName:SetText(rankName);
		BGBuddy_RankFrameIcon:SetTexture(format("%s%02d","Interface\\PvPRankBadges\\PvPRank", rankNumber));
	end
end

-- GetBattlefieldInfo(0); ???
-- ShowBattlefieldList(0);  ???
-- GetNumBattlefields(); Number fo instances on the menu in range

function BGBuddy_UpdateDisplay()
	-- Reset the display
	BGBuddy_ClearLines();
	
	-- Get all battlefield statuses
	local bgStatus = { };
	local hasBGStatus = nil;
	honorshown = false;
	
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName, instanceID = GetBattlefieldStatus(i);
		bgStatus[i] = { };
		bgStatus[i]["status"] = status;
		bgStatus[i]["map"] = mapName;
		bgStatus[i]["id"] = instanceID;
		
		-- Show honor on top if we've opted to always display it
		if ( BGBuddy_SavedVars["config"]["alwaysShowHonor"] == 1 
			and honorshown == false
			and  status ~= "active" ) then
			BGBuddy_AddLine(NORMAL_FONT_COLOR_CODE..BGBUDDY_ALWAYS_SHOW_HONOR_STRING..
				HIGHLIGHT_FONT_COLOR_CODE..sessionhonor..FONT_COLOR_CODE_CLOSE);
			honorshown = true;
		end
		
		if( status == "queued" ) then
			hasBGStatus = true;
			BGBuddy_ProcessSingleQueue(i, bgStatus[i]);
		elseif( status == "confirm" ) then
			hasBGStatus = true;
			BGBuddy_ProcessReady(i, bgStatus[i]);
		elseif( status == "active" ) then
			hasBGStatus = true;
			BGBuddy_ProcessActive(bgStatus[i]);
		end
	end

	-- No PvP right now? :(
	if( hasBGStatus == nil ) then
		BGBuddy_ProcessNotQueued();
	end

	BGBuddy_StandardFrame.status = "ERROR";
	BGBuddy_StandardFrame.mapName = "ERROR";
	BGBuddy_StandardFrame.instanceID = "ERROR";

	BGBuddy_DisplayLines();
end

-- Function to be called if there are NO active queues
function BGBuddy_ProcessNotQueued()
	
	BGBuddy_AddLine(GRAY_FONT_COLOR_CODE..BGBUDDY_NOT_IN_QUEUE..FONT_COLOR_CODE_CLOSE);

	-- Handle mod visibility preferences
	if ( BGBuddy_SavedVars["config"]["isAlwaysVisible"] == 0 ) then
		BGBuddy_StandardFrame:Hide();
	else
		if ( BGBuddy_SavedVars["config"]["hideDisplay"] == 0 ) then
			BGBuddy_StandardFrame:Show();
		end
	end
	
	BGBuddy_OverlayFrame_EnterButton:Hide();
	BGBuddy_OverlayFrame_LeaveButton:Hide();
	BGBuddy_ScoreFrame:Hide();
end

-- Function to be called for each queued battleground
-- this must not interfere with active battlegrounds
function BGBuddy_ProcessSingleQueue(index, bgStatus)

	soundplayed[bgStatus["map"]] = false;
	
	local waitTime = GetBattlefieldEstimatedWaitTime(index);
	local timeInQueue = GetBattlefieldTimeWaited(index)/1000;
	timeInQueue = SecondsToTime(timeInQueue, BGBuddy_SavedVars["queued"]["showQueuedSeconds"] );

	-- We really should show seconds if minutes are 0
	if( timeInQueue == "" and BGBuddy_SavedVars["queued"]["showQueuedSeconds"] ~= nil ) then
		timeInQueue = GetBattlefieldTimeWaited(index)/1000;
		timeInQueue = SecondsToTime(timeInQueue);
	end

	if ( waitTime == 0 ) then
		waitTime = UNAVAILABLE;
	elseif ( waitTime < 60000 ) then
		waitTime = LESS_THAN_ONE_MINUTE;
	else
		waitTime = SecondsToTime(waitTime/1000, 1);
	end
	
	if( bgStatus["id"] ~= 0 ) then
		BGBuddy_AddLine(NORMAL_FONT_COLOR_CODE..BGBUDDY_IN_QUEUE..FONT_COLOR_CODE_CLOSE..
				GREEN_FONT_COLOR_CODE..bgStatus["map"].." "..bgStatus["id"]..
				FONT_COLOR_CODE_CLOSE);
	else	-- If first availible
		BGBuddy_AddLine(NORMAL_FONT_COLOR_CODE..BGBUDDY_IN_QUEUE..FONT_COLOR_CODE_CLOSE..
				GREEN_FONT_COLOR_CODE..bgStatus["map"]..FONT_COLOR_CODE_CLOSE..
				GREEN_FONT_COLOR_CODE.." "..BGBUDDY_FIRST_AVAILABLE..FONT_COLOR_CODE_CLOSE);
	end

	BGBuddy_AddLine(HIGHLIGHT_FONT_COLOR_CODE..waitTime.." ("..GRAY_FONT_COLOR_CODE..
			timeInQueue..FONT_COLOR_CODE_CLOSE..")"..FONT_COLOR_CODE_CLOSE);

	if ( BGBuddy_SavedVars["config"]["hideDisplay"] == 0 ) then
		BGBuddy_StandardFrame:Show();
		BGBuddy_ScoreFrame:Show();
		if ( BGBuddy_SavedVars["config"]["hideBGIcon"] == 1 ) then
			MiniMapBattlefieldFrame:Hide();
		else
			MiniMapBattlefieldFrame:Show();
		end
	end
	BGBuddy_OverlayFrame_EnterButton:Hide();
	BGBuddy_OverlayFrame_LeaveButton:Hide();
end

-- Function to be called for and active battleground
-- can only be called once per update (duh)
function BGBuddy_ProcessActive(bgStatus)
    	RequestBattlefieldScoreData();
	
	local playerName = UnitName("player");
	local av = BGBuddy_SavedVars["alterac_valley"];
	local wsg = BGBuddy_SavedVars["warsong_gulch"];
	local ab = BGBuddy_SavedVars["arathi_basin"];
	local numScores = GetNumBattlefieldScores();
	local name, kills, killingblows, deaths, honorgained, faction, rank, race, class;
	local totalplayers = 0;
	local playerstanding = 0;
	local playerkills = 0;
	local playerkillingblows = 0;
	local playerdeaths = 0;
	local playerhonorgained = 0;
	local playerfaction = 0;
	local playerrank = 0;
	local playerrace = 0;
	local playerclass = 0;

	BGBuddy_SyncResTimer();

	for i=1, 80 do
		name, _, _, _, _, _, _, _, playerclass = GetBattlefieldScore(i);
		if ( playerclass ~= nil ) then
			totalplayers = totalplayers + 1;
		else
			break;
		end

		if ( name == playerName ) then
			playerstanding = i;
			_, playerkillingblows, playerkills, playerdeaths, playerhonorgained, playerfaction, playerrank, playerrace, _ = GetBattlefieldScore(i);
			playerlifetimekills,_,_ = GetPVPLifetimeStats();
			bonusHonor = playerhonorgained;
		end
	end

	if( bgStatus["map"] == BGBUDDY_BATTLEGROUND_ALTERAC_VALLEY ) then
		local numStatColumns = GetNumBattlefieldStats();
		for j=1, MAX_NUM_STAT_COLUMNS do
			if ( j <= numStatColumns ) then
				columnData = GetBattlefieldStatData(playerstanding, j);
				if (j==1) then 
					playergraveyardsassaulted = columnData;
				elseif (j==2) then 
					playergraveyardsdefended = columnData;
				elseif (j==3) then 
					playertowersassaulted = columnData;
				elseif (j==4) then 
					playertowersdefended = columnData;
				elseif (j==5) then 
					playerminescaptured = columnData;
				elseif (j==6) then 
					playerleaderskilled = columnData;
				elseif (j==7) then 
					playersecondaryobjectives = columnData; 
				end				
			end
		end
	elseif( bgStatus["map"] == BGBUDDY_BATTLEGROUND_ARATHI_BASIN ) then
		local numStatColumns = GetNumBattlefieldStats();
		for j=1, MAX_NUM_STAT_COLUMNS do
			if ( j <= numStatColumns ) then
				columnData = GetBattlefieldStatData(playerstanding, j);
				if (j==1) then
					playergraveyardsassaulted = columnData;
				elseif (j==2) then
					playergraveyardsdefended = columnData; 
				else
					break;
				end
			end
		end
		playertowersassaulted = GetBattlefieldWinner();
		if( playertowersassaulted == nil ) then playertowersassaulted = "N/A"; end
		playertowersdefended = "N/A";
		playerminescaptured = "N/A";
		playerleaderskilled = "N/A";
		playersecondaryobjectives = "N/A";
	else
		playergraveyardsassaulted = "N/A";
		playergraveyardsdefended = "N/A";
		playertowersassaulted = "N/A";
		playertowersdefended = "N/A";
		playerminescaptured = "N/A";
		playerleaderskilled = "N/A";
		playersecondaryobjectives = "N/A";
	end

	-- Just in case some values are still nill
	-- It shouldnt happen, but it does.
	if (playerlifetimekills == nil) then
		playerlifetimekills = "N/A";
	end
	if (playername == nil) then
		playername = "N/A";
	end
	if (playerkills == nil) then
		playerkills = "N/A";
	end
	if (playerdeaths == nil) then
		playerdeaths = "N/A";
	end
	if (playerkillingblows == nil) then
		playerkillingblows = "N/A";
	end
	if (playerhonorgained == nil) then
		playerhonorgained = "N/A";
		bonusHonor = 0;
	end
	if (playerfaction == nil) then
		playerfaction = "N/A";
	end
	if (playerrank == nil) then
		playerrank = "N/A";
	end
	if (playerrace == nil) then
		playerrace = "N/A";
	end
	if (playerclass == nil) then
		playerclass = "N/A";
	end
	if ( playergraveyardsassaulted == nil ) then
	    playergraveyardsassaulted = "N/A";
	end
	if ( playergraveyardsdefended == nil ) then
	    playergraveyardsdefended = "N/A";
	end

	sSub   = HIGHLIGHT_FONT_COLOR_CODE..playerstanding.."/"..totalplayers..NORMAL_FONT_COLOR_CODE;
	kSub   = GRAY_FONT_COLOR_CODE..playerkills..NORMAL_FONT_COLOR_CODE;
	kbSub  = GREEN_FONT_COLOR_CODE..playerkillingblows..NORMAL_FONT_COLOR_CODE;
	lkSub  = HIGHLIGHT_FONT_COLOR_CODE..playerlifetimekills..NORMAL_FONT_COLOR_CODE;
	dSub   = RED_FONT_COLOR_CODE..playerdeaths..NORMAL_FONT_COLOR_CODE;
	shSub  = HIGHLIGHT_FONT_COLOR_CODE..sessionhonor..NORMAL_FONT_COLOR_CODE;
	khSub  = HIGHLIGHT_FONT_COLOR_CODE..sessionkillhonor..NORMAL_FONT_COLOR_CODE;
	lkhSub = HIGHLIGHT_FONT_COLOR_CODE..lastkill..NORMAL_FONT_COLOR_CODE;
	bhSub  = HIGHLIGHT_FONT_COLOR_CODE..playerhonorgained..NORMAL_FONT_COLOR_CODE;
	gyaSub = RED_FONT_COLOR_CODE..playergraveyardsassaulted..NORMAL_FONT_COLOR_CODE;
	gydSub = GREEN_FONT_COLOR_CODE..playergraveyardsdefended..NORMAL_FONT_COLOR_CODE;
	taSub  = RED_FONT_COLOR_CODE..playertowersassaulted..NORMAL_FONT_COLOR_CODE;
	tdSub  = GREEN_FONT_COLOR_CODE..playertowersdefended..NORMAL_FONT_COLOR_CODE;
	mcSub  = HIGHLIGHT_FONT_COLOR_CODE..playerminescaptured..NORMAL_FONT_COLOR_CODE;
	ldkSub = HIGHLIGHT_FONT_COLOR_CODE..playerleaderskilled..NORMAL_FONT_COLOR_CODE;
	soSub  = HIGHLIGHT_FONT_COLOR_CODE..playersecondaryobjectives..NORMAL_FONT_COLOR_CODE;
	bgSub  = GREEN_FONT_COLOR_CODE..bgStatus["map"].." "..bgStatus["id"]..FONT_COLOR_CODE_CLOSE;
	
	if( resTimeSet == false ) then
	    resSub = RED_FONT_COLOR_CODE.."N/A"..NORMAL_FONT_COLOR_CODE;
	else
	    local time_left = ceil(timer_nextRes - this_GameTime);
	    
	    if( time_left == 31 ) then
		 resSub = RED_FONT_COLOR_CODE.."RES!"..NORMAL_FONT_COLOR_CODE;
	    elseif( time_left < 6 ) then
		resSub = RED_FONT_COLOR_CODE..time_left..NORMAL_FONT_COLOR_CODE;
	    elseif( time_left < 15 ) then
		resSub = GREEN_FONT_COLOR_CODE..time_left..NORMAL_FONT_COLOR_CODE;
	    else
		resSub = HIGHLIGHT_FONT_COLOR_CODE..time_left..NORMAL_FONT_COLOR_CODE;
	    end
	end

	newString = nil;

	if ( bgStatus["map"] == BGBUDDY_BATTLEGROUND_ALTERAC_VALLEY ) then
		newString = BGBuddy_SavedVars["alterac_valley"]["customizeText"];
	elseif ( bgStatus["map"] == BGBUDDY_BATTLEGROUND_WARSONG_GULCH ) then
		newString = BGBuddy_SavedVars["warsong_gulch"]["customizeText"];
	elseif ( bgStatus["map"] == BGBUDDY_BATTLEGROUND_ARATHI_BASIN ) then
		newString = BGBuddy_SavedVars["arathi_basin"]["customizeText"];
	end

	if ( newString ~= nil ) then
		newString = gsub(newString,"~LKH",lkhSub);
		newString = gsub(newString,"~LDK",ldkSub);
		newString = gsub(newString,"~GYA",gyaSub);
		newString = gsub(newString,"~GYD",gydSub);
		newString = gsub(newString,"~KB",kbSub);
		newString = gsub(newString,"~LK",lkSub);
		newString = gsub(newString,"~SH",shSub);
		newString = gsub(newString,"~KH",khSub);
		newString = gsub(newString,"~BH",bhSub);
		newString = gsub(newString,"~TA",taSub);
		newString = gsub(newString,"~TD",tdSub);
		newString = gsub(newString,"~MC",mcSub);
		newString = gsub(newString,"~SO",soSub);
		newString = gsub(newString,"~K",kSub);
		newString = gsub(newString,"~D",dSub);
		newString = gsub(newString,"~S",sSub);
		newString = gsub(newString,"~BG",bgSub);
		newString = gsub(newString,"~RES",resSub);
		BGBuddy_AddLine(NORMAL_FONT_COLOR_CODE..newString);
	end

	if ( BGBuddy_SavedVars["config"]["hideBGIcon"] == 1 ) then
		MiniMapBattlefieldFrame:Hide();
	else
		MiniMapBattlefieldFrame:Show();
	end
	
	BGBuddy_OverlayFrame_EnterButton:Hide();
	BGBuddy_OverlayFrame_LeaveButton:Hide();
	BGBuddy_OverlayFrame_SwitchButton:Hide();
	
	if ( BGBuddy_SavedVars["config"]["hideDisplay"] == 0 ) then
		BGBuddy_ScoreFrame:Show();
		BGBuddy_StandardFrame:Show();
	end
end

-- Function to be called for each battleground that
-- is ready to join
function BGBuddy_ProcessReady(index, bgStatus)
	
	if ( BGBuddy_SavedVars["config"]["playSound"] == 1 and soundplayed[bgStatus["map"]] == false) then
		PlaySoundFile("Interface\\AddOns\\BGBuddy\\BGBuddy_BattlegroundReady.wav");
		soundplayed[bgStatus["map"]] = true;
	end

	BGBuddy_AddLine(GREEN_FONT_COLOR_CODE..bgStatus["map"]..FONT_COLOR_CODE_CLOSE..
			HIGHLIGHT_FONT_COLOR_CODE..BGBUDDY_BATTLEGROUND_READY..FONT_COLOR_CODE_CLOSE);

	local expireTime = GetBattlefieldPortExpiration(index)/1000
	local autoJoinTime = SecondsToTime(expireTime-2);
	local manualJoinTime = SecondsToTime(expireTime);
	if ( BGBuddy_SavedVars["config"]["delayedAutoJoin"] == 1 
	     and BGBuddy_SavedVars["config"]["AutoJoin"] == 1 ) then
		BGBuddy_AddLine(NORMAL_FONT_COLOR_CODE..BGBUDDY_BATTLEGROUND_JOIN_TIME..
				FONT_COLOR_CODE_CLOSE..RED_FONT_COLOR_CODE..autoJoinTime..FONT_COLOR_CODE_CLOSE);
	else
		BGBuddy_AddLine(NORMAL_FONT_COLOR_CODE..BGBUDDY_BATTLEGROUND_JOIN_EXPIRE..
				FONT_COLOR_CODE_CLOSE..RED_FONT_COLOR_CODE..manualJoinTime..FONT_COLOR_CODE_CLOSE);
	end
	
	BGBuddy_AutoJoin(index);

	StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
	if ( BGBuddy_SavedVars["config"]["hideBGIcon"] == 1 ) then
		MiniMapBattlefieldFrame:Hide();
	else
		MiniMapBattlefieldFrame:Show();
	end
	
	BGBuddy_OverlayFrame_LeaveButton:Hide();
	
	if ( BGBuddy_SavedVars["config"]["hideDisplay"] == 0 ) then
		BGBuddy_StandardFrame:Show();
		BGBuddy_OverlayFrame_EnterButton:Show();
		BGBuddy_ScoreFrame:Show();
	end
	bonusHonor = -1;
end


-- Add a line to the ui display
function BGBuddy_AddLine(arg1)
	lines[current_line] = arg1;
	current_line = current_line + 1;
end

function BGBuddy_ClearLines()
	lines = { };
	current_line = 1;
end

function BGBuddy_DisplayLines()
	-- Clear out the UI text field
	BGBuddy_Line1:SetText("");
	
	local lineCount = 0;
	local display_text = "";
	for i=1, (current_line+1) do
		if( lines[i] ~= nil ) then
			if( i ~= 1) then
				display_text = display_text.."\n";
			end

			display_text = display_text..lines[i];
			lineCount = lineCount + 1;
		end
	end
	BGBuddy_Line1:SetText(display_text);

	local baseHeight = 0;
	if( lineCount > 0 ) then
		baseHeight = baseHeight + math.floor(lineCount * 13);
	end

	maxWidth = BGBuddy_Line1:GetWidth();
	if ( (BGBuddy_RankName:GetWidth()+40) > maxWidth and BGBuddy_SavedVars["config"]["displayRank"] == 1 ) then
		maxWidth = BGBuddy_RankName:GetWidth() + 40;
	end

	if ( BGBuddy_ScoreFrame:IsVisible() ) then
		maxWidth = maxWidth + 17;
	end


	if ( BGBuddy_SavedVars["config"]["displayRank"] == 1 ) then
		baseHeight = baseHeight + 16;
		BGBuddy_RankFrame:Show();
	else
		BGBuddy_RankFrame:Hide();
	end

	BGBuddy_StandardFrame:SetHeight(baseHeight);
	BGBuddy_StandardFrame:SetWidth(maxWidth);
end


function BGBuddy_OnMouseDown(arg1)
	if (arg1 == "LeftButton" and BGBuddy_SavedVars["config"]["isLocked"] == 0) then
		BGBuddy_StandardFrame:StartMoving();
	end

	if (arg1 == "RightButton") then
		ShowUIPanel(BGBuddy_ConfigPanel_CustomizeDisplay);
	end
end

function BGBuddy_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		BGBuddy_StandardFrame:StopMovingOrSizing();
	end
end

function BGBuddy_Config_SetCustomDisplay()
	custom_text = ConfigureBodyEditBox:GetText();

	if ( AVLabel:IsVisible() == 1 ) then
		BGBuddy_SavedVars["alterac_valley"]["customizeText"] = custom_text;
	elseif ( WSGLabel:IsVisible() == 1 ) then
		BGBuddy_SavedVars["warsong_gulch"]["customizeText"] = custom_text;
	elseif ( ABLabel:IsVisible() == 1 ) then
		BGBuddy_SavedVars["arathi_basin"]["customizeText"] = custom_text;
	end
end

-- Sets the check boxes and line text to match the current saved settings
function BGBuddy_Config_ChangeCustomDisplay(bg)
	custom_text = " ";

	AVLabel:Hide();
	WSGLabel:Hide();
	ABLabel:Hide();

	LegendValue2_AV:Hide();
	LegendValue2_WSG:Hide();
	LegendValue2_AB:Hide();

	LegendEquals2_AV:Hide();
	LegendEquals2_WSG:Hide();

	LegendKeys2_AV:Hide();
	LegendKeys2_WSG:Hide();
	
	if ( bg == "AV" ) then
		AVLabel:Show();
		LegendValue2_AV:Show();
		LegendEquals2_AV:Show();
		LegendKeys2_AV:Show();
		custom_text = BGBuddy_SavedVars["alterac_valley"]["customizeText"];
	elseif ( bg == "WSG" ) then
		WSGLabel:Show();
		LegendValue2_WSG:Show();
		LegendEquals2_WSG:Show();
		LegendKeys2_WSG:Show()
		custom_text = BGBuddy_SavedVars["warsong_gulch"]["customizeText"];
	elseif ( bg == "AB" ) then
		ABLabel:Show();
		LegendValue2_AB:Show();
		LegendEquals2_WSG:Show();
		LegendKeys2_WSG:Show();
		custom_text = BGBuddy_SavedVars["arathi_basin"]["customizeText"];
	else
		return;
	end

	ConfigureBodyEditBox:SetText(custom_text);
end

function BGBuddy_Config_ChangeCustomDisplayNBG(tab)
	custom_text = "";

	AVLabel:Hide();
	WSGLabel:Hide();
	ABLabel:Hide();

	LegendValue2_AV:Hide();
	LegendValue2_WSG:Hide();
	LegendValue2_AB:Hide();

	LegendEquals2_AV:Hide();
	LegendEquals2_WSG:Hide();

	LegendKeys2_AV:Hide();
	LegendKeys2_WSG:Hide();
	
	if ( bg == "AV" ) then
		AVLabel:Show();
		LegendValue2_AV:Show();
		LegendEquals2_AV:Show();
		LegendKeys2_AV:Show();
		custom_text = BGBuddy_SavedVars["queued"]["customizeText"];
	elseif ( bg == "WSG" ) then
		WSGLabel:Show();
		LegendValue2_WSG:Show();
		LegendEquals2_WSG:Show();
		LegendKeys2_WSG:Show()
		custom_text = BGBuddy_SavedVars["not_queued"]["customizeText"];
	else
		return;
	end

	ConfigureBodyEditBox:SetText(custom_text);
end

--
-- Timers
--
-- Sync the res timers, or try to keep count
function BGBuddy_SyncResTimer()
    local spiritTimer = GetAreaSpiritHealerTime();
    
    if( spiritTimer ~= 0 and spiritTimer ~= nil ) then
        timer_nextRes = ceil(this_GameTime) + spiritTimer;
        resTimeSet = true;
        return;
    end

    if( resTimeSet == true ) then
        -- Countdown is -1 < x < 31.
        while( (timer_nextRes - this_GameTime) < 0 ) do
            timer_nextRes = timer_nextRes + 31;
        end
        
        -- Only decrement the counter about once per second
        if( (floor(this_GameTime) - ceil(last_GameTime)) >= 1 ) then
            last_GameTime = this_GameTime;
        end
    end
end

-- Update the timers res timer when it hits 0
function BGBuddy_UpdateResTimer()

end


--
-- UI Button Panels
--
-- Enables all buttons, then disables the currently active button
function BGBuddy_Config_SetButtonState(button)
	-- BG
	BGBuddy_ConfigPanel_CustomizeDisplay.selectedTab = button;
	PanelTemplates_UpdateTabs(BGBuddy_ConfigPanel_CustomizeDisplay);
end

-- Sets up the customize drop down
function BGBuddy_ConfigPanel_CustomizeDropdown_OnLoad()
	UIDropDownMenu_Initialize( this, BGBuddy_ConfigPanel_CustomizeDropdown_Init );
end

function BGBuddy_ConfigPanel_CustomizeDropdown_Init()
	local battlegrounds = { };
	battlegrounds.text = BGBUDDY_CONFIG_DROPDOWN_BG;
	battlegrounds.value = "bg";
	battlegrounds.func = BGBuddy_ShowConfigPanel;
	battlegrounds.toolTipTitle = BGBUDDY_CONFIG_DROPDOWN_TITLE;
	battlegrounds.toolTipText = BGBUDDY_CONFIG_DROPTOWN_BG_TIP;

--[[	local nonbattlegrounds = { };
	nonbattlegrounds.text = BGBUDDY_CONFIG_DROPDOWN_NONBG;
	nonbattlegrounds.value = "nbg";
	nonbattlegrounds.func = BGBuddy_ShowConfigPanel;
	nonbattlegrounds.toolTipTitle = BGBUDDY_CONFIG_DROPDOWN_TITLE;
	nonbattlegrounds.toolTipText = BGBUDDY_CONFIG_DROPDOWN_NONBG_TIP;
]]
	local general = { };
	general.text = BGBUDDY_CONFIG_DROPDOWN_GENERAL;
	general.value = "gen";
	general.func = BGBuddy_ShowConfigPanel;
	general.toolTipTitle = BGBUDDY_CONFIG_DROPDOWN_TITLE;
	general.toolTipText = BGBUDDY_CONFIG_DROPDOWN_GENERAL_TIP;
	
	UIDropDownMenu_AddButton( battlegrounds, 1 );
--	UIDropDownMenu_AddButton( nonbattlegrounds, 1 );
	UIDropDownMenu_AddButton( general, 1 );
end

function BGBuddy_ShowConfigPanel(id, value)
	if( id == nil ) then
		id = this:GetID();
	end
	if( value == nil ) then
		value = this.value;
	end
	
	UIDropDownMenu_SetSelectedID(BGBuddy_ConfigPanel_CustomizeDropdown, id, nil);

	BGBuddy_ConfigPanel_CustomizeBG:Hide();
--	BGBuddy_ConfigPanel_CustomizeNonBG:Hide();
	BGBuddy_ConfigPanel_CustomizeGeneral:Hide();

	if ( value == "bg" ) then
		BGBuddy_ConfigPanel_CustomizeBG:Show();
--	elseif ( value == "nbg" ) then
--		BGBuddy_ConfigPanel_CustomizeNonBG:Show();
	elseif ( value == "gen" ) then
		BGBuddy_ConfigPanel_CustomizeGeneral:Show();
	end
end

--
-- General Config Handling Functions
--
function BGBuddy_Config_SetAlpha()
	BGBuddy_ConfigPanel_Slider1:SetValue(BGBuddy_SavedVars["config"]["backgroundAlpha"]);
	BGBuddy_ConfigPanel_Slider2:SetValue(BGBuddy_SavedVars["config"]["borderAlpha"]);
end

function BGBuddy_Config_SetBackgroundAlpha()
	BGBuddy_SavedVars["config"]["backgroundAlpha"] = BGBuddy_ConfigPanel_Slider1:GetValue();
	BGBuddy_ConfigPanel_Slider1ValueText:SetText(BGBuddy_SavedVars["config"]["backgroundAlpha"].."%");
	
	alpha = BGBuddy_SavedVars["config"]["backgroundAlpha"];
	alpha = alpha * 0.01;

	BGBuddy_StandardFrame:SetBackdropColor(0, 0, 0, alpha);
end

function BGBuddy_Config_SetBorderAlpha()
	BGBuddy_SavedVars["config"]["borderAlpha"] = BGBuddy_ConfigPanel_Slider2:GetValue();
	BGBuddy_ConfigPanel_Slider2ValueText:SetText(BGBuddy_SavedVars["config"]["borderAlpha"].."%");
	
	alpha = BGBuddy_SavedVars["config"]["borderAlpha"];
	alpha = alpha * 0.01;

	BGBuddy_StandardFrame:SetBackdropBorderColor(1, 1, 1, alpha);
end

function BGBuddy_Config_SetUiScale()
	BGBuddy_SavedVars["config"]["uiScale"] = BGBuddy_ConfigPanel_Slider3:GetValue();
	BGBuddy_ConfigPanel_Slider3ValueText:SetText((100+(math.floor(BGBuddy_SavedVars["config"]["uiScale"])).."%"));

	BGBuddy_StandardFrame:SetScale(1 + (BGBuddy_SavedVars["config"]["uiScale"]/100));
end

function BGBuddy_Config_SetEnabled() 
	if ( BGBuddy_ConfigPanel_EnableBGBuddy:GetChecked() == 1 ) then
		BGBuddy_Initialize();
		BGBuddy_Config_SetVisibilityStatus();
	else
		DEFAULT_CHAT_FRAME:AddMessage(BGBUDDY_TITLE.." "..BGBUDDY_VERSION..BGBUDDY_DISABLED_CHAT_MESSAGE);
		BGBuddy_StandardFrame:Hide();
	end
end

function BGBuddy_Config_SetVisibility() 
	if ( BGBuddy_SavedVars["config"]["hideDisplay"] == 1 ) then
		BGBuddy_StandardFrame:Hide();
		DEFAULT_CHAT_FRAME:AddMessage(BGBUDDY_TITLE.." "..BGBUDDY_VERSION..BGBUDDY_HIDDEN_CHAT_MESSAGE);
	else
		BGBuddy_StandardFrame:Show();
	end
end

function BGBuddy_Config_SetVisibilityStatus() 
	if ( BGBuddy_SavedVars["config"]["isAlwaysVisible"] == 1 ) then
		if ( BGBuddy_SavedVars["config"]["hideDisplay"] == 0 ) then
			BGBuddy_StandardFrame:Show();
		end
	end
end

function BGBuddy_AutoJoin(index)
	local expireTime = GetBattlefieldPortExpiration(index)/1000
	
	if( BGBuddy_SavedVars["config"]["AutoJoin"] == 1 ) then
		if( BGBuddy_SavedVars["config"]["delayedAutoJoin"] == 0 ) then
			AcceptBattlefieldPort(index, true);
			StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
		else
			expireTime = math.floor(expireTime);
			if( expireTime == 2 ) then
				AcceptBattlefieldPort(index, true);
				StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
			end
		end
	end
end

-- Standard as of WoW 1.7
function BGBuddy_AutoRes()
--	local status, _, _ = GetBattlefieldStatus();
--	if ( BGBuddy_ConfigPanel_AutoRes:GetChecked() == 1) then
--		BGBuddy_SavedVars["config"]["AutoRes"] = 1;
--		if ( status == "active" ) then
--
--			if ( UnitIsGhost("player") ) then
--				AcceptAreaSpiritHeal();
--				getglobal("StaticPopup1Button1"):Hide();
--				getglobal("StaticPopup1Button2"):Hide();
--			end
--		end
--	else 
--		BGBuddy_SavedVars["config"]["AutoRes"] = 0;
--	end
end

function BGBuddy_AutoRelease()
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local _, _, instanceID = GetBattlefieldStatus(i)
		
		if( BGBuddy_SavedVars["config"]["AutoRelease"] == 1
	        	and UnitIsDeadOrGhost("player")
	        	and HasSoulstone() == nil
			and instanceID ~= 0 ) then
	        	RepopMe();
		end
	end
end

-- Generic output
function BGBuddy_ChatReport(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg,1,0,0.35);
end

------------------------------
--  Debug Functions
------------------------------
function bgbdebug(msg)
	if( debug_enable == 1 ) then
		BGBuddy_ChatReport( "BGB Debug: "..msg );
	end
end

function BGBuddy_ToggleDebug()
	if( debug_enable == 1 ) then
		debug_enable = 0;
		DEFAULT_CHAT_FRAME:AddMessage("BGB Debugging: Disabled",1,0.65,1);
		return;
	end

	debug_enable = 1;
	DEFAULT_CHAT_FRAME:AddMessage("BGB Debugging: Enabled",1,0.65,1);
end

--[[
Author 1: Znadul (Kor'gall)
Author 2: Corvian (Warsong)
Date: 21/06/2006
Version: 0.8

Description:

Special thnx:
AeneasKuM and mrpel (ui.worldofwar.net) - 1.12 fix
]]--

---------------------------------------------------------------------------------
-- VARIABLES
---------------------------------------------------------------------------------
local lOriginalWorldStateAlwaysUpFrame_Update;
ABHEFS_VERSION = "0.8";

local ABHEFS_FlagsData = {
	[0] = { time = 999999, rate = 999999 },
	[1] = { time = 11, rate = 1.1 },
	[2] = { time = 10, rate = 1 },
	[3] = { time = 6, rate = 0.6 },
	[4] = { time = 3, rate = 0.3 },
	[5] = { time = 1, rate = 0.03333 }
};	

local ABHEFS_POIsData = {
	-- ids: 1-Mine, 2-Lumber, 3-BS, 4-Farm, 5-Stables (not used)
	[16] = { id = 1, faction = "Neutral", conflict = false },
	[17] = { id = 1, faction = "Aliance", conflict = true },
	[18] = { id = 1, faction = "Aliance", conflict = false },
	[19] = { id = 1, faction = "Horde", conflict = true },
	[20] = { id = 1, faction = "Horde", conflict = false },
	[21] = { id = 2, faction = "Neutral", conflict = false },
	[22] = { id = 2, faction = "Aliance", conflict = true },
	[23] = { id = 2, faction = "Aliance", conflict = false },
	[24] = { id = 2, faction = "Horde", conflict = true },
	[25] = { id = 2, faction = "Horde", conflict = false },
	[26] = { id = 3, faction = "Neutral", conflict = false },
	[27] = { id = 3, faction = "Aliance", conflict = true },
	[28] = { id = 3, faction = "Aliance", conflict = false },
	[29] = { id = 3, faction = "Horde", conflict = true },
	[30] = { id = 3, faction = "Horde", conflict = false },
	[31] = { id = 4, faction = "Neutral", conflict = false },
	[32] = { id = 4, faction = "Aliance", conflict = true },
	[33] = { id = 4, faction = "Aliance", conflict = false },
	[34] = { id = 4, faction = "Horde", conflict = true },
	[35] = { id = 4, faction = "Horde", conflict = false },
	[36] = { id = 5, faction = "Neutral", conflict = false },
	[37] = { id = 5, faction = "Aliance", conflict = true },
	[38] = { id = 5, faction = "Aliance", conflict = false },
	[39] = { id = 5, faction = "Horde", conflict = true },
	[40] = { id = 5, faction = "Horde", conflict = false }
};

local ABHEFS_FlagsStatus = {
	[ABHEFS_GOLDMINE] = { id = 1, status = -1, timeLeft = 0 },
	[ABHEFS_LUMBERMILL] = { id = 2, status = -1, timeLeft = 0 },
	[ABHEFS_BLACKSMITH] = { id = 3, status = -1, timeLeft = 0 },
	[ABHEFS_FARM] = { id = 4, status = -1, timeLeft = 0 },
	[ABHEFS_STABLES] = { id = 5, status = -1, timeLeft = 0 }
};

local ABHEFS_ScoreStatus = {
	["Aliance"] = { score = 0, lastUpdate = 0, flags = 0, updated = false},
	["Horde"] = { score = 0, lastUpdate = 0, flags = 0, updated = false }
};
	
local ABHEFS_DebugData = { };
	
local ABHEFS_PlayerFaction = nil;

local ABHEFS_TimeLeft = 0;
local ABHEFS_FlagAssaultTime = 64;
local ABHEFS_ShowTime = false;
local ABHEFS_LastLeftTimerUpdate;
local ABHEFS_LastTimersUpdate;
local ABHEFS_isWinning = { faction = 0, score = 0}; -- faction: 1-alliance 2-horde

---------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
---------------------------------------------------------------------------------

function ABHEFSPrint(msg) --*
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 0.5, 1.0);
	end
end

function ABHEFS_ResetStatus() --*
	for i, value in ABHEFS_FlagsStatus do
		value.status = -1;
		value.timeLeft = 0;
	end
	for i, value in ABHEFS_ScoreStatus do
		value.score = 0;
		value.lastUpdate = 0;
		value.flags = 0;
		value.updated = false;
	end
	
end		

function ABHEFS_TimeToStr(time) --*
	if ( time >= 60 ) then
		secs = mod(time, 60);
		mins = (time - secs) / 60;
	else
		mins = 0;
		secs = time;
	end
	if ( mins < 10 ) then mins = "0" .. mins; end
	if ( secs < 10 ) then secs = "0" .. secs; end
	
	timeText = mins .. ":" .. secs;
	
	return timeText;
end

function ABHEFS_SlashHandler(command) --*
	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");

	-- nil prevention
	if (not cmd) then cmd = command; end
	if (not cmd) then cmd = ""; end
	if (not param) then param = ""; end
	
	if (cmd == "on") then
		-- hook
		WorldStateAlwaysUpFrame_Update = ABHEFS_WorldStateAlwaysUpFrame_Update;
		ABHEFSPrint("ABHEFS enabled");
		WorldStateAlwaysUpFrame_Update();
	end

	if (cmd == "off") then
		-- unhook
		WorldStateAlwaysUpFrame_Update = lOriginalWorldStateAlwaysUpFrame_Update;
		ABHEFSPrint("ABHEFS disabled");
		getglobal("ABHEFS_Frame"):Hide();
--		WorldStateAlwaysUpFrame_Update();
	end

	if (cmd == "resetpos") then
		getglobal("ABHEFS_Frame"):ClearAllPoints();
		getglobal("ABHEFS_Frame"):SetPoint("TOPLEFT", "AlwaysUpFrame2", "BOTTOMLEFT", 0, 0);
	end


	if ((cmd == "") or (cmd == "help")) then
		ABHEFSPrint("Usage:");
		ABHEFSPrint(" /ABHEFS (on/off)  | Enable / Disable");
		ABHEFSPrint(" /ABHEFS resetpos  | Reset the frame position");
	end

end

function ABHEFS_TimeTo(faction, endScore) --*
  	-- check for endScore reached
  	if (ABHEFS_ScoreStatus[faction].score >= endScore) then
  		return 0;
  	end
  	
  	timePerTick = ABHEFS_FlagsData[ABHEFS_ScoreStatus[faction].flags].time;
  	

	timeToNextTick = timePerTick - (time() - ABHEFS_ScoreStatus[faction].lastUpdate);

	-- check for reached at next tick
	if (endScore == ABHEFS_ScoreStatus[faction].score + 10) then
		return timeToNextTick;
	end
  	
  	timeTo = (((endScore - (ABHEFS_ScoreStatus[faction].score + 10)) / 10) * timePerTick) + timeToNextTick;
  	return timeTo;
end

function ABHEFS_scoreAfter(faction, seconds) --*
  	timePerTick = ABHEFS_FlagsData[ABHEFS_ScoreStatus[faction].flags].time;

	timeToNextTick = timePerTick - (time() - ABHEFS_ScoreStatus[faction].lastUpdate);
	
	-- check for no changes until second
	if (timeToNextTick > seconds) then 
		return ABHEFS_ScoreStatus[faction].score;
	end

	scoreAfter = ABHEFS_ScoreStatus[faction].score + 10 + (floor((seconds - timeToNextTick) / timePerTick) * 10);
	
	return scoreAfter;
end

function ABHEFS_GetData() --*
	local winner, stat1, stat2;
	local scoreWinner;
	local estimatedTime;
	local min, secs;
	_, stat1 = GetWorldStateUIInfo(1);
	_, stat2 = GetWorldStateUIInfo(2);
	_, _, strAllyBases, strAllyScore = string.find(stat1, ABHEFS_WORLDSTATESTRING);
	_, _, strHordeBases, strHordeScore = string.find(stat2, ABHEFS_WORLDSTATESTRING);
	
	allyBases = tonumber(strAllyBases);
	hordeBases = tonumber(strHordeBases);
	allyScore = tonumber(strAllyScore);
	hordeScore = tonumber(strHordeScore);
	needed = ABHEFS_GetNeeded(allyScore, hordeScore);
	-- check for data and victory 
	if (not allyScore) or (not hordeScore) or (allyScore == 2000) or (hordeScore == 2000) then
		getglobal("ABHEFS_Frame"):Hide();
		ABHEFS_ResetStatus();
		ABHEFS_TimeLeft = 0;
		return;
	else
		getglobal("ABHEFS_Frame"):Show();
	end
	
	-- bases are always updated
	ABHEFS_ScoreStatus["Aliance"].flags = allyBases;
	ABHEFS_ScoreStatus["Horde"].flags = hordeBases;

	-- check for first update
	if (ABHEFS_ScoreStatus["Horde"].lastUpdate == 0) then
		ABHEFS_ScoreStatus["Horde"].score = hordeScore;
		ABHEFS_ScoreStatus["Horde"].lastUpdate = time();
	end
	if (ABHEFS_ScoreStatus["Aliance"].lastUpdate == 0) then
		ABHEFS_ScoreStatus["Aliance"].score = allyScore;
		ABHEFS_ScoreStatus["Aliance"].lastUpdate = time();
	end

	-- check for 5-0
	if (allyBases == 5) then
		return 2000, hordeScore;
	elseif (hordeBases == 5) then
		return allyScore, 2000, nil, needed;
	end
	
	if (allyBases == 0) and (hordeBases == 0) then
		estimatedAlly = "ind.";
		estimatedHorde = "ind.";
		return estimatedAlly, estimatedHorde, nil, needed;
	end	

	-- if some1 is 0 then updated is true anyway
	if (allyBases == 0) then
		ABHEFS_ScoreStatus["Aliance"].updated = true;
	end
	
	if (hordeBases == 0) then
		ABHEFS_ScoreStatus["Horde"].updated = true;
	end
		
	if (hordeScore ~= ABHEFS_ScoreStatus["Horde"].score) then
		ABHEFS_ScoreStatus["Horde"].score = hordeScore;
		ABHEFS_ScoreStatus["Horde"].lastUpdate = time();
		ABHEFS_ScoreStatus["Horde"].updated = true;
	elseif (allyScore ~= ABHEFS_ScoreStatus["Aliance"].score) then
		ABHEFS_ScoreStatus["Aliance"].score = allyScore;
		ABHEFS_ScoreStatus["Aliance"].lastUpdate = time();
		ABHEFS_ScoreStatus["Aliance"].updated = true;
	end -- TODO: check for only flags change
	

	-- only show when both factions updateds
	if not ABHEFS_ScoreStatus["Aliance"].updated or not ABHEFS_ScoreStatus["Horde"].updated then
		estimatedAlly = "ind.";
		estimatedHorde = "ind.";
		return estimatedAlly, estimatedHorde, nil, needed;
	end	

	
	estiHordeTime = ABHEFS_TimeTo("Horde", 2000);
	estiAlianceTime = ABHEFS_TimeTo("Aliance", 2000);
	
	if (estiHordeTime > estiAlianceTime) or (hordeBases == 0) then -- aliance victory
        	estimatedAlly = 2000;
        	estimatedHorde = ABHEFS_scoreAfter("Horde", estiAlianceTime);
        	winner = 1;
        	scoreWinner = allyScore;
        	estimatedTime = estiAlianceTime;
    	else
        	estimatedHorde = 2000;
        	estimatedAlly = ABHEFS_scoreAfter("Aliance", estiHordeTime);
		winner = 2;
        	scoreWinner = hordeScore;
        	estimatedTime = estiHordeTime;
    	end
    	
    	    	
	if estimatedTime then
		-- only return estimatedTime for resources changes on winner
		if (winner ~= ABHEFS_isWinning.faction) or (scoreWinner ~= ABHEFS_isWinning.score) then
			ABHEFS_TimeLeft = estimatedTime;
			ABHEFS_LastLeftTimerUpdate = time();
			ABHEFS_isWinning.faction = winner;
			ABHEFS_isWinning.score = scoreWinner;
			return estimatedAlly, estimatedHorde, ABHEFS_TimeToStr(estimatedTime), needed;
		else
			return estimatedAlly, estimatedHorde, ABHEFS_TimeToStr(ABHEFS_TimeLeft),needed;
		end
	else
		return estimatedAlly, estimatedHorde, nil, needed;
	end
end

function ABHEFS_GetNeeded(aScore, hScore)
	if (aScore and hScore) then
		aScore = tonumber(aScore);
		hScore = tonumber(hScore);
		if (((2000 - aScore) * ABHEFS_FlagsData[1].rate) < ((2000 - hScore) * ABHEFS_FlagsData[4].rate)) then
			return 1;
		elseif (((2000 - aScore) * ABHEFS_FlagsData[2].rate) < ((2000 - hScore) * ABHEFS_FlagsData[3].rate)) then
			return 2;
		elseif (((2000 - aScore) * ABHEFS_FlagsData[3].rate) < ((2000 - hScore) * ABHEFS_FlagsData[2].rate)) then
			return 3;
		elseif (((2000 - aScore) * ABHEFS_FlagsData[4].rate) < ((2000 - hScore) * ABHEFS_FlagsData[1].rate)) then
			return 4;		
		else
			return 5;
		end
	else
		return;
	end
end

function ABHEFS_UpdateFlags() --*
	local name, status, lastStatus;
	local timeLeft;
	local ownerFaction, oppositeFaction;
	local x1, x2, y1, y2;
	
	SetMapToCurrentZone();
		
	-- read data
	local numLMs = GetNumMapLandmarks();
	for i = 1, numLMs, 1 do
		name, _, status = GetMapLandmarkInfo(i);
		-- check for change status (only trackeable status, with entry in ABHEFS_POIsData)
		if ABHEFS_FlagsStatus[name] and (ABHEFS_FlagsStatus[name].status ~= status) and ABHEFS_POIsData[status] then
			lastStatus = ABHEFS_FlagsStatus[name].status;
			ABHEFS_FlagsStatus[name].status = status;

			if (lastStatus ~= -1) and ABHEFS_POIsData[status].conflict then -- just assaulted
				-- if lastStatus == -1 the new status is the first known status
				ABHEFS_FlagsStatus[name].timeLeft = ABHEFS_FlagAssaultTime;
			else
				ABHEFS_FlagsStatus[name].timeLeft = 0;
			end
		end
	end
	
	-- write flags
	for index, value in ABHEFS_FlagsStatus do
		status = value.status;
		timeLeft = value.timeLeft;
		i = value.id;
		
		
		if ABHEFS_POIsData[status] and (ABHEFS_POIsData[status].faction ~= "Neutral") then
			ownerFaction = ABHEFS_POIsData[status].faction;
			if (ownerFaction == "Aliance") then
				oppositeFaction = "Horde";
			else
				oppositeFaction = "Aliance";
			end			
		
			flagFrameShow = getglobal("ABHEFS_"..ownerFaction.."Flag"..i);
			flagFrameTextShow = getglobal("ABHEFS_"..ownerFaction.."Flag"..i.."TimeText");
			flagFrameTextureShow = getglobal("ABHEFS_"..ownerFaction.."Flag"..i.."Texture");
			flagFrameHide = getglobal("ABHEFS_"..oppositeFaction.."Flag"..i);
		
			x1, x2, y1, y2 = WorldMap_GetPOITextureCoords(status);
			flagFrameTextureShow:SetTexCoord(x1, x2, y1, y2);

			if (timeLeft > 0) then
				flagFrameTextShow:SetText(ABHEFS_TimeToStr(timeLeft));
			else
				flagFrameTextShow:SetText("");
			end

			flagFrameShow:Show();
			flagFrameHide:Hide();
		else
			getglobal("ABHEFS_AlianceFlag"..i):Hide();
			getglobal("ABHEFS_HordeFlag"..i):Hide();
		end
	end
end


---------------------------------------------------------------------------------
-- EVENT FUNCTIONS
---------------------------------------------------------------------------------

function ABHEFS_OnLoad()
	-- events
	this:RegisterEvent("UPDATE_WORLD_STATES");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");
	
	-- drag
	this:RegisterForDrag("LeftButton");
	
	-- hook
	lOriginalWorldStateAlwaysUpFrame_Update = WorldStateAlwaysUpFrame_Update;
	
	-- enabled on load
	WorldStateAlwaysUpFrame_Update = ABHEFS_WorldStateAlwaysUpFrame_Update;	
	
	ABHEFS_LastTimersUpdate = time();
	
	ABHEFSPrint("ABHEFS redux v."..ABHEFS_VERSION.."has loaded!");
	
	SLASH_ABHEFS1 = "/ABHEFS";
	SlashCmdList["ABHEFS"] = ABHEFS_SlashHandler;
end

function ABHEFS_OnEvent()
	if (event == "UPDATE_WORLD_STATES") then
		-- void atm
	end
	if (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE") then
		ABHEFS_UpdateFlags();
	end
end

function ABHEFS_OnUpdate()
	-- check for Arathi Basin
	local inArathi = false;
	
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName = GetBattlefieldStatus(i);
	
		if (status == "active") and (mapName == ABHEFS_MAPNAME) then
			inArathi = true;
		end
	end
	
	if not inArathi then
		getglobal("ABHEFS_Frame"):Hide();
		ABHEFS_ResetStatus();
		return;
	end

	-- execute code every second
	if (ABHEFS_LastTimersUpdate ~= time()) then
		ABHEFS_LastTimersUpdate = time();
		
		-- flags time
		for i, value in ABHEFS_FlagsStatus do
			timeLeft = value.timeLeft;
		
			if (timeLeft > 0) then
				value.timeLeft = timeLeft - 1;
			end
		end
		ABHEFS_UpdateFlags(false);

		-- Estimated End time
		if (ABHEFS_TimeLeft == 0) or not ABHEFS_ShowTime then return; end

		if (ABHEFS_LastLeftTimerUpdate ~= time()) then
			-- get time elapsed
			elapsed = time() - ABHEFS_LastLeftTimerUpdate;
			ABHEFS_TimeLeft = ABHEFS_TimeLeft - elapsed;

			getglobal("ABHEFS_FrameTimeText"):SetText(ABHEFS_TIMELEFT .. ABHEFS_TimeToStr(ABHEFS_TimeLeft));
	
			ABHEFS_LastLeftTimerUpdate = time();
		end
	end
end

function ABHEFS_OnDragStart()
	ABHEFS_Frame:StartMoving();
end

function ABHEFS_OnDragStop()
	ABHEFS_Frame:StopMovingOrSizing();
end


---------------------------------------------------------------------------------
-- HOOK
---------------------------------------------------------------------------------

function ABHEFS_WorldStateAlwaysUpFrame_Update()
	local inArathi = false;

	lOriginalWorldStateAlwaysUpFrame_Update();
	
	-- check for Arathi Basin
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName = GetBattlefieldStatus(i);
	
		if (status == "active") and (mapName == ABHEFS_MAPNAME) then
			inArathi = true;
		end
	end
	
	if not inArathi then
		getglobal("ABHEFS_Frame"):Hide();
		ABHEFS_ResetStatus();
		return;
	end
		
	if (ABHEFS_PlayerFaction == nil) then 
		ABHEFS_PlayerFaction = UnitFactionGroup("player");
	end
	ABHEFS_UpdateFlags();
	
	-- update scores
	frameTextAlly = getglobal("ABHEFS_FrameText1");
	frameTextHorde = getglobal("ABHEFS_FrameText2");
	frameTimeLeft = getglobal("ABHEFS_FrameTimeText");
	frameBasesNeeded = getglobal("ABHEFS_FrameNeededText");
	
	estimatedAlly, estimatedHorde, estimatedTime, needed = ABHEFS_GetData();
	
	if estimatedAlly then
		frameTextAlly:SetText(estimatedAlly);
	end
	if estimatedHorde then
		frameTextHorde:SetText(estimatedHorde);
	end
	if needed then
		if (ABHEFS_PlayerFaction == "Horde") then 
			needed = 6 - needed;
		end
		frameBasesNeeded:SetText(ABHEFS_BASESNEEDED..needed);
	end
	if estimatedTime then
		ABHEFS_ShowTime = true;
		frameTimeLeft:SetText(ABHEFS_TIMELEFT..estimatedTime);
	else
		ABHEFS_ShowTime = false;
		frameTimeLeft:SetText("");
	end;
	
end
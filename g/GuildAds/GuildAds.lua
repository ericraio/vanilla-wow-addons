----------------------------------------------------------------------------------
--
-- GuildAds.lua
--
-- Author: Alexandre Flament
-- URL : http://guildads.sourceforge.net
-- Licence: GPL version 2 (General Public License)
--
-- GuildAds allows multiple independant players to create a channel for chatting, 
-- exchange object and event organisation.
--

---------------------------------------------------------------------------------
--
-- Constants
-- 
---------------------------------------------------------------------------------
GUILDADS_VERSION          = 103.2;

GUILDADS_MAX_CHANNEL_JOIN_ATTEMPTS = 5;				-- Wait 8 seconds more if no channel are joined

GUILDADS_DEBUG = false;

----------------------------------------------------------------------------------
--
-- Global variables / file scope variables
-- 
---------------------------------------------------------------------------------
local g_GuildAdsInitialized;						--- Is GuildAds initialized?

local g_playerName = "Noname";
local g_realmName = "None";
local g_ChatChannel = "GuildAdsGlobal";
local g_ChatPassword = nil;
local g_JoinChannelAttempts = 0;

-- CHAT_MSG_CHANNEL_JOIN, g_HasJoined[player] = true
-- GuildAds_OnOnline(player, true), si g_HasJoined[player] 
-- alors on affiche le message de connexion
local g_HasJoined = {};

local g_showPlayerVersion = false;

----------------------------------------------------------------------------------
--
-- Print a debug string to the chat frame
--	msg - message to print
-- 
---------------------------------------------------------------------------------
local function DEBUG_MSG(msg)
	if (GUILDADS_DEBUG) then
		ChatFrame1:AddMessage(msg, 1.0, 1.0, 0.5);
	end
end

function NoNil(param)
	if (param == nil) then
		return "<nil>";
	else
		return param
	end
end

----------------------------------------------------------------------------------
--
-- GetVersionAsString
-- 
---------------------------------------------------------------------------------
function GuildAds_GetVersionAsString()
	local addThis;
	local major = floor(GUILDADS_VERSION);
	local minor = floor((GUILDADS_VERSION - major)*10 + 0.5);
	if minor>0 then
		local minorToString = {
			[1] = "Alpha",
			[2] = "Beta",
			[3] = "Beta 2",
			[4] = "Beta 3",
			[5] = "Beta 4",
			[6] = "Beta 5",
			[7] = "RC 1",
			[8] = "RC 2",
			[9] = "RC 3"
		}
		addThis = " "..minorToString[minor];
	else
		addThis = "";
	end
	return string.format("%0.2f", major/100)..addThis;
end

--------------------------------------------------------------------------------
--
-- Init
-- 
--------------------------------------------------------------------------------
function GuildAds_InitVariablesLoaded()
	DEBUG_MSG("[GuildAds_InitVariablesLoaded]");
	
	local backupAccountId;
	
	-- Init player and realm Name
	g_playerName = UnitName("player");
	g_realmName = GetCVar("realmName");
	
	 -- Add GuildAds to myAddOns addons list
	 if(myAddOnsFrame) then
	 	myAddOnsList.GuildAds = {
			name = "GuildAds",
			version = GuildAds_GetVersionAsString(),
			category = MYADDONS_CATEGORY_GUILD,
			author = "Zarkan",
			email = "guildads@gmail.com",
			website = "http://guildads.sf.net",
			frame = "GuildAdsFrame",
			optionsframe = "GuildAdsConfigFrame"
		};
	end
	
	-- On reset, backup accountId
	if GuildAds and GuildAds.Version=="reset" then
		backupAccountId = GuildAds.AccountId;
	end
	
	-- Reset channel data for old version
	if GuildAds and GuildAds.Version == "20050729" then
		-- for each GuildAds.Data[realmName].Global[channel]
		for realmName, data in pairs(GuildAds.Data) do
			for channelName, ads in pairs(data.Global) do
				data.Global[channelName] = nil;
			end
		end
		-- to avoid reset
		GuildAds.Version = GUILDADS_VERSION_STORAGE;
	end
	
	-- If this is the first time that GuildAds is use with this version
	if ( (GuildAds == nil) or (GuildAds["Version"] ~=  GUILDADS_VERSION_STORAGE) ) then
		if (GuildAds) then
			ChatFrame1:AddMessage("GuildAds: Reset", 1.0, 0.0, 0.0);
		end
		GuildAds = {};
		GuildAds.Version = GUILDADS_VERSION_STORAGE;
		GuildAds.Data = {};
		GuildAds.Config = {
			MinimapRadiusOffset = 77;
			MinimapArcOffset = 296;
			PublishMyAds = true;
			ShowMyAds = true;
			ShowOfflinePlayer = true;
			Filters = {
				[GUILDADS_MSG_TYPE_ANNONCE] = {	};
				[GUILDADS_MSG_TYPE_REQUEST] = {
					everything = true;
				};
				[GUILDADS_MSG_TYPE_AVAILABLE] = {
					everything = true;
				};
				[GUILDADS_MSG_TYPE_SKILL] = {
					[4] = true, [5] = true, [6] = true,   
					[7] = true,  [8] = true, [9] = true,
					[13] = true
				};
				[GUILDADS_MSG_TYPE_EVENT] = {};
			};
			Mine = {};
		}
		
		for id, _ in GUILDADS_CLASSES do
			GuildAds.Config.Filters[GUILDADS_MSG_TYPE_ANNONCE][id] =  true;
		end
		
		if (backupAccountId) then
			GuildAds.AccountId = backupAccountId;
		end
		
		DEBUG_MSG("First time for this client");
	end
	
	-- Call GAC_InitVariablesLoaded
	GAC_InitVariablesLoaded();
	
	-- Call GuildAds_Init in 8 seconds or after Clcore init
	if clcore_AfterInit then
		clcore_AfterInit(GuildAds_ChatLocCallBack);
	else
		GuildAdsSystem.Reinit = false;
		GuildAdsSystem.InitTimer = 8;
	end
end

function GuildAds_ChatLocCallBack(flag)
	if flag=="INIT" then
		GuildAds_Init();
	end
end

function GuildAds_Init()
	DEBUG_MSG("[GuildAds_Init] begin");
	
	-- already init ? 
	if g_GuildAdsInitialized then
		return;
	end
	
	-- does general channels exists ? if not delayed init
	local firstChannelNumber = GetChannelList();
	if (firstChannelNumber == nil) then
		DEBUG_MSG("[GuildAds_Init] delay - channels");
		g_JoinChannelAttempts = g_JoinChannelAttempts +1;
		if (g_JoinChannelAttempts <= GUILDADS_MAX_CHANNEL_JOIN_ATTEMPTS) then
			GuildAdsSystem.InitTimer = 2;
			return;
		end
	end
	
	-- Init du channel
	g_ChatChannel = GuildAdsConfig_GetChannelName();
	g_ChatPassword =  GuildAdsConfig_GetChannelPassword();
	
	-- GuildAdsStorage : init
	GAS_Init(g_playerName, g_ChatChannel);

	-- Register plugins
	GuildAdsPlugin_RegisterPlugins();
	
	-- GuildAdsComm : init
	GAC_Init(g_playerName, g_ChatChannel, g_ChatPassword);
	
	-- Init Plugin
	DEBUG_MSG("[GuildAdsPlugin_OnInit] begin");
	GuildAdsPlugin_OnInit();
	DEBUG_MSG("[GuildAdsPlugin_OnInit] end");
	
	-- Init first step done
	g_GuildAdsInitialized = true;
	
	-- Init GuildAdsFrame
	DEBUG_MSG("[GuildAdsFrame_Init] begin");
	GuildAdsFrame_Init();
	DEBUG_MSG("[GuildAdsFrame_Init] end");
	
	DEBUG_MSG("[GuildAds_Init] end");
end

function GuildAds_Reinit()
	DEBUG_MSG("[GuildAds_Reinit]");
	GAC_SendRemoveAll(nil);
	
	GuildAdsSystem.Reinit = true;
	GuildAdsSystem.InitTimer = 2;
end

function GuildAds_ReinitSecond()
	DEBUG_MSG("[GuildAds_ReinitSecond]");
	g_GuildAdsInitialized = false;
	
	-- Reinit du channel
	g_ChatChannel = GuildAdsConfig_GetChannelName();
	g_ChatPassword =  GuildAdsConfig_GetChannelPassword();
	
	-- Reinit GuildAdsStorage
	GAS_Init(g_playerName, g_ChatChannel);
	
	-- Reinit UI
	GuildAdsFrame_OnChannelChange();
	
	-- Reinit GuildAdsComm
	GAC_Reinit(g_ChatChannel, g_ChatPassword);
	
	g_GuildAdsInitialized = true;
end

function GuildAds_OnEvent(event)
	if (event == "PLAYER_LEVEL_UP") then
		GuildAdsSystem.SendAnnonceTimer = 10;
		
	elseif (event == "CHAT_MSG_SKILL") then
		-- Toutes les compétences sont envoyées.
		-- Lors de l'apprentissage d'une armes contre un mob la compétence monte vite.
		-- --> MAJ au maxi toutes les minutes, pour éviter le flood.
		GuildAdsSystem.SendSkillsTimer = 60;
		
	elseif (event == "CHARACTER_POINTS_CHANGED") then
		GuildAdsSystem.SendSkillsTimer = 60;
		
	elseif (event == "PLAYER_GUILD_UPDATE") then
		-- Changement de guilde ?
		if g_GuildAdsInitialized and GuildAdsConfig_GetChannelName() ~= g_ChatChannel then
			GuildAds_ReinitSecond();
		end
		
	elseif (event == "CHAT_MSG_CHANNEL_JOIN") and (arg9 == g_ChatChannel) then
		-- Un joueur vient d'arrive sur le channel
		g_HasJoined[arg2] = GAS_currentTime();
		
	elseif (event == "CHAT_MSG_CHANNEL_LEAVE") and (arg9 == g_ChatChannel) then
		-- Un joueur vient de quitter le channel 
		-- Mise à jour du statut online
		GAS_SetOnlineStatus(arg2, false);
		
	elseif (event == "VARIABLES_LOADED") then
		GuildAds_InitVariablesLoaded();
		
	end
end

---------------------------------------------------------------------------------
--
-- Called by WOW for each frame
-- 
---------------------------------------------------------------------------------
function GuildAds_OnUpdate(elapsed)
	
	if (this.InitTimer) then
		this.InitTimer = this.InitTimer - elapsed;
		if (this.InitTimer <= 0) then
			this.InitTimer = nil;
			if (this.Reinit) then
				GuildAds_ReinitSecond();
			else
				GuildAds_Init();
			end
		end
	else
		if (this.SendAnnonceTimer) then
			this.SendAnnonceTimer = this.SendAnnonceTimer - elapsed;
			if (this.SendAnnonceTimer <=0) then
				this.SendAnnonceTimer = nil;
				GAC_SendAnnonce(nil);
			end
		end
		
		if (this.SendSkillsTimer) then
			this.SendSkillsTimer = this.SendSkillsTimer - elapsed;
			if (this.SendSkillsTimer <= 0) then
				this.SendSkillsTimer = nil;
				GAC_SendSkills(nil);
			end
		end	
		
		if (this.SynchronizeOfflinesTimer) then
			this.SynchronizeOfflinesTimer = this.SynchronizeOfflinesTimer - elapsed;
			if (this.SynchronizeOfflinesTimer <= 0) then
				this.SynchronizeOfflinesTimer = nil;
				if (this.SynchronizeOfflinesTimerEnd) then
					GAC_SynchronizeOfflinesEnd();
				else
					GAC_SynchronizeOfflines(this.SynchronizeOfflinesCount);
				end
			end
		end
	end
end

---------------------------------------------------------------------------------
--
-- Called by WoW when this add-on is loaded.  Register for events we are interested in.
-- 
---------------------------------------------------------------------------------
function GuildAds_OnLoad()
	DEBUG_MSG("[GuildAds_OnLoad]");
	
	--
	this:RegisterEvent("VARIABLES_LOADED");
	
	this:RegisterEvent("PLAYER_LEVEL_UP");
	
	this:RegisterEvent("CHAT_MSG_SKILL");
	this:RegisterEvent("CHARACTER_POINTS_CHANGED");
	
	this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
	this:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE");
	
	this:RegisterEvent("PLAYER_GUILD_UPDATE");

	-- Start uninitialized
	g_GuildAdsInitialized = false;
	
	-- Slash commands
	SLASH_GUILDADS1 = "/guildads";
	SlashCmdList["GUILDADS"] = GuildAds_SlashHandler;
end

----------------------------------------------------------------------------------
--
-- Return non-nil if playerName has joined the GuildAds channel after the current one
-- 
---------------------------------------------------------------------------------
function GuildAds_HasJoined(playerName)
	return g_HasJoined[playerName];
end

function GuildAds_ResetHasJoined(playerName)
	g_HasJoined[playerName] = nil;
end

----------------------------------------------------------------------------------
--
-- Called by /guildads
-- 
---------------------------------------------------------------------------------
function GuildAds_ShowPlayerVersion()
	return g_showPlayerVersion;
end

function GuildAds_SlashHandler(msg)
	iStart, iEnd, command = string.find(msg, "(%w+)( ?)");
	if (iEnd) then
		param = string.sub(msg, iEnd+1)
	else
		param = "";
	end
	
	if (msg == "") then
		if (g_GuildAdsInitialized) then
			GuildAds_Toggle();
		else
			ChatFrame1:AddMessage("GuildAds is not initialized.");
		end
	elseif (command == "debuginfo") then
		GuildAds_Debuginfo();
	elseif (command == "reset") then
		g_GuildAdsInitialized = false;
		GuildAds.Version = "reset";
		ReloadUI();
	elseif (command == "hardreset") then
		g_GuildAdsInitialized = false;
		GuildAds = nil;
		ReloadUI();
	elseif (command == "debug") then
		GUILDADS_DEBUG = true;
		GUILDADSSTORAGE_DEBUG = true;
		GUILDADSCOMM_DEBUG = true;
	elseif (command == "nodebug") then
		GUILDADS_DEBUG = false;
		GUILDADSSTORAGE_DEBUG = false;
		GUILDADSCOMM_DEBUG = false;
	elseif (command == "config") then
		if (g_GuildAdsInitialized) then
			GuildAdsConfigFrame:Show();
		else
			ChatFrame1:AddMessage("GuildAds is not initialized.");
		end
	elseif (command == "angle") then
		if (param=="") then
			ChatFrame1:AddMessage(GuildAds.Config.MinimapArcOffset);
		else
			GuildAds.Config.MinimapArcOffset = tonumber(param)+0;
			GuildAdsMinimapButton_Update();
		end
	elseif (command == "showVersions") then
		if g_showPlayerVersion then
			ChatFrame1:AddMessage("show versions: no");
			g_showPlayerVersion = false;
		else
			ChatFrame1:AddMessage("show versions: yes");
			g_showPlayerVersion = true;
		end
	elseif (command == "ignore") then
		if param=="" then
			ChatFrame1:AddMessage(IGNORE_LIST);
			for playerName, when in GAS_ProfileIgnoreList() do
				ChatFrame1:AddMessage(string.format("|Hplayer %s|h[%s]|h "..GUILDADS_SINCE, playerName, playerName, GAS_timeToString(when)));
			end
		else
			if GAS_ProfileIsIgnored(param) then
				ChatFrame1:AddMessage(string.format(ERR_IGNORE_REMOVED_S, param));
				GAS_ProfileIgnore(param, false);
			else
				ChatFrame1:AddMessage(string.format(ERR_IGNORE_ADDED_S, param));
				GAS_ProfileIgnore(param, true);
			end
		end
	end
end

function GuildAds_Debuginfo()
	ChatFrame1:AddMessage("Version: "..GUILDADS_VERSION.."("..NoNil(GuildAds.Version)..")");
	if (g_GuildAdsInitialized) then
		ChatFrame1:AddMessage("GuildAdsInitialized: true");
	else
		ChatFrame1:AddMessage("GuildAdsInitialized: false");
	end
	ChatFrame1:AddMessage("PlayerName: "..NoNil(g_playerName));
	ChatFrame1:AddMessage("Realm: "..NoNil(g_realmName));
	ChatFrame1:AddMessage("AccountId: "..NoNil(GAS_GetAccountId()));
	ChatFrame1:AddMessage("Channel: "..NoNil(g_ChatChannel));
	ChatFrame1:AddMessage("JoinChannelAttemps: "..g_JoinChannelAttempts);
end

----------------------------------------------------------------------------------
--
-- Toggle hidden status of want ads
-- 
---------------------------------------------------------------------------------
function GuildAds_Toggle() 
	if (g_GuildAdsInitialized) then
		if ( GuildAdsFrame:IsVisible() ) then
			GuildAdsFrame:Hide();
		else
			GuildAdsFrame:Show();
		end
	end
end

----------------------------------------------------------------------------------
--
-- Toggle advertise on and off
-- 
---------------------------------------------------------------------------------
function GuildAds_SetPublishMyAds(state)
	if (state) then
		-- Broadcast all my ads
		GAC_SendAllAdsType(nil, nil);
	else
		-- Broadcast a message to remove all my ads
		GAC_SendRemoveAll(nil);
	end
	GuildAds.Config.PublishMyAds = state;
end

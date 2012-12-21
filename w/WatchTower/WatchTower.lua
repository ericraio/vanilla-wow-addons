--	///////////////////////////////////////////////////////////////////////////////////////////
--	
--	WatchTower:	Developed for use in Realm Defense. WatchTower allows you to automatically announce to the area all
--			pertinant information about the invaders. Simply click on the invader and use your hot key to Report
--			enemy. Information included in your message will be Faction, Race, Level, and Current Subzone they are in.
--			Or, you may use your multiple reporting hotkey,
--			mouseover all enemies you wish to report, and then hit the hotkey again to report multiple enemies at once.
--
--	Official Site: 	www.grimeygames.com/wow
--
--	Current Team Members:  Clangadin, Sancho, Aragent, Nathanmx
--		
--	Contributions: Rowne's Variable Saves/Loads and GUI Detection.
--			 Sancho's multiple enemy reporting code.
--		       Jhax's PvP enabled/disabled report fix.
--			 Torgo's AlarmSystem code (and voozoodoo for helping rip some)
--	
--	License: You are hereby authorized to freely modify and/or distribute all files of this add-on, in whole or in part,
--		providing that this header stays intact, and that you do not claim ownership of this Add-on.
--		
--		Additionally, the original owner wishes to be notified by email if you make any improvements to this add-on.
--		Any positive alterations will be added to a future release, and any contributing authors will be 
--		identified in the section above. Contact at fcarentz@grimeygames.com
--	
--	Features:
--			v1.7 - Added Cosmos (Khaos) and UUI compatibility
--				Added tons of various fixes and changes
--			v1.6 - Additions by Sancho:  Changed addon to use UnitLevel() appropriately (changed by blizzard
--				to return -1 when the enemy is 10 levels above you).  Added Verbose and Debug Modes.  Added
--				output options for single enemy reporting.  Added Player Name/Guild info to output options.
--				Coordinate functionality taken from AlarmSystem, thanks to Torgo, the author, and voozoodoo
--				for ripping it.
--				1.6 Bug Fixes (Sancho)
--					-Removed Heading functionality (UnitFacing() taken out by blizzard)
--					-Fixed typo that was messing up raid channel reporting
--					-Fix by Jhax: Now reports pvp enabled/disabled correctly
--			v1.5 - Additions by Sancho:  Multiple enemy reporting, Raid channel broadcasting
--				1.5 Bug Fixes (Sancho)
--					-Fixed faction auto-detection (hopefully) and removed from saved variable list
--					-Fixed language auto-detection (hopefully) and removed from saved variable list
--			v1.4 - Added detection for GUI to show saved settings. Added Rownes Variable saves and GUI detection.
--				1.4 Bug Fixes
--					- Auto Language detection to determine what language the message should be sent in.
--					- Removed bug causing error on NPC Targeting. Will now display message that player can only
--					  target players of the selected enemy faction.
--
--			v1.3 - Added GUI interface...and options to send message to Party, Guild and Local Def. 
--						added Simple slash commands.
--			v1.2 - Corrected Autofaction code. Added Message notification of Enemy Faction, also added 
--					 	message telling user if Target is currently PVP enabled or not. 
--			v1.1 - Removed the Player Set variable of WTChannel to allow program to post to Local Defense.
--						Added autodetect for faction on load of Watch Tower. WatchTower will now automatically
--						set your enemy faction to the opposite of that which you are playing.
--
--         v1.0 - Sends message containing targets Faction, Race, Level, Subzone and Heading (Compass Style)
--	
--	///////////////////////////////////////////////////////////////////////////////////////////


	
	
-----------------------------------------------------------------------------------------------------------
--DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING--
-----------------------------------------------------------------------------------------------------------
BINDING_HEADER_WATCHTOWER = "Watch Tower";
BINDING_NAME_WT_OPTIONS = "Options";
BINDING_NAME_WT_VERBOSE = "Toggle Verbose Mode";
BINDING_NAME_WT_DEBUG = "Toggle Debug Mode";
BINDING_NAME_WT_REPORT = "Report Enemy";
BINDING_NAME_WT_REPORT_GANK = "Report Low-Level Player Killer";
BINDING_NAME_WT_TOGGLE = "Toggle Watch Tower";
BINDING_NAME_WT_FACTION = "Switch Faction Enemy (For Testing Purposes)";
BINDING_NAME_WT_REPORT_MULTIPLE = "Report Multiple Enemies With Mouseover";
WATCHTOWERTITLE = "The Watch Tower";
WATCHTOWEROUTPUTTITLE = "Select Reporting Options";
WT_REPORT_PVP = "PvP Status";
WT_REPORT_FACTION = "Faction";
WT_REPORT_GUILD = "Guild";
WT_REPORT_NAME = "Name";
WT_REPORT_RACE = "Race";
WT_REPORT_CLASS = "Class";
WT_REPORT_LEVEL = "Level";
WT_REPORT_LOCATION = "Location";
WT_REPORT_COORDINATES = "Coordinates";
WT_CUSTOM_CHANNEL = "Custom Channel: ";
WT_PARTY = "Send To Party";
WT_RAID = "Send To Raid";
WT_GUILD = "Send To Guild";
WT_DEFENSE = "Local Defense";
FactionSetTo = "";
WT_Language= "";

local GankReport = false;
local HasCheckedFaction = false;
local PlayerCollectionEnabled = false;
local ReportOwnFaction = false;
local ReportPvPOnly = false;
local ClassOrder = {"Warrior", "Paladin", "Priest", "Hunter", "Rogue", "Shaman", "Mage", "Warlock", "Druid"};
local NumOfPlayers = 0;
local PlayerNames = { "" };
local PlayerLevels = { };
local SortedPlayerLevels = { };
local AverageLevel = 0;
local PlayerClasses = { };
local SortedPlayerClasses = { };
local PlayerRaces = { };
local SortedPlayerRaces = { };
local PlayerClassCounts = {0, 0, 0, 0, 0, 0, 0, 0, 0};

-- support for Cosmos
function WatchTower_Register_Khaos()
	local optionSet = {
		id="WatchTower";
		text=WatchTower_CONFIG_HEADER;
		helptext=WatchTower_CONFIG_HEADER_INFO;
		difficulty=1;
		options={
			{
				id="Header";
				text=WATCHTOWER_CONFIG_HEADER;
				helptext=WATCHTOWER_CONFIG_HEADER_INFO;
				type=K_HEADER;
				difficulty=1;
			};
			{
				id="WatchTowerEnable";
				type=K_TEXT;
				text=WATCHTOWER_ENABLED;
				helptext=WATCHTOWER_ENABLED_INFO;
				callback=function(state) if (state.checked) then WatchTower_Enabled = true; else WatchTower_Enabled = false; end end;
				feedback=function(state) return WATCHTOWER_ENABLED_INFO; end;
				check=true;
				default={checked=true};
				disabled={checked=false};
			};
		};
	};
	Khaos.registerOptionSet(
		"Comm",
		optionSet
	);
end


function WT_OnEvent()
	-- Register command handler and new commands
	SlashCmdList["WatchTowerCOMMAND"] = WTStatusSlashHandler;
	SLASH_WatchTowerCOMMAND1 = "/watchtower";
	SLASH_WatchTowerCOMMAND2 = "/wt";

if (event == "VARIABLES_LOADED") then
    	if (WatchTowerEnabled == nil) then
		WatchTowerEnabled = true;
	end
	if (WatchTower_SendParty == nil or WatchTower_SendLocal == nil or WatchTower_SendGuild == nil or WatchTower_SendRaid == nil
	    or WatchTower_ReportPvP == nil or WatchTower_ReportFaction == nil or WatchTower_ReportGuild == nil
	    or WatchTower_ReportName == nil or WatchTower_ReportRace == nil or WatchTower_ReportClass == nil
	    or WatchTower_ReportLevel == nil or WatchTower_ReportLocation == nil or WatchTower_ReportCoordinates == nil) then
	    --or WatchTower_CustomChannel == nil) then
		if (WatchTower_SendParty == nil) then
			WatchTower_SendParty = false;
		end
		if (WatchTower_SendRaid == nil) then
			WatchTower_SendRaid = false;
		end
		if (WatchTower_SendGuild == nil) then
			WatchTower_SendGuild = false;
		end 
		if (WatchTower_SendLocal == nil) then
			WatchTower_SendLocal = false;
		end
		if (WatchTower_ReportPvP == nil) then
			WatchTower_ReportPvP = false;
		end
		if (WatchTower_ReportFaction == nil) then
			WatchTower_ReportFaction = true;
		end
		if (WatchTower_ReportGuild == nil) then
			WatchTower_ReportGuild = false;
		end
		if (WatchTower_ReportName == nil) then
			WatchTower_ReportName = false;
		end
		if (WatchTower_ReportRace == nil) then
			WatchTower_ReportRace = false;
		end
		if (WatchTower_ReportClass == nil) then
			WatchTower_ReportClass = true;
		end
		if (WatchTower_ReportLevel == nil) then
			WatchTower_ReportLevel = true;
		end
		if (WatchTower_ReportLocation == nil) then
			WatchTower_ReportLocation = true;
		end
		if (WatchTower_ReportCoordinates == nil) then
			WatchTower_ReportCoordinates = true;
		end
		--if (WatchTower_CustomChannel == nil) then
		--	WatchTower_CustomChannel = "";
		--end
		--ShowUIPanel(WT_FrameTemplate);
	end
	if (WatchTower_Verbose == nil) then
		WatchTower_Verbose = true;
	end
	if (WatchTower_Debug == nil) then
		WatchTower_Debug = false;
	end
		--Let the player know that WatchTower has Loaded.
 --       WatchTowerStatusChatMsg("WatchTower loaded. Type /wt to display options.");
--	WatchTowerStatusChatMsg("Remember to set up your Key Bindings.");
	WT_SetCheckBox();
	end
	if(PlayerCollectionEnabled and WatchTowerEnabled and event == "UPDATE_MOUSEOVER_UNIT" and UnitExists("mouseover")) then
		TargetUnit("mouseover");
		WatchTowerDebugChatMsg("UNIT SELECTED", 0, 0, 1);
		--if (UnitFactionGroup("target") == FactionSetTo and UnitPlayerControlled("target") and UnitIsPlayer("target") and (UnitIsPVP("target") or not ReportPvPOnly)) then
--------------------------------------------------------------------------------------------------------
-- Comment the above line and uncomment the 2 commented blocks below to give extra debugging		|
--------------------------------------------------------------------------------------------------------
		if (UnitFactionGroup("target") == FactionSetTo) then					
			WatchTowerDebugChatMsg("IN " .. string.upper(FactionSetTo), 0, 0, 1);
			if (UnitPlayerControlled("target")) then					
				WatchTowerDebugChatMsg("PLAYERCONTROLLED", 0, 0, 1);				
				if (UnitIsPlayer("target")) then					
					WatchTowerDebugChatMsg("NOT A PET", 0, 0, 1);			 	
					if(UnitIsPVP("target") or not ReportPvPOnly) then		
						if(UnitIsPVP("target")) then				
							WatchTowerDebugChatMsg("IS PVP", 0, 0, 1);
						end
--------------------------------------------------------------------------------------------------------
						local tempname = UnitName("target");
						local isNew = true;
						for i=1, NumOfPlayers + 1 do
							if (PlayerNames[i] == tempname) then
								isNew = false;
							end
						end
						if(isNew) then
							Sancho_AddPlayer();
						else
							WatchTowerVerboseChatMsg("PLAYER ALREADY ADDED");
						end
--------------------------------------------------------------------------------------------------------
					else								
						WatchTowerDebugChatMsg("IS NOT PVP", 1, 0, 0);			
					end								
				else									
					WatchTowerDebugChatMsg("IS A PET", 1, 0, 0);				
				end									
			else										
				WatchTowerDebugChatMsg("NOT PLAYERCONTROLLED", 1, 0, 0);			
			end										
		else											
			WatchTowerDebugChatMsg("NOT IN " .. string.upper(FactionSetTo), 1, 0, 0);					
--------------------------------------------------------------------------------------------------------
		end
	end
	--if(event == "WORLD_MAP_UPDATE") then
	--	WT_draw();
	--end
	--if(event == "CHAT_MSG") then
	--	WatchTowerStatusChatMsg(message);
	--end
end

function WT_OnLoad()
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("VARIABLES_LOADED");
	if (Khaos) then
		WatchTower_Register_Khaos();
	end
	SLASH_WATCHTOWER1 = "/watchtower";
	SLASH_WATCHTOWER2 = "/wt";
	SlashCmdList["WATCHTOWER"] = WatchTower_ShowUI;
--[[
	if ( UltimateUI_RegisterButton ) then
		UltimateUI_RegisterButton (
			"Watch Tower",
			"Config",
			"|cFF00CC00Watch Tower|r\nAllows you to report information \nabout enemy targets in various chat channels",
			"Interface\\Icons\\Ability_Seal",
			ShowUIPanel(WT_FrameTemplate),
			function()
			return true; -- The button is enabled
			end
		);
	end
]]
end

--Executed by the user via a script, slash command, or bindable key

function Sancho_ReportToggle()
	if(PlayerCollectionEnabled == false) then
		PlayerCollectionEnabled = true;
		if(HasCheckedFaction == false) then
			SetFaction(UnitFactionGroup("player"));
			HasCheckedFaction = true;
		end
		WatchTowerVerboseChatMsg("WatchTower player collection enabled");
		WatchTowerDebugChatMsg("Reporting " .. FactionSetTo .. " enemies", 1, 1, 1);
		if(ReportPvPOnly) then
			WatchTowerVerboseChatMsg("Reporting only PvP players");
		else
			WatchTowerVerboseChatMsg("Reporting PvP and non-PvP players");
		end
	else
		PlayerCollectionEnabled = false;
		Sancho_PrintData();
		Sancho_ClearData();
	end
end

--Function assumes that an enemy unit is selected which is not already in the tables

function Sancho_AddPlayer()
	NumOfPlayers = NumOfPlayers + 1;
	PlayerNames[NumOfPlayers] = UnitName("target");
	PlayerClasses[NumOfPlayers] = UnitClass("target");
	PlayerLevels[NumOfPlayers] = UnitLevel("target");
	PlayerRaces[NumOfPlayers] = UnitRace("target");
	--Was for debugging, but keeping it until a better way is developed of telling the
	--user which players have already been added (i.e. highlighting the added players somehow)
	WatchTowerVerboseChatMsg("Added (" .. NumOfPlayers .. " Players)");
end

--Prints results, will only be done after data collection has been stopped

function Sancho_PrintData()
	if(NumOfPlayers ~= 0) then
		Sancho_ClassBreakdown();
		Sancho_SortLevels();
	end
	local tMessage = "";
	-- From AlarmSystem, by Torgo, ripped with permission
	-- thanks voozoodoo for ripping!
	xME, yME = GetPlayerMapPosition("player"); 
	xME = math.floor(xME*100.0); 
	yME = math.floor(yME*100.0); 	
	if(not ReportPvPOnly) then
		tMessage = tMessage .. "WatchTower: " .. NumOfPlayers .. " " .. FactionSetTo ..
					" attacking " .. GetMinimapZoneText();
	else
		tMessage = tMessage .. "WatchTower: " .. NumOfPlayers .. " PvP enabled " .. FactionSetTo ..
					" attacking " .. GetMinimapZoneText();
	end
	if ((xME > 0) or (yME > 0)) then 
		tMessage = tMessage.." at ("..xME..","..yME..")! ";
	else
		tMessage = tMessage.."! ";
	end
	if(NumOfPlayers > 50) then
		Sancho_CalculateAverage();
		if(SortedPlayerLevels[NumOfPlayers] == -1) then
			tMessage = tMessage .. "Lowest level: " .. SortedPlayerLevels[1] ..
						" Highest level: " .. UnitLevel("player") + 10 ..
						"+ Average level of known players: " .. string.format("%.1f", AverageLevel);
		else
			tMessage = tMessage .. "Lowest level: " .. SortedPlayerLevels[1] ..
						" Highest level: " .. SortedPlayerLevels[NumOfPlayers] ..
						" Average level of known players: " .. string.format("%.1f", AverageLevel);
		end
	elseif(NumOfPlayers > 20) then
		tMessage = tMessage .. "lvls: ";
		for i=1, NumOfPlayers do
			if(SortedPlayerLevels[i] == -1) then
				tMessage = tMessage .. UnitLevel("player") + 10 .. "+ ";
			else
				tMessage = tMessage .. SortedPlayerLevels[i] .. " ";
			end
		end
	elseif(NumOfPlayers > 10) then
		local temporarycounter = 0; --<<keeps track of how many players are processed,
		for i=1, 9 do		    ----so that it knows if it should add a comma or not
			if(PlayerClassCounts[i] ~= 0) then
					--For the first loop, i = 1, ClassOrder[1] will be a Warrior
					--If there are 2 warriors, for example, the first loop will add
					--"2 Warrior" and "s" since there are more than one
					--and ", " if there are more than 2 total players
				tMessage = tMessage .. PlayerClassCounts[i] .. " " .. ClassOrder[i];
				if(PlayerClassCounts[i] > 1) then
					tMessage = tMessage .. "s";
				end
				temporarycounter = temporarycounter + PlayerClassCounts[i];
				if(temporarycounter < NumOfPlayers) then
					tMessage = tMessage .. ", ";
				end
			end
		end
		tMessage = tMessage .. " - lvls: ";
		for i=1, NumOfPlayers do
			if(SortedPlayerLevels[i] == -1) then
				tMessage = tMessage .. UnitLevel("player") + 10 .. "+ ";
			else
				tMessage = tMessage .. SortedPlayerLevels[i] .. " ";
			end
		end
	elseif(NumOfPlayers > 5) then
		for i=1, NumOfPlayers do
			if(SortedPlayerLevels[i] == -1) then
				tMessage = tMessage .. "lvl " .. UnitLevel("player") + 10 .. "+ " .. SortedPlayerClasses[i];
			else
				tMessage = tMessage .. "lvl " .. SortedPlayerLevels[i] .. " " .. SortedPlayerClasses[i];
			end
			if(i < NumOfPlayers) then
				tMessage = tMessage .. ", ";
			end
		end
	elseif(NumOfPlayers > 0) then
		for i=1, NumOfPlayers do
			if(SortedPlayerLevels[i] == -1) then
				tMessage = tMessage .. "Level " .. UnitLevel("player") + 10 .. "+ " .. SortedPlayerRaces[i] .. " " .. SortedPlayerClasses[i];
			else
				tMessage = tMessage .. "Level " .. SortedPlayerLevels[i] .. " " .. SortedPlayerRaces[i] .. " " .. SortedPlayerClasses[i];
			end
			if(i < NumOfPlayers) then
				tMessage = tMessage .. ", ";
			end
		end
	else
		--Just in case
	end
	--Actually sends the data to whichever channel is wanted
	if(NumOfPlayers ~= 0) then
		if (UnitFactionGroup("player") == "Horde") then
			WT_Language = "Orcish";
		else
			WT_Language = "Common";
		end
		if (WatchTower_SendLocal == true) then
			tempArray = { GetMapZones(GetCurrentMapContinent()) }; 
			mapZone = tempArray[GetCurrentMapZone()]; 
			localDef = GetChannelName("LocalDefense - " ..mapZone); 
			SendChatMessage(tMessage ,"CHANNEL", WT_Language, localDef);
		end

		if WatchTower_SendGuild == true then
			SendChatMessage(tMessage ,"Guild");
		end

		if WatchTower_SendParty == true then
			SendChatMessage(tMessage ,"Party");
		end
		
		if WatchTower_SendRaid == true then
			SendChatMessage(tMessage ,"Raid");
		end

		WatchTowerDebugChatMsg(tMessage, 1, 1, 1);
	else
		WatchTowerStatusChatMsg("No enemies to report.  Is your faction set right?  Is PvP only reporting enabled?");
	end
end

--Run after the data is printed .. also sorts classes and races to match up with levels when needed

function Sancho_SortLevels()
	for i=1, NumOfPlayers do
		for j=1, i do
			if(SortedPlayerLevels[j] == nil or (SortedPlayerLevels[j] > PlayerLevels[i] and PlayerLevels[i] ~= -1)) then
				table.insert(SortedPlayerLevels, j, PlayerLevels[i]);
				table.insert(SortedPlayerClasses, j, PlayerClasses[i]);
				table.insert(SortedPlayerRaces, j, PlayerRaces[i]);
				break;
			end
		end
	end
end

function Sancho_CalculateAverage()
	local count = 0
	for i=1, NumOfPlayers do
		if(PlayerLevels[i] ~= -1) then
			AverageLevel = AverageLevel + PlayerLevels[i];
			count = count + 1;
		end
	end
	AverageLevel = AverageLevel / count;
end

--Will make an array with elements based on the number of each class
--For example PlayerClasses[1] would equal the number of Warriors (see ClassOrder)

function Sancho_ClassBreakdown()
	for i=1, NumOfPlayers do
		for j=1, 9 do
			if(PlayerClasses[i] == ClassOrder[j]) then
				PlayerClassCounts[j] = PlayerClassCounts[j] + 1;
			end
		end
	end
end

function Sancho_ClearData()
	NumOfPlayers = 0;
	PlayerNames = { "" };
	PlayerLevels = { };
	SortedPlayerLevels = { };
	PlayerClasses = { };
	SortedPlayerClasses = { };
	PlayerRaces = { };
	SortedPlayerRaces = { };
	PlayerClassCounts = {0, 0, 0, 0, 0, 0, 0, 0, 0}
end

function WTReportEnemy()
	if(HasCheckedFaction == false) then
		SetFaction(UnitFactionGroup("player"));
		HasCheckedFaction = true;
	end
	if (WatchTowerEnabled == true) then
		if (UnitFactionGroup("target") == FactionSetTo and UnitPlayerControlled("target") and UnitIsPlayer("target")) then --make sure that the unit is the correct faction
		
			--Gather all the needed information about the target
			local tClass, tLevel, tFaction, tRace, tLoc, tPvP;
			tName = UnitName("target");
			tGuild = GetGuildInfo("target");
			if(tGuild == nil) then
				tGuild = "Unguilded"
			end
			tClass = UnitClass("target");
			tLevel = UnitLevel("target");
			tFaction = UnitFactionGroup("target");
			tRace = UnitRace("target");
			tLoc = GetMinimapZoneText();
			tSubZone = GetSubZoneText();
			
			tMessage = "WatchTower: "

			if(WatchTower_ReportName and WatchTower_ReportGuild) then
				if(tGuild == "Unguilded") then
					tMessage = tMessage .. tName .. " / ";
				else
					tMessage = tMessage .. tName .. " of the guild " .. tGuild .. " / ";
				end
			elseif(WatchTower_ReportName and not WatchTower_ReportGuild) then
				tMessage = tMessage .. tName .. " / ";
			elseif(not WatchTower_ReportName and WatchTower_ReportGuild) then
				if(tGuild ~= "Unguilded") then
					tMessage = tMessage .. tGuild .. " guild member / ";
				end
			end
			
			if (UnitIsPVP("target")) then --fix by Jhax
					tPvP = "PvP enabled"
			else
					tPvP = "PvP disabled"
			end
			
			if(WatchTower_ReportPvP) then
				tMessage = tMessage .. tPvP .. " ";
			end
			
			if(WatchTower_ReportFaction) then
				tMessage = tMessage .. tFaction .. " ";
			end
			
			if(WatchTower_ReportRace) then
				tMessage = tMessage .. tRace .. " ";
			end
			
			if(WatchTower_ReportClass) then
				tMessage = tMessage .. tClass .. " ";
			end
			
			if(WatchTower_ReportLevel) then
				if(tLevel ~= -1) then
					tMessage = tMessage .. "(lvl: " .. tLevel .. ") ";
				else
					tMessage = tMessage .. "(lvl: " .. UnitLevel("player") + 10 .. "+)";
				end
			end

			if(WatchTower_ReportLocation or WatchTower_ReportCoordinates) then
				tMessage = tMessage .. "last seen ";
				if(WatchTower_ReportLocation) then
					tMessage = tMessage .. "in " .. tLoc .. " ";
				end
				-- From AlarmSystem, by Torgo, ripped with permission
				-- thanks voozoodoo for ripping!
				xME, yME = GetPlayerMapPosition("player"); 
				xME = math.floor(xME*100.0); 
				yME = math.floor(yME*100.0); 
				if ((xME > 0) or (yME > 0)) then 
					if(WatchTower_ReportCoordinates) then
						tMessage = tMessage .. "at ("..xME..","..yME..") ";
					end
				end
			end
			if(GankReport == true) then
				tMessage = tMessage .. "WARNING: This player is ganking low level " .. UnitFactionGroup("player") .. " members!";
			end
			if (UnitFactionGroup("player") == "Horde") then
				WT_Language = "Orcish";
			else
				WT_Language = "Common";
			end
			if (WatchTower_SendLocal == true) then
				tempArray = { GetMapZones(GetCurrentMapContinent()) }; 
				mapZone = tempArray[GetCurrentMapZone()]; 
				-- fix the output channel incase mapzone is nil (inside instances and whatnot)  -nathanmx
				if (mapZone) then
					localDef = GetChannelName("LocalDefense - " .. mapZone); 
				else
					mapZone = GetMinimapZoneText();
					localDef = GetChannelName("LocalDefense - " .. mapZone); 
				end
				SendChatMessage(tMessage ,"CHANNEL", WT_Language, localDef);
				
			end
			
			if WatchTower_SendGuild == true then
				SendChatMessage(tMessage ,"Guild");
			end
			
			if WatchTower_SendParty == true then
				SendChatMessage(tMessage ,"Party");
			end

			if WatchTower_SendRaid == true then
				SendChatMessage(tMessage ,"Raid");
			end 
			WatchTowerDebugChatMsg(tMessage, 1, 1, 1);
		else
			WatchTowerStatusChatMsg("You can only track player-controlled units of the "..FactionSetTo.." faction.");
		end 				 
	end
end

function ToggleWatchTower()
   if (WatchTowerEnabled == true) then
		WatchTowerStatusChatMsg("WatchTower Disabled.");
   else
		WatchTowerStatusChatMsg("WatchTower Enabled.");
   end
   WatchTowerEnabled = not WatchTowerEnabled;
end

function WTStatusSlashHandler(msg)
	if (msg == nil) then 
		msg = "";
	end
	msg = string.lower(msg);
	local num, offset, command, args = string.find (msg, "(%w+) (%w+)");    
	if (msg == "verbose") then
		ToggleVerboseMode();
	elseif (msg == "debug") then
		ToggleDebugMode();
    	elseif (msg == "options") then
		ShowUIPanel(WT_FrameTemplate);
	else
		WatchTowerStatusChatMsg("/wt options - options menu for channel output and info to report");
		WatchTowerStatusChatMsg("/wt verbose - toggles verbose mode");
		WatchTowerStatusChatMsg("/wt debug - toggles debug mode");
	end
end

function WatchTowerStatusChatMsg(msg)
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function WatchTowerVerboseChatMsg(msg)
	if( DEFAULT_CHAT_FRAME ) then
		if(WatchTower_Verbose) then
			DEFAULT_CHAT_FRAME:AddMessage(msg);
		end
	end
end

function WatchTowerDebugChatMsg(msg, red, green, blue)
	if( DEFAULT_CHAT_FRAME ) then
		if(WatchTower_Debug) then
			DEFAULT_CHAT_FRAME:AddMessage(msg, red, green, blue);
		end
	end
end

function ToggleVerboseMode()
   if (WatchTower_Verbose == true) then
		WatchTowerStatusChatMsg("Verbose Mode Disabled.");
   else
		WatchTowerStatusChatMsg("Verbose Mode Enabled.");
   end
   WatchTower_Verbose = not WatchTower_Verbose;
end

function ToggleDebugMode()
   if (WatchTower_Debug == true) then
		WatchTowerStatusChatMsg("Debug Mode Disabled.");
   else
		WatchTowerStatusChatMsg("Debug Mode Enabled.");
   end
   WatchTower_Debug = not WatchTower_Debug;
end

function WTGankReport()
	GankReport = true;
	WTReportEnemy();
	GankReport = false;
end

function ToggleFaction()  -- for debugging
	ReportOwnFaction = not ReportOwnFaction;
	SetFaction();
end

function SetFaction()
	local faction;
	-- Determine the Players Faction upon login and automatically set 
	-- them to the correct enemy type.
	--if (faction==nil) then
	faction= UnitFactionGroup("player");
	--end
	if(ReportOwnFaction) then  -- for debugging
		FactionSetTo = faction;
		WatchTowerStatusChatMsg("Enemy set to " .. faction);
	elseif (faction == "Horde") then
		FactionSetTo = "Alliance";
		WatchTowerStatusChatMsg("Enemy set to Alliance");
	else
		FactionSetTo = "Horde";
		WatchTowerStatusChatMsg("Enemy set to Horde");
	end
end

function WT_SetCheckBox()
	--Make the GUI show if Options are selected or not 
	--dependant upon the variables.
	if WatchTower_SendLocal == true then
		WT_Checkbox3:SetChecked(1);
		WatchTowerDebugChatMsg("Local True", 0, 0, 1);
	else
		WT_Checkbox3:SetChecked(0);
		WatchTowerDebugChatMsg("Local False", 1, 0, 0);
	end
	if WatchTower_SendGuild == true then
		WT_Checkbox2:SetChecked(1);
		WatchTowerDebugChatMsg("Guild True", 0, 0, 1);
	else
		WT_Checkbox2:SetChecked(0);
		WatchTowerDebugChatMsg("Guild False", 1, 0, 0);
	end
	if WatchTower_SendRaid == true then
		WT_Checkbox1:SetChecked(1);
		WatchTowerDebugChatMsg("Raid True", 0, 0, 1);
	else
		WT_Checkbox1:SetChecked(0);
		WatchTowerDebugChatMsg("Raid False", 1, 0, 0);
	end
	if WatchTower_SendParty == true then
		WT_Checkbox0:SetChecked(1);
		WatchTowerDebugChatMsg("Party True", 0, 0, 1);
	else
		WT_Checkbox0:SetChecked(0);
		WatchTowerDebugChatMsg("Party False", 1, 0, 0);
	end
	if WatchTower_ReportPvP == true then
		WT_Checkbox10:SetChecked(1);
	else
		WT_Checkbox10:SetChecked(0);
	end
	if WatchTower_ReportFaction == true then
		WT_Checkbox11:SetChecked(1);
	else
		WT_Checkbox11:SetChecked(0);
	end
	if WatchTower_ReportGuild == true then
		WT_Checkbox12:SetChecked(1);
	else
		WT_Checkbox12:SetChecked(0);
	end
	if WatchTower_ReportName == true then
		WT_Checkbox13:SetChecked(1);
	else
		WT_Checkbox13:SetChecked(0);
	end
	if WatchTower_ReportRace == true then
		WT_Checkbox14:SetChecked(1);
	else
		WT_Checkbox14:SetChecked(0);
	end
	if WatchTower_ReportClass == true then
		WT_Checkbox15:SetChecked(1);
	else
		WT_Checkbox15:SetChecked(0);
	end
	if WatchTower_ReportLevel == true then
		WT_Checkbox16:SetChecked(1);
	else
		WT_Checkbox16:SetChecked(0);
	end
	if WatchTower_ReportLocation == true then
		WT_Checkbox17:SetChecked(1);
	else
		WT_Checkbox17:SetChecked(0);
	end
	if WatchTower_ReportCoordinates == true then
		WT_Checkbox18:SetChecked(1);
	else
		WT_Checkbox18:SetChecked(0);
	end
	--WT_Editbox0:SetText(WatchTower_CustomChannel);
end

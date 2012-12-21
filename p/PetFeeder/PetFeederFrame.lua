--[[
path: /PetFeeder/
filename: PetFeeder.lua
author: Jeff Parker <jeff3parker@gmail.com>
created: Tue, 22 Jan 2005 14:15:00 -0800
updated: Tue, 22 Jan 2005 21:39:00 -0800

Pet Feeder: a GUI interface allowing you configure happiness level for your pet & 
			drag/drop foods you wish your pet to eat.  When the pet happiness drops below
			the selected threshold will automatically feed your pet.
			To remove a food from the list, simply click on it.
]]


PETFEEDER_ITEM_HEIGHT = 32;
PETFEEDER_ITEMS_SHOWN = 7;

PETFEEDER_FL_DISLIKED = 0;
PETFEEDER_FL_UNKNOWN = 1;
PETFEEDER_FL_APPROVED = 2;


-- Configuration
PeetFeederPlayer_Config = {};

UIPanelWindows["PetFeederFrame"] = { area = "left", pushable = 4 };
PETFEEDER_TAB_SUBFRAMES = {  "PetFeeder_FoodsFrame", "PetFeeder_ApprovedFoodsFrame", "PetFeeder_UnlikedFoodsFrame" };

-- Foods Lists
PetFeederPlayer_Foods = {};
PetFeeder_Foods = {};
PetFeeder_BadFoods = {};
PetFeeder_QuestItems = {};
PetFeeder_PetName = "";
local LastPetName = nil;
PetFeeder_Pets = {};

-- Variables
PetFeeder_Var = { };

PetFeeder_Var.PetInCombat = false;
PetFeeder_Var.PlayerInCombat = false;
PetFeeder_Var.PetDead = false;
PetFeeder_Var.PlayerDead = false;
PetFeeder_Var.TradeOrLoot = false;
PetFeeder_Var.Searching = false;
PetFeeder_Var.isSitting = false;
PetFeeder_Var.sitPosX = -1;
PetFeeder_Var.sitPosY = -1;
PetFeeder_Var.feedStartTime = 0;
PetFeeder_Var.debug = false;
PetFeeder_Var.AutoFindFoodTimer = 0;
PetFeeder_Var.AutoFindFoodTimeout = 60; -- 60 seconds
PetFeeder_Var.LastItemAttempted = nil;
PetFeeder_Var.Feed = false;
PetFeeder_Var.DialogShowing = false;


-- Hooked function variables
Pre_SitOrStand = nil;
Pre_DoEmote = nil;
Pre_PetFeeder_ZMI = nil;
Pre_PetFeeder_ZMO = nil;

--Pre_Jump = nil; -- blocked by Blizzard in v1.10

PetDies_ChatParseInfo = { AddOn = "PetFeeder" };

function PetFeeder_PetIsDead(value)
	PetFeeder_Var.PetDead = value;
	if ( value == true )  then
		PFDebugMessage("PF-Died", "PET DIED. <from messages>", "debug");
	else
		PFDebugMessage("PF-Died", "PET REVIVED. <from messages>", "debug");
	end
end

--[[
=============================================================================
Debug message output 
=============================================================================
]]
function PFDebugMessage(x,y,z) 
	if ( z == "error" ) then 
		DEFAULT_CHAT_FRAME:AddMessage(format("|cffff0000[%s]: %s|r", x, y)) 
	end
	
	if ( PetFeeder_Var.debug ) then
		DEFAULT_CHAT_FRAME:AddMessage(format("|ccfff0000[%s]: %s|r", x, y)) 
	end
end


--[[
=============================================================================
The loading frame handles getting our AddOn initialized properly 
=============================================================================
]]
function PetFeederLoadingFrame_OnUpdate()
	if ( PetFeederFrame.loaded ) then
		PetFeederLoadingFrame:UnregisterEvent("VARIABLES_LOADED");
		PetFeederLoadingFrame:UnregisterEvent("UNIT_NAME_UPDATE");
		PetFeederLoadingFrame:Hide();
		PetFeederLoadingFrame = nil;

		
	elseif ( PetFeederLoadingFrame.loadTime + 10 <= GetTime() ) then
		--PetFeederFrame_LoadData();
		PetFeederFrame.loaded = true;
		PetFeederLoadingFrame.loadTime = GetTime();
	end
end

function PetFeederLoadingFrame_OnLoad()
	PetFeederLoadingFrame:RegisterEvent("VARIABLES_LOADED");
	PetFeederLoadingFrame:RegisterEvent("UNIT_NAME_UPDATE");
	PetFeederLoadingFrame.init = 0;
	PetFeederLoadingFrame.loadTime = GetTime();

end

function PetFeederLoadingFrame_OnEvent(event, arg1)
	if ( not PetFeederLoadingFrame ) then
		return;
	end
	if ( event == "VARIABLES_LOADED" or event == "UNIT_NAME_UPDATE" ) then
		PetFeederLoadingFrame.init = PetFeederLoadingFrame.init + 1;
	end

	

end

--[[
=============================================================================
Initialize data, perform hooks, register for events
=============================================================================
]]


function PetFeederFrame_LoadData()

	if ( UnitClass("player") ~= PETFEEDER_HUNTER) then
		return;
	end

	PetFeederFrame_InitConfig();
	
	PetFeeder_PetName = UnitName( "pet" );
	if ( PetFeeder_PetName == "Unknown Entity" ) then
		PetFeeder_PetName = nil;
		return
	end
	if ( PetFeeder_PetName ~= nil ) then
		initChatParseforPetDiesEvent();
		PetDies_ChatParseInfo.template = PetFeeder_PetName.." dies.";
		PFChatParse_RegisterEvent(PetDies_ChatParseInfo);
		PFDebugMessage("PF-Register", "registering Pet Died event", "debug");
	-- Check for old version of foods
		if ( PetFeederPlayer_Foods[PetFeeder_PetName] and getn(PetFeederPlayer_Foods[PetFeeder_PetName]) > 0) then
			anItem = PetFeederPlayer_Foods[PetFeeder_PetName][1];
			if ( not anItem.quality ) then
				FixOldInventoryData();
			end
		end
		
		if ( PetFeederPlayer_Foods[PetFeeder_PetName] ) then
			for i=1, table.getn( PetFeederPlayer_Foods[PetFeeder_PetName] ) do
				if ( not PetFeederPlayer_Foods[PetFeeder_PetName][i].foodlikedstate ) then
					PetFeederPlayer_Foods[PetFeeder_PetName][i].foodlikedstate = PETFEEDER_FL_UNKNOWN;
					return true;
				end
			end
		end
	end
	
	
		
	PetFeederFrame.loaded = true;
end

function PetFeederFrame_InitConfig()
	
	PetFeederFrame_SetPlayerConfig("Enabled",1);
	PetFeederFrame_SetPlayerConfig("BarEnabled",1);
	PetFeederFrame_SetPlayerConfig("Alert",1);
	PetFeederFrame_SetPlayerConfig("Level",2);
	PetFeederFrame_SetPlayerConfig("SortOption",1);
	PetFeederFrame_SetPlayerConfig("SortOption1",1);
	PetFeederFrame_SetPlayerConfig("SortOption2",1);
	PetFeederFrame_SetPlayerConfig("AutoFindFood",1);
	PetFeederFrame_SetPlayerConfig("SkipBuffFoods",1);
	PetFeederFrame_SetPlayerConfig("RequireApproval",1);
	PetFeederFrame_SetPlayerConfig("FeedOnlyApproved",1);

end
function PetFeederFrame_SetPlayerConfig(ftableitem,defaultvalue)

	if ( not defaultvalue ) then
		defaultvalue = 0;
	end
	
	PeetFeederPlayer_Config[ftableitem] = PeetFeederPlayer_Config[ftableitem] or defaultvalue;
			
end


function initChatParseforPetDiesEvent()
	PetDies_ChatParseInfo.event = "CHAT_MSG_COMBAT_FRIENDLY_DEATH";
	PetDies_ChatParseInfo.func  = function(t) PetFeeder_PetIsDead(true); end;
	PetDies_ChatParseInfo.template = "%s "..PETFEEDER_PET_DIES_MSG;
	PetDies_ChatParseInfo.english = "Aslok dies."; -- example
	PetDies_ChatParseInfo.fields   = {  };
end
--[[
=============================================================================
Initialize saves, slash cmd and panels
=============================================================================
]]
function PetFeederFrame_OnLoad()
	
	if ( UnitClass("player") ~= PETFEEDER_HUNTER ) then
		if ( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00PetFeeder:|r "..PETFEEDER_SESSION_DISABLED);
		end
		return;
	end
	
	PetFeederFrame_LoadData();
	
	-- Register for Events
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
	this:RegisterEvent("UNIT_HAPPINESS");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_PET_CHANGED");
	this:RegisterEvent("PLAYER_ALIVE");
	this:RegisterEvent("PLAYER_UNGHOST")
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("TRADE_SHOW");
	this:RegisterEvent("TRADE_CLOSED");
	this:RegisterEvent("LOOT_SHOW");
	this:RegisterEvent("LOOT_CLOSED");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
	this:RegisterEvent("PET_BAR_UPDATE"); -- to get the rez pet event
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("LOCALPLAYER_PET_RENAMED");	
	
	-- this is player initiated and will help fire the feeding
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	
	-- Hook functions
	if ( not Pre_DoEmote ) then
		Pre_DoEmote = DoEmote;
		DoEmote = PetFeeder_DoEmote;
	end

	if ( not Pre_PetFeeder_ZMI ) then
		Pre_PetFeeder_ZMI = CameraZoomIn;
		CameraZoomIn = PetFeeder_ZMI;
	end
	
	if ( not Pre_PetFeeder_ZMO ) then
		Pre_PetFeeder_ZMO = CameraZoomOut;
		CameraZoomOut = PetFeeder_ZMO;
	end
	

	local chatParseInfo = { AddOn = "PetFeeder" };
	chatParseInfo.event    = "CHAT_MSG_SPELL_FAILED_LOCALPLAYER";
	chatParseInfo.func     = function(t) PetFeeder_RemoveBadFood(); end;
	chatParseInfo.template = PETFEEDER_FAILED_TO_FEED;
	chatParseInfo.english  = "You fail to perform Feed Pet: Your pet doesn't like that food.";
	chatParseInfo.fields   = {  };

	if ( not PFChatParse_RegisterEvent ) then
		PFDebugMessage("PF", "function PFChatParse_RegisterEvent not defined!", "error");
	end

	PFChatParse_RegisterEvent(chatParseInfo);
	
	local chatParseInfo1 = { AddOn = "PetFeeder" };
	chatParseInfo1.event    = "CHAT_MSG_SPELL_FAILED_LOCALPLAYER";
	chatParseInfo1.func     = function(t) PetFeeder_RemoveBadFood(); end;
	chatParseInfo1.template = PETFEEDER_FOODTOOLOW;
	chatParseInfo1.english  = "You fail to perform Feed Pet: That food's level is not high enough for your pet.";
	chatParseInfo1.fields   = {  };
	PFChatParse_RegisterEvent(chatParseInfo1);

	local chatParseInfo2 = { AddOn = "PetFeeder" };
	chatParseInfo2.event    = "CHAT_MSG_SYSTEM";
	chatParseInfo2.func     = function() PetFeeder_DoEmote("SIT"); end;
	chatParseInfo2.template = PETFEEDER_AFK;
	chatParseInfo2.english  = "You are now AFK: Away from Keyboard";
	chatParseInfo2.fields   = {  };
	PFChatParse_RegisterEvent(chatParseInfo2);

	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Jeff's "..PETFEEDER_TITLE.." AddOn loaded.  Use /pf");
	end
	UIErrorsFrame:AddMessage(loadMessage, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);

	-- Register Slash Commands
	SLASH_PetFeeder1 = "/PetFeeder";
	SLASH_PetFeeder2 = "/pf";
	SlashCmdList["PetFeeder"] = function(msg)
		PetFeeder_SlashCmd(msg);
	end

	-- Tab Handling code
	PanelTemplates_SetNumTabs(PetFeederFrame, 3);
	PanelTemplates_SetTab(PetFeederFrame, 1);
	
	this.loaded = nil;
	
end

--[[
=============================================================================
Called when PF opens or closes
=============================================================================
]]
function PetFeederFrame_OnShow()
	PlaySound("igCharacterInfoOpen");
	PetFeeder_Update_Frames();
	
end

function PetFeederFrame_OnHide()
	PlaySound("igCharacterInfoClose");
end

--[[
=============================================================================
Hooked Functions
 replaces the original calls with our own and then calls the original.  These
 methods are hooked so we can detect when a player performs a specific action
 such as sitting, jumping, etc.
=============================================================================
]]
function PetFeeder_DoEmote(token,...)	

	if ( token == "SIT" or token == "sit") then
		 -- DEFAULT_CHAT_FRAME:AddMessage("emote SIT");
		 PetFeeder_Var.sitPosX, PetFeeder_Var.sitPosY = GetPlayerMapPosition("player");
		 PetFeeder_Var.isSitting = true;
	end
	if ( token == "STAND" ) then
		PetFeeder_Var.isSitting = false;
	end
	
	if ( table.getn(arg) > 0 ) then
		Pre_DoEmote(token,arg[1]);	
	else
		Pre_DoEmote(token);
	end
	
end

-- Zoom in mouse wheel hook to call our event handler
function PetFeeder_ZMI(arg1)
	PetFeederFrame_OnEvent("PLAYER_TARGET_CHANGED","pet");
	Pre_PetFeeder_ZMI(arg1);
end

-- Zoom out mouse wheel hook to call our event handler
function PetFeeder_ZMO(arg1)
	PetFeederFrame_OnEvent("PLAYER_TARGET_CHANGED","pet");
	Pre_PetFeeder_ZMO(arg1);
end


--[[
=============================================================================
Walked through our list of foods and obtains the ItemCount for each
=============================================================================
]]
function PetFeeder_UpdateQuantities()
	PetFeeder_GetQuestItems();
	for index, value in PetFeederPlayer_Foods[PetFeeder_PetName] do
		-- update the item count
		PetFeederPlayer_Foods[PetFeeder_PetName][index].quantity = PetFeeder_GetItemCount( value.name );

	end
end


function PetFeeder_GetQuestItems()
	
	PetFeeder_QuestItems = nil;
	PetFeeder_QuestItems = {};
	local numEntries, numQuests = GetNumQuestLogEntries()
	
	for questNum = 1,  GetNumQuestLogEntries() do
		SelectQuestLogEntry(questNum);
		local questTitle, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questNum);
		if ( not isHeader ) then
			for requiredItem = 1, GetNumQuestLeaderBoards(questNum) do
				
				local text, type, finished = GetQuestLogLeaderBoard(requiredItem);
				if ( type == "item" ) then
					local _, _, itemName, numCurrent, numRequired = string.find(text, "(.*): (%d+)/(%d+)");
					--DEFAULT_CHAT_FRAME:AddMessage("itemName="..itemName);	
					--DEFAULT_CHAT_FRAME:AddMessage("numRequired="..numRequired);	
					if (PetFeeder_QuestItems[itemName]) then
						PetFeeder_QuestItems[itemName] = PetFeeder_QuestItems[itemName] + numRequired;
					else
						PetFeeder_QuestItems[itemName] = numRequired;
					end
				end
			end
		end
		
	end
end

function togglePetFeeder(tab)
	if not ( PetFeeder_HasPet() ) then
		UIErrorsFrame:AddMessage(PETFEEDER_ESTABLISH_PET, 0.8, 0, 0, 1.0, UIERRORS_HOLD_TIME);
		return;
	end
	
	if ( not tab ) then
		if ( PetFeederFrame:IsVisible() ) then
			HideUIPanel(PetFeederFrame);
		else
			ShowUIPanel(PetFeederFrame);
			local selectedFrame = getglobal(PETFEEDER_TAB_SUBFRAMES[PetFeederFrame.selectedTab]);
			if ( not selectedFrame:IsVisible() ) then
				selectedFrame:Show();
			end
		end
	else
		local subFrame = getglobal(tab);
		if ( subFrame ) then
			PanelTemplates_SetTab(PetFeederFrame, subFrame:GetID() );
			if ( PetFeederFrame:IsVisible() ) then
				if ( subFrame:IsVisible() ) then
					HideUIPanel( PetFeederFrame );
				else
					PlaySound("igCharacterInfoTab");
					PetFeederFrame_ShowSubFrame(tab);
				end
			else
				ShowUIPanel( PetFeederFrame );
				PetFeederFrame_ShowSubFrame(tab);
			end
		end
	end


end

function PetFeederFrame_ShowSubFrame(frameName)
	for index, value in PETFEEDER_TAB_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();
		end
	end
end
---------------------------------------------------
--Show config dialog when slash-command is called--
---------------------------------------------------
function PetFeeder_SlashCmd(msg)

	if ( not PetFeeder_HasPet() ) then
		UIErrorsFrame:AddMessage(PETFEEDER_ESTABLISH_PET, 0.8, 0, 0, 1.0, UIERRORS_HOLD_TIME);
		return;
	end	
	
	PetFeeder_PetName = UnitName( "pet" );
	
	if (msg == "feed" ) then
	  PetFeeder_Feed();
	elseif ( msg == "clear" ) then			
		PetFeeder_ClearFoods();
	elseif ( msg == "clearbad" ) then			
		PetFeeder_ClearBadFoods();
	elseif ( msg == "dump" ) then
		PetFeeder_DebugDump();
	elseif ( msg == "toggledebug" ) then
		PetFeeder_Var.debug = not PetFeeder_Var.debug;
		if ( PetFeeder_Var.debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("debug is ON");
		else
			DEFAULT_CHAT_FRAME:AddMessage("debug is OFF");
		end
	elseif ( msg == "buff" ) then
		PetFeeder_PlayerBuff();
	elseif ( msg == "populate" ) then
		PetFeeder_PopulateFoods();
	else
			togglePetFeeder(nil);
	end
	
end

-- Do not localize this
function PetFeeder_DebugDump()
	local i;
	DEFAULT_CHAT_FRAME:AddMessage("Petname is "..PetFeeder_PetName);
	DEFAULT_CHAT_FRAME:AddMessage("PetFeeder Foods in the order of consumption");
	for index, value in PetFeederPlayer_Foods[PetFeeder_PetName] do
		DEFAULT_CHAT_FRAME:AddMessage(value.name.." "..value.foodlikedstate);
	end
end

function PetFeeder_GetID(button)
	if ( button == nil ) then
		return 0;
	end

	return (button:GetID())
end

LLLAstEvetnt = nil;
local PetRename = false;


function PetFeederFrame_OnEvent(event, arg1)
	--[[if ( LLLAstEvetnt ~= event ) then
		LLLAstEvetnt = event;
		DEFAULT_CHAT_FRAME:AddMessage(event);
		if ( arg1 ) then
			DEFAULT_CHAT_FRAME:AddMessage("Arg1: "..arg1);
		end
		if ( arg2 ) then
			DEFAULT_CHAT_FRAME:AddMessage("Arg2: "..arg2);
		end
			
	end]]
	
	if (not PeetFeederPlayer_Config.Enabled ) then
		PFDebugMessage("PF", "PF is disabled", "debug");
		return;
	end

	local eventmsg = "event="..event;
	PFDebugMessage("PF", eventmsg, "debug");
	if (arg1 ) then
		eventmsg = "arg1="..arg1;
		PFDebugMessage("PF", eventmsg, "debug");
	end

	 if ( event == "PLAYER_PET_CHANGED" ) then
	 	PetFeeder_Var.PetInCombat = false;
	 	PetFeeder_Var.PetDead = false;
	 	PetFeeder_Var.PlayerInCombat = false;
	 	PetFeeder_Var.PlayerDead = false;
		initChatParseforPetDiesEvent();
		PFChatParse_UnregisterEvent(PetDies_ChatParseInfo);
		PetDies_chatParseInfo.template = PetFeeder_PetName.." dies.";
		PFChatParse_RegisterEvent(PetDies_ChatParseInfo);
		PFDebugMessage("PF-Register", "registering Pet Died event", "debug");
	 	return;
	 end
	
	if ( event == "PET_ATTACK_START" ) then
		PetFeeder_Var.PetInCombat = true;
		PFDebugMessage("PF", "Pet START COMBAT", "debug");
		return;
	elseif ( event == "PLAYER_REGEN_DISABLED" ) then		
		PetFeeder_Var.PlayerInCombat = true;
		return;
	elseif ( event == "PET_ATTACK_STOP" ) then
		PFDebugMessage("PF", "Pet EXIT COMBAT", "debug");
		PetFeeder_Var.PetInCombat = false;
	elseif ( event == "PLAYER_REGEN_ENABLED" ) then
		PetFeeder_Var.PlayerInCombat = false;
	elseif ( event == "PET_BAR_UPDATE" and arg1 == nil) then
		if ( not PetFeeder_HasPet() ) then
			return;
		end
		PetFeeder_PetName = UnitName("pet");
		if ( LastPetName ) then
			LastPetName = nil;
		else
			LastPetName = PetFeeder_PetName;
		end
		PetFeeder_Var.PetDead = false;
		PetFeeder_Var.PetInCombat = false; -- Pet could have died during combat and we don't get notified
		PFDebugMessage("PF-Alive", "Pet is alive <showgrid>", "debug");
		if ( PeetFeederPlayer_Config.AutoFindFood ) then
			PetFeeder_PopulateFoods();
		end
		PetFeeder_Update_Frames();
	elseif ( event == "PLAYER_DEAD" ) then
		PetFeeder_Var.PlayerDead = true;
		return;
	elseif ( event == "PLAYER_ALIVE" or event == "PLAYER_UNGHOST" ) then  -- no notification of deaths, be sure to clear these
		PetFeeder_Var.PetInCombat = false;
		PetFeeder_Var.PlayerInCombat = false;
		PetFeeder_Var.PlayerDead = false;
	elseif ( event == "TRADE_SHOW" or event == "LOOT_SHOW") then
		PetFeeder_Var.TradeOrLoot = true;
		return;
	elseif ( event == "TRADE_CLOSED" or event == "LOOT_CLOSED") then
		PetFeeder_Var.TradeOrLoot = false;
		return;
	elseif (  event == "BAG_UPDATE" or event == "UNIT_PET" ) then
		if ( not PetFeeder_HasPet() ) then
			return;
		end
		if ( PeetFeederPlayer_Config.AutoFindFood ) then
			PetFeeder_PopulateFoods();
		end
		PetFeeder_Update_Frames();
	elseif ( event == "LOCALPLAYER_PET_RENAMED" ) then
		PetRename = true;
	elseif ( event == "UNIT_NAME_UPDATE" ) then
		if ( arg1 and arg1 == "pet" ) then
			if ( not PetFeeder_HasPet() ) then
				return;
			end
			if ( PetFeeder_PetName ~= UnitName("pet") ) then
				--DEFAULT_CHAT_FRAME:AddMessage("UNIT_NAME_UPDATE is running "..UnitName("pet"));
				if ( PetRename ) then
					if ( PetFeederPlayer_Foods[PetFeeder_PetName] ) then
						PetFeederPlayer_Foods[UnitName("pet")] = PetFeederPlayer_Foods[PetFeeder_PetName];
					end
					PetRename = false;
				
				elseif ( PetFeederPlayer_Foods[PetFeeder_PetName] ) then 
					PetFeederPlayer_Foods[PetFeeder_PetName] = {}; 
					LastPetName = UnitName("pet");
				end
				PetFeeder_PetName = UnitName("pet");
				
			else
				
				return;
			end
			if ( PeetFeederPlayer_Config.AutoFindFood ) then
				PetFeeder_PopulateFoods();
			end
			PetFeeder_Update_Frames();
			return;
		else
			return;
		end
	
	end
	

		
	-- HACK
	-- in v1.10 Blizzard changed the DropItemOnUnit( ) method so that it must be player
	-- click event related.  This event identifies such an event.
	-- There's no reason to even try feeding the pet unless this event has fired otherwise the feed attempt will fail.
	if ( event == "PLAYER_TARGET_CHANGED" ) then
		if ( PeetFeederPlayer_Config.Enabled ) then
			PFDebugMessage("PF", "Attempt to feed", "debug");
			if ( PetFeeder_CheckHappiness() == false ) then
				return; -- feeding not necessary
			end
			PetFeeder_Feed();
		end
	end
end


function PetFeeder_CanFeed()
	-- Abort routines
	if not ( PetFeeder_HasPet() ) then
		PFDebugMessage("PF-Abort", "cannot find a pet", "debug");
		PetFeeder_Var.PetInCombat = false;  -- Pet could have died during combat and we don't get notified
		return;
	end
	if ( UnitHealth("pet") <= 0 ) then
		PFDebugMessage("PF-Abort", "Pet Dead", "debug");
		return false;
	end
	if ( UnitHealth("player") <= 0 ) then
		PFDebugMessage("PF-Abort", "Player Dead", "debug");
		return false;
	end
	if ( CastingBarFrameStatusBar:IsVisible() ) then
		PFDebugMessage("PF-Abort", "Player Casting Spell", "debug");
		return false;
	end
	if ( UnitOnTaxi("player") ) then
		PFDebugMessage("PF-Abort", "Player On Taxi", "debug");
		return false;
	end

	
	if ( PetFeeder_Var.PetInCombat == true or PetFeeder_Var.PlayerInCombat == true ) then
		PFDebugMessage("PF-Abort", "Can't feed while in combat", "debug");
		return false;
	end
	
	if ( PetFeeder_HasFeedEffect() ) then
		PFDebugMessage("PF-Abort", "Pet already has Feed effect", "debug");
		return false;
	end
	
-- Extra check to clear sitting flag
	if ( PetFeeder_Var.isSitting == true) then
		local posX, posY = GetPlayerMapPosition("player");
		if ( PetFeeder_Var.sitPosX ~= posX ) then
			PetFeeder_Var.isSitting = false;
		elseif (PetFeeder_Var.sitPosY ~= posY ) then
			PetFeeder_Var.isSitting = false;
		end
	end
	
-- Must have Pet from here down
	if ( not PetFeeder_PetName or PetFeeder_PetName == "" or PetFeeder_PetName == "Unknown Entity" ) then
		PetFeeder_PetName = UnitName( "pet" );
		if ( not PetFeeder_PetName or PetFeeder_PetName == "" ) then
			PFDebugMessage("PF-Critical", "Did not find pet in <event handler>", "debug");
			return false;
		end	
		initChatParseforPetDiesEvent();
		PFChatParse_UnregisterEvent(PetDies_ChatParseInfo);
		PetDies_ChatParseInfo.template = PetFeeder_PetName.." dies.";
		PFChatParse_RegisterEvent(PetDies_ChatParseInfo);
		PFDebugMessage("PF-Register", "registering Pet Died event", "debug");
	end

	if ( not PetFeederPlayer_Foods[PetFeeder_PetName] ) then
	  PFDebugMessage("PF", "inserting new pet", "debug");
	  PetFeederPlayer_Foods[PetFeeder_PetName] = {};
	end
	
	

	-- Is there a debuff on the pet that will break the feeding Buff?
	if ( PetFeeder_PetDebuff() ) then
		PFDebugMessage("PF-Abort", "Pet is debuffed", "debug");
		return false;
	end

	-- check for player buffs that might interfere with feeding
	-- or result in undesired effects (such as stopping feign death or shadowmelding)
	if ( PetFeeder_PlayerBuff() ) then
		PFDebugMessage("PF-Abort", "Can't feed with these player buffs", "debug");
		return false;
	end
	
	return true;
end


-- Check player buffs
-- return true if buff enabled we don't want to break by feeding
-- (i.e. FeignDeath or Shadowmeld )
function PetFeeder_PlayerBuff()
	local i = 1;
	local buff;
	local unit = "player";
	buff = UnitBuff(unit,i);
	while buff do
		--PetFeederTooltip:SetUnitBuff( unit, i );
		--DEFAULT_CHAT_FRAME:AddMessage("debug::Player buff::"..i.."="..buff);
		local debuginfo = "Player buff::"..i.."="..buff;
		if ( isMounted( unit, i, buff ) ) then
			PFDebugMessage("PF-Abort", "Player is mounted", "debug");
			return true;
		elseif ( string.find(buff, "Ability_Rogue_FeignDeath") ) then
			PFDebugMessage("PF-Abort", debuginfo, "debug");
			return true;
		elseif ( string.find(buff, "Ability_Ambush") ) then -- shadowmeld
			PFDebugMessage("PF-Abort", debuginfo, "debug");
			return true;
		elseif ( string.find(buff, "DemonBreath") ) then -- water breathing
			PFDebugMessage("PF-Abort", debuginfo, "debug");
			return true;
		end		
		i = i + 1;
		buff = UnitBuff(unit,i);
	end

	-- Check for eating or drinking
	local playerBuffs = {"Interface\\Icons\\INV_Drink_07","Interface\\Icons\\INV_Misc_Fork&Knife"};
	for i=0, 15 do
		buff = GetPlayerBuffTexture(i);
		if ( buff ) then
			for k,v in playerBuffs do
				if ( buff == v ) then
					PFDebugMessage("PF-Abort", buff, "debug");
					return true;
				end
			end
		end
	end

	if ( PetFeeder_Var.TradeOrLoot ) then
		return true;
	end
	
	return false;
end

--=============================================================================
-- Return information about the pattern
--
-- pattern	pattern to find
local function BuffInformation( pattern )
	if pattern then
		return string.find( PetFeederTooltipTextLeft2:GetText(), pattern );
	else
		return 1;
	end
end
--=============================================================================

-- Check to see if the player is mounted
function isMounted(unit, i, buff )
	PetFeederTooltip:SetUnitBuff( unit, i );
	if ( string.find(buff, "_Mount_" ) or string.find(buff,"INV_Misc_Foot_Kodo") ) then
		local startpos,endpos,buffValue = BuffInformation(" (%d+)%%");
		if ( buffValue ~= nil ) then
			buffValue = buffValue + 0;
			if ( buffValue >=60 ) then
				return true;
			end
		end
	end
	
	return false;
	
end

-- Check pet debuffs
-- return true if pet has debuff that will break feeding
-- (i.e. poisoned )
function PetFeeder_PetDebuff()
	local i = 1;
	local buff;
	buff = UnitDebuff("pet", i);
	
	while buff do
		local debuginfo = "Pet debuff::"..i.."="..buff;
		--PFDebugMessage("PF", debuginfo, "debugbuff");
		
		if ( string.find(buff, "Spell_Nature_CorrosiveBreath") ) then
			return true;  -- this comes from a Venom Spitter when it poisons the target
		end
		if ( string.find(buff, "Spell_Nature") ) then
			return true;   -- this might be too liberal, but should catch all instances we are searching for
		end
		i = i + 1;
		buff = UnitDebuff("pet", i);
	end
	return false;

end

-- Check Feed Effect
function PetFeeder_HasFeedEffect()
	local i = 1;
	local buff;
	buff = UnitBuff("pet", i);
	
	while buff do
		local debuginfo = "Pet buff::"..i.."="..buff;
		--PFDebugMessage("PF", debuginfo, "debugbuff");

		if ( string.find(buff, "Ability_Hunter_BeastTraining") ) then
			return true;
		end
		i = i + 1;
		buff = UnitBuff("pet", i);
	end
	return false;

end

-- Check Happiness
function PetFeeder_CheckHappiness()

	if ( UnitHealth("pet") <= 0 ) then
		PFDebugMessage("PF-Abort", "Pet Dead", "debug");
		return false;
	end
	if ( UnitHealth("player") <= 0 ) then
		PFDebugMessage("PF-Abort", "Player Dead", "debug");
		return false;
	end
	
	-- Get Pet Info
	--local pet = UnitName("pet");
	local happiness, damage, loyalty = GetPetHappiness();
	
	local level = PeetFeederPlayer_Config.Level + 1;
	
	-- Check Happiness
	if ( happiness == 0 ) or ( happiness == nil ) then
		PFDebugMessage("PF-Abort", "Unable to determine pet happiness", "debug");
		return false;
	end
	
	if ( happiness >= level ) then
		local msg = "Feeding not necessary.  Pet happiness is at threshold:"..PETFEEDER_LEVELS_DROPDOWN[happiness-1].name;
		PFDebugMessage("PF-Abort", msg, "debug");
		return false;
	end

	-- Check if Feeding is needed
	PFDebugMessage("PF", "pet isn't happy enough", "debug");

	if not ( PetFeeder_Var.Searching ) then	
		return true;
	else
		PFDebugMessage("PF-Abort", "Pet already searching for food", "debug");
	end

	return false;
end

-- Feed Pet
function PetFeeder_Feed()
	
	if ( not PetFeeder_Var.feedStartTime) then
		PetFeeder_Var.feedStartTime = GetTime();
	else
		local time = GetTime();
		local timePast = time - PetFeeder_Var.feedStartTime;
		if ( timePast < 2 ) then
			return;
		end
	end
	
	

	if ( not PetFeeder_CanFeed() ) then return; end
	
	-- Check if dragging item
	if ( CursorHasItem() ) then 
		PFDebugMessage("PF-Abort", "item is on cursor", "debug"); 
		return; 
	end
		
	-- Make sure PetFeeder_PetName has pet name
	PetFeeder_PetName = UnitName( "pet" );
	if ( not PetFeederPlayer_Foods[PetFeeder_PetName] ) then
		PetFeederPlayer_Foods[PetFeeder_PetName] = {};
	end
	
	PetFeeder_UpdateQuantities();
	PetFeeder_Var.Searching = true;
	if ( PeetFeederPlayer_Config.Alert ) then
		DEFAULT_CHAT_FRAME:AddMessage(PetFeeder_PetName..PETFEEDER_BEGIN_SEARCH);
	end			

	-- 1. Get first available food from our list with quantity > 0
	-- 2. Find the m,n location of it in the pack.
	-- 3. Pick up and eat.
	local lowestQuantity = 99;
	local lowestM = 0;
	local lowestN = 0;
	for index, value in PetFeederPlayer_Foods[PetFeeder_PetName] do
		if ( value.quantity > 0 ) then
			
			if ( PeetFeederPlayer_Config.RequireApproval and PeetFeederPlayer_Config.RequireApproval == 1 and value.foodlikedstate == PETFEEDER_FL_UNKNOWN ) then
				PetFeeder_ApproveFoodItem(value.name);
				PetFeeder_Var.Feed = true;
				
				return;
			end
			if ( (PeetFeederPlayer_Config.FeedOnlyApproved == 1 and value.foodlikedstate == PETFEEDER_FL_APPROVED) or ( PeetFeederPlayer_Config.FeedOnlyApproved == 0 and value.foodlikedstate > 0 ) )then 
				
				 -- Find lowest instance of the food item
				for m = 0, 4 do
					for n = 1, 18 do
						itemObject = PetFeeder_GetItemObject(m,n);
						if ( itemObject and itemObject.name == value.name ) then
							-- Using this itemCount because we need the actual value in the slot
							local texture, itemCount, locked, quality, readable = GetContainerItemInfo(m,n);
							if ( itemCount < lowestQuantity ) then						
								--DEFAULT_CHAT_FRAME:AddMessage("lowest M = "..m.." lowestN="..n.." lowestqty="..itemCount);
								lowestQuantity = itemCount;
								lowestM = m;
								lowestN = n;
							end
						end
					end
				end
				
				local msg = "Feed item in bag,slot="..lowestM..","..lowestN.." which is "..value.name;
				PFDebugMessage("PF", msg, "debug" );
				
				PickupContainerItem( lowestM, lowestN );
	
				PetFeeder_Var.feedStartTime = GetTime();
				
				if ( CursorHasItem() ) then				
					DropItemOnUnit("pet");
					PetFeeder_Var.LastItemAttempted = value;
					PFDebugMessage("PF", "Fed item "..value.name, "debug" );
				end
				if ( CursorHasItem() ) then
					PickupContainerItem(lowestM, lowestN);
				end
	
				value.quantity = value.quantity - 1;
				-- Alert
				if ( PeetFeederPlayer_Config.Alert ) then
					DEFAULT_CHAT_FRAME:AddMessage(PetFeeder_PetName..PETFEEDER_EATS_A..value.name );
				end
	
				PetFeeder_Var.Searching = false;
				return;
			 end
		end
	end
	
	-- No Food Could be Found
	PFDebugMessage("PF", "No food could be found to feed the pet", "debug" );
	if ( PeetFeederPlayer_Config.Alert ) then
		DEFAULT_CHAT_FRAME:AddMessage(PetFeeder_PetName..PETFEEDER_NO_FOOD);
	end
	
	PetFeeder_Var.Searching = false;	
end

function PetFeeder_ApproveFoodItem( lname )
	
	local _,_,name = string.find(lname, "(.*) %(%d+%)");
	if ( not name ) then
		name = lname;
	end
		
	StaticPopupDialogs["PetFeeder_ApproveFoodItem"] = {
		text = PETFEEDER_APPROVE_FOOD..": "..name,
		button1 = PETFEEDER_APPROVE,
		button2 = PETFEEDER_DISLIKE,
		whileDead = 1,
		OnAccept = function()
			PetFeeder_AddFood(name, PETFEEDER_FL_APPROVED);
			PetFeeder_Var.DialogShowing = false;
			PetFeeder_Var.Searching = false;
			if ( PetFeeder_Var.Feed == true ) then
				PetFeeder_Feed();
			end
			PetFeeder_Update_Frames();
		end,
		OnCancel = function()
			PetFeeder_AddFood(name, PETFEEDER_FL_DISLIKED);
			PetFeeder_Var.DialogShowing = false;
			PetFeeder_Var.Searching = false;
			if ( PetFeeder_Var.Feed == true ) then
				-- PetFeeder_Feed();
			end
			PetFeeder_Update_Frames();
		end,
		
		timeout = 0
	};
	PetFeeder_Var.DialogShowing = true;
	StaticPopup_Show("PetFeeder_ApproveFoodItem");
	
end

------------------
-- Threshold Dropdown
------------------
local function PetFeederFrameDropDown_Initialize()
	local info;
	for i = 1, getn(PETFEEDER_LEVELS_DROPDOWN), 1 do
		info = { };
		info.text = PETFEEDER_LEVELS_DROPDOWN[i].name;
		info.func = PetFeederFrameDropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function PetFeederFrameDropDown_OnLoad()
	UIDropDownMenu_Initialize(PetFeederFrameDropDown, PetFeederFrameDropDown_Initialize);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", PetFeederFrameDropDown)
end

function PetFeederFrameDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(PetFeederFrameDropDown, this:GetID());
	PeetFeederPlayer_Config.Level = UIDropDownMenu_GetSelectedID(PetFeederFrameDropDown);	
end


-- Sorting Algorithms


function PetFeeder_SortFoods()

	if ( PetFeederPlayer_Foods[PetFeeder_PetName] == nil ) then
		PetFeeder_ClearFoods();
		return;
	end
	
	PetFeeder_UpdateQuantities();
	
	table.sort( PetFeederPlayer_Foods[PetFeeder_PetName], function(a,b) return a.name > b.name end );
	
		
	if ( PeetFeederPlayer_Config.SortOption == 1 ) then
		return;
	end;

	
	table.sort( PetFeederPlayer_Foods[PetFeeder_PetName], PetFeeder_CompareItem );

end
--[[
=============================================================================
The primary sort compare method.  We may call up to to actual sorting methods
depending on the results.  The sorting methods return 1, 0, -1 while
this method results true|false;
returns: 
=============================================================================
]]

function PetFeeder_CompareItem(a,b)
	
  local result = 0;

  if ( not PeetFeederPlayer_Config.SortOption ) then  PeetFeederPlayer_Config.SortOption = 1; end
  if ( PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption].func ) then
  	result = PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption].func(a,b);
  end

  if ( not PeetFeederPlayer_Config.SortOption2 ) then  PeetFeederPlayer_Config.SortOption2 = 3; end
   
  if (PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption2].func and result == 0) then
  	result = PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption2].func(a,b);
  end
  

  return result > 0;

end

function sortQuantityHighLow(a,b)
	--table.sort( PetFeeder_Foods[PetFeeder_PetName], function(a,b) return a.quantity > b.quantity end );
	if ( a and b ) then
		return a.quantity - b.quantity;
	else
		return 0;
	end
end
function sortQuantityLowHigh(a,b)
	--table.sort( PetFeeder_Foods[PetFeeder_PetName], function(a,b) return a.quantity < b.quantity end );
	if ( a and b ) then
		return b.quantity - a.quantity;
	else
		return 0;
	end
end
function sortQualityHighLow(a,b)
	--table.sort( PetFeeder_Foods[PetFeeder_PetName], function(a,b) return a.quality > b.quality end );
	if ( a and b ) then
		return a.quality - b.quality;
	else
		return 0;
	end
end
function sortQualityLowHigh(a,b)
	--table.sort( PetFeeder_Foods[PetFeeder_PetName], function(a,b) return a.quality < b.quality end );
	if ( a and b ) then
		return b.quality - a.quality;
	else
		return 0;
	end
end
function sortAlphabeticallyHighLow(a,b)
	--table.sort( PetFeeder_Foods[PetFeeder_PetName], function(a,b) return a.name > b.name end );
	if ( a and b ) then
			if ( a.name > b.name ) then
			return 1;
		elseif ( a.name == b.name ) then
			return 0;
		end
		return -1;
	end
	return 0;
end

function sortAlphabeticallyLowHigh(a,b)
	--table.sort( PetFeeder_Foods[PetFeeder_PetName], function(a,b) return a.name < b.name end );
	if ( a and b ) then
		if ( a.name < b.name ) then
			return 1;
		elseif ( a.name == b.name ) then
			return 0;
		end
		return -1;
	end
	return 0;
end


----------------------------
--PetFeeder Checkbuttons--
-----------------------------
function PetFeeder_PF_Enabled_CheckBt_Update(whatValue)
	PeetFeederPlayer_Config.Enabled = whatValue;
	PetFeeder_Update_Frames();
end

function PetFeeder_PF_AutoFindFood_CheckBt_Update(whatValue)
	PeetFeederPlayer_Config.AutoFindFood = whatValue;
	if ( PeetFeederPlayer_Config.AutoFindFood ) then
		PetFeeder_PopulateFoods();
	end
	PetFeeder_Update_Frames();
	
end

function PetFeeder_PF_Alerts_CheckBt_Update(whatValue)
	PeetFeederPlayer_Config.Alert = whatValue;
end

function PetFeeder_PF_SkipBuffFoods_CheckBt_Update(whatValue)
	PeetFeederPlayer_Config.skipBuffFoods = whatValue;
	if ( PeetFeederPlayer_Config.AutoFindFood ) then
		PetFeeder_PopulateFoods();
	end
	PetFeeder_Update_Frames();
end

function PetFeeder_PF_FeedOnlyApproved_CheckBt_Update(whatValue)
	PeetFeederPlayer_Config.FeedOnlyApproved = whatValue;
end

function PetFeeder_PF_RequireApproval_CheckBt_Update(whatValue)
	PeetFeederPlayer_Config.RequireApproval = whatValue;
end

--[[
=============================================================================
 Food Management Routines 
=============================================================================
]]

--[[
=============================================================================
Adds a food item to the Food list or the Bad food list.  Checks to ensure
that the food isn't already in the table and checks to ensure we aren't
re-adding food the Pet doesn't like.
params:
 - PetFeederPlayer_Foods[PetFeeder_PetName]: list to add the item to.
 - value   : table object for the item
=============================================================================
]]

function PetFeeder_AddFood( value , foodlikedstate )
	
	-- DEFAULT_CHAT_FRAME:AddMessage(value); 
	-- Make sure PetFeeder_PetName has real pet name
	PetFeeder_PetName = UnitName( "pet" );
	if ( not PetFeeder_PetName ) then
		return;
	end
	if ( not PetFeederPlayer_Foods[PetFeeder_PetName] ) then
		PetFeederPlayer_Foods[PetFeeder_PetName] = {};
	end
	
	local changeVal = true;
	if ( not foodlikedstate ) then
		foodlikedstate = PETFEEDER_FL_UNKNOWN;
		changeVal = false;
	end
	
	if ( type(value) ~= "table" ) then
		local _,_,name = string.find(value, "(.*) %(%d+%)");
		if ( not name ) then
			name = value;
		end
		if ( name ) then 
		  	for i=1, table.getn( PetFeederPlayer_Foods[PetFeeder_PetName] ) do
		    		if ( PetFeederPlayer_Foods[PetFeeder_PetName][i].name == name ) then
		    			value = PetFeederPlayer_Foods[PetFeeder_PetName][i];
		    		end
		  	end
		end	

	end
	
	if ( not value ) then
		return;
	end
	
	-- don't add if already in the table
	-- just change foodlikedstate state
	
	PFDebugMessage("PF", "Pet Name: "..PetFeeder_PetName, "debug");
	if ( not PetFeederPlayer_Foods[PetFeeder_PetName] ) then
		PFDebugMessage("PF", "No table for pet", "debug");
	end
	PFDebugMessage("PF", "Food State Name: "..foodlikedstate, "debug");
	for i=1, table.getn( PetFeederPlayer_Foods[PetFeeder_PetName] ) do
	  if ( PetFeederPlayer_Foods[PetFeeder_PetName][i].name == value.name ) then
	  	if ( changeVal or not PetFeederPlayer_Foods[PetFeeder_PetName][i].foodlikedstate ) then
	  		PFDebugMessage("PF", "Change Food State Name: "..foodlikedstate, "debug");
			PetFeederPlayer_Foods[PetFeeder_PetName][i].foodlikedstate = foodlikedstate;
		end
		return true;
	  end
	end
	
	
	value.foodlikedstate = foodlikedstate;
	
	table.insert(PetFeederPlayer_Foods[PetFeeder_PetName], value );

	return true;
end

function PetFeeder_ClearFoods( foodlikedstate )
	if not ( PetFeeder_HasPet() ) then
		UIErrorsFrame:AddMessage(PETFEEDER_NEED_PET, 0.8, 0, 0, 1.0, UIERRORS_HOLD_TIME);
		return;
	end
	
	PetFeeder_PetName = UnitName( "pet" );
	if ( not foodlikedstate ) then
		PetFeederPlayer_Foods[PetFeeder_PetName] = {};
	else
		for i=table.getn( PetFeederPlayer_Foods[PetFeeder_PetName] ), 1,-1  do
		  	if ( PetFeederPlayer_Foods[PetFeeder_PetName][i].foodlikedstate == foodlikedstate ) then
		  		table.remove(PetFeederPlayer_Foods[PetFeeder_PetName],i);
			--	PetFeeder_AddFood(PetFeederPlayer_Foods[PetFeeder_PetName][i], PETFEEDER_FL_UNKNOWN);
		 	end
		end
	end
	PetFeeder_Update_Frames();
end

function PetFeeder_FoodsFrame_UpdateExt( foodlikedstate )

	local frameCoWord;
	
	if ( not foodlikedstate ) then
		foodlikedstate = PETFEEDER_FL_UNKNOWN;
	end
	
	if ( foodlikedstate == PETFEEDER_FL_UNKNOWN ) then
		frameCoWord = "";
	elseif ( foodlikedstate == PETFEEDER_FL_APPROVED ) then
		frameCoWord = "Approved";
	else
		frameCoWord = "Unliked";
	end
	
	local iItem;

	local numEntries = 0;
	for index, value in PetFeederPlayer_Foods[PetFeeder_PetName] do
		if ( value.foodlikedstate == foodlikedstate ) then
			numEntries = numEntries + 1;
		end
	end

	--DEFAULT_CHAT_FRAME:AddMessage(frameCoWord.." numEntries "..numEntries); 
	
	local scrollFrame = getglobal("PetFeeder_"..frameCoWord.."FoodsFrameListScrollFrame");
	FauxScrollFrame_Update(scrollFrame, numEntries, PETFEEDER_ITEMS_SHOWN, PETFEEDER_ITEM_HEIGHT, nil, nil, nil, nil, nil, PETFEEDER_ITEM_HEIGHT);
	
	local scrollFrameOffset = FauxScrollFrame_GetOffset(scrollFrame);
	--DEFAULT_CHAT_FRAME:AddMessage(" scrollFrameOffset "..scrollFrameOffset); 
	local realItem = 1;
	local realIndex = 0;
	local usedButtons = 1;
	while  usedButtons <= PETFEEDER_ITEMS_SHOWN do
		realIndex = realIndex + 1
		local buttonItem = getglobal("PetFeeder_"..frameCoWord.."FoodsFrameItem"..usedButtons);
		if ( usedButtons > numEntries ) then
		  	buttonItem:Hide();
		  	usedButtons = usedButtons + 1;
		else
			
			iconTexture = getglobal("PetFeeder_"..frameCoWord.."FoodsFrameItem"..usedButtons.."ItemIconTexture");
			if ( PetFeederPlayer_Foods[PetFeeder_PetName][realIndex] ) then
				local value = PetFeederPlayer_Foods[PetFeeder_PetName][realIndex];
			
				if ( value.foodlikedstate == foodlikedstate ) then
					if ( realItem > scrollFrameOffset ) then
						--DEFAULT_CHAT_FRAME:AddMessage(" realIndex "..realIndex.." Name "..value.name); 
						if ( value.texture ) then
							iconTexture:SetTexture( value.texture );
						end
			 			local name = value.name.." ("..value.quantity..")";
			 			if ( value.quality ) then
			 				name = name.." - quality: "..value.quality;
			 			end
			
						buttonItem:SetText(name);
						buttonItem:Show();
						usedButtons = usedButtons + 1
					end
					realItem = realItem + 1;
								
				end
			else
				usedButtons = usedButtons + 1;
			end
		end
	end	
end

--[[
=============================================================================
This method gets called by the ChatMsg callback functions when it detects
that a pet doesn't like the food we fed it.
- Bad food will be the first one readily available
- Only gets called when a bad food item is detected
- If the user manually feeds, the timer which is set when WE feed, will be off
  by more than 2 clicks.  We don't want to remove any foods from our list because
  we don't know what the pet didn't like.
  params:
   - t: nil
=============================================================================
]]
function PetFeeder_RemoveBadFood()
	
	PetFeeder_UpdateQuantities();
	
	PFDebugMessage("PF", "Bad food detected "..PetFeeder_Var.LastItemAttempted.name, "debug");
	
	if ( (GetTime() - PetFeeder_Var.feedStartTime) >= 2 ) then
		PFDebugMessage("PF", "Not removing bad food as feed wasn't initiated by PF", "debug");
		return;
	end
	PetFeeder_Var.feedStartTime = 0;
	for index, value in PetFeederPlayer_Foods[PetFeeder_PetName] do
		if ( value.name == PetFeeder_Var.LastItemAttempted.name ) then			
			if ( PeetFeederPlayer_Config.Alert ) then
				DEFAULT_CHAT_FRAME:AddMessage(PETFEEDER_REMOVE_FOOD..value.name);
			end
			
			PetFeeder_AddFood( value , PETFEEDER_FL_DISLIKED );
			break;
		end
	end
	
	PetFeeder_Update_Frames();	
	
end

--[[
=============================================================================
Gets called when we want to drop an item onto the list.  Identifies which
item in bag,slot is being dropped, gets into about that item and then attempts
to add it to the list.
params:
 - PetFeederPlayer_Foods[PetFeeder_PetName]: the name of the list to add the item to.
=============================================================================
]]

function PetFeeder_Update_Frames()
	if ( not UnitName( "pet" ) ) then
		return;
	end
	PetFeeder_SortFoods();
	PetFeeder_UnlikedFoodsFrame_Update();
	PetFeeder_FoodsFrame_Update();
	PetFeeder_ApprovedFoodsFrame_Update();
	
end


function PetFeeder_DroptheItem( accept , foodlikedstate )
	
	if CursorHasItem() and PetFeeder_PickedupItem then
		
		local value = PetFeeder_GetItemObject( PetFeeder_PickedupItem.bag,PetFeeder_PickedupItem.slot );
		if ( value ) then
			--if ( accept == "any" ) then
			-- if ( PetFeederFrame_IsFood( value ) or accept == "any" ) then

				PetFeeder_AddFood( value, foodlikedstate );
					
			--end
		end
		ResetCursor();
		PetFeeder_TakeItemOffCursor(PetFeeder_PickedupItem.bag,PetFeeder_PickedupItem.slot);			
	end  -- if has item and we know where it came from

	PetFeeder_PickedupItem = nil;	

end


--[[
=============================================================================
Returns the item name;
params:
 - bag: the bag number of the item
 - slot: the slot number of the item
=============================================================================
]]
function PetFeeder_GetItemName(bag, slot)
  --local name,totalCount,quality,texture,linktext = PetFeeder_GetItemInfo(bag,slot);   
  local value = PetFeeder_GetItemObject( m, n );
  
  if ( value ) then
  	return value.name;
  end
  
  return nil;
end

--[[
=============================================================================
Looks through all bags/slots to find the item and adds up the total quantity
for it.
params:
 - itemName: name of the item
=============================================================================
]]
function PetFeeder_GetItemCount(itemName)
	--DEFAULT_CHAT_FRAME:AddMessage("itemName="..itemName);  
	local totalItemCount = 0;
	local itemQuality = 0;
  -- calc total number of items
  	for m = 0, 4 do
		for n = 1, 20 do
		      	local curLinkText = GetContainerItemLink(m, n);
		      	local curname;
			if curLinkText then
				_, _, id,curname = string.find(curLinkText, "^.*:(%d+):%d+:%d+:%d+.*%[(.*)%].*$");
	
			end
			if ( curname == itemName ) then
				
				texture, itemCount, locked, quality, readable = GetContainerItemInfo(m,n);
			      	itemQuality = quality;
			      	if ( itemCount ) then
			      		totalItemCount = totalItemCount + itemCount;
			      	end
	      		end
    		end
  	end
  	
  	if ( PetFeeder_QuestItems[itemName] ) then
  		--DEFAULT_CHAT_FRAME:AddMessage("Quest itemName="..itemName); 
  		local sum = totalItemCount - PetFeeder_QuestItems[itemName];
  		--DEFAULT_CHAT_FRAME:AddMessage("sum="..sum); 
  		totalItemCount = max(sum,0);
  	end
  	return totalItemCount, itemQuality;
  
end

function PetFeeder_GetItemObject(bag,slot)
  
  local value = { };
  local linktext = GetContainerItemLink(bag, slot);
  local itemTexture, itemCount, locked, itemQuality, readable = GetContainerItemInfo(bag,slot);
  local itemColor, itemID, itemName;
  local restores, overTime;
  
  value.quality = 61;

	-- no sense processing if there isn't an item
  if ( not linktext ) then
  	return nil;
  end
  
	for itemColor, itemID, itemName in string.gfind(linktext, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
		if ( itemColor and itemID and itemName ~= "" ) then
			  value.name = itemName;
			  value.color=itemColor;
			  value.id=itemID;
			--DEFAULT_CHAT_FRAME:AddMessage("color="..itemColor.."  itemID="..itemID.."  name="..itemName.." texture="..itemTexture);  	
		end
	end
	
	if ( not value.id ) then
		return nil;
	end
	
	local _, _, _, _, itemType, itemSub = GetItemInfo("item:"..value.id)
	--DEFAULT_CHAT_FRAME:AddMessage(value.name.." - "..itemType.." - "..itemSub)
	value.type = itemSub;
	value.texture = itemTexture;
  	value.link = linktext;

	-- Look for 'Use: Restores XXXX health over YY seconds'
	-- Regex looks for 'Use:', a space, 1 or more characters, a space, 1 or more digits
	-- Return the digits as our version of quality
	if ( value ) then
		PetFeederTooltip:ClearLines();
		PetFeederTooltip:SetHyperlink( "item:"..value.id );
		--PFDebugMessage("PF", "Parse ITEM="..value.name, "info");
	end
	local i;

	if ( PetFeederTooltipTextLeft2:GetText() ) then
		--PFDebugMessage("PF", "TooltipTextLeft2="..PetFeederTooltipTextLeft2:GetText(), "info");
		--for restores in string.gfind(PetFeederTooltipTextLeft2:GetText(), PETFEEDER_RESTORES.." (%d+)") do
		for restores in string.gfind(PetFeederTooltipTextLeft2:GetText(), ITEM_SPELL_TRIGGER_ONUSE.." %w+ (%d+)") do		
			if ( restores ~= "" ) then
				  value.quality = tonumber(restores);
			end
		end
	end		
	if ( PetFeederTooltipTextLeft3:GetText() ) then
		--PFDebugMessage("PF", "TooltipTextLeft3="..PetFeederTooltipTextLeft3:GetText(), "info");
		--for restores in string.gfind(PetFeederTooltipTextLeft3:GetText(), PETFEEDER_RESTORES.." (%d+)") do
		for restores in string.gfind(PetFeederTooltipTextLeft3:GetText(), ITEM_SPELL_TRIGGER_ONUSE.." %w+ (%d+)") do		
			if ( restores ~= "" ) then
				  value.quality = tonumber(restores);
			end
		end
	end
	

	value.attributeBuffs = false;
	if ( PetFeederTooltipTextLeft2:GetText() ) then
		for i = 1, getn(PETFEEDER_ITEM_ATTRIBUTE_BUFFS), 1 do
			for restores in string.gfind(PetFeederTooltipTextLeft2:GetText(), PETFEEDER_ITEM_ATTRIBUTE_BUFFS[i].search ) do		
				if ( restores ~= "" ) then
					  value.attributeBuffs = true;
					  break;
				end
			end
		end
	end

	if ( PetFeederTooltipTextLeft3:GetText() and (value.attributeBuffs == false)) then
		for i = 1, getn(PETFEEDER_ITEM_ATTRIBUTE_BUFFS), 1 do
			for restores in string.gfind(PetFeederTooltipTextLeft3:GetText(), PETFEEDER_ITEM_ATTRIBUTE_BUFFS[i].search ) do		
				if ( restores ~= "" ) then
					  value.attributeBuffs = true;
					  break;
				end
			end
		end
	end


  local totalItemCount = PetFeeder_GetItemCount( name );
  value.quantity = totalItemCount;

--  if ( value.name and value.name == "Mystery Meat" ) then 
--    DEFAULT_CHAT_FRAME:AddMessage("object::color="..value.color.."  itemID="..value.id.."  name="..value.name);
--	  DEFAULT_CHAT_FRAME:AddMessage("object::texture="..value.texture.."  quality="..value.quality.."  link="..value.link);
--	  DEFAULT_CHAT_FRAME:AddMessage("object::quantity="..value.quantity);
--  else
--    DEFAULT_CHAT_FRAME:AddMessage("null name in bag="..bag.." slot="..slot);
--  end
  
  if ( value.name ) then
  	return value;
  end
 
  return nil;
  
end

function PetFeeder_TakeItemOffCursor(srcBag, srcSlot)
	if srcBag == -1 then
		PickupInventoryItem(srcSlot);
	else
		PickupContainerItem(srcBag, srcSlot);
	end
end

--[[
=============================================================================
Algorithm to auto-populate foods into our food list.  Uses pattern matching 
to find foods based on popular words associated with foods in the game.
Alt Algorithm: uses texture to determine whether an item is a food item or not.
=============================================================================
]]
function PetFeeder_PopulateFoods()
	--DEFAULT_CHAT_FRAME:AddMessage("PetFeeder_PopulateFoods");
	if not ( PetFeeder_HasPet() ) then
		return;
	end

  -- Walk through each inventory item
	  for m = 0, 4 do
		for n = 1, 20 do
	      
		  local value = PetFeeder_GetItemObject( m,n );
		  if ( value ) then
			  if ( PetFeederFrame_IsFood( value ) 
			  	and ( (PeetFeederPlayer_Config.skipBuffFoods and value.attributeBuffs == false) 
			  				or (not PeetFeederPlayer_Config.skipBuffFoods)) )
			  then
			  	-- DEFAULT_CHAT_FRAME:AddMessage(value.name);
				PetFeeder_AddFood( value );
			  end
		  end
		  
		end
	  end
  
end

--[[
=============================================================================
Determine whether the item is food or not.  We try three things to figure this out
1. If the texture contains the word _Food_ or _Misc_Bowl_ we assume its a food item
2. If the texture contains certain woods (ie: Weapon, Arrow) we eliminate it as a choice
3. Everything else goes through our food filter list to see if they contain
   keywords for food items.
Even if we mis-identify something as a food item, it will get eliminated from
the pet's diet list as soon as it tries to eat it and the Add_Food routine
will eliminate it for us.
=============================================================================
]]
function PetFeederFrame_IsFood( item )
	
	local isGood = false;
	--DEFAULT_CHAT_FRAME:AddMessage("texture="..item.texture.." item="..item.name);
	
	if ( item.type == PETFEEDER_CONSUMABLE or item.type == PETFEEDER_TRADEGOODS or PF_FOM_IsFood(item) ) then
		local foodTextures = { "_Food_", "_Misc_", "_Fish_","_Mushroom_" };
		local i
		for  i=1, table.getn( foodTextures ) do
			if ( string.find( item.texture, foodTextures[i] ) ) then
				isGood = true;
				break;
			end
		end
	else
		return false;
	end
	
	local notFoodTextures = { "_Gem_", "_ArmorKit_", "_Flower_","_LeatherScrap_","_Bandage_","_MonsterScales_","_Herb_" };
	local i
	for  i=1, table.getn( notFoodTextures ) do
		if ( string.find( item.texture, notFoodTextures[i] ) ) then
			return false;
		end
	end
	return isGood;
	
end



--=============================================================================
-- Return information about the pattern
--
-- pattern	pattern to find
local function BuffInformation( pattern )
	if pattern then
		return string.find( PetFeederTooltipTextLeft2:GetText(), pattern );
	else
		return 1;
	end
end
--=============================================================================


-- Called when you click on a Tab
function PetFeederTab_OnClick()
	if ( this:GetName() == "PetFeederFrameTab1" ) then
		togglePetFeeder("PetFeeder_FoodsFrame");
	elseif ( this:GetName() == "PetFeederFrameTab2" ) then
		togglePetFeeder("PetFeeder_ApprovedFoodsFrame");
	elseif ( this:GetName() == "PetFeederFrameTab3" ) then
		togglePetFeeder("PetFeeder_UnlikedFoodsFrame");	
	end
	PlaySound("igCharacterInfoTab");
end

--[[
=============================================================================
Hooked function that gets called when a user picks up an item
=============================================================================
]]
local PetFeeder_Save_PickupContainerItem = PickupContainerItem;
PickupContainerItem = function (bag,slot)
	PetFeeder_PickedupItem = { };
	PetFeeder_PickedupItem.bag = bag;
	PetFeeder_PickedupItem.slot = slot;
	
	return PetFeeder_Save_PickupContainerItem(bag,slot);
end

--[[
=============================================================================
Hooked function that gets called when a user picks up an item
=============================================================================
]]
local PetFeeder_Save_PickupInventoryItem = PickupInventoryItem;
PickupInventoryItem = function (slot)
	PetFeeder_PickedupItem = { };
	PetFeeder_PickedupItem.bag = -1;
	PetFeeder_PickedupItem.slot = slot;
	return PetFeeder_Save_PickupInventoryItem(slot);
end

function PetFeederItemButton_OnEnter(lname)
	
	local _,_,name = string.find(lname, "(.*) %(%d+%)");
	if ( not name ) then
		name = lname;
	end
	
	local link = nil;
	
	for index, value in PetFeederPlayer_Foods[PetFeeder_PetName] do
		if ( value.name == name ) then
			link = "item:"..value.id;
		end
	end
	
	if( link ) then
		GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(link);
		GameTooltip:Show();
	end
end

function PetFeederItemButton_OnLeave()
	if( PetFeederFrame.TooltipButton ) then
		PetFeederFrame.TooltipButton = nil;
		HideUIPanel(PetFeederDisplayTooltip);
	end
end

function FixOldInventoryData()
	local itemObject;
	
	for index, value in PetFeederPlayer_Foods[PetFeeder_PetName] do
		for m = 0, 4 do
			for n = 1, 18 do
				itemObject = PetFeeder_GetItemObject(m,n);
				if ( itemObject and itemObject.name == value.name ) then
					value = itemObject;
					break;
				end
			end
			if ( itemObject and itemObject.name == value.name ) then
				break;
			end
		end		
	end
end


--[[
=============================================================================
  Test whether a pet is present or not.
=============================================================================
]]
function PetFeeder_HasPet()
	if (  not UnitExists("pet") ) then
		return false;
	elseif ( UnitName("pet") == "Unknown Entity"  or UnitName("pet") == "Unknown" ) then
		return false;
	end
	
	return true;
end



function PetFeeder_IdFromLink(link)
	if (link == nil) then return nil; end
	local _, _, itemID  = string.find(link, "(%d+):%d+:%d+:%d+");
--	DEFAULT_CHAT_FRAME:AddMessage("link ".. link .." to "..itemID);
	
	if (tonumber(itemID)) then
		return tonumber(itemID);
	else
		return nil;
	end
end
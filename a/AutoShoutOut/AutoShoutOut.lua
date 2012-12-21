-- ****************
-- * AutoShoutOut *
-- ****************

ASO_Version = "1.15.5";

local ASO_Debug = false;
local ASO_Variables_Loaded = false;
local ASO_Initialized = false;
local ASO_RezStone_Warn_Done = false;
local ASO_BeenGivenRezStone = false;

local ASO_CharacterName = nil;

local ASO_InDuel = false;

local ASO_Event_Type_Desc_Selected = nil;

local ASO_LastShout = {
	[ASO_LOCSTR_HEALTH] 	= 0,
	[ASO_LOCSTR_LIFE] 		= 0,
	[ASO_LOCSTR_MANA] 		= 0,
	[ASO_LOCSTR_PETHEALTH] 	= 0,
	[ASO_LOCSTR_REZSTONE]	= 0
};	

local ASO_Events = {
	[ASO_LOCSTR_HEALTH_LABEL] 		= ASO_LOCSTR_HEALTH,
	[ASO_LOCSTR_LIFE_LABEL] 		= ASO_LOCSTR_LIFE,
	[ASO_LOCSTR_MANA_LABEL] 		= ASO_LOCSTR_MANA,
	[ASO_LOCSTR_PETHEALTH_LABEL] 	= ASO_LOCSTR_PETHEALTH,
	[ASO_LOCSTR_REZSTONE_LABEL]		= ASO_LOCSTR_REZSTONE
};

local ASO_Settings = {
	[ASO_LOCSTR_CONFIGS_PARTY_LABEL]	= ASO_LOCSTR_CONFIGS_PARTY,
	[ASO_LOCSTR_CONFIGS_RAID_LABEL]		= ASO_LOCSTR_CONFIGS_RAID,
	[ASO_LOCSTR_CONFIGS_SOLO_LABEL]		= ASO_LOCSTR_CONFIGS_SOLO,
};

------------------------------------------------------------------------------------------

function ASO_OnLoad()

	--Store default config values for later:
	if (ASO_Debug) then
		ASO_ChatMessage(ASO_LOCSTR_LOADING .. " AutoShoutOut v" .. ASO_Version);
		message(ASO_LOCSTR_LOADING .. " AutoShoutOut v" .. ASO_Version .. "\n\nDebug Is ON!");
	end

	-- add the slash commands
	SlashCmdList["ASOCMD"] = function(msg)
		ASO_Command(msg);
	end
	SLASH_ASOCMD1 = "/aso";
	SLASH_ASOCMD2 = "/autoshoutout";


	-- Register for events
	ASO_Register_For_Events();

	
	-- Hook our window up so that the ESCAPE key closes it...
	tinsert(UISpecialFrames, "AutoShoutOutWindow") 

	-- Let user know it was loaded, and how they can get help if they need it
	ASO_ChatMessage("AutoShoutOut v" .. ASO_Version .. " " .. ASO_LOCSTR_GREETINGS);
	
end

------------------------------------------------------------------------------------------

function ASO_Register_For_Events()

	-- IF YOU ADD A NEW EVENT, ALSO ADD IT TO ASO_Unregister_For_Events() !!!

	--Register Events:
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("UNIT_AURA"); -- v1.15.0
	this:RegisterEvent("UNIT_AURASTATE"); -- v1.15.0
	this:RegisterEvent("UNIT_COMBAT"); -- v1.15.0
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	
	-- Below for variables loading and UnitName("player") initializations...
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	
	-- Below for Druid changing form, so that UI 'Mana' event type can be enabled/disabled
	-- this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS"); -- This does not seem to work for some reason???
	this:RegisterEvent("UNIT_MODEL_CHANGED"); -- Will use this instead of UPDATE_SHAPESHIFT_FORMS
	
	-- Below is for automatic switching of configurations
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("CHAT_MSG_SYSTEM"); -- Used for duel information
	
	-- "DUEL_REQUESTED" only works if player requests, not if player is requested, so 
	-- we'll parse the system chat messages instead for the countdown messages.
	this:RegisterEvent("DUEL_FINISHED");

end

------------------------------------------------------------------------------------------

function ASO_Unregister_For_Events()

	-- IF YOU ADD A NEW EVENT, ALSO ADD IT TO ASO_Unregister_For_Events() !!!

	--Register Events:
	this:UnregisterEvent("PLAYER_AURAS_CHANGED");
	this:UnregisterEvent("UNIT_AURA"); -- v1.15.0
	this:UnregisterEvent("UNIT_AURASTATE"); -- v1.15.0
	this:UnregisterEvent("UNIT_COMBAT"); -- v1.15.0
	this:UnregisterEvent("UNIT_HEALTH");
	this:UnregisterEvent("UNIT_MANA");
	
	-- Below for variables loading and UnitName("player") initializations...
	this:UnregisterEvent("VARIABLES_LOADED");
	this:UnregisterEvent("PLAYER_ENTERING_WORLD");
	this:UnregisterEvent("UNIT_NAME_UPDATE");
	
	-- Below for Druid changing form, so that UI 'Mana' event type can be enabled/disabled
	-- this:UnregisterEvent("UPDATE_SHAPESHIFT_FORMS"); -- This does not seem to work for some reason???
	this:UnregisterEvent("UNIT_MODEL_CHANGED"); -- Will use this instead of UPDATE_SHAPESHIFT_FORMS
	
	-- Below is for automatic switching of configurations
	this:UnregisterEvent("PARTY_MEMBERS_CHANGED");
	this:UnregisterEvent("RAID_ROSTER_UPDATE");
	this:UnregisterEvent("CHAT_MSG_SYSTEM"); -- Used for duel information
	
	-- "DUEL_REQUESTED" only works if player requests, not if player is requested, so 
	-- we'll parse the system chat messages instead for the countdown messages.
	this:UnregisterEvent("DUEL_FINISHED");

end

------------------------------------------------------------------------------------------

function ASO_Command(msg)

	if (ASO_Debug) then
		ASO_ChatMessage(msg);
	end

    -- If need to redo commands functionality in full, 
    -- use below code instead, cleaner/better...
    --local ASO_Command_Words = {};
    --for msg in string.gfind(msg, "(%S+)") do
    --  table.insert(ASO_Command_Words, msg)
    --end

	-- Break down msg (thank you ChatWatch dev!)
	-- (%S+) are spaces, (%a+) is alphas but doesn't work with special foreign chars!
	local firsti, lasti, command, arg1, arg2, arg3 = string.find(msg, "(%S+) (%S+) (%S+) (%S+)");

	-- command nill if only three arg (instead of four), so check again
    if (command == nil) then
		-- (%S+) are spaces, (%a+) is alphas but doesn't work with special foreign chars!
		firsti, lasti, command, arg1, arg2 = string.find(msg, "(%S+) (%S+) (%S+)");
	end

	-- command nill if only two arg (instead of three), so check again
    if (command == nil) then
		-- (%S+) are spaces, (%a+) is alphas but doesn't work with special foreign chars!
		firsti, lasti, command, arg1 = string.find(msg, "(%S+) (%S+)");
	end

	-- command nill if only one arg (instead of two), so check again
    if (command == nil) then
		-- (%S+) are spaces, (%a+) is alphas but doesn't work with special foreign chars!
    	firsti, lasti, command = string.find(msg, "(%S+)");
    end 

	if (ASO_Debug) then
		ASO_ChatMessage("Command...");
		ASO_ChatMessage(command);
		ASO_ChatMessage("Args...");
		ASO_ChatMessage(arg1);
		ASO_ChatMessage(arg2);
		ASO_ChatMessage(arg3);
		ASO_ChatMessage(arg4);
		ASO_ChatMessage(arg5);
		ASO_ChatMessage(arg6);
		ASO_ChatMessage(arg7);
		ASO_ChatMessage(arg8);
		ASO_ChatMessage(arg9);
		ASO_ChatMessage("Original string...");
		ASO_ChatMessage(msg);
	end

	-- Now that we have user-supplied info, lets do something
	if ( (command ~= nil) and (string.lower(command) == ASO_LOCSTR_DEBUG) ) then

		if (AutoShoutOut[ASO_LOCSTR_DEBUG_LABEL]) then
			AutoShoutOut[ASO_LOCSTR_DEBUG_LABEL] = false;
			ASO_Debug = AutoShoutOut[ASO_LOCSTR_DEBUG_LABEL];
			message("AutoShoutOut v" .. ASO_Version .. "\n\n"..ASO_LOCSTR_DEBUG_LABEL.." Is "..string.upper(ASO_LOCSTR_OFF)..".");
		else
			AutoShoutOut[ASO_LOCSTR_DEBUG_LABEL] = true;
			ASO_Debug = AutoShoutOut[ASO_LOCSTR_DEBUG_LABEL];
			message("AutoShoutOut v" .. ASO_Version .. "\n\n"..ASO_LOCSTR_DEBUG_LABEL.." Is "..string.upper(ASO_LOCSTR_ON).."!");
		end

	elseif ( (command ~= nil) and (string.lower(command) == ASO_LOCSTR_ON) ) then
		
		AutoShoutOut.NotifyingEnabled = true;
		ASO_ChatMessage(ASO_LOCSTR_OUTPUT_MSG2 .. " " .. ASO_LOCSTR_ON .. ".");
		ASO_Register_For_Events();
		
	elseif ( (command ~= nil) and (string.lower(command) == ASO_LOCSTR_OFF) ) then
		
		if ( AutoShoutOutWindow:IsVisible() ) then 
			ASO_Window_Hide();
		end
		
		AutoShoutOut.NotifyingEnabled = false;
		ASO_ChatMessage(ASO_LOCSTR_OUTPUT_MSG2 .. " " .. ASO_LOCSTR_OFF .. ".");
		ASO_Unregister_For_Events();
		
	elseif ( (command ~= nil) and (string.lower(command) == ASO_LOCSTR_STATUS) ) then
		
		if ( ASO_IsStatusOutput() ) then
			AutoShoutOut.StatusOutput = false;
		else
			AutoShoutOut.StatusOutput = true;
		end
		
		local text = ASO_LOCSTR_OUTPUT_MSG1 .. " ";
		if (ASO_IsStatusOutput()) then
			text = text .. ASO_LOCSTR_ON .. ".";
		else
			text = text .. ASO_LOCSTR_OFF .. ".";
		end
		
		ASO_ChatMessage(text);
		
	elseif ( (command ~= nil) and (string.lower(command) == ASO_LOCSTR_WARNMSGS) ) then
		
		if ( ASO_IsWarnMsgs() ) then
			AutoShoutOut.WarnMsgs = false;
		else
			AutoShoutOut.WarnMsgs = true;
		end
		
		local text = ASO_LOCSTR_OUTPUT_MSG4 .. " ";
		if (ASO_IsWarnMsgs()) then
			text = text .. ASO_LOCSTR_ON .. ".";
		else
			text = text .. ASO_LOCSTR_OFF .. ".";
		end
		
		ASO_ChatMessage(text);
		
	elseif ( (command ~= nil) and (string.lower(command) == ASO_LOCSTR_RESET) ) then

		ASO_Confirm_Reinitalize_AutoShoutOut_Table();
		
	elseif ( (command ~= nil) and (string.lower(command) == "buffs") ) then -- Debugging purposes only

		ASO_ShowAllUnitBuffs("player");
		ASO_ChatMessage("Rez Stone? " .. ASO_BooleanToString( ASO_HasRezStone() ) );
		
	else
	
		if ( ASO_IsNotifyingEnabled() ) then
		
			if (ASO_Debug) then
				if ( (ASO_LOCSTR_CHARACTER ~= nil) and (ASO_CharacterName ~= nil) ) then
					ASO_ChatMessage(ASO_LOCSTR_CHARACTER .. ": " .. ASO_CharacterName);
				end
			end
		
			ASO_Window_Toggle();
		
		else
		
			message(ASO_LOCSTR_OUTPUT_MSG3);
		
		end

	end
	
end

------------------------------------------------------------------------------------------

function ASO_SetMessage(type, settings, target, msg)

	if (string.lower(target) == ASO_LOCSTR_ON) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].MessageEnabled = true;
	elseif (string.lower(target) == ASO_LOCSTR_OFF) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].MessageEnabled = false;
	else
		if ( ASO_IsStringLOCAL(target) or ASO_IsStringSAY(target) or ASO_IsStringPARTY(target) or ASO_IsStringRAID(target) ) then
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].MessageTarget = string.upper(target);
		else
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].MessageTarget = target;
		end
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].MessageText = msg;
	end
		
end

------------------------------------------------------------------------------------------

function ASO_SetNotifyCondition(type, settings, msg)

	if (string.lower(msg) == ASO_LOCSTR_COMBAT) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].NotifyCombatOnly = true;
	else
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].NotifyCombatOnly = false;
	end
	
end

------------------------------------------------------------------------------------------

function ASO_SetNotifyDuringDuel(type, settings, msg)

	if (string.lower(msg) == ASO_LOCSTR_ON) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].NotifyDuringDuel = true;
	else
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].NotifyDuringDuel = false;
	end
	
end

------------------------------------------------------------------------------------------

function ASO_SetShout(type, settings, msg)

	if (string.lower(msg) == ASO_LOCSTR_ON) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].ShoutEnabled = true;
	else
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].ShoutEnabled = false;
	end
	
end

------------------------------------------------------------------------------------------

function ASO_SetNotifyPercent(type, settings, msg)

	msg = tonumber(msg);
	if (msg == nil) then
		return;
	end

	local lowValue = 0;
	local highValue = 99;

	if (msg >= lowValue) and (msg <= highValue) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].NotifyPercent = msg;
	else
		local temp = "'"..type.."' "..ASO_LOCSTR_SET_NOTIFY_PERCENT2.." "..lowValue.." & "..highValue.."!";
		message(ASO_LOCSTR_TITLE.."\n"..temp);
	end
	
end

------------------------------------------------------------------------------------------

function ASO_SetNotifyFrequency(type, settings, seconds)

	local seconds = tonumber(seconds);
	if (type == nil or seconds == nil) then
		return;
	end
	
	local lowValue = 1;
	local highValue = 999;

	if (seconds >= lowValue) and (seconds <= highValue) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][settings][type].NotifyFrequency = seconds;
	else
		local temp = "'"..type.."' "..ASO_LOCSTR_SET_NOTIFY_FREQUENCY2.." "..lowValue.." & "..highValue.."!";
		message(ASO_LOCSTR_TITLE.."\n"..temp);
	end
	
end

------------------------------------------------------------------------------------------

function ASO_BooleanToString(bool)
	if (bool == true) then
		return ASO_LOCSTR_TRUE;
	else
		return ASO_LOCSTR_FALSE;
	end
end

------------------------------------------------------------------------------------------=

function ASO_Initialize()

	-- UnitName('player') init coding logic from Iriel - Thanks! :) 
	-- "http://forums.worldofwarcraft.com/thread.aspx?fn=wow-interface-customization&t=46282&tmp=1#post46282"

	if (ASO_Debug) then
		DEFAULT_CHAT_FRAME:AddMessage("AutoShoutOut - ASO_Initialized: " .. ASO_BooleanToString(ASO_Initialized), 1.0,1.0,1.0 );
		DEFAULT_CHAT_FRAME:AddMessage("AutoShoutOut - ASO_Variables_Loaded: " .. ASO_BooleanToString(ASO_Variables_Loaded), 1.0,1.0,1.0 );
		DEFAULT_CHAT_FRAME:AddMessage("AutoShoutOut - UnitName(\"player\"): " .. UnitName("player"), 1.0,1.0,1.0 );
	end

	-- Have all conditions been met so that initialization can be done?
	if (ASO_Initialized or 
		(not ASO_Variables_Loaded) or 
		(not UnitName("player")) or 
		(UnitName("player") == UNKNOWNOBJECT) -- "Unknown Entity") 
	) then
	
		if (ASO_Debug) then
			DEFAULT_CHAT_FRAME:AddMessage("AutoShoutOut - " .. ASO_LOCSTR_DEBUG_MSG5, 1.0,1.0,1.0);
		end
		
		return;
	
	end

	-- Do any post loading of SavedVariables.lua processing

	-- Assign the character name to be used throughout the run of the add-on...
	ASO_CharacterName = UnitName("player");
	ASO_ShowCharacterNameErrorIfError();

	if (ASO_Debug) then
		DEFAULT_CHAT_FRAME:AddMessage(ASO_LOCSTR_DEBUG_MSG6 .. " [" .. ASO_GetCharacterName() .. "]", 1.0,1.0,1.0);
	end
	
	-- New per-player table definition for first-time running new version that has it
	ASO_Initalize_AutoShoutOut_Table();
	

	-- Add AutoShoutOut to myAddOns addons list
	if(myAddOnsFrame) then
		if (ASO_Debug) then
			DEFAULT_CHAT_FRAME:AddMessage("AutoShoutOut "..ASO_LOCSTR_DEBUG_MSG7.." myAddOns!", 1.0,1.0,1.0);
		end
		myAddOnsList.AutoShoutOut = {name = ASO_LOCSTR_TITLE, description = ASO_LOCSTR_MYADDONS_DESCRIPTION, version = ASO_Version, category = MYADDONS_CATEGORY_COMBAT, frame = "AutoShoutOut", optionsframe = "AutoShoutOutWindow"};
	end

	ASO_Build_Event_Strings();
	
	-- We have been initialized!
	ASO_Initialized = true;

end

------------------------------------------------------------------------------------------

function ASO_GetCharacterName()
	ASO_ShowCharacterNameErrorIfError();
	return ASO_CharacterName;
end

------------------------------------------------------------------------------------------

function ASO_ShowCharacterNameErrorIfError()

	if ( (not ASO_CharacterName) or (ASO_CharacterName == UNKNOWNOBJECT) ) then
		local tempMsg = "AutoShoutOut\n\n" .. ASO_LOCSTR_CHARNAME_ERROR;
		ASO_ChatMessage(tempMsg);
		ASO_CombatMessage(tempMsg);
		ASO_BannerMessage(tempMsg);
		message(tempMsg);
	end

end

------------------------------------------------------------------------------------------

function ASO_Confirm_Reinitalize_AutoShoutOut_Table()

	-- table.insert(StaticPopupDialogs, "AUTOSHOUTOUT_DIALOG");

	StaticPopupDialogs["AUTOSHOUTOUT_DIALOG"] = {
		text = ASO_LOCSTR_CONFIRM_TABLE_INIT,
		button1 = TEXT(ACCEPT),
		button2 = TEXT(CANCEL),
		showAlert = 1,
		timeout = 0,
		OnAccept = function()
			ASO_Reinitalize_AutoShoutOut_Table();
		end,
	};

	StaticPopup_Show("AUTOSHOUTOUT_DIALOG");

end
	
------------------------------------------------------------------------------------------

function ASO_Reinitalize_AutoShoutOut_Table()

	ASO_ChatMessage("AutoShoutOut " .. ASO_LOCSTR_TABLE_INIT, 1.0, 1.0, 1.0);
	
	if (ASO_Debug) then
		ASO_ChatMessage("ASO_Reinitalize_AutoShoutOut_Table()", 0.5, 0.5, 0.5);
	end
	
	-- Reset the current character's info, not ALL of the character's info!
	AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()] = {}
	ASO_Initalize_AutoShoutOut_Table();
	
	ASO_Window_Initialize();
	
end

------------------------------------------------------------------------------------------

function ASO_GetCharactersRealmName()

	-- Idea of using GetCVar("RealmName") from HunterBar FeedButton add-on
	local RealmName = GetCVar("RealmName");
	
	if (RealmName == nil) then
		RealmName = "UNKNOWN";
	end
	
	return RealmName;
	
end

------------------------------------------------------------------------------------------

function ASO_Initalize_AutoShoutOut_Table()

	if ( not AutoShoutOut ) then
		AutoShoutOut = {};
	end

	-- Don't need to test because we always want to overwrite this value!
	AutoShoutOut.Version = ASO_Version;

	if ( AutoShoutOut.NotifyingEnabled == nil ) then
		AutoShoutOut.NotifyingEnabled = true; -- v1.14.0
	end
	
	if ( AutoShoutOut.StatusOutput == nil ) then
		AutoShoutOut.StatusOutput = true; -- v1.10.2
	end
	
	if ( AutoShoutOut.WarnMsgs == nil ) then
		AutoShoutOut.WarnMsgs = true; -- v1.15.2
	end
	
	if ( not AutoShoutOut[ASO_LOCSTR_DEBUG_LABEL] ) then
		AutoShoutOut[ASO_LOCSTR_DEBUG_LABEL] = false; -- v1.13.3
	end
	ASO_Debug = AutoShoutOut[ASO_LOCSTR_DEBUG_LABEL];

	if ( not AutoShoutOut[ASO_LOCSTR_REALM] ) then
		AutoShoutOut[ASO_LOCSTR_REALM] = {};
	end

	if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()] ) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()] = {};
	end

	if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER] ) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER] = {};
	end

	if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()] ) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()] = {};
	end
	
	if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS] ) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS] = {};
	end

	if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] ) then
		ASO_Set_Active_Configuration(ASO_LOCSTR_CONFIGS_SOLO);
	end
	
	-- v1.12.0	
	if ( not ASO_IsAutoSwitch() ) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_AUTOSWITCH] = false;
	end
	
	
	for key,value in pairs(ASO_Settings) do
	
		if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value] ) then
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value] = {};
		end

		if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]] ) then
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]] = {};
		
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].NotifyPercent = 30;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].NotifyFrequency = 10;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].NotifyCombatOnly = true;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].NotifyDuringDuel = false; -- v1.12.0
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].ShoutEnabled = true;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].ShoutEmote = ASO_LOCSTR_DOEMOTE_HEALME;
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].MessageEnabled = false;
			
			if (value == ASO_LOCSTR_CONFIGS_PARTY) then	
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].MessageTarget = ASO_LOCSTR_PARTY;
			elseif (value == ASO_LOCSTR_CONFIGS_RAID) then
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].MessageTarget = ASO_LOCSTR_RAID;
			else
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].MessageTarget = ASO_LOCSTR_LOCAL; -- ASO_GetCharacterName();
			end
			
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_HEALTH_LABEL]].MessageText = ASO_LOCSTR_DEFAULT_MESSAGE_HEALTH;
			
		end
		
		if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]] ) then
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]] = {};
		
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].NotifyPercent = 25;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].NotifyFrequency = 10;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].NotifyCombatOnly = true;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].NotifyDuringDuel = false; -- v1.12.0
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].ShoutEnabled = false;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].ShoutEmote = nil;
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].MessageEnabled = true;
			
			if (value == ASO_LOCSTR_CONFIGS_PARTY) then	
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].MessageTarget = ASO_LOCSTR_PARTY;
			elseif (value == ASO_LOCSTR_CONFIGS_RAID) then
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].MessageTarget = ASO_LOCSTR_RAID;
			else
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].MessageTarget = ASO_LOCSTR_LOCAL; -- ASO_GetCharacterName();
			end
			
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]].MessageText = ASO_LOCSTR_DEFAULT_MESSAGE_PETHEALTH;
			
		end
		
		if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]] ) then
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]] = {};
			
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].NotifyPercent = 15;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].NotifyFrequency = 10;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].NotifyCombatOnly = true;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].NotifyDuringDuel = false; -- v1.12.0
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].ShoutEnabled = true;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].ShoutEmote = ASO_LOCSTR_DOEMOTE_HELPME;
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].MessageEnabled = false;
			
			if (value == ASO_LOCSTR_CONFIGS_PARTY) then	
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].MessageTarget = ASO_LOCSTR_PARTY;
			elseif (value == ASO_LOCSTR_CONFIGS_RAID) then
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].MessageTarget = ASO_LOCSTR_RAID;
			else
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].MessageTarget = ASO_LOCSTR_LOCAL; -- ASO_GetCharacterName();
			end
			
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].MessageText = ASO_LOCSTR_DEFAULT_MESSAGE_LIFE;
			
		end
		
		if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]] ) then
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]] = {};
			
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].NotifyPercent = 5;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].NotifyFrequency = 15;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].NotifyCombatOnly = true;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].NotifyDuringDuel = false; -- v1.12.0
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].ShoutEnabled = true;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].ShoutEmote = ASO_LOCSTR_DOEMOTE_OOM;
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].MessageEnabled = false;
			
			if (value == ASO_LOCSTR_CONFIGS_PARTY) then	
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].MessageTarget = ASO_LOCSTR_PARTY;
			elseif (value == ASO_LOCSTR_CONFIGS_RAID) then
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].MessageTarget = ASO_LOCSTR_RAID;
			else
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].MessageTarget = ASO_LOCSTR_LOCAL; -- ASO_GetCharacterName();
			end
			
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_MANA_LABEL]].MessageText = ASO_LOCSTR_DEFAULT_MESSAGE_MANA;
			
		end
	
		if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]] ) then -- v1.15.0
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]] = {};
			
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].NotifyPercent = 100;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].NotifyFrequency = 60;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].NotifyCombatOnly = false;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].NotifyDuringDuel = false; -- v1.12.0
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].ShoutEnabled = false;
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].ShoutEmote = nil;
	
			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].MessageEnabled = false;

			if (value == ASO_LOCSTR_CONFIGS_PARTY) then	
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].MessageTarget = ASO_LOCSTR_PARTY;
			elseif (value == ASO_LOCSTR_CONFIGS_RAID) then
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].MessageTarget = ASO_LOCSTR_RAID;
			else
				AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].MessageTarget = ASO_LOCSTR_LOCAL; -- ASO_GetCharacterName();
			end

			AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][value][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].MessageText = ASO_LOCSTR_DEFAULT_MESSAGE_REZSTONE;
			
		end
	
	end
	
end

------------------------------------------------------------------------------------------

-- Used for pattern matching system messages to determine if user in/out of duel

function ASO_Build_Event_Strings()

	-- Vars from "FrameXML\GlobalStrings.lua"
			
	if (ASO_Debug) then
		ASO_ChatMessage(DUEL_COUNTDOWN, 0.5, 0.5, 0.5);
		--ASO_ChatMessage(ERR_DUEL_CANCELLED, 0.5, 0.5, 0.5);
		--ASO_ChatMessage(DUEL_WINNER_KNOCKOUT, 0.5, 0.5, 0.5);
		--ASO_ChatMessage(DUEL_WINNER_RETREAT, 0.5, 0.5, 0.5);
		ASO_ChatMessage("-----");
	end
	
	-- We strip out any argument value markers in the default strings 
	-- like player names (%s / %1), or time left (%d), etc.  These substrings
	-- are then used later to parse though event mesages that come in, to see
	-- if all of the words in these substrings exist in the received message.
	
	ASO_SYSMSG_DUEL_COUNTDOWN = string.gsub(DUEL_COUNTDOWN,"%%d","");
	if (ASO_Debug) then
		ASO_ChatMessage("[" .. ASO_SYSMSG_DUEL_COUNTDOWN .. "]", 0.5, 1.5, 0.5);
	end
	
	-- Event DUEL_FINISHED should handle the ending of a duel for both parties.
	
	--ASO_SYSMSG_DUEL_WINNER_KNOCKOUT = string.gsub(DUEL_WINNER_KNOCKOUT,"%%1%$s","");
	--ASO_SYSMSG_DUEL_WINNER_KNOCKOUT = string.gsub(ASO_SYSMSG_DUEL_WINNER_KNOCKOUT,"%%2%$s","");
	--if (ASO_Debug) then
	--	ASO_ChatMessage("[" .. ASO_SYSMSG_DUEL_WINNER_KNOCKOUT .. "]", 0.5, 1.5, 0.5);
	--end	

	--ASO_SYSMSG_DUEL_WINNER_RETREAT = string.gsub(DUEL_WINNER_RETREAT,"%%2%$s","");
	--ASO_SYSMSG_DUEL_WINNER_RETREAT = string.gsub(ASO_SYSMSG_DUEL_WINNER_RETREAT,"%%1%$s","");
	--if (ASO_Debug) then
	--	ASO_ChatMessage("[" .. ASO_SYSMSG_DUEL_WINNER_RETREAT .. "]", 0.5, 1.5, 0.5);
	--end
	
end

------------------------------------------------------------------------------------------

-- We intercept the ItemRef:SetItemRef(link, button) method call, to see if the user did a
-- ctrl-left-click, which means they want to target the source of the message.
local OLD_SetItemRef = SetItemRef;
function SetItemRef(link, text, button)
	if ( strsub(link, 1, 6) == "player" ) then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			-- name = gsub(name, "([^%s]*)%s+([^%s]*)", "%2");
			if ( button == "LeftButton" and IsControlKeyDown() ) then

				local targetName = UnitName("target");
				if (ASO_debug) then
					if (targetName ~= nil) then
						ASO_ChatMessage("targetName: " .. targetName);
					else
						ASO_ChatMessage("targetName: nil!");
					end
				end
		
				-- If already targeted, target pet if unit has one			
				if (name == targetName) then
				
					if (ASO_Debug) then
						ASO_ChatMessage("AutoShoutOut: Targeting ["..name.."]'s pet!");
					end
					
					-- TargetUnitsPet(Unit) was deprecated in WoW v1.6!
					-- v1.15.3 (for WoW 1.6) (Thank you Silmalia (http://forums.worldofwarcraft.com/thread.aspx?ForumName=wow-interface-customization&ThreadID=179460))
					if(not TargetUnitsPet) then
						TargetUnitsPet = function(name)
							-- THIS IS NOT WORKING!
							TargetUnit(name.."pet"); -- Only works in party/raid
						end
					end
					TargetUnitsPet("target");
						
				-- Not already targeted, so try and target
				else				
				
					if (ASO_Debug) then
						ASO_ChatMessage("AutoShoutOut: Targeting ["..name.."]");
					end
					
					TargetByName(name);
					
					-- Lets verify that unit was targeted successfully
					targetName = UnitName("target");
					if (name ~= targetName) then
						-- Something went wrong!
						message(ASO_LOCSTR_TITLE.."\n\n" .. ASO_LOCSTR_TARGET_ERROR .. " ["..name.."]!");
						ClearTarget();
					end
					
				end
				
			else
				OLD_SetItemRef(link, text, button);
			end
		end
		return;

	else
		OLD_SetItemRef(link, text, button);
	end
	
end

------------------------------------------------------------------------------------------

function ASO_OnEvent(event)

	if (ASO_Debug) then
		local msg = "ASO_OnEvent: ";
		if (event ~= nil) then
			msg = msg .. event;
		end
		if (arg1 ~= nil) then
			msg = msg .. " arg1: " .. arg1;
		end
		if (arg2 ~= nil) then
			msg = msg .. " arg2: " .. arg2;
		end
		if (arg3 ~= nil) then
			msg = msg .. " arg3: " .. arg3;
		end
		if (arg4 ~= nil) then
			msg = msg .. " arg4: " .. arg4;
		end
		if (arg5 ~= nil) then
			msg = msg .. " arg5: " .. arg5;
		end
		if (arg6 ~= nil) then
			msg = msg .. " arg6: " .. arg6;
		end
		if (arg7 ~= nil) then
			msg = msg .. " arg7: " .. arg7;
		end
		if (arg8 ~= nil) then
			msg = msg .. " arg8: " .. arg8;
		end
		if (arg9 ~= nil) then
			msg = msg .. " arg9: " .. arg9;
		end
		ASO_CombatMessage(msg);
	end


	-- Have the SavedVariables.lua variables been loaded in yet?
	if (event == "VARIABLES_LOADED") then
		ASO_Variables_Loaded = true;
		ASO_Initialize();
	end


	-- Has the player been fully loaded into the world for the first time or after '/console reloadui'?
	if ( (event == "PLAYER_ENTERING_WORLD") or (event == "UNIT_NAME_UPDATE") ) then
		ASO_Initialize();
	end


	-- If all pre-processing has been done, then do normal operations...
	if (ASO_Initialized == true) then

		
		if (UnitIsDeadOrGhost("player")) then
		
			if (ASO_Debug) then
				ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG8);
			end
			return;
			
		end
		

		-- Warn user that Soulstone Resurrection was applied to them
		-- but AutoShoutOut is not watching for it to go away...		
		if ( (event == "PLAYER_AURAS_CHANGED") or (event == "UNIT_AURA") or (event == "UNIT_AURASTATE") ) then -- v1.15.0
			if ( not ASO_HasBeenGivenRezStone() ) then
				if ( ASO_HasRezStone() ) then
					if ( not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] ][ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]].MessageEnabled ) then
						if ( not ASO_RezStone_Warn_Done ) then 
							if ( ASO_IsWarnMsgs() ) then
								message(ASO_LOCSTR_TITLE .. "\n"..ASO_LOCSTR_REZSTONE_WARNING);
							end
							ASO_RezStone_Warn_Done = true;
						end
					end
					ASO_BeenGivenRezStone = true;
-- ASO_CombatMessage("ASO_BeenGivenRezStone = " .. ASO_BooleanToString(ASO_BeenGivenRezStone), 1.0,1.0,1.0);
				else
					-- Reset warning message tracker if Soulstone Resurrection buff goes away...
					ASO_RezStone_Warn_Done = false;
				end
--			elseif ( not ASO_HasRezStone() ) then
--				ASO_BeenGivenRezStone = false;
---- ASO_CombatMessage("ASO_BeenGivenRezStone = " .. ASO_BooleanToString(ASO_BeenGivenRezStone), 1.0,1.0,1.0);
			end
		end
		
		
		if (event == "UNIT_MODEL_CHANGED") then -- event == "UPDATE_SHAPESHIFT_FORMS" 

			-- Want the Mana event type to be disabled if the Druid 
			-- shapeshifts into a form that doesn't have mana.
			ASO_Window_Initialize();
		
		end	
		
		
		if (event == "DUEL_FINISHED") then
			ASO_SetInDuel(false);
		end
		
		
		if (event == "CHAT_MSG_SYSTEM") then
		
			if (ASO_Debug) then
				ASO_ChatMessage("*** CHAT_MSG_SYSTEM ***");
				ASO_ChatMessage("1");
				ASO_ChatMessage(arg1);
				--ASO_ChatMessage("2");
				--ASO_ChatMessage(arg2);
				--ASO_ChatMessage("3");
				--ASO_ChatMessage(arg3);
				ASO_ChatMessage("---------------");
				
			end
			
			-- Dueling
			-- Vars from "FrameXML\GlobalStrings.lua"
			-- DUEL_REQUESTED = "%s has challenged you to a duel.";
			-- ERR_DUEL_REQUESTED = "You have requested a duel.";
			if ASO_IsWordsInString(arg1, ASO_SYSMSG_DUEL_COUNTDOWN) then -- DUEL_COUNTDOWN = "Duel starting: %d"; -- %d is the number of seconds until the beginning of the duel.
				ASO_SetInDuel(true);
			-- Don't need to parse system message for finish of dueling as there's an event for it (see above)!
			--elseif (arg1 == ERR_DUEL_CANCELLED) then -- ERR_DUEL_CANCELLED = "Duel cancelled.";
			--	ASO_SetInDuel(false);
			--elseif ASO_IsWordsInString(arg1, ASO_SYSMSG_DUEL_WINNER_KNOCKOUT) then -- DUEL_WINNER_KNOCKOUT = "%1$s has defeated %2$s in a duel"; -- %1$s is the winner, %2$s is the loser
			--	ASO_SetInDuel(false);
			--elseif ASO_IsWordsInString(arg1, ASO_SYSMSG_DUEL_WINNER_RETREAT) then -- DUEL_WINNER_RETREAT = "%2$s has fled from %1$s in a duel"; -- %1$s is the winner, %2$s is the loser
			--	ASO_SetInDuel(false);
			end
			
		end
		
		
		-- Auto switching to PARTY/RAID
		if ( ASO_IsAutoSwitch() ) then
		
			if ( ASO_Debug ) then 
				ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG19);
			end
				
			if ( ASO_IsInRaid() ) then
			
				if ( ASO_Debug ) then 
					ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG20);
				end
				
				if ( not ASO_IsActiveConfigRaid() ) then
				
					if ( ASO_Debug ) then 
						ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG21);
					end
				
					ASO_Set_Active_Configuration( ASO_LOCSTR_CONFIGS_RAID );
					ASO_Window_Initialize(true);
					
				end
				
			elseif ( ASO_IsInParty() ) then
			
				if ( ASO_Debug ) then 
					ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG22);
				end
				
				if ( not ASO_IsActiveConfigParty() ) then
				
					if ( ASO_Debug ) then 
						ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG23);
					end
				
					ASO_Set_Active_Configuration( ASO_LOCSTR_CONFIGS_PARTY );
					ASO_Window_Initialize(true);
					
				end
				
			else -- default to 'Solo'
			
				if ( ASO_Debug ) then 
					ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG24);
				end
				
				if ( not ASO_IsActiveConfigSolo() ) then
				
					if ( ASO_Debug ) then 
						ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG25);
					end

					ASO_Set_Active_Configuration( ASO_LOCSTR_CONFIGS_SOLO );
					ASO_Window_Initialize(true);

				end
				
			end
			
		end
		
		
		-- Check Life before Health, as its more important, so 
		-- it doesn't get lost because only one or the other is
		-- ever done (on seperate timers but Health will not be
		-- done if Life needs to be done!).
		if ( ASO_IsNotifyingEnabled() ) then
		
			ASO_CheckLife();
			ASO_CheckHealth();
			ASO_CheckMana();
			ASO_CheckPetHealth();
			ASO_CheckRezStone();
			
		end
		
	end
		
end

------------------------------------------------------------------------------------------

function ASO_IsWordsInString(sysmsg, aso_sysmsg)

	if (ASO_Debug) then
		ASO_ChatMessage("SysMsg:     " .. sysmsg );    	
		ASO_ChatMessage("ASO SysMsg: " .. aso_sysmsg );    	
	end

	counterFound = 0;
	counterMissed = 0;

    if ( not (sysmsg == nil) ) then
    
	    -- Can cause 'C Stack Overflow' errors for some reason!?!?
	    for w in string.gfind(aso_sysmsg, "(%S+)") do -- (%S+) are spaces, (%a+) is alphas but doesn't work with special foreign chars!
	
		    i, j = string.find(sysmsg, w);
		    if (i == nil) then
		      	counterMissed = counterMissed + 1;
		    else
		      	counterFound = counterFound + 1;
		    end
	
	    end
	
		if (ASO_Debug) then
			ASO_ChatMessage("Found:  " .. tostring( counterFound ) );    	
			ASO_ChatMessage("Missed: " .. tostring( counterMissed ) );
		end
		
		-- If new system messages show up with more than two args, 
		-- counterMissed counter value will need to be changed!
		if ( counterMissed == 0 ) then
			return true;
		else
			return false;
		end
	
    end
    
end

------------------------------------------------------------------------------------------

function ASO_CheckHealth()

	-- Don't do health notifications if life notifications need to be done!
	-- Otherwise do health notifications.
	
	-- A health notification needs to be done
	if ( ASO_IsHealthPointsLow( ASO_Events[ASO_LOCSTR_HEALTH_LABEL] ) ) then
	
		-- If not doing any kind of life notifications do low health notifications
		if ( (not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] ][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].ShoutEnabled) and
			 (not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] ][ASO_Events[ASO_LOCSTR_LIFE_LABEL]].MessageEnabled) ) then
			
			if (ASO_Debug) then
				ASO_ChatMessage("'" .. ASO_LOCSTR_HEALTH_LABEL .. "' " .. ASO_LOCSTR_DEBUG_MSG18);
			end
			
			ASO_UseGeneric(ASO_Events[ASO_LOCSTR_HEALTH_LABEL]);
		
		-- Life notifications could have been done, so check if the life percentage 
		-- threshold has not been met.  If it has not, then do low health notifications	
		elseif ( not ASO_IsHealthPointsLow( ASO_Events[ASO_LOCSTR_LIFE_LABEL] ) ) then
		
			if (ASO_Debug) then
				ASO_ChatMessage("'" .. ASO_LOCSTR_HEALTH_LABEL .. "' " .. ASO_LOCSTR_DEBUG_MSG18);
			end
			
			ASO_UseGeneric(ASO_Events[ASO_LOCSTR_HEALTH_LABEL]);
			
		end
		
		-- Otherwise a life notification should have already been done in function ASO_OnEvent(event)!
		
	end
	
	return;
	
end

------------------------------------------------------------------------------------------

function ASO_CheckPetHealth()

	if ( HasPetUI() and ASO_IsHealthPointsLow(ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]) ) then
		if (ASO_Debug) then
			ASO_ChatMessage("'"..ASO_LOCSTR_PETHEALTH_LABEL .. "' " .. ASO_LOCSTR_DEBUG_MSG18);
		end
		ASO_UseGeneric(ASO_Events[ASO_LOCSTR_PETHEALTH_LABEL]);
	end
	
	return;
	
end

------------------------------------------------------------------------------------------

function ASO_CheckLife()
	
	if ( ASO_IsHealthPointsLow(ASO_Events[ASO_LOCSTR_LIFE_LABEL]) ) then
		if (ASO_Debug) then
			ASO_ChatMessage("'"..ASO_LOCSTR_LIFE_LABEL .. "' " .. ASO_LOCSTR_DEBUG_MSG18);
		end
		ASO_UseGeneric(ASO_Events[ASO_LOCSTR_LIFE_LABEL]);
	end
	
	return;
	
end

------------------------------------------------------------------------------------------

function ASO_CheckMana()

	if ( ASO_IsPlayerManaClass() ) then
	
		if ( ASO_IsManaPointsLow(ASO_Events[ASO_LOCSTR_MANA_LABEL]) ) then
			
			if (ASO_Debug) then
				ASO_ChatMessage("'"..ASO_LOCSTR_MANA_LABEL .. "' " .. ASO_LOCSTR_DEBUG_MSG18);
			end
			
			ASO_UseGeneric(ASO_Events[ASO_LOCSTR_MANA_LABEL]);
			
		end
		
	end

	return;
	
end

------------------------------------------------------------------------------------------

function ASO_CheckRezStone()

	if (ASO_Debug) then
		ASO_CombatMessage("ASO_CheckRezStone() - ASO_HasBeenGivenRezStone(): " .. ASO_BooleanToString(ASO_HasBeenGivenRezStone()), 1.0,1.0,1.0);
		ASO_CombatMessage("ASO_CheckRezStone() - not ASO_HasRezStone(): " .. ASO_BooleanToString(not ASO_HasRezStone()), 1.0,1.0,1.0);
	end

	if ( ASO_HasBeenGivenRezStone() ) then
		if ( not ASO_HasRezStone() ) then
			if (ASO_Debug) then
				ASO_ChatMessage("'"..ASO_LOCSTR_REZSTONE_LABEL .. "' " .. ASO_LOCSTR_DEBUG_MSG18);
			end
			ASO_UseGeneric(ASO_Events[ASO_LOCSTR_REZSTONE_LABEL]);
		end
	end
	
	return;
	
end

------------------------------------------------------------------------------------------

function ASO_IsPlayerManaClass()

	local ManaClass = true;
	
	local localizedClass, englishClass = UnitClass("player");
	
	if (englishClass == "DRUID") then
	
		-- Check for Druid in shapeshifted form...
		local numberOfShapes = GetNumShapeshiftForms();
		for i=1,numberOfShapes do
		
			icon, name, active = GetShapeshiftFormInfo(i);
			
			if (active == 1) then
			
				ManaClass = false;
				if (ASO_Debug) then
					ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG9 .. "  ["..englishClass.."]");
				end
				
				break;
				
			end
			
		end
	
	elseif ( (englishClass == "WARRIOR") or (englishClass == "ROGUE") ) then
	
		ManaClass = false;
		if (ASO_Debug) then
			ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG9 .. "  ["..englishClass.."]");
		end
		
	end
	
	return ManaClass;

end

------------------------------------------------------------------------------------------

function ASO_IsHealthPointsLow(type)

	-- Convert player health to a percentage and check if it's less than the 
	-- defined AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][type].NotifyPercent value:
	
	--if (ASO_Debug) then
	--	ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG10 .. " '"..type.."'...",0.0,1.0,0.0);
	--end
	
	local unit = ASO_GetEventTypeUnit(type);

	if (((UnitHealth(unit)/UnitHealthMax(unit))*100)<AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] ][type].NotifyPercent) then
		if (ASO_Debug) then
			ASO_ChatMessage("'"..type.."' " .. ASO_LOCSTR_DEBUG_MSG11,1.0,0.0,0.0);
		end
		return true;
	else
		--if (ASO_Debug) then
		--	ASO_ChatMessage("'"..type.."' " .. ASO_LOCSTR_DEBUG_MSG12,1.0,0.0,0.0);
		--end
		return false;
	end
	
end

------------------------------------------------------------------------------------------

function ASO_IsManaPointsLow(type)

	-- Convert player mana to a percentage and check if it's less than the 
	-- defined AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][type].NotifyPercent value:
	
	--if (ASO_Debug) then
	--	ASO_ChatMessage(ASO_LOCSTR_DEBUG_MSG10 .. " '"..type.."'...",0.0,1.0,0.0);
	--end

	local unit = ASO_GetEventTypeUnit(type);

	if (((UnitMana(unit)/UnitManaMax(unit))*100)<AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][type].NotifyPercent) then
		if (ASO_Debug) then
			ASO_ChatMessage("'"..type.."' " .. ASO_LOCSTR_DEBUG_MSG11,1.0,0.0,0.0);
		end
		return true;
	else
		--if (ASO_Debug) then
		--	ASO_ChatMessage("'"..type.."' " .. ASO_LOCSTR_DEBUG_MSG12,1.0,0.0,0.0);
		--end
		return false;
	end
	
end

------------------------------------------------------------------------------------------

function ASO_IsInCombat(type)

	if (ASO_Debug) then
		ASO_ChatMessage( ASO_LOCSTR_DEBUG_MSG13, 1.0, 0.5, 0.5);
	end
	
	local unit = ASO_GetEventTypeUnit(type);

	if ( UnitAffectingCombat(unit) == 1 ) then

		if (ASO_Debug) then
			ASO_ChatMessage( ASO_LOCSTR_DEBUG_MSG14, 1.0, 0.5, 0.5);
		end
	
		return true;
		
	else

		if (ASO_Debug) then
			ASO_ChatMessage( ASO_LOCSTR_DEBUG_MSG15, 1.0, 0.5, 0.5);
		end
	
		return false;
		
	end
	
end

------------------------------------------------------------------------------------------

function ASO_UseGeneric(Type)

	if (ASO_Debug) then
		ASO_ChatMessage(">>>>> ASO_UseGeneric(Type): " .. Type,1.0,1.0,1.0);
	end
			
	--Check to see if CoolDownTime has passed:
	if (GetTime() - ASO_LastShout[Type] > AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].NotifyFrequency) then
	
		if (ASO_Debug) then
			ASO_ChatMessage("'"..Type.."' "..ASO_LOCSTR_DEBUG_MSG16 .. ASO_BooleanToString(AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].NotifyCombatOnly),1.0,0.75,0.75);
			ASO_IsInCombat(Type); -- for debugging reasons
		end
		
		if ( (AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].NotifyCombatOnly and ASO_IsInCombat(Type)) or (not AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].NotifyCombatOnly) ) then
		
			if ( (not ASO_IsInDuel()) or (ASO_IsInDuel() and AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].NotifyDuringDuel) ) then
			
				-- v1.14.0
				local channelingSpell = false;
				if ( CastingBarFrame.channeling == 1 ) then -- :IsShown()
					channelingSpell = true;
				end
		
				if (ASO_IsStatusOutput()) then
					ASO_CombatMessage(ASO_LOCSTR_COMBAT_MSG1.. " " .. Type .. " (Channeling? [".. ASO_BooleanToString(channelingSpell) .. "]).  " .. ASO_LOCSTR_COMBAT_MSG2 ,1.0, 0.75, 0.75);
				end
	
				if ( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].ShoutEnabled ) then

					-- Don't do OOM shout if spell channeling, as it 'may' cause interruption of spell channeling
					if ( (not channelingSpell) or (ASP_Spell_Channeling and (Type ~= ASO_Events[ASO_LOCSTR_MANA_LABEL])) ) then
						DoEmote( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].ShoutEmote );
					end

				end
			
				if ( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].MessageEnabled ) then
					ASO_SendMessage( Type );
				end
	
				ASO_LastShout[Type] = GetTime();
				return true;
		
			elseif (ASO_IsStatusOutput()) then
				ASO_CombatMessage(ASO_LOCSTR_NOTIFY_DURING_DUEL_OFF, 1.0, 0.75, 0.75);
			end

		end
		
	else
		if (ASO_Debug) then
			ASO_ChatMessage("'"..Type.."' " .. ASO_LOCSTR_DEBUG_MSG17,1.0,0.0,0.0);
		end
	end
			
	return false;

end

------------------------------------------------------------------------------------------

function ASO_SendMessage(Type)

	if (ASO_Debug) then
		ASO_ChatMessage("Method ASO_SendMessage(" .. Type .. ") called!",1.0,1.0,1.0);
	end

	local target = AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].MessageTarget;
	local text = ASO_ParseMessage( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]][Type].MessageText, Type );
	
	if (target ~= nil and text ~= nil) then

		if (ASO_Debug) then
			ASO_ChatMessage("'" .. target .. "' "..ASO_LOCSTR_DEBUG_MSG4..": " .. text,1.0,1.0,1.0);
		end

		if (ASO_IsStringLOCAL(target)) then
			ASO_ChatMessage(text, 1.0, 1.0, 1.0);
		elseif (ASO_IsStringBANNER(target)) then
			ASO_BannerMessage(text, 1.0, 1.0, 1.0);
		elseif (ASO_IsStringSAY(target)) then
			SendChatMessage(text);
		elseif (ASO_IsStringPARTY(target)) then
			-- To prevent "C stack overflow" errors we verify that the user 
			-- is in a PARTY/RAID.  If not, then we do a say instead.
			-- 1.14.1
			if (ASO_IsInRaid() or ASO_IsInParty()) then -- v1.15.4 added ASO_IsInRaid()
				SendChatMessage(text, 'PARTY');
			else
				ASO_ChatMessage("ASO: " .. ASO_LOCSTR_UI_IsMessagingEnabledCheckButtonLabel .. "-" .. ASO_LOCSTR_UI_MessageTargetEditBoxLabel .. ASO_LOCSTR_DEBUG_MSG24, 1.0, 1.0, 0.75);
				SendChatMessage(text);
			end
		elseif (ASO_IsStringRAID(target)) then
			-- To prevent "C stack overflow" errors we verify that the user 
			-- is in a PARTY/RAID.  If not, then we do a say instead.
			-- 1.14.1
			if (ASO_IsInRaid()) then
				SendChatMessage(text, 'RAID');
			else
				ASO_ChatMessage("ASO: " .. ASO_LOCSTR_UI_IsMessagingEnabledCheckButtonLabel .. "-" .. ASO_LOCSTR_UI_MessageTargetEditBoxLabel .. ASO_LOCSTR_DEBUG_MSG24, 1.0, 1.0, 0.75);
				SendChatMessage(text);
			end
		else
			SendChatMessage(text, 'WHISPER', nil, target);
		end
		
	end

end

------------------------------------------------------------------------------------------

function ASO_ParseMessage(text, type)

	local message = text;
	
	-- Must be processed in largest to smallest order, as gsub substitutes substrings too!
	message = string.gsub(message, "$HEALTHPERCENT", math.floor( UnitHealth( ASO_GetEventTypeUnit(type) ) / UnitHealthMax( ASO_GetEventTypeUnit(type) ) * 100 ) );
	message = string.gsub(message, "$HEALTHMAX", UnitHealthMax( ASO_GetEventTypeUnit(type) ) );
	message = string.gsub(message, "$HEALTH", UnitHealth( ASO_GetEventTypeUnit(type) ) );

	message = string.gsub(message, "$MANAPERCENT", math.floor( UnitMana( ASO_GetEventTypeUnit(type) ) / UnitManaMax( ASO_GetEventTypeUnit(type) ) * 100 ) );
	message = string.gsub(message, "$MANAMAX", UnitManaMax( ASO_GetEventTypeUnit(type) ) );
	message = string.gsub(message, "$MANA", UnitMana( ASO_GetEventTypeUnit(type) ) );
	
	message = string.gsub(message, "$NAME", UnitName( ASO_GetEventTypeUnit(type) ) );
	
	return message;
	
end

------------------------------------------------------------------------------------------

-- The below functions should not do a string.upper or string.lower when checking against
-- the constant variable values!  This is so that a player 'Banner' can get a whisper and
-- the user can choose to send messages to the upper center 'BANNER' (channel) area!

function ASO_IsStringLOCAL(text)
	if (text ~= nil and text == ASO_LOCSTR_LOCAL) then
		return true;
	end
	return false;
end

function ASO_IsStringBANNER(text)
	if (text ~= nil and text == ASO_LOCSTR_BANNER) then
		return true;
	end
	return false;
end

function ASO_IsStringSAY(text)
	if (text ~= nil and text == ASO_LOCSTR_SAY) then
		return true;
	end
	return false;
end

function ASO_IsStringPARTY(text)
	if (text ~= nil and text == ASO_LOCSTR_PARTY) then
		return true;
	end
	return false;
end

function ASO_IsStringRAID(text)
	if (text ~= nil and text == ASO_LOCSTR_RAID) then
		return true;
	end
	return false;
end

------------------------------------------------------------------------------------------

function ASO_GetEventTypeUnit(eventType)

	if ( string.lower(eventType) == string.lower(ASO_LOCSTR_PETHEALTH) ) then
		-- if (ASO_Debug) then
		--	ASO_ChatMessage("'"..eventType.."' "..ASO_LOCSTR_DEBUG_MSG2,1.0,1.0,1.0);
		-- end
		return "pet";
	else
		-- if (ASO_Debug) then
		--	ASO_ChatMessage("'"..eventType.."' "..ASO_LOCSTR_DEBUG_MSG3,1.0,1.0,1.0);
		-- end
		return "player";
	end

end


------------------------------------------------------------------------------------------

function ASO_IsStatusOutput()
	return AutoShoutOut.StatusOutput;
end

------------------------------------------------------------------------------------------

function ASO_IsWarnMsgs()
	return AutoShoutOut.WarnMsgs;
end

------------------------------------------------------------------------------------------
-- Global switch check for any kind of notifications
function ASO_IsNotifyingEnabled()
	return AutoShoutOut.NotifyingEnabled;
end

------------------------------------------------------------------------------------------

function ASO_IsAutoSwitch()
	return AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_AUTOSWITCH];
end

------------------------------------------------------------------------------------------

function ASO_IsInParty()
	if ( ASO_Debug ) then 
		ASO_ChatMessage("ASO_IsInParty(): " .. ASO_BooleanToString( ( (not ASO_IsInRaid()) and (GetNumPartyMembers() ~= 0) ) ) );
	end
	return ( (not ASO_IsInRaid()) and (GetNumPartyMembers() ~= 0) );
end

------------------------------------------------------------------------------------------

function ASO_IsInRaid()
	if ( ASO_Debug ) then 
		ASO_ChatMessage("ASO_IsInRaid(): " .. ASO_BooleanToString( (GetNumRaidMembers() ~= 0) ) );
	end
	return (GetNumRaidMembers() ~= 0);
end

------------------------------------------------------------------------------------------

function ASO_IsInDuel()
	if ( ASO_Debug ) then 
		ASO_ChatMessage("ASO_IsInDuel(): " .. ASO_BooleanToString( ASO_InDuel ) );
	end
	return ASO_InDuel;
end

------------------------------------------------------------------------------------------

function ASO_SetInDuel(bool)
	ASO_InDuel = bool;
	if ( ASO_Debug ) then 
		ASO_ChatMessage("ASO_SetInDuel(): " .. ASO_BooleanToString( ASO_InDuel ) );
	end
end

------------------------------------------------------------------------------------------

function ASO_IsActiveConfigSolo()
	-- return AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] == ASO_LOCSTR_CONFIGS_SOLO;
	return ( (not ASO_IsActiveConfigParty()) and (not ASO_IsActiveConfigRaid()) );
end

------------------------------------------------------------------------------------------

function ASO_IsActiveConfigParty()
	return AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] == ASO_LOCSTR_CONFIGS_PARTY;
end

------------------------------------------------------------------------------------------

function ASO_IsActiveConfigRaid()
	return AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] == ASO_LOCSTR_CONFIGS_RAID;
end

------------------------------------------------------------------------------------------

function ASO_ChatMessage(msg,r,g,b)

	if (msg == nil) then
		msg = 'nil';
	end
	
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b);
	else
		message("AutoShoutOut is unable to display a message in your general chat window (DEFAULT_CHAT_FRAME)!\n" .. msg);
	end
	
end

------------------------------------------------------------------------------------------

function ASO_CombatMessage(msg,r,g,b)

	if (msg == nil) then
		msg = 'nil';
	end
	
	if( ChatFrame2 ) then
		ChatFrame2:AddMessage(msg,r,g,b);
	-- else
	--	message("AutoShoutOut is unable to display a message in your combat chat window (ChatFrame2)!\n" .. msg);
	end
	
end

------------------------------------------------------------------------------------------

function ASO_BannerMessage(msg,r,g,b)

	if (msg == nil) then
		msg = 'nil';
	end
	
	if( UIErrorsFrame ) then
		UIErrorsFrame:AddMessage(msg,r,g,b,1.0,UIERRORS_HOLD_TIME);
	else
		message(ASO_LOCSTR_BANNER_DISPLAY_ERROR .. "\n" .. msg );
	end
	
end

-----------------------------------------------------------------------------------------------

function ASO_HasRezStone()

	hasRezStone = ASO_IsPlayerBuffUp("Spell_Shadow_SoulGem"); -- Spell_Shadow_SoulGem
-- ASO_CombatMessage("ASO_HasRezStone(): " .. ASO_BooleanToString(hasRezStone), 1.0,1.0,1.0);
	return hasRezStone;
	
end

-----------------------------------------------------------------------------------------------

function ASO_HasBeenGivenRezStone()
-- ASO_CombatMessage("ASO_HasBeenGivenRezStone(): " .. ASO_BooleanToString(ASO_BeenGivenRezStone), 1.0,1.0,1.0);
	return ASO_BeenGivenRezStone;
end

-----------------------------------------------------------------------------------------------

function ASO_IsPlayerBuffUp(sBuffname)
  return ASO_IsUnitBuffUp("player", sBuffname) 
end;

--Loops through active buffs looking for a string match
--Origin Zorlen's hunter functions (via WowWiki)
function ASO_IsUnitBuffUp(sUnitname, sBuffname) 
  local iIterator = 1
  while (UnitBuff(sUnitname, iIterator)) do
    if (string.find(UnitBuff(sUnitname, iIterator), sBuffname)) then
      return true
    end
    iIterator = iIterator + 1
  end
  return false
end

function ASO_ShowAllUnitBuffs(sUnitname) 
  local iIterator = 1;
  DEFAULT_CHAT_FRAME:AddMessage( format("[%s] Buffs", sUnitname) );
  while (UnitBuff(sUnitname, iIterator)) do
    DEFAULT_CHAT_FRAME:AddMessage( UnitBuff(sUnitname, iIterator), 1, 1, 0);    
    iIterator = iIterator + 1;
  end
  DEFAULT_CHAT_FRAME:AddMessage("---", 1, 1, 0);    
end

-----------------------------------------------------------------------------------------------

-- ========================================================================================
-- ========================================================================================
-- ========================================================================================

function ASO_Window_OnShow()
	ASO_Window_Initialize();
end

--------------------------------------------------------------------------------------------

function ASO_Window_OnHide()
	PlaySound("igMainMenuClose");
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] );
end

--------------------------------------------------------------------------------------------

function ASO_Window_Toggle()

	if ( AutoShoutOutWindow:IsVisible() ) then 
		ASO_Window_Hide();
	else
		PlaySound("igMainMenuOpen");
		AutoShoutOutWindow:Show();
	end	
	
end

--------------------------------------------------------------------------------------------

function ASO_Window_Hide()
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] );
	PlaySound("igMainMenuClose");
	AutoShoutOutWindow:Hide();
end

--------------------------------------------------------------------------------------------

function ASO_Window_Initialize(flagRepaint)

	if ( AutoShoutOutWindow:IsVisible() ) then

		-- Resize UI controls based on localization settings...
		getglobal("AutoShoutOutWindow"):SetWidth(ASO_LOCSTR_UI_MainWindowSize_Width, ASO_LOCSTR_UI_MainWindowSize_Height);
		getglobal("AutoShoutOutWindow_TitleBox"):SetWidth(ASO_LOCSTR_UI_TitleBoxSize_Width, 65);
		getglobal("MessageMessageEditBox"):SetWidth(ASO_LOCSTR_UI_MessageMessageEditBoxSize_Width, 16);
		-- 

		UIDropDownMenu_SetSelectedValue(ConfigurationsDropDown, AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]);
		ASO_Window_Update_Controls(ASO_LOCSTR_HEALTH_LABEL, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );

		getglobal("EventList_GlobalButton1"):LockHighlight();
		getglobal("EventList_GlobalButton2"):UnlockHighlight();
		getglobal("EventList_GlobalButton3"):UnlockHighlight();
		getglobal("EventList_GlobalButton4"):UnlockHighlight();
		getglobal("EventList_GlobalButton5"):UnlockHighlight();

		-- Assign tooltips...		
		getglobal("ConfigurationsDropDown").tooltip = ASO_LOCSTR_UI_TooltipText_ConfigurationsDropDown;
		getglobal("AutoSwitchCheckButton").tooltip = ASO_LOCSTR_UI_TooltipText_AutoSwitchCheckButton;
		getglobal("EventList_GlobalButton1").tooltip = ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton1;
		getglobal("EventList_GlobalButton2").tooltip = ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton2;
		getglobal("EventList_GlobalButton3").tooltip = ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton3;
		getglobal("EventList_GlobalButton4").tooltip = ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton4;
		getglobal("EventList_GlobalButton5").tooltip = ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton5;
		getglobal("NotifyPercentEditBox").tooltip = ASO_LOCSTR_UI_TooltipText_NotifyPercentEditBox;
		getglobal("NotifyFrequencyEditBox").tooltip = ASO_LOCSTR_UI_TooltipText_NotifyFrequencyEditBox;
		getglobal("MessageMessageEditBox").tooltip = ASO_LOCSTR_UI_TooltipText_MessageMessageEditBox;
		getglobal("IsShoutEnabledCheckButton").tooltip = ASO_LOCSTR_UI_TooltipText_IsShoutEnabledCheckButton;
		getglobal("IsMessagingEnabledCheckButton").tooltip = ASO_LOCSTR_UI_TooltipText_IsMessagingEnabledCheckButton;
		getglobal("TargetChannelsButton").tooltip = ASO_LOCSTR_UI_TooltipText_TargetChannelsButton;
		getglobal("MessageTargetEditBox").tooltip = ASO_LOCSTR_UI_TooltipText_MessageTargetEditBox;
		getglobal("AutoShoutOutWindowCloseButton").tooltip = ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindowCloseButton;
		getglobal("AutoShoutOutWindow_Close_Button").tooltip = ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindow_Close_Button;

		-- v1.12.0 addition with autoswitching functionality...
		-- Below is to get around painting bug, where the Configuration dropdown has its value changed
		-- via a set call, and it changes internally, but the text that is displayed does not change.  Hiding
		-- and reshowing the window seems to force a repaint of the dropdown, so that the label reflects
		-- the same value as what it is set to.
		if (flagRepaint) then
			AutoShoutOutWindow:Hide();
			AutoShoutOutWindow:Show();
		end
		
	end
	
end

--------------------------------------------------------------------------------------------

function ASO_Window_EventList_OnClick(whichclick,buttonobject)

	PlaySound("igMainMenuOptionCheckBoxOn");
	
	getglobal("EventList_GlobalButton1"):UnlockHighlight();
	getglobal("EventList_GlobalButton2"):UnlockHighlight();
	getglobal("EventList_GlobalButton3"):UnlockHighlight();
	getglobal("EventList_GlobalButton4"):UnlockHighlight();
	getglobal("EventList_GlobalButton5"):UnlockHighlight();
	
	buttonobject:LockHighlight();

	local btnLabel = getglobal(buttonobject:GetName().."Label");

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
	
	ASO_Window_Update_Controls( btnLabel:GetText(), UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
	
end

--------------------------------------------------------------------------------------------

function ASO_Set_Active_Configuration(config)

	if ( config ~= AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE]) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] = config;
		if ( ASO_IsStatusOutput() ) then
			ASO_CombatMessage("AutoShoutOut " .. ASO_LOCSTR_UI_ConfigurationsDropDownLabel .. ": " .. string.upper( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_ACTIVE] ), 1.0, 0.75, 1.0);
		end
	end
	
end

--------------------------------------------------------------------------------------------

function ASO_Window_Update_Controls( EventTypeDesc, SettingsTypeDesc )

	ASO_Event_Type_Desc_Selected = EventTypeDesc;

	ASO_Set_Active_Configuration(SettingsTypeDesc);
	
	if ( ASO_IsAutoSwitch() ) then
		getglobal("AutoSwitchCheckButton"):SetChecked( 1 );
	else
		getglobal("AutoSwitchCheckButton"):SetChecked( nil );
	end

	getglobal("NotifyPercentEditBox"):SetText( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].NotifyPercent );

	getglobal("NotifyFrequencyEditBox"):SetText( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].NotifyFrequency );

	if ( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].NotifyCombatOnly ) then
		getglobal("IsCombatOnlyCheckButton"):SetChecked( 1 );
	else
		getglobal("IsCombatOnlyCheckButton"):SetChecked( nil );
	end

	if ( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].NotifyDuringDuel ) then
		getglobal("IsNotifyDuringDuelCheckButton"):SetChecked( 1 );
	else
		getglobal("IsNotifyDuringDuelCheckButton"):SetChecked( nil );
	end

	if ( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].ShoutEnabled ) then
		getglobal("IsShoutEnabledCheckButton"):SetChecked( 1 );
	else
		getglobal("IsShoutEnabledCheckButton"):SetChecked( nil );
	end

	if ( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].MessageEnabled ) then
		getglobal("IsMessagingEnabledCheckButton"):SetChecked( 1 );
	else
		getglobal("IsMessagingEnabledCheckButton"):SetChecked( nil );
	end

	getglobal("MessageTargetEditBox"):SetText( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].MessageTarget );

	getglobal("MessageMessageEditBox"):SetText( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].MessageText );
	
	------------------------------------------
	-- Show/Hide controls based on settings...
	------------------------------------------
	
	ASO_Window_OnClick_IsMessagingEnabledCheckButton();
	
	-- If event type selected is 'Rez Stone' then don't let them modify the notify percentage...
	if ( EventTypeDesc == ASO_LOCSTR_REZSTONE_LABEL ) then
		getglobal("NotifyPercentEditBox"):Hide();
	else
		getglobal("NotifyPercentEditBox"):Show();
	end
	
	if ( AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][SettingsTypeDesc][ASO_Events[EventTypeDesc]].ShoutEmote == nil ) then
		getglobal("IsShoutEnabledCheckButtonLabel"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		getglobal("IsShoutEnabledCheckButton"):Disable();
	else
		getglobal("IsShoutEnabledCheckButtonLabel"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		getglobal("IsShoutEnabledCheckButton"):Enable();
	end

	-- If not a class that has a mana pool, disable selection of the mana event type...
	if ( ASO_IsPlayerManaClass() ) then
		getglobal("EventList_GlobalButton3Label"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		getglobal("EventList_GlobalButton3"):Enable();
	else
		getglobal("EventList_GlobalButton3Label"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		getglobal("EventList_GlobalButton3"):Disable();
	end
	
	-- If not a class that has a pet, disable selection of the pet health event type...
	if ( HasPetUI() ) then
		getglobal("EventList_GlobalButton4Label"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		getglobal("EventList_GlobalButton4"):Enable();
	else
		getglobal("EventList_GlobalButton4Label"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		getglobal("EventList_GlobalButton4"):Disable();
	end
	
end

----------------------------------------------------------------------------------------------

function ASO_Save_Settings( EventTypeDesc, SettingsTypeDesc )

	if (ASO_Debug) then
		ASO_ChatMessage("ASO_Save_Settings --> [" .. EventTypeDesc .. "][" .. SettingsTypeDesc .. "]" , 1.0, 1.0, 1.0 );
	end

	if ( getglobal("AutoSwitchCheckButton"):GetChecked() == 1 ) then
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_AUTOSWITCH] = true;
	else
		AutoShoutOut[ASO_LOCSTR_REALM][ASO_GetCharactersRealmName()][ASO_LOCSTR_CHARACTER][ASO_GetCharacterName()][ASO_LOCSTR_CONFIGS][ASO_LOCSTR_CONFIGS_AUTOSWITCH] = false;
	end

	ASO_SetNotifyPercent( ASO_Events[EventTypeDesc], SettingsTypeDesc, getglobal("NotifyPercentEditBox"):GetText() );
	
	ASO_SetNotifyFrequency( ASO_Events[EventTypeDesc], SettingsTypeDesc, getglobal("NotifyFrequencyEditBox"):GetText() );

	if ( getglobal("IsCombatOnlyCheckButton"):GetChecked() == 1 ) then
		ASO_SetNotifyCondition( ASO_Events[EventTypeDesc], SettingsTypeDesc, ASO_LOCSTR_COMBAT);
	else
		ASO_SetNotifyCondition( ASO_Events[EventTypeDesc], SettingsTypeDesc, ASO_LOCSTR_ALWAYS);
	end

	if ( getglobal("IsNotifyDuringDuelCheckButton"):GetChecked() == 1 ) then
		ASO_SetNotifyDuringDuel( ASO_Events[EventTypeDesc], SettingsTypeDesc, ASO_LOCSTR_ON);
	else
		ASO_SetNotifyDuringDuel( ASO_Events[EventTypeDesc], SettingsTypeDesc, ASO_LOCSTR_OFF);
	end

	if ( getglobal("IsShoutEnabledCheckButton"):GetChecked() == 1 ) then
		ASO_SetShout( ASO_Events[EventTypeDesc], SettingsTypeDesc, ASO_LOCSTR_ON );
	else
		ASO_SetShout( ASO_Events[EventTypeDesc], SettingsTypeDesc, ASO_LOCSTR_OFF );
	end

	if ( getglobal("IsMessagingEnabledCheckButton"):GetChecked() == 1 ) then
		ASO_SetMessage( ASO_Events[EventTypeDesc], SettingsTypeDesc, ASO_LOCSTR_ON, nil);
	else
		ASO_SetMessage( ASO_Events[EventTypeDesc], SettingsTypeDesc, ASO_LOCSTR_OFF, nil);
	end

	ASO_SetMessage( ASO_Events[EventTypeDesc], SettingsTypeDesc, getglobal("MessageTargetEditBox"):GetText(), getglobal("MessageMessageEditBox"):GetText());
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnClick_IsMessagingEnabledCheckButton()

	if ( getglobal("IsMessagingEnabledCheckButton"):GetChecked() == 1 ) then
	
		getglobal("MessageTargetEditBox"):Show();
		getglobal("MessageMessageEditBox"):Show();
		getglobal("TargetChannelsButton"):Show();
		
		-- For 'Soulstone' event (Soulstone Resurrection buff)...
		if ( ASO_HasRezStone() ) then
			ASO_BeenGivenRezStone = true;
		end
		
	else

		getglobal("MessageTargetEditBox"):Hide();
		getglobal("MessageMessageEditBox"):Hide();
		getglobal("TargetChannelsButton"):Hide();
		
		-- For 'Soulstone' event (Soulstone Resurrection buff)...
		if ( not ASO_HasRezStone() ) then
			ASO_BeenGivenRezStone = false;
		end
		
	end
	
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );

end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnClick_IsCombatOnlyCheckButton()
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnClick_IsShoutEnabledCheckButton()
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnClick_ChannelsButton(buttonobject)

	PlaySound("igMainMenuOptionCheckBoxOn");
	
	if ( getglobal("MessageTargetEditBox"):GetText() == ASO_LOCSTR_LOCAL ) then
		getglobal("MessageTargetEditBox"):SetText( string.upper( ASO_LOCSTR_BANNER ) );
	elseif ( getglobal("MessageTargetEditBox"):GetText() == ASO_LOCSTR_BANNER ) then
		getglobal("MessageTargetEditBox"):SetText( string.upper( ASO_LOCSTR_SAY ) );
	elseif ( getglobal("MessageTargetEditBox"):GetText() == ASO_LOCSTR_SAY ) then
		getglobal("MessageTargetEditBox"):SetText( string.upper( ASO_LOCSTR_PARTY ) );
	elseif ( getglobal("MessageTargetEditBox"):GetText() == ASO_LOCSTR_PARTY ) then
		getglobal("MessageTargetEditBox"):SetText( string.upper( ASO_LOCSTR_RAID ) );
	elseif ( getglobal("MessageTargetEditBox"):GetText() == ASO_LOCSTR_RAID ) then
		-- If player is targeted, enter their name...
		if ( UnitIsPlayer("target") ) then
			getglobal("MessageTargetEditBox"):SetText( UnitName("target") );
		else
			getglobal("MessageTargetEditBox"):SetText( string.upper( ASO_LOCSTR_LOCAL ) );
		end
	-- Redundant...
	--elseif ( getglobal("MessageTargetEditBox"):GetText() == UnitName("target") ) then
	--	getglobal("MessageTargetEditBox"):SetText( string.upper( ASO_LOCSTR_LOCAL ) );
	else
		getglobal("MessageTargetEditBox"):SetText( string.upper( ASO_LOCSTR_LOCAL ) );
	end
	
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );

end

-----------------------------------------------------------------------------------------------

function ASO_Window_ConfigurationsDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, ASO_Window_ConfigurationsDropDown_Initialize);
end

-----------------------------------------------------------------------------------------------

function ASO_Window_ConfigurationsDropDown_OnShow()
	UIDropDownMenu_Initialize(this, ASO_Window_ConfigurationsDropDown_Initialize);
end
								
-----------------------------------------------------------------------------------------------

function ASO_Window_ConfigurationsDropDown_Initialize()

	for key,value in pairs(ASO_Settings) do
	
		info = {};
		info.text = key;
		info.value = value;
		-- info.tooltipText = ASO_LOCSTR_UI_TooltipText_ConfigurationsDropDown; -- Doesn't work!?
		info.func = ASO_Window_ConfigurationsDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
		
	end
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_ConfigurationsDropDown_OnClick()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
	
	UIDropDownMenu_SetSelectedValue(ConfigurationsDropDown, this.value);
	
	ASO_Window_Update_Controls( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnClick_AutoSwitchCheckButton()
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnClick_IsNotifyDuringDuelCheckButton()
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnTabPressed_NotifyPercentEditBox()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
	
	this:ClearFocus();
	getglobal("NotifyFrequencyEditBox"):SetFocus();
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnEnterPressed_NotifyPercentEditBox()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );

	this:ClearFocus();
	getglobal("NotifyFrequencyEditBox"):SetFocus();
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnTabPressed_NotifyFrequencyEditBox()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
	
	this:ClearFocus();
	getglobal("MessageTargetEditBox"):SetFocus();
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnEnterPressed_NotifyFrequencyEditBox()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );

	this:ClearFocus();
	getglobal("MessageTargetEditBox"):SetFocus();
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnTabPressed_MessageTargetEditBox()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
	
	this:ClearFocus();
	getglobal("MessageMessageEditBox"):SetFocus();
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnEnterPressed_MessageTargetEditBox()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );

	this:ClearFocus();
	getglobal("MessageMessageEditBox"):SetFocus();
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnTabPressed_MessageMessageEditBox()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );
	
	this:ClearFocus();
	
	if ( getglobal("NotifyPercentEditBox"):IsVisible() ) then
		getglobal("NotifyPercentEditBox"):SetFocus();
	else
		getglobal("NotifyFrequencyEditBox"):SetFocus();
	end
	
	
end

-----------------------------------------------------------------------------------------------

function ASO_Window_OnEnterPressed_MessageMessageEditBox()

	-- Should only be saving settings that have changed, 
	-- but table is small enough to get away with this.
	ASO_Save_Settings( ASO_Event_Type_Desc_Selected, UIDropDownMenu_GetSelectedValue(ConfigurationsDropDown) );

	this:ClearFocus();
	
	if ( getglobal("NotifyPercentEditBox"):IsVisible() ) then
		getglobal("NotifyPercentEditBox"):SetFocus();
	else
		getglobal("NotifyFrequencyEditBox"):SetFocus();
	end
	
end


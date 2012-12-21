--[[

	The UltimateUI Configuration Master

	This is a set of functions and a window, designed
	to      accept a list of variables, editable in a simple
	configuration view.

	by Alexander Brazie

	==> Demo at the Bottom <==

	Revision: $Rev: 1142 $
	Last Author: $Author: AlexYoshi $
	Last Change: $Date: 2005-03-22 10:20:48 -0600 (Tue, 22 Mar 2005) $
]]--

-- Global values
ULTIMATEUIMASTER_DISPLAY_LIMIT = 10;
ULTIMATEUIMASTER_HEIGHT_LIMIT = 32;
ULTIMATEUIMASTER_CHAT_INIT_WAIT = 1;
ULTIMATEUIMASTER_CHAT_JOIN_DELAY = 3;
ULTIMATEUIMASTER_CHAT_UPDATE_WAIT = 1;
ULTIMATEUIMASTER_CHAT_STABLE_CHECK = 3;
ULTIMATEUIMASTER_VERSION = "$Rev: 1142 $";
ULTIMATEUIMASTER_UPDATE = "$Date: 2005-03-22 10:20:48 -0600 (Tue, 22 Mar 2005) $";

-- Debugger Toggles
ULTIMATEUIMASTER_DEBUG = 1;
CSM_DEBUG = "ULTIMATEUIMASTER_DEBUG";

-- Blizzard Registrations
UIPanelWindows["UltimateUIMasterFrame"] =   { area = "center",      pushable = 0 };

-- These contain the registered variables, and their respective settings
UltimateUIMaster_Configurations = { };
UltimateUIMaster_ChatCommands = { };
UltimateUIMaster_ChatWatches = { };
UltimateUIMaster_ChatTypeMap = { };
UltimateUIMaster_Buttons = { };
UltimateUIMaster_ChannelOrder = { };
UltimateUIMaster_UltimateUIUsers = { };

-- Store UltimateUI Users between sessions?
-- RegisterForSave("UltimateUIMaster_UltimateUIUsers");
-- RegisterForSave("UltimateUIMaster_CVars");

-- Keywords (for use by anyone)
CSM_VARIABLE = "variable";
CSM_TYPE	= "type";
CSM_STRING      = "string";
CSM_DESCRIPTION = "description";
CSM_HANDLER = "onchange";
CSM_CHECKONOFF = "checked";
CSM_SLIDERSTRING = "substring";
CSM_DEFAULTVALUE = "slidervalue";
CSM_SLIDERVALUE = "slidervalue";
CSM_SLIDERMIN = "slidermin";
CSM_SLIDERMAX = "slidermax";
CSM_SLIDERSTEP = "sliderstep";
CSM_SLIDERVALUETEXTTOGGLE = "slidervaluetexttoggle";
CSM_SLIDERTEXTAPPEND = "append";
CSM_SLIDERVALUETEXTMULTIPLIER = "multiplier";
CSM_SECTION = "section";
CSM_ID = "id";
CSM_NAME = "name";
CSM_ICON = "icon";
CSM_LONGDESCRIPTION = "longdescription";
CSM_CALLBACK = "callback";
CSM_TESTFUNCTION = "testfunction";
CSM_ALIASES = "aliases";
CSM_PREVIOUSFUNCTION = "prevfunction";
CSM_CHAINPRE = "chainpre"; -- Chain commands before you call yourself
CSM_CHAINPOST = "chainpost"; -- Chain commands after you call yourself
CSM_CHAINNONE = "chainnone"; -- Don't chain
CSM_CHAINPREVIOUSONLY = "chainpreviousonly"; -- Ignore yourself if you already exist
CSM_TYPELIST = "typelist";
CSM_CHANNELINDEX = "chanindex";
CSM_CHANNELNAME = "channame";
CSM_CHANNELDESC = "chandesc";
CSM_CHANNELSTATE = "chanstate";
CSM_CHANNELCREATE = "chantimeorder";

-- These contain global variables, used for timing/state checks
UltimateUIMaster_StartTime = 0;
UltimateUIMaster_WaitMessage = "";
UltimateUIMaster_WaitButton = "";
UltimateUIMaster_CurrentChannel = "";
UltimateUIMaster_LastChatTime = 0;
UltimateUIMaster_JoinDelay = ULTIMATEUIMASTER_CHAT_JOIN_DELAY;
UltimateUIMaster_LeaveDelay = ULTIMATEUIMASTER_CHAT_JOIN_DELAY;
UltimateUIMaster_VarsLoaded = nil;
UltimateUIMaster_LastPlayer = nil;
UltimateUIMaster_LastRealm = nil;
UltimateUIMaster_ChansLoaded = nil;
UltimateUIMaster_ChansWasOnTaxi = nil;
UltimateUIMaster_LastAsked = nil;
UltimateUIMaster_ChanList = {};
UltimateUIMaster_ChanIDList = {};
UltimateUIMaster_Section = "UUI_COS";
UltimateUIMaster_UseChatFunctions = true;
UltimateUIMaster_LastSection = UltimateUIMaster_Section;
UltimateUIMaster_LastSeparator = nil;
CHANNEL_ULTIMATEUI = "ULTIMATEUI_CHANNEL";
CHANNEL_PARTY = "ULTIMATEUI_PARTY";

-- This registers a variable with the configuration client. --

--[[

  This MUST be called for a variable to appear in the configuration menu.

	ParameterList:
  uui_variable - the global var used and string for the CVar
  uui_type - CHECKBOX, SLIDER, BOTH, BUTTON, SEPARATOR, or SECTION
  uui_string - Associated string
  uui_description -  A three line max description of the variable for the users sake
  uui_handerfunction - Function called with value as first parameter, and second as toggle state when changed.
  uui_defaultcheckedvalue - 1 = Checked, 0 = Unchecked
  uui_defaultvalue - Default value returned when checked
  uui_min - Minimum slider value
  uui_max - Maximum slider value
  uui_substring - Slider or button text
  uui_sliderstep - Increments at which the slider may move
  uui_slidervaluetexton - Toggle for the exact value display of a slider
  uui_slidervalueappend - Whats added to the end of the number
  uui_slidervaluemultiplier - Whats the value multiplied by for display.

 ]]--

function UltimateUI_RegisterConfiguration(
	uui_variable,
	uui_type,
	uui_string,
	uui_description,
	uui_handlerfunction,
	uui_defaultcheckedvalue,
	uui_defaultvalue,
	uui_min,
	uui_max,
	uui_substring,
	uui_sliderstep,
	uui_slidervaluetexton,
	uui_slidervalueappend,
	uui_slidervaluemultiplier )

   -- Prepare for nil values
	if ( uui_description == nil ) then uui_description = ""; end
	if ( uui_defaultcheckedvalue == nil or uui_defaultcheckedvalue == false or uui_defaultcheckedvalue == 0 ) then uui_defaultcheckedvalue = 0;
	else uui_defaultcheckedvalue = 1; end
	if ( uui_defaultvalue == nil ) then uui_defaultvalue = 1; end
	if ( uui_min == nil  ) then uui_min = 0; end
	if ( uui_max == nil  ) then uui_max = 1; end
	if ( uui_slidervalueappend == nil ) then uui_slidervalueappend = ""; end
	if ( uui_slidervaluemultiplier == nil ) then uui_slidervaluemultiplier = 1; end
	if ( uui_type == nil ) then uui_type = "nil"; end
	if ( uui_substring == nil  ) then uui_substring = ""; end
	if ( uui_sliderstep == nil ) then uui_sliderstep = .01; end
	if ( uui_handlerfunction == nil ) then uui_handlerfunction = function ( x ) return; end; end;
	if ( uui_slidervaluetexton == nil or uui_slidervaluetexton == 0) then uui_slidervaluetexton = 0;
	else uui_slidervaluetexton = 1;
	end

	if (not string.find ( uui_variable, "UUI_" )) then
		-- Sea.io.print ( "Invalid Prefix" );
		return; -- We won't permit CVars that could mess up the game
				-- So they must be prefixed with UUI_
	end

	-- Check the specified type
	if ( not uui_type == "CHECKBOX" and not uui_type == "SLIDER" and not uui_type == "SEPARATOR" and not uui_type == "BOTH" and not uui_type == "BUTTON" and not uui_type == "SECTION" ) then
		-- Sea.io.print ( "Invalid Type: "..uui_type );
		return; -- Return if it does not suit our handleable types
	end
	if ( uui_type == "SLIDER" or uui_type == "BOTH" ) then
		if ( uui_defaultvalue == nil) then uui_defaultvalue = 1; end
	end
	if ( uui_type == "SECTION" ) then
		UltimateUIMaster_LastSection = uui_variable;
	end
	if ( uui_type == "SEPARATOR" ) then
		UltimateUIMaster_LastSeparator = uui_variable;
	end

	local newRegistrant = {
		[CSM_VARIABLE] = uui_variable,
		[CSM_TYPE]      = uui_type,
		[CSM_STRING]    = uui_string,
		[CSM_DESCRIPTION] = uui_description,
		[CSM_SLIDERSTRING] = uui_substring,
		[CSM_CHECKONOFF] = uui_defaultcheckedvalue,
		[CSM_SLIDERMIN] = uui_min,
		[CSM_SLIDERMAX] = uui_max,
		[CSM_SLIDERVALUE] = uui_defaultvalue,
		[CSM_SLIDERSTEP] = uui_sliderstep,
		[CSM_SLIDERVALUETEXTTOGGLE] = uui_slidervaluetexton,
		[CSM_SLIDERVALUETEXTMULTIPLIER] = uui_slidervaluemultiplier,
		[CSM_SLIDERTEXTAPPEND] = uui_slidervalueappend,
		[CSM_HANDLER] = uui_handlerfunction,
		[CSM_SECTION] = UltimateUIMaster_LastSection
	}

	-- Check if its already been registered and flag an error
	local found = false;
	for k,v in UltimateUIMaster_Configurations do
		if ( UltimateUIMaster_Configurations[k][CSM_VARIABLE] == uui_variable ) then
			if (((UltimateUIMaster_Configurations[k][CSM_TYPE] == "SECTION") and (uui_type == "SECTION")) or ((UltimateUIMaster_Configurations[k][CSM_TYPE] == "SEPARATOR") and (uui_type == "SEPARATOR"))) then
				return true;
			else
				-- Sea.io.print ( " UltimateUI Register Configuration Error: Duplicate Configuration - "..uui_variable );
				found = true;
			end
		end
	end
	if ( found == false ) then
		local index = nil;
		if (UltimateUIMaster_LastSection and (uui_type ~= "SECTION")) then
			local foundSection = false;
			local foundSeparator = false;
			for k in UltimateUIMaster_Configurations do
				if (foundSeparator and ((UltimateUIMaster_Configurations[k][CSM_TYPE] == "SECTION") or (UltimateUIMaster_Configurations[k][CSM_TYPE] == "SEPARATOR"))) then
					break;
				end
			 	if (foundSection and UltimateUIMaster_LastSeparator and (UltimateUIMaster_Configurations[k][CSM_VARIABLE] == UltimateUIMaster_LastSeparator)) then
			 		foundSeparator = true;
			 	end
			 	if (foundSection and (UltimateUIMaster_Configurations[k][CSM_TYPE] == "SECTION")) then
					break;
				end
				if (UltimateUIMaster_Configurations[k][CSM_VARIABLE] == UltimateUIMaster_LastSection) then
			 		foundSection = true;
			 	end
			 	if (foundSection) then
			 		index = k;
			 	end
			end
		end
		-- Add the new registrant to the list
		if (index) then
			table.insert ( UltimateUIMaster_Configurations, index + 1, newRegistrant );
		else
			table.insert ( UltimateUIMaster_Configurations, newRegistrant );
		end
	end

	--if ( uui_type=="SLIDER" or  uui_type=="BOTH" ) then
		UltimateUI_RegisterCVar(uui_variable, uui_defaultvalue);
	--end
	--if (  uui_type=="CHECKBOX" or  uui_type=="BOTH" ) then
		UltimateUI_RegisterCVar(uui_variable.."_X", uui_defaultcheckedvalue);
	--end

	return true;

end

--[[
	UltimateUI_UpdateValue allows you to manually update a parameter.

	I presume upon the user to use this properly.
	If you break it, tough luck. No error checking here.

	parameter list:

	uui_uniqueid - UniqueID (CVar) (technically it updates every match)
	uui_parameter - Parameter to be updated,
	uui_value - new value to be set.

	Example usage
	UltimateUI_UpdateValue( "UUI_MYVAR", CSM_TYPE, "BUTTON" );
	UltimateUI_UpdateValue( "UUI_MYVAR", CSM_SLIDERVALUETEXTMULTIPLIER, UnitHealthMax("player") );
  ]]--

function UltimateUI_UpdateValue( uui_uniqueid, uui_parameter, uui_value )

	if( uui_parameter == CSM_CHECKONOFF ) then
		if ( uui_value+0 == 0 or uui_value+0 == 1 ) then
		else return; end
	end
	if( uui_parameter == CSM_TYPE ) then
		if ( uui_value == "SLIDER" or uui_value == "CHECKBOX" or uui_value == "BOTH"
		or  uui_value == "BUTTON" or uui_value == "SEPARATOR" or uui_value == "SECTION" ) then
		else return; end
	end
	if( uui_parameter == CSM_SLIDERSTEP ) then
		if ( uui_value == 0 ) then uui_value = .01;
		else return; end
	end

	for index, value in UltimateUIMaster_Configurations do
		if ( value[CSM_VARIABLE] == uui_uniqueid ) then
			value[uui_parameter] = uui_value; -- Hope the user doesnt break it.
		end
	end

end

--[[

    UltimateUI_RegisterChatCommand

    Allows you to register an in-game chat command with UltimateUI's simple registration system.
    It will also cause your command to be listed with the /help or /eshelp command locally.

	usage:

	UltimateUI_RegisterChatCommand( GroupID, Array of commands, handler of 1 argument, chaining instructions );

	example:		this.chatFrame.channelList[i] = name;
		this.chatFrame.zoneChannelList[i] = zoneChannel;
	function MyCallback (message) DEFAULT_CHAT_FRAME:AddMessage(message,r,g,b); end
	MyCommands = { "/testa", "/testb", "/testc" }
	UltimateUI_RegisterChatCommand( "TESTGROUP", MyCommands, MyCallback, "My Function", CSM_CHAINPOST);

	Will create a command that executes MyCallback, and anything else that was listed for testgroup previously.

	]]--

function UltimateUI_RegisterChatCommand( uui_groupid, uui_commands, uui_handler, uui_descriptionstring, uui_chaintype )
	-- Error checking.
	if ( uui_groupid == nil ) then
		-- Sea.io.print( " No Group ID specified." );
		return;
	end
	if ( uui_commands == nil ) then
		-- Sea.io.print( uui_groupid.." No /command specified." );
		return;
	end
	if ( uui_handler == nil ) then
		-- Sea.io.print( uui_groupid.." No functions specified." );
		return;
	end

	-- Adds the command handler to the chat global pane
	cmdlist = getglobal ( "SlashCmdList" );

	local uui_prevfunc = nil;

	-- Save the old commands if you're overwriting one
	if ( cmdlist [ uui_groupid ] ~= nil ) then
		uui_prevfunc = cmdlist [ uui_groupid ] ;
	end

	-- Error checking
	if ( uui_prevfunc == nil ) then
		uui_prevfunc = function () return; end;
	end

	-- Set the new command
	if ( uui_chaintype == CSM_CHAINPRE ) then
		cmdlist [ uui_groupid ]
			= function (msg)
				uui_prevfunc(msg);
				uui_handler(msg);
			end;
	end

	if ( uui_chaintype == CSM_CHAINPOST ) then
		cmdlist [ uui_groupid ]
			= function (msg)
				uui_handler(msg);
				uui_prevfunc(msg);
			end;
	end
	if ( uui_chaintype == CSM_CHAINPREVIOUSONLY ) then
		cmdlist [ uui_groupid ]
			= function (msg)
				uui_prevfunc(msg);
			end;
	end
	if ( uui_chaintype == nil or uui_chaintype == CSM_CHAINNONE ) then
		cmdlist [ uui_groupid ]
			= function (msg)
				uui_handler(msg);
			end;
	end

	-- Create a new command and save it locally.
	-- Sky.registerSlashCommand({id=uui_groupid,commands=uui_commands,onExecute=uui_handler,action=uui_prevfunc, helpText=uui_descriptionstring} );
end

--[[

	RegisterButton

	Allow you to create a button of your mod in the UltimateUI Features Frame.

	Usage:

		UltimateUI_RegisterButton ( name, description, ToolTip_description, icon, callback, testfunction )

	Example:

		UltimateUI_RegisterButton (
			"Name",
			"Little Text",
			"Long Tool Tip Text",
			"Interface\\Icons\\Spell_Holy_BlessingOfStrength",
			function()
				if (GamesListFrame:IsVisible()) then
					HideUIPanel(GamesListFrame);
				else
					ShowUIPanel(GamesListFrame);
				end
			end,
			function()
				if (UnitInParty("party1")) then
					return true; -- The button is enabled
				else
					return false; -- The button is disabled
				end
			end
			);

		A button will be created in the Features Frame.

		Description must not be more than 2 words, you should put a longer description in the tool tip.

	]]--

function UltimateUI_RegisterButton ( uui_name, uui_description, uui_longdescription, uui_icon, uui_callback, uui_testfunction )
	if ( uui_name == nil ) then
		-- Sea.io.print ( "Missing a name for the Button.");
	end
	if ( uui_icon == nil ) then
		-- Sea.io.print ( "Missing an icon path for the Button.");
	end
	if ( uui_callback == nil ) then
		-- Sea.io.print ( "Missing a callback for the Button.");
	end
	if ( uui_testfunction == nil ) then
		uui_testfunction = function () return true; end;
	end

	temp = { };
	temp[CSM_NAME] = uui_name;
	temp[CSM_DESCRIPTION] = uui_description;
	temp[CSM_LONGDESCRIPTION] = uui_longdescription;
	temp[CSM_ICON] = uui_icon;
	temp[CSM_CALLBACK] = uui_callback;
	temp[CSM_TESTFUNCTION] = uui_testfunction;

	tinsert ( UltimateUIMaster_Buttons, temp );

	UltimateUIButton_UpdateButton();
end

--[[

	RegisterChatWatch

	Allows you to register a command to be called when a condition
	is met within a block of text in incoming chat messages.

	Usage:

		UltimateUI_RegisterChatWatch ( id, typearray, handlerfunction, description );

	Example;

		UltimateUI_RegisterChatWatch ( "NOYELLS", {"YELL"}, function (msg) return 0; end );

		This would create a function which disables yells by returning a 0
		(indicating to halt all commands) whenever a type 'YELL' is seen.

		Description is entirely for debugging and observational purposes.

	You can watch the ultimateui channel, just use CHANNEL_ULTIMATEUI instead of the channel type.
	You can watch the ultimateui party channel, just use CHANNEL_PARTY instead of the channel type.

	]]--

function UltimateUI_RegisterChatWatch ( uui_id, uui_typelist, uui_handler, uui_description )

	if ( uui_id == nil ) then
		-- Sea.io.print ( "Missing an ID for ChatWatch.");
	end
	if ( uui_typelist == nil or getn( uui_typelist) == 0 ) then
		-- Sea.io.print ( "No chat types specified for observation");
	end
	if ( uui_handler == nil ) then
		-- Sea.io.print ( "No handler function specified to apply to chat messages");
	end

	newChatWatch = {};
	newChatWatch[CSM_ID] = uui_id;
	newChatWatch[CSM_TYPELIST] = uui_typelist;
	newChatWatch[CSM_HANDLER] = uui_handler;
	newChatWatch[CSM_DESCRIPTION] = uui_description;

	-- Ignore this really useless line
	tinsert ( UltimateUIMaster_ChatWatches, newChatWatch );
	for k,v in uui_typelist do
		if ( UltimateUIMaster_ChatTypeMap[v] == nil ) then UltimateUIMaster_ChatTypeMap[v] = {}; end
		tinsert ( UltimateUIMaster_ChatTypeMap[v], {handler=uui_handler;id=uui_id} );
	end
end

-- this function iterates through the list and processes all commands that match and return not 0
function UltimateUIMaster_PreprocessChat(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, loops, frame)
	-- Sea.io.error("If you're seeing this message, you have an out of date FrameXML folder. Delete it and patch again.");
end

-- Cleans out ultimateui channels
function UltimateUIMaster_CleanChannels()
	local foundChan = false;
	for i = 1, 10, 1 do
		local channelNum, channelName = GetChannelName(i);
		if (channelNum > 0 and  channelName ~= nil) then
			if ( string.find(channelName, "ZParty") or string.find(channelName, "ZUltimateUITemp") or (channelName == UltimateUIMaster_GetChannelName())) then
				LeaveChannelByName(channelName);
				foundChan = true;
			end
		end
	end
	if (foundChan) then
		--UltimateUI_Schedule(1, UltimateUIMaster_CleanChannels);
		return;
	end
	if (UnitOnTaxi("player")) then
		UltimateUIMaster_ChansWasOnTaxi = true;
		--UltimateUI_Schedule(1, UltimateUIMaster_CleanChannels);
		return;
	end
	if (UltimateUIMaster_ChansWasOnTaxi) then
		UltimateUIMaster_ChansWasOnTaxi = false;
		--UltimateUI_Schedule(ULTIMATEUIMASTER_CHAT_INIT_WAIT, UltimateUIMaster_CleanChannels);
		return;
	end
	UltimateUIMaster_ChansLoaded = true;
end

-- Keeps up with new channels that have been joined, and assigns an appropriate number to them in the virtual number system
function UltimateUIMaster_WatchChatOrder()
end

-- Replacement for the normal channel listing, lists UltimateUI numbered channels
function UltimateUIMaster_ListChannels(message, chanNum)
end

-- This fuction obtains the number of the specified channel
function UltimateUIMaster_GetChannelNumber(channel)
end

-- This fuction obtains the number of the specified channel in the ultimateui channel list
function UltimateUIMaster_GetChannelID(name)
end

-- This Determines the name of the UltimateUI channel
function UltimateUIMaster_GetChannelName()
end

function UltimateUIMaster_JoinChannel(channelName)
end

-- Joins a channel and assigns it a number in the ultimateui channel list
-- Dont pass channelID if you want the channel to no longer have a specified ID
function UltimateUIMaster_JoinChannelByID(channelName, channelID)
end

function UltimateUI_LeaveChannel(channelName, loops)
end

function UltimateUI_SendMessage(message)
end

function UltimateUI_LeaveParty()
	for i = 1, 20, 1 do
		local channelNum, channelName = GetChannelName(i);
		
		if (channelNum > 0 and  channelName ~= nil) then
			if ( string.find(channelName, "ZParty") ~= nil ) then
				UltimateUI_LeaveChannel(channelName);
			end
		end
	end
end

function UltimateUI_SendPartyMessage(message)
end

function UltimateUIMaster_ChangePartyChannel()
end

function UltimateUIMaster_GetCurrentPartyChannel()
	local gleader = "gg";

	return "ZParty"..gleader;
end

-- Update callback
function UltimateUIMaster_Update()
	UltimateUIMaster_DrawData();
end

-- Loading function
function UltimateUIMasterFrame_Show()
	UltimateUIMasterFrame_IsLoading = true;
	UltimateUIMaster_DrawData();
	UltimateUIMasterFrame_IsLoading = false;
end

function FixMacroActionButtonErrors()
-- thanks to iriel :)
	if (not MacroFrame_EditMacro) then
		function MacroFrame_EditMacro()
			if (MacroFrame_SaveMacro) then
				MacroFrame_SaveMacro();
			end 
		end
	end
	
end

-- Basic Initialization of global variables
function UltimateUIMaster_Init()
	-- Register UltimateUI' chat commands
	UltimateUI_RegisterUltimateUIChatCommands();

	-- Add CVar watching
	this:RegisterEvent("CVAR_UPDATE");
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	-- Set Up the timers
	UltimateUIMaster_StartTime = GetTime();
	UltimateUIMaster_WaitButton = GetTime() + 0.1;

	-- Reload all variables.
	UltimateUIMaster_Reset();

	local comlist = ULTIMATEUI_COMM;
	local desc	= ULTIMATEUI_DESC;
	local id = "ULTIMATEUIOTHER";
	local func = function(msg)
		if (msg) then
			UltimateUI_SendMessage('<C>'..msg);
			UltimateUIMaster_LastAsked = strupper(msg);
			--UltimateUI_Schedule(5,UltimateUI_DontHaveUltimateUI, msg);
		end
	end
	UltimateUI_RegisterChatCommand ( id, comlist, func, desc );
	
	FixMacroActionButtonErrors();
	
	UltimateUI_IsLoaded = "true";
end

-- Event handling
function UltimateUIMaster_OnEvent(event)
   if (( event == "UNIT_NAME_UPDATE" ) and (arg1 == "player") and (not UltimateUIMaster_VarsLoaded)) then
		playername = UnitName("player");
		if (playername) then
			if ((playername ~= UKNOWNBEING) and ( playername ~= UNKNOWNOBJECT )) then
				UltimateUIMaster_LastPlayer = UltimateUIMaster_CVars[UUI_LAST_PLAYER];
				UltimateUIMaster_LastRealm = UltimateUIMaster_CVars[UUI_LAST_REALM];
				UltimateUIMaster_CVars[UUI_LAST_PLAYER] = playername;
				UltimateUIMaster_CVars[UUI_LAST_REALM] = GetCVar("realmName");
				UltimateUIMaster_VarsLoaded = true;
				UltimateUI_RegisterMissed();
				UltimateUI_SetMissed();
				UltimateUIMaster_LoadVariables();
				UltimateUIMaster_SyncVars();
				UltimateUI_CallVarsLoaded();
			end
		end
	end
	if (event == "VARIABLES_LOADED") then
			UltimateUIMaster_LastPlayer = UltimateUIMaster_CVars[UUI_LAST_PLAYER];
			UltimateUIMaster_LastRealm = UltimateUIMaster_CVars[UUI_LAST_REALM];
			UltimateUIMaster_CVars[UUI_LAST_PLAYER] = playername;
			UltimateUIMaster_CVars[UUI_LAST_REALM] = GetCVar("realmName");
			UltimateUIMaster_VarsLoaded = true;
			UltimateUI_RegisterMissed();
			UltimateUI_SetMissed();
			UltimateUIMaster_LoadVariables();
			UltimateUIMaster_SyncVars();
			UltimateUI_CallVarsLoaded();
	end
end

function UltimateUIMaster_OnUpdate(elapsed)
end

-- Basic Saving
function UltimateUIMaster_Save()
	UltimateUIMaster_StoreVariables();
	UltimateUIMaster_SyncVars();
	-- RegisterForSave("UltimateUIMaster_CVars");
end

-- Basic Reverting
function UltimateUIMaster_Reset()
	UltimateUIMaster_LoadVariables();
	UltimateUIMaster_SyncVars();
end

-- Displays the commands help list
function UltimateUIMaster_ChatCommandsHelpDisplay (msg)
	-- Sea.io.print ( "UltimateUI Help: ");
	for index, value in UltimateUIMaster_ChatCommands do
		if ( value[CSM_DESCRIPTION] == "" ) then
		else
			local aliases = value[CSM_ALIASES];
			if ( aliases and value[CSM_DESCRIPTION]) then
				local helpmsg = "- "..aliases[1].." - "..value[CSM_DESCRIPTION];
				-- Sea.io.printc ( {r=.7,g=.6,b=.8}, helpmsg );
			end
		end
	end

end

-- Shows the current version.
function UltimateUIMaster_ChatVersionDisplay(msg)
	-- Sea.io.print ( "UltimateUI Version: "..ULTIMATEUIMASTER_VERSION.."\n".."UltimateUI Menu Updated: "..ULTIMATEUIMASTER_UPDATE );
end

-- Returns the command alias list for a registered command.
function UltimateUIMaster_GetCommandAliases ( uui_id )
	-- Sea.io.print(uui_id, .5, .5, .5); -- Debug:  This will list all commands passed through

	for index, value in UltimateUIMaster_ChatCommands do
		if ( value[CSM_ID] == uui_id ) then
			return value[CSM_ALIASES];
		end
	end
	-- If none was found, return nil
	return nil;
end

-- Gets the prior functions for a registered command
function UltimateUIMaster_GetPreviousCommand ( uui_id )
	for index, value in UltimateUIMaster_ChatCommands do
		if ( value[CSM_ID] == uui_id ) then
			return value[CSM_PREVIOUSFUNCTION];
		end
	end
	-- If none was found, return nil
	return nil;

end

-- Displays description text.
function UltimateUIMaster_SetInfo( index )
	local realindex = index + FauxScrollFrame_GetOffset(UltimateUIMasterScrollFrame);

	-- Make sure its a valid index.
	if ( realindex > getn ( UltimateUIMaster_Configurations ) ) then return; end

	local config = UltimateUIMaster_GetOffsetValue(realindex);
	if (not config) then return; end
	local descriptiontext = config[CSM_DESCRIPTION];

	if ( realindex == 0 ) then
		-- Sea.io.error ("Invalid UltimateUI Index: 0 ");
	else
		local config = UltimateUIMaster_GetOffsetValue(realindex);
		local descriptiontext = config[CSM_DESCRIPTION];

		if ( not (descriptiontext == "") ) then
			UltimateUIMaster_ClearInfo();
			UltimateUIMasterTextbox:AddMessage("\n"..descriptiontext.."\n ", 156/256, 212/256, 1.0 );
		end
	end
end

-- Displays description text.
function UltimateUIMaster_SetSectionInfo( index )
	local realindex = index + FauxScrollFrame_GetOffset(UltimateUIMasterSectionScrollFrame);

	-- Make sure its a valid index.
	if ( realindex > UltimateUIMaster_GetSectCount() ) then return; end

	local config = UltimateUIMaster_GetOffsetSection(realindex);
	if (not config) then return; end
	local descriptiontext = config[CSM_DESCRIPTION];

	if ( realindex == 0 ) then
		-- Sea.io.error ("Invalid UltimateUI Index: 0 ");
	else
		local config = UltimateUIMaster_GetOffsetSection(realindex);
		local descriptiontext = config[CSM_DESCRIPTION];

		if ( not (descriptiontext == "") ) then
			UltimateUIMaster_ClearInfo();
			UltimateUIMasterTextbox:AddMessage("\n"..descriptiontext.."\n ", 156/256, 212/256, 1.0 );
		end
	end
end

function UltimateUIMaster_ClearInfo()
	UltimateUIMasterTextbox:AddMessage("\n\n\n\n");
end

-- Switches sections
function UltimateUIMaster_Section_OnClick(index)
	if ( not (UltimateUIMasterFrame_IsLoading == 1) and (UltimateUIMaster_DrawDataStarted==0) ) then
		local sectOffset = FauxScrollFrame_GetOffset(UltimateUIMasterSectionScrollFrame);
		local sectionButton = getglobal ("UltimateUISection"..index);
		local section = UltimateUIMaster_GetOffsetSection(index+sectOffset); -- change to + offset
		if (section[CSM_VARIABLE] and (section[CSM_VARIABLE] ~= UltimateUIMaster_Section)) then
			UltimateUIMaster_Section = section[CSM_VARIABLE];
			UltimateUIMaster_DrawData();
		end
	end
end

-- Updates the value when a slider changes...
function UltimateUIMaster_Slider (relativeindex, slidervalue )

	if ( not (UltimateUIMasterFrame_IsLoading == 1) and (UltimateUIMaster_DrawDataStarted==0) ) then
			local append = "";
			local index = relativeindex;
			local funcOffset = FauxScrollFrame_GetOffset(UltimateUIMasterScrollFrame);
			local value = UltimateUIMaster_GetOffsetValue(index+funcOffset); -- change to + offset
			local slider = getglobal ("UltimateUI"..index.."Slider");
			local slidervaluetext = getglobal("UltimateUI"..index.."Slider".."ValueText");

			-- This makes sure that the correct type is being used before setting the value
			if ( value[CSM_TYPE] == "SLIDER" or value[CSM_TYPE] == "BOTH" ) then

				-- Rounds off value to 2 Decimal places
				local newvalue = slidervalue;
				newvalue = floor(newvalue * 100+.5)/100;

				value[CSM_SLIDERVALUE] = newvalue;

				if ( value[CSM_SLIDERVALUETEXTTOGGLE] == 1 ) then
					-- Show only 2 decimal places of accuracy in text
					local valuetext = floor(value[CSM_SLIDERVALUE]*value[CSM_SLIDERVALUETEXTMULTIPLIER]*100+.5)/100;
					valuetext = valuetext..value[CSM_SLIDERTEXTAPPEND];

					slidervaluetext:SetText ( valuetext );
					slidervaluetext:Show();
				else
					slidervaluetext:Hide();

				end

				slidervalue =  value[CSM_SLIDERVALUE];

				-- Call the referring function
				local callback = value[CSM_HANDLER];
				callback(value[CSM_CHECKONOFF],slidervalue);
			end
	end

end

--[[ Handles Checkbox Events ]]--
function UltimateUIMaster_CheckBox (relativeindex, checkedvalue )
	if ( not UltimateUIMasterFrame_IsLoading ) then
		local index = relativeindex;
		local funcOffset = FauxScrollFrame_GetOffset(UltimateUIMasterScrollFrame);
		index = index + funcOffset;
		local value = UltimateUIMaster_GetOffsetValue(index);

		local checkbox = getglobal("UltimateUI"..index.."Checkbox");
		local checkboxtext = getglobal("UltimateUI"..index.."FrameText");

		if ( value[CSM_TYPE] == "CHECKBOX") then
			value[CSM_CHECKONOFF] = checkedvalue;
		else
			if ( value[CSM_TYPE] == "BOTH" ) then
				value[CSM_CHECKONOFF] = checkedvalue;
			else
				value[CSM_CHECKONOFF] = 1;
			end
		end

		-- Call the referring function
		local callback = value[CSM_HANDLER];
		local setval = (0);
		if ( value[CSM_SLIDERVALUE] ) then
			setval = value[CSM_SLIDERVALUE];
		end
		callback(value[CSM_CHECKONOFF], setval);

	end
end

function UltimateUIMaster_Button (relativeindex)
	if ( not (UltimateUIMasterFrame_IsLoading==1) ) then
		local index = relativeindex;
		local funcOffset = FauxScrollFrame_GetOffset(UltimateUIMasterScrollFrame);
		local value = UltimateUIMaster_GetOffsetValue(index+funcOffset); -- change to + offset

		-- Call the referring function
		local callback = value[CSM_HANDLER];
		local setval = value[CSM_SLIDERVALUE];
		local checked = value[CSM_CHECKONOFF];
		if (setval == nil) then setval=1; end
		callback(checked, setval);
	end
end

-- Turns channel management on/off
function UltimateUIMaster_ToggleChannelManager ( toggle, value )
	UltimateUIMaster_ChannelManager = toggle;
end

-- Default behaviour
function UltimateUIMaster_CheckGui( slot )
	--SendChatMessage( "Error, invalid value at slot" + slot );
end

function UltimateUI_UserMessage(message)
	-- Sea.io.print(message);
end

function UltimateUI_DontHaveUltimateUI(user)
	if (strupper(UltimateUIMaster_LastAsked) == strupper(user)) then
		UltimateUI_UserMessage(format(ULTIMATEUI_DONTHAVE,user));
	end
end

-- Updates the ultimateui user list
function UltimateUIMaster_UltimateUIUsers_Update( type, info, message, player, language ) 
	if ( message == "<CL>" ) then
		UltimateUIMaster_UltimateUIUsers[player] = GetTime();
		if (strupper(player) == UltimateUIMaster_LastAsked) then
			UltimateUI_UserMessage(format(ULTIMATEUI_HAVE,player));
		end

		return 0;
	end
	
	if ( "<C>" == strsub(message, 1, 3) ) then
		local name = strsub(message, 4, strlen(message));
		if (strupper(UnitName("player")) == strupper(name)) then
			UltimateUIMaster_UltimateUIUsers[player] = GetTime();
			UltimateUI_SendMessage('<CL>');
		end

		return 0;
	end
end

function UltimateUIMaster_OnOkayClick()
	PlaySound("gsTitleOptionOK");
	UltimateUIMaster_Save();
	HideUIPanel(UltimateUIMasterFrame);
end
-- Synchronizes all global variables
function UltimateUIMaster_SyncVars()
	for index, value in UltimateUIMaster_Configurations do
		if ( value[CSM_TYPE] == "SEPARATOR" or value[CSM_TYPE] == "BUTTON" or value[CSM_TYPE] == "SECTION" ) then
		else
			setglobal(value[CSM_VARIABLE], value[CSM_SLIDERVALUE] );
			setglobal(value[CSM_VARIABLE]..'_X',value[CSM_CHECKONOFF]);
			local callback = value[CSM_HANDLER];
			local slidervalue =  value[CSM_SLIDERVALUE];
			callback(value[CSM_CHECKONOFF],slidervalue);
		end
	end
end

-- Load all variables from CVars
function UltimateUIMaster_LoadVariables()

	for index, value in UltimateUIMaster_Configurations do
		-- Ignore separators
		if ( value[CSM_TYPE] == "SEPARATOR" or value[CSM_TYPE] == "BUTTON" or value[CSM_TYPE] == "SECTION" ) then
		else
			if ( value[CSM_TYPE]=="SLIDER" or value[CSM_TYPE]=="BOTH" ) then
				val = UltimateUI_GetCVar(value[CSM_VARIABLE]);
				if ( val ~= nil ) then
					value[CSM_SLIDERVALUE] = val + 0;
				else
					UltimateUI_SetCVar(value[CSM_VARIABLE], value[CSM_SLIDERVALUE]);
				end
			end
			if ( value[CSM_TYPE]=="CHECKBOX" or value[CSM_TYPE]=="BOTH" ) then
				val = UltimateUI_GetCVar(value[CSM_VARIABLE].."_X");
				if ( val ~= nil ) then
					value[CSM_CHECKONOFF] = val + 0;
				else
					UltimateUI_SetCVar(value[CSM_VARIABLE], value[CSM_CHECKONOFF]);
				end
			end
		end
	end
end

-- Store all variables to CVars
function UltimateUIMaster_StoreVariables()
	for index, value in UltimateUIMaster_Configurations do
		if (not ( value[CSM_TYPE]=="SEPARATOR") and not (value[CSM_TYPE] == "BUTTON") and not (value[CSM_TYPE] == "SECTION") ) then
			if ( value[CSM_TYPE]=="SLIDER" or value[CSM_TYPE]=="BOTH" ) then
				local slidervalue =  value[CSM_SLIDERVALUE] ;

				UltimateUI_SetCVar(value[CSM_VARIABLE], slidervalue);
			end
			if ( value[CSM_TYPE]=="CHECKBOX" or value[CSM_TYPE]=="BOTH" ) then
				UltimateUI_SetCVar(value[CSM_VARIABLE].."_X", value[CSM_CHECKONOFF]);
			end
		end
	end

end

-- Notify all stored methods
function UltimateUIMaster_NotifyAll()
	for index, value in UltimateUIMaster_Configurations do
		if (not ( value[CSM_TYPE] == "SEPARATOR") and not (value[CSM_TYPE] == "BUTTON") and not (value[CSM_TYPE] == "SECTION") ) then
			f = value[CSM_HANDLER];
			local slidervalue =  value[CSM_SLIDERVALUE];

			f(value[CSM_CHECKONOFF],slidervalue);
		end
	end
end

-- Watch CVars
function UltimateUIMaster_HandleCVarUpdate(cvar, val, checked)
	--[[
	for index, value in UltimateUIMaster_Configurations do
		if ( cvar == value[CSM_VARIABLE] ) then
			-- this function now works for checkbox types, but
			-- probably not much else --Thott
			if(value[CSM_TYPE] == "CHECKBOX") then
				value[CSM_CHECKONOFF] = val+0;
			end

			value[CSM_SLIDERVALUE] = val;
		end
	end
	UltimateUIMaster_NotifyAll();
	UltimateUIMaster_DrawData();
	]]
end

-- Helper function to get Offset
function UltimateUIMaster_GetOffsetValue(offset)
	local curList = {};
	local curIndex = 1;
	for dex, curVal in UltimateUIMaster_Configurations do
		if (curVal and (curVal[CSM_TYPE] ~= "SECTION") and (curVal[CSM_SECTION] == UltimateUIMaster_Section)) then
			table.insert(curList, curVal);
		end
	end	
	return curList[offset];
end

-- Helper function to get the number of configurations for the current header
function UltimateUIMaster_GetConfCount()
	confCount = 0;
	for dex, curVal in UltimateUIMaster_Configurations do
		if (curVal and (curVal[CSM_TYPE] ~= "SECTION") and (curVal[CSM_SECTION] == UltimateUIMaster_Section)) then
			confCount = confCount + 1;
		end
	end
	return confCount;
end

-- Helper function to sort the list of the sections
function UltimateUIMaster_SectionComparator(section1, section2)
	if ( ( section1 ) and ( section2 ) ) then
		if ( ( section1[CSM_STRING] ) and ( section2[CSM_STRING] ) ) then
			if ( section1[CSM_STRING] == TEXT(ULTIMATEUI_CONFIG_SEP) ) then
				return true;
			elseif ( section2[CSM_STRING] == TEXT(ULTIMATEUI_CONFIG_SEP) ) then
				return false;
			else
				return (section1[CSM_STRING] < section2[CSM_STRING]);
			end
		elseif ( section1[CSM_STRING] ) then
			return false;
		elseif ( section2[CSM_STRING] ) then
			return true;
		end
	elseif ( section1 ) then
		return false;
	elseif ( section2 ) then
		return true;
	end
end

-- Helper function to get a list of the sections
function UltimateUIMaster_GenerateSectionList()
	local curList = {};
	for dex, curVal in UltimateUIMaster_Configurations do
		if (curVal and (curVal[CSM_TYPE] == "SECTION")) then
			table.insert(curList, curVal);
		end
	end
	table.sort(curList, UltimateUIMaster_SectionComparator);
	return curList;
end

-- Helper function to get Offset
function UltimateUIMaster_GetOffsetSection(offset)
	local curList = UltimateUIMaster_GenerateSectionList();
	return curList[offset];
end

-- Helper function to get the number of sections
function UltimateUIMaster_GetSectCount()
	sectCount = 0;
	for dex, curVal in UltimateUIMaster_Configurations do
		if (curVal[CSM_TYPE] == "SECTION") then
			sectCount = sectCount + 1;
		end
	end
	return sectCount;
end

-- Helper function to set up a section button
function UltimateUIMaster_SectionSetup(button, visible, section)
	local normalTexture = getglobal(button:GetName().."NormalTexture");
	
	if (section) then
		button:SetText(section[CSM_STRING]);
		if (section[CSM_VARIABLE] == UltimateUIMaster_Section) then
			button:LockHighlight();
		else
			button:UnlockHighlight();
		end
	end
	
	if (visible) then
		if (not button:IsVisible()) then
			button:Show();
		end
	else
		if (button:IsVisible()) then
			button:Hide();
		end
	end
	
	if (UltimateUIMaster_GetSectCount() <= 18) then
		button:SetWidth(160);
	else
		button:SetWidth(132);
	end
end

-- Draws the boxes data
function UltimateUIMaster_DrawData()
	local sectCount = UltimateUIMaster_GetSectCount()+2;
	FauxScrollFrame_Update(UltimateUIMasterSectionScrollFrame, sectCount, 18, 32 );
	local sectOffset = FauxScrollFrame_GetOffset(UltimateUIMasterSectionScrollFrame);
	for index=1, 18, 1 do
		local button = getglobal("UltimateUISection"..index);
		local section = UltimateUIMaster_GetOffsetSection(index+sectOffset);
		if (section) then
			UltimateUIMaster_SectionSetup(button, true, section);
		else
			UltimateUIMaster_SectionSetup(button);
		end
	end

	local confCount = UltimateUIMaster_GetConfCount()+2;
	FauxScrollFrame_Update(UltimateUIMasterScrollFrame, confCount, 10, 32 );

	local funcOffset = FauxScrollFrame_GetOffset(UltimateUIMasterScrollFrame);
	local limit = ULTIMATEUIMASTER_DISPLAY_LIMIT;

	if ( UltimateUIMaster_DrawDataStarted == 1 ) then return;
	else UltimateUIMaster_DrawDataStarted = 1; end

	UltimateUIMaster_HideAll();
	
	-- Update all boxes from the configuration
	for index=1, 10, 1 do
		if ( index <= 10 and funcOffset >= 0 and index < getn(UltimateUIMaster_Configurations)) then
			-- Acquire the value object
			local value = UltimateUIMaster_GetOffsetValue(index+funcOffset);
			index = index;
			if ( value == nil ) then break; end

			-- Update checkboxes
			local checkbox = getglobal("UltimateUI"..index.."Checkbox");
			local checkboxtext = getglobal("UltimateUI"..index.."FrameText");
			local chatbox = getglobal("DEFAULT_CHAT_FRAMEEditBox");

			if(  value[CSM_TYPE] == "CHECKBOX" or value[CSM_TYPE] == "BOTH"
			or value[CSM_TYPE] == "SLIDER"   or value[CSM_TYPE] == "BUTTON") then
				if ( value[CSM_STRING] == null ) then
					checkboxtext:Hide();
				else
					checkboxtext:SetText(value[CSM_STRING]);
					checkboxtext:Show();
				end
			end

			if ( value[CSM_TYPE] == "CHECKBOX" or value[CSM_TYPE] == "BOTH" ) then
				checkbox:Show();

				if ( value[CSM_CHECKONOFF] == 1)	then
					checkbox:SetChecked(1);
				else
					checkbox:SetChecked(0);
				end
			end

			-- Update sliders

			if ( value[CSM_TYPE] == "SLIDER" or value[CSM_TYPE] == "BOTH" ) then
				local slider = getglobal ("UltimateUI"..index.."Slider");
				local slidertext = getglobal("UltimateUI"..index.."Slider".."Text");
				local slidervaluetext = getglobal("UltimateUI"..index.."Slider".."ValueText");

				if ( value[CSM_SLIDERVALUETEXTTOGGLE] == 1 ) then
					local valuetext = floor(value[CSM_SLIDERVALUE]*value[CSM_SLIDERVALUETEXTMULTIPLIER]*100+.5)/100;

					valuetext = valuetext..value[CSM_SLIDERTEXTAPPEND];

					slidervaluetext:SetText ( valuetext );
					slidervaluetext:Show();
				else
					slidervaluetext:Hide();
				end
				slidertext:SetText ( value[CSM_SLIDERSTRING] );
				slidertext:Show();
				local slidervalue =  value[CSM_SLIDERVALUE];
				slider:SetMinMaxValues( value[CSM_SLIDERMIN], value[CSM_SLIDERMAX] );
				slider:SetValueStep( value[CSM_SLIDERSTEP] );
				slider:SetValue( slidervalue );
				slider:Show();
			end

			-- Update Separators

			if ( value[CSM_TYPE] == "SEPARATOR" ) then
				local separator = getglobal("UltimateUI"..index.."Separator");
				local separatortext = getglobal("UltimateUI"..index.."Separator".."Text");

				if ( value[CSM_STRING] == nil ) then
					separatortext:Hide();
					separator:Show();
				else
					separatortext:SetText ( value[CSM_STRING] );
					separatortext:Show();
					separator:Show();
				end

				checkbox:Hide();
			end

			-- Update Buttons
			if ( value[CSM_TYPE] == "BUTTON" ) then
				local button = getglobal("UltimateUI"..index.."Button");

				if ( value[CSM_SLIDERSTRING] == nil ) then
					button:SetText("Options");
				else
					button:SetText ( value[CSM_SLIDERSTRING] );
				end
				button:Show();
			end
		end
	end

	UltimateUIMasterFrame_IsLoading = false;
	UltimateUIMaster_DrawDataStarted = 0;

end

--[[  Hides all gui items ]]--
function UltimateUIMaster_HideAll()
	-- Reset all boxes.
	for index = 1, ULTIMATEUIMASTER_DISPLAY_LIMIT, 1 do
		local checkbox = getglobal("UltimateUI"..index.."Checkbox");
		local checkboxtext = getglobal("UltimateUI"..index.."FrameText");
		local slider = getglobal ("UltimateUI"..index.."Slider");
		local slidertext = getglobal("UltimateUI"..index.."Slider".."Text");
		local slidervaluetext = getglobal("UltimateUI"..index.."Slider".."ValueText");
		local button = getglobal("UltimateUI"..index.."Button");
		local separator = getglobal("UltimateUI"..index.."Separator");

		checkbox:SetChecked(0);
		checkbox:Hide();
		checkboxtext:Hide();
		checkboxtext:SetText("Reset");
		slider:Hide();
		slidertext:Hide();
		slidervaluetext:Hide();
		button:SetText("");
		button:Hide();
		separator:Hide();
	end
end

--Shows the UltimateUI Menu Button in the game menu
function ToggleGameMenu(clicked)
	if ( StaticPopup_Visible("CAMP") or StaticPopup_Visible("QUIT") ) then
		return;
	end

	if ( clicked ) then
		if ( OptionsFrame:IsVisible() ) then
			OptionsFrameCancel:Click();
			end
		if ( UltimateUIMasterFrame) then 
			if ( UltimateUIMasterFrame:IsVisible() ) then
				UltimateUIMasterFrameCancel:Click();
			end
		end
		if ( GameMenuFrame:IsVisible() ) then
			PlaySound("igMainMenuQuit");
			HideUIPanel(GameMenuFrame);
		else
			CloseMenus();
			CloseAllWindows()
			PlaySound("igMainMenuOpen");
			ShowUIPanel(GameMenuFrame);
		end
		return;
	end

	
	if ( OptionsFrame:IsVisible() ) then
		OptionsFrameCancel:Click();
	elseif ( GameMenuFrame:IsVisible() ) then
		PlaySound("igMainMenuQuit");
		HideUIPanel(GameMenuFrame);
	elseif ( CloseMenus() ) then
	elseif ( SpellStopCasting() ) then
	elseif ( SpellStopTargeting() ) then
	elseif ( CloseAllWindows() ) then
	elseif ( ClearTarget() ) then
	else
		PlaySound("igMainMenuOpen");
		ShowUIPanel(GameMenuFrame);
	end
end


-------------------------------------------------------------------------------
-- Example Code
-------------------------------------------------------------------------------

--[[
 An Example of how this could be used :

-- Example Callback Functions
function CombatCaller_HealthEnabledCallback (state, onoff)
	if( onoff == 1) then
		SendChatMessage ( state );
	end
end
function CombatCaller_ManaEnabledCallback (state, onoff)
	if ( onoff == 1) then
		SendChatMessage ( state );
	end
end

All you have to do is call:

	UltimateUI_RegisterConfiguration("UUI_MYMOD_MYVALUE", "BOTH", "Abc ShortDescription", "Abc Long description\n line12",CombatCaller_HealthEnabledCallback, 0, .5, 0, 1, "BarName", 1, 1, "%");

And I'll call CombatCaller_HealthEnabledCallback(value); every time the value changes!

If you need to read the value regularly, just check the variable ULTIMATEUI_MYMOD_MYVALUE.

	Example arrays stored:
	(You dont have to create these, I make them in Register)

UltimateUI_CombatCallerEnableHealthConfig = {
	[CSM_VARIABLE]="UUI_COMBATCALLER_HEALTHENABLED", -- The CVar and global value that is updated
	[CSM_TYPE]="BOTH", -- CHECKBOX, SLIDER or BOTH
	[CSM_STRING]="Enable Auto Low Health Shout", -- The Text string
	[CSM_DESCRIPTION]="Long description here\n moretext";
	[CSM_CHECKONOFF]=1,     -- Starts off checked = true (1)
	[CSM_HANDLER]=CombatCaller_HealthEnabledCallback, -- The Function called when the value changes.
	[CSM_SLIDERMIN]=0,		-- Min value on slider
	[CSM_SLIDERMAX]=1,		-- Max value on slider
	[CSM_SLIDERVALUE]=.5,   -- Default value on slider
	[CSM_SLIDERSTEP]=.01,   -- Increments on slider
	[CSM_SLIDERSTRING]="Health Limit",      -- Slider Text (optional)
	[CSM_SLIDERVALUETEXTTOGGLE]=1,			-- Slider Text On/Off toggle
	[CSM_SLIDERTEXTAPPEND]="\%",
	[CSM_SLIDERVALUETEXTMULTIPLIER]=100
}
UltimateUIMaster_CombatCallerThankYouConfig = {
	[CSM_VARIABLE]="UUI_COMBATCALLER_THANKYOUENABLED",
	[CSM_TYPE]="CHECKBOX",
	[CSM_STRING]="Enable Auto Thank You Shout",
	[CSM_DESCRIPTION]="",
	[CSM_CHECKONOFF]=1,     -- Default on?
	[CSM_HANDLER]=CombatCaller_HealthEnabledCallback,
	[CSM_SLIDERMIN]=0,      -- Everything below is useless for checkbox only.
	[CSM_SLIDERMAX]=1,
	[CSM_SLIDERVALUE]=1,
	[CSM_SLIDERSTEP]=.01, --Unimportant for checkboxes
	[CSM_SLIDERSTRING]="",
	[CSM_SLIDERVALUETEXTTOGGLE]=0 -- 0 for off!
}

	Please use this wisely.

	-Alex

	------------------------------------------------------------------

	How to register a chat command:

	--Create a function for your command:
	function myfunc () return 4; end

	--Create a list of /commands you want applied.
	mycommands = { "/mycommand", "/mycommands" };

	--Create a help description
	local mydesc = "This is my command!";

	--Pick a name or an action you are overwriting.
	local myfuncname = "CUSTOMMINE";

	--Choose how to handle a command if you overwrite it. (usually CSM_CHAINNONE)
	local mychain = CSM_CHAINNONE;

	--Register it
	UltimateUIMaster_RegisterChatCommand( myfuncname, mycommands, myfunc, mydesc, mychain );

	-- Thats it!

]]--


-- Compatability stuffs
-- UltimateUI_Schedule = Chronos.schedule;
-- UltimateUI_ScheduleByName = Chronos.scheduleByName;
-- UltimateUI_AfterInit = Chronos.afterInit;

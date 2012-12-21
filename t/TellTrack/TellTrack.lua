--[[
	Tell Track

	By AnduinLothar, sarf & Lash

	This mod allows you to keep track of people you have had whisper conversations with.

	Thanks goes to Lash for the idea, support and the development of the XML file 
	(as well as providing acceleration to the rear end of sarf).
	Remember, only Lash prevented your CPU from suffering from loops galore!
	
	CosmosUI URL:
	http://www.cosmosui.org/
	
	Change Log:
	v1.1 (2/11/05) - Taken Over by AnduinLothar:
		-The newest whisper appears on the bottom and TellTrack auto-scrolls when updated.
		-Also added a "Delete All" option to the right-click menu.
		-Now monitors incomming whispers and adds their sender to the list.
		-If they were the last one to whisper their name is red. If you whispered last their name is green.
		-Added /re or /retell slash commands to whisper the last person you whispered.
		-Made retell bindable too. (I use shift-r)
		-Works w/o cosmos now.
	v1.2 (2/15/05) 
		-TellTrack is now resizable! Drag the bottom right corner. Remade button graphics to stretch correctly.
		-Added ability to extend up to 20 or down to 2 visible names.
		-List is now invertable "/telltrackinvert" or use cosmos options or right-click menu (cosmos only).
		-Bugfix for variable saving for non-cosmos users.
	v1.21 (2/15/05) 
		-Updated the toc version number to 4211.
		-Updated the right-click menu height
	v1.22 (2/15/05) 
		-Compressed images.
		-Made image alpha layers compatible with UI transparency (TransNUI)
	v1.23 (2/19/05)
		-Fixed name length trunkating.
		-Fixed right-click indexing and menu problems.
		-Added resize tooltip.
		-Optimized the arrow buttons code.
		-Fixed a rare bug where if you closed TellTrack while resizing or moving you couldn't click on anything.
		-Tooltip now scales correctly (set parent to UIParent)
	v1.24 (2/21/05) 
		-Fixed too many buttons showing onload.
		-Fixed unhooking issue with Sky.
		-Fixed reseting offset on Cosmos options cancil and login/reload.
	v1.25 (2/21/05)
		-Fixed Resize bug with too many buttons showing
	v1.3 (3/25/05)
		-Updated TOC to 1300
		-Fixed RMB Menu to use Earth instead of the obsolete Cosmos Menu
		-French Localization by Elzix and Sasmira
		-Fixed Wrong Faction Detected
	v1.4 (7/25/05)
		-Updated TOC to 1600
		-Added Khaos Configuration Support
		-Added Visibility Options Support
		-Added Sky Slash command Support
		-Fixed TellTrack not showing onload.
	v1.5 (8/2/05)
		-Added Shift-Click 'Who'
		-Added Alt-Click group invitation
		-Added Control-Click add to friends list
		-Added (Optional) Whisper Conversation Issolation
		(first click shows conversation, second click whispers)
		-Fixed inverted auto-scrolls on button update
		-Added list auto-scrolls for outgoing whispers.
		-If whisper frame is visible, 'enter' initiates a whisper
		-If there is not current conversation issolation defaults to off
		-When whisper frame is not visible a number on the TellTrack frame indicates the number of unread whipers from each person
		-Added option to not store list between login
		-Added VisibilityOptions for TellTrack Border/ScrollButtons
		-Auto WhisperChatFrame Creation
		-WhisperChatFrame saved for each realm/character
		-Added option to hide all other whispers
		-Added optional whisper frame time stamping
		-Compatibility with ChatTimeStamp seperator and date options.
		-Will utilize Clock value for time stamps if availible.
	v1.51 (9/18/05)
		-Fixed TellTrackTooltip nil bug.
	v1.52 (10/05/05)
		-Fixed a bug whispering players whose name started with a special character.
	v1.6 (10/12/05)
		-TOC updated to 1800
		-updated to use chatFrame:Clear()
		-Added 'Whisper First' option to open whisper on first click rather than view the chat log.
		-Fix for capitalization bug which caused whisper frame to not show received messages under certain circumstances
	v1.7 (11/13/05)
		-German localization updated.
		-Fixed the percentage issue
		-Renamed TellTrack_AddWhipser to TellTrack_AddWhisper.
		-Guilded and Sky whispers should now be hidden.
	v1.71 (11/16/05)
		-GuildAds should now be hidden.
		-Fix: <GM> whispers will not be hidden
	v1.8 (12/3/05)
		-SlashCommands issolated all to the namespace: "/telltrack"
		SubCommands: enabled, invert, dontsavelist, autowhisperframe, hidewhispers, timestamps, whisperfirst, clearall
		-Added Limited Chinese support
		-DropDownMenu no longer requires Earth
		-Dragging will now be more snappy with a new OnDragStart technique.
	v1.81 (1/2/06)
		-Removed debug that was causing error w/o Sea
	v1.9 (3/20/06)
		-Fixed RegisterForSave bug
		-Updated TOC to 11000
	v1.91 (4/18/06)
		-Fixed ancient resizing bug that showed the wrong number of buttons on new sessions.
	v1.92 (8/22/06)
		-Added Telepathy whisper ignores
		-Updated toc to 11200
		
   ]]--

-- Variables

TellTrack_ButtonCount = 1;
TellTrack_TooltipSetId = 0;
TellTrack_Array = {};
TellTrack_ID = 0;
TellTrack_LastTell = nil;
TellTrack_ArrayMaxSize = 20;
TellTrack_ArrayOffset = 1;

TellTrack_WhisperMessages = {};
TellTrack_WhisperChatFrame = {};
TellTrack_CurrentConversation = {name="",showAll=true};

TellTrack_Cosmos_Registered = nil;
TellTrack_Khaos_Registered = nil;
TellTrack_Satellite_Registered = nil;

local SavedSendChatMessage = nil;
local SavedFCF_SelectDockFrame = nil;
local SavedChatFrame_OpenChat = nil;
local SavedFCF_Close = nil;
local SavedFCF_OpenNewWindow = nil;

SELECTED_CHAT_FRAME = DEFAULT_CHAT_FRAME;

-- executed on load, calls general set-up functions
function TellTrack_OnLoad()
	TellTrack_Register();
	TellTrack_UpdateTellTrackButtonsText();
	
	if (Sea and Sea.util and Sea.util.hook) then
		Sea.util.hook("SendChatMessage", "TellTrack_SendChatMessage", "before");
		Sea.util.hook("FCF_SelectDockFrame", "TellTrack_FCF_SelectDockFrame", "after");
		Sea.util.hook("ChatFrame_OpenChat", "TellTrack_ChatFrame_OpenChat", "replace");
		Sea.util.hook("FCF_Close", "TellTrack_FCF_Close", "before");
		Sea.util.hook("FCF_OpenNewWindow", "TellTrack_FCF_OpenNewWindow", "replace");
	else
		-- Hook the chat event handler 'before'
		if (SendChatMessage ~= SavedSendChatMessage) then
			SavedSendChatMessage = SendChatMessage;
			SendChatMessage = TellTrack_SendChatMessage;
		end
		
		-- Hook dock frame selection 'after'
		if (FCF_SelectDockFrame ~= TellTrack_FCF_SelectDockFrame) then
			SavedFCF_SelectDockFrame = FCF_SelectDockFrame;
			FCF_SelectDockFrame = TellTrack_FCF_SelectDockFrame;
		end
		
		-- Hook Open Chat to Open as whisper
		if (ChatFrame_OpenChat ~= TellTrack_ChatFrame_OpenChat) then
			SavedChatFrame_OpenChat = ChatFrame_OpenChat;
			ChatFrame_OpenChat = TellTrack_ChatFrame_OpenChat;
		end
		
		-- Hook Open Chat to Open as whisper
		if (FCF_Close ~= TellTrack_FCF_Close) then
			SavedFCF_Close = FCF_Close;
			FCF_Close = TellTrack_FCF_Close;
		end
		
		-- Hook Open Chat to Open as whisper
		if (FCF_OpenNewWindow ~= TellTrack_FCF_OpenNewWindow) then
			SavedFCF_OpenNewWindow = FCF_OpenNewWindow;
			FCF_OpenNewWindow = TellTrack_FCF_OpenNewWindow;
		end
	end
	
	TellTrack_SlashSubCommandList = {
		enabled = {func=function(msg) TellTrack_ChatCommandToggler(msg, TellTrack_Toggle_Enabled) end, help=TELLTRACK_CHAT_COMMAND_ENABLE_INFO};
		invert = {func=function(msg) TellTrack_ChatCommandToggler(msg, TellTrack_Toggle_Inverted) end, help= TELLTRACK_CHAT_COMMAND_INVERT_INFO};
		dontsavelist = {func=function(msg) TellTrack_ChatCommandToggler(msg, TellTrack_Toggle_DontSaveList) end, help= TELLTRACK_CHAT_COMMAND_DONTSAVELIST_INFO};
		autowhisperframe = {func=function(msg) TellTrack_ChatCommandToggler(msg, TellTrack_Toggle_AutoWhisperFrame) end, help= TELLTRACK_CHAT_COMMAND_AUTOWHISPERFRAME_INFO};
		hidewhispers = {func=function(msg) TellTrack_ChatCommandToggler(msg, TellTrack_Toggle_HideOtherWhispers) end, help= TELLTRACK_CHAT_COMMAND_HIDEOTHERWHISPERS_INFO};
		timestamps = {func=function(msg) TellTrack_ChatCommandToggler(msg, TellTrack_Toggle_TimeStamps) end, help=TELLTRACK_CHAT_COMMAND_TIMESTAMPS_INFO};
		whisperfirst = {func=function(msg) TellTrack_ChatCommandToggler(msg, TellTrack_Toggle_WhisperFirst) end, help=TELLTRACK_CHAT_COMMAND_WHISPERFIRST_INFO};
		clearall = {func=TellTrack_Menu_DeleteAll, help=TELLTRACK_CHAT_COMMAND_CLEARALL_INFO};
	};
	
end

function TellTrack_Register_Khaos()
	local optionSet = {
		id="TellTrack";
		text=TELLTRACK_CONFIG_HEADER;
		helptext=TELLTRACK_CONFIG_HEADER_INFO;
		difficulty=1;
		options={
			{
				id="Header";
				text=TELLTRACK_CONFIG_HEADER;
				helptext=TELLTRACK_CONFIG_HEADER_INFO;
				type=K_HEADER;
				difficulty=1;
			};
			{
				id="TellTrackEnable";
				type=K_TEXT;
				text=TELLTRACK_ENABLED;
				helptext=TELLTRACK_ENABLED_INFO;
				callback=function(state) if (state.checked) then TellTrack_Toggle_Enabled(1) else TellTrack_Toggle_Enabled(0) end end;
				feedback=function(state) if (state.checked) then return TELLTRACK_CHAT_ENABLED; else return TELLTRACK_CHAT_DISABLED; end end;
				check=true;
				--default={checked=TellTrack_Enabled};
				default={checked=true};
				disabled={checked=false};
			};
			{
				id="TellTrackInvert";
				type=K_TEXT;
				text=TELLTRACK_INVERTED;
				helptext=TELLTRACK_INVERTED_INFO;
				callback=function(state) if (state.checked) then TellTrack_Toggle_Inverted(1) else TellTrack_Toggle_Inverted(0) end end;
				feedback=function(state) if (state.checked) then return TELLTRACK_CHAT_INVERTED; else return TELLTRACK_CHAT_NORMALIZED; end end;
				check=true;
				--default={checked=TellTrack_InvertedList};
				default={checked=false};
				disabled={checked=false};
			};
			{
				id="TellTrackDontSaveList";
				type=K_TEXT;
				text=TELLTRACK_DONTSAVELIST;
				helptext=TELLTRACK_DONTSAVELIST_INFO;
				callback=function(state) if (state.checked) then TellTrack_Toggle_DontSaveList(1) else TellTrack_Toggle_DontSaveList(0) end end;
				feedback=function(state) if (state.checked) then return TELLTRACK_CHAT_DONTSAVELIST; else return TELLTRACK_CHAT_SAVELIST; end end;
				check=true;
				--default={checked=TellTrack_DontSaveList};
				default={checked=false};
				disabled={checked=false};
			};
			{
				id="TellTrackAutoWhisperFrame";
				type=K_TEXT;
				text=TELLTRACK_AUTOWHISPERFRAME;
				helptext=TELLTRACK_AUTOWHISPERFRAME_INFO;
				callback=function(state) if (state.checked) then TellTrack_Toggle_AutoWhisperFrame(1) else TellTrack_Toggle_AutoWhisperFrame(0) end end;
				feedback=function(state) if (state.checked) then return TELLTRACK_CHAT_AUTOWHISPERFRAME; else return TELLTRACK_CHAT_MANUALWHISPERFRAME; end end;
				check=true;
				--default={checked=TellTrack_AutoWhisperFrame};
				default={checked=true};
				disabled={checked=false};
			};
			{
				id="TellTrackHideOtherWhispers";
				type=K_TEXT;
				text=TELLTRACK_HIDEOTHERWHISPERS;
				helptext=TELLTRACK_HIDEOTHERWHISPERS_INFO;
				callback=function(state) if (state.checked) then TellTrack_Toggle_HideOtherWhispers(1) else TellTrack_Toggle_HideOtherWhispers(0) end end;
				feedback=function(state) if (state.checked) then return TELLTRACK_CHAT_HIDEOTHERWHISPERS; else return TELLTRACK_CHAT_SHOWOTHERWHISPERS; end end;
				check=true;
				--default={checked=TellTrack_HideOtherWhispers};
				default={checked=false};
				disabled={checked=false};
			};
			{
				id="TellTrackTimeStamps";
				type=K_TEXT;
				text=TELLTRACK_TIMESTAMPS;
				helptext=TELLTRACK_TIMESTAMPS_INFO;
				callback=function(state) if (state.checked) then TellTrack_Toggle_TimeStamps(1) else TellTrack_Toggle_TimeStamps(0) end end;
				feedback=function(state) if (state.checked) then return TELLTRACK_CHAT_TIMESTAMPS; else return TELLTRACK_CHAT_NOTIMESTAMPS; end end;
				check=true;
				--default={checked=TellTrack_TimeStamps};
				default={checked=false};
				disabled={checked=false};
			};
			{
				id="TellTrackWhisperFirst";
				type=K_TEXT;
				text=TELLTRACK_WHISPERFIRST;
				helptext=TELLTRACK_WHISPERFIRST_INFO;
				callback=function(state) if (state.checked) then TellTrack_Toggle_WhisperFirst(1) else TellTrack_Toggle_WhisperFirst(0) end end;
				feedback=function(state) if (state.checked) then return TELLTRACK_CHAT_WHISPERFIRST; else return TELLTRACK_CHAT_LOGFIRST; end end;
				check=true;
				--default={checked=TellTrack_TimeStamps};
				default={checked=false};
				disabled={checked=false};
			};
		};
	};
	Khaos.registerOptionSet(
		"chat",
		optionSet
	);
	TellTrack_Khaos_Registered = 1;
end


-- registers the mod with Cosmos
function TellTrack_Register_Cosmos()
	Cosmos_RegisterConfiguration(
		"COS_TELLTRACK",
		"SECTION",
		TELLTRACK_CONFIG_HEADER,
		TELLTRACK_CONFIG_HEADER_INFO
	);
	Cosmos_RegisterConfiguration(
		"COS_TELLTRACK_HEADER",
		"SEPARATOR",
		TELLTRACK_CONFIG_HEADER,
		TELLTRACK_CONFIG_HEADER_INFO
	);
	Cosmos_RegisterConfiguration(
		"COS_TELLTRACK_ENABLED",
		"CHECKBOX",
		TELLTRACK_ENABLED,
		TELLTRACK_ENABLED_INFO,
		TellTrack_Toggle_Enabled,
		TellTrack_Enabled
	);
	Cosmos_RegisterConfiguration(
		"COS_TELLTRACK_INVERTED",
		"CHECKBOX",
		TELLTRACK_INVERTED,
		TELLTRACK_INVERTED_INFO,
		TellTrack_Toggle_Inverted,
		TellTrack_InvertedList
	);
	Cosmos_RegisterConfiguration(
		"COS_TELLTRACK_DONTSAVELIST",
		"CHECKBOX",
		TELLTRACK_DONTSAVELIST,
		TELLTRACK_DONTSAVELIST_INFO,
		TellTrack_Toggle_DontSaveList,
		TellTrack_DontSaveList
	);
	Cosmos_RegisterConfiguration(
		"COS_TELLTRACK_AUTOWHISPERFRAME",
		"CHECKBOX",
		TELLTRACK_AUTOWHISPERFRAME,
		TELLTRACK_AUTOWHISPERFRAME_INFO,
		TellTrack_Toggle_AutoWhisperFrame,
		TellTrack_AutoWhisperFrame
	);
	Cosmos_RegisterConfiguration(
		"COS_TELLTRACK_TIMESTAMPS",
		"CHECKBOX",
		TELLTRACK_TIMESTAMPS,
		TELLTRACK_TIMESTAMPS_INFO,
		TellTrack_Toggle_TimeStamps,
		TellTrack_TimeStamps
	);
	Cosmos_RegisterConfiguration(
		"COS_TELLTRACK_WHISPERFIRST",
		"CHECKBOX",
		TELLTRACK_WHISPERFIRST,
		TELLTRACK_WHISPERFIRST_INFO,
		TellTrack_Toggle_WhisperFirst,
		TellTrack_WhisperFirst
	);
	
	TellTrack_Cosmos_Registered = 1;
end

function TellTrack_Register_Satellite()
	Satellite.registerSlashCommand(
		{
			id="TellTrack";
			commands = {"/telltrack","/ttrack"};
			onExecute = TellTrack_ChatCommandHandler;
			helpText = TELLTRACK_CHAT_COMMAND_INFO;
		}
	);
	Satellite.registerSlashCommand(
		{
			id="Retell";
			commands = {"/re", "/retell"};
			onExecute = TellTrack_WhisperToPreviousTarget;
			helpText = BINDING_NAME_TELLTRACK_RETELL;
		}
	);
	TellTrack_Satellite_Registered = 1;
end

-- registers the mod with the system, integrating it with slash commands and "master" AddOns
function TellTrack_Register()
	if (Khaos) then
		if (not TellTrack_Khaos_Registered) then
			TellTrack_Register_Khaos();
		end
	elseif (Cosmos_RegisterConfiguration) then
		if (not TellTrack_Cosmos_Registered) then
			TellTrack_Register_Cosmos();
		end
	end
		

	if (Satellite) then
		if (not TellTrack_Satellite_Registered) then
			TellTrack_Register_Satellite();
		end
	else
		SlashCmdList["TELLTRACK"] = TellTrack_ChatCommandHandler;
		SLASH_TELLTRACK1 = "/telltrack";
		SLASH_TELLTRACK2 = "/ttrack";
		SlashCmdList["TELLTRACKRETELL"] = TellTrack_WhisperToPreviousTarget;
		SLASH_TELLTRACKRETELL1 = "/re";
		SLASH_TELLTRACKRETELL2 = "/retell";
	end
        
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	if ( Eclipse ) then
		--Set the ui section to be TellTrack if we have Khaos
		local uisec = "TellTrack";
		--If we don't have Khaos, then use the Cosmos section
		if (not Khaos) then
			uisec = "COS_TELLTRACK";
		end
		--Register with VisibilityOptions
		Eclipse.registerForVisibility( {
			name = "TellTrackFrame";	--The name of the config, in this case also the name of the frame
			nototal = true;	--This addon has an option to hide the frame already, so we don't need to register with total
			uisec = uisec;	--This puts the options, in the TellTrack section, it is not neccisary but helps to keep VisOpts section cleaner
			uiname = TELLTRACK_CONFIG_HEADER;	--This is the base name of this reg to display in the description and ui
			slashcom = { "telltrack", "tt" };	--These are the slash commands
		}	);
		Eclipse.registerForVisibility( {
			name = "TellTrackBorder";	--The name of the config
			frames = {"TellTrackFrameArrowUpButton", "TellTrackFrameArrowDownButton", "TellTrackFrameBackground"};
			uisec = uisec;	--This puts the options, in the TellTrack section, it is not neccisary but helps to keep VisOpts section cleaner
			uiname = TELLTRACK_BORDER_CONFIG_HEADER;	--This is the base name of this reg to display in the description and ui
			slashcom = { "telltrackborder", "ttborder" };	--These are the slash commands
			state = { show = true };	--Because the frame is not visible when registered, we need to let VisOpts know it should be visible
		}	);
	else
		if ( TransNUI_RegisterUI ) then
			TransNUI_RegisterUI("TellTrackFrame", { "telltrack" }, TELLTRACK_CONFIG_TRANSNUI, TELLTRACK_CONFIG_TRANSNUI_INFO, 0);
		end
		if ( PopNUI_RegisterUI ) then
			PopNUI_RegisterUI("TellTrackFrame", { "telltrack" }, {"TellTrack_Enabled", 1, true}, TELLTRACK_CONFIG_POPNUI, TELLTRACK_CONFIG_POPNUI_INFO);
		end
	end
end

function TellTrack_ChatCommandToggler(msg, func)
	if msg == nil then
		msg = "";
	end
	msg = string.lower(msg);
	
	-- Toggle appropriately
	if ( (string.find(msg, 'on')) or ((string.find(msg, '1')) and (not string.find(msg, '-1')) ) ) then
		func(1);
	else
		if ( (string.find(msg, 'off')) or (string.find(msg, '0')) ) then
			func(0);
		else
			func(-1);
		end
	end
end

--Master Chat Command Handler
function TellTrack_ChatCommandHandler(msg)
	local _, _, subcom, toggle = string.find(msg, "[ ]*(%w+)[ ]*(.*)");
	if (subcom) then
		subcom = strlower(subcom);
		--Sea.io.print("TellTrack - ", subcom, " ", toggle);
	else
		TellTrack_ChatCommand_Help();
		return;
	end
	if (TellTrack_SlashSubCommandList[subcom]) then
		TellTrack_SlashSubCommandList[subcom].func(toggle);
	else
		TellTrack_ChatCommand_Help();
	end
end

function TellTrack_ChatCommand_Help()
	TellTrack_Print (TELLTRACK_CHAT_QUESTION_MARK_INFO,1.0,1.0,0);
	TellTrack_Print (TELLTRACK_CHAT_USE_INFO,1.0,1.0,0);
	for subcom, info in TellTrack_SlashSubCommandList do
		TellTrack_Print(subcom.." - ".. info.help,1.0,1.0,0);
	end
end

-- Does things with the hooked function
function TellTrack_SendChatMessage(text, type, language, target)
	-- saves target for 'Retell' regardless of TellTrack_Enabled
	target = TellTrack_Capitalize(target);
	if ( type == "WHISPER" ) then
		TellTrack_LastTell = target;
	end
	if ( TellTrack_Enabled == 1 ) then
		if ( type == "WHISPER" ) then 
			-- prevent data message transfers from being used
			if ( strsub(text, 1, 1) ~= "<" ) then
				TellTrack_HandleMessageSentOrRecieved(target, false);
			end
		end
	end
	if (SavedSendChatMessage) then
		SavedSendChatMessage(text, type, language, target);
	end
end

function TellTrack_Capitalize(text)
	if (not text) then
		return;
	end
	if( string.find(text, "^[a-zA-Z].*") ) then
		text = strupper(strsub(text,1,1))..strlower(strsub(text,2));
	else
		text = strupper(strsub(text,1,2))..strlower(strsub(text,3));
	end
	return text;
end

function TellTrack_startsWith(s, prefix)
	local isAtBeginning = false;
	if (type(s) == "string") and (type(prefix) == "string") then
		if (s == prefix) then
			isAtBeginning = true;
		elseif ( string.len(s) > string.len(prefix) ) then
			if( string.sub(s, 1, string.len(prefix)) == prefix ) then
				isAtBeginning = true;
			end
		end
	end
	return isAtBeginning;
end


-- Handles events
function TellTrack_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		local value = TellTrack_Enabled;
		if ( TellTrack_Cosmos_Registered ) then
			value = getglobal("COS_TELLTRACK_ENABLED_X");
			TellTrack_InvertedList = getglobal("COS_TELLTRACK_INVERTED_X");
		end
		if (value == nil) then
			-- defaults to off
			value = 0;
		end
		if (TellTrack_InvertedList == nil) then
			-- defaults to off
			TellTrack_InvertedList = 0;
		end
		if (not TellTrack_WhisperChatFrame[GetRealmName()]) then
			TellTrack_WhisperChatFrame[GetRealmName()] = {};
		end
		if (not TellTrack_Khaos_Registered) then
			TellTrack_Toggle_Enabled(value);
		end
		if ( TellTrack_DontSaveList == 1 ) then
			TellTrack_SavedList = {};
		end
		TellTrack_LoadNames();
		--Initialize Menu
		UIDropDownMenu_Initialize(TellTrackDropDown, TellTrackTextButton_InitializeMenuArray, "MENU");
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		TellTrack_ModifyButtonCount(TellTrackFrame:GetHeight());
	elseif ( event == "CHAT_MSG_WHISPER" ) or ( event == "CHAT_MSG_WHISPER_INFORM" ) then
		--For some reason TellTrack_HookAllAddMessages doesn't work on VARIABLES_LOADED...
		TellTrack_HookAllAddMessages();
		
		--Special Hidden Whisper Ignores
		if ( IsAddOnLoaded("Sky") ) and (string.len(arg1) > 4) and (string.sub(arg1,1,4) == "<Sky") then
			--Hide Sky messages
			return;
		elseif ( IsAddOnLoaded("Guilded") ) and (string.len(arg1) > 2) and (string.sub(arg1,1,2) == "<G") and ( (string.len(arg1) ~= 4) or (string.sub(arg1,1,4) ~= "<GM>") ) then
			--Hide Guilded messages
			return;
		elseif ( IsAddOnLoaded("GuildAds") ) and (string.len(arg1) > 3) and (string.sub(arg1,1,3) == "<GA") then
			--Hide GuildAds messages
			return;
		elseif ( IsAddOnLoaded("Telepathy") ) and (string.len(arg1) > 3) and (string.sub(arg1,1,3) == "<T>") then
			--Hide Telepathy messages
			return;
		end 
		
		local type = string.sub(event,10);
		if ( event == "CHAT_MSG_WHISPER" ) then
			TellTrack_HandleMessageSentOrRecieved(arg2, true, arg1);
		end
		local time;
		if (Clock_GetTimeText) then
			time = Clock_GetTimeText();
		else
			local hour, minute = GetGameTime();
			time = {h=hour,m=minute};
		end
		local message = gsub(arg1, "%%", "%%%%");
		table.insert(TellTrack_WhisperMessages, {type=type,name=arg2,msg=message,time=time, date=date()});
	end
end

function TellTrack_AddWhisper(chatFrame, text, name, type, time)
	local info = ChatTypeInfo[type];
	chatFrame:AddMessage(format(TEXT(getglobal("CHAT_"..type.."_GET"))..text, "|Hplayer:"..name.."|h".."["..name.."]".."|h"), info.r, info.g, info.b, info.id, time);
end

function TellTrack_GetTimeStamp(time)
	local separator = ">";
	if (ChatTimeStamps_TimeStamp) and (not ChatTimeStamps_SEPARATOR) then
		separator = "";
	end
	if (not time) then
		if (ChatTimeStamps_LOCALTIME) then
			time = date();
		elseif (Clock_GetTimeText) then
			time = Clock_GetTimeText();
		else
			local hour, minute = GetGameTime();
			time = {h=hour,m=minute};
		end
	end
	if (type(time) == "string") then
		return time..separator.." ";
	end
	
	if (time.h < 10) then 
		time.h = "0"..time.h; 
	end

	if (time.m < 10) then 
		time.m = "0"..time.m; 
	end
	return time.h..":"..time.m..separator.." ";
end

function TellTrack_ClearChatFrame(chatFrame)
	chatFrame:Clear();
end

function TellTrack_ShowConversationWith(name, showAll)
	if (not TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
		if (TellTrack_AutoWhisperFrame) and (FCF_GetNumActiveChatFrames() < NUM_CHAT_WINDOWS ) then
			TellTrack_CreateWhisperChatFrame();
		else
			return;
		end
	end
	local WhisperFrame = getglobal(TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]);
	TellTrack_CurrentConversation = {name=name,showAll=true};
	TellTrack_ClearChatFrame(WhisperFrame);
	TellTrack_CurrentConversation.showAll = showAll;
	local found = 0;
	--Display only the valid whispers.
	for i, data in TellTrack_WhisperMessages do
		if (showAll) or (data.name == name) then
			if (ChatTimeStamps_LOCALTIME) then
				TellTrack_AddWhisper(WhisperFrame, data.msg, data.name, data.type, data.date);
			else
				TellTrack_AddWhisper(WhisperFrame, data.msg, data.name, data.type, data.time);
			end
			found = found + 1;
		end
	end
	
	if (found == 0) then
		TellTrack_CurrentConversation.showAll = true;
		local timeStamp = TellTrack_TimeStamps;
		TellTrack_TimeStamps = 0;
		WhisperFrame:AddMessage(format(TELLTRACK_NO_CURRENT_CONVERSATION, name));
		TellTrack_TimeStamps = timeStamp;
		FCF_SetWindowName(WhisperFrame, TELLTRACK_WHISPER_FRAME_TITLE);
	else
		FCF_SetWindowName(WhisperFrame, name);
	end
	
	-- Show the frame and tab
	FCF_SelectDockFrame(WhisperFrame);
end

function TellTrack_ShowAllWhispers()
	TellTrack_ShowConversationWith(TellTrack_CurrentConversation.name, true);
end

function TellTrack_WhisperChatFrame_AddMessage(this, text, r, g, b, id, time)
	if (this:GetName() ~= TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
		-- incorrect whisper frame
		SavedWhisperChatFrame_AddMessages[this:GetName()](this, text, r, g, b, id);
		return;
	end
	local stamps = ChatTimeStamps_ENABLED;
	ChatTimeStamps_ENABLED = 0;
	if (strlen(text) < 5) then
		SavedWhisperChatFrame_AddMessages[this:GetName()](this, text, r, g, b, id);
		ChatTimeStamps_ENABLED = stamps;
		return;
	end
	local timedText = text;
	if (TellTrack_TimeStamps == 1) then
		timedText = TellTrack_GetTimeStamp(time)..text;
	end
	if (not TellTrack_CurrentConversation) or (TellTrack_CurrentConversation.showAll) then
		SavedWhisperChatFrame_AddMessages[this:GetName()](this, timedText, r, g, b, id);
		ChatTimeStamps_ENABLED = stamps;
		return;
	end
	local name = TellTrack_CurrentConversation.name;
	if  (TellTrack_startsWith(text, format(TEXT(getglobal("CHAT_WHISPER_GET")), "|Hplayer:"..name.."|h".."["..name.."]".."|h"))) or
		(TellTrack_startsWith(text, format(TEXT(getglobal("CHAT_WHISPER_INFORM_GET")), "|Hplayer:"..name.."|h".."["..name.."]".."|h"))) then
		SavedWhisperChatFrame_AddMessages[this:GetName()](this, timedText, r, g, b, id);
		ChatTimeStamps_ENABLED = stamps;
		return;
	end
end

function TellTrack_RedrawWhisperFrame()
	if ( not GetRealmName() or not UnitName("player") ) then
		return;
	end;
	if (not TellTrack_WhisperChatFrame[GetRealmName()] ) then
		TellTrack_WhisperChatFrame[GetRealmName()] = {};
	end
	if (not TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
		return;
	end
	local WhisperFrame = getglobal(TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]);
	local scrollOffset = WhisperFrame:GetCurrentScroll();
	TellTrack_ClearChatFrame(WhisperFrame);
	for i, data in TellTrack_WhisperMessages do
		if (TellTrack_CurrentConversation.showAll) or (data.name == TellTrack_CurrentConversation.name) then
			TellTrack_AddWhisper(WhisperFrame, data.msg, data.name, data.type, data.time);
		end
	end
	WhisperFrame:SetScrollFromBottom(scrollOffset)
end

function TellTrack_HookAllAddMessages()
	if (SavedWhisperChatFrame_AddMessages) then
		--Sea.io.print("Failed to set up TellTrack_WhisperChatFrame_AddMessage hooks.");
		return;
	end
	SavedWhisperChatFrame_AddMessages = {};
	local frameName = ""
	for i=1, NUM_CHAT_WINDOWS do
		frameName = "ChatFrame"..i;
		if (getglobal(frameName).AddMessage ~= TellTrack_WhisperChatFrame_AddMessage) then
			SavedWhisperChatFrame_AddMessages[frameName] = getglobal(frameName).AddMessage;
			getglobal(frameName).AddMessage = TellTrack_WhisperChatFrame_AddMessage;
		end
	end
	--Sea.io.print("Set up TellTrack_WhisperChatFrame_AddMessage hooks.");
end

function TellTrack_ChatFrame_OpenChat(text, chatFrame)
	if (text == "") and (SELECTED_CHAT_FRAME:GetName() == TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) and (TellTrack_CurrentConversation) and (TellTrack_CurrentConversation.name) and (TellTrack_CurrentConversation.name ~= "") then
		TellTrack_InitiateWhisperToTarget(TellTrack_CurrentConversation.name);
	else
		if (SavedChatFrame_OpenChat) then
			SavedChatFrame_OpenChat(text, chatFrame);
		else
			return true;
		end
	end
end

function TellTrack_FCF_OpenNewWindow(name)
	if (TellTrack_HideOtherWhispers == 1) then
		local temp, shown;
		local newChatFrame = nil;
		for i=1, NUM_CHAT_WINDOWS do
			temp, temp, temp, temp, temp, temp, shown, temp = GetChatWindowInfo(i);
			chatFrame = getglobal("ChatFrame"..i);
			if ( (not shown and not chatFrame.isDocked) or (count == NUM_CHAT_WINDOWS) ) then
				newChatFrame = chatFrame;
				break;
			end
		end
		if (SavedFCF_OpenNewWindow) then
			SavedFCF_OpenNewWindow(name);
		else
			Sea.util.Hooks.FCF_OpenNewWindow.orig(name);
		end
		ChatFrame_RemoveMessageGroup(newChatFrame, "WHISPER");
	else
		if (SavedFCF_OpenNewWindow) then
			SavedFCF_OpenNewWindow(name);
		else
			return true;
		end
	end
end

function TellTrack_FCF_Close(chatFrame)
	if ( not chatFrame ) then
		chatFrame = FCF_GetCurrentChatFrame();
	end
	if (chatFrame:GetName() == TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
		TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")] = nil;
	end
	if (SavedFCF_Close) then
		SavedFCF_Close(chatFrame);
	else
		return true, chatFrame;
	end
end

function TellTrack_FCF_SelectDockFrame(frame)
	if (SavedFCF_SelectDockFrame ) then
		SavedFCF_SelectDockFrame(frame);
	end
	if (frame:GetName() == TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")] ) then
		if (TellTrack_CurrentConversation.showAll) then
			for i = 1, TellTrack_ArrayMaxSize do
				if (TellTrack_Array[i]) then
					TellTrack_Array[i].unread = 0;
				end
			end
		elseif (TellTrack_CurrentConversation.name ~= "") then
			for i = 1, TellTrack_ArrayMaxSize do
				if (TellTrack_Array[i]) and (TellTrack_Array[i].name == TellTrack_CurrentConversation.name) then
					TellTrack_Array[i].unread = 0;
				end
			end
		end
		TellTrack_UpdateTellTrackButtonsText();
	end
	SELECTED_CHAT_FRAME = frame;
end

function TellTrack_CreateWhisperChatFrame(name)
	if (TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
		--check for not valid?
		return;
	end
	local temp, shown;
	local count = 1;
	local chatFrame;
	
	for i=1, NUM_CHAT_WINDOWS do
		temp, temp, temp, temp, temp, temp, shown, temp = GetChatWindowInfo(i);
		chatFrame = getglobal("ChatFrame"..i);
		chatTab = getglobal("ChatFrame"..i.."Tab");
		if ( (not shown and not chatFrame.isDocked) or (count == NUM_CHAT_WINDOWS) ) then
			if (type(name) ~= "string" or name == "") then
				name = "TellTrack";
			end
			
			-- initialize the frame
			FCF_SetWindowName(chatFrame, name);
			FCF_SetWindowColor(chatFrame, DEFAULT_CHATFRAME_COLOR.r, DEFAULT_CHATFRAME_COLOR.g, DEFAULT_CHATFRAME_COLOR.b);
			FCF_SetWindowAlpha(chatFrame, DEFAULT_CHATFRAME_ALPHA);
			SetChatWindowLocked(i, nil);

			-- Listen to the standard messages
			ChatFrame_RemoveAllMessageGroups(chatFrame);
			ChatFrame_AddMessageGroup(chatFrame, "WHISPER");

			-- Show the frame and tab
			chatFrame:Show();
			chatTab:Show();
			SetChatWindowShown(i, 1);
			
			-- Dock the frame by default
			FCF_DockFrame(chatFrame);
			
			TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")] = chatFrame:GetName();
			break;
		end
		count = count + 1;
	end
end

function TellTrack_HideWhispersInOtherFrames()
	if (not TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
		--check for not valid?
		return;
	end
	local chatFrameName;
	for i=1, NUM_CHAT_WINDOWS do
		chatFrameName = "ChatFrame"..i;
		if (chatFrameName ~= TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
			ChatFrame_RemoveMessageGroup(getglobal(chatFrameName), "WHISPER");
		end
	end
end

-- Toggles the enabled/disabled state of an option and returns the new state
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function TellTrack_Generic_Toggle(toggle, variableName, CVarName, enableMessage, disableMessage, CosmosVarName, KhaosVarName)
	local oldvalue = getglobal(variableName);
	local newvalue = toggle;
	if ( ( toggle ~= 1 ) and ( toggle ~= 0 ) ) then
		if (oldvalue == 1) then
			newvalue = 0;
		elseif ( oldvalue == 0 ) then
			newvalue = 1;
		else
			newvalue = 0;
		end
	end
	setglobal(variableName, newvalue);
	setglobal(CVarName, newvalue);
	if ( ( newvalue ~= oldvalue ) and ( not TellTrack_Cosmos_Registered ) and ( not TellTrack_Khaos_Registered ) ) then
		if ( newvalue == 1 ) then
			TellTrack_Print(TEXT(getglobal(enableMessage)));
		else
			TellTrack_Print(TEXT(getglobal(disableMessage)));
		end
	end
	-- TellTrack_Register_Cosmos();
	if (TellTrack_Khaos_Registered) then
		if (Khaos.getSetKey("TellTrack", KhaosVarName)) then
			Khaos.setSetKeyParameter("TellTrack",KhaosVarName, "checked", (newvalue == 1));
		end
	elseif (TellTrack_Cosmos_Registered) then
		if ( CosmosVarName ) then
			Cosmos_UpdateValue(CosmosVarName, CSM_CHECKONOFF, newvalue);
			Cosmos_SetCVar(CosmosVarName, newvalue);
		end
	else
		-- No more RegisterForSave
	end
	return newvalue;
end

-- Toggles the enabled/disabled state of the TellTrack
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function TellTrack_Toggle_Enabled(toggle)
	local oldvalue = TellTrack_Enabled;
	local newvalue = TellTrack_Generic_Toggle(toggle, "TellTrack_Enabled", "COS_TELLTRACK_ENABLED", "TELLTRACK_CHAT_ENABLED", "TELLTRACK_CHAT_DISABLED", "COS_TELLTRACK_ENABLED", "TellTrackEnable");
	if ( TellTrack_Enabled == 0 ) then
		TellTrackFrame:Hide();
		if (TellTrackTooltip) then
			TellTrackTooltip:Hide();
		end
	else
		TellTrackFrame:Show();
	end
end

-- Toggles the inverted/normalized state of the TellTrack list
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function TellTrack_Toggle_Inverted(toggle)
	local oldvalue = TellTrack_InvertedList;
	local newvalue = TellTrack_Generic_Toggle(toggle, "TellTrack_InvertedList", "COS_TELLTRACK_INVERTED", "TELLTRACK_CHAT_INVERTED", "TELLTRACK_CHAT_NORMALIZED", "COS_TELLTRACK_INVERTED", "TellTrackInvert");
	--only change (reset offset) telltrack if TellTrack_InvertedList was changed
	if ( oldvalue ~= newvalue ) then
		if ( newvalue == 1 ) then
			TellTrack_ChangeArrayOffset(TellTrack_ArrayMaxSize);
		else
			TellTrack_ChangeArrayOffset(1);
		end
		TellTrack_UpdateTellTrackButtonsText();
	end
end

-- Toggles the saved state of the TellTrack list accross sessions
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function TellTrack_Toggle_DontSaveList(toggle)
	local oldvalue = TellTrack_DontSaveList;
	local newvalue = TellTrack_Generic_Toggle(toggle, "TellTrack_DontSaveList", "COS_TELLTRACK_DONTSAVELIST", "TELLTRACK_CHAT_DONTSAVELIST", "TELLTRACK_CHAT_SAVELIST", "COS_TELLTRACK_DONTSAVELIST", "TellTrackDontSaveList");
end

-- Toggles the auto creation of TellTrack whisper frame
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function TellTrack_Toggle_AutoWhisperFrame(toggle)
	local oldvalue = TellTrack_AutoWhisperFrame;
	local newvalue = TellTrack_Generic_Toggle(toggle, "TellTrack_AutoWhisperFrame", "COS_TELLTRACK_AUTOWHISPERFRAME", "TELLTRACK_CHAT_AUTOWHISPERFRAME", "TELLTRACK_CHAT_MANUALWHISPERFRAME", "COS_TELLTRACK_AUTOWHISPERFRAME", "TellTrackAutoWhisperFrame");
end

-- Toggles Hiding Whispers outside the whisper frame
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function TellTrack_Toggle_HideOtherWhispers(toggle)
	local oldvalue = TellTrack_HideOtherWhispers;
	local newvalue = TellTrack_Generic_Toggle(toggle, "TellTrack_HideOtherWhispers", "COS_TELLTRACK_HIDEOTHERWHISPERS", "TELLTRACK_CHAT_HIDEOTHERWHISPERS", "TELLTRACK_CHAT_SHOWOTHERWHISPERS", "COS_TELLTRACK_HIDEOTHERWHISPERS", "TellTrackHideOtherWhispers");
	if ( newvalue == 1 ) then
		TellTrack_HideWhispersInOtherFrames();
	end
end

-- Toggles Whisper chat stamping
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function TellTrack_Toggle_TimeStamps(toggle)
	local oldvalue = TellTrack_TimeStamps;
	local newvalue = TellTrack_Generic_Toggle(toggle, "TellTrack_TimeStamps", "COS_TELLTRACK_TIMESTAMPS", "TELLTRACK_CHAT_TIMESTAMPS", "TELLTRACK_CHAT_NOTIMESTAMPS", "COS_TELLTRACK_TIMESTAMPS", "TellTrackTimeStamps");
	TellTrack_RedrawWhisperFrame();
end

-- Toggles the whisper first option
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function TellTrack_Toggle_WhisperFirst(toggle)
	local oldvalue = TellTrack_WhisperFirst;
	local newvalue = TellTrack_Generic_Toggle(toggle, "TellTrack_WhisperFirst", "COS_TELLTRACK_WHISPERFIRST", "TELLTRACK_CHAT_WHISPERFIRST", "TELLTRACK_CHAT_LOGFIRST", "COS_TELLTRACK_WHISPERFIRST", "TellTrackWhisperFirst");
end

-- Prints out text to a chat box.
function TellTrack_Print(msg,r,g,b,frame,id,unknown4th)
	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end
				
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if ( frame ) then 
		frame:AddMessage(msg,r,g,b,id,unknown4th);
	else
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b,id,unknown4th);
		end
	end
end

function TellTrack_ArrowButton_OnLoad(frame)
	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

function TellTrack_ArrowUpButton_OnClick(button)
	local id = this:GetID();
	if ( not id ) then
		return
	end
	if ( button == "RightButton" ) then
		TellTrack_ChangeArrayOffset(1);
	elseif ( button == "LeftButton" ) then
		TellTrack_PageUp();
	end
end

function TellTrack_ArrowDownButton_OnClick(button)
	local id = this:GetID();
	if ( not id ) then
		return;
	end
	if ( button == "RightButton" ) then
		TellTrack_ChangeArrayOffset(TellTrack_ArrayMaxSize);
	elseif ( button == "LeftButton" ) then
		TellTrack_PageDown();
	end
end

function TellTrack_QButton_OnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

function TellTrack_QButton_OnClick(button)
	local id = this:GetID();
	if ( not id ) then
		return
	end
	TellTrack_ChatCommand_Help();
	--TellTrack_Print(TELLTRACK_CHAT_QUESTION_MARK_INFO,1.0,1.0,0);
end

function TellTrackTextButton_OnEnter()
	local id = this:GetID();
	if ( id ) then
		TellTrackTooltip:SetOwner(TellTrackFrame, "ANCHOR_TOPLEFT");
		TellTrackSetTooltip(id);
	end
end

function TellTrackTextButton_OnLeave()
	if ( TellTrackTooltip:IsOwned(TellTrackFrame) ) then
		TellTrackTooltip:Hide();
	end
end

function TellTrackTextButton_OnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

function TellTrack_InitiateWhisperByID(id)
	local name = TellTrackGetName(id);
	TellTrack_InitiateWhisperToTarget(name);
end

-- 1/20/05 'Retell' added by AnduinLothar
function TellTrack_InitiateWhisperToPreviousTarget()
	if ( not TellTrack_LastTell ) then
		return;
	end
	TellTrack_InitiateWhisperToTarget(TellTrack_LastTell);
end

function TellTrack_WhisperToPreviousTarget(msg)
	if ( not TellTrack_LastTell ) then
		return;
	end
	SendChatMessage(msg, "WHISPER", this.language, TellTrack_LastTell);
end

function TellTrack_InitiateWhisperToTarget(name)
	if ( not name ) then
		return;
	end
	local chatFrame = DEFAULT_CHAT_FRAME;
	chatFrame.editBox.chatType = "WHISPER";
	chatFrame.editBox.tellTarget = name;
	ChatEdit_UpdateHeader(chatFrame.editBox);
	if ( not chatFrame.editBox:IsVisible() ) then
		if (SavedChatFrame_OpenChat) then
			SavedChatFrame_OpenChat("", chatFrame);
		else
			Sea.util.Hooks.ChatFrame_OpenChat.orig("", chatFrame);
		end
	end
end

function TellTrack_Menu_Whisper()
	TellTrack_InitiateWhisperByID(TellTrack_ID);
end

function TellTrack_Menu_Show_Conversation()
	TellTrack_ShowConversationWith(TellTrackGetName(TellTrack_ID), false);
end

function TellTrack_Menu_Who()
	local name = TellTrackGetName(TellTrack_ID);
	SendWho("n-\""..name.."\"");
end

function TellTrack_Menu_GroupeInvite()
	local name = TellTrackGetName(TellTrack_ID);
	InviteByName(name);
end

function TellTrack_Menu_AddToFriend()
	local name = TellTrackGetName(TellTrack_ID);
	AddFriend(name);
end

function TellTrack_Menu_Delete()
	TellTrack_EraseByID(TellTrack_ID);
end

-- Function by AnduinLothar used in right click menu

function TellTrack_Menu_DeleteAll()
	--Print("TT: Reseting Tell List");
	TellTrack_Array = {};
	--Print("TT: Updating Tell Track Button");
	TellTrack_UpdateTellTrackButtonsText();
	-- saves the names to the list
	TellTrack_SaveNames();
end

-- Modified by AnduinLothar to add "Delete All", and "Invert List"

function TellTrackTextButton_InitializeMenuArray()
	local info = { }
	table.insert(info, { text = "   "..BINDING_HEADER_TELLTRACKHEADER, isTitle = 1 });
	table.insert(info, { text = TELLTRACK_WHISPER, func = TellTrack_Menu_Whisper });
	table.insert(info, { text = TELLTRACK_SHOW_CONVERSATION, func = TellTrack_Menu_Show_Conversation });
	table.insert(info, { text = TELLTRACK_WHO, func = TellTrack_Menu_Who });
	table.insert(info, { text = TELLTRACK_GRPINV, func = TellTrack_Menu_GroupeInvite });
	table.insert(info, { text = TELLTRACK_ADDFRIEND, func = TellTrack_Menu_AddToFriend });
	table.insert(info, { text = TELLTRACK_DELETE, func = TellTrack_Menu_Delete });
	table.insert(info, { text = "|cFFCCCCCC--------------|r", disabled = 1, notClickable = 1 });
	table.insert(info, { text = TELLTRACK_DELETE_ALL, func = TellTrack_Menu_DeleteAll });
	table.insert(info, { text = TELLTRACK_INVERT, func = TellTrack_Toggle_Inverted });
	table.insert(info, { text = TELLTRACK_SHOW_ALL_WHISPERS, func = TellTrack_ShowAllWhispers });
	table.insert(info, { text = TELLTRACK_CREATE_CHATFRAME, func = TellTrack_CreateWhisperChatFrame });
	table.insert(info, { text = "|cFFCCCCCC--------------|r", disabled = 1, notClickable = 1 });
	table.insert(info, { text = TELLTRACK_CANCEL, func = function () end });
	for index, menuLine in info do
		UIDropDownMenu_AddButton(menuLine);
	end
end

function TellTrackTextButton_GetMenuLevels(menu)
	if ( not menu ) then
		return 0;
	end
	local menuLevels = 1;
	for i = 1, getn(menu) do
		if ( menu[i][1] ) then
			menuLevels = menuLevels + TellTrackTextButton_GetMenuLevels(menu[i]);
			break;
		end
	end
	return menuLevels;
end

function TellTrackTextButton_ShowMenu()
	ToggleDropDownMenu(1, nil, TellTrackDropDown, "cursor", 0, 0);
	return true;
end

function TellTrackTextButton_OnClick(button)
	local id = this:GetID();
	if ( not id ) then
		return;
	end
	if ( TellTrack_Array[TellTrack_GetArrayId(id)] == nil ) then
		return;
	end
	TellTrack_ID = id;
	if ( button == "RightButton" ) then
		if ( not TellTrackTextButton_ShowMenu() ) then
			TellTrack_EraseByID(id);
		end
	elseif ( button == "LeftButton" ) then
		if (IsShiftKeyDown()) then
			TellTrack_Menu_Who();
		elseif (IsAltKeyDown()) then
			TellTrack_Menu_GroupeInvite();
		elseif (IsControlKeyDown()) then
			TellTrack_Menu_AddToFriend();
		else
			local name = TellTrackGetName(id);
			if (TellTrack_WhisperFirst == 1) then
				if (SELECTED_DOCK_FRAME.editBox:IsVisible()) and (SELECTED_DOCK_FRAME.editBox.chatType == "WHISPER") and (SELECTED_DOCK_FRAME.editBox. tellTarget == name) then
					TellTrack_ShowConversationWith(name, false);
				else
					TellTrack_InitiateWhisperToTarget(name);
				end
			else
				if (SELECTED_DOCK_FRAME == getglobal(TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")])) and (TellTrack_CurrentConversation.name == name) then
					TellTrack_InitiateWhisperToTarget(name);
					--TellTrack_InitiateWhisperByID(id);
				else
					TellTrack_ShowConversationWith(name, false);
				end
			end
		end
	end
end

function TellTrack_GetArrayId(id)
	local newID
	if ( TellTrack_InvertedList == 1 ) then
		newID = TellTrack_ArrayMaxSize - (id + TellTrack_ArrayOffset) + 2;
	else
		newID = (id + TellTrack_ArrayOffset) - 1;
	end
	return newID;
end

function TellTrack_EraseByID(id)
	if ( id ) then
		id = TellTrack_GetArrayId(id);
		if ( TellTrack_Array ) and ( TellTrack_Array[id] ) then
			if ( ( TellTrackTooltip:IsVisible() ) and ( TellTrack_TooltipSetId == id ) ) then
				TellTrackTooltip:Hide();
			end
			TellTrack_Array[id] = nil;
		end
		TellTrack_CompressList();
		TellTrack_UpdateTellTrackButtonsText();
	end
end

function TellTrackGetName(id)
	if ( id ) then
		id = TellTrack_GetArrayId(id);
		if ( ( TellTrack_Array ) and ( TellTrack_Array[id] ) and ( TellTrack_Array[id].name ) ) then
			return TellTrack_Array[id].name;
		end
	end
	return nil;
end

function TellTrackSetTooltip(id)
	local name = TellTrackGetName(id);
	if ( name ) then
		TellTrackTooltip:SetText(name);
		TellTrack_TooltipSetId = id;
	end
end

-- Yet another function from George Warner, modified a bit to fit my own nefarious purposes. 
-- It can now accept r, g and b specifications, too (leaving out a), as well as handle 255 255 255
-- Source : http://www.cosmosui.org/cgi-bin/bugzilla/show_bug.cgi?id=159
function TellTrack_GetColorFormatString(a, r, g, b)
	local percent = false;
	if ( ( ( not b ) or ( b <= 1 ) ) and ( a <= 1 ) and ( r <= 1 ) and ( g <= 1) ) then percent = true; end
	if ( ( not b ) and ( a ) and ( r ) and ( g ) ) then b = g; g = r; r = a; if ( percent ) then a = 1; else a = 255; end end
	if ( percent ) then a = a * 255; r = r * 255; g = g * 255; b = b * 255; end
	a = TellTrack_GetByteValue(a); r = TellTrack_GetByteValue(r); g = TellTrack_GetByteValue(g); b = TellTrack_GetByteValue(b);
	
	--return format("[c%02X%02X%02X%02X%%s]r", a, r, g, b);
	return format("|c%02X%02X%02X%02X%%s|r", a, r, g, b);
end

function TellTrack_UpdateTellTrackButtonsText()
	local lastSentToNameFormatStr = TellTrack_GetColorFormatString(0.2, 1.0, 0.2);
	local lastRecievedFromNameFormatStr = TellTrack_GetColorFormatString(1.0, 0.2, 0.2);
	local noNameFormatStr = TellTrack_GetColorFormatString(0.4, 0.4, 0.4);
	local id = 0;
	for i = 1, TellTrack_ButtonCount do
		local buttonText = getglobal("TellTrack"..i.."Text");
		local formatStr, valueStr;
		id = TellTrack_GetArrayId(i);
		if ( ( TellTrack_Array[id] ) and ( TellTrack_Array[id].name ) ) then
			if( TellTrack_Array[id].sentTo ) then
				formatStr = lastSentToNameFormatStr;
			else
				formatStr = lastRecievedFromNameFormatStr;
			end
			valueStr = TellTrack_Array[id].name;
			if (TellTrack_Array[id].unread) and (TellTrack_Array[id].unread > 0) then
				valueStr = "("..TellTrack_Array[id].unread..") "..valueStr;
			end
		else
			formatStr = noNameFormatStr;
			valueStr = "Empty";
		end
		if ( buttonText ) then
			buttonText:SetText(format(formatStr, valueStr));
			buttonText:Show();
		end
	end
end

--[[ The following function was edited by AnduinLothar (1/15/05)
		to add the following features:

	 The last person whispered is automaticly moved to the bottom
	of the list and everytime you whisper it autoscrolls to the 
	bottom of the list.  Also if the list is full the top name is
	deleted and the new name is appended to the bottom.
        
        1/17/05
	Added recieved/sent boolean for color on button reload.
	
]]--
function TellTrack_HandleMessageSentOrRecieved(target, recieved, msg)
	local tempName = strlower(target);
	local firstEmptySlotIndex = nil;
	local previousNameInstance = nil;
	for i = 1, TellTrack_ArrayMaxSize do
		if ( ( not firstEmptySlotIndex ) and ( not TellTrack_Array[i] )) then
			--Print("TT: First empty slot "..i);
			firstEmptySlotIndex = i;
		elseif( not firstEmptySlotIndex ) then
			if( TellTrack_Array[i].compareName == tempName ) then
				--Print("TT: Found in array");
				previousNameInstance = i;
			end
		end
	end
	if( (not firstEmptySlotIndex) and (not previousNameInstance) ) then
		--Print("TT: No empty slots found, deleting first name");
		TellTrack_Array[1] = nil;
		TellTrack_CompressList();
		firstEmptySlotIndex = TellTrack_ArrayMaxSize;
	elseif( (not firstEmptySlotIndex) and previousNameInstance) then
		firstEmptySlotIndex = TellTrack_ArrayMaxSize+1;
	end
	for i = 1, TellTrack_ArrayMaxSize do
		if ( previousNameInstance == i and firstEmptySlotIndex == i+1) then
			--Print("TT: Name found is last name sent "..i);
			TellTrack_Array[i].sentTo = not recieved;
			if (not TellTrack_Array[i].unread) then
				TellTrack_Array[i].unread = 0;
			end
			if (recieved) and (TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
				if (not getglobal(TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]):IsVisible()) or (TellTrack_CurrentConversation.name ~= target and not TellTrack_CurrentConversation.showAll) then
					TellTrack_Array[i].unread = TellTrack_Array[i].unread + 1;
				end
			end
			firstEmptySlotIndex = firstEmptySlotIndex-1
			if (TellTrack_InvertedList == 1) then
				if( i < TellTrack_ArrayMaxSize-TellTrack_ButtonCount and (TellTrack_ArrayMaxSize-i+1) ~= TellTrack_ArrayOffset ) then
					TellTrack_ChangeArrayOffset(TellTrack_ArrayMaxSize-i+1);
				end
			else
				if( i > TellTrack_ButtonCount and (i-TellTrack_ButtonCount+1) ~= TellTrack_ArrayOffset ) then
					TellTrack_ChangeArrayOffset(i-TellTrack_ButtonCount+1);
				end
			end
		elseif ( previousNameInstance == i and firstEmptySlotIndex ~= i+1) then
			--Print("TT: Removing old instance at "..i);
			TellTrack_Array[i] = nil;
			TellTrack_CompressList()
			firstEmptySlotIndex = firstEmptySlotIndex-1;
		elseif ( firstEmptySlotIndex == i ) then
			--Print("TT: Adding to array "..i);
			TellTrack_Array[i] = {};
			TellTrack_Array[i].name = target;
			TellTrack_Array[i].compareName = tempName;
			TellTrack_Array[i].sentTo = not recieved;
			if (not TellTrack_Array[i].unread) then
				TellTrack_Array[i].unread = 0;
			end
			if (recieved) and (TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]) then
				if (not getglobal(TellTrack_WhisperChatFrame[GetRealmName()][UnitName("player")]):IsVisible()) or (TellTrack_CurrentConversation.name ~= target and not TellTrack_CurrentConversation.showAll) then
					TellTrack_Array[i].unread = TellTrack_Array[i].unread + 1;
				end
			end
			if (TellTrack_InvertedList == 1) then
				if( i < TellTrack_ArrayMaxSize-TellTrack_ButtonCount and (TellTrack_ArrayMaxSize-i+1) ~= TellTrack_ArrayOffset ) then
					TellTrack_ChangeArrayOffset(TellTrack_ArrayMaxSize-i+1);
				end
			else
				if( i > TellTrack_ButtonCount and (i-TellTrack_ButtonCount+1) ~= TellTrack_ArrayOffset ) then
					TellTrack_ChangeArrayOffset(i-TellTrack_ButtonCount+1);
				end
			end
		end
	end
	--Print("TT: Updating Tell Track Button");
	TellTrack_UpdateTellTrackButtonsText();
	-- saves the names to the list
	TellTrack_SaveNames();
end

-- thanks again to Lash for the idea and the pushing of this function :)
function TellTrack_CompressList()
	local index;
	local otherArray = {};
	index = 1;
	if ( TellTrack_Array ) then
		for k, v in TellTrack_Array do
			otherArray[index] = v;
			index = index + 1;
		end
	end
	TellTrack_Array = otherArray;
	TellTrack_UpdateTellTrackButtonsText();
end


function TellTrack_ChangeArrayOffset(offset)
	local capSize = TellTrack_ArrayMaxSize - TellTrack_ButtonCount+1;
	if ( offset <= 0 ) then
		offset = 1;
	end
	if ( offset > capSize ) then
		offset = capSize;
	end
	TellTrack_ArrayOffset = offset;
	TellTrack_UpdateTellTrackButtonsText();
end

function TellTrack_PageDown()
	TellTrack_ChangeArrayOffset(TellTrack_ArrayOffset + TellTrack_ButtonCount);
end

function TellTrack_PageUp()
	TellTrack_ChangeArrayOffset(TellTrack_ArrayOffset - TellTrack_ButtonCount);
end

function TellTrack_OnMouseWheel(value)
	if ( value > 0 ) then
		TellTrack_ChangeArrayOffset(TellTrack_ArrayOffset - 1);
	elseif ( value < 0 ) then
		TellTrack_ChangeArrayOffset(TellTrack_ArrayOffset + 1);
	end
end


function TellTrack_QButton_OnEnter()
	TellTrackTooltip:SetOwner(TellTrackFrame, "ANCHOR_TOPLEFT");
	TellTrackTooltip:SetText(TELLTRACK_QUESTION_MARK_TOOLTIP);
end

function TellTrack_QButton_OnLeave()
	if ( TellTrackTooltip:IsOwned(TellTrackFrame) ) then
		TellTrackTooltip:Hide();
	end
end

function TellTrack_ResizeButton_OnEnter()
	TellTrackTooltip:SetOwner(TellTrackFrame, "ANCHOR_TOPLEFT");
	TellTrackTooltip:SetText(TELLTRACK_RESIZE_TOOLTIP);
end

function TellTrack_ResizeButton_OnLeave()
	if ( TellTrackTooltip:IsOwned(TellTrackFrame) ) then
		TellTrackTooltip:Hide();
	end
end

function TellTrack_IsClassHorde(class)
	local hordeClasses = { "Orc", "Tauren", "Troll", "Undead" };
	for k, v in hordeClasses do
		if ( class == v ) then
			return true;
		end
	end
	return false;
end

-- returns the index name for the load/save funcs
function TellTrack_GetListIndex()
	local firstString = GetCVar("realmName");
	local secondString = UnitRace("player");
	--local secondString = UnitName("player");
	if ( not firstString ) or ( not secondString ) then
		return nil;
	end
	if ( TellTrack_IsClassHorde(secondString) ) then
		secondString = "Horde";
	else
		secondString = "Alliance";
	end
	return format("%s_%s", firstString, secondString);
end

function TellTrack_LoadNames()
	local index = TellTrack_GetListIndex();
	if ( not index ) then
		if ( Cosmos_ScheduleByName ) then
			Cosmos_ScheduleByName("TELLTRACK_LOADNAMES", 0.5, TellTrack_LoadNames);
		end
		return;
	end
	if ( not TellTrack_SavedList ) then
		return;
	end;
	local list = TellTrack_SavedList[index];
	--1/20/05 now aditionally loads sentTo instead of just names. This allows loading of 'recieved/sent' status.
	if ( list ) then
		for k, v in list do
			if(type(v) == "table") then
				if(v.name and v.sentTo ~= nil) then
					TellTrack_HandleMessageSentOrRecieved(v.name, not v.sentTo);
				elseif(v.name) then
					TellTrack_HandleMessageSentOrRecieved(v.name, false);
				end
			elseif(type(v) == "string") then
				TellTrack_HandleMessageSentOrRecieved(v, false); --Support for previous TellTrack Saved Lists (all are marked as sent)
			end
			TellTrack_Array[k].unread = 0;
		end
	end
end

function TellTrack_SaveNames()
	local index = TellTrack_GetListIndex();
	if ( not index ) then
		if ( Cosmos_ScheduleByName ) then
			Cosmos_ScheduleByName("TELLTRACK_SAVENAMES", 0.5, TellTrack_SaveNames);
		end
		return;
	end
	--[[
	local list = {};
	for k, v in TellTrack_Array do
		if (v.name) then
			table.insert(list, v.name);
		end
	end
	]]--
	 --1/20/05 now saves whole array instead of just names. This allows saving of 'recieved/sent' status.
	list = TellTrack_Array;
        
	if ( not TellTrack_SavedList ) then
		TellTrack_SavedList = {};
	end
	TellTrack_SavedList[index] = list;
end

-- helper function - returns value as a byte
function TellTrack_GetByteValue(pValue)
	local value = tonumber(pValue);
	if ( value <= 0 ) then return 0; end
	if ( value >= 255 ) then return 255; end
	return value;
end


function TellTrack_ModifyButtonCount(height)
	height = height - 44;   --insets and arrow buttons
	local newCount = floor((height)/20);
	if ( newCount ~= TellTrack_ButtonCount ) then
		TellTrack_ButtonCount = newCount;
		for i=1, TellTrack_ArrayMaxSize do
			local thisButton = getglobal("TellTrack"..i);
			if not thisButton:IsVisible() and i <= TellTrack_ButtonCount then
				thisButton:Show();
			elseif thisButton:IsVisible() and i > TellTrack_ButtonCount then
				thisButton:Hide();
			end
		end
	end
	local offset = floor((height-TellTrack_ButtonCount*20+20)/2);
	TellTrackFrameArrowUpButton:SetHeight(offset);
	TellTrackFrameArrowDownButton:SetHeight(offset);
end

function TellTrackFrame_OnSizeChanged()
	local width = TellTrackFrame:GetWidth()-24;
	TellTrackFrameArrowUpButton:SetWidth(width);
	for i=1, TellTrack_ArrayMaxSize do
		getglobal("TellTrack"..i):SetWidth(width);
	end
	TellTrackFrameArrowDownButton:SetWidth(width);
	TellTrack_ModifyButtonCount(TellTrackFrame:GetHeight());
	TellTrack_ChangeArrayOffset(TellTrack_ArrayOffset);
	TellTrack_UpdateTellTrackButtonsText();
end

function TellTrack_ArrowButton_OnSizeChanged(frame)
	local height = frame:GetHeight();
	getglobal(frame:GetName().."RightBG"):SetHeight(height);
	getglobal(frame:GetName().."LeftBG"):SetHeight(height);
	getglobal(frame:GetName().."Arrow"):SetHeight(height);
end



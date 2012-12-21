SIMPLECOMM_DEBUG = false;				-- output debug information

SIMPLECOMM_CHARACTERSPERTICK_MAX = 512;	-- char per tick
SIMPLECOMM_TICK_DELAY = 1;				-- delay in second between tick

local PIPE_ENTITIE = "\127p";

SimpleComm_Channel = nil;
SimpleComm_Password = nil;
SimpleComm_ChatFrame = nil;

SimpleComm_JoinHandler = nil;
SimpleComm_LeaveHandler = nil;

local SimpleComm_Handler = nil;
local SimpleComm_Serialize = nil;
local SimpleComm_Unserialize = nil;
local SimpleComm_FilterText = nil;

local SimpleComm_oldChatFrame_OnEvent = nil;

SimpleComm_oldSendChatMessage = nil;
local SimpleComm_chanSlashCmd = nil;
local SimpleComm_chanSlashCmdUpper = nil;

local SimpleComm_FlagListener = nil;

local SimpleComm_messageQueueHeader = {};
local SimpleComm_messageQueueLast = SimpleComm_messageQueueHeader;
	-- .delay
	-- .to
	-- .serialized
	-- .next
	
local SimpleComm_sentBytes = 0;
local SimpleComm_channelName = nil;

SimpleComm_Disconnected = {};

SimpleComm_DisconnectedMessage = string.format(ERR_CHAT_PLAYER_NOT_FOUND_S, "(.*)");
SimpleComm_AFK_MESSAGE = string.format(MARKED_AFK_MESSAGE, "(.*)");
SimpleComm_DND_MESSAGE = string.format(MARKED_DND, "(.*)");
SimpleComm_Flags = {};
SimpleComm_FlagTestMessage = "-= SimpleComm test message =-";
SimpleComm_WaitingForFlagTest = false;

---------------------------------------------------------------------------------
--
-- Debug
-- 
---------------------------------------------------------------------------------
local function DEBUG_MSG(msg, high)
	if (SIMPLECOMM_DEBUG)
	then
		if high then
			ChatFrame1:AddMessage(msg, 1.0, 0.0, 0.25);
		else
			ChatFrame1:AddMessage(msg, 1.0, 1.0, 0.75);
		end
	end
end

---------------------------------------------------------------------------------
--
-- On load
-- 
---------------------------------------------------------------------------------
function SimpleComm_OnLoad()
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
end

---------------------------------------------------------------------------------
--
-- Init
-- 
---------------------------------------------------------------------------------
local function SimpleComm_joinChannel()
	DEBUG_MSG("[SimpleComm_joinChannel] begin");
	if ( GetChannelName(SimpleComm_Channel) == 0) then
		local zoneChannel, channelName = JoinChannelByName(SimpleComm_Channel, SimpleComm_Password, SimpleComm_ChatFrame:GetID());
		
		if (zoneChannel ~= 0) then
			local name = SimpleComm_Channel;
			if ( channelName ) then
				name = channelName;
			end
			
			local i = 1;
			while ( SimpleComm_ChatFrame.channelList[i] ) do
				i = i + 1;
			end
			SimpleComm_ChatFrame.channelList[i] = name;
			SimpleComm_ChatFrame.zoneChannelList[i] = zoneChannel;
		end
		DEBUG_MSG("[SimpleComm_joinChannel] end - false");
		return false;
	else
		DEBUG_MSG("[SimpleComm_joinChannel] end - true");
		return true;
	end
end

local function SimpleComm_leaveChannel()
	if ( GetChannelName(SimpleComm_Channel) ~= 0) then
		LeaveChannelByName(SimpleComm_Channel);
		SimpleComm_Channel = nil;
		SimpleComm_Password = nil;
	end
end

local function SimpleComm_initChannel()
	DEBUG_MSG("[SimpleComm_initChannel] begin");
	SimpleComm_messageQueue = { };
	SimpleComm.update = SIMPLECOMM_TICK_DELAY;
	DEBUG_MSG("[SimpleComm_initChannel] end");
	return SimpleComm_joinChannel();
end

local function SimpleComm_doneChannel()
	SimpleComm.update = nil;
	SimpleComm_leaveChannel();
end

---------------------------------------------------------------------------------
--
-- Alias
-- 
---------------------------------------------------------------------------------
local function SimpleComm_SetAliasChannel()
	id = GetChannelName( SimpleComm_Channel );
	if (id~=0 and SimpleComm_aliasMustBeSet) then
		local id = GetChannelName( SimpleComm_Channel );
		
		ChatTypeInfo[SimpleComm_chanSlashCmdUpper] = ChatTypeInfo["CHANNEL"..id];
		ChatTypeInfo[SimpleComm_chanSlashCmdUpper].sticky = 1;
		
		setglobal("CHAT_MSG_"..SimpleComm_chanSlashCmdUpper, SimpleComm_chanAlias);
		setglobal("CHAT_"..SimpleComm_chanSlashCmdUpper.."_GET", "["..SimpleComm_chanAlias.."] %s:\32");
		setglobal("CHAT_"..SimpleComm_chanSlashCmdUpper.."_SEND", SimpleComm_chanAlias..":\32");
		
		SlashCmdList[SimpleComm_chanSlashCmdUpper] = SimpleComm_test;
		setglobal("SLASH_"..SimpleComm_chanSlashCmdUpper.."1", "/"..SimpleComm_chanSlashCmd);
		
		-- hook only one time
		if (not SimpleComm_oldSendChatMessage) then
			SimpleComm_oldSendChatMessage = SendChatMessage;
			SendChatMessage = SimpleComm_newSendChatMessage;
		end

		SimpleComm_aliasMustBeSet = false;
	end
end

local function SimpleComm_UnsetAliasChannel()
	if (SimpleComm_chanSlashCmdUpper) then
		
		if ( DEFAULT_CHAT_FRAME.editBox.stickyType == string.upper(SimpleComm_chanSlashCmdUpper) ) then
			DEFAULT_CHAT_FRAME.editBox.chatType = "SAY"
			DEFAULT_CHAT_FRAME.editBox.stickyType = "SAY"
		end
		
		setglobal("CHAT_MSG_"..SimpleComm_chanSlashCmdUpper, nil);
		setglobal("CHAT_"..SimpleComm_chanSlashCmdUpper.."_GET", nil);
		setglobal("CHAT_"..SimpleComm_chanSlashCmdUpper.."_SEND", nil);
		
		SlashCmdList[SimpleComm_chanSlashCmdUpper] = nil;
		setglobal("SLASH_"..SimpleComm_chanSlashCmdUpper.."1", nil);
		
		SimpleComm_aliasMustBeSet = true;
	end
end

function SimpleComm_newSendChatMessage(msg, sys, lang, name)
	-- DEBUG_MSG("SimpleComm_newSendChatMessage("..msg..","..sys..","..NoNil(lang)..","..NoNil(name)..")");
	if (sys == SimpleComm_chanSlashCmdUpper) then
		return SimpleComm_oldSendChatMessage(string.gsub(msg, "|", PIPE_ENTITIE), "CHANNEL", lang, GetChannelName( SimpleComm_Channel ));
	else
		return SimpleComm_oldSendChatMessage(msg, sys, lang, name);
	end
end;

function SimpleComm_test()
	DEBUG_MSG("ok");
end

---------------------------------------------------------------------------------
--
-- AFK/DND status
-- 
---------------------------------------------------------------------------------
function SimpleComm_SetFlag(player, flag, message)
	if player==nil then
		player = UnitName("player");
		if SimpleComm_FlagListener then
			SimpleComm_FlagListener(flag, message);
		end
	end
	if flag then
		SimpleComm_Flags[player] = { flag=flag; message=message; count = 0 };
	else
		SimpleComm_Flags[player] = nil;
	end

end

function SimpleComm_GetFlag(player)
	if SimpleComm_Flags[player] then
		return SimpleComm_Flags[player].flag, SimpleComm_Flags[player].message;
	else
		return nil;
	end
end

function SimpleComm_AddWhisper(player)
	if SimpleComm_Flags[player] then
		SimpleComm_Flags[player].count = SimpleComm_Flags[player].count +1;
	end
end

function SimpleComm_DelWhisper(player)
	if SimpleComm_Flags[player] then
		if SimpleComm_Flags[player].count>0 then
			SimpleComm_Flags[player].count = SimpleComm_Flags[player].count -1;
			return true;
		end
	end
	return false;
end

function SimpleComm_SendFlagTest()
	SimpleComm_WaitingForFlagTest = time();
	SendChatMessage(SimpleComm_FlagTestMessage, "WHISPER", nil, UnitName("player"));
end

---------------------------------------------------------------------------------
--
-- Envois
-- 
---------------------------------------------------------------------------------
local function SimpleComm_SendQueue(elapsed)
	-- DEBUG_MSG("[SimpleComm_SendQueue] begin");
	
	local clearAFK = GetCVar("autoClearAFK");
	SetCVar("autoClearAFK", 0);
	-- GetLanguageByIndex(1), GetDefaultLanguage()
	
	SimpleComm_sentBytes = 0;
	SimpleComm_channelName = GetChannelName(SimpleComm_Channel);
	
	local previousMessage = SimpleComm_messageQueueHeader;
	local message = SimpleComm_messageQueueHeader.next;
	
	while message do
		
		-- update delay
		if message.delay then
			message.delay = message.delay-elapsed;
			if message.delay<=0 then
				message.delay = nil;
			end
		end
		
		if message.delay then
			-- skip the current message
			previousMessage = message;
			message = message.next;
		else
			-- check chat traffic
			SimpleComm_sentBytes = SimpleComm_sentBytes + string.len(message.serialized);
			if SimpleComm_sentBytes > SIMPLECOMM_CHARACTERSPERTICK_MAX then
				SimpleComm_sentBytes = SimpleComm_sentBytes - string.len(message.serialized);
				previousMessage = SimpleComm_messageQueueLast;
				break;
			end
			
			-- send message
			if message.to then
				if not SimpleComm_Disconnected[message.to] then
					-- DEBUG_MSG("Envois a("..message.to..") de("..message.serialized..")");
					SendChatMessage(message.serialized, "WHISPER", nil, message.to);
					SimpleComm_AddWhisper(message.to);
				else
					-- Ignore the message since the player is offline.
					SimpleComm_sentBytes = SimpleComm_sentBytes - string.len(message.serialized);
				end
			else
				-- DEBUG_MSG("Envois a tous de("..message.serialized..")");
				SendChatMessage(message.serialized, "CHANNEL", nil, SimpleComm_channelName);
			end
			
			-- delete current message in queue
			previousMessage.next = message.next;
			
			-- go to next message (previousMessage keeps the same value)
			message = message.next
		end
		
	end
	
	SimpleComm_messageQueueLast = previousMessage;
	
	SetCVar("autoClearAFK", clearAFK);
	if (SimpleComm_sentBytes > 0) then
		DEBUG_MSG("Octets envoyes:"..SimpleComm_sentBytes, true);
	end
	
	-- DEBUG_MSG("[SimpleComm_SendQueue] end");
end

---------------------------------------------------------------------------------
--
-- Reception
-- 
---------------------------------------------------------------------------------
local function SimpleComm_ParseMessage(author, text)
	local message = SimpleComm_Unserialize(text);
	if ((message) and (SimpleComm_Handler)) then
		SimpleComm_Handler(author, message);
	end
end

function SimpleComm_ParseEvent(event)
	if (SimpleComm_Channel) then
		
		-- event=CHAT_MSG_CHANNEL; arg1=chat message; arg2=author; arg3=language; arg4=channel name with number; arg8=channel number; arg9=channel name without number
		if ((event == "CHAT_MSG_CHANNEL") and (arg9 == SimpleComm_Channel)) then
			-- DEBUG_MSG("Reception depuis le channel:"..arg1);
			SimpleComm_Disconnected[arg2] = nil;
			SimpleComm_ParseMessage(arg2, arg1);
		
		elseif (event == "CHAT_MSG_WHISPER") then
			-- DEBUG_MSG("Reception de "..arg2..":"..arg1);
			SimpleComm_Disconnected[arg2] = nil;
			SimpleComm_ParseMessage(arg2, arg1);
		
		elseif ((event == "CHAT_MSG_CHANNEL_NOTICE") and (arg9 == SimpleComm_Channel)) then
			if (arg1 == "YOU_JOINED") then
				if (SimpleComm_Password) then
					SetChannelPassword(SimpleComm_Channel, SimpleComm_Password);
				end
				if (SimpleComm_chanSlashCmd) then
					SimpleComm_SetAliasChannel();
				end
				if (SimpleComm_JoinHandler) then
					SimpleComm_JoinHandler();
				end
			elseif (arg1 == "YOU_LEFT") then
				if (SimpleComm_chanSlashCmd) then
					SimpleComm_UnsetAliasChannel();
				end
				if (SimpleComm_LeaveHandler) then
					SimpleComm_LeaveHandler();
				end
			end
		end
		
	end
end

function SimpleComm_newChatFrame_OnEvent(event)
	if (SimpleComm_Channel) then
		
		if ((event == "CHAT_MSG_CHANNEL") and (arg9 == SimpleComm_Channel)) then

			-- Hide if this is an internal message
			if SimpleComm_FilterText(arg1) then
				return;
			end
			
			-- the message is shown in this ChatFrame ?
			local info;
			local found = 0;
			local channelLength = strlen(arg4);
			for index, value in this.channelList do
				if ( channelLength > strlen(value) ) then
					-- arg9 is the channel name without the number in front...
					if ( ((arg7 > 0) and (this.zoneChannelList[index] == arg7)) or (strupper(value) == strupper(arg9)) ) then
						found = 1;
						info = ChatTypeInfo["CHANNEL"..arg8];
						break;
					end
				end
			end
			if ( (found == 0) or not info ) then
				return;
			end
			
			-- unpack PIPE_ENTITIE
			arg1 = string.gsub(arg1, PIPE_ENTITIE, "|")
			
			if (SimpleComm_chanSlashCmdUpper) then
				event = "CHAT_MSG_"..SimpleComm_chanSlashCmdUpper;
				arg4 = "";   --  channel name with number
			end
		end
		
		if (event == "CHAT_MSG_SYSTEM") then
			local iStart, iEnd, playerName = string.find(arg1, SimpleComm_DisconnectedMessage);
			if iStart then
				if SimpleComm_Disconnected[playerName] then
					if time()-SimpleComm_Disconnected[playerName] < 2 then 
						return;
					end
				else
					SimpleComm_Disconnected[playerName] = time();
				end
			end
			
			local iStart, iEnd, message = string.find(arg1, SimpleComm_AFK_MESSAGE);
			if iStart or arg1==MARKED_AFK then 
				SimpleComm_SetFlag(nil, "AFK", message);
			end
			
			local iStart, iEnd, message = string.find(arg1, SimpleComm_DND_MESSAGE);
			if iStart then
				SimpleComm_SetFlag(nil, "DND", message);
			end
			
			if arg1==CLEARED_AFK or arg1==CLEARED_DND then
				SimpleComm_SetFlag(nil, nil, nil);
			end
		end
		
		if (event == "CHAT_MSG_WHISPER") then
			if SimpleComm_FilterText(arg1) or arg1==SimpleComm_FlagTestMessage then
				return;
			end
		end
		
		if (event == "CHAT_MSG_WHISPER_INFORM") then
			if SimpleComm_FilterText(arg1) or arg1==SimpleComm_FlagTestMessage then
				return;
			end
		end
		
		if (event == "CHAT_MSG_CHANNEL_JOIN") and (arg9 == SimpleComm_Channel) then
			SimpleComm_Disconnected[arg2] = nil;
			return;
		end
		
		if (event == "CHAT_MSG_CHANNEL_LEAVE") and (arg9 == SimpleComm_Channel) then
			-- to avoid bug #1315237 : guess that player is offline if he isn't on the channel
			SimpleComm_Disconnected[arg2] = time();
			return;
		end
		
		if event == "CHAT_MSG_AFK" or event == "CHAT_MSG_DND" then
			if SimpleComm_DelWhisper(arg2) then
				return;
			elseif SimpleComm_WaitingForFlagTest and arg2==UnitName("player") then
				-- whisper to myself, and SimpleComm is waiting for the AFK/DND status
				if (SimpleComm_WaitingForFlagTest-time())<10 then
					-- event before 10 seconds -> the player is AFK/DND
					if event=="CHAT_MSG_AFK" then
						SimpleComm_SetFlag(nil, "AFK", arg1);
					elseif event=="CHAT_MSG_DND" then
						SimpleComm_SetFlag(nil, "DND", arg1);
					end
					SimpleComm_WaitingForFlagTest = false;
					return
				else
					-- event 10 seconds after the init -> the player wrote and sent a whisper to himself while he is AFK/DND.
					SimpleComm_WaitingForFlagTest = false;
				end
			end
		end
	else
		if event=="CHAT_MSG_CHANNEL" or event=="CHAT_MSG_WHISPER" or event=="CHAT_MSG_WHISPER_INFORM" then
			if SimpleComm_FilterText and SimpleComm_FilterText(arg1) then
				return;
			end
		end
	end
	
	SimpleComm_oldChatFrame_OnEvent(event);
end
SimpleComm_oldChatFrame_OnEvent = ChatFrame_OnEvent;
ChatFrame_OnEvent = SimpleComm_newChatFrame_OnEvent;

---------------------------------------------------------------------------------
--
-- Timer
-- 
---------------------------------------------------------------------------------
function SimpleComm_OnUpdate(elapsed)
	if (this.update) then
		this.update = this.update - elapsed;
		if (this.update <=0) then
			SimpleComm_SendQueue(SIMPLECOMM_TICK_DELAY - this.update);
			this.update = SIMPLECOMM_TICK_DELAY;
		end
	elseif (this.initChannel) then
		this.initChannel = this.initChannel - elapsed;
		if (this.initChannel <= 0) then
			SimpleComm_initChannel();
			this.initChannel = nil;
		end
	end
end

---------------------------------------------------------------------------------
--
-- Hook into Ephemeral
-- 
---------------------------------------------------------------------------------
local function initEphemeralHook()
	if ep and ep.VERSION_NUMERIC then
		ep.UnregisterForEvent( "CHAT_MSG_WHISPER", ep.RespondToWhisper )
		ep.UnregisterForEvent( "CHAT_MSG_WHISPER_INFORM", ep.RespondToWhisperNotice )
		ep.RegisterForEvent( "CHAT_MSG_WHISPER", SimpleComm_EphemeralRespondToWhisper )
		ep.RegisterForEvent( "CHAT_MSG_WHISPER_INFORM", SimpleComm_EphemeralRespondToWhisperNotice )
	end
end

if ep and not ep.UnregisterForEvent then
	function ep.UnregisterForEvent(event, callback)
		if ep.RegisteredEvents[ event ] then
			for index, currentCB in ep.RegisteredEvents[ event ] do
				if currentCB == callback then
					table.remove( ep.RegisteredEvents[ event ], index);
				end
			end
		end
	end
end

function SimpleComm_EphemeralRespondToWhisper( event, parameters )
	if not SimpleComm_FilterText(parameters[1]) then
		ep.RespondToWhisper(event, parameters);
	end
end

function SimpleComm_EphemeralRespondToWhisperNotice( event, parameters )
	if not SimpleComm_FilterText(parameters[1]) then
		ep.RespondToWhisperNotice(event, parameters);
	end
end


---------------------------------------------------------------------------------
--
-- Fonctions publiques
-- 
---------------------------------------------------------------------------------
function SimpleComm_SendMessage(who, msg, delay)
	if not(who and SimpleComm_Disconnected[who]) then
		SimpleComm_messageQueueLast.next = {to=who; serialized=SimpleComm_Serialize(msg); delay=delay };
		SimpleComm_messageQueueLast = SimpleComm_messageQueueLast.next;
	end
end

function SimpleComm_SendRawMessage(who, message, delay)
	if not(who and SimpleComm_Disconnected[who]) then
		SimpleComm_messageQueueLast.next = {to=who; serialized=message; delay=delay };
		SimpleComm_messageQueueLast = SimpleComm_messageQueueLast.next;
	end
end

function SimpleComm_PreInit(FilterText)
	SimpleComm_FilterText = FilterText;
end

function SimpleComm_Init(Channel, Password, ChatFrame, OnJoin, OnLeave, OnMessage, Serialize, Unserialize, FilterText)
	DEBUG_MSG("[SimpleComm_Init] begin");
	-- Pour la reception
	SimpleComm_Handler = OnMessage;
	SimpleComm_JoinHandler = OnJoin;
	SimpleComm_LeaveHandler = OnLeave;
	SimpleComm_Serialize =  Serialize;
	SimpleComm_Unserialize =  Unserialize;
	SimpleComm_FilterText = FilterText;
	SimpleComm_ChatFrame = ChatFrame;
	
	-- Init Channel
	SimpleComm_Channel = Channel;
	SimpleComm_Password = Password;
	local onChannelNow = SimpleComm_initChannel();
	
	-- Init hook into Ephemeral
	initEphemeralHook();
	
	-- AFK/DND test for myself
	SimpleComm_SendFlagTest();
	
	-- 
	if (onChannelNow) then
		SimpleComm_JoinHandler();
	end
	
	-- Set timer
	SimpleComm:Show();
	
	DEBUG_MSG("[SimpleComm_Init] end");
end

function SimpleComm_InitAlias(chanSlashCmd, chanAlias)
	DEBUG_MSG("[SimpleComm_InitAlias] begin");
	-- unset previous alias
	if (SimpleComm_chanSlashCmd) then
		SimpleComm_UnsetAliasChannel();
	end
	
	-- set alias
	SimpleComm_chanSlashCmd = chanSlashCmd;
	SimpleComm_chanSlashCmdUpper = string.upper(chanSlashCmd);
	SimpleComm_chanAlias = chanAlias;
	
	SimpleComm_aliasMustBeSet = true;
	SimpleComm_SetAliasChannel();
	DEBUG_MSG("[SimpleComm_InitAlias] end");
end

function SimpleComm_SetChannel(Channel, Password)
	if (Channel ~= SimpleComm_Channel) then
		-- done
		if (SimpleComm_chanSlashCmd) then
			SimpleComm_UnsetAliasChannel();
		end
		SimpleComm_doneChannel();
		-- set channel
		SimpleComm_Channel = Channel;
		SimpleComm_Password = Password;
		-- init alias / joinHandler
		local onChannelNow = (GetChannelName(SimpleComm_Channel) ~= 0);
		if (onChannelNow) then
			SimpleComm_JoinHandler();
			if (SimpleComm_chanSlashCmd) then
				SimpleComm_SetAliasChannel();
			end
		end
		-- call SimpleComm_initChannel in 2 seconds
		SimpleComm.initChannel = 2;
	end
end

function SimpleComm_SetFlagListener(flagListener)	
	SimpleComm_FlagListener = flagListener;
end
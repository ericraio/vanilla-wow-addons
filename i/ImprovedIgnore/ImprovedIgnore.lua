--[[
ImprovedIgnore.lua
by Yrys - Hellscream <yrysremove at twparemove dot net>

Improved functionality for ignore.  Ignored players show up as red on
who lists, and sending a tell to a player on ignore will optionally either
auto-remove that player from your ignore list, or block the tell.

Version history:
- 1.1.1.11100  (2005-09-30): The binary version! Updated for 1.11 patch.
- 1.1.1.11000  (2005-09-30): The binary version! Updated for 1.10 patch.
- 1.1.1.10900 (2005-12-02): Removed emote blocking code, and updated for 1.9.
- 1.1.0.1800  (2005-09-30): Updated for 1.8 patch.
- 1.1.0.1700  (2005-09-13): Updated for 1.7 patch.
- 1.1.0.1600  (2005-07-12): Updated for 1.6 patch.
- 1.1.0.1500  (2005-06-07): Updated for 1.5 patch.
- 1.1.0.1300  (2005-04-30): Emotes are now suppressed for people on your ignore list.
- 1.0.1.1300  (2005-04-29): Added command line options, whisper setting, system who.
- 1.0.0.1300  (2005-04-26): First version.
]]

-- Variables.
IIGNORE_VER = "1.1.0.11000"
local SendChatMessage_Orig = nil
local GetWhoInfo_Orig = nil
local AddMessage1_Orig = nil
local AddMessage2_Orig = nil
local AddMessage3_Orig = nil
local AddMessage4_Orig = nil
local AddMessage5_Orig = nil
local AddMessage6_Orig = nil
local AddMessage7_Orig = nil
local syswhofound = nil
ImprovedIgnore_Settings = {
	whisper = STR_IIGNORE_COMMAND_OFF
}



function ImprovedIgnore_OnLoad()
	-- Hook functions.
	
	if SendChatMessage ~= ImprovedIgnore_SendChatMessage then
		SendChatMessage_Orig = SendChatMessage
		SendChatMessage = ImprovedIgnore_SendChatMessage
	end
	if GetWhoInfo ~= ImprovedIgnore_GetWhoInfo then
		GetWhoInfo_Orig = GetWhoInfo
		GetWhoInfo = ImprovedIgnore_GetWhoInfo
	end
	if DEFAULT_CHAT_FRAME.AddMessage ~= ImprovedIgnore_AddMessage1 then
		AddMessage1_Orig = DEFAULT_CHAT_FRAME.AddMessage
		DEFAULT_CHAT_FRAME.AddMessage = ImprovedIgnore_AddMessage1
	end
	if ChatFrame2 and ChatFrame2.AddMessage ~= ImprovedIgnore_AddMessage2 then
		AddMessage2_Orig = ChatFrame2.AddMessage
		ChatFrame2.AddMessage = ImprovedIgnore_AddMessage2
	end
	if ChatFrame3 and ChatFrame3.AddMessage ~= ImprovedIgnore_AddMessage3 then
		AddMessage3_Orig = ChatFrame3.AddMessage
		ChatFrame3.AddMessage = ImprovedIgnore_AddMessage3
	end
	if ChatFrame4 and ChatFrame4.AddMessage ~= ImprovedIgnore_AddMessage4 then
		AddMessage4_Orig = ChatFrame4.AddMessage
		ChatFrame4.AddMessage = ImprovedIgnore_AddMessage4
	end
	if ChatFrame5 and ChatFrame5.AddMessage ~= ImprovedIgnore_AddMessage5 then
		AddMessage5_Orig = ChatFrame5.AddMessage
		ChatFrame5.AddMessage = ImprovedIgnore_AddMessage5
	end
	if ChatFrame6 and ChatFrame6.AddMessage ~= ImprovedIgnore_AddMessage6 then
		AddMessage6_Orig = ChatFrame6.AddMessage
		ChatFrame6.AddMessage = ImprovedIgnore_AddMessage6
	end
	if ChatFrame7 and ChatFrame7.AddMessage ~= ImprovedIgnore_AddMessage7 then
		AddMessage7_Orig = ChatFrame7.AddMessage
		ChatFrame7.AddMessage = ImprovedIgnore_AddMessage7
	end
	if SendChatMessage ~= ImprovedIgnore_SendChatMessage then
		SendChatMessage_Orig = SendChatMessage
		SendChatMessage = ImprovedIgnore_SendChatMessage
	end

	-- Register events we want to catch.
	this:RegisterEvent ("CHAT_MSG_SYSTEM")

	-- Set up slash commands.
	SlashCmdList["IMPROVEDIGNORE"] = ImprovedIgnore_CmdRelay
	SLASH_IMPROVEDIGNORE1 = "/ii"
	SLASH_IMPROVEDIGNORE2 = "/improvedignore"

	-- Show loaded message.
	DEFAULT_CHAT_FRAME:AddMessage (string.format (STR_IIGNORE_FUNC_LOADED, IIGNORE_VER))
end



-- Event handler.  Checks for non-WhoFrame /whos.
function ImprovedIgnore_OnEvent()
	local name, othertext, start, stop = nil

	if event == "CHAT_MSG_SYSTEM" and arg1 then
		start, stop, name, othertext = string.find (arg1, "^(%a+)(: Level %d+ [^-]+- .*)")
		if name and othertext then
			syswhofound = 1
		end
	end
end



-- Command-line handler.  Passes to other functions.
function ImprovedIgnore_CmdRelay (args)
	local start, stop, cmd, subargs = nil

	-- Split arguments into first and all others.
	if args then
		start, stop, cmd, subargs = string.find (args, "^([^ ]-) (.+)$")
		if not cmd then
			cmd = args
		end
	end

	if cmd then
		cmd = string.lower (cmd)
	end
	if subargs then
		subargs = string.lower (subargs)
	end

	if cmd == STR_IIGNORE_COMMAND_STATUS then
		ImprovedIgnore_CmdStatus()
	elseif cmd == STR_IIGNORE_COMMAND_WHISPER or cmd == STR_IIGNORE_COMMAND_TELL then
		ImprovedIgnore_CmdWhisperConfig (subargs)
	else
		ImprovedIgnore_CmdHelp()
	end
end



-- Shows command-line help.
function ImprovedIgnore_CmdHelp()
	local syscolor = ChatTypeInfo["SYSTEM"]

	DEFAULT_CHAT_FRAME:AddMessage (string.format (STR_IIGNORE_HELP_HEADER, IIGNORE_VER), syscolor.r, syscolor.g, syscolor.b, syscolor.id)
	DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_HELP_STATUS, syscolor.r, syscolor.g, syscolor.b, syscolor.id)
	DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_HELP_WHISPER, syscolor.r, syscolor.g, syscolor.b, syscolor.id)
end



-- Shows ImprovedIgnore status.
function ImprovedIgnore_CmdStatus()
	DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_STATUS_HEADER)
	if ImprovedIgnore_Settings.whisper == STR_IIGNORE_COMMAND_ON then
		DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_STATUS_WHISPERON)
	elseif ImprovedIgnore_Settings.whisper == STR_IIGNORE_COMMAND_AUTO then
		DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_STATUS_WHISPERAUTO)
	elseif ImprovedIgnore_Settings.whisper == STR_IIGNORE_COMMAND_OFF then
		DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_STATUS_WHISPEROFF)
	end
end



-- Configure whisper settings.
function ImprovedIgnore_CmdWhisperConfig (arg)
	local syscolor = ChatTypeInfo["SYSTEM"]

	if arg == STR_IIGNORE_COMMAND_ON then
		ImprovedIgnore_Settings.whisper = STR_IIGNORE_COMMAND_ON
		DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_WHISPER_ON)
	elseif arg == STR_IIGNORE_COMMAND_AUTO then
		ImprovedIgnore_Settings.whisper = STR_IIGNORE_COMMAND_AUTO
		DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_WHISPER_AUTO)
	elseif arg == STR_IIGNORE_COMMAND_OFF then
		ImprovedIgnore_Settings.whisper = STR_IIGNORE_COMMAND_OFF
		DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_WHISPER_OFF)
	else
		DEFAULT_CHAT_FRAME:AddMessage (STR_IIGNORE_HELP_WHISPER, syscolor.r, syscolor.g, syscolor.b, syscolor.id)
	end
end



-- Check a name to see if it's being ignored.  1 if true, nil if false.
function ImprovedIgnore_IsPlayerIgnored (player)
	if player and GetNumIgnores() then
		for x = 1, GetNumIgnores() do
			if string.lower (GetIgnoreName(x)) == string.lower (player) then
				return 1
			end
		end
	end

	return nil
end



-- Color a name red if player is on ignore.
function ImprovedIgnore_ColorWhoName (player)
	if ImprovedIgnore_IsPlayerIgnored (player) then
		player = "|cffff0000" .. player .. "|r";
	end
	
	return player
end



-- When getting who info, check for ignored names.
function ImprovedIgnore_GetWhoInfo (whoIndex)
	name, guild, level, race, class, zone, group = GetWhoInfo_Orig (whoIndex)

	name = ImprovedIgnore_ColorWhoName (name)
	
	return name, guild, level, race, class, zone, group
end



-- Check to see if message is a system /who.
function ImprovedIgnore_CheckSysWho (whotext)
	local start, stop, name, othertext = nil

	if whotext then
		start, stop, name, othertext = string.find (arg1, "^(%a+)(: Level %d+ [^-]+- .*)")
		if name and othertext then
			name = ImprovedIgnore_ColorWhoName (name)
			whotext = name .. othertext
		end
	end

	return whotext
end



-- Check to see if an emote is from an ignored player.  1 on true, nil on false.
-- REMOVED FOR 1.9.  This will be deleted from the code in the next release.
--[[ function ImprovedIgnore_CheckEmote (message)
	local start, stop, name = nil

	if message then
		start, stop, name = string.find (message, "^(%a+)")
		if name and ImprovedIgnore_IsPlayerIgnored (name) then
			return 1
		end
	end

	return nil
end ]]



-- Check for ignored players on sending a whisper.
function ImprovedIgnore_SendChatMessage (msg, ...)
	local system, language, player = unpack (arg)

	if system == "WHISPER" and player then
		if ImprovedIgnore_IsPlayerIgnored (player) then
			if ImprovedIgnore_Settings.whisper == STR_IIGNORE_COMMAND_AUTO then
				DEFAULT_CHAT_FRAME:AddMessage (string.format (STR_IIGNORE_FUNC_AUTO, player), 1, 0, 0)
				DelIgnore (player)
			elseif ImprovedIgnore_Settings.whisper == STR_IIGNORE_COMMAND_OFF then
				DEFAULT_CHAT_FRAME:AddMessage (string.format (STR_IIGNORE_FUNC_BLOCK, player), 1, 0, 0)
				return
			end
		end
	end

	SendChatMessage_Orig (msg, unpack (arg))
end



-- Modified default AddMessage.  If flag is set, check for ignored /who name.
function ImprovedIgnore_AddMessage1 (t, s, ...)
	if syswhofound then
		s = ImprovedIgnore_CheckSysWho (s)
		syswhofound = nil
	end

	AddMessage1_Orig (t, s, unpack (arg))
end



-- Modified chat 2 AddMessage.  If flag is set, check for ignored /who name.
function ImprovedIgnore_AddMessage2 (t, s, ...)
	if syswhofound then
		s = ImprovedIgnore_CheckSysWho (s)
		syswhofound = nil
	end

	AddMessage2_Orig (t, s, unpack (arg))
end



-- Modified chat 3 AddMessage.  If flag is set, check for ignored /who name.
function ImprovedIgnore_AddMessage3 (t, s, ...)
	if syswhofound then
		s = ImprovedIgnore_CheckSysWho (s)
		syswhofound = nil
	end

	AddMessage3_Orig (t, s, unpack (arg))
end



-- Modified chat 4 AddMessage.  If flag is set, check for ignored /who name.
function ImprovedIgnore_AddMessage4 (t, s, ...)
	if syswhofound then
		s = ImprovedIgnore_CheckSysWho (s)
		syswhofound = nil
	end

	AddMessage4_Orig (t, s, unpack (arg))
end



-- Modified chat 5 AddMessage.  If flag is set, check for ignored /who name.
function ImprovedIgnore_AddMessage5 (t, s, ...)
	if syswhofound then
		s = ImprovedIgnore_CheckSysWho (s)
		syswhofound = nil
	end

	AddMessage5_Orig (t, s, unpack (arg))
end



-- Modified chat 6 AddMessage.  If flag is set, check for ignored /who name.
function ImprovedIgnore_AddMessage6 (t, s, ...)
	if syswhofound then
		s = ImprovedIgnore_CheckSysWho (s)
		syswhofound = nil
	end

	AddMessage6_Orig (t, s, unpack (arg))
end



-- Modified chat 7 AddMessage.  If flag is set, check for ignored /who name.
function ImprovedIgnore_AddMessage7 (t, s, ...)
	if syswhofound then
		s = ImprovedIgnore_CheckSysWho (s)
		syswhofound = nil
	end

	AddMessage7_Orig (t, s, unpack (arg))
end

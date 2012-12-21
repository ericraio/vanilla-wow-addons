
-- Add the module to the tree
-- table setup
local mod = thismod
local me = { }
mod.out = me

me.trace = 
{
	-- Top two are special. "traceall" true will make all traces print, regardless of their state.
	-- "badtracekey" true will print an error when a tracecall is made with an undefined key 
	["traceall"] = false,
	["badtracekey"] = true,

	["localnooverride"] = false,
	["localinvalidkey"] = true,
}

--[[
mod.out.printtrace(condition, message)
Prints out <message> if the trace variable <condition> is true. <condition> must be a key in me.trace.
]]
me.printtrace = function(condition, message)

	-- 1) Check the trace key exists
	if me.trace[condition] == nil then
		
		-- That trace key does not exist
		if me.trace.badtracekey == true then
			me.print(string.format("The trace key |cffff3333%s|r is not defined. The message was: %s", condition, message))
		end
		
		return
	end
	
	-- 2) To print or not?
	if (me.trace.traceall == true) or (me.trace[condition] == true) then
		me.print(string.format("|cff6666ffTrace |r%s", message))
	end
	
end

--[[ 
mod.out.print(message, chatframeindex, noheader)
Prints out <message> to chat.
To print to ChatFrame3, set <chatframeindex> to 3, etc.
Adds a header "KTM: " to the message, unless <noheader> is non-nil.
]]
me.print = function(message, chatframeindex, noheader)

	-- Get a Frame to write to
	local chatframe

	if chatframeindex == nil then
		chatframe = DEFAULT_CHAT_FRAME
		
	else
		chatframe = getglobal("ChatFrame" .. chatframeindex)
		
		if chatframe == nil then
			chatframe = DEFAULT_CHAT_FRAME
		end
	end

	-- touch up message
	message = message or "<nil>"
		
	if noheader == nil then
		message = mod.string.get("print", "core", "header") .. message 
	end
	
	-- write
	chatframe:AddMessage(message)

end

--[[
mod.out.booltostring(boolean)
Converts a Boolean value (true or false) to a string representation.
true -> "true", false -> "false", nil -> "nil"
]]
me.booltostring = function(boolean)
	
	if boolean == true then
		return "true"
	elseif boolean == false then
		return "false"
	else
		return "nil"
	end
	
end

--[[ 
mod.out.announce(message)
Sends a chat message to Raid if possible, or Party if possible, or finally Say.
]]
me.announce = function(message)
		
	local channel = "SAY"

	if GetNumRaidMembers() > 0 then
		channel = "RAID"

	elseif GetNumPartyMembers() > 0 then
		channel = "PARTY"
	end

	SendChatMessage(message, channel)

end

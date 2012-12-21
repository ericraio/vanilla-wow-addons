
local mod = thismod
local me = {}
mod.console = me

-- Special onload method called from Core.lua
me.onload = function()
	
	-- Set up a command line handler
	setglobal(string.format("SLASH_%s%d", mod.string.get("print", "core", "modname"), 1), mod.string.get("print", "console", "short"))
	setglobal(string.format("SLASH_%s%d", mod.string.get("print", "core", "modname"), 2), mod.string.get("print", "console", "medium"))
	setglobal(string.format("SLASH_%s%d", mod.string.get("print", "core", "modname"), 3), mod.string.get("print", "console", "long"))

	SlashCmdList[mod.string.get("print", "core", "modname")] = me.consolecommand
	
	-- create all the CLUI tables
	me.defineclui()
	
	-- Add their .rootstring values
	me.clui.rootstring = mod.string.get("print", "console", "short") .. " "
	me.clui.colourrootstring = "|cffffff00" .. me.clui.rootstring
	
	me.fillchildrootstrings(me.clui)
	
end

--[[
me.fillchildrootstrings(clui)
Computes the value of clui.rootstring and .rootstring for all its child branches.
the .rootstring value is what the user has to type to get into that branch. The rootstring for the
topmost node is just "/ktm"; for the test child of the main node, the rootstring is "/ktm test".
This method is called recursively on all child branches.
]]
me.fillchildrootstrings = function(clui)

	local key
	local value
	
	-- debug checks
	if clui == nil then
		mod.out.print("clui = nil")
	elseif clui.branches == nil then
		mod.out.print("branches = nil")
	end
	
	local colourcommands = { }
	local key2
	local value2
	local length
	
	for key, value in clui.branches do
		length = 1
		
		for key2, value2 in clui.branches do
			
			if value ~= value2 then
			
				for x = length, string.len(value.command) - 1 do
				
					if string.sub(value.command, 1, x) == string.sub(value2.command, 1, x) then
						length = x + 1 
					else
						break
					end
				end
			end
		end
		
		value.colourcommand = "|cff33ff88" .. string.sub(value.command, 1, length) .. "|cffffff00" .. string.sub(value.command, length + 1)
		
		if type(value.output) ~= "function" then
			value.output.rootstring = clui.rootstring .. value.command .. " "
			value.output.colourrootstring = clui.colourrootstring .. value.colourcommand .. " "
			me.fillchildrootstrings(value.output)
		end
	end
	
end

--[[ 
me.runclui(commands, clui)
Process the commands <commands> on <clui>.
<commands> is an array with 0 or more strings.
<clui> is a branch of the console tree, e.g. me.cluitest
]]
me.runclui = function(commands, clui)
	
	local command = commands[1]
	local key
	local branch
	
	if command == nil then
		-- just print out help information for this one
		me.printhelpforclui(clui)
		
	else
		
		-- find the branches that match the command
		local matchingbranches = { }
		
		for key, branch in clui.branches do
			if string.len(branch.command) >= string.len(command) and string.sub(branch.command, 1, string.len(command)) == command then
				-- this branch matches the command
				table.insert(matchingbranches, branch)
			end
		end
	
		-- 1) Not enough branches
		if table.getn(matchingbranches) == 0 then
			
			-- print error, print help, abort.
			mod.out.print("|cffff8888No command matching " .. clui.colourrootstring .. command .. "|cffff8888 could be found.")
			
			me.printhelpforclui(clui)
			
			-- too many branches that match the abbreviation. Error then exit
		elseif table.getn(matchingbranches) > 1 then
			
			local errorstring = "|cffff8888Could not disambiguate your command " .. clui.colourrootstring .. command .. " |cffff8888, after " .. clui.colourrootstring .. "|cffff8888 you could mean {"
			for key, branch in matchingbranches do
				if key > 1 then
					errorstring = errorstring .. ", "
				end
				
				errorstring = errorstring .. branch.colourcommand .. "|cffff8888"
			end
			
			errorstring = errorstring .. "}."
			mod.out.print(errorstring)
			
		else -- just one branch matches the abbreviation. run it.
			
			branch = matchingbranches[1]
			if type(branch.output) == "function" then
				
				-- base command
				local message = "|cff8888ffRunning the command " .. clui.colourrootstring .. branch.colourcommand 
				
				-- arguments
				table.remove(commands, 1)
				
				for _, key in commands do
					message = message .. " " .. key
				end
				
				-- print
				message = message .. "|cff8888ff."
				mod.out.print(message)
				
				-- run
				branch.output(commands[1], commands)
				
			else
				-- run the block
				table.remove(commands, 1)
				me.runclui(commands, branch.output)
			end
		end
	end	
end


me.printhelpforclui = function(clui)

	mod.out.print("|cff8888ffThis is the help topic for " .. clui.colourrootstring .. "|cff8888ff.")

	if type(clui.description) == "string" then
		mod.out.print(clui.description)
	
	elseif type(clui.description) == "function" then
		clui.description()
	end
		
	local key
	local branch
	local message
	
	for key, branch in clui.branches do
		message = clui.colourrootstring .. branch.colourcommand .. "|r - "
		
		if type(branch.description) == "function" then
			message = message .. branch.description()
		else
			message = message .. branch.description
		end
		
		mod.out.print(message)
	end

end

--[[ 
This method is called by typing a "/ktm" command in the console.
]]
me.consolecommand = function(message)
	
	-- parse space-delimited words into a list
	local commandlist = { }
	local command
	
	for command in string.gfind(message, "[^ ]+") do
		table.insert(commandlist, string.lower(command))
	end
	
	me.runclui(commandlist, me.clui)

end

--[[ 
These are static variables, but they depend on static variables defined in other modules (function pointers and such).
Therefore they are initialised at onload(), not when the code is read.
]]
me.defineclui = function()

me.subclui = { }

me.subclui.memory = 
{
	description = nil,
	branches = 
	{
		{
			command = "total",
			description = "total memory created.",
			output = function()
				mod.main.print2("memory", "total")
			end,
		},
		{
			command = "recent",
			description = "memory created in the last 30 seconds.",
			output = function()
				mod.main.print2("memory", "currenthistorysum")
			end,
		},
	},
}
	
me.subclui.time = 
{
	description = nil,
	branches = 
	{
		{
			command = "total",
			description = "total processor time used.",
			output = function()
				mod.main.print2("time", "total")
			end,
		},
		{
			command = "recent",
			description = "processor time used in the last 30 seconds.",
			output = function()
				mod.main.print2("time", "currenthistorysum")
			end,
		},
	},
}	

me.clui =
{
	--["RootString"] = <a string>. Gets filled in at RunTime - KLHTM_ConsoleUIStartup()
	["description"] = nil,
	["branches"] = 
	{
		{
			["command"] = "memory",
			["description"] = "Print out the top memory users.",
			["output"] = me.subclui.memory,
		},
		{
			["command"] = "time",
			["description"] = "Print out the top processor time users.",
			["output"] = me.subclui.time,
		},
		{
			["command"] = "load",
			["description"] = "loads the monitoring engine.",
			["output"] = mod.main.hookall,
		},
		{
			["command"] = "disable",
			["description"] = "Emergency stop: disables events / onupdate.",
			["output"] = function()
				if mod.isenabled == false then
					mod.out.print("The mod is already disabled. Run the 'enable' command to restart it.")
					
				else
					mod.isenabled = false
					mod.out.print("The mod has been disabled, and won't work until you run the 'enable' command.")
				end
			end
		},
		{
			["command"] = "enable",
			["description"] = "Restart the mod after an emergency stop.",
			["output"] = function()
				if mod.isenabled == true then
					mod.out.print("The mod is already running.")
					
				else
					mod.isenabled = true
					mod.out.print("The mod has been restarted, and will now receive events / onupdate.")
				end
			end
		}
					
	},
}

end

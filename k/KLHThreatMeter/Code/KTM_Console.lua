
local mod = klhtm
local me = {}
mod.console = me

-- Special onload method called from Core.lua
me.onload = function()
	
	-- Set up a command line handler
	SLASH_KLHThreatMeter1 = "/ktm"
	SLASH_KLHThreatMeter2 = "/klhtm"
	SLASH_KLHThreatMeter3 = "/klhthreatmeter"
	SlashCmdList["KLHThreatMeter"] = me.consolecommand
	
	-- create all the CLUI tables
	me.defineclui()
	
	-- Add their .rootstring values
	me.clui.rootstring = "/ktm "
	me.clui.colourrootstring = "|cffffff00/ktm "
	
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
		
		-- debug
		if value == nil then
			mod.out.print("oops, nil for key = " .. key)
		end
		
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

me.subclui.version = 
{
	["description"] = 
	function()
		mod.out.print(string.format("This is Release |cff33ff33%s|r Revision |cff33ff33%s|r. These commands require you to be the raid leader or an officer.", mod.release, mod.revision))
	end,
	["branches"] = 
	{
		{
			["command"] = "notify",
			["description"] = "Notifies users with an older version of the mod to upgrade.",
			["output"] = mod.net.versionnotify
		},
		{
			["command"] = "query",
			["description"] = "Asks everyone in the raid to report their mod version.",
			["output"] = mod.net.versionquery
		},
		{
			["command"] = "advertise",
			["description"] = "Will occasionally tell people who pull aggro and don't have the mod to get it. Run this command again to stop it.",
			["output"] = mod.net.toggleadvertise,
		},
	}
}

-- GUI commands. Most commands would be fairly redundany, because you can just use the GUI, after all.
-- You can use this to bring up the window if it has been closed, or reset it completely if you have lost it.
me.subclui.gui = 
{	
	["description"] = nil,
	["branches"] = 
	{
		{
			["command"] = "show",
			["description"] = "Shows the window.",
			["output"] = 
				function()
					KLHTM_SetVisible(true)
				end,
		},
		{
			["command"] = "hide",
			["description"] = "Hides the window.",
			["output"] = 
				function()
					KLHTM_SetVisible(false)
				end,
		},
		{
			["command"] = "reset",
			["description"] = "Puts the window back in the middle of the screen.",
			["output"] = KLHTM_ResetFrame,
		},
	}
}

me.subclui.test = 
{
	["description"] = nil,
	["branches"] = 
	{
		{
			["command"] = "talents",
			["description"] = "Prints out your talent points in any talents that affect your threat.",
			["output"] = mod.data.testtalents
		},
		{
			["command"] = "gear",
			["description"] = "Prints out the set pieces you are wearing for sets that affect your threat.",
			["output"] = mod.data.testitemsets
		},
		{
			["command"] = "threat",
			["description"] = "Prints out a variety of threat parameters.",
			["output"] = mod.my.testthreat
		},
		{
			["command"] = "time",
			["description"] = "Prints out processor time information.",
			["output"] = 
				function()
					mod.diag.printalldata("time", "Milliseconds, or Milliseconds per Second")
				end
		},
		{
			["command"] = "memory",
			["description"] = "Prints out memory usage information.",
			["output"] = 
				function()
					mod.diag.printalldata("memory", "Kilobytes, or Kilobytes per Second")
				end
		},
		{
			["command"] = "channel",
			["description"] = "Checks whether the communication channel is properly set up.",
			["output"] = function()
				
				local number
				local name
				local source
				
				number, name, source = mod.net.getchannel()
				
				if number == 0 then
					mod.out.print("The mod could not find a suitable channel!")
				
				else
					mod.out.print(string.format("You are using channel number %s, %s, from %s.", number, name, source))
					
				end
				
			end
		},
		{
			["command"] = "netlog",
			["description"] = "Information about the channel messages received.",
			["output"] = 
				function()
					local key
					local value
					
					for key, value in mod.netin.messagelog do
						mod.out.print(string.format("|cffffff00%s: |r%d bytes in %d messages (%d average).", key, value.bytes, value.count, math.floor(0.5 + value.bytes / math.max(value.count, 0))))						
					end 
				end	
		},
		{
			["command"] = "states",
			["description"] = "Check that the mod has the correct value for its state variables",
			["output"] = 
				function()
					local key
					local value
					
					local doformat = function(Time)
						if Time == 0 then
							return "never"
						end
						
						return string.format("%d seconds ago", GetTime() - Time)
					end				
					
					for key, value in mod.my.states do
						mod.out.print(string.format("The state '%s' is '%s'. The last change was %s.", key, mod.out.booltostring(value.value), doformat(value.lastchange)))
					end
				end
		},
		{
			["command"] = "local",
			["description"] = "Check for localisations that are missing in your locale.",
			["output"] = mod.string.testlocalisation,
		},
	}
}

me.subclui.boss = 
{
	description = "To run these commands you must be a raid assistant or the group leader.",
	branches = 
	{
		{
			command = "report",
			description = "Make players notify you when their threat is changed by boss abilities.",
			output = mod.net.startspellreporting,
		},
		{
			command = "endreport",
			description = "Stop players reporting when their threat is changed by boss abilities.",
			output = mod.net.stopspellreporting,
		},
		{
			command = "setspell",
			description = "Change a parameter of a known boss ability.",
			
			output = function(firstvalue, allvalues)

				local value, errormessage = mod.net.checkspellvaluesyntax(allvalues)
				
				if errormessage then
					mod.out.print("|cffff8888Syntax: setspell <spellid> <bossid> <parameter> <value>")
					mod.out.print(errormessage)
					
				else
					-- set the value
					mod.net.setspellvalue(allvalues[1], allvalues[2], allvalues[3], allvalues[4])
				end
			end,
		},
		{
			command = "autotarget",
			description = "Clear the meter and set the master target automatically when you next target a world boss.",
			output = function()
				if mod.net.checkpermission() then
					mod.boss.starttrigger("autotarget")
					mod.out.print(mod.string.get("print", "boss", "autotargetstart"))
				end
			end,
		},
	}
}

me.clui =
{
	--["RootString"] = <a string>. Gets filled in at RunTime - KLHTM_ConsoleUIStartup()
	["description"] = nil,
	["branches"] = 
	{
		{
			["command"] = "test",
			["description"] = "A set of debugging commands.",
			["output"] = me.subclui.test
		},
		{
			["command"] = "gui",
			["description"] = "Commands to show the window.",
			["output"] = me.subclui.gui
		},
		{
			["command"] = "version",
			["description"] = "Commands to check and upgrade the version of other users.",
			["output"] = me.subclui.version,
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
		},
		{
			["command"] = "mastertarget",
			["description"] = "Set or clear the Master Target.",
			["output"] = function()
				if (UnitExists("target")) then
					mod.net.sendmastertarget()
				else
					mod.net.clearmastertarget()
				end
			end
		},
		{
			["command"] = "resetraid",
			["description"] = "Reset the threat of everyone in the raid group.",
			["output"] = mod.net.clearraidthreat,
		},
		{
			["command"] = "boss",
			["description"] = "Functions to work out and set boss abilities.",
			["output"] = me.subclui.boss,
		},
	},
}

end

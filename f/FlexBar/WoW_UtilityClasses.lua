--[[ 
	
	Utility Class Version		1.02
	Command Class Version	1.03
	Timer Class Version		1.03

	Mairelon's Utility Classes
	Place me in your mod directory.
	In your XML file, load me prior to any scripts.
	
	Version checking occurs - if there is a later
	version of one of these classes alread available,
	it won't overwrite it.

	Utility_Class just provides 2 methods at the 
	moment (And isn't technically an object as there is no
	state maintained).  Echo displays a message over your
	character's head, Print displays the message in the
	chat box.
	
	Command_Class simplifies the addition of sophisticated
	slash commands.  It replaces large if-then-elseif-else-end
	constructs with a callback function system.  It also 
	encapsulates basic usage messages and limited parameter
	parsing.
	
	Timer_Class encapsulates a basic timer, capable of displaying
	end of timer messages, playing sounds or calling a callback.
	Timers can be one-shot or recurring, be paused, restarted and
	reset.
	
	Last Modified
		01/13/2005
			Fixed mac crash in Timer_Class
		01/16/2005
			added parameter checking to command class
		03/31/2005
			added ability to specify command text to command class
		02/06/2005
			Added stack class 1.0
		04/14/2005
			Fixed bug in timer class that was eating memory
		08/21/2005
			Fixed potential bug - %%qt changed to %&qt in GetParameters for consistancy
--]]
-- Class declarations

-- Utility class provides print (to the chat box) and echo (displays over your character's head).
-- Instantiate it and use the colon syntax.
-- Color is an optional argument.  You can either use one of 7 named colors
-- "red", "green", "blue", "yellow", "cyan", "magenta", "white" or
-- a table with the r, g, b values.
-- IE foo:Print("some text", {r = 1.0, g=1.0, b=.5})

-- Version 1.02 has a new table copy function.

-- Since the class is global, ensure that we have the latest version available.  If you make changes
-- to this class RENAME IT.  Do not change the interface and leave the name the same, as that 
-- can break other mods using the class.
if not Utility_Class or (not Utility_Class.version) or (Utility_Class.version < 1.02) then
	Utility_Class = {};
	Utility_Class.version = 1.02
	function Utility_Class:New ()
		local o = {}   -- create object
		setmetatable(o, self)
		self.__index = self
		return o
	end
	
	function Utility_Class:Print(msg, color)
	-- the work for these is done in get-color, otherwise it's just adding
	-- the text to the chat frame.
	if msg == nil then return end;
	local r, g, b;
		if msg == nil then return; end
		if color == nil then color = "white"; end
		r, g, b = self:GetColor(color);
		
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b);
		end
		
	end
	
	function Utility_Class:Echo(msg, color)
	-- the work for these is done in get-color, otherwise it's just adding
	-- the text to the UIERRORS frame.
	if msg == nil then return end;
	local r, g, b;
		if msg == nil then return; end
		if color == nil then color = "white"; end
		r, g, b = self:GetColor(color);
		
		UIErrorsFrame:AddMessage(msg, r, g, b, 1.0, UIERRORS_HOLD_TIME);
		
	end
	
	function Utility_Class:GetColor(color)
	-- Turn any string color into its rgb, check any table arg for
	-- being in-bounds, return the appropriate RGB values.
		if color == nil then color = self end
		if color == nil then return 1, 1, 1 end
	
		if type(color) == "string" then 
			color = Utility_Class.ColorList[string.lower(color)];
		end
		
		if type(color) == "table" then
			if color.r == nil then color.r = 0.0 end
			if color.g == nil then color.g = 0.0 end
			if color.b == nil then color.b = 0.0 end
		else
			return 1, 1, 1 
		end
	
		if color.r < 0 then color.r = 0.0 end
		if color.g < 0 then color.g = 0.0 end
		if color.b < 0 then color.g = 0.0 end
	
		if color.r > 1 then color.r = 1.0 end
		if color.g > 1 then color.g = 1.0 end
		if color.b > 1 then color.g = 1.0 end
		
		return color.r, color.g, color.b
		
	end
	
	-- Straight forward list of primary/complement colors and their r, g, b values.
	Utility_Class.ColorList = {}
	Utility_Class.ColorList["red"] = { r = 1.0, g = 0.0, b = 0.0 }
	Utility_Class.ColorList["green"] = { r = 0.0, g = 1.0, b = 0.0 }
	Utility_Class.ColorList["blue"] = { r = 0.0, g = 0.0, b = 1.0 }
	Utility_Class.ColorList["white"] = { r = 1.0, g = 1.0, b = 1.0 }
	Utility_Class.ColorList["magenta"] = { r = 1.0, g = 0.0, b = 1.0 }
	Utility_Class.ColorList["yellow"] = { r = 1.0, g = 1.0, b = 0.0 }
	Utility_Class.ColorList["cyan"] = { r = 0.0, g = 1.0, b = 1.0 }

-- Recursive table copy function.  Copies by value
	function Utility_Class:TableCopy(table1)
	local table2 = {};
	if table1 == nil then return table2 end
	local index, value
		for index, value in pairs(table1) do
		local text = index .. " "
			if type(value) == "table" then
				table2[index] = Utility_Class:TableCopy(value)
			else
				table2[index] = value
			end
		end
		return table2;
	end

end


-- Command_Class provides an easy way to handle slash commands and their associated
-- sub-commands, parameters and usage statements.
-- Instantiate a Command_Class variable with Command_Class:New(modname) instead of
-- SlashCmdList[modname] = Slash_Command_Callback.
-- After that, use :AddCommand("command", callback, "group", "usage") to add new
-- sub-commands.

-- If the command on the command line does not match one of the added commands, 
-- displayusage() will be called for the main group.  Use seperate groups to partition
-- your usage statements into manageable sets.

-- Version 1.01 - fixed error in dispatch code.
-- Version 1.02 - add parameter checking methods
-- Version 1.03 - added command text

-- Since the class is global, ensure that we have the latest version available.  If you make changes
-- to this class RENAME IT.  Do not change the interface and leave the name the same, as that 
-- can break other mods using the class.

if (not Command_Class) or (not Command_Class.version) or (Command_Class.version < 1.03) then
    Command_Class = {}
    Command_Class.version=1.03
    
--  Instantiate the new object  - for more on OO in Lua see the book
--  Programming in Lua at Lua.org.
    function Command_Class:New(modname,command)
		if (modname == nil) then return nil end
		if (command == nil) then command = "/" .. string.lower(modname) end
		local o = {}
        o.CommandList = {}
        o.UsageList = {}
		o.UsageList.n=0
        o.GroupList = {}
		o.ParamList = {}
		SlashCmdList[modname .. "COMMAND"] = function(msg) o:Dispatch(msg) end
		setglobal("SLASH_" .. modname .. "COMMAND1", command)
        setmetatable(o, self)
        self.__index = self
        return o
    end

--  This the instance method that will be assigned to the slash command.
--  this replaces the huge if/then/elseif structures common to my mods so far.    
--  msg             is the text passed to the command by the WoW environment
--  command     	is the text of the command we are looking for
--  dispatch       	is the function to call on that command.
    function Command_Class:Dispatch(msg)
    --  first, pull off the first token to compare against the command text
		if msg == nil then msg = "" end
		local token
        local firsti, lasti = string.find(msg, " ")
        if firsti then
            token = string.sub(msg, 1, firsti-1)
        else
            token = msg
        end
    -- the command function will expect the remainder of msg as an argument
        if lasti then
            msg = string.sub(msg, lasti+1)
        else
            msg = ""
        end
    -- ensure it gets the empty string rather than nil
        if msg == nil then msg = "" end;
    --  if command exists - dispatch it.
		if self.CommandList[string.lower(token)] then
			local dispatch = self.CommandList[string.lower(token)]
			dispatch(msg)
		else
		--  no match found - display the usage message.
			self:DisplayUsage()
		end
    end

--  Method to display the optional usage message attached to the command
--  if no group is specified, the main group usage is displayed.  To partition
--  large command lists, seperate them into groups and add commands to 
--  display non-main groups.
    function Command_Class:DisplayUsage(group)
    --  Simply iterate through and display the usage line for each command in group
		local util = Utility_Class:New()
        local index, usage
        if group == nil then group = "main" end
        for index, usage in ipairs(self.UsageList) do
            if self.GroupList[index] == group then
                util:Print(self.UsageList[index])
            end
        end
    end

--  Method to add commands to the recoginized command list.
--  Arguments are:
--  command:    The text we are searching for in the slash command line 
--                      (case insensitive)
--  dispatch:      The name of the function that will handle this command
--  group:           Optional (will default to main) used in display usage
--  usage           Optional (will default to command) used in display usage
    function Command_Class:AddCommand(command, dispatch, group, usage)
        self.CommandList[command]=dispatch
        if usage == nil then usage =command end
		self.UsageList.n = self.UsageList.n + 1
        self.UsageList[self.UsageList.n]=usage
        if group == nil then group = "main" end
        group = string.lower(group)
        self.GroupList[self.UsageList.n]=group
		self.ParamList[command]={}
    end

-- Method to parse msg for name=value pairs
-- handles the following types:
-- name=<number>  where <number> is any whole number
-- returns <number> in return["name"]

-- name=<number>-<number> where number1 and number2 are any whole number
-- returns a table in return["name"] containing all the numbers from
-- number1 to number 2 (inclusive)

-- name=[<number> <number> .... <number>]  where number is a whole number.
-- returns the table with all the numbers in return["name"]

-- name='<string with spaces>'  returns the arbitrary string in return["name"], all
-- characters allowed except '


	function Command_Class:GetParameters(msg)
	if msg == nil then return {} end
	-- pattern to return name=
	msg = string.gsub(msg,"\\'","%&qt")
	local pattern = "([%a_][%w_]*)="
	local index = 1
	local params = {}
		local firsti, lasti, capture = string.find(msg,pattern)
		-- while we have a name=, process the info after it.
		while capture do
			local varname=string.lower(capture)
			index = index+lasti
			firsti, lasti, capture = string.find(string.sub(msg, index),pattern)
			if not firsti then firsti=string.len(msg) else firsti=firsti-2 end
			local str = string.sub(msg,index, index+firsti)
			-- if the start is ', we have a string
			if string.sub(str,1,1) == "'" then
				local location = string.find(string.sub(str,2),"'")
				if location and (location>1) then
					params[varname]=string.gsub(string.sub(str,2,location),"%&qt","'")
				end
			-- we have a table
			elseif string.sub(str,1,1) == "[" then
				local table1={}
				local element
				local index = 1
				for element in string.gfind(str,"'([^']+)'") do
					table1[index] = string.gsub(element,"%&qt","'")
					index = index+1
				end
				if not (index > 1) then
				-- no strings in table - look for numbers
					for element in string.gfind(str,"([-]?%d+)") do
						table1[index] = element+0
						index = index+1
					end
				end
				if index > 1 then
					params[varname] = table1
				end
			-- we have a range of values
			elseif string.find(str,"([-]?%d+)-([-]?%d+)") then
				local firsti, lasti, startrange, endrange = string.find(str,"([-]?%d+)-([-]?%d+)")
				local index = 1
				local table = {}
				local value;
				if firsti then
					for value = startrange+0, endrange+0 do
						table[index]=value
						index=index+1
					end
				end
				if index>1 then
					params[varname]=table
				end
			-- Not a string, range or table, so extract a number from it
			else
				local firsti, lasti, value = string.find(str,"([-]?%d+)")
				if value then
					params[varname]=value+0
				end
			end
		end
		return params
	end	
	
-- Method to add a parameter to a command for automatic checking.
-- Inputs:
-- command 	= the command this parameter is for (string)
-- param 		= the parameter name (string)
-- required	= whether the parameter is required or optional (true or nil)
-- strict		= if strict is true, error if values are not in allowed values and return false
--			= otherwise show a warning on values not in allowed range and return true
-- types		= what types are allowed for this param - needs to be a table of strings.
--			if "string" is in the table then type string is allowed
--			if "number" is in the table then type number is allowed
--			if "table" is in the table then tables are allowed BUT - if either of the
--			previous 2 are specified, only tables of that type.
--			EG 	{"string"}  allows only strings
--				{"number"} allows only numbers
--				{"table"} allows only tables (no restriction on contents)
--				{"string" "table"} allows strings or tables of strings
--				{"number" "table"} allows numbers or tables of numbers
--				{"number" "string" "table"} allows  any value my command class can parse,
--				equivalent to {} or nil
-- allowed		Values that are allowed for this parameter.  Must be a table.
--			if lowerbound or upperbound are set, it will check numeric values against them:
--			eg { lowerbound=5, upperbound=10 } will only allow values that are >= 5 and <=10
--			but will be ignored if the value is non-numeric.  Enforce that with types
--			if lowerbound and upperbound are both omitted, it is simply a list of allowed values
--			eg { 'true', 'false' } will only allow those 2 strings and IS case sensitive
-- default		default value to assign in the case this item is optional and nil

	function Command_Class:AddParam(command, param, required, strict, types, allowed, default)
		if not self.CommandList[command] then return end
		self.ParamList[command][param] = {}
		local p = self.ParamList[command][param]
		
		p["required"] = required
		p["strict"] = strict
		p["types"] = types
		p["default"] = default
		p["allowed"] = allowed
	end

-- Method to actually verify the params against the paramlist
-- return true if they are valid, false otherwise
	function Command_Class:CheckParameters(command, args)
		local util = Utility_Class:New()
		local plist = self.ParamList[command]
		local index, param
		-- first check for existence.  If required and nil, raise error
		-- if optional and nil assign default value
		for index, param in pairs(plist) do
			if not args[index] and param["required"] then
				util:Print("Error: " .. index .. " is required")
				return false
			elseif not args[index] and not param["required"] then
				args[index] = param["default"]
			end
			
			-- next - check types
			if param["types"] and args[index] then
				local types={}	-- used to simplify type checking
				local index2
				for index2=1,3 do
					if param["types"][index2] then
						types[param["types"][index2]]=true
					end
				end
				
				-- basic type checking 
				if not types[type(args[index])] then 
					util:Print("Error: " .. index .. " type mismatch " .. type(args[index]) .. " not allowed")
					return false
				end
				
				-- if the argument was a table, and tables are allowed then check each value in the table.
				-- since tables of tables will not be parsed by Command_Class we can explicitly check one level down
				-- without needing recursion
				if type(args[index]) == "table" then
					local index3, value
					for index3, value in ipairs(args[index]) do
						if not types[type(value)] then 
							util:Print("Error: " .. index .. " type mismatch " .. type(value) .. " not allowed")
							return false
						end
					end
				end
			end

			-- if allowed values were specified, check against them
			if param["allowed"] and (args[index]) then
				local vals = param["allowed"]
				-- first, check for lower and upper bounds
				if vals.lowerbound or vals.upperbound then
					-- simple bounds checking for non-table types
					if type(args[index]) == "number" then
						if vals.lowerbound and args[index] < vals.lowerbound then 
							if param["strict"] then
								util:Print("Error: " .. index .. " must be higher than (or equal to)" .. vals.lowerbound)
							else
								util:Print("Warning: " .. index .. " should be higher than (or equal to)" .. vals.lowerbound)
							end
						elseif  vals.upperbound and args[index] > vals.upperbound then
							if param["strict"] then
								util:Print("Error: " .. index .. " must be lower than (or equal to)" .. vals.upperbound)
								return false
							else
								util:Print("Warning: " .. index .. " should be lower than (or equal to) " .. vals.upperbound) 
							end
						end
					-- bounds checking for each individual value for table types
					elseif (type(args[index]) == "table" and type(args[index][1]) == "number") then
						local index5, value
						for index5, value in ipairs(args[index]) do
							if vals.lowerbound and value < vals.lowerbound then 
								if param["strict"] then
									util:Print("Error: " .. index .. " must be higher than (or equal to)" .. vals.lowerbound)
								else
									util:Print("Warning: " .. index .. " should be higher than (or equal to)" .. vals.lowerbound)
								end
							elseif  vals.upperbound and value > vals.upperbound then
								if param["strict"] then
									util:Print("Error: " .. index .. " must be lower than (or equal to)" .. vals.upperbound)
									return false
								else
									util:Print("Warning: " .. index .. " should be lower than (or equal to) " .. vals.upperbound) 
								end
							end
						end
					end
				else
					-- without bounds, we just check against each individual element of allowed
					local valid = false
					-- check arg against each element in allowed
					if type(args[index]) ~= "table" then
						local index6, allowedvalue
						for index6, allowedvalue in ipairs(vals) do
							if args[index] == allowedvalue then
								valid = true
							end
						end
					else
					-- if it's a table, we compare each element of the table against the elements of allowed
						local index7, value						
						for index7, value in ipairs(args[index]) do
							local index6, allowedvalue
							for index6, allowedvalue in ipairs(vals) do
								if value == allowedvalue then
									valid = true
								end
							end
						end
					end
					if (not valid) and param["strict"] then
						util:Print("Error: " .. index .. " not in range of allowed values")
						return false
					elseif (not valid) then
						util:Print("Warning: " .. index .. " has an unrecognized value -- errors may result")
					end
				end
			end
		end
		return true
	end
end

-- A simple timer class.  Timers can be one shot or recurring, they can be paused, reset and restarted
-- Timers can echo a message over head, play a sound file or execute a function at the end of their
-- run

-- Version 1.01 fixed Mac crash.
-- Version 1.03 altered code so the timer is disposed of at the end of it's run

-- Since the class is global, ensure that we have the latest version available.  If you make changes
-- to this class RENAME IT.  Do not change the interface and leave the name the same, as that 
-- can break other mods using the class.

if (not Timer_Class) or (not Timer_Class.version) or (Timer_Class.version < 1.03) then
    Timer_Class = {}
    Timer_Class.version=1.03
	Timer_Class.Util = Utility_Class:New()
-- Create a new timer.  Arguments are:
-- duration	How long (in seconds) the timer should run)
-- recurring	Whether the timer should reset after finishing
-- message	What message to display overhead at the end of the timer
-- sound		Soundfile to play at the end of the timer*****
--		****	The soundfile MUST be in your World of Warcraft/Data directory BEFORE UI load
-- callback	A function to be called at the end of the timer.

-- Duration must exist and be non-negative, or it returns nil
-- at least one of message, sound, callback must be non-nil
-- the timer defaults to running.  If you need it paused, call timer:Pause() after creating it.

	function Timer_Class:New (duration, recurring, message, sound, callback)
		if duration == nil or type(duration) ~= "number" or duration < 0 then return nil end
		if message == nil and sound == nil and callback == nil then return nil end
--		if message == nil then message = ""; end
--		if sound == nil then sound = ""; end
--		if callback == nil then callback = function() end end
		local o = {}   -- create object
		setmetatable(o, self)
		self.__index = self
		o.duration = duration
		o.message = message
		o.recurring = recurring
		o.sound = sound
		o.callback = callback
		o.running = true
		o.currenttime = o.duration
		return o
	end
	
-- Method to call in the mod's OnUpdate function.  Pass OnUpdate's arg1 to the method.
-- The timer is disposed of when it finishes it's run

	function Timer_Class:Update(elapsed)
		if self.running then
			self.currenttime = self.currenttime - elapsed
			if self.currenttime <= 0 then
				if self.recurring then
					self.currenttime = self.duration
				else
					self.running = false
				end
				if self.message then Timer_Class.Util:Echo(self.message) end
				if self.sound then PlaySoundFile(self.sound) end
				if self.callback then self.callback() end
			end
		end
	end	

-- Helper methods to pause a running timer, start a paused timer and reset the timer.	
	function Timer_Class:Pause()
		self.running = nil
	end
	
	function Timer_Class:Start()
		self.running = true;
	end
	
	function Timer_Class:Reset()
		self.currenttime = self.duration
	end

-- Helper methods to return time currently left on the timer, max duration and running state.
	function Timer_Class:GetTimeLeft()
		return self.currenttime;
	end
	
	function Timer_Class:GetDuration()
		return self.duration
	end
	
	function Timer_Class:GetRunning()
		if self.running then return true else return false end
	end
end


-- A simple Stack class.  

-- Since the class is global, ensure that we have the latest version available.  If you make changes
-- to this class RENAME IT.  Do not change the interface and leave the name the same, as that 
-- can break other mods using the class.

if (not Stack_Class) or (not Stack_Class.version) or (Stack_Class.version < 1.02) then
    Stack_Class = {}
    Stack_Class.version=1.02

	function Stack_Class:New ()
		local o = {}   -- create object
		setmetatable(o, self)
		self.__index = self
		o.n = 0
		return o
	end
	
	function Stack_Class:IsEmpty()
		if self.n == 0 then
			return true
		else
			return false
		end
	end
	
	function Stack_Class:Top()
		if not self:IsEmpty() then
			return self[self.n]
		else
			return nil
		end
	end
	
	function Stack_Class:Pop()
		if not self:IsEmpty() then
			local value = self:Top()
			self.n = self.n - 1
			return value
		else
			return nil
		end
	end
	
	function Stack_Class:Push(value)
		if value ~= nil then
			self.n = self.n + 1
			self[self.n] = value
		end
	end
end

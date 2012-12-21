
-- Add the module to the tree
local mod = klhtm
local me = {}
mod.regex = me

--[[
Regex.lua

The Regex module converts printing formatted strings to parsing formatted strings, in a locale independent way.

e.g.
"Your %s hits %s for %d." -> {"Your (.+) hits (.+) for (%d+)%.", {1, 2, 3}}
"Le %$3s de %$2s vous fait gagner %$1d points de vie." -> {"Le (.+) de (.+) vous fait gagner (%d+) points de vie%.", {3, 2, 1}}

First a bit of background. We want to be able to read the combat log on all clients, whether the language is english or french or chinese or otherwise. Furthermore, we don't want to rely on localisers working out the parser strings manually, because there is a likelihood of human error, and it would take too long to get a new string added.

Fortunately, we have all the information we need (at runtime, at least). For instance, in the example above, the value of the format string is given in the variable SPELLLOGSELFOTHER. If you open the GlobalStrings.lua (may need the WoW interface extractor to see it), on english clients you will see
...
SPELLLOGSELFOTHER = "Your %s hits %s for %d."
...
and on french clients you will see
...
SPELLLOGSELFOTHER = "Le %$3s de %$2s vous fait gagner %$1d points de vie."
...
When the WoW client is printing to the combat log, it will run a command like
ChatFrame2:AddMessage(string.format(SPELLLOGSELFOTHER, "Mortal Strike", "Mottled Boar", 352))

So, at Runtime (that is, when the addon loads, but not when i am writing it - i only have the english values) the mod has access to all the printing string format variables, like SPELLLOGSELFOTHER. We have a list of all the important ones, for all the abilities that the mod needs, so we want to make a big parser to scan them all at runtime. So the first thing we do when the addon loads is create all these parsers, then use them for all our combat log parsing.

------------------------------------------------------------

Structures:

1) Small Parser:

	local parser = 
	{
		["formatstring"] = formatstring,			"You hit %s for %s."
		["regexstring"] = regexstring,			"You hit (.+) for (.+)%."
		numarguments = me.numarguments,			2
		ordering = me.ordering,						{1, 2}
		argtypes = me.types,							{"string", "number"}
	}
	Note that the values of <argtypes> matches the canonical ordering (1, 2, 3, ...), not the localised ordering
	as in <ordering>.

2) Big Parser:

	local value = 
	{
		["parser"] = parser,							a <Small Parser> structure
		["globalstring"] = globalstringname,	COMBATHITSELFOTHER
		["identifier"] = identifier,				"whiteattackhit"
	}

3) Parser Set:

	First level is a key-value list. The keys are event names, e.g. "CHAT_MSG_SPELL_SELF_BUFF". 
	The values are ordered lists of <Big Parser>s.

4) Parser Output:

	local output = 
	{
		hit = <flag. Nil or non-nil>,
		temp = { },								list of up to 4 values, the captures with localised ordering
		final = { },							list of up to 4 values, the captures with canonical ordering
	}
	
	The idea is to reuse the <Parser Output> structure, so the flag <hit> just records whether the last parse
	succeeded (non-nil for success). It is assumed that all parse strings have at most 4 arguments.

5) BigParser Output:

	same as <Parser Output>, but has the property <parser>, which is a <BigParser> structure.
]]

--[[
------------------------------------------------------------------------------
			Section A: Parsing a String With the Parser Engine
------------------------------------------------------------------------------
]]

-- this is returned from all calls to mod.regex.parse().
me.output = 
{
	hit = nil,
	temp = { },
	final = { },
	parser = nil,
}

--[[
mod.regex.parse(inputstring, event)
Given a string, checks whether it matches any parser in the engine. The return value is a <BigParser Output>
structure.
<inputstring> is e.g. a line from your combat log to be parsed.
<event> is the event the string was received on, e.g. "CHAT_MSG_SPELL_SELF_BUFF"
]]
me.parse = function(parserset, inputstring, event)

	-- 0) Reset output
	me.output.hit = nil

	-- 1) Check that the event is handled by the parser
	local parsersubset = parserset[event]
	if parsersubset == nil then
		return me.output
	end
	
	-- 2) Look for a parser
	local x, bigparser, y, parser
	
	for x, bigparser in parsersubset do
		parser = bigparser.parser
		
		if me.parsestring(parser, inputstring, me.output) then
			me.output.parser = bigparser
			
			-- verify numeric arguments
			for y = 1, parser.numarguments do
				if (parser.argtypes[y] == "number") and (tonumber(me.output.final[y]) == nil) then
					
					-- error occur!
					if mod.out.checktrace("error", me, "regex") then
						mod.out.printtrace(string.format("The value |cffffff00%s|r of argument %d is not a number as it should be! Parser = %s, format string = %s. Event = %s, string = %s.", me.output.final[y], y, bigparser.identifier, parser.formatstring, event, inputstring))
					end
					
					break
				end
			end
			
			return me.output
		end
	end

	-- 3) No hit - oh well!
	return me.output
	
end

--[[
me.parsestring(parser, string, output)
Parses a string with the specified parser. Returns non-nil if the string satisfies the parser
<parser> is a parser structure, i.e. an output of me.formattoregex().
<string> is the string to parse, e.g. a combat log line.
<output> is a structure to store the output. It must have .temp and .final properties which are lists.
]]
me.parsestring = function(parser, inputstring, output)

	_, output.hit, output.temp[1], output.temp[2], output.temp[3], output.temp[4], output.temp[5] = string.find(inputstring, parser.regexstring)
	
	-- early exit on fail
	if output.hit == nil then
		return
	end
	
	-- now reorder arguments
	local x
	
	for x = 1, parser.numarguments do
		output.final[parser.ordering[x]] = output.temp[x]
	end
	
	return true
end


--[[
------------------------------------------------------------------------------
			Section B: Creating the Parser Engine at Startup
------------------------------------------------------------------------------
]]

--[[
me.addparsestring(parserset, indentifier, globalstringname, event)
Adds a new parser to the parser set.
<parserset> is a key-value list, keyed by event names, values are a list of parsers listening to that event
<identifier> is a description of the capture, e.g. "spellcrit"
<globalstringname> is the name of the variable that holds for format pattern, e.g. "SPELLLOGHIT"
<event> is the event in which the capture comes, e.g. "CHAT_MESSAGE_SPELL_SELF_BUFF"
]]
me.addparsestring = function(parserset, identifier, globalstringname, event)

	-- if there are no parsers on this event already, create a new list
	if parserset[event] == nil then
		parserset[event] = { }
	end
	
	-- get the value of the global string variable
	local formatstring = getglobal(globalstringname)
	if formatstring == nil then
		if mod.out.checktrace("error", me, "regex") then
			mod.out.printtrace(string.format("No global string %s found. ID = %s, event = %s.", globalstringname, identifier, event))
		end
		return
	end
	
	-- convert to regex
	local parser = me.formattoregex(formatstring)
	
	if me.testparser(parser) == nil then
		if mod.out.checktrace("error", me, "regex") then
			mod.out.printtrace(string.format("parser failed on %s.", identifier))
		end
		return
	end
	
	-- This is a parser structure, i guess. A big one, call it.
	local value = 
	{
		["parser"] = parser,
		["globalstring"] = globalstringname,
		["identifier"] = identifier,
	}
	
	-- ordered insert. If there are several parsers sharing the one event, we want to order them in such a way
	-- that no parser gets blocked by another, less specific parser.
	local length, x = table.getn(parserset[event])
	
	if length == 0 then
		table.insert(parserset[event], value)
	
	else
	
		for x = 1, length do
			-- keep going until you are smaller than one of them 
			
			if me.compareregexstrings(parserset[event][x].parser, parser) == 1 then
				
				-- our string is definitely higher
				table.insert(parserset[event], x, value)
				break
				
			elseif x == length then
				table.insert(parserset[event], value)	
			end
		end	
	end
end

--[[
me.formattoregex(formatstring)
Returns a small parser structure from a print formatting string.
<formatstring> is e.g. "You hit %s for %s.".
The output describes how to convert this to a parser.
]]
me.formattoregex = function(formatstring)

	--[[
	gsub replaces all occurences of the first string with the second string.
	[%.%(%)] means all occurences of . or ( or )
	%%%1 means replace these with a % and then itself.
	We're replacing them now so they don't interfere with the next bit.
	]]
	local regexstring = string.gsub(formatstring, "([%.%(%)])", "%%%1")
	
	--[[
	Formatting blocks have two types. If they arguments are in the same order as the english, the patterns
	will look like "%s   %s   %d %s" etc. If they have a different argument ordering, it would be e.g.
	"%3$s     %1$d     %2$s". So we need to check for both these circumstances
	]]
	
	me.numarguments = 0
	me.ordering = { }	
	me.types = { }
	
	--[[
	string.gsub will search the string regexstring, identify captures of the form "(%%(%d?)$?([sd]))", then replace
	them with the value me.gsubreplacement(<captures>). See me.gsubreplacement comments for more details.
	]]
	regexstring = string.gsub(regexstring, "(%%(%d?)$?([sd]))", me.gsubreplacement)
	
	--[[
	Adding a ^ character to the search string means that the string.find() is only allowed to match the test string 
	starting at the first character.
	]]
	regexstring = "^" .. regexstring
	
	local parser = 
	{
		["formatstring"] = formatstring,
		["regexstring"] = regexstring,
		numarguments = me.numarguments,
		ordering = me.ordering,
		argtypes = me.types,
	}
	
	return parser
	
end

-- set in me.formattoregex:
-- me.numarguments = 0 
-- me.ordering = { }
-- me.types = { }

--[[
The round brackets in the format string "(%%(%d?)$?([sd]))" denote captures. They will be sent to the 
replacement function as arguments. Their order is the order of the open brackets. So the first argument 
is the entire string, e.g. "%3$s" or "%s", the second argument is the index, if supplied, e.g. "3" or nil,
and the third argument is "s" or "d", i.e. whether the print format is a string or an integer.
]]
me.gsubreplacement = function(totalstring, index, formattype)

	me.numarguments = me.numarguments + 1
	
	-- set the index for strings that don't supply them by default (when ordering is 1, 2, 3, ...)
	index = tonumber(index)
	
	if index == nil then
		index = me.numarguments
	end
	
	table.insert(me.ordering, index)

	-- the return value is the actual replacement
	if formattype == "d" then
		me.types[index] = "number"
		return "(%d+)"
	else
		me.types[index] = "string"
		return "(.+)"
	end
	
end

--[[
me.compareregexstrings(regex1, regex2)
We are given two strings, and we want to know in which order to check them. e.g.
(1) "You gain (%d+) health from (.+)%." vs
(2) "You gain (%d+) (.+) from (.+)%."
In this case we should check for (1) first, then (2). To be more specific,
	1) If one pattern goes to a capture and another goes to text, due the text first.
	2) If both of them go to different texts, put the guy with the most captures first. Otherwise, the longest guy.
	3) If both go to captures of differnt types, then don't worry.
	
return values:
-1: regex1 first
+1: regex2 first

Where possible, prefer to return -1.
]]
me.compareregexstrings = function(parser1, parser2)

	local regex1, regex2 = parser1.regexstring, parser2.regexstring
	local start1, start2 = 1, 1
	local token1, token2
		
	while true do
	
		token1 = me.getnexttoken(regex1, start1)
		token2 = me.getnexttoken(regex2, start2)

		-- check for end of strings
		if token2 == nil then
			return -1
		elseif token1 == nil then
			return 1
		end
		
		-- check for equal (so far)
		if token1 == token2 then
			start1 = start1 + string.len(token1)
			start2 = start2 + string.len(token2)
		else
			break
		end
		
	end
	
	-- to get there, they have arrived at different tokens, therefore they must be orderable
		
	if string.len(token1) > 2 then
		-- regex1 is at a capture
			
		if string.len(token2) > 2 then
			-- regex2 is at a capture
	
			-- they are different, so one is a number, one a string, so who cares
			return -1
		
		else
		
			-- prefer the non-capture first
			return 1
		end
		
	else
		-- regex1 is not at a capture
		
		if string.len(token2) > 2 then
			-- regex2 at a capture
			return -1
			
		else
			
			if string.find(string.sub(regex2, start2), string.sub(regex1, start1)) then
				return 1
			end
			
			if true then
				return -1
			end
			
			-- neither at a capture
			if parser1.numarguments < parser2.numarguments then
				return 1
				
			elseif parser1.numarguments > parser2.numarguments then
				return -1
				
			elseif string.len(regex1) >= string.len(regex2) then
				return -1
				
			else
				return 1
			end
		end
	end
		
end

--[[
me.getnexttoken(regex, start)
Returns the next regex token in a string.
<regex> is the regex string, e.g. "hello (.+)%." .
<start> is the 1-based index of the string to start from.
Tokens are captures, e.g. "(.+)" or "(%d+)", or escaped characters, e.g. "%." or "%(", or normal letters, e.g. "a", ",".
]]
me.getnexttoken = function(regex, start)

	if start > string.len(regex) then
		return nil
	end
	
	local char = string.sub(regex, start, start)
	
	if char == "%" then
		return string.sub(regex, start, start + 1)
		
	elseif char == "(" then
		char = string.sub(regex, start + 1, start + 1)
		
		if char == "%" then
			return string.sub(regex, start, start + 4)
			
		else
			return string.sub(regex, start, start + 3)
		end
	
	else
		return char
	end

end

--[[
------------------------------------------------------------------------------
				Section C: Testing the Regex System
------------------------------------------------------------------------------
]]

--[[
mod.regex.test()
Checks that the parsers created from print format strings are working correctly, over a range of tough strings.
Will print out the results.
]]
me.test = function()

	strings = {"%3$s vous fait gagner %1$d %2$s.", "Votre %4$s inflige %2$d points de degats de %3$s a %1$s.", 
			   "Vous utilisez %s sur votre %s."}
			
	for x = 1, table.getn(strings) do
		if me.testformatstring(strings[x]) == nil then
			mod.out.print(string.format("test failed on string %d, '%s'.", x, strings[x]))
			return
		end
	end
	
	mod.out.print(string.format("all %d strings passed their tests.", table.getn(strings)))

end

--[[
me.testformatstring(value)
Given a print formatting string, creates a parser for that string, and checks that the parser works correctly.
<value> is e.g. "You hit %s for %s."
Returns: non-nil if the test succeeds.
]]
me.testformatstring = function(value)

	local parser = me.formattoregex(value)
	
	-- debug a bit
	mod.out.print(string.format("Format string = |cffffff00%s|r, regex string = |cffffff00%s|r, numargs = |cffffff00%d|r.",	parser.formatstring, parser.regexstring, parser.numarguments))
	
	return me.testparser(parser)

end

--[[
me.testparser(parser, debug)
Verifies experimentally that a parser matches its print format string.
<parser> is a <Small Parser> structure.
<debug> is a flag, if non-nil come debugging will be printed.
Returns: non-nil if the test succeeds.
The method generates a random string that could be made from <parser>'s format string, then parses it with the
parser, and checks that the captured values match the original arguments.
]]
me.testparser = function(parser, debug)

	-- 1) Generate a random string that matches the format
	local arguments = { }
	local x
	
	for x = 1, parser.numarguments do 
		if parser.argtypes[parser.ordering[x]] == "string" then
			arguments[parser.ordering[x]] = me.generaterandomstring()
		else
			arguments[parser.ordering[x]] = math.random(1000)
		end
	end
	
	-- debug print
	if debug then 
		for x = 1, parser.numarguments do
			if arguments[x] == nil then
				mod.out.print("arg " .. x .. " is nil!")
				return
			end
			
			mod.out.print("arg" .. x .. " = " .. arguments[x])
		end
	end
	
	local randomstring = string.format(parser.formatstring, unpack(arguments))
	
	-- debug print
	if debug then
		mod.out.print("the test string = " .. randomstring)
	end
	
	-- try parse
	local output = 
	{
		temp = { },
		final = { },
	}
	
	if me.parsestring(parser, randomstring, output) == nil then
		mod.out.print("The string did not parse.")
		return nil
		
	else
	
		-- debug print
		if debug then
			for x = 1, parser.numarguments do
				mod.out.print("output" .. x .. " = " .. output.final[x])
			end 
		end
		
		return true
	end

end

--[[
Generates a random string of capital letters and spaces. Will look something like "AJ WFDSO ECL SFOE".
]]
me.generaterandomstring = function()

	local length = 10 + math.random(10)
	local x
	local value = ""
	
	for x = 1, length do
		if math.random(3) == 3 then
			value = value .. " "
		else
			value = value .. string.format("%c", 64 + math.random(26))
		end
	end
	
	return value
end

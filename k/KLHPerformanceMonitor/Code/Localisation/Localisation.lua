
--[[
Localisation for KLHThreatMeter.

The structure for localisation is probably a bit different to most mods. There is no long list of constants called
KLHTM_COMBAT_RAZORGORE_PHASE2 or similar, because it looks silly, and is hard to debug.

All the strings are stored in multi-layered table with related strings. The names of spells are in one subtable,
the names of talents in another. Some tables contain subtables. 

The highest level of the tree is keyed by your localisation - "enUS" or "frFR" etc (these are the return values of
GetLocale()). A small subset of the tree is

me.data = 
{
	["enUS"] = 
	{
		["spell"] = 
		{
			["cower"] = "Cower",
		}
	},
	["frFR"] = 
	{
		["spell"] = 
		{
			["cower"] = "Effrayer une b\195\170te",
		},
	},
}
	
To get the localised name of the spell Cower, call the function 
	mod.string.get("spell", "cower")

The table mod.string.data is an empty table defined below; each localisation file adds their own subtable.
]]

-- table setup
local mod = thismod
local me = { }
mod.string = me

me.data = {}
me.mylocale = GetLocale()

-- This holds the arguments to the method me.get(). We want to store them in a table, but don't want to
-- recreate the table whenever the method is called, because excessive heap memory will be used.
me.stringkeys = { "1", "2", "3", "4", "5" }

--[[ 
Returns a localised string for the keys <key1>, <key2>, ...
If there is no string for your localisation, it will return the English version and print to trace with "LocalNoOverride".
If there is no english version either, it will return "." and print to trace with "LocalInvalidKey".
]]
me.get = function(key1, key2, key3, key4, key5)
	
	-- Load arguments
	me.stringkeys[1] = key1
	me.stringkeys[2] = key2
	me.stringkeys[3] = key3
	me.stringkeys[4] = key4
	me.stringkeys[5] = key5
	
	-- Try to find a localised version
	local stringvalue = me.getinternal(me.mylocale)
	
	if stringvalue == nil then
		
		-- No value was found. It's likely that your localisation has not been completely updated.
		-- This is probably a non-essential string, so the English version will do
		
		stringvalue = me.getinternal("enUS")
			
		if stringvalue == nil then
			-- No string in the english version either. The keys must have been wrong.
			
			mod.out.printtrace("localinvalidkey", string.format("The localisation identifier |cffffff00%s|r does not exist.", me.keysettostring()))
			stringvalue = "."
		
		else
			
			-- Found the english version. Use it this time. 
			mod.out.printtrace("localnooverride", string.format("The |cffffff00%s|r locale has no value for the key |cffffff00%s|r.", me.mylocale, me.keysettostring()))
			return stringvalue
		end
	end
		
	return stringvalue
	
end

--[[
Fetches a localisation string. Returns nil if there is no match.
<locale> is e.g. "enUS", "frFR", a return value of GetLocale().
The lookup keys for the string have already been written to the me.stringkeys array.
]]
me.getinternal = function(locale)

	local value = me.data[locale]
	local key
	
	-- Recall the format of me.stringkeys is e.g. { "print", "data", "talent" }
	
	-- The length of the array me.stringkeys is unknown. The for loop will keep going until it comes to <nil>.
	for _, key in me.stringkeys do
		
		-- "value" was obtained in the last loop. Since we are looping again, there must be another key
		-- inside, so value has to be a table object
		
		if value == nil then
			return nil
		end
		
		if type(value) ~= "table" then
			return nil
		end
		
		value = value[key]
	end
	
	return value
	
end

--[[
Prints out the keys that were requested for a localisation string. Used only when there is an error.
e.g. { "combat", "attack", "kill" } --> "combat.attack.kill"
]]
me.keysettostring = function()
	
	local message = ""

	for _, key in me.stringkeys do
		message = message .. "." .. key
	end
	
	return message
	
end

--[[
mod.string.testlocalisation(locale)
Checks your localisation for missing values (compared to enUS)
locale is "enUS" or "deDE", etc.
]]
me.testlocalisation = function(locale)

	-- default = check your own locale
	if locale == nil then
		locale = me.mylocale
	end
	
	if me.data[locale] == nil then
		mod.out.print(string.format("Sorry, there's no localisation at all for the |cffffff00%s|r locale.", locale))
		return
	end
	
	me.testlocalisationbranch(me.data["enUS"], me.data[locale], "")

end

-- return value = number of errors
-- linkstring = current table identifier, e.g. "print.combat."
me.testlocalisationbranch = function(english, mine, linkstring)

	local key
	local value
	local errors = 0
	
	-- check for missing values in our locale
	for key, value in english do
		
		if mine[key] == nil then
			if type(value) == "table" then
				mod.out.print(string.format("Missing the set of keys |cffffff00%s%s|r.", linkstring, key))
				errors = errors + 1
			else
				mod.out.print(string.format("Missing the key |cffffff00%s%s|r. The english value is |cff3333ff%s|r", linkstring, key, value))
				errors = errors + 1
			end
			
		else
			-- recurse to subtables
			if type(value) == "table" then
				errors = errors + me.testlocalisationbranch(value, mine[key], linkstring .. key .. ".")
			end
		end
	end
	
	-- check for unused values (in the english)
	for key, value in mine do
		
		if english[key] == nil then
			if type(value) == "table" then
				mod.out.print(string.format("The set of keys |cffffff00%s%s|r does not exist in the english version, so is probably no longer used.", linkstring, key))
				errors = errors + 1
			else
				mod.out.print(string.format("The key |cffffff00%s%s|r does not exist in the english version, so is probably no longer used. The current value is |cff3333ff%s|r", linkstring, key, value))
				errors = errors + 1
			end
		end
	end
	
	-- print out total errors (base case only)
	if linkstring == "" then
		mod.out.print(string.format("Found |cffffff00%d|r errors in total.", errors))
	end
	
	return errors
end
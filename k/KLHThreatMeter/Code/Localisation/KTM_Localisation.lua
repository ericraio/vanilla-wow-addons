
--[[
Localisation for KLHThreatMeter.

The structure for localisation is probably a bit different to most mods. There is no long list of constants called KLHTM_COMBAT_RAZORGORE_PHASE2 or similar, because it looks silly, and is hard to debug, not to mention type.

All the strings are stored in multi-layered table with related strings. The names of spells are in one subtable,
the names of talents in another. Some tables contain subtables. 

The highest level of the tree is keyed by your localisation - "enUS" or "frFR" etc (these are the return values of GetLocale()). A small subset of the tree is

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
			["cower"] = "D\195\169robade",
		},
	},
}
	
To get the localised name of the spell Cower, call the function 
	mod.string.get("spell", "cower")

The table mod.string.data is an empty table defined below; each localisation file adds their own subtable.
]]

-- Add the module to the tree
local mod = klhtm
local me = {}
mod.string = me

-- Special onload method called from Core.lua
me.onload = function()
	
	me.createreverselookup(me.data[me.mylocale], me.reverselookup, "klhtm.string.data." .. me.mylocale )
	
	-- set up key binding variables
	BINDING_HEADER_KLHTM = "KLHThreatMeter"
	
	BINDING_NAME_KLHTM_HIDESHOW = me.get("binding", "hideshow")
	BINDING_NAME_KLHTM_STOP = me.get("binding", "stop")
	BINDING_NAME_KLHTM_MASTERTARGET = me.get("binding", "mastertarget")
	BINDING_NAME_KLHTM_RESETRAID = me.get("binding", "resetraid")
	
end

--[[
	Often we could like to unlocalise the name of a spell or mob. It is much easier to work with an internal representation such as "sunder" than the value mod.string.get("spell", "sunder") all the time.
	The table me.reverselookup is where we will store the unlocalisation. Before run time, it will just list all the parts of the localisation tree that we want to unlocalise. e.g. "spell = true", indicates that we want to "spell" section to have a reverse lookup.
	To get a lookup for deeper parts of the localisation tree, just duplicate the tree until you reach the set you want.
]]
me.reverselookup = 
{
	spell = true,
	boss = 
	{
		name = true,
		spell = true,
	},
}

--[[
me.createreverselookup(localtree, reversetree, parentkey)
	Fills in the lookup tree (initially me.reverselookup) with a key-value list, where the key is the localised string and the value is the internal identifier.
	The method is recursive, if it encounters a subtable it will call itself on that table.
]]
me.createreverselookup = function(localtree, reversetree, parentkey)

	local key, value, localtable, reversetable, key2, value2
	
	for key, value in reversetree do
		
		-- check that your localisation has <key> defined
		localtable = localtree[key]
		
		if localtable == nil then
			if mod.out.checktrace("warning", me, "lookup") then
				mod.out.printtrace(string.format("Can't complete the localisation reverse lookup because the strings for %s.%s haven't been localised!", parentkey, key))
			end
		elseif type(value) == "table" then
			me.createreverselookup(localtree[key], value, parentkey .. "." .. key)
			
		else
			reversetable = { }
			localtable = localtree[key]
			
			for key2, value2 in localtable do
				reversetable[value2] = key2
			end
			
			reversetree[key] = reversetable
		end
	end
	
end

--[[
mod.string.unlocalise(key1, key2, [key3, key4, key5])
	Gets the internal name for a spell or mob that has a localisation string. e.g. converts "Sunder Armor" to "sunder", but works on any locale (where "sunder" has been defined).
	The first few keys are entries in the me.reverselookup table, which specify which part of the localisation tree the lookup will work on, i.e. are you looking for a spell, or a boss' name, etc. The last key is the value you have parsed from a combat log.
Returns: the internal identifier, if it exists, otherwise nil.
]]
me.unlocalise = function(key1, key2, key3, key4, key5)

	-- Load arguments
	me.stringkeys[1] = key1
	me.stringkeys[2] = key2
	me.stringkeys[3] = key3
	me.stringkeys[4] = key4
	me.stringkeys[5] = key5
	
	local x
	local subtable = me.reverselookup
	
	for x = 1, 5 do
		if subtable[me.stringkeys[x]] == nil then
			
			--[[
				There is no such entry in the reverse lookup tree. If the key we are checking was the last key, this is fine, it just means the spell or mob is not a special one, or there is no localisation created for it.
				However if it is not the last key, then there is an internal error in the reverse lookup tree, or the keys are invalid.
			]]
			if (x == 5) or (me.stringkeys[x + 1] == nil) then
				-- this was the last key - no hit. return nil.
				return nil
			
			else
				-- error occur!
				if mod.out.checktrace("error", me, "lookup") then
					mod.out.printtrace(string.format("Localisation reverse lookup error. No subtable for %s in the keyset %s.", me.stringkeys[x], me.keysettostring()))
				end
				return nil
			end
		
		else
			subtable = subtable[me.stringkeys[x]]
			
			if type(subtable) ~= "table" then
				-- we've come to the end of the keyset and found a match, yay
				return subtable
			end
		end	
	end
	
end

me.data = {}
me.mylocale = GetLocale()

-- we want enGB to use the enUS names for spells and mobs. We don't want enGB to just default to enUS, because features would be disabled if the mod thought it was defaulting.
if me.mylocale == "enGB" then
	me.mylocale = "enUS"
end


-- This holds the arguments to the method me.get(). We want to store them in a table, but don't want to
-- recreate the table whenever the method is called, because excessive heap memory will be used.
me.stringkeys = { "1", "2", "3", "4", "5" }

--[[
mod.string.get(key1, key2, [key3, key4, key5])
	Gives the localisation string specified by the set of keys. Localisation strings are grouped into related categories in a heirarchial manner. <key1> is the highest, most general level, e.g. "print", <key2> is more specific, e.g. "network", and the other keys are more specific still, e.g. "newmttargetnil". So the method call mod.string.get("print", "network", "newmttargetnil") is a message whose english value is "Could not confirm the master target %s, because %s has no target.".
	Refer to KTM_enUS.lua for a list of all keys.
	If there is no localised version available, the mod will return the English version instead. 
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
			
			if mod.out.checktrace("error", me, "get") then
				mod.out.printtrace(string.format("The localisation identifier |cffffff00%s|r does not exist.", me.keysettostring()))
			end
			return "."
		
		else
			
			-- Found the english version. Use it this time. 
			if mod.out.checktrace("warning", me, "get") then
				mod.out.printtrace(string.format("The |cffffff00%s|r locale has no value for the key |cffffff00%s|r.", me.mylocale, me.keysettostring()))
			end
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
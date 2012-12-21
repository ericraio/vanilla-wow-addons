
local mod = klhtm
local me = { }
mod.table = me

me.mydata = { } -- personal threat table data
me.raiddata = { } -- raid's threat table data
me.raidthreatoffset = 0 -- difference between your total threat and your raid threat

me.raidclasses = { } -- list of classes by player name. e.g. { ["Kenco"] = "Warrior", }
me.raidupdatetimes = { } -- list of last update times by player, e.g. { ["Kenco"] = GetTime(), }

------------------------------------
--    Special Core.lua Methods    --
------------------------------------

me.onload = function()
	
	-- initialise me.mydata . This refers to static methods from me.string, so goes in our onload().
	me.mydata[mod.string.get("threatsource", "total")] = me.newdatastruct()
	
end

--[[
We have the list me.raiddata, key = name, value = threat. Then the list me.raidupdatetimes, key = value, name = time.
We want to remove people from raiddata who are not in the raid / party, and also to reset the threat of people who are
in the party, but who haven't updated for a while.
]]

me.lastonupdate = 0			-- value of GetTime()
me.updateinterval = 1.0		-- at most once every second
me.idlereset = 15.0			-- seconds before we reset someone's threat

me.onupdate = function()

	-- 1) check for update time
	local timenow = GetTime()
	if timenow > me.lastonupdate + me.updateinterval then
		me.lastonupdate = timenow
	else
		return
	end

	local x
	
	-- 2) Remove people who aren't in the raid group
	for x, _ in me.raiddata do
		
		if (x ~= mod.string.get("misc", "aggrogain")) and (mod.unit.isplayeringroup(x) == nil) then
			
			if mod.out.checktrace("info", me, "idleplayer") then
				mod.out.printtrace(string.format("Removing %s from the table, since he isn't in the raid group.", x))
			end
			
			me.raiddata[x] = nil
			me.raidupdatetimes[x] = nil
			
		end
	end

	-- 3) Reset inactive people
	for x, _ in me.raiddata do
		if me.raidupdatetimes[x] == nil then
			me.raidupdatetimes[x] = timenow

		elseif (timenow > me.raidupdatetimes[x] + me.idlereset) and (me.raiddata[x] ~= 0) then
			me.raiddata[x] = 0
			me.raidupdatetimes[x] = timenow
			
			if mod.out.checktrace("info", me, "idleplayer") then
				mod.out.printtrace(string.format("Resetting %s's threat, since he hasn't updated for a while.", x))
			end
		end
	end
		

end


-- to save lots of writing!
me.newdatastruct = function()
	
	return
	{
		["hits"] = 0,
		["damage"] = 0,
		["threat"] = 0,
		["rage"] = 0,
	}
	
end


-----------------------------------------------------

--[[ 
mod.table.getraidthreat()
Returns the value you would post to the raid group as your threat.
]]
me.getraidthreat = function()

	return me.mydata[mod.string.get("threatsource", "total")].threat + me.raidthreatoffset

end

--[[ 
mod.table.resetraidthreat()
Set your threat for the rest of the raid group to 0. Used for a complete threat wipe.
]]
me.resetraidthreat = function()
	
	me.raidthreatoffset = - me.mydata[mod.string.get("threatsource", "total")].threat
	
end

--[[ 
mod.table.updateplayerthreat(player, threat)
Updates a raid threat entry.
<player> is the name of the player whose threat is updated
<threat> is the new amount
TODO: add code to change aggrogain here, if player is master target???
]]
me.updateplayerthreat = function(player, threat)
	
	me.raiddata[player] = threat
	me.raidupdatetimes[player] = GetTime()

end


--[[ 
mod.table.redoraidclasses()
Checks the raid / party and finds the class of every player.
]]
me.redoraidclasses = function()
	
	local numraiders = GetNumRaidMembers()
	local class
	
	if (numraiders == 0) then
		-- we're not in a raid. check party
		
		local numparty = GetNumPartyMembers()
		
		for x = 1, numparty do
			_, class = UnitClass("party" .. x)
			me.raidclasses[UnitName("party" .. x)] = string.lower(class)
		end
		
		-- also do yourself
		me.raidclasses[UnitName("player")] = mod.my.class
		
	else -- we're in a raid
		
		local class
		local name
		
		for x = 1, numraiders do
			_, class = UnitClass("raid" .. x)
			me.raidclasses[UnitName("raid" .. x)] = string.lower(class)
		end
	end
end

--[[
mod.table.resetmytable()
Clears all the data in your personal threat table.
]]
me.resetmytable = function()
	
	-- reset raid offset
	me.raidthreatoffset = me.getraidthreat()
	
	-- clear table
	local key
	local value
	local key2
	
	for key, value in me.mydata do
		for key2 in value do
			value[key2] = 0
		end
	end
	
end

--[[ 
mod.table.resetraidtable()
Clears all the data in the raid table.
]]
me.clearraidtable = function()

	local key
	
	for key, _ in me.raiddata do
		me.raiddata[key] = nil;
	end
	
	me.raiddata[UnitName("player")] = 0

end


local mod = klhtm
local me = { }
mod.unit = me

--[[
Unit.lua

Contains helper functions for finding players and units and their properties. Most involve iterating through the raid group.
]]

--[[
mod.unit.findunitidfromname(name)
Returns the unitid of the player in your group whose name is <name>.
Only works on players or pets in your raid or party, or yourself.
Returns nil if there is no match to <name>.
]]
me.findunitidfromname = function(name)
	
	if name == UnitName("player") then
		return "player"
	end 
	
	local x
	
	if GetNumRaidMembers() > 0 then
		for x = 1, 40 do
			if UnitName("raid" .. x) == name then
				return "raid" .. x
			end
		end
		
		for x = 1, 40 do
			if UnitName("raidpet" .. x) == name then
				return "raidpet" .. x
			end
		end
		
	elseif GetNumPartyMembers() > 0 then
		for x = 1, 4 do
			if UnitName("party" .. x) == name then
				return "party" .. x
			end
		end
		
		for x = 1, 4 do
			if UnitName("partypet" .. x) == name then
				return "partypet" .. x
			end
		end
	end
	
end

--[[
mod.unit.findnearbybossname()
Searches the target of everyone in the raid group, looking for a worldboss.
Returns: the name of the worldboss, or nil.
]]
me.findnearbybossname = function()
	
	local x
	
	for x = 1, 40 do
		if UnitClassification("raid" .. x) == "worldboss" then
			return UnitName("raid" .. x)
		end
	end
	
end

--[[
mod.unit.isplayeringroup(name)
Returns: true if the player is in your group, nil otherwise
]]
me.isplayeringroup = function(name)

	-- raid group
	if GetNumRaidMembers() > 0 then
		for x = 1, 40 do
			if UnitName("raid" .. x) == name then
				return true
			end
		end
	
	-- party (check for self separately)
	elseif GetNumPartyMembers() > 0 then
		for x = 1, 4 do
			if UnitName("party" .. x) == name then
				return true
			end
		end
		
		if name == UnitName("player") then
			return true
		end
	end
	
	if name == UnitName("player") then
		return true
	end

end

--[[ 
mod.unit.isplayerofficer(playername)
Returns: true if <playername> is an officer / leader, nil otherwise.
This is for the purpose of sending "special" commands, like setting the master target.
]]
me.isplayerofficer = function(playername)

	local name
	local rank

	if GetNumRaidMembers() > 0 then
		for i = 1, 40 do
			
			name, rank = GetRaidRosterInfo(i)
			if name == playername then
				if rank > 0 then
					return true
				else
					return nil
				end
			end
		end
		
	elseif GetNumPartyMembers() > 0 then
		if UnitIsPartyLeader("player") == 1 and playername == UnitName("player") then
			return true
		else
			for i = 1, 4 do
				if UnitName("party" .. i) == playername then
					if UnitIsPartyLeader("party" .. i) == 1 then
						return true
					else
						return nil
					end
				end
			end
		end
		
	else
		return true -- single player = officer
		
	end
	
end
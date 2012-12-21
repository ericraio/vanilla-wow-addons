
local mod = klhtm
local me = { }
mod.net = me

--[[
KTM_Net.lua

This module has all the code for operating the chat channel and sending KLHTM messages on it. Note that it doesn't
deal with parsing / interpreting messages received from the chat channel - this is all done in KTM_NetIn.lua.

]]

me.channelname = ""
me.channelnumber = 0
me.source = ""

me.manualchannel = nil -- manual override

me.lastmtsender = ""	-- name of the player who sent the last mt
me.lastmtstring = ""	-- name of the last mt, as sent by the player
me.lastmttime = 0		-- time you last updated MT
me.mtrepeattime = 10.0

-- Special onupdate method from Core.lua
me.onupdate = function()
	
	me.updatethreattoraid()
	me.checkversionquery()
	me.checkadvertise()
	
	-- check to repeat mt string
	if me.lastmtsender == UnitName("player") then
		
		-- check if you are still an assistant
		if mod.unit.isplayerofficer(UnitName("player")) == nil then
			me.lastmtsender = ""
			
		elseif GetTime() > me.lastmttime + me.mtrepeattime then
			
			-- resend and reset timer
			me.lastmttime = GetTime()
			
			-- Now, was it a clear or a name?
			if me.lastmtstring == "clear" then
				
				-- temporary: only send this to new versions (or else old versions might get spammed!)
				if mod.isnewwowversion then
					me.clearmastertarget()
				end
				
			else
				-- temporary: only send this to new versions (or else old versions might get spammed!)
				if mod.isnewwowversion then
					me.sendmessage("mtpoll " .. me.lastmtstring)
				end
			end
		end
	end
end


------------------------------------------------------------------------------------------------

---------------------------------
--    Chat Channel Operation   --
---------------------------------

-- return: number, name, method
me.getchannel = function()

	local name
	local number
	local test

	-- use the current channel, if that works
	number, name = GetChannelName(me.channelname)
	
	if number > 0 then
		return number, name, me.source
	end
	
	-- Channel broken. look for oRA, CT_RA, manual set channels.
	
	-- First priority: manual override
	if me.manualchannel then
		number, name = GetChannelName(me.manualchannel)
		
		if number > 0 then
			me.channelnumber = number
			me.channelname = name
			me.source = mod.string.get("print", "network", "channel", "manual")
			return number, name, me.source
		end
	end
	
	-- Second priority: oRA
	if oRA_Core then
		test = oRA_Core:GetOpt("channel")
		
		if test then 
			number, name = GetChannelName(test)
			
			if number > 0 then
				me.channelnumber = number
				me.channelname = name
				me.source = mod.string.get("print", "network", "channel", "ora")
				return number, name, me.source
			end
		end
	end
	
	-- Third priority: CT_RA
	if CT_RA_Channel then
		number, name = GetChannelName(CT_RA_Channel)
		
		if number > 0 then
			me.channelnumber = number
			me.channelname = name
			me.source = mod.string.get("print", "network", "channel", "ctra")
			return number, name, me.source
		end
	end
	
	-- can't find it!
	return 0 
end


--[[
mod.net.sendmessage(message)
Sends a message to the KLHTM chat channel.
<message> is a string. Don't put the "KLHTM " header on it; that's what this method does.
Return: true if the mod could find the right channel, false otherwise.
]]
me.sendmessage = function(message)
	
	-- 1.12 override
	if mod.isnewwowversion then

		if GetNumRaidMembers() > 0 then
			SendAddonMessage("KLHTM", message, "RAID")
		
		elseif GetNumPartyMembers() > 0 then
			SendAddonMessage("KLHTM", message, "PARTY")
		
		else
			-- Send directly to our input handler
			mod.netin.messagein(UnitName("player"), message, 1)
		end
		
		return true
	end
	
	local channelnumber = me.getchannel()
	
	if channelnumber > 0 then
		
		-- add KLHTM header
		message = "KLHTM " .. message
		
		-- send
		SendChatMessage(message, "CHANNEL", nil, channelnumber)
		
		-- debug
		if mod.out.checktrace("info", me, "message") then
			mod.out.printtrace(string.format("Sent this message: %s.", message))
		end
		
		return true 
	
	else
	
		return false
	end
	
end


------------------------------------------------------------------------------------------------

---------------------------------
--    Special Raid Commands    --
---------------------------------

--[[ 
me.checkpermission()
Returns: non-nil iff you are allowed to send special commands (raid assistant / party leader, etc)
]]
me.checkpermission = function()

	if mod.unit.isplayerofficer(UnitName("player")) == true then
		return true
		
	else
		mod.out.print(mod.string.get("print", "network", "raidpermission"))
		return
	end
	
end
	
--[[
mod.net.clearmastertarget()
Sends a message to clear the master target. This is called from "/ktm mastertarget", or clicking the master target button
when you have no target.
]]
me.clearmastertarget = function()
	
	if me.checkpermission() == nil then
		return
	end
	
	me.sendmessage("cleartarget")
		
end

--[[
mod.net.sendmastertarget()
Sends a message to set the master target to your current target. The name of your current target, as you see it, is sent along with the command, in case someone is out of (targetting) range of your target. This is called from 
"/ktm mastertarget", or clicking the master target button when you have a target.
]]
me.sendmastertarget = function()

	if me.checkpermission() == nil then
		return
	end
	
	if UnitName("target") == nil then
		mod.out.print(mod.string.get("print", "network", "needtarget"))
		return 
	end
	
	me.sendmessage("target " .. UnitName("target"))
	
end

--[[
mod.net.clearraidthreat()
Commands everyone in the raid to reset their threat. Called when you type "/ktm resetraid" or click the "clear threat"
button on the GUI (which is not visible by default).
]]
me.clearraidthreat = function()
	
	if me.checkpermission() == nil then
		return
	end
	
	me.sendmessage("clear")
	
end

-- Commands in the Boss Section

me.startspellreporting = function()

	if me.checkpermission() == nil then
		return
	end
	
	me.sendmessage("spellstart")
		
end

me.stopspellreporting = function()
	
	if me.checkpermission() == nil then
		return
	end
	
	me.sendmessage("spellstop")

end

me.reportspelleffect = function(spellname, bossname, result, value1, value2)
	
	if result == "miss" then
		me.sendmessage(string.format("spelleffect \"%s\" \"%s\" %s", spellname, bossname, result))
		
	else
		me.sendmessage(string.format("spelleffect \"%s\" \"%s\" %s %s %s", spellname, bossname, result, value1, value2))
	end
	
end

me.setspellvalue = function(spellid, bossid, parameter, value)

	if me.checkpermission() == nil then
		return
	end
	
	me.sendmessage(string.format("spellvalue %s %s %s %s", spellid, bossid, parameter, value))

end

-- syntax: <spellid> <bossid> <parameter> <value>
--[[
	if it succeeds, it will return just the value that is set.
	if it fails, it will return nil, then the error message.
]]
me.checkspellvaluesyntax = function(allvalues)
			
	local x, spellid, bossid, parameter, value, key, message

	-- Check their first argument, <spellid>, is valid
	spellid = allvalues[1]
	if (spellid == nil) or (mod.boss.bossattacks[spellid] == nil) then
		
		message = "The argument |cffffff00" .. tostring(spellid) .. "|r does not match any boss spell id. Valid spellids are|cffffff00"
		
		for key, value in mod.boss.bossattacks do
			message = message .. " " .. key
		end

		message = message .. "|r."
		return nil, message
	end
	
	-- Check their second argument, <bossid>, is valid
	local dataset = mod.boss.bossattacks[spellid]
	
	bossid = allvalues[2]
	if (bossid == nil) or (dataset[bossid] == nil) then
		
		message = "The argument |cffffff00" .. tostring(bossid) .. "|r does not match any boss that uses the spell |cffffff00" .. mod.string.get("boss", "spell", spellid) .. "|r. Valid bossids are|cffffff00"
		
		for key, value in dataset do
			message = message .. " " .. key
		end

		message = message .. "|r."
		return nil, message
	end
	
	-- Check their third argument, <parameter>, is valid
	dataset = dataset[bossid]
	
	parameter = allvalues[3]
	if (parameter == nil) or (dataset[parameter] == nil) then
		
		message = "The argument |cffffff00" .. tostring(parameter) .. "|r does not match any parameter that can be set. Valid parameters are|cffffff00"
		
		for key, valud in dataset do
			message = message .. " " .. key
		end

		message = message .. "|r."
		return nil, message
	end
	
	-- 4th parameter is value
						
	-- multiplier / addition: need number
	if (parameter == "addition") or (parameter == "multiplier") then
		value = tonumber(allvalues[4])
		
		if value == nil then
			
			message = "The argument |cffffff00" .. tostring(allvalues[4]) .. "|r is not a number."
			return nil, message
		end
		
	elseif parameter == "ticks" then
		value = tonumber(allvalues[4])
		
		if (value == nil) or (math.floor(value) ~= value) or (value < 1) then
			
			message = "The argument |cffffff00" .. tostring(allvalues[4]) .. "|r is not a positive integer."
			return nil, message
	end
		
	elseif parameter == "effectonmiss" then
		
		if value == "true" then
			value = true
		
		elseif value == "false" then
			value = false
		
		else
			message = "The argument |cffffff00" .. tostring(allvalues[4]) .. "|r is not a boolean value."
			return nil, message
		end
		
	elseif parameter == "type" then
		
		if (value ~= "physical") or (value ~= "debuff") or (value ~= "spell") then
			
			message = "The argument |cffffff00" .. tostring(allvalues[4]) .. "|r is not one of |cffffff00 physical debuff spell|r."
			return nil, message
		end
	end
	
	-- it worked!
	return value
end


me.versionnotify = function()

	if me.checkpermission() == nil then
		return
	end
	
	me.sendmessage(string.format("version %d.%d", mod.release, mod.revision))
	mod.out.print(mod.string.get("print", "network", "upgradenote"))
	
end

me.versionquery = function()
	
	if me.checkpermission() == nil then
		return
	end
	
	-- clear the version table
	local key

	for key, _ in me.raidversions do
		table.remove(me.raidversions, key)
	end
	
	-- set the timeout for responses
	me.versionquerytimeout = GetTime() + 3
	
	-- Notify the user
	mod.out.print(mod.string.get("print", "network", "versionrequest"))
	
	-- send the message
	me.sendmessage("versionquery")
		
end

me.setraidknockbackvalue = function(value, attack)
	
	if me.checkpermission() == nil then
		return
	end
	
	if mod.boss.isknockbackdiscoveryactive == false then
		mod.out.print(mod.string.get("print", "network", "knockbackinactive"))
	else
		me.sendmessage("knockbackvalue " .. value .. " " .. attack)
	end
	
end

me.sendknockbackevent = function(enemy, ability, value)

	if (mod.boss.isknockbackdiscoveryactive == true) and (enemy == mod.boss.mastertarget) then
	
		me.sendmessage("knockaway " .. math.ceil(0.5 + mod.table.getraidthreat()))
		me.sendmessage(string.format("knockawaytext {%s, %s, %s}", enemy, ability, value))
	end
	
end

-- don't send an event if one has already been received and confirmed recently.
me.sendevent = function(event)
	
	me.sendmessage("event " .. event)
	
end

-- Version Querying Stuff. Key = release number, value = array of names
me.raidversions = { }
me.versionquerytimeout = 0 -- 0 = inactive, > 0 = active. Return value of GetTime()

me.addversionresponse = function(playername, version)

	local versionstring = tostring(version)
	
	-- ignore unless we are checking versions
	if me.versionquerytimeout > 0 then
	
		if me.raidversions[versionstring] == nil then
			me.raidversions[versionstring] = { }
		end
		
		me.raidversions[versionstring][playername] = true
	end

end


-- When we do "/ktm version query", the rest of the raid has 3 seconds to respond.
me.checkversionquery = function()
	
	if me.versionquerytimeout == 0 then
		return
	end
	
	if GetTime() > me.versionquerytimeout then
		
		-- print it out and stuff
		me.versionquerytimeout = 0
		
		local message
		local key
		local value
		local key2
		local namesfound = { }
		
		for key, value in me.raidversions do
			message = string.format(mod.string.get("print", "network", "versionrecent"), key)
			
			for key2, _ in value do
				message = message .. key2 .. ", "
				namesfound[key2] = true
			end
			
			message = message .. " }."
			mod.out.print(message)
			
			table.remove(me.raidversions, key)
		end
		
		-- Now print the people who have out of date versions
		message = mod.string.get("print", "network", "versionold")
		for key, _ in mod.table.raiddata do
			if namesfound[key] == nil and mod.unit.isplayeringroup(key) == true then
				namesfound[key] = true
				message = message .. key .. ", "
			end
		end
		
		message = message .. " }."
		mod.out.print(message)
		
		-- Now print out people who are not talking to us
		message = mod.string.get("print", "network", "versionnone")
		
		for value = 1, 40 do
			key = GetRaidRosterInfo(value)
			if (key ~= nil) and (namesfound[key] == nil) then
				namesfound[key] = true
				message = message .. key .. ", "
			end
		end
		
		message = message .. " }."
		mod.out.print(message)
		
	end
end

me.lastthreatupdate = 0 -- value of GetTime(). When we last posted our threat to the raid
me.minimumupdateinterval = 0.5 -- minimum time, in seconds, between threat updates to the raid
me.idleupdateinterval = 10.0 -- how often to update when our value is not changing
me.lastthreatvaluesent = -1 -- the name says it all, really

--[[
me.updatethreattoraid()
Posts your threat value to the KLHTM channel if necessary. You will send your threat at most once every
<me.minimumupdateinterval> = 0.5 seconds. If your threat value is unchanged, you will repeat it once every 10
seconds only. If you aren't in a party or raid, you won't repeat your value if it is constant.
]]
me.updatethreattoraid = function()
	
	local interval
	local myraidthreat
	
	if mod.my.states.incombat.value == true then
		myraidthreat = math.floor(0.5 + mod.table.getraidthreat())
	else
		myraidthreat = 0
	end
	
	if myraidthreat == me.lastthreatvaluesent then
		interval = me.idleupdateinterval
	
		-- check for solo, then no updates
		if GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then
			return
		end 
		
		-- also don't send idle updates when afk
		if mod.my.states.afk.value == true then
			return
		end
		
	else
		interval = me.minimumupdateinterval
		
	end
	
	-- check update frequency
	if GetTime() < me.lastthreatupdate + interval then
		return -- only just sent an update. Wait a bit to send the next one.
	end
	
	-- OK. Send.
	local message = "threat " .. myraidthreat
	if mod.isnewwowversion then
		message = "t " .. myraidthreat
	end
	
	if me.sendmessage(message) == nil then
		if mod.out.checktrace("warning", me, "channel") then
			mod.out.printtrace("Threat was not updated because the CTRA Channel is not set up properly.")
		end
	end
	
	me.lastthreatupdate = GetTime()
	me.lastthreatvaluesent = myraidthreat

end

--------------------------------------------------------------------------------------------------

-------------------------------------------------------
--    Advertising KLHTM to people who pull aggro!    --
-------------------------------------------------------

me.isadvertising = false
me.lastadvert = 0
me.advertinterval = 300 -- seconds

--[[
mod.net.toggleadvertise()
Switch the advertising function on or off.
]]
me.toggleadvertise = function()

	me.isadvertising = not me.isadvertising
	
	if me.isadvertising == true then
		mod.out.print(mod.string.get("print", "network", "advertisestart"))
	else
		mod.out.print(mod.string.get("print", "network", "advertisestop"))
	end

end

me.raidnumbers = { } -- {1, 2, 3, ..., 40}

for x = 1, 40 do
	me.raidnumbers[x] = x
end

--[[
me.checkadvertise()
Looks for people who have pulled aggro but don't have KLHTM, and tells them to get it. A message will be sent no more than
once every <me.advertinterval> = 5 minutes. Messages will be sent to non-warriors who are being targetted by a mob, so it's
not a complete guarantee that they have aggro.
]]
me.checkadvertise = function()

	if me.isadvertising == false then
		return
	end
	
	-- don't spam
	if GetTime() < me.lastadvert + me.advertinterval then
		return
	end

	-- look for someone who has aggro, is not a warrior, is not in the raid threat
	if GetNumRaidMembers() <= 0 then
		return
	end
	
	local target = ""
	local player = ""
	local x
	
	-- make it a random permutation of the raid, to stop bugging one person
	me.scrambleraid(me.raidnumbers)
	
	for y = 1, 40 do
		
		-- get x from scrambled array
		x = me.raidnumbers[y]
		
		-- there is a raid player
		target = "raid" .. x
		if UnitExists(target) == 1 then
			
			-- the player is targetting a mob
			target = target .. "target"
			if UnitExists(target) == 1 and UnitIsFriend("player", target) ~= 1 then
			
				-- mob has another player targetted
				player = target .. "target"
				if UnitIsFriend("player", player) == 1 then
				
					-- player is not yourself, not a warrior, is a player
					if (UnitIsPlayer(player) == 1) and (UnitName("player") ~= UnitName(player)) then
					
						local _, class = UnitClass(player)
						if class ~= "WARRIOR" then
							
							-- check they arne't using the meter
							if mod.table.raiddata[UnitName(player)] == nil then
							
								-- send them a message
								SendChatMessage(string.format(mod.string.get("print", "network", "advertisemessage"), UnitName(target)), "WHISPER", nil, UnitName(player))
								me.lastadvert = GetTime()
								return
							end
						end
					end
				end
			end
		end
	end
end

--[[
me.scrambleraid(numbers)
Slightly scrambles the array <numbers>. Picks 10 random pairs and swaps them. Since this scramble method gets called
each time we check, the array will be sufficiently inconstant all the time.
]]
me.scrambleraid = function(numbers)

	local x
	local temp
	local box1
	local box2
	
	for x = 1, 10 do
		box1 = math.random(1, 40)
		box2 = math.random(1, 40)
		
		temp = numbers[box1]
		numbers[box1] = numbers[box2]
		numbers[box2] = temp
	end
	
end					
			
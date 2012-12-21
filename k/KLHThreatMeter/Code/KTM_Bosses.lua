
local mod = klhtm
local me = {}
mod.boss = me

--[[
KTM_Bosses.lua

This module contains all the code for special boss encounters, determining who has aggro, etc.

The old functions from the old KLHTMTargetting.lua are a bit scrappy and due for a major buff in R17, as well
as the entire rest of this module, with lots more boss encounters being added.
]]

me.mastertarget = nil
me.ismtworldboss = false

me.isspellreportingactive = false
me.istrackingspells = false
me.bosstarget = ""

-- me.onload() - called by Core.lua.
me.onload = function()
	
	-- Let's create our parser!
	me.createparser()
	
end

me.myevents = { "CHAT_MSG_MONSTER_EMOTE", "CHAT_MSG_MONSTER_YELL", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "CHAT_MSG_COMBAT_HOSTILE_DEATH", }

me.onevent = function()
	
	if event == "CHAT_MSG_MONSTER_EMOTE" then
		
		if string.find(arg1, mod.string.get("boss", "speech", "razorphase2")) then
			
			-- clear threat when phase 2 starts
			mod.table.resetraidthreat()
			
			-- set the master target to Razorgore, but only if a localised version of him exists.
			local bossname = mod.string.get("boss", "name", "razorgore")
			
			if mod.string.unlocalise("boss", "name", bossname) then
				me.automastertarget(bossname)
			end
			
			return
		end
	
	elseif event == "CHAT_MSG_MONSTER_YELL" then
	
		-- Nef Phase 2
		if string.find(arg1, mod.string.get("boss", "speech", "nefphase2")) then
			
			-- reset threat in phase 2
			mod.table.resetraidthreat()
			
			-- boss name is given by the arg2
			me.automastertarget(arg2)
			
			return
		end	
	
		-- ZG Tiger boss phase 2
		if string.find(arg1, mod.string.get("boss", "speech", "thekalphase2")) then
			
			-- reset threat in phase 2
			mod.table.resetraidthreat()
			
			-- boss name is given by the arg2
			me.automastertarget(arg2)
			
			return
		end
		
		-- Rajaxx attacks
		if string.find(arg1, mod.string.get("boss", "speech", "rajaxxfinal")) then
			
			-- reset threat when he finally attacks
			mod.table.resetraidthreat()
			
			-- boss name is given by arg2
			me.automastertarget(arg2)
			
			return
		end
		
		-- Azuregos Port
		if string.find(arg1, mod.string.get("boss", "speech", "azuregosport")) then
			
			-- 1) Find Azuregos
			local bossfound = false
			
			for x = 1, 40 do
				
				if UnitClassification("raid" .. x .. "target") == "worldboss" then
					if CheckInteractDistance("raid" .. x .. "target", 4) then
						mod.table.resetraidthreat()
					end
					
					bossfound = true
					break
				end	
			end
			
			-- couldn't find anyone targetting Azuregos. Better reset just to be sure.
			if bossfound == false then
				mod.table.resetraidthreat()
			end
			
			return
		end
	
	elseif event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" then
		
		-- 1) Scan for casting pattern
		local output = mod.regex.parse(me.parserset, arg1, event)
	
		if (output.hit == nil) or (output.parser.identifier ~= "mobbuffgain") then
			return
		end
		
		-- 2) Get Boss, Spell
		local boss, spell = output.final[1], output.final[2]
		
		-- noth blink
		if spell == mod.string.get("boss", "spell", "nothblink") then
			
			-- notify the raid, if this event isn't on cooldown 
			if GetTime() < me.bossevents.nothblink.lastoccurence + me.bossevents.nothblink.cooldown then
				-- on cooldown. don't send
			else
				mod.net.sendevent("nothblink")
			end
		end
	
	elseif event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" then
		
		-- 1) Scan for casting pattern
		local output = mod.regex.parse(me.parserset, arg1, event)
	
		if (output.hit == nil) or (output.parser.identifier ~= "mobspellcast") then
			return
		end
		
		-- 2) Get Boss, Spell
		local boss, spell = output.final[1], output.final[2]
		
		-- twin teleport
		if spell == mod.string.get("boss", "spell", "twinteleport") then
			
			-- notify the raid, if this event isn't on cooldown 
			if GetTime() < me.bossevents.twinteleport.lastoccurence + me.bossevents.twinteleport.cooldown then
				-- on cooldown. don't send
			else
				mod.net.sendevent("twinteleport")
			end
				
		-- gate of shazzrah
		elseif spell == mod.string.get("boss", "spell", "shazzrahgate") then

			-- notify the raid, if this event isn't on cooldown 
			if GetTime() < me.bossevents.shazzrahgate.lastoccurence + me.bossevents.shazzrahgate.cooldown then
				-- on cooldown. don't send
			else
				mod.net.sendevent("shazzrahgate")
			end
		end
	
	elseif event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
		
		-- 1) Scan for mob death
		local output = mod.regex.parse(me.parserset, arg1, event)
	
		if (output.hit == nil) or (output.parser.identifier ~= "mobdeath") then
			return
		end
		
		local mobname = output.final[1]
		
		if (mobname == me.mastertarget) and (me.ismtworldboss == true) and (mod.net.lastmtsender == UnitName("player")) and mod.unit.isplayerofficer(UnitName("player")) then
			
			mod.net.clearmastertarget()
			me.ismtworldboss = false
		end
	
	else
		me.parsebossattack(arg1, event)
	end
	
end

--[[
me.onupdate is called by Core.lua. It currently has 3 different parts that are unrelated.
]]
me.onupdate = function()

	local key, value, key2
	
	-- 1) if we are out of combat, reset the ticks on all boss abilities that have them
	if UnitAffectingCombat("player") == nil then
		
		for key, value in me.tickcounters do
			for key2 in value do
				value[key2] = 0
			end
		end
	end
	
	-- 2) clear out all old event reports - one report but no confirmations for 1.0 seconds.
	local timenow = GetTime()
	
	for key, value in me.bossevents do
		if (value.reporter ~= "") and (timenow > value.reporttime + 1.0) then
			
			-- debug
			if mod.out.checktrace("warning", me, "event") then
				mod.out.printtrace(string.format("The event %s has not been confirmed. It was reported by %s.", key, value.reporter))
			end
			
			-- remove the report
			value.reporter = ""
		end
	end

	-- 3) spellreporting: check for target changes
	if (me.isspellreportingactive == true) and (me.istrackingspells == true) and me.mastertarget then
		
		-- 1) find mt
		local x, newtarget
		
		for x = 1, 40 do
			name = UnitName("raid" .. x .. "target")
			if name == me.mastertarget then
				
				-- get target^2
				newtarget = UnitName("raid" .. x .. "targettarget")
				
				if newtarget == nil then
					newtarget = "<none>"
				end
				
				break
			end
		end
		
		-- couldn't find the boss?
		if newtarget == nil then
			newtarget = "<unknown>"
		end
		
		-- report!
		if newtarget ~= me.bosstarget then
			
			-- find the threat of the old target
			local oldthreat = mod.table.raiddata[me.bosstarget]
			if oldthreat == nil then
				oldthreat = "?"
			end
			
			-- threat of the boss' new target
			local newthreat = mod.table.raiddata[me.bosstarget] 
			if newthreat == nil then
				newthreat = "?"
			end
			
			-- print
			mod.out.print(string.format(mod.string.get("print", "boss", "bosstargetchange"), me.mastertarget, me.bosstarget, oldthreat, newtarget, newthreat))
			
			-- update bosstarget
			me.bosstarget = newtarget
		end
	end
	
	-- 4) Check triggers
	me.checktriggers()
	
end

--[[
------------------------------------------------------------------------------------------------
					Boss Events - Sending and Receiving
------------------------------------------------------------------------------------------------

Boss Events are when a mob changes his threat against everyone after taking some action. Some players may be out of (combat log) range of the boss action, so we have nearby players report these special events to the rest of the raid.
There is a potential for abuse if someone in the raid group sends false boss event reports, which could make the raid group incorrectly reset their threat. To counter this we require two people to report the same event within a small time interval for it to be activated.
For each event in <me.bossevents>, we keep track of the person who first reported it, and the time they reported it. If the trace key "boss.fireevent" is enabled, the mod will print out who first reported the event and who confirmed it.
Insertion: players in the raid report events in the network channel, and <me.reportevent(...)> is called from the <netin> module.
Maintenance: no OnUpdate maintenance necessary.
]]

me.bossevents = { }

--[[
me.addevent(eventid, cooldown)
Defines a new event in <me.bossevents>. This is just a helper method to create <me.bossevents>. Called at file load.
<eventid> is a localisation key in the "boss"-"spell" set.
<cooldown> is the minimum time between casts, extreme lower bound. Want it large enough to avoid spams. 1 sec would probably do.
]]
me.addevent = function(eventid, cooldown)
	
	me.bossevents[eventid] = 
	{
		["cooldown"] = cooldown,
		lastoccurence = 0, 	-- GetTime()
		reporter = "",
		reporttime = 0, 	-- GetTime()
		["eventid"] = eventid,
	}
	
end

-- define all possible events. These methods are called at file read time.
me.addevent("shazzrahgate", 5.0)
me.addevent("twinteleport", 5.0)
me.addevent("wrathofragnaros", 5.0)
me.addevent("nothblink", 5.0)

--[[
mod.boss.reportevent(eventid, player)
Called when someone in the raid reports a boss event.
<eventid> is the internal name of the event.
<player> is the name of the player who reported it.
]]
me.reportevent = function(eventid, player)

	local eventdata = me.bossevents[eventid]
	local timenow = GetTime()
	
	-- ignore if the event is cooling down
	if timenow < eventdata.lastoccurence + eventdata.cooldown then
		return
	end
	
	-- has this been reported recently? If so it is now confirmed and we can run it.
	if (eventdata.reporter ~= "") and (eventdata.reporter ~= player) then
		me.fireevent(eventdata, player)
	
	-- always trust reports from yourself
	elseif player == UnitName("player") then
		me.fireevent(eventdata, player)
	
	-- some player reports a new event. wait for confirmation
	else
		eventdata.reporter = player
		eventdata.reporttime = timenow
	end

end

--[[
me.fireevent(eventdata, player)
Run when an event is confirmed. Does whatever the event does.
<eventdata> is an structure in <me.bossevents>
<player> is the name of the player who confirmed the event
]]
me.fireevent = function(eventdata, player)
	
	-- debug
	if mod.out.checktrace("info", me, "event") then
		mod.out.printtrace(string.format("The event |cffffff00%s|r has occured. It was reported by %s and confirmed by %s.", eventdata.eventid, eventdata.reporter, player))
	end
	
	-- first reset the event's timers
	eventdata.lastoccurence = GetTime()
	eventdata.reporter = ""
	
	-- now actually do the event
	if eventdata.eventid == "shazzrahgate" then
		mod.table.resetraidthreat()
		
	elseif eventdata.eventid == "twinteleport" then
		mod.table.resetraidthreat()
		
		-- activate the proximity aggro detection trigger
		me.starttrigger("twinemps")
		
	elseif eventdata.eventid == "wrathofragnaros" then
		mod.table.resetraidthreat()
	
	elseif eventdata.eventid == "nothblink" then
		mod.table.resetraidthreat()
	end
	
end

--[[
------------------------------------------------------------------------------------------------
				Triggers - Hard To Detect Events That Require Polling
------------------------------------------------------------------------------------------------

Some events have no easily defined actions such as a combat log event, and must be checked for periodically instead.
For example in the Twin Emperors encounter, after a teleport the closest person to each emperor is given a moderate amount of threat. The only way to see who received the threat is to see who the emperors target. However, after the teleport they become stunned and have no target, so we have to wait until the stun period has ended. So we make a trigger to periodically check them for new targets.
Each trigger has these properties:
<isactive>		boolean, whether the mod is checking the trigger
<startdelay>	time in seconds after the trigger is activated that the mod will start checking it.
<timeout>		time in seconds after the trigger has started that the mod should give up on it
<mystarttime>	when the most recent activation of the trigger occured.

The names and basic properties of triggers are defined in the variable <me.triggers>. This is a key-value list where the key is the internal name of the trigger, and the value is a structure with the variables described above.
To activate a trigger, call the <me.starttrigger(trigger)> function with the internal name of the trigger.
The code that will run each time a trigger is polled is contained in the variable <me.triggerfunctions>. This is a key-value list, where the key is the internal name and the value is the function that is run.
]]

me.triggers = 
{
	twinemps = 
	{
		isactive = false,
		startdelay = 0.5,
		timeout = 5.0,
		mystarttime = 0,
		data = 0,
	},
	autotarget = 
	{
		isactive = false,
		startdelay = 1.0,
		timeout = 300.0,
		mystarttime = 0,
		data = 0,
	}
}

--[[
me.starttrigger(trigger)
Activates a trigger. The mod will start periodically checking for it.
<trigger> is the mod's internal identifier of the trigger, and matches a key to me.triggers.
]]
me.starttrigger = function(trigger)
	
	-- debug check for trigger being defined. We should generalise this, since is happens in a flew different places in the mod. i.e. "badidentifierargument"
	-- maybe also some kind of flood control to stop error messages spamming onupdate.
	
	if (trigger == nil) or (me.triggers[trigger] == nil) then
		
		-- report error
		if mod.out.checktrace("error", me, "trigger") then
			mod.out.printtrace(string.format("There is no trigger |cffffff00%s|r.", trigger or "<nil>"))
		end
		
		return
	end
	
	local triggerdata = me.triggers[trigger]
	triggerdata.isactive = true
	triggerdata.mystarttime = GetTime() + triggerdata.startdelay
	triggerdata.data = 0
	
	-- debug
	if mod.out.checktrace("info", me, "trigger") then
		mod.out.printtrace(string.format("The |cffffff00%s|r trigger has been activated.", trigger))
	end
		
end

--[[
This variable gives the code that runs when an active trigger is checked. The keys are the internal names of triggers, that match keys in <me.triggers>.
The values are functions. The functions should return non-nil if the trigger is to be deactivated.
]]
me.triggerfunctions = 
{
	--[[ 
	We want to find out if we are being targetting by one of the emps. To do this we find the emperors by scanning the targets of everyone in the raid group. Then once we have an emps's target, we check whether that is us.
	It might occur that one emps' target is known but the other is not (not sure if this could happen). In this case the trigger should not end; we should keep checking until we know both targets.
	However, if one of the emps is targetting us, we can instantly give ourself threat and exit.
	The threat gained is set at 2000. This isn't confirmed, and is instead a bit of a guess.
	]]
	twinemps = function(triggerdata)
		
		local x, name, firstbossname, unitid
		local bosshits = 0
		local bosstargets = 0
		
		-- loop through everyone in the raid
		for x = 1, 40 do
			
			unitid = "raid" .. x .. "target"
			if UnitExists(unitid) and (UnitClassification(unitid) == "worldboss") then
				
				-- we've found an emperor. check if we've seen him before
				name = UnitName(unitid)
				
				if name ~= firstbossname then
					bosshits = bosshits + 1
					
					-- if this is the first boss we've seen, put his name up
					if bosshits == 1 then
						firstbossname = name
					end
					
					-- now find the player the boss is targetting
					unitid = unitid .. "target"
					
					if UnitExists(unitid) then
						bosstargets = bosstargets + 1
						
						if UnitIsUnit("player", unitid) then
							-- an emp is targetting us. give us a bit of threat.
							
							mod.combat.event.hits = 1
							mod.combat.event.threat = 2000
							mod.combat.event.damage = 0
							mod.combat.event.rage = 0
							
							mod.combat.addattacktodata(mod.string.get("threatsource", "threatwipe"), mod.combat.event)
							
							-- clear hits for total column
							mod.combat.event.hits = 0
							mod.combat.addattacktodata(mod.string.get("threatsource", "total"), mod.combat.event)
							
							-- if an emperor is targetting us, he will be the only one, and we have all the information we need, so we want the trigger to deactivate
							bosstargets = 2
							bosshits = 2
						end
					end
					
					-- if we have found 2 bosses now, there's no need to do more searching
					if bosshits == 2 then 
						break
					end
				end
			end
		end
		
		-- don't give up on the trigger until we have found both boss targets on one loop
		if bosstargets == 2 then
			return true
		end
	end,
	
	--[[
	Autotarget trigger runs when you run the command "/ktm boss autoatarget". When you next target a world boss, you will set the target and clear the meter.
	]]
	autotarget = function(triggerdata)
		
		if UnitExists("target") and (UnitClassification("target") == "worldboss") then
			
			-- found a target. now only activate if we've been targetting him for a while
			if triggerdata.data == 0 then
				triggerdata.data = GetTime()
				return
				
			else
				-- 500 ms minimum.
				if GetTime() < triggerdata.data + 0.5 then
					return
				end
			end
			
			-- found a target. Activate
			if me.mastertarget == UnitName("target") then
				
				-- someone has already set the master target to this mob. In this case don't do anything.
				mod.out.print(string.format(mod.string.get("print", "boss", "autotargetabort"), UnitName("target")))
				
			else
				mod.net.clearraidthreat()
				mod.net.sendmastertarget()
			end
			
			return true
		end	
		
	end
}

--[[
me.checktriggers()
Loops through all possible triggers, checking for active ones and running them if need be. This is called in the OnUpdate() method.
]]
me.checktriggers = function()

	local key, data
	local timenow = GetTime()
	
	for key, data in me.triggers do
		
		-- ignore inactive triggers
		if data.isactive == true then
			
			-- stop the trigger if it has timed out
			if timenow > data.mystarttime + data.timeout then
				
				data.isactive = false
				
				-- debug
				if mod.out.checktrace("warning", me, "trigger") then
					mod.out.printtrace(string.format("The trigger |cffffff00%s|r timed out.", key))
				end
				
			-- don't process the trigger if the start delay is not over
			elseif timenow < data.mystarttime then
				-- (do nothing)
				
			else
				-- ok, run a trigger check
				if me.triggerfunctions[key](data) then
					data.isactive = false
				end
			end
		end
	end
end

--[[
------------------------------------------------------------------------------------------------
			Parsing the Combat Log to Detect Boss Special Attacks and Spells
------------------------------------------------------------------------------------------------
]]

-- me.parserset = { }  -- defined in me.createparser

--[[
me.createparser()
Called from me.onload() on startup. Creates the parser engine from the constructor.
]]
me.createparser = function()
	
	me.parserset = { }
	
	local parserdata
	
	for _, parserdata in me.parserconstructor do
		mod.regex.addparsestring(me.parserset, parserdata[1], parserdata[2], parserdata[3])
	end
	
end

-- This describes all the combat log lines we are checking for
me.parserconstructor = 
{
	-- this is for school spells or debuffs
	{"magicresist", "SPELLRESISTOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"}, -- "%s's %s was resisted."

	-- these two are for school spells only
	{"spellhit", "SPELLLOGSCHOOLOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"}, -- "%s's %s hits you for %d %s damage."
	{"spellhit", "SPELLLOGCRITSCHOOLOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"}, -- "%s's %s crits you for %d %s damage."

	-- spellboth is for abilities or school spells
	{"attackabsorb", "SPELLLOGABSORBOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"}, -- "You absorb %s's %s."
		
	-- ability hit / miss only works for physical spells.
	{"abilityhit", "SPELLLOGOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"}, 		-- "%s's %s hits you for %d."
	{"abilityhit", "SPELLLOGCRITOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"},	-- "%s's %s hits you for %d."
	{"abilityhit", "SPELLBLOCKEDOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"}, 	-- "%s's %s was blocked."
	{"abilitymiss", "SPELLDODGEDOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"},	-- "%s's %s was dodged."
	{"abilitymiss", "SPELLPARRIEDOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"},	-- "%s's %s was parried."
	{"abilitymiss", "SPELLMISSOTHERSELF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"},		-- "%s's %s misses you."
	
	{"debuffstart", "AURAADDEDSELFHARMFUL", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"}, -- "You are afflicated by %s."
	
	{"mobspellcast", "SPELLCASTGOOTHER", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"},		-- "%s casts %s."
	{"mobbuffgain", "AURAADDEDOTHERHELPFUL", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"}, 		-- "%s gains %s."
	
	{"mobdeath", "UNITDIESOTHER", "CHAT_MSG_COMBAT_HOSTILE_DEATH"}, -- "%s dies."
}

me.tickcounters = { }

--[[
me.parsebossattack(message, event)

Handles a combat log line that describes a boss's attack or spell against the player.
--> Stage one is to parse the message to find which formatting pattern the message matches, e.g. "magicresist" or
"spellhit" etc, or none (then just exit).
--> Stage two is to fill in <me.action>, whch descibes the important parts of the attack, using the formatting patter and the arguments captured by the pattern.
--> Then we check whether this attack is actually a threat modifying attack. For this to be the case, there would be a localisation string whose value is the attack name, and there would be an entry in <me.bossattacks> with the same key as the localisation key.
--> Next we identify the ability w.r.t. the mob. Does the ability only come from one mob, and if so is the mob who just attacked us the right one? This involves a check in the next level of <me.bossattacks>.
--> Now we know the specific attack performed against us, and we have to work out whether it triggered. If the ability does not trigger on a miss (e.g. Knock Away), we won't do anything. If the ability only triggers after a number of ticks (Time Lapse), it will only trigger if the correct number of ticks has passed.
--> If it triggers, we just change our threat by the right amount, then report the threat change in the <combat> and <table> modules.

<message> is the combat log line.
<event> is the chat message event <message> was received on.
Returns: nothing.
]]
me.parsebossattack = function(message, event)
	
	-- stage 1: regex
	local output = mod.regex.parse(me.parserset, message, event)
	
	if output.hit == nil then
		return
	end

	-- interrupt: wrath of ragnaros
	if output.final[2] == mod.string.get("boss", "spell", "wrathofragnaros") then

		-- notify the raid, if this event isn't on cooldown 
		if GetTime() < me.bossevents.wrathofragnaros.lastoccurence + me.bossevents.wrathofragnaros.cooldown then
			-- on cooldown. don't send
		else
			mod.net.sendevent("wrathofragnaros")
		end
	end
 
	-- Set the mob and ability (always arg1 and arg2, except for debuffgain)
	if output.parser.identifier == "debuffstart" then
		me.resetaction("", output.final[1])
	else	
		me.resetaction(output.final[1], output.final[2])
	end
	
	-- set the spell and hit types
	local description = me.attackdescription[output.parser.identifier]

	if description.ishit then me.action.ishit = true end
	if description.isspell then me.action.isspell = true end
	if description.isdebuff then me.action.isdebuff = true end
	if description.isphysical then me.action.isphysical = true end
	
	-- Now, is the attack known?
	local spellid = mod.string.unlocalise("boss", "spell", me.action.ability)
	if (spellid == nil) or (me.bossattacks[spellid] == nil) then
		return
	end
	
	-- Check for a mob match
	local spelldata
	
	local mobid = mod.string.unlocalise("boss", "name", me.action.mobname)
	
	if mobid and me.bossattacks[spellid][mobid] then
		-- there is a specific version of this spell for this particular mob
		spelldata = me.bossattacks[spellid][mobid]
	
	elseif me.bossattacks[spellid].default == nil then
		-- this mob does not match any of the mobs that have the ability
		return
		
	else
		spelldata = me.bossattacks[spellid].default
	end
	
	-- Now process the spell
	
	-- 1) Does the ability activate on a miss?
	if (me.action.ishit == false) and (spelldata.effectonmiss == false) then
		
		-- ability will not activate
		if mod.out.checktrace("info", me, "attack") then
			mod.out.printtrace(string.format("%s's attack %s did not activate because it missed.", me.action.mobname, me.action.ability))
		end
		
		-- spell reporting
		if me.isspellreportingactive == true then
			mod.net.reportspelleffect(me.action.ability, me.action.mobname, "miss")
		end
		
		return
	end
	
	-- 2) Check number of ticks
	local mytickdata
	
	if spelldata.ticks ~= 1 then
		
		-- create a list if none exists yet
		if me.tickcounters[me.action.ability] == nil then
			me.tickcounters[me.action.ability] = { }
		end
		
		if me.tickcounters[me.action.ability][me.action.mobname] == nil then
			me.tickcounters[me.action.ability][me.action.mobname] = 0
		end
		
		-- create an entry if none exists so far
		me.tickcounters[me.action.ability][me.action.mobname] = me.tickcounters[me.action.ability][me.action.mobname] + 1
		
		-- now, have we gone enough ticks?	
		if me.tickcounters[me.action.ability][me.action.mobname] < spelldata.ticks then
			
			-- not enough ticks
			if mod.out.checktrace("info", me, "attack") then
				mod.out.printtrace(string.format("This is tick number %d of %s; it will activate in another %d ticks.", me.tickcounters[me.action.ability][me.action.mobname], me.action.ability, spelldata.ticks - me.tickcounters[me.action.ability][me.action.mobname]))
			end
			
			-- spell reporting
			local value1 = me.tickcounters[me.action.ability][me.action.mobname]
			local value2 = spelldata.ticks - value1
			
			if me.isspellreportingactive then
				mod.net.reportspelleffect(me.action.ability, me.action.mobname, "tick", value1, value2)
			end
			
			return
			
		else
			-- we just got enough ticks, so now reset to 0
			me.tickcounters[me.action.ability][me.action.mobname] = 0
			
		end
	end
	
	-- 3) To get here, the ability is definitely activating
	if mod.out.checktrace("info", me, "attack") then
		mod.out.printtrace(string.format("%s's %s activates, multiplying your threat by %s then adding %s.", me.action.mobname, me.action.ability, spelldata.multiplier, spelldata.addition))
	end
	
	-- compute new threat
	local newthreat = mod.table.getraidthreat() * spelldata.multiplier + spelldata.addition
	
	-- remember threat can't go below 0
	newthreat = math.max(0, newthreat)
	
	-- threat change is the (possibly negative) amount of threat that was added
	local threatchange = newthreat - mod.table.getraidthreat()
	
	-- spellreporting
	if me.isspellreportingactive then
		mod.net.reportspelleffect(me.action.ability, me.action.mobname, "proc", math.floor(0.5 + mod.table.getraidthreat()), math.floor(0.5 + newthreat))
	end
	
	-- add to threat wipes section, but not to totals
	mod.combat.event.hits = 1
	mod.combat.event.damage = 0
	mod.combat.event.rage = 0
	mod.combat.event.threat = threatchange
	
	mod.combat.addattacktodata(mod.string.get("threatsource", "threatwipe"), mod.combat.event)
	
	-- now add it to your raid threat total (but not your personal threat total)
	mod.table.raidthreatoffset = mod.table.raidthreatoffset + threatchange
	
	-- ask for a redraw of the personal window
	KLHTM_RequestRedraw("self")
	
end

--[[
me.resetaction()
Sets the values of me.action to their defaults.
]]
me.resetaction = function(mobname, ability)

	me.action.mobname = mobname
	me.action.ability = ability
	me.action.ishit = false
	me.action.isphysical = false
	me.action.isdebuff = false
	me.action.isspell = false
	
end

me.action = 
{
	mobname = "",
	ability = "",
	ishit = false,
	isphysical = false,
	isdebuff = false,
	isspell = false,
}

-- Note that <ishit> defaults to false, so we only set it when it is true
me.attackdescription = 
{
	["magicresist"] = 
	{
		isspell = true,
		isdebuff = true,
	},
	["spellhit"] =
	{
		isspell = true,
		ishit = true,
	},
	["attackabsorb"] = 
	{
		isspell = true,
		isphysical = true,
		ishit = true,
	},
	["abilityhit"] = 
	{
		isphysical = true,
		ishit = true,
	},
	["abilitymiss"] = 
	{	
		isphysical = true,
	},
	["debuffstart"] = 
	{
		ishit = true,
		isdebuff = true,
	},
}

--[[
Here is where you define all the boss' attacks that affect threat.
	The first key in me.bossattacks is the identifier of the spell. That is, mod.string.get("boss", "spell", <first key>) 
is the localised version.
	The second key deep specifies which mob the attack comes from. You can choose "default" to make it apply to all mobs,
or you can specify a mob id, which will override the "default" value. Mob id's recognised are all the keys in the 
"boss" -> "name" section of the localisation tree.
	So if you want to define a new attack name or boss name, you'll have to add a new key to the localisation tree in the
"boss" -> "spell" and "boss" -> "name" sections respectively.
	Inside each block, the follow parameters are defined:
	<multiplier> - a value that your threat is multiplier by. e.g. the standard Knock Away is -50% threat, so this would be a 
multiplier of 0.5. A complete threat wipe would be a multiplier of 0.
	<addition> - a flat value that is added to your threat. Can be positive or negative or 0.
	<effectonmiss> - a boolean value specifying whether the event triggers even when it is resisted or misses you.
	<ticks> - the number of times you must suffer the attack before your threat is changed. e.g. most knockbacks happen every
time so <ticks> = 1, but Time Lapse reduces your threat only after a certain number of applications.
	<type> - describes the attack. Can be "physical" or "spell" or "debuff". Not used by the mod at the moment: it will 
assume that if the name matches, it has found the right ability.
]]
me.bossattacks = 
{
	knockaway = 
	{
		default = 
		{
			multiplier = 0.5,
			addition = 0,
			effectonmiss = false,
			ticks = 1,
			type = "physical",
		},
		onyxia = 
		{
			multiplier = 0.67,
			addition = 0,
			effectonmiss = false,
			ticks = 1,
			type = "physical",
		},
	},
	wingbuffet = 
	{
		default = 
		{
			multiplier = 0.5,
			addition = 0,
			effectonmiss = false,
			ticks = 1,
			type = "physical",
		},
		onyxia = 
		{
			multiplier = 1.0,
			addition = 0,
			effectonmiss = false,
			ticks = 1,
			type = "physical",
		},
	},
	timelapse = 
	{
		default = 
		{
			multiplier = 0,
			addition = 0,
			effectonmiss = false,
			ticks = 5,
			type = "debuff"
		}
	},
	sandblast = 
	{
		default = 
		{
			multiplier = 0,
			addition = 0,
			effectonmiss = false,
			ticks = 1,
			type = "spell"
		}
	},
}

--[[
------------------------------------------------------------------------------------------------
	+ B +			Normal Shit
------------------------------------------------------------------------------------------------
]]

--[[
me.automastertarget(target)
Called when the mod itself sets the mastertarget.
<target> is the localised name of the mob.
]]
me.automastertarget = function(target)

	me.mastertarget = target
	
	-- stop network module autoupdating the master target
	mod.net.lastmtsender = ""

	-- explain to user
	mod.out.print(string.format(mod.string.get("print", "boss", "automt"), target))
	
end

--[[
mod.boss.newmastertarget(author, target)
Handles a request to change the master target.
<author> is the name of the officer in the group who changed the master target.
<target> is the name of his current mob, localised to him.
The problem is that if you have a different localisation to <author>, you will think his target is spelt differently to <target>! So we have to check for this, and override if necessary.
]]
me.newmastertarget = function(author, target)
	
	-- 1) Find the author's UnitID
	local officerunit = mod.unit.findunitidfromname(author)
	local officertarget = UnitName(tostring(officerunit) .. "target")
		
	-- 2) Check for differences
	if officertarget == nil then
		mod.out.print(string.format(mod.string.get("print", "network", "newmttargetnil"), target, author))
	
	elseif officertarget ~= target then
		mod.out.print(string.format(mod.string.get("print", "network", "newmttargetmismatch"), author, target, officertarget))
		target = officertarget
	end
	
	-- 3) Check for worldboss target
	if author == UnitName("player") and UnitClassification("target") == "worldboss" then
		me.ismtworldboss = true
	else
		me.ismtworldboss = false
	end
	
	-- 3) OK
	me.mastertarget = target
	mod.out.print(string.format(mod.string.get("print", "network", "newmt"), target, author))
	
end

-- todo: stuff, maybe?
me.clearmastertarget = function()
	
	me.mastertarget = nil
	
end

--[[
mod.boss.targetismaster(target)
Checks whether <target> is the master target. The master target is usually just a name / string, but it may be something
more general in the future (e.g. tracking both bosses in the Twin Emps fight).
<target> is the name of the mob being queried.
Return: non-nil if <target> is a mastertarget.
]]
me.targetismaster = function(target)
	
	if me.mastertarget == nil then
		return true
	end
	
	if target == me.mastertarget then
		return true
	end
	
	-- insert other checks here, later.
	
	return -- (nil)
	
end

-----------------------------------
--		Targeting Behaviour      --
-----------------------------------
--[[

True = True target. Who the mob would have aggro on, if we discount secondary targetting and taunts, etc.
Curr = Current target. Who the mob's target unitid is
New  = New target. If the mob's current target has changed

x, y = players with known threat values
nil  = no target
?    = player with unknown threat value


True	Curr	New		Result
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
nil		nil		x		true and curr become x

x		x		y		curr -> y. In 2 seconds with no change, true -> y. also, if their threat goes above 110 of yours in that time, put them up.
x		x		?		curr -> ?. In 2 seconds with no change, true -> ?
x		x		nil		curr -> nil.

x		y		z		curr -> z. In 2 secs, true -> z
x		y		nil		curr -> nil.
x		y		?		curr -> ?. In 2 secs, true -> ?
x		y		x		curr -> x

x		nil		y		If it's been nil for more than 1 second, true = y. Otherwise true -> y after 2 - (secs at nil) secs.
x		nil		x		curr -> x
x		nil		?		same as x - nil - y

?		?		x		true -> x. Easy enough.

]]

-- Master Target Variables
me.mttruetarget = nil	-- The Name of the player who this mod thinks is the true target
me.mtcurrenttarget = nil	-- The Name of the player the mob is currently targetting
me.mttargetswaptime = 0	-- The time when the mob last changed its target
me.unknowntarget = "#unknown" 
me.mastertargettarget = nil

-- lm2: aggro gain is now calculated just before redrawing the raid frame
me.updateaggrogain = function()
	
	if mod.boss.mastertarget == nil then
		me.recalculateaggrogain()
	else
		me.updatetrueaggrotarget()
	end
	
end
	

me.updatetrueaggrotarget = function()
		
	-- 1) find a UnitID for the master target
	local mastertargetid = nil
	
	if UnitName("target") == me.mastertarget then
		mastertargetid = "target"
		
	else
		-- check everyone in the raid
		local x
		
		for x = 1, 40 do
			if UnitName("raid" .. x .. "target") == me.mastertarget then
				mastertargetid = "raid" .. x .. "target"
				break
			end
		end
	end
	
	-- 2) If noone can see the mob, give up.
	if mastertargetid == nil then
		
		me.mttruetarget = me.unknowntarget
		me.mtcurrenttarget = me.unknownuarget
		mod.table.raiddata[mod.string.get("misc", "aggrogain")] = nil
		
		return
	end
	
	-- 3) Get the boss' current target
	local targetnow = UnitName(mastertargetid .. "target")
	 
	-- 4) Reevaluate True, Current, Time
	
	-- a) Transitions from true=unknown	
	if (me.mttruetarget == nil) or (me.mttruetarget == me.unknowntarget) or (mod.table.raiddata[me.mttruetarget] == nil) then
		
		-- debug print
		if targetnow ~= me.mttruetarget then
			if targetnow == nil then
				if mod.out.checktrace("info", me, "target") then
					mod.out.printtrace("Target changed from bad to nil.")
				end
			else
				if mod.out.checktrace("info", me, "target") then
					mod.out.printtrace(string.format("Target changed from bad to %s.", targetnow))
				end
				
				if (me.isknockbackdiscoveryactive == true) and (targetnow == UnitName("player")) then
					mod.net.sendmessage("aggrogain " .. mod.table.getraidthreat())
				end
			end
		end
		
		me.mttruetarget = targetnow
		me.mtcurrenttarget = targetnow
	
	-- b) Transitions from true = known
	elseif targetnow ~= me.mtcurrenttarget then
	
		if me.mtcurrenttarget ~= nil then
			me.mttargetswaptime = GetTime()
		end
	
		me.mtcurrenttarget = targetnow
		
		if targetnow == nil then
			if mod.out.checktrace("info", me, "target") then
				mod.out.printtrace("CurrentTarget changed to nil.")
			end
		else
			if mod.out.checktrace("info", me, "target") then
				mod.out.printtrace(string.format("CurrentTarget changed from bad to %s.", targetnow))
			end
			
			if (me.isknockbackdiscoveryactive == true) and (targetnow == UnitName("player")) then
				mod.net.sendmessage("aggrogain " .. mod.table.getraidthreat())
			end
		end
	end
	
	-- 5) Check if CurrentTarget should become Truetarget
	if me.mttruetarget ~= me.mtcurrenttarget then
		-- to get here, true target is known.
		
		if me.mtcurrenttarget == nil then
			-- do nothing
			
		elseif mod.table.raiddata[me.mtcurrenttarget] == nil then
			-- switch to unknown if it's been more than 2 seconds
			
			if GetTime() > me.mttargetswaptime + 2 then
				me.mttruetarget = me.mtcurrenttarget
				
				if mod.out.checktrace("info", me, "target") then
					mod.out.printtrace(string.format("TrueTarget switches to the unknown %s after 2 seconds.", me.mttruetarget))
				end
			end
			
		else -- current target is a known user
			if GetTime() - me.mttargetswaptime > 2 then
				me.mttruetarget = me.mtcurrenttarget
				
				if mod.out.checktrace("info", me, "target") then
					mod.out.printtrace(string.format("TrueTarget switches to the known player %s after 2 seconds.", me.mttruetarget))
				end
				
			elseif mod.table.raiddata[me.mtcurrenttarget] > mod.data.threatconstants.meleeaggrogain * mod.table.raiddata[me.mttruetarget] then
				me.mttruetarget = me.mtcurrenttarget

				if mod.out.checktrace("info", me, "target") then
					mod.out.printtrace(string.format("TrueTarget switches to the known player %s due to high threat.", me.mttruetarget))
				end
			end
		end
	end
	
	-- update the AggroGain virtual player
	if ((me.mttruetarget ~= nil) and (me.truetarget ~= me.unknowntarget) and
		(mod.table.raiddata[me.mttruetarget] ~= nil)) then
		
		local aggro = mod.table.raiddata[me.mttruetarget];

		if (UnitName("player") ~= me.mttruetarget) then
			if CheckInteractDistance(mastertargetid, 1) then
				aggro = math.ceil(aggro * mod.data.threatconstants.meleeaggrogain)
			else
				aggro = math.ceil(aggro * mod.data.threatconstants.rangeaggrogain)
			end
		end
		
		mod.table.raiddata[mod.string.get("misc", "aggrogain")] = aggro;
	else
		mod.table.raiddata[mod.string.get("misc", "aggrogain")] = nil
	end
end

me.recalculateaggrogain = function()

	-- update aggro, and such
	local newaggrogain
	local targetname = ""
	local maxdepth = 5
	local i
	local targetacquired = false
	
	for i = 1, maxdepth do
		targetname = targetname .. "target"
		
		if UnitName(targetname) == nil then
			break
		
		elseif UnitIsFriend("player", targetname) == nil then
			targetacquired = true
			break
		end
	end
	
	if targetacquired == false then
		-- remove aggro gain
		newaggrogain = nil
		
	else
		local mobtarget = UnitName(targetname .. "target")
		if mobtarget == nil then
			mobtarget = "<nil>"
		end
		
		if mod.table.raiddata[mobtarget] then
			-- aggro target has a known threat value
			
			if UnitName("player") == mobtarget then
				newaggrogain = mod.table.raiddata[mobtarget]
			
			else
				-- now check our range to the mob
				if CheckInteractDistance(targetname, 1) then
					-- we're in melee range 
					newaggrogain = math.ceil(mod.table.raiddata[mobtarget] * mod.data.threatconstants.meleeaggrogain)
					
				else
					-- there's a small region where we might be in melee range. for now, assume not
					newaggrogain = math.ceil(mod.table.raiddata[mobtarget] * mod.data.threatconstants.rangeaggrogain)
				end
			end
		else
			newaggrogain = nil
		end
	end
	
	local currentaggrogain = mod.table.raiddata[mod.string.get("misc", "aggrogain")]
	if newaggrogain ~= currentaggrogain then
		mod.table.raiddata[mod.string.get("misc", "aggrogain")] = newaggrogain
	end

end


local mod = klhtm
local me = {}
mod.alert = me

----------------------
-- Aggro loss / gain notification

-- This stuff is just debug material, to print out your threat when you gain or lose aggro.
----------------------

me.notifyaggro = false
me.targetname = "nil"
me.targettargetname = "nil"

function klhtest()

	me.notifyaggro = not me.notifyaggro
	
	if me.notifyaggro == true then
		mod.out.print("Now notifying you of aggro changes.")
	else
		mod.out.print("No longer notifying you of aggro changes.")
	end
	
end

me.onupdate = function()
	
	if me.notifyaggro == false then
		return
	end
	
	-- get current ID's. If you are targetting friend, then use HIS targets
	local targetid = "target"
	local doubletargetid = "targettarget"
	
	if UnitIsFriend("player", "target") then
		targetid = targetid .. "target"
		doubletargetid = doubletargetid .. "target"
	end
	
	-- check for valid targets
	if UnitIsFriend("player", targetid) then
		-- there are no enemies around. don't do anything
		me.targetname = "nil"
		return
	end
	
	-- now see if the target has changed
	local targetnow = UnitName(targetid)
	
	if targetnow == nil or targetnow == "Unknown Entity" then
		-- no mob targetted. ignore
		targetnow = "nil"
		return
	end
	
	-- get target target name
	local doubletargetnow = UnitName(doubletargetid)
	if doubletargetnow == nil then
		doubletargetnow = "nil"
	end
	
	-- check for target change
	if targetnow ~= me.targetname then
		
		-- target change. ignore targettarget therefore
		me.targetname = targetnow
		me.targettargetname = doubletargetnow
		return
	end
	
	-- to get here, target is valid and is the same. we want to see if targettarget is changed
	
	-- is change?
	if doubletargetnow ~= me.targettargetname then
	
		-- changed to nil
		if doubletargetnow == "nil" then
			if UnitIsDead(targetid) then
				-- target lost its target, because it died.
				me.targetname = "nil"
		
			else
				-- target temporarily lost its target. probably it is stunned
				-- so just don't update targettarget to nil
			end
	
			return
		end
		
		if me.targettargetname == "nil" then
			-- picked it up from noone. no announce.
			
		elseif me.targettargetname == UnitName("Player") then
			-- we lost aggro
			-- mod.out.announce("I lost aggro to " .. doubletargetnow .. ". His threat should be at least " ..	math.ceil(KLHTM_MyData["Total"].threat * 1.1) .. ". " .. me.enumeratethreat())
		
		elseif doubletargetnow == UnitName("Player") then
			-- we gained aggro
			mod.out.announce("I gained aggro from " .. me.targettargetname .. ". My threat is " .. math.ceil(mod.table.mydata["Total"].threat) .. ". " .. me.enumeratethreat(true))
		end
		
		me.targettargetname = doubletargetnow
	end
	
end

me.enumeratethreat = function(lastmessage)

	local message = "Damage = " .. mod.table.mydata["Total"].damage
	
	local key;	local value
	
	for key, value in mod.table.mydata do
		if key == "Healing" then
			message = message .. ", Healing = " .. value.damage
		
		elseif key ~= "Total" and key ~= "White Damage" then
			if value.hits > 0 then
				message = message .. ", " .. key .. " " .. value.hits .. " hits"
			end
		end
	end
		
	if lastmessage then
	
		local threat = mod.table.mydata["Total"].threat
		message = message .. ". Threat = " .. threat
	
		if mod.combat.lastattack then
			threat = threat - mod.combat.lastattack.threat
			message = message .. ", then " .. threat
		end
		
		if mod.combat.lastattack then
			threat = threat - mod.combat.lastattack.threat
			message = message .. ", then " .. threat
		end
	end
	
	message = message .. "."
	
	return message
	
end

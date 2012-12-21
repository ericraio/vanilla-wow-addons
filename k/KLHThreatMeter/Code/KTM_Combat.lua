
-- Add the module to the tree
local mod = klhtm
local me = {}
mod.combat = me

--[[
KTM_Combat.lua

The combat module parses combat log events for damage and abilities done.
]]

-- These are the events we would like to be notified of
me.myevents = { "CHAT_MSG_SPELL_FAILED_LOCALPLAYER", "CHAT_MSG_COMBAT_FRIENDLY_DEATH"}

-- these are kept for debug purposes. We need two because next attack abilities are split into two.
me.lastattack = nil
me.secondlastattack = nil

--[[ 
This is a record of attacks in the last second while out of combat. We keep this because when you
go into combat by initiating an attack, the +combat event can come after the actual attack. 
]]
me.recentattacks = { } 

me.onupdate = function()

	local timenow = GetTime()
	local key
	local value

	for key, value in me.recentattacks do
		if value[1] < timenow - 1 then
			me.recentattacks[key] = nil
		end
	end

end
	

-- This is a method level temporary variable. Declared at file level because it is a list,
-- and we don't want to keep paging heap memory every time he is created.
me.event = 
{
	["hits"] = 0,
	["damage"] = 0,
	["rage"] = 0,
	["threat"] = 0,
	["name"] = 0,
}

--[[ 
Special onevent() method that will be called by Core.lua:onevent()
]]
me.onevent = function()

	if me.oneventinternal() then
		KLHTM_RequestRedraw("self")
	end
	
end

-- Returns non-nil if the event causes our threat to change
me.oneventinternal = function()
	
	local ability
	local target
	local amount
	local damagetype
	
	if event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER" then
		if string.find(arg1, mod.string.get("spell", "sunder")) then
			me.retractsundercast()
			return true 
		else
			return
		end
	
	elseif event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH" then
		
		if arg1 == UNITDIESSELF then -- UNITDIESSELF = "You die."
			-- death is a threat wipe
			mod.table.resetraidthreat()
			return true
		end
		
	end
		
end

--[[
mod.combat.specialattack(abilityid, target, damage, iscrit, spellschool)
This handles any attack from a spell that has special threat properties, i.e. all the spells in mod.data.spells .
<abilityid> is the internal identifier for these abilities. i.e. Sunder Armor has <abilityid> = "sunder". This is locale
independent.
<damage>, <iscrit>, and <spellschool> are optional. <spellschool> is localised, and will have the value either nil
	or "" or one of SPELL_SCHOOL1_CAP, SPELL_SCHOOL2_CAP, etc.
<iscrit> is only accepted if it has the boolean value true.
]]
me.specialattack = function(abilityid, target, damage, iscrit, spellschool)

	-- 1) check the attack is directed at the master target. If not, ignore.
	if mod.boss.targetismaster(target) == nil then
		return
	end
	
	-- 2) get the player's global threat modifiers (defensive stance, blessing of salvation, etc)
	local threatmodifier = mod.my.globalthreat.value
	
	--[[
	Now, most attacks can be handled gracefully by the table. However, for abilities that modify your autoattack, 
	we would prefer to decouple the ability from the autoattack, so we have to handle these cases individually.
	]]
	
	-- reset me.event
	me.event.hits = 1
	me.event.rage = 0
	me.event.damage = damage
	
	-- 3) Handle Autoattack modifying abilities separately
	if abilityid == "whitedamage" then

		-- shaman special: check for rockbiter
		if mod.my.mods.shaman.rockbiter > 0 then
			
			-- make a separate event for the rockbiter
			local weaponspeed = UnitAttackSpeed("player")
			local rockbiterdps = mod.data.rockbiter[mod.my.mods.shaman.rockbiter]

			-- note: we are sending the threat value of rockbiter as the damage argument
			me.specialattack("rockbiter", target, rockbiterdps * weaponspeed, nil, nil)
			
			-- the above call to me.specialattack will have overwritten some parts of me.event. Set them back!
			me.event.damage = damage
		end
		
		-- normal behaviour
		me.event.threat = damage * threatmodifier
	
	-- Special case: Rockbiter Weapon
	elseif abilityid == "rockbiter" then
		
		-- this will only come from a "whitedamage" call to this method (see above)
		me.event.threat = me.event.damage * threatmodifier
		me.event.damage = 0

	-- Special case: Heroic Strike
	elseif abilityid == "heroicstrike" then
		
		local preimpaledamage = damage
		if iscrit == true then
			preimpaledamage = damage / (1 + mod.my.mods.warrior.impale)
		end
		
		local addeddamage = mod.my.ability("heroicstrike", "nextattack")
		local myaveragedamage = me.averagemainhanddamage()
		local whitedamage = preimpaledamage * (myaveragedamage / (addeddamage + myaveragedamage))
		
		-- Now make a separate method call for the autoattack component
		me.specialattack("whitedamage", target, whitedamage, nil, nil)
		
		-- The above method will have overwritten some parts of me.event, so change them back
		me.event.damage = damage - whitedamage
		me.event.threat = (me.event.damage + mod.my.ability("heroicstrike", "threat")) * threatmodifier
		me.event.rage = mod.my.ability("heroicstrike", "rage") + whitedamage / (UnitLevel("player") / 2)
	
	-- Special Case: Maul
	elseif abilityid == "maul" then
		
		-- same as heroic strike, but a bit different
		local presavagefurydamage = damage / (1 + mod.my.mods.druid.savagefury)		
		local addeddamage = mod.my.ability("maul", "nextattack")
		local myaveragedamage = me.averagemainhanddamage()
		local whitedamage = presavagefurydamage * (myaveragedamage / (addeddamage + myaveragedamage))
		
		-- Now make a separate method call for the autoattack component
		me.specialattack("whitedamage", target, whitedamage, nil, nil)
		
		-- The above method will have overwritten some parts of me.event, so change them back
		me.event.damage = damage - whitedamage
		me.event.threat = threatmodifier * (damage * mod.my.ability("maul", "multiplier") - whitedamage)
		me.event.rage = mod.my.ability("maul", "rage") + whitedamage / (UnitLevel("player") / 2)
		
	-- Default Case: all other abilities
	else
		
		-- 1) Check for rage
		me.event.rage = mod.my.ability(abilityid, "rage")

		local multiplier = mod.my.ability(abilityid, "multiplier")
		
		-- 2) Check for multiplier
		if multiplier then
			me.event.threat = me.event.damage * multiplier
			
		else
			me.event.threat = me.event.damage + mod.my.ability(abilityid, "threat")
		end
		
		-- 3) Multiply by global modifiers
		me.event.threat = me.event.threat * threatmodifier
	
	end
	
	-- Paladin righteous fury (can affect holy shield)
	if mod.my.class == "paladin" then
		
		-- righteous fury
		if spellschool == SPELL_SCHOOL1_CAP then -- holy
			me.event.threat = me.event.threat * mod.my.mods.paladin.righteousfury
		end
		
	-- warlock Nemesis 8/8 (can affect searing pain)
	elseif mod.my.class == "warlock" then
			
		-- Nemesis 8/8
		if (mod.my.mods.warlock.nemesis == true) and (mod.data.spellmatchesset("Warlock Destruction", abilityid) == true) then
			me.event.threat = me.event.threat * 0.8
		end
	end
		
	-- check for >= 0 threat
	if me.event.threat + mod.table.getraidthreat() < 0 then
		me.event.threat = - mod.table.getraidthreat()
	end
	
	-- relocalise.
	if abilityid == "whitedamage" then
		me.event.name = mod.string.get("threatsource", "whitedamage")
		
	else
		me.event.name = mod.string.get("spell", abilityid)
	end
	
	-- Add to data
	me.addattacktodata(me.event.name, me.event)
	me.addattacktodata(mod.string.get("threatsource", "total"), me.event)
	
end

-- to work out which part of a next attack ability was from white damage
-- used by nextattack abilities like maul and heroic strike.
me.averagemainhanddamage = function()

	local min, max = UnitDamage("player")
	return (min + max) / 2

end

--[[
me.normalattack(spellname, damage, target, iscrit, spellschool)
Handles a damage-causing ability with no special threat properties. We often have to make modifiers for gear or talents here.
<spellname> is the name of the ability.
<spellid> is the internal name for "special" spells or abilities, i.e. those we have to look out for because there are specific set bonuses or talents that affect them.
<damage> is the damage done.
<target> is the name of the mob you hit.
<iscrit> is a boolean, whether the hit was a critical one. Triggers iff it is the boolean value true.
<spellschool> is a string, one of SPELL_SCHOOL1_CAP, SPELL_SCHOOL2_CAP, etc, or possibly nil or "".
]]
me.normalattack = function(spellname, spellid, damage, isdot, target, iscrit, spellschool)
	
	-- check the attack is directed at the master target. If not, ignore.
	if mod.boss.targetismaster(target) == nil then
		return
	end

	-- threatmodifier includes global things, like defensive stance, tranquil air totem, rogue passive modifier, etc.
	local threatmodifier = mod.my.globalthreat.value
	
	-- Special threat mod: priest silent resolve (spells only)
	if mod.my.class == "priest" then
		
		-- 1.12: multiplicative threat
		if mod.isnewwowversion then
			threatmodifier = threatmodifier * (1.0 +  mod.my.mods.priest.silentresolve)
		else
			threatmodifier = threatmodifier + mod.my.mods.priest.silentresolve
		end
		
	end 
	
	-- Special threat modifiers for mages
	if mod.my.class == "mage" then
		if spellschool == SPELL_SCHOOL6_CAP then -- arcane
		
			-- 1.12 override check
			if mod.isnewwowversion then
				threatmodifier = threatmodifier * (1.0 + mod.my.mods.mage.arcanethreat)
			else
				threatmodifier = threatmodifier + mod.my.mods.mage.arcanethreat
			end
		
		elseif spellschool == SPELL_SCHOOL4_CAP then -- frost
			
			-- 1.12 override check
			if mod.isnewwowversion then
				threatmodifier = threatmodifier * (1.0 + mod.my.mods.mage.frostthreat)
			else
				threatmodifier = threatmodifier + mod.my.mods.mage.frostthreat
			end
		
		elseif spellschool == SPELL_SCHOOL2_CAP then -- fire
			
			-- 1.12 override check
			if mod.isnewwowversion then
				threatmodifier = threatmodifier * (1.0 + mod.my.mods.mage.firethreat)
			else
				threatmodifier = threatmodifier + mod.my.mods.mage.firethreat
			end
		end
	end
	
	-- Default values for me.event:
	me.event.hits = 1
	me.event.rage = 0
	me.event.damage = damage
	me.event.threat = damage * threatmodifier

	-- now get the name:
	if spellid == "dot" then
		
		me.event.hits = 0
		me.event.name = mod.string.get("threatsource", "dot")
		
	elseif spellid == "damageshield" then
		me.event.name = mod.string.get("threatsource", "damageshield")
		
	else
		me.event.name = mod.string.get("threatsource", "special")
		me.event.threat = damage * threatmodifier
	end
	
	-- Now apply class-specific filters
	
	-- warlock
	if mod.my.class == "warlock" then
			
		-- Nemesis 8/8
		if (mod.my.mods.warlock.nemesis == true) and (mod.data.spellmatchesset("Warlock Destruction", spellid) == true) then
			me.event.threat = me.event.threat * 0.8
		end
	
	-- Priest
	elseif mod.my.class == "priest" then
			
		-- shadow affinity
		if spellschool == SPELL_SCHOOL5_CAP then
			me.event.threat = me.event.threat * mod.my.mods.priest.shadowaffinity
		end
		
		-- holy nova: no threat
		if spellid == "holynova" then
			me.event.threat = 0
		end
		
	-- Mage
	elseif mod.my.class == "mage" then
			
		-- netherwind
		if mod.my.mods.mage.netherwind == true then
			
			if (spellid == "frostbolt") or (spellid == "scorch") or (spellid == "fireball") then
				-- note that this won't trigger off the dot part of fireball, because then spellid will be "dot"
				me.event.threat = math.max(0, (me.event.threat - 100))
				
			elseif spellid == "arcanemissiles" then
				me.event.threat = math.max(0, (me.event.threat - 20))
			end
		end
		
	-- Paladin
	elseif mod.my.class == "paladin" then
		
		-- righteous fury
		if spellschool == SPELL_SCHOOL1_CAP then -- holy
			me.event.threat = me.event.threat * mod.my.mods.paladin.righteousfury
		end
	end

	-- special: blood siphon no threat vs Hakkar. This may or may not be correct.
	if spellid == "bloodsiphon" then
		me.event.threat = 0
	end

	-- now add me.event to individual and totals
	me.addattacktodata(me.event.name, me.event)
	me.addattacktodata(mod.string.get("threatsource", "total"), me.event)
	
end

--[[ 
me.registertaunt()
Called when you succesfully casts Taunt or Growl on a mob.
<target> is the name of the mob you have taunted.
]]
me.taunt = function(target)
	
	if mod.out.checktrace("info", me, "taunt") then
		mod.out.printtrace(string.format("Taunting %s!", target))
	end
	
	--[[
	OK, new idea. If targettarget has greater threat than you, assume they are the aggro target.
	]]
	
	if mod.boss.mastertarget and (target ~= mod.boss.mastertarget) then
		-- you taunted a mob that is not the master target
		return
	end
	
	-- here, you either taunted the master target, or there is no master target
	-- check if you are still targetting that mob (likely, if you just taunted it)
	if UnitName("target") == target then
	
		-- Check for tt
		local targettarget = UnitName("targettarget")
		
		if mod.table.raiddata[targettarget] and (mod.table.raiddata[targettarget] > mod.table.getraidthreat()) then
			-- your current target is targetting another player, and they have more threat than you
			
			local gain = mod.table.raiddata[targettarget] - mod.table.getraidthreat()
				
			me.event.hits = 1
			me.event.damage = 0
			me.event.rage = 0
			me.event.threat = gain
			me.event.name = mod.string.get("spell", "taunt")

			me.addattacktodata(mod.string.get("spell", "taunt"), me.event)
			me.addattacktodata(mod.string.get("threatsource", "total"), me.event)
			
			if mod.out.checktrace("info", me, "taunt") then
				mod.out.printtrace(string.format("You taunt %s from %s, gaining %d threat.", target, targettarget, gain))
			end
			
			return
		end
	end
	
	-- If that didn't work, use the old code:	
	
	if target == mod.boss.mastertarget then
		local previoustargetthreat = mod.table.raiddata[mod.boss.mttruetarget]
		
		if (previoustargetthreat ~= nil) and (previoustargetthreat > mod.table.getraidthreat()) then
			local tauntgain = previoustargetthreat - mod.table.getraidthreat()
			
			me.event.hits = 1
			me.event.damage = 0
			me.event.rage = 0
			me.event.threat = tauntgain
			me.event.name = mod.string.get("spell", "taunt")
			
			me.addattacktodata(mod.string.get("spell", "taunt"), me.event)
			me.addattacktodata(mod.string.get("threatsource", "total"), me.event)

			if mod.out.checktrace("info", me, "taunt") then
				mod.out.printtrace(string.format("You taunt %s from %s, gaining %d threat.", target, mod.boss.mttruetarget or "<nil>", tauntgain))
			end
		
		else
			if mod.out.checktrace("info", me, "taunt") then
				mod.out.printtrace(string.format("You taunt %s from %s, but he had a lower threat, so you gain no threat.", target, mod.boss.mttruetarget or "<nil>"))
			end
		end
	end
	
end

--[[
me.possibleoverheal(spellname, spellid, amount, target)
Works out the threat from a heal.
<spellname> is the localised name of the spell
<spellid> is the mod's internal name for the spell, if it is special (i.e. affected by talents / sets bonuses), otherwise "".
<amount> is the healed amount only (no overheal)
<target> is the name of the target
Called when you heal someone. Deducts the overhealing from the total, then calls the Heal method
]]
me.possibleoverheal = function(spellname, spellid, amount, target)
	
	-- we can check the target's health, which will be the health before the heal. Then we work out what the 
	-- heal did, and we can calculate overheal.
	
	local unit = mod.unit.findunitidfromname(target)
	
	if unit == nil then
		if mod.out.checktrace("info", me, "healtarget") then
			mod.out.printtrace(string.format("Could not find a UnitID for the name %s.", target))
		end
		-- (and assume there was no overheal)
	else
		local hpvoid = UnitHealthMax(unit) - UnitHealth(unit)
		amount = math.min(amount, hpvoid)
	end
	
	me.registerheal(spellname, spellid, amount, target)
	
end

--[[ 
me.registerheal(spellname, spellid, amount, target)
Works out the threat from a heal.
<spellname> is the localised name of the spell
<spellid> is the mod's internal name for the spell, if it is special (i.e. affected by talents / sets bonuses), otherwise "".
<amount> is the healed amount only (no overheal)
<target> is the name of the target
]]
me.registerheal = function(spellname, spellid, amount, target)

	-- in general, don't count heals towards the master target
	if mod.boss.mastertarget and mod.boss.targetismaster(target) then
		return
	end
	
	me.event.hits = 1
	me.event.rage = 0
	me.event.damage = amount
	
	local threatmod = mod.my.globalthreat.value
	
	-- Special threat mod: priest silent resolve (spells only)
	if mod.my.class == "priest" then
		
		-- 1.12+ multiplicative threat
		if mod.isnewwowversion then
			threatmod = threatmod * (1 + mod.my.mods.priest.silentresolve)
		else
			threatmod = threatmod + mod.my.mods.priest.silentresolve
		end
	end 
	
	me.event.threat = amount * threatmod * mod.data.threatconstants.healing
	
	-- class-based healing multipliers
	if mod.my.class == "paladin" then
		me.event.threat = me.event.threat * mod.my.mods.paladin.healing
		
	elseif mod.my.class == "druid" then
		me.event.threat = me.event.threat * mod.my.mods.druid.subtlety
		
		if spellid == "tranquility" then
			me.event.threat = me.event.threat * mod.my.mods.druid.tranquilitythreat
		end
		
	elseif mod.my.class == "shaman" then
		me.event.threat = me.event.threat * mod.my.mods.shaman.healing
		
	end 
	
	-- Special: healing abilities which don't cause threat
	if spellid == "holynova" then
		me.event.threat = 0
	elseif spellid == "siphonlife" then
		me.event.threat = 0
	elseif spellid == "drainlife" then
		me.event.threat = 0
	elseif spellid == "deathcoil" then
		me.event.threat = 0
	end
	
	me.addattacktodata(mod.string.get("threatsource", "healing"), me.event)
	
	me.event.damage = 0
	me.addattacktodata(mod.string.get("threatsource", "total"), me.event)
end

--[[
me.powergain(amount, powertype)
Calculates the threat from gaining energy / mana / rage.
<amount> is the amount of power gained.
<powertype> is "Mana" or "Rage" or "Energy", but the localised versions.
<spellid> is the spell or effect that caused the power gain.
]]
me.powergain = function(amount, powertype, spellid)
	
	me.event.damage = amount
	me.event.hits = 1
	me.event.rage = 0
	
	-- 1) Prevent "overheal" for power gain
	local maxgain = UnitManaMax("player") - UnitMana("player")
	amount = math.min(maxgain, amount)
	
	if powertype == mod.string.get("power", "rage") then
		me.event.threat = amount * mod.data.threatconstants.ragegain
		
	elseif powertype == mod.string.get("power", "energy") then
		me.event.threat = amount * mod.data.threatconstants.energygain
		
	elseif powertype == mod.string.get("power", "mana") then
		me.event.threat = amount * mod.data.threatconstants.managain 
		
	else
		return
	end
	
	-- Special: abilities which don't cause threat
	if spellid == "lifetap" then
		me.event.threat = 0
	end
		
	me.addattacktodata(mod.string.get("threatsource", "powergain"), me.event)
	
	-- now mod it a bit to work into total better
	me.event.damage = 0
	me.event.hits = 0
	
	me.addattacktodata(mod.string.get("threatsource", "total"), me.event)
	
end

--[[
me.addattacktodata(name, data)
Once the threat from an attack has been worked, add it.
<name> is the category to add the threat to
<data> is me.event, i think...
Heap Memory will be created when you call this method when out of combat (mostly healing). 
From the size of the list (two numbers in it), will be 50 bytes tops each time.
]]
me.addattacktodata = function(name, data)
	
	-- Ignore if charmed
	if mod.my.states.playercharmed.value == true then
		return
	end 
	
	if name ~= mod.string.get("threatsource", "total") then
		me.secondlastattack = me.lastattack
		me.lastattack = data
		
		-- Add this to the recent attacks list, if we are not in combat
		if mod.my.states.incombat.value == false then
			table.insert(me.recentattacks, {GetTime(), data.threat})
		end
	end
	
	-- Add a new column to mod.table.mydata, if it does not exist already
	if mod.table.mydata[name] == nil then
		mod.table.mydata[name] = mod.table.newdatastruct()
	end
	
	mod.table.mydata[name].hits = mod.table.mydata[name].hits + data.hits
	mod.table.mydata[name].threat = mod.table.mydata[name].threat + data.threat
	mod.table.mydata[name].rage = mod.table.mydata[name].rage + data.rage
	mod.table.mydata[name].damage = mod.table.mydata[name].damage + data.damage 
	
end


----------------------------------------------------------
--					Handling Sunder						--
----------------------------------------------------------


--[[
klhtu.combat.submitsundercast()
When you think you have just cast a sunder, call this method to make sure the addon knows. There's no way to
reliably detect a sunder hit, so we assume it has been cast, then look for failure signs (misses, spell errors)
It's highly recommended to use klhtm.combat.sunder() or KLHTM_Sunder() instead, because it will make sure
that threat is correct when you spam the button, which may not happen otherwise.
]]
me.submitsundercast = function()
	
	-- check for Master Target
	if mod.boss.targetismaster(UnitName("target")) == nil then
		return
	end
	
	me.specialattack("sunder", UnitName("target"), 0)
	KLHTM_RequestRedraw("self")
end

-- Call this from a macro, to replace your normal sunder button
me.spellbooksunderindex = 1

-- Kept for compatibility
function KLHTM_Sunder()
	
	me.sunder()
	
end

--[[
me.sunder()
Casts Sunder Armor if most checks reveal it is castable, and calls me.sumbitsundercast().
This method is safe to be spammed. It will only cast if the global cooldown is off, which means once you try to
cast it, you won't try again unless the server says "failed due to <x>". So it's like full good and stuff.
]]
me.sunder = function()
	
	if mod.my.class ~= "warrior" then
		return
	end
	
	-- 1) Check if the old position is fine
	if GetSpellName(me.spellbooksunderindex, "spell") ~= mod.string.get("spell", "sunder") then
		
		-- get spell number of spells
		local spelltabs = GetNumSpellTabs()
		local numspells = 0
		local i
		local temp
	
		for i = 1, spelltabs do
			_, _, _, temp = GetSpellTabInfo(i)
			numspells = numspells + temp
		end
	
		-- 2) locate sunder armor in the spell book
		for i = 1, numspells do
			if GetSpellName(me.spellbooksunderindex + i, "spell") == mod.string.get("spell", "sunder") then
				me.spellbooksunderindex = me.spellbooksunderindex + i
				break
				
			elseif i == numspells then
				if mod.out.checktrace("warning", me, "sunder") then
					mod.out.printtrace("Can't find sunder in your spellbook!")
				end
				return -- can't find sunder
			end
		end
	end
	
	-- Now we've found sunder. Check the cooldown		
	if GetSpellCooldown(me.spellbooksunderindex, "spell") ~= 0 then 
		return
	end
	
	-- Test for target
	if UnitCanAttack("player", "target") == nil then
		return
	end 
	
	-- Cast
	CastSpellByName(mod.string.get("spell", "sunder") .. "()")
	me.submitsundercast()
	
end

--[[ 
me.retractsundercast()
Called when an attempted cast of Sunder Armor was found to have failed. i.e. we received a message like
"Your sunder armor failed: not enough rage" in the combat log.
]]
me.retractsundercast = function()

	-- 1) check for master target
	if mod.boss.targetismaster(UnitName("target")) == nil then
		return
	end
	
	me.event.hits = -1
	me.event.damage = 0
	me.event.rage = - mod.my.ability("sunder", "rage")
	
	local threatmodifier = mod.my.globalthreat.value
	me.event.threat = - mod.my.ability("sunder", "threat") * threatmodifier 

	me.addattacktodata(mod.string.get("spell", "sunder"), me.event)
	me.addattacktodata(mod.string.get("threatsource", "total"), me.event)
	
	KLHTM_RequestRedraw("self")
end

--[[
This code hooks UseAction, intercepts the user casting Sunder Armor, and runs me.sunder() instead.
]]

me.saveduseaction = UseAction

me.newuseaction = function(actionindex, x, y)
	
	-- Check Sunder
	if (mod.my.class == "warrior") and actionindex and (GetActionText(actionindex) == nil) and (GetActionTexture(actionindex) == "Interface\\Icons\\Ability_Warrior_Sunder") then
		
		if GetActionCooldown(actionindex) > 0 then
			if mod.out.checktrace("info", me, "sunder") then
				mod.out.printtrace("Preventing Sunder cast due to cooldown!")
			end
			return
			
		else
			-- Now check we have a decent target. Otherwise press "tab" - this is what the UI does anyway
			if UnitCanAttack("player", "target") ~= 1 then
				
				if mod.out.checktrace("info", me, "sunder") then
					mod.out.printtrace("Preventing Sunder cast due to invalid target!")
				end
				
				TargetNearestEnemy()
				return
			end
			
			me.submitsundercast()
			-- At the bottom of this method the sunder will be cast
		end
	
	end

   -- Call the original function
   me.saveduseaction(actionindex, x, y)   

end

UseAction = me.newuseaction

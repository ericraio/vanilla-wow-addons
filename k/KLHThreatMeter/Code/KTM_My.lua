
local mod = klhtm
local me = { }
mod.my = me

--[[ 
KTM_My.lua

This file stores data that specifically relates to the current player, and methods that change these data sets.
Most of the data sets are updated by polling, that is frequently recalculating their values.

me.states		- 	a set of flags, e.g. "player in combat" / "afk" / "feigning death"
me.spellranks	-	list of ranks the player has for the important threat causing spells / abilities
me.mods			-	currently active modifiers to threat / abilities from talents, gear, buffs, etc
me.globalthreat	-	buffs that affect all threat the player generates
]]

----------------------------------------------------------------------------------------

me.feigndeathresisttime = 0 -- return value of GetTime()
me.lastfadevalue = 0

-- mod.my.class is the unlocalised lower case representation. e.g. "warrior", "rogue", no matter what locale you are in.
_, me.class = UnitClass("player")
me.class = string.lower(me.class)

-----------------------------------------
--    Special Methods from Core.lua    --
-----------------------------------------

me.parserset = { }

-- onupdate
me.onload = function()
	
	-- make our parser
	local parserdata
	
	for _, parserdata in me.parserconstructor do
		mod.regex.addparsestring(me.parserset, parserdata[1], parserdata[2], parserdata[3])
	end
	
end

me.parserconstructor = 
{
   {"buffstart", "AURAADDEDSELFHELPFUL", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"},	-- "You gain %s."
   {"debuffstart", "AURAADDEDSELFHARMFUL", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"}, -- "You are afflicated by %s."
	{"weaponbuff", "ITEMENCHANTMENTADDSELFSELF", "CHAT_MSG_SPELL_ITEM_ENCHANTMENTS"}, -- "You cast %s on your %s."
	{"buffend", "AURAREMOVEDSELF", "CHAT_MSG_SPELL_AURA_GONE_SELF"}, -- "%s fades from you."
}

-- The "UI_ERROR_MESSAGE" event is used to detect Feign Death resists.
me.myevents = { "UI_ERROR_MESSAGE", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "CHAT_MSG_SPELL_AURA_GONE_SELF", 
	"CHAT_MSG_SPELL_ITEM_ENCHANTMENTS", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"}

me.onevent = function()

	local ability

	-- 1) Check for Feign Death resisted
	if event == "UI_ERROR_MESSAGE" then
		
		if arg1 == ERR_FEIGN_DEATH_RESISTED then
			if mod.out.checktrace("info", me, "feigndeath") then
				mod.out.printtrace("Feign Death Resist message intercepted.")
			end
			me.feigndeathresisttime = GetTime()
		end
		
		return
	end
	
	-- 2) Check for various buffs
	local output = mod.regex.parse(me.parserset, arg1, event)
	
	if output.hit == nil then
		return
	end
	
	me.parserstagetwo[output.parser.identifier](output.final[1], output.final[2], output.final[3], output.final[4])

end

--[[
This is the continuation of the combat log parsing from me.onevent above. From that method, we know the identifier of the event that has been parsed, and all the arguments that go with it. We put all the identifiers into a table whose value is a method to handle that event.
]]
me.parserstagetwo = 
{
	["debuffstart"] = function(buff)	
		if buff == mod.string.get("boss", "spell", "burningadrenaline") then
			me.setstate("burningadrenaline", true)
		end
		
	end,
	
	["buffend"] = function(buff)
		if buff == mod.string.get("boss", "spell", "burningadrenaline") then
			me.setstate("burningadrenaline", false)
			
		elseif buff == mod.string.get("spell", "arcaneshroud") then
			me.setstate("arcaneshroud", false) 
		
		elseif buff == mod.string.get("spell", "fade") then
			-- retract fade
			mod.table.raidthreatoffset = mod.table.raidthreatoffset + me.lastfadevalue
			me.setstate("fade", false)
		end 	
				
	end,
	
	["weaponbuff"] = function(buff, weapon)
		-- only care about rockbiter == shaman
		if me.class ~= "shaman" then
			return
		end
		
		if string.find(buff, mod.string.get("spell", "rockbiter")) then
			
			-- get rank
			local rank
			_, _, rank = string.find(buff, ".-(%d+).-")
			
			-- set rank in mods
			me.mods.shaman.rockbiter = tonumber(rank)
		
		else
		
			-- added an enchant that was not rockbiter
			me.mods.shaman.rockbiter = 0
		end	
		
	end,
	
	["buffstart"] = function(buff)
		if buff == mod.string.get("spell", "arcaneshroud") then -- fetish of the sand reaver activation
			mod.my.setstate("arcaneshroud", true)
		
		elseif buff == mod.string.get("spell", "vanish") then
			mod.table.resetraidthreat()
			
		elseif buff == mod.string.get("spell", "fade") then
		
			local threat = mod.my.ability("fade", "threat")
			mod.table.raidthreatoffset = mod.table.raidthreatoffset - threat
			mod.my.lastfadevalue = threat
			
			mod.my.setstate("fade", true)
		end
	end,
}


me.lastupdatetime = 0.0			-- return value of GetTime()
me.longupdateinterval = 1.0 	-- at least this time in seconds will pass between long updates

me.lastmegaupdatetime = 0.0
me.megaupdateinterval = 10.0

--[[  
Special onupdate() function, called from Core.lua
me.states		-	frequent update
me.spellranks	-	long time update
me.mods			-	long time update
me.globalthreat	-	frequent update
]]
me.onupdate = function()
	
	-- short updates
	me.redostates()
	
	-- check for long updates
	local timenow = GetTime()
	
	-- long updates
	if timenow > me.lastupdatetime + me.longupdateinterval then
		me.lastupdatetime = timenow
		me.redomods()
		me.redoglobalthreat()
	end
	
	-- mega updates
	if timenow > me.lastmegaupdatetime + me.megaupdateinterval then
		me.lastmegaupdatetime = timenow
		me.redospellranks()
	end
		
	-- check status of rockbiter enchant for Shaman, i.e. whether it has run out.
	if GetWeaponEnchantInfo() == nil then
		me.mods.shaman.rockbiter = 0
	end
end

----------------------------------------------------------------------------------------

----------------------------
--	  General Methods     --
----------------------------


--[[ 
mod.my.ability(name, value)
Returns the current value for some property of your spells and abilities.
	<name> is the mod's internal name for the ability.
	<value> is the name of the property, e.g. "threat", "multiplier", "rage". These are the indexes of values in
the mod.data.spells structure.
--> multiplier: return nil if nil
--> rage: return 0 if nil
--> threat / nextattack: throw error if nil

	This method will use me.spellranks to get the data that applies to your specific rank of the ability. Then
it will apply any modifiers from me.mods that are appropriate.
]]
me.ability = function(spellid, parameter)
	
	if (spellid == nil) or (mod.data.spells[spellid] == nil) then
		if mod.out.checktrace("error", me, "ability") then
			mod.out.printtrace(string.format("No ability |cffffff00%s|r found.", tostring(spellid)))
		end
		return 0
	end
	
	local value
	local data = mod.data.spells[spellid]
	
	-- "rage" and "multiplier" parameters are easy, since they 
	if parameter == "rage" then
		if data.rage == nil then
			return 0
		else
			return data.rage
		end
	
	elseif parameter == "multiplier" then
		return data.multiplier -- may be nil
	end
		
	-- to get here, <parameter> is either "threat" or "nextattack"
	
	-- Item abilities only have one value for threat, no ranks.
	if data.class == "item" then
		return data.threat
	end
	
	-- Now check the spell has a known rank
	local spellrank = me.spellranks[spellid]
	
	if spellrank == nil then
		if mod.out.checktrace("error", me, "ability") then
			mod.out.printtrace(string.format("No spell rank defined for |cffffff00%s.", tostring(spellid)))
		end

		return 0
	end
	
	-- Check there is a value in data for our parameter (should always be)
	value = data[spellrank][parameter]
	
	if value == nil then
		if mod.out.checktrace("error", me, "ability") then
			mod.out.printtrace(string.format("No value of |cffffff00%s for rank |cffffff00%s of |cffffff00%s.", tostring(parameter), tostring(spellrankg), tostring(spellid)))
		end
		
		return 0
	end

	-- to get here, there were no errors. we got a value. Now we have to look for class mods that would affect it.
	if spellid == "sunder" then
		if parameter == "rage" then
			value = value + me.mods.warrior.sundercost
		elseif parameter == "threat" then
			value = value * me.mods.warrior.sunderthreat
		end
		
	elseif spellid == "heroicstrike" then
		if parameter == "rage" then
			value = value + me.mods.warrior.heroicstrikecost
		end
		
	elseif spellid == "feint" then
		if parameter == "threat" then
			value = value * me.mods.rogue.feintthreat
		end
		
	elseif spellid == "maul" then
		if parameter == "rage" then
			value = value + me.mods.druid.ferocity
		end
		
	elseif spellid == "swipe" then
		if parameter == "rage" then
			value = value + me.mods.druid.ferocity
		end	
	end
	
	return value
end

--[[
mod.my.testthreat()
Print out your threat properties for debug purposes.
]]
me.testthreat = function()
		
	-- 1) Print out spell ranks
	local key
	local value
	
	for key, value in me.spellranks do
		mod.out.print(string.format(mod.string.get("print", "data", "abilityrank"), key, value))
	end
	
	-- 2) Print out global threat
	mod.out.print(string.format(mod.string.get("print", "data", "globalthreat"), me.globalthreat.value))
	for key, value in me.globalthreat.modifiers do
		if value.isactive == false then
			break
		end
		
		mod.out.print(string.format(mod.string.get("print", "data", "globalthreatmod"), value.reason, value.value))
	end

	-- 3) Print out threat for specific abilities
	if me.class == "priest" then
		mod.out.print(string.format(mod.string.get("print", "data", "multiplier"), UnitClass("player"), mod.string.get("talent", "silentresolve"), 1.0 + me.mods.priest.silentresolve))
		mod.out.print(string.format(mod.string.get("print", "data", "multiplier"), UnitClass("player"), SPELL_SCHOOL5_CAP, me.mods.priest.shadowaffinity))
	
	elseif me.class == "warlock" then
		mod.out.print(string.format(mod.string.get("print", "data", "setactive"), mod.string.get("sets", "nemesis"), 8, mod.out.booltostring(me.mods.warlock.nemesis)))
	
	elseif me.class == "mage" then
		mod.out.print(string.format(mod.string.get("print", "data", "setactive"), mod.string.get("sets", "netherwind"), 3, mod.out.booltostring(me.mods.mage.netherwind)))
		mod.out.print(string.format(mod.string.get("print", "data", "multiplier"), UnitClass("player"), SPELL_SCHOOL6_CAP, 1.0 + me.mods.mage.arcanethreat))
		mod.out.print(string.format(mod.string.get("print", "data", "multiplier"), UnitClass("player"), SPELL_SCHOOL4_CAP, 1.0 + me.mods.mage.frostthreat))
		mod.out.print(string.format(mod.string.get("print", "data", "multiplier"), UnitClass("player"), SPELL_SCHOOL2_CAP, 1.0 + me.mods.mage.firethreat))
		
	elseif me.class == "paladin" then
		mod.out.print(string.format(mod.string.get("print", "data", "multiplier"), UnitClass("player"), mod.string.get("print", "data", "holyspell"), me.mods.paladin.righteousfury))
		mod.out.print(string.format(mod.string.get("print", "data", "healing"), mod.data.threatconstants.healing * me.mods.paladin.healing))
		
	elseif me.class == "warrior" then
		mod.out.print(string.format(mod.string.get("print", "data", "multiplier"), UnitClass("player"), mod.string.get("spell", "sunder"), me.mods.warrior.sunderthreat))
		
	elseif me.class == "druid" then
		mod.out.print(string.format(mod.string.get("print", "data", "multiplier"), UnitClass("player"), mod.string.get("talent", "tranquility"), me.mods.druid.tranquilitythreat))
		
	elseif me.class == "shaman" then
		mod.out.print(string.format(mod.string.get("print", "data", "healing"), mod.data.threatconstants.healing * me.mods.shaman.healing))
		
		if me.mods.shaman.rockbiter > 0 then
			mod.out.print(string.format(mod.string.get("print", "data", "rockbiter"), me.mods.shaman.rockbiter, UnitAttackSpeed("player") * mod.data.rockbiter[me.mods.shaman.rockbiter]))
		end
	end
end


----------------------------------------------------------------------------------------

----------------------------
--	  	  States          --
----------------------------

--[[      
each state is represented by a key-value pair. The key is a string, which is a description of the state,
e.g. "incombat", "afk". The value is a list with properties 
	["value"], boolean, whether the state is on or off
	["lastchange"], return value of GetTime() (seconds + decimal), when the value last changed
	["duration"], OPTIONAL, known duration of the state. This is used to turn the state off just in case
				  the normal mechanism to detect it does not work.
				
To set a state's value, call the method mod.my.setstate(<string name>, <boolean value>). If this causes the
state to change, the method will return non-nil, and an event KLHTM_STATECHANGE_<NAME> will be raised.
]]  
me.states = 
{
	["feigndeath"] = 
	{
		["value"] = false,
		["lastchange"] = 0,
	},
	["arcaneshroud"] = -- from Fetish of the Sandreaver
	{
		["value"] = false,
		["lastchange"] = 0,
		["duration"] = 20.0
	},
	["incombat"] = 
	{
		["value"] = false,
		["lastchange"] = 0,
	},
	["playercharmed"] = -- whether you have been mind controlled
	{
		["value"] = false,
		["lastchange"] = 0,
	},
	["burningadrenaline"] = 
	{
		["value"] = false,
		["lastchange"] = 0,
		["duration"] = 20.0,
	},
	["afk"] = 
	{
		["value"] = false,
		["lastchange"] = 0,
	},
	["fade"] = 
	{
		["value"] = false,
		["lastchange"] = 0,
		["duration"] = 10.0,
	},
}


--[[ 
mod.my.setstate(state, value)
Sets the value of one of the state variables above.
<state> is a string, a key to the me.states list, e.g. "afk", "incombat", etc.
<value> is a boolean, true or false.
Return: true if the set represents a change, otherwise nil
]]
me.setstate = function(state, value)
	
	-- verify <state>
	if me.states[state] == nil then
		if mod.out.checktrace("error", me, "state") then
			mod.out.printtrace(string.format("There is no state |cffffff00%s|r.", tostring(state)))
		end
		return
	end
	
	-- update
	if me.states[state].value ~= value then
		me.states[state].value = value
		me.states[state].lastchange = GetTime()
		
		return true
	end

end

--[[
me.redostates()
Checks for changes to state variables that we poll for (e.g. "incombat" / "ischarmed").
Also checks for states that have run out, but whose end events were not detected (e.g. burning adrenaline). This
last should not be relied upon though.
]]
me.redostates = function()
	
	-- hunter: check for FD
	if mod.my.class == "hunter" then
		
		-- Check for feign death debuff
		local currentfd = mod.data.isbuffpresent("Interface\\Icons\\Ability_Rogue_FeignDeath")
		
		if me.setstate("feigndeath", currentfd) and (currentfd == true) then
			
			-- first check for resist.
			if math.abs(me.feigndeathresisttime - GetTime()) < 1.0 then
				--resisted. Nothing happens
				
				if mod.out.checktrace("info", me, "feigndeath") then
					mod.out.printtrace("feigndeathdebug", "Feign Death was resisted!")
				end
				
			else -- wipe threat
			
				mod.table.resetraidthreat()
				
			end
			
		end
	end
 
	-- update charmed state
	if UnitIsCharmed("player") == 1 then
		me.setstate("playercharmed", true)
	else
		me.setstate("playercharmed", false)
	end

	-- update combat state
	if UnitAffectingCombat("player") == 1 then
		
		if me.setstate("incombat", true) then
			
			-- player has just joined combat
			if mod.out.checktrace("info", me, "incombat") then
				mod.out.printtrace("You entered combat.")
			end
			
			mod.table.resetraidthreat()
			
			local key
			local value
		
			for key, value in mod.combat.recentattacks do
				mod.table.raidthreatoffset = mod.table.raidthreatoffset + value[2]
			end	
		end
	
	else
		if (me.states.playercharmed.value == true) or (GetTime() - me.states.playercharmed.lastchange < 2.0) then
			me.setstate("incombat", true) -- should not be a change
		else
			if me.setstate("incombat", false) then
				if mod.out.checktrace("info", me, "incombat") then
					mod.out.printtrace("You left combat.")
				end
				me.lastfadevalue = 0 -- stop fade
			end 
		end
	end
	
	-- update states with a "duration" parameter. They are all designed to deactivate on their own, but e.g.
	-- burning adrenaline isn't working, so we put in this mechanism as a backup
	local state
	local data
	
	for state, data in me.states do
		if data.duration and (data.value == true) and (GetTime() > data.lastchange + data.duration + 1.0) then
			me.setstate(state, false)
			
			if mod.out.checktrace("info", me, "state") then
				mod.out.printtrace(string.format("Deactivated the state %s because it had passed its duration.", state))
			end
		end
	end 
end

----------------------------------------------------------------------------------------

----------------------------
--      Spell Ranks       --
----------------------------

--[[
	A collection of key-value pairs. The key is a string, the name of a spell / ability, e.g. "Sunder Armor". It
is localised. The value is an integer, the rank of that spell you have.
	The only spells recorded are those which are cause or remove threat by known amounts, i.e. Sunder Armor, 
Revenge, Maul, Feint, etc.
	We want to know the what rank of the spell the player has, because most abilities have different numbers for 
different spell ranks. e.g. Heroic Strike does more damage and threat for each new rank. Some players will have the
extra rank from AQ20, some will not.
	These ranks will probably not change over the course of a session, but we poll just in case.
]]
me.spellranks = { } 

--[[
me.redospellranks()
Redetermines the ranks of all special threat abilities you have.
]]
me.redospellranks = function()
	
	local index = 0
	local name, rankstring, rank, spellid
	local rankpattern = mod.string.get("misc", "spellrank") -- e.g. "Rank %d" in english.
		
	while true do
		index = index + 1
		name, rankstring = GetSpellName(index, "spell")
		
		if name == nil then
			break
		end
		
		-- get the internal spell ID
		spellid = mod.string.unlocalise("spell", name)
		
		if spellid and mod.data.spells[spellid] then
			rank = 0
			
			_, _, rank = string.find(rankstring, rankpattern)
			if rank then
				me.spellranks[spellid] = rank
			end
		end
	end
	
end


----------------------------------------------------------------------------------------

---------------------------------------
--    Threat And Ability Modifers    --
---------------------------------------

me.mods = 
{
	["warrior"] = 
	{
		["defiance"] = 0.0, 			-- modifier to global threat. e.g. "+0.15" for 5 points.
		["sunderthreat"] = 1.0, 	-- multiplier. e.g. "1.15" for 8/8 Might.
		["sundercost"] = 0.0,		-- modifier of rage cost. e.g. "-3" for 3/3 improved sunder talent.
		["heroicstrikecost"] = 0.0,-- modifier of rage cost. e.g. "-3" for 3/3 improved heroic strike talent.
		["impale"] = 0.0 				-- critical strike bonus damage for abilities. e.g. "0.2" for 2/2 impale talent.
	},
	["rogue"] = 
	{
		["feintthreat"] = 1.0,		-- multiplier. e.g. "1.25" for 5/8 Bloodfang.
	},
	["druid"] = 
	{
		["feralinstinct"] = 0.0, 	-- defiance for druids.
		["savagefury"] = 1.0, 		-- multiplier to damage for druid abilities
		["subtlety"] = 1.0, 			-- multiplier to healing threat. e.g. "0.8" for all talents.
		["ferocity"] = 0.0, 			-- modifier to rage cost of maul and swipe. e.g. "-5" for all talents.
		["tranquilitythreat"] = 1.0-- multiplier, from Improved Tranquility Talent
	},
	["mage"] = 
	{
		["arcanist"] = false, 		-- 8 piece bonus
		["netherwind"] = false, 	-- 3 piece
		["arcanethreat"] = 0.0,		-- almost a modifier to global threat (spells only) e.g. "-0.4" for 2/2 talent points.
		["frostthreat"] = 0.0, 		-- almost a modifier to global threat (spells only) e.g. "-0.3" for 3/3 talent points.
		["firethreat"] = 0.0, 		-- almost a modifier to global threat (spells only) e.g. "-0.3" for 2/2 talent points.
	},
	["warlock"] = 
	{
		["masterdemo"] = 0.0, 		-- modifier to global threat. e.g. "-0.2" for imp out, 5/5.
		["nemesis"] = false,			-- 8 piece bonus
	},
	["priest"] =
	{
		["silentresolve"] = 0.0, 	-- almost a modifier to global threat (spells only) e.g. "-0.2" for fully talented.
		["shadowaffinity"] = 1.0, 	-- multiplier for shadow damage. e.g. "0.8".
	},
	["paladin"] = 
	{
		["righteousfury"] = 1.0, 	-- multiplier for threat from holy damage / abilities.
		["healing"] = 0.5, 			-- this is actually constant, but really fits best in this variable.
	},
	["shaman"] = 
	{
		["rockbiter"] = 0, 			-- current rank of rockbiter that is active, 0 for none.
		["healing"] = 1.0, 			-- multiplier. e.g. 0.85 for 3/3 Healing Grace.
	}
}

me.redomods = function()
	
	-- talent / gear searching
	local info
	local rank
	local key
	local value
	
	-- warrior
	if mod.my.class == "warrior" then

		-- might 8/8
		if mod.data.getsetpieces("might") == 8 then
			me.mods.warrior.sunderthreat = 1.15
		else
			me.mods.warrior.sunderthreat = 1.0
		end

		-- improved sunder armor
		rank = mod.data.gettalentrank("sunder")
		me.mods.warrior.sundercost = -rank

		-- improved heroic strike
		rank = mod.data.gettalentrank("heroicstrike")
		me.mods.warrior.heroicstrikecost = -rank

		-- defiance
		rank = mod.data.gettalentrank("defiance")
		me.mods.warrior.defiance = 0.03 * rank

		-- impale
		rank = mod.data.gettalentrank("impale")
		me.mods.warrior.impale = 0.05 * rank

	-- rogue
	elseif mod.my.class == "rogue" then
		
		if mod.data.getsetpieces("bloodfang") > 4 then
			me.mods.rogue.feint = 1.25
		else
			me.mods.rogue.feint = 1.0
		end
	
	-- priest
	elseif mod.my.class == "priest" then
		
		-- silent resolve
		rank = mod.data.gettalentrank("silentresolve") 
		me.mods.priest.silentresolve = -0.04 * rank
				
		-- shadow affinity
		rank = mod.data.gettalentrank("shadowaffinity")
		me.mods.priest.shadowaffinity = 1 - rank * 0.25 / 3
	
	-- druid
	elseif mod.my.class == "druid" then
		
		-- subtlety
		rank = mod.data.gettalentrank("druidsubtlety")
		me.mods.druid.subtlety = 1 - 0.04 * rank
			
		-- feral instinct
		rank = mod.data.gettalentrank("feralinstinct")
		me.mods.druid.feralinstinct = 0.03 * rank
		
		-- ferocity
		rank = mod.data.gettalentrank("ferocity")
		me.mods.druid.ferocity = -rank
		
		-- savage fury
		rank = mod.data.gettalentrank("savagefury")
		me.mods.druid.savagefury = rank * 0.1
		
		-- improved tranquility
		rank = mod.data.gettalentrank("tranquility")
		me.mods.druid.tranquilitythreat = 1.0 - rank * 0.4
		
	-- mage
	elseif mod.my.class == "mage" then
		
		-- arcanist 8 piece
		if mod.data.getsetpieces("arcanist") == 8 then
			me.mods.mage.arcanist = true
		else
			me.mods.mage.arcanist = false
		end
		
		-- arcane subtelty
		rank = mod.data.gettalentrank("arcanesubtlety")
		me.mods.mage.arcanethreat = 0.0 - 0.2 * rank

		-- frost channeling
		rank = mod.data.gettalentrank("frostchanneling")
		me.mods.mage.frostthreat = 0.0 - 0.1 * rank
		
		-- burning soul
		rank = mod.data.gettalentrank("burningsoul")
		me.mods.mage.firethreat = 0.0 - 0.15 * rank
		
		-- netherwind 3 piece
		if mod.data.getsetpieces("netherwind") > 2 then
			me.mods.mage.netherwind = true
		else
			me.mods.mage.netherwind = false
		end
	
	-- warlock
	elseif mod.my.class == "warlock" then
		-- master demonologist
		rank = mod.data.gettalentrank("masterdemonologist")
		
		-- check for imp
		if UnitCreatureFamily("pet") == mod.string.get("misc", "imp") then
			me.mods.warlock.masterdemo = -0.04 * rank
		else
			me.mods.warlock.masterdemo = 0
		end
		
		-- nemesis 8 piece
		if mod.data.getsetpieces("nemesis") == 8 then
			me.mods.warlock.nemesis = true
		else
			me.mods.warlock.nemesis = false
		end
		
	-- shaman
	elseif mod.my.class == "shaman" then
		
		-- healing grace
		rank = mod.data.gettalentrank("healinggrace")
		me.mods.shaman.healing = 1.0 - 0.05 * rank
		
	-- paladin
	elseif mod.my.class == "paladin" then
		
		local multi = 1.0
		
		-- righteous fury buff:
		if mod.data.isbuffpresent("Interface\\Icons\\Spell_Holy_SealOfFury") then
			multi = multi + 0.6
		
			-- talents
			rank = mod.data.gettalentrank("righteousfury")
			multi = multi + (0.5 * rank / 3)
		end
		
		me.mods.paladin.righteousfury = multi
	end
	
end


----------------------------------------------------------------------------------------

----------------------------
--  Global Threat Mods    --
----------------------------

--[[
	There are certain threat modifiers that are applied to all threat done, and that stack additively.
For instance with the "Blessing of Salvation" buff, all your threat is reduced by 30%. Wit the Arcanist
8 piece bonus, threat is reduced by 15%, but these bonuses add directly, so that with both bonuses, your 
threat is reduced by 45%.
	mod.my.globalthreat provides a list of all your global bonuses that are currently active. The data is
designed to be easily printed to the user.
	The data is updated frequently, because the modifiers can come on and off at any time. This means once
every OnUpdate, roughly 40 times per second. As a result we take pains to avoid the creation of new lists,
which would otherwise generate excess heap memory.
	me.globalthreat.modifiers is an ARRAY, i.e. a list keyed by [1], [2], [3], etc. Each item of the array the value
is a list with properties
	["value"] - the fractional reduction in threat. -30% from Blessing of Salvation would be "-0.3".
	["reason"] - a description of the effect, for the user's benefit. e.g. "Blessing of Salvation".
	["isactive"] - if false, this value and all further values should be ignored. Since we don't want to keep
	             recreating lists in a frequently called procedure, when a threat modifier is no longer active,
				 <isactive> is set to false, and that value is ignored. A newly added buff will overwrite the
				other data fields, but set <isactive> to true.
	There is one final part me.globalthreat, a key-value pair. The key is "value" and the value is your total
modifier, i.e. the sum of all the modifiers. For a normal character with no buffs / talents / items, this
value would be 1.0, e.g.
	me.globalthreat = 
{
	["value"] = 1.0,
	["modifiers"] = 
	{
		[1] = 
		{
			["value"] = 1.0,
			["reason"] = "Base Value",
			["isactive"] = true,
		}
	}
}
]]
me.globalthreat = 
{
	["value"] = 0.0,
	["modifiers"] = { }
}

--[[ 
me.modifyglobalthreat(value, reason)
Adds a global threat modifier to me.globalthreat.
<value> and <reason> are as defined in me.globalthreat (see comments above).
This method will first look for a value in the me.globalthreat array that is labeled inactive (unused memory) 
and write the values there. Otherwise it will create a new value and append it to the array.
Heap memory creation occurs a maximum of n times, where n is the largest number of +- threat buffs you get.
This is on the order of 5, and for the whole running time, so negligable.
]]
me.modifyglobalthreat = function(value, reason)
	
	-- update the total / sum
	
	-- 1.12: multiplicative threat
	if mod.isnewwowversion then	
		me.globalthreat.value = me.globalthreat.value * (1.0 + value)
		value = 1.0 + value
	else
		me.globalthreat.value = me.globalthreat.value + value
	end
	
	-- look for an unused array position
	local x
	local count = table.getn(me.globalthreat.modifiers)
	
	for x = 1, count do
		
		if me.globalthreat.modifiers[x].isactive == false then
			
			-- found an inactive array index. Activate it and write values
			me.globalthreat.modifiers[x].value = value
			me.globalthreat.modifiers[x].reason = reason
			me.globalthreat.modifiers[x].isactive = true 
			return
		end
	end
	
	-- all the slots in the array are being used. Add a new value to the end
	table.insert(me.globalthreat.modifiers, {["value"] = value, ["reason"] = reason, ["isactive"] = true})
	
end

--[[ 
me.redoglobalthreat()
Recalculates all your global threat modifiers.
]]
me.redoglobalthreat = function()

	-- 1) reset
	local x
	for x = 1, table.getn(me.globalthreat.modifiers) do
		me.globalthreat.modifiers[x].isactive = false
	end
	
	-- 1.12 change: all threat is multiplicative
	if mod.isnewwowversion then
		me.globalthreat.value = 1.0
		me.modifyglobalthreat(0.0, mod.string.get("threatmod", "basevalue"))
		
	else
		me.globalthreat.value = 0.0
		me.modifyglobalthreat(1.0, mod.string.get("threatmod", "basevalue"))
	end
	
	-- 2) rebuild
	
	-- Tranquil Air
	if mod.data.isbuffpresent("Interface\\Icons\\Spell_Nature_Brilliance") == true then
		me.modifyglobalthreat(-0.2, mod.string.get("threatmod", "tranquilair"))
	end
	
	-- Blessing of Salvation
	if mod.data.isbuffpresent("Interface\\Icons\\Spell_Holy_SealOfSalvation") == true then
		me.modifyglobalthreat(-0.3, mod.string.get("threatmod", "salvation"))
		
	elseif mod.data.isbuffpresent("Interface\\Icons\\Spell_Holy_GreaterBlessingofSalvation") == true then
		me.modifyglobalthreat(-0.3, mod.string.get("threatmod", "salvation"))
	end
	
	-- Burning Adrenaline
	if me.states["burningadrenaline"].value == true then
		me.modifyglobalthreat(-0.75, mod.string.get("boss", "spell", "burningadrenaline"))
	end
	
	-- Fetish of the Sand Reaver
	if me.states["arcaneshroud"].value == true then
		me.modifyglobalthreat(-0.7, mod.string.get("spell", "arcaneshroud"))
	end
		
	local linkstring
	local enchant
	
	-- +2% threat enchant to gloves
	linkstring = GetInventoryItemLink("player", 10) or "" 
	_, _, enchant = string.find(linkstring, ".-item:%d+:(%d+).*")
	
	if enchant == "2613" then
		me.modifyglobalthreat(0.02, mod.string.get("threatmod", "glovethreatenchant"))
	end
	
	-- -2% threat enchant to back
	linkstring = GetInventoryItemLink("player", 15) or ""
	_, _, enchant = string.find(linkstring, ".-item:%d+:(%d+).*")
	
	if enchant == "2621" then
		me.modifyglobalthreat(-0.02, mod.string.get("threatmod", "backthreatenchant"))
	end
	
	local stance
	
	-- Warrior
	if mod.my.class == "warrior" then
		stance = me.getstanceindex()
		
		if stance == 1 then
			me.modifyglobalthreat(-0.2, mod.string.get("threatmod", "battlestance"))
			
		elseif stance == 2 then
			me.modifyglobalthreat(0.3, mod.string.get("threatmod", "defensivestance"))
			me.modifyglobalthreat(me.mods.warrior.defiance, mod.string.get("talent", "defiance"))
	
		elseif stance == 3 then
			me.modifyglobalthreat(-0.2, mod.string.get("threatmod", "berserkerstance"))
		end
		
	-- Druid Stances
	elseif mod.my.class == "druid" then
		stance = me.getstanceindex()
		
		if stance == 1 then
			me.modifyglobalthreat(0.3, mod.string.get("threatmod", "bearform"))
			me.modifyglobalthreat(me.mods.druid.feralinstinct, mod.string.get("talent", "feralinstinct"))
			
		elseif stance == 3 then
			me.modifyglobalthreat(-0.2, mod.string.get("threatmod", "catform"))
			
		end
	
	-- Rogue
	elseif mod.my.class == "rogue" then
		me.modifyglobalthreat(-0.2, UnitClass("player"))
		
	-- Arcanist
	elseif (mod.my.class == "mage") and (me.mods.mage.arcanist == true) then
		me.modifyglobalthreat(-0.15, mod.string.get("sets", "arcanist") .. " 8/8")
		
	-- Warlock
	elseif (mod.my.class == "warlock") and (me.mods.warlock.masterdemo ~= 0) then
		me.modifyglobalthreat(me.mods.warlock.masterdemo, mod.string.get("talent", "masterdemonologist"))
	end	
end


--[[ 
me.getstanceindex()
For Druids and Warriors, returns an integer saying which stance you are in.
]]
me.getstanceindex = function()
	
	local x = 0
	local isactive
	local texture 
	
	while true do
		x = x + 1
		texture, _, isactive = GetShapeshiftFormInfo(x)
		
		if texture == nil then
			return 0
		end
		
		if isactive == 1 then
			return x
		end
	end
	
end
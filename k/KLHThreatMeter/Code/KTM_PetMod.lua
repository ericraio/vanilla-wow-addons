
local mod = klhtm
local me = {}
local petthreat
local petincombat = false
mod.pet = me

--[[
PetMod.lua
v1.0 by Ghost, public domain

An extension to measure pet threat for warlocks (maybe hunters?) while solo
playing. Just proof-of-concept code, based on the klhtm framework for making
extensions. It seems to work with DE and EN client voidwalker, on levels 10-60,
assuming all books have been bought. Have fun, but don't expect updates :-)

Known bugs:
-"prin" statements are for debugging purpose only but should not be executed
-target of the pet is ignored
-pet aggro display is not deleted when pet leaves combat
-no talents or whatever are taken into account, only Damage+Torment+Suffering
-no character can use the name Pet
]]


------------------------------------------------------------------------
-- 					   Aggro for Warlocks Voidwalker				  --
------------------------------------------------------------------------

me.myevents = { "CHAT_MSG_SPELL_PET_DAMAGE", "CHAT_MSG_COMBAT_PET_HITS", "CHAT_MSG_COMBAT_HOSTILE_DEATH", "PET_ATTACK_START"}

--[[  
onupdate() function, called from Core.lua
]]
me.onupdate = function()
	-- update combat state
	if UnitAffectingCombat("pet") then
    if petincombat == false then
    	petincombat = true
		end 
	else
    if petincombat == true then
    	petincombat = false
    	mod.table.raiddata[UnitName("pet")] = nil
    	KLHTM_RequestRedraw("raid")
		end 
	end
end

me.onevent = function()

	--prin(string.format("Received the event %s: %s", event, arg1))
	
--	if (mod.my.states.incombat.value == false) then
--		mod.table.raiddata["Pet"] = nil
--	end

	-- This is stage one:
	local output = mod.regex.parse(me.parserset, arg1, event)
	
	if output.hit == nil then
		return
	end
	
	if output.final[1] ~= UnitName("pet") then
		return
	end

	
	if output.parser.identifier == "petattack" then
		me.addpetthreat(output.final[3])
	elseif output.parser.identifier == "petcastaggro" then
		if me.getenglishspell(output.final[2]) == "Torment" then
			me.addpetthreat(me.getthreatvalue(output.final[2]))
		elseif me.getenglishspell(output.final[2]) == "Suffering" then
			if UnitName("target") == output.final[3] then	
				me.addpetthreat(me.getthreatvalue(output.final[2]))
			end
		elseif me.getenglishspell(output.final[2]) == "Growl" then
			me.addpetthreat(me.getthreatvalue(output.final[2]))
		elseif me.getenglishspell(output.final[2]) == "Intimidation" then
			me.addpetthreat(me.getthreatvalue(output.final[2]),True)
		end
	elseif output.parser.identifier == "petspell" then
		me.addpetthreat(output.final[4])
	end

end

--me.onloadcomplete = function()
--	prin("KTM PetMod loaded!!")
--end

-- show pet threat value in raid display
me.addpetthreat = function(value)
--	if not value then prin("no pet threat value to add"); return; end
	if mod.table.raiddata[UnitName("pet")] == nil then
		petthreat = 0
	end

	petthreat = petthreat + value
	mod.table.updateplayerthreat(UnitName("pet"), petthreat)
	KLHTM_RequestRedraw("raid")
	return
end

---- BEGIN spell data
-- minimum player level for each rank
local spellaggrolevel = {
	["Torment"] = {
		60, 50, 40, 30, 20, 10
	},
	["Suffering"] = {
		60, 48, 36, 24
	},
	["Growl"] = {
		60, 50, 40, 30, 20, 10, 1
	},
	["Intimidation"] = {
		1
	}
}
-- aggro value for each rank
local spellaggro = {
	["Torment"] = {
		395, 300, 215, 125,  75,  45
	},
	["Suffering"] = {
		600, 450, 300, 150
	},
	["Growl"] = {
		415, 320, 240, 170, 110, 65, 50
	},
	["Intimidation"] = {
		580
	}
}

me.getthreatvalue = function(spellname)
	spellname = me.getenglishspell(spellname)
	if not spellaggrolevel[spellname] then prin("key not found in spelldata "..spellname); return 0; end
	local i = 1
	while UnitLevel('pet') < spellaggrolevel[spellname][i] do
		i = i + 1
	end
	return spellaggro[spellname][i]
end

me.getenglishspell = function(spellname)
-- translate localised spell name to english version, to match spellaggro data above
	if GetLocale() == "deDE" then
		if spellname == "Qual" then return "Torment"
		elseif spellname == "Leiden" then return "Suffering"
		-- additional translations could be added
		end
	end
	if GetLocale() == "koKR" then
		if spellname == "고문" then return "Torment"
		elseif spellname == "고통" then return "Suffering"
		elseif spellname == "포효" then return "Growl"
		elseif spellname == "위협" then return "Intimidation"
				-- additional translations could be added
		end
	end
	return spellname
end
---- END spell data

me.parserset = { }
me.onload = function()

	local parserdata
	
	for _, parserdata in me.parserconstructor do
		mod.regex.addparsestring(me.parserset, parserdata[1], parserdata[2], parserdata[3])
	end
		
end

--[[
List of all the parsers we use. The first value is the identifier, the second value is the name of the variable
defined in GlobalStrings.lua, and the third variable is the event the parser works on.
]]
me.parserconstructor = 
{
	{"petcastaggro", "SPELLCASTGOOTHERTARGETTED", "CHAT_MSG_SPELL_PET_DAMAGE"}, 		-- %1$s wirkt %2$s auf %3$s. "You hit %s for %d."
	{"petcastaggro", "SIMPLECASTOTHEROTHER", "CHAT_MSG_SPELL_PET_DAMAGE"},
	
	{"petattack", "COMBATHITCRITOTHEROTHER", "CHAT_MSG_COMBAT_PET_HITS"}, -- %1$s trifft %2$s fA¼r %3$d Schaden. "You crit %s for %d."
	{"petattack", "COMBATHITOTHEROTHER", "CHAT_MSG_COMBAT_PET_HITS"}, -- %1$s trifft %2$s fA¼r %3$d Schaden. "You crit %s for %d."
	
	{"petspell", "SPELLLOGCRITSCHOOLOTHEROTHER", "CHAT_MSG_SPELL_PET_DAMAGE"},	-- "%ss %s trifft %s kritisch fA¼r %d %s Schaden."
	{"petspell", "SPELLLOGSCHOOLOTHEROTHER", "CHAT_MSG_SPELL_PET_DAMAGE"},

	{"petspell", "SPELLLOGOTHEROTHER", "CHAT_MSG_SPELL_PET_DAMAGE"},	-- "%ss %s trifft %s kritisch fA¼r %d %s Schaden."
	{"petspell", "SPELLLOGCRITOTHEROTHER", "CHAT_MSG_SPELL_PET_DAMAGE"},
	
--	{"abilityhit", "SPELLLOGSELFOTHER", "CHAT_MSG_SPELL_SELF_DAMAGE"}, 			-- "Your %s hits %s for %d."
--	{"abilitycrit", "SPELLLOGCRITSELFOTHER", "CHAT_MSG_SPELL_SELF_DAMAGE"}, 	-- "Your %s crits %s for %d."
}



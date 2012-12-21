
-- Add the module to the tree
local mod = klhtm
local me = {}
mod.combatparser = me

--[[
CombatParser.lua

This module is the bridge between Regex.lua and Combat.lua. Given a combat log event, it feeds it to the parser.
If successful, the parser will return a set of arguments, and an identifier that describes the combat log line, such as "whiteattackhit".

CombatParser then works out what to do with the arguments. That is, it massages them into a format for Combat.lua's methods.

]]

me.myevents = { "CHAT_MSG_COMBAT_SELF_HITS", "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF", "CHAT_MSG_SPELL_SELF_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS", "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "CHAT_MSG_SPELL_SELF_BUFF", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" }

-- OnEvent() - called from Core.lua.
me.onevent = function()

	-- This is stage one:
	local output = mod.regex.parse(me.parserset, arg1, event)
	
	if output.hit == nil then
		return
	end

	-- Reset combat args
	me.action.type = ""
	me.action.spellname = ""
	me.action.spellid = ""
	me.action.damage = 0
	me.action.target = ""
	me.action.iscrit = false
	me.action.spellschool = ""
	
	-- check a stage two handler is defined
	if me.parserstagetwo[output.parser.identifier] == nil then
		if mod.out.checktrace("error", me, "parser") then
			mod.out.printtrace(string.format("No handler is defined for a %s parse!", output.parser.identifier))
		end
		return
	end
	
	-- run the stage two handler
	me.parserstagetwo[output.parser.identifier](output.final[1], output.final[2], output.final[3], output.final[4], output.final[5])

   -- check a stage 3 handler is defined
   if me.parserstagethree[me.action.type] == nil then
		if mod.out.checktrace("error", me, "parser") then   
			mod.out.printtrace(string.format("No stage handler is defined for a %s action!", me.action.type))
		end
		return
	end
	
   -- run the stage 3 handler
   me.parserstagethree[me.action.type]()
   
end

--[[
type can be:

attack			anything that causes damage
heal				any source of healing from you
powergain		you gain x rage / mana / energy
nothing			actions that don't change threat
special			non-damaging abilities, e.g. taunt / feint

]]

me.action = 
{
	type = "",
	spellname = "",
	spellid = "",
	damage = 0,
	target = "",
	iscrit = false,
	spellschool = "",
}

--[[
Combining some parsers is possible. e.g. autoattack hits and crits can go together. Even if in one locale they look completely different, or have different orderings, once they go through stage one they will come out the same. And for an autoattack we don't care whether it's a crit or not (only for abilities, to calculate the rage cost of heroic strike or maul more accurately).
]]
me.parserstagetwo = 
{
	["autoattack"] = function(target, damage)
		me.action.spellid = "whitedamage"
		me.action.damage = damage
		me.action.target = target
		me.action.type = "attack"
      
	end,
	
	["damageshield"] = function(damage, school, target)
		me.action.damage = damage
		me.action.target = target
		me.action.spellschool = school
    me.action.type = "attack"
		me.action.spellid = "damageshield"
		
	end,
	
	["abilityhit"] = function(name, target, damage)
		me.action.spellname = name
		me.action.damage = damage
		me.action.target = target
	   me.action.type = "attack"
      
	end,
	
	["abilitycrit"] = function(name, target, damage)
		me.action.spellname = name
		me.action.damage = damage
		me.action.target = target
		me.action.iscrit = true
		me.action.type = "attack"
      
	end,
	
	["spellhit"] = function(name, target, damage, school)
		me.action.spellname = name
		me.action.damage = damage
		me.action.target = target
		me.action.spellschool = school
		me.action.type = "attack"
      
	end,
	
	["spellcrit"] = function(name, target, damage, school)
		me.action.spellname = name
		me.action.damage = damage
		me.action.target = target
		me.action.spellschool = school
		me.action.iscrit = true
		me.action.type = "attack"
      
	end,
	
	["perform"] = function(name, target)
		me.action.spellname = name
		me.action.target = target
		me.action.type = "special"
      
	end,
	
	["spellcast"] = function(name, target)
		me.action.spellname = name
		me.action.target = target
		me.action.type = "special"
      
	end,

	["othersdotonother"] = function(target, damage, school, author, name)
    me.action.type = "nothing"
    if (GetLocale() == "koKR") then
      local korname = author.."의 "..name
      if (korname == "어둠의 권능: 고통" or korname == "파멸의 역병" or korname == "정신의 채찍" or
        korname == "고통의 저주" or korname == "불의 비" or korname == "폭발의 덫" or korname == "제물의 덫") then
        me.action.spellname = korname
        me.action.spellid = "dot"
        me.action.damage = damage
        me.action.target = target
        me.action.spellschool = school
        me.action.type = "attack"
      end
		end
    
	end,

	["dot"] = function(target, damage, school, name)
		me.action.spellname = name
		me.action.spellid = "dot"
		me.action.damage = damage
		me.action.target = target
		me.action.spellschool = school
		me.action.type = "attack"
      
	end,
	
	["yourhotonother"] = function(target, damage, name)
		me.action.spellname = name
		me.action.damage = damage
		me.action.target = target
		me.action.type = "heal"
      
	end,
	
	-- check that we don't do anything when we get this
	["othershotonyou"] = function()
	   me.action.type = "nothing"
      
	end,
	
	["othershotonother"] = function()
	   me.action.type = "nothing"
      
	end,
	
	-- healing on self. Leave target = nil
	["hotonself"] = function(damage, name)
		me.action.spellname = name
		me.action.damage = damage
		me.action.type = "heal"
      
	end,
	
	-- powertype is put in the target section
	["powergain"] = function(damage, powertype, name)
		me.action.spellname = name
		me.action.damage = damage
		me.action.target = powertype
		
		me.action.type = "powergain"
      
	end,
	
	["healonself"] = function(name, damage)
		me.action.spellname = name
		me.action.damage = damage
		me.action.type = "heal"
      
	end,
	
	["healonother"] = function(name, target, damage)
		me.action.spellname = name
		me.action.damage = damage
		me.action.target = target
		me.action.type = "heal"
      
	end,
	
}

me.parserstagethree = 
{
   ["attack"] = function()
		
		-- 1) Check for special abilities
		if me.action.spellid == "" then
			me.action.spellid = mod.string.unlocalise("spell", me.action.spellname)
		end
		
		if me.action.spellid and mod.data.spells[me.action.spellid] then
			-- this is a special
			mod.combat.specialattack(me.action.spellid, me.action.target, me.action.damage, me.action.iscrit, me.action.spellschool)
			
		else
			-- this is a normal attack, or is not modified by threat
			mod.combat.normalattack(me.action.spellname, me.action.spellid, me.action.damage, nil, me.action.target, me.action.iscrit, me.action.spellschool)
		end
		
		KLHTM_RequestRedraw("self")
	end,
	
	["heal"] = function()
		if me.action.target == "" then
			me.action.target = UnitName("player")
		end
		
		-- check for a spellid
		me.action.spellid = mod.string.unlocalise("spell", me.action.spellname)
		
		mod.combat.possibleoverheal(me.action.spellname, me.action.spellid, me.action.damage, me.action.target)
		
		KLHTM_RequestRedraw("self")
	end,
	
	["nothing"] = function()
	
	end,
	
	["powergain"] = function()
		me.action.spellid = mod.string.unlocalise("spell", me.action.spellname)
		mod.combat.powergain(me.action.damage, me.action.target, me.action.spellid)
		
		KLHTM_RequestRedraw("self")
	end,
	
	["special"] = function()
		
		-- 1) Unlocalise the ability. e.g. "Heroic Strike" -> "heroicstrike", "Heldenhafter Sto\195\159" -> "heroicstrike"
		me.action.spellid = mod.string.unlocalise("spell", me.action.spellname)
		
		-- 2) Taunt / Growl
		if (me.action.spellid == "taunt") or (me.action.spellid == "growl") then
			mod.combat.taunt(me.action.target)
			
		-- 3) Special Abilities
		elseif me.action.spellid and mod.data.spells[me.action.spellid] then
			mod.combat.specialattack(me.action.spellid, me.action.target, 0, nil, nil)
			
		-- 4) Unrelated abilities
		else
			return
		end
		
		KLHTM_RequestRedraw("self")
		
	end,
	
}

--[[
------------------------------------------------------------------------------
			Section B: Creating the Parser Engine at Startup
------------------------------------------------------------------------------
]]

me.parserset = { }

-- Special OnLoad() method called from Core.lua.
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
	{"autoattack", "COMBATHITSELFOTHER", "CHAT_MSG_COMBAT_SELF_HITS"}, 		-- "You hit %s for %d."
	{"autoattack", "COMBATHITCRITSELFOTHER", "CHAT_MSG_COMBAT_SELF_HITS"}, -- "You crit %s for %d."
	
	{"damageshield", "DAMAGESHIELDSELFOTHER", "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF"}, -- "You reflect %d %s damage to %s."
	
	{"abilityhit", "SPELLLOGSELFOTHER", "CHAT_MSG_SPELL_SELF_DAMAGE"}, 			-- "Your %s hits %s for %d."
	{"abilitycrit", "SPELLLOGCRITSELFOTHER", "CHAT_MSG_SPELL_SELF_DAMAGE"}, 	-- "Your %s crits %s for %d."
	{"spellhit", "SPELLLOGSCHOOLSELFOTHER", "CHAT_MSG_SPELL_SELF_DAMAGE"},		-- "Your %s hits %s for %d %s damage."
	{"spellcrit", "SPELLLOGCRITSCHOOLSELFOTHER", "CHAT_MSG_SPELL_SELF_DAMAGE"}, -- "Your %s crits %s for %d %s damage."
	{"perform", "SPELLPERFORMGOSELFTARGETTED", "CHAT_MSG_SPELL_SELF_DAMAGE"}, 	-- "You perform %s on %s."
	{"spellcast", "SPELLCASTGOSELFTARGETTED", "CHAT_MSG_SPELL_SELF_DAMAGE"},	-- "You cast %s on %s."
	
  {"othersdotonother", "PERIODICAURADAMAGEOTHEROTHER", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"}, -- added for korean
	{"dot", "PERIODICAURADAMAGESELFOTHER", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"}, -- "%s suffers %d %s damage from your %s."
	


  
	{"othershotonother", "PERIODICAURAHEALOTHEROTHER", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS"}, -- "%s gains %d health from %s' %s."
	{"yourhotonother", "PERIODICAURAHEALSELFOTHER", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS"}, -- "%s gains %d health from your %s."
  
	{"othershotonother", "PERIODICAURAHEALOTHEROTHER", "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS"}, -- "%s gains %d health from %s' %s."
	{"yourhotonother", "PERIODICAURAHEALSELFOTHER", "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS"}, -- "%s gains %d health from your %s."
  
	{"othershotonyou", "PERIODICAURAHEALOTHERSELF", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"}, -- "You gain %d health from %s's %s."
	{"othershotonother", "PERIODICAURAHEALOTHEROTHER", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"}, -- "You gain %d health from %s's %s."
	{"yourhotonother", "PERIODICAURAHEALSELFOTHER", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"}, -- "%s gains %d health from your %s."

	{"hotonself", "PERIODICAURAHEALSELFSELF", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"},-- "You gain %d health from %s."
	{"powergain", "POWERGAINSELFSELF", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"},		-- "You gain %d %s from %s."
	
	{"healonother", "HEALEDSELFOTHER", "CHAT_MSG_SPELL_SELF_BUFF"},			-- "Your %s heals %s for %d."
	{"healonother", "HEALEDCRITSELFOTHER", "CHAT_MSG_SPELL_SELF_BUFF"},		-- "Your %s critically heals %s for %d."	
	{"healonself", "HEALEDSELFSELF", "CHAT_MSG_SPELL_SELF_BUFF"},			-- "Your %s heals you for %d."
	{"healonself", "HEALEDCRITSELFSELF", "CHAT_MSG_SPELL_SELF_BUFF"},		-- "Your %s critically heals you for %d."
	{"powergain", "POWERGAINSELFSELF", "CHAT_MSG_SPELL_SELF_BUFF"},			-- "You gain %d %s from %s."
}

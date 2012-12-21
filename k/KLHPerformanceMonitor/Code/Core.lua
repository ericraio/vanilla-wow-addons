
--[[

A module can optionally have

1) .myevents 	-	a list of strings, the events to register
2) .onload		-	to be called on startup
3) .onloadcomplete	to be called after all other modules have been loaded.
3) .onevent		-	will do your onevent. Currently sends all events to you, we should fix it to send only your events!
4) .onupdate	-	you can guess this one!
5) .isenabled	-	whether to receive onload, onevent, onupdate commands. Must be <false> to not be called


Managing your Variables / Methods

--> Initialise static data anywhere in your code file
--> Initialise variables that depend on other module's static data in your onload() method
--> Initialise variables that depend on other module's variables in your onloadcomplete() method


Each module has a key / branch in the master table. The following keys have been taken:

]]

-- table setup
local mod = thismod
local me = { }
mod.core = me

me.frame = nil -- set at runtime 

-- Mod Version
me.release = 3
me.revision = 1
me.build = 4

--[[
Release	Build
	1		
]]


me.events = { } --[[ 
Remember which module wants which events.
It will look like
{
	["combat"] = 
	{
		["CHAT_MSG_SPELL_SELF_BUFF"] = true,
	},
}
if the combat module has registered CHAT_MSG_SPELL_SELF_BUFF
]]


me.isloaded = false -- true when .onload has been called for all sub-modules
me.isenabled = true -- iif false, onupdate and onevent will not be called

-- onload
mod.onload = function()
	
	-- find frame
	me.frame = getglobal(mod.string.get("print", "core", "frame"))
	
	-- initialise all submodules
	for key, subtable in mod do
		if type(subtable) == "table" and subtable.onload and subtable.isenabled ~= "false" then
			subtable.onload()
		end
	end
	
	me.isloaded = true 
	
	-- register events. Strictly after all modules have been loaded.
	for key, subtable in mod do
		if type(subtable) == "table" and subtable.myevents then
			
			me.events[key] = { }
			
			for _, event in subtable.myevents do
				me.frame:RegisterEvent(event)
				me.events[key][event] = true 
			end
		end
	end
	
	-- onloadcomplete
	for key, subtable in mod do
		if type(subtable) == "table" and subtable.onloadcomplete and subtable.isenabled ~= "false" then
			subtable.onloadcomplete()
		end
	end
	
	-- Print load message
	mod.out.print(string.format(mod.string.get("print", "core", "startupmessage"), me.release, me.revision), nil, true)
end

-- OnUpdate
mod.onupdate = function()
		
	-- only call when everything has been loaded
	if me.isloaded ~= true then
		return
	end
	
	-- don't call if the entire addon is disabled
	if me.isenabled == false then
		return
	end
	
	for key, subtable in mod do
		if type(subtable) == "table" and subtable.onupdate and subtable.isenabled ~= "false" then
			subtable.onupdate()
		end
	end
	
end

-- OnEvent
mod.onevent = function()

	-- don't call if the entire addon is disabled
	if me.isenabled == false then
		return
	end

	for key, subtable in mod do
		-- 1) The subtable is a valid module - is a table and has a .onevent property.
		-- 2) The subtable is not disabled
		-- 3) The subtable has registered the event
		if type(subtable) == "table" and subtable.onevent and subtable.isenabled ~= "false" and me.events[key][event] then
			
			subtable.onevent()
		end
	end
	
end

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
	out	
	alert
	console
	string
	combat
	data
	my
	table
	net,	netin
	gui,	guiopt,	guiraid, some other gui
	boss
	diag
]]

-- table setup
klhtm = { }
local me = klhtm
me.frame = nil -- set at runtime 

-- Mod Version
me.release = 17
me.revision = 12
me.build = 203

--[[
Release	Build
	 1	  6
	 2	 11
	 3	 30
	 4	 32
	 5	 44
	 6	 54
	 7	 73
	 8	 80
	 9	 92
	10	103
	11	116
	12	124
	13	141
	14	156
	15	177
	16	189
	16b 192
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

-- This checks whether you are on the 0.12 PTR or 1.12+ live (vs 1.11 live)
if SendAddonMessage then
	me.isnewwowversion = true
end

me.isloaded = false -- true when .onload has been called for all sub-modules
me.isenabled = true -- iif false, onupdate and onevent will not be called

-- onload
me.onload = function()
	
	-- find frame
	me.frame = KLHTM_OnUpdateFrame
	
	-- initialise all submodules
	for key, subtable in me do
		if type(subtable) == "table" and subtable.onload and subtable.isenabled ~= "false" then
			subtable.onload()
		end
	end
	
	me.isloaded = true 
	
	-- register events. Strictly after all modules have been loaded.
	for key, subtable in me do
		if type(subtable) == "table" and subtable.myevents then
			
			me.events[key] = { }
			
			for _, event in subtable.myevents do
				me.frame:RegisterEvent(event)
				me.events[key][event] = true 
			end
		end
	end
	
	-- onloadcomplete
	for key, subtable in me do
		if type(subtable) == "table" and subtable.onloadcomplete and subtable.isenabled ~= "false" then
			subtable.onloadcomplete()
		end
	end
	
	-- Print load message
	me.out.print(string.format(me.string.get("print", "main", "startupmessage"), me.release, me.revision), nil, true)
	
	-- notify of 1.12 override
	if me.isnewwowversion then
		me.out.print("The WoW version is 0.12 or 1.12 or higher, so the mod is using multiplicative threat and no longer using a chat channel for communication.")
	end
	
end

-- OnUpdate
me.onupdate = function()
		
	-- only call when everything has been loaded
	if me.isloaded ~= true then
		return
	end
	
	-- don't call if the entire addon is disabled
	if me.isenabled == false then
		return
	end
	
	for key, subtable in me do
		if type(subtable) == "table" and subtable.onupdate and subtable.isenabled ~= "false" then
			me.diag.logmethodcall(key, "onupdate")
		end
	end
	
end

-- OnEvent
me.onevent = function()

	-- don't call if the entire addon is disabled
	if me.isenabled == false then
		return
	end

	for key, subtable in me do
		-- 1) The subtable is a valid module - is a table and has a .onevent property.
		-- 2) The subtable is not disabled
		-- 3) The subtable has registered the event
		if type(subtable) == "table" and subtable.onevent and subtable.isenabled ~= "false" and me.events[key][event] then
			
			me.diag.logmethodcall(key, "onevent")
		end
	end
	
end

--[[
klhtm.emergencystop()
Stops all processing of events and onupdates. Just in case! This is unlocalised and raw to make sure it works even if there are errors elsewhere in the program.
]]
me.emergencystop = function()
	
	me.isenabled = false
	
	ChatFrame1:AddMessage("KLHThreatMeter emergency stop! |cffffff00/ktm|r e to resume.")
	
end
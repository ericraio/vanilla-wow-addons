
local mod = klhtm
local me = { }
mod.diag = me

--[[
KTM_Diagnostic.lua

This module monitors computer performance and how it is affected by the rest of the mod. It is useful to check for
methods that are using excessive amounts of memory or processor time.

Whenever the KTM_Core.lua is about to call a module's .onevent() or .onupdate() methods, it instead sends the method to mod.diag.logmethodcall(module, methodtype). The time taken in milliseconds and memory used in kilobytes is recorded. For each module that has a .onevent() or .onupdate() method, a separate entry is kept, which records the total value,average rate, maximum rate over 5 seconds and rate in the last 5 seconds.

To print out the memory data, run the command "/ktm test memory"; for timing data, "/ktm test time".

Times are recorded in one second intervals. So whenever a method is called, the .current value of the relevant dataset is incremented. Then every second, there is a collation, where .current is added to .history, and .total and .recordinterval are updated. This is done in me.onupdate().

]]


me.lastcollation = GetTime() -- value of GetTime(). Happens once a second.
me.datalogstart = GetTime() -- when we started logging times. For the "average rate" value.

--[[
timing / memory data set. Each module-method combination has a separate set. e.g. there is one for the .onevent() function of the .combat module.
]]
me.createnewdataset = function()

	return
	{
		["total"] = 0,
		["history"] = {0, 0, 0, 0, 0}, 	-- values for the last 5 seconds
		["historylength"] = 5,
		["current"] = 0, 				-- working value for the current second
		["recordinterval"] = 0,			-- maximum sum of .history
	}

end

--[[
All the data we keep is in this table. At startup, we can only be sure the "total" sets will exist - we don't know which modules have a .onupdate or .onevent method. As soon as those methods are called for the first time, we will add a data set for them.
]]
me.data = 
{
	["memory"] =
	{
		["onupdate"] = 
		{
			["total"] = me.createnewdataset(),
		},
		["onevent"] = 
		{
			["total"] = me.createnewdataset(),
		},
		["total"] = me.createnewdataset(),
	},
	["time"] =
	{
		["onupdate"] = 
		{
			["total"] = me.createnewdataset(),
		},
		["onevent"] = 
		{
			["total"] = me.createnewdataset(),
		},
		["total"] = me.createnewdataset(),
	}
}

--[[
mod.diag.logmethodcall(module, calltype)
Runs the special Core.lua methods, and logs the timing and memory usage.
<module> is a string, the key for a module, e.g. "combat", "string", "netin", etc.
<calltype> is either "onupdate" or "onevent".
]]
me.logmethodcall = function(module, calltype)

	local method = mod[module][calltype]
	local memory
	local time
	
	local manualstart = GetTime()
	memory, time = me.getfunctionstats(method)
	local manualtime = math.floor(0.5 + (GetTime() - manualstart) * 1000)
	
	-- Scrub out bullshit values! > 100ms = bs, > 10 ms = should be traced. < 0 kb = bs (gc).
	-- Sometimes debugprofile gives completely spasticated values for unknown reasons. Also we might get a negative
	-- value for memory if a garbage collection occurs.
	if time > 100 or time < 0 or math.abs(time - manualtime) > 5 then
		time = 0
	elseif time > 10 then
		if mod.out.checktrace("info", me, "timing") then
			mod.out.printtrace(string.format("Time from %s %s is %s ms (manual says %s ms) (memory was %s).", module, calltype, me.formatdecimal(time), manualtime, memory))
		end
	end
	
	if memory < 0 then
		memory = 0
	end
	
	me.adddatapoint("time", calltype, module, time)
	me.adddatapoint("memory", calltype, module, memory)
	
end

--[[
me.getfunctionstats(method)
Runs the the function <method>, and records how much time was taken, and memory used.
Returns: <memory, in whole kilobytes>, <time, in fractional milliseconds>.
]]
me.getfunctionstats = function(method) 

	local memorystart = gcinfo()
	local timestart = debugprofilestop()
	
	method()
	
	local timetaken = (debugprofilestop() - timestart) 
	local memoryused = gcinfo() - memorystart
	
	return memoryused, timetaken
end


--[[
me.adddatapoint(datatype, calltype, module, value)
Adds <value> to the .current property of the relevant dataset. Also adds it to any parent sets, e.g. "total".
<datatype> is "memory" or "time"
<calltype> is "onupdate" or "onevent"
<module> is "combat", "string", "data", etc.
]]
me.adddatapoint = function(datatype, calltype, module, value)

	if me.data[datatype][calltype][module] == nil then
		me.data[datatype][calltype][module] = me.createnewdataset()
	end
	
	me.data[datatype][calltype][module].current = me.data[datatype][calltype][module].current + value
	me.data[datatype][calltype].total.current = me.data[datatype][calltype].total.current + value
	me.data[datatype].total.current = me.data[datatype].total.current + value

end

--[[
Special Core.lua method. If this "second" has ended (i.e. it's been at least 1 second since the last collation),
then run a collation.
]]
me.onupdate = function()

	local timenow = GetTime()
	
	-- update at most once a second
	if timenow < me.lastcollation + 1.0 then
		return
	end

	me.collatetable(me.data, timenow - me.lastcollation)
	me.lastcollation = timenow
end

--[[
me.collatetable(data, period)
Collating a dataset is to finalise the ".current" value, add it to history, update total, etc.
This is a recursive method. <data> might be a data set (base case), or it might be a tree containing datasets (note the
structure of me.data). If it is a tree, then me.collatetable will be called on any subtrees inside it.
<period> = time in seconds this collation is over. It will be at least 1, and close to 1, but not exactly 1. Since we want
to record the rate, e.g. KB/sec, we have to divide by this value.
]]
me.collatetable = function(data, period)

	if data.current == nil then
		-- this guy is a table, with subtables. do the subtables.
		
		local value
		for _, value in data do
			me.collatetable(value, period)
		end
		
		return
	end

	-- this guy is an actual data set	
	local x
	local interval = 0
	
	for x = data.historylength - 1, 1, -1 do
		data.history[x + 1] = data.history[x]
		interval = interval + data.history[x]
	end
	
	-- take into account period length (we want / second)
	data.history[1] = data.current / period
	interval = interval + data.history[1]
	data.total = data.total + data.current
	
	-- check for new record 5 second burst
	if interval > data.recordinterval then
		data.recordinterval = interval
	end
	
	-- reset the current value, it's a new second
	data.current = 0

end

--[[
mod.diag.printdataset(datatype, units)
This is called when a console command "/ktm test time" or "/ktm test memory" is run.
<datatype> is "time" or "memory"
<datatype> is a description of the units, e.g. "Milliseconds per Second".
]]
me.printalldata = function(datatype, units)

	-- print total, then subcategories, recursively.
	mod.out.print(string.format("|cff6666ffThis is a listing of |cffffff00%s |cff6666ffusage. Units are |cffffff00%s.|r", datatype, units))
	
	local data = me.data[datatype]
	local key
	local value
	
	-- grand total
	me.printdataset("|cffff3333Total", data.total)
	
	-- onupdates
	me.printdataset("|cff66ff66OnUpdates", data.onupdate.total)
	
	for key, value in data.onupdate do
		if key ~= "total" then
			me.printdataset("|cffffff00" .. key, value)
		end
	end
	
	-- onevents
	me.printdataset("|cff66ff66OnEvents", data.onevent.total)
	
	for key, value in data.onevent do
		if key ~= "total" then
			me.printdataset("|cffffff00" .. key, value)
		end
	end
	
end

--[[
me.printdataset(name, set)
This prints the values of an individual data set.
<name> is the name of the module or category, with colouring.
<set> is the actual data set.
]]
me.printdataset = function(name, set)

	local x
	local last5 = 0
	
	for x = 1, 5 do
		last5 = last5 + set.history[x]
	end
	
	mod.out.print(string.format("%s:|r Total = %s, Avg = %s, Burst = %s, Recent = %s.", 
		name, me.formatdecimal(set.total), me.formatdecimal(set.total / (GetTime() - me.datalogstart)), me.formatdecimal(set.recordinterval / 5), me.formatdecimal(last5 / 5)))

end

--[[
me.formatdecimal(value)
Returns a string representation of <value>, including up the the first place after the decimal, if it exists.
]]
me.formatdecimal = function(value)

	if floor(value) == value then
		return string.format("%d", value)

	else
		local base = string.format("%f", value)
		local dotpoint = string.find(base, "%.")
		return string.sub(base, 1, dotpoint + 1)
	end
end

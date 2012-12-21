
--[[

Code for manipulating a data set.

]]

-- table setup
local mod = thismod
local me = { }
mod.dataset = me


--[[
add <value> to <dataset>.current
]]
me.adddatapoint = function(dataset, value)

	dataset.current = dataset.current + value

	me.updatedataset(dataset)
end

--[[
me.updatedataset for tree with nested data sets.
This method is currently unused.
]]
me.updatedatatree = function(tree)

	if tree.current then
		-- this is an ordinary dataset
		me.updatedataset(tree)
		
	else
	
		local value
		
		for _, value in tree do
			if type(value) == "table" then
				me.updatedatatree(value)
			end
		end
	end

end

--[[
Manage ticks / history, etc
]]
me.updatedataset = function(data)

	local timenow = GetTime()
	local sum
	
	if timenow < data.lasttick + data.ticklength then
		-- not time for a new tick
		return
	end
	
	-- do a new tick
	data.totalticks = data.totalticks + 1
	data.lasttick = timenow

	-- add recent value to history
	local x
	sum = 0
	
	for x = data.historylength, 2, -1 do 
		data.history[x] = data.history[x - 1]
		sum = sum + data.history[x]
	end
	
	data.history[1] = data.current
	sum = sum + data.current
	data.currenthistorysum = sum
	
	if sum > data.maxhistory then
		data.maxhistory = sum
	end
	
	-- increment total
	data.total = data.total + data.current
	data.current = 0
	
	return true 
end

--[[
mod.dataset.createnewdataset(ticklength, historylength)
Returns a newly created dataset.
<ticklength> is a fractional value, in seconds, how long each update period is.
<historylength> is an integer, the number of recent values that are kept in record.
The history is used to get an average usage over a decently long period of time.
]]
me.createnewdataset = function(ticklength, historylength)

	local value = 
	{
		["total"] = 0,
		["ticklength"] = ticklength,
		["totalticks"] = 0,
		["lasttick"] = GetTime(),
		["starttime"] = GetTime(),
		["history"] = { }, 	
		["historylength"] = historylength,
		["current"] = 0,
		["maxhistory"] = 0,	
		["currenthistorysum"] = 0,
	}
	
	local x
	
	for x = 1, value.historylength do
		table.insert(value.history, 0)
	end
	
	return value
end

--[[
mod.dataset.resetdataset(data)
<data> is the dataset to reset.
This will return it to factory settings.
]]
me.resetdataset = function(data)

	data.total = 0
	data.totalticks = 0
	data.lasttick = GetTime()
	data.starttime = GetTime()
	me.clearhistory(data)

end

--[[
mod.dataset.clearhistory(data)
<data> is the dataset to clear.
This will just remove the history. 
]]
me.clearhistory = function(data)

	local x
	
	for x = 1, data.historylength do
		data.history[x] = 0
	end
	
	for x = 1, data.deephistorylength do
		data.deephistory[x] = 0
	end
	
	data.maxhistory = 0
	data.maxdeephistory = 0
end

--[[
print a specific data set.
This method is currently unused.
]]--
me.printdataset = function(dataset, description)

	local totaltime = dataset.lasttick - dataset.starttime
	local tickmultiplier = dataset.totalticks / (totaltime / dataset.ticklength)
	local historytime = math.min(totaltime, dataset.ticklength * dataset.historylength) * tickmultiplier
	local historyaverage = 0
	
	local x
	
	for x = 1, dataset.historylength do
		historyaverage = historyaverage + dataset.history[x]
	end
	
	historyaverage = historyaverage / historytime


	mod.out.print(string.format("|cffffff00%s:|r Total = |cff00ffff%s|r. Average = |cff00ffff%s|r over |cff00ff00%s|r secs, |cff00ffff%s|r over |cff00ff00%s|r secs.", 
		description, me.formatdecimal(dataset.total), me.formatdecimal(dataset.total / totaltime), me.formatdecimal(totaltime), me.formatdecimal(historyaverage), me.formatdecimal(historytime)))

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
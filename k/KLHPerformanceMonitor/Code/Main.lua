
--[[

Main.lua

This module does all the work. It hooks every OnEvent and OnUpdate function in existance.

]]

-- table setup
local mod = thismod
local me = { }
mod.main = me

me.ishooking = false

--[[
me.hookall()
Hooks all the OnUpdate() and OnEvent() methods running.

First thing is to gather all frames. We make a table, key = the frame itself, value = {onevent = <true or nil>, onupdate = <true or nil>}
]]
me.hookall = function()

	-- this method can only be run once - check!
	if me.ishooking == true then
		mod.out.print("The monitor has already been loaded, and is actively recording data.")
		return
	end

	local frame, script
	local numonevents = 0
	local numonupdates = 0
	local numframes = 0
	local numemptyframes = 0
	
	-- first let's find all the frames
	local allframes = { }
	local hasonupdate, hasonevent
		
	while true do
		
		-- get next frame
		frame = EnumerateFrames(frame)
		if frame == nil then
			break
		end
	
		numframes = numframes + 1
		allframes[frame] = {me = frame, numchildren = 0, children = { }}
		
		-- Determine whether the frame has onupdates or onevents
		hasonupdate = frame:GetScript("OnUpdate")
		hasonevent = frame:GetScript("OnEvent")
		
		if hasonevent then
			numonevents = numonevents + 1
			allframes[frame].onevent = true
		end
		
		if hasonupdate then
			numonupdates = numonupdates + 1
			allframes[frame].onupdate = true 
		end
		
		-- add the name property
		allframes[frame].name = frame:GetName()
		
	end 
	
	-- print
	mod.out.print(string.format("Found %s frames, %s onupdates, %s onevents.", numframes, numonupdates, numonevents))
	
	-- Now, find anonymous frames whose parents have known parents (not uiparent)
	local numanonymous, numnamed, parent
	local key, value, parentvalue
	
	-- for loop as a safety limit, for now
	for x = 1, 10 do
		numanonymous = 0
		numnamed = 0
		
		for key, value in allframes do
			if value.name == nil then
				numanonymous = numanonymous + 1
				
				-- check for parent
				parent = key:GetParent()
				parentvalue = allframes[parent]
				
				if parentvalue and parentvalue.name and parentvalue.name ~= "UIParent" then
					-- we've found a good parent
					parentvalue.numchildren = parentvalue.numchildren + 1
					numnamed = numnamed + 1
					value.name = parentvalue.name .. "$child" .. parentvalue.numchildren
					table.insert(parentvalue.children, value)
					
				elseif x == 10 then
					-- we just can't find the name for this frame's parents, no matter what. Better scrap it
					allframes[key] = nil
				end
			end
		end
		
		--mod.out.print(string.format("x = %d, found %d anonymous, named %d.", x, numanonymous, numnamed))
		
		if numnamed == 0 then
			break
		end
	end
	
	local totalframes, framesdropped
	
	for x = 1, 10 do
		totalframes = 0
		framesdropped = 0
			
		for key, value in allframes do

			totalframes = totalframes + 1
			
			-- 1) check 0 children
			if value.numchildren == 0 then
			
				-- check no event on onupdate
				if value.onupdate == nil and value.onevent == nil then
					framesdropped = framesdropped + 1
					
					-- check for anonymous frame
					if key:GetName() == nil then
						-- remove name from parent's list
						parentvalue = allframes[key:GetParent()]
						
						-- parentvalue might not exist now
						if parentvalue then
							for y = 1, parentvalue.numchildren do
								if parentvalue.children[y] == value then
									table.remove(parentvalue.children, y)
									break
								end
							end
							
							parentvalue.numchildren = parentvalue.numchildren - 1
						end
					end
					
					allframes[key] = nil
				end
			end
		end
		
		-- print
		--mod.out.print(string.format("stage %s, found %s frames, dropped %s.", x, totalframes, framesdropped))
		
		if framesdropped == 0 then
			break
		end
				
	end
	
	-- Group related holdings into families
	local headers = { }
	local header
	local numfamilies = 0
	local framesleft = 0
	
	for key, value in allframes do
		
		framesleft = framesleft + 1
		
		-- somehow, value.name can be nil here
		if value.name then
			local header = me.getnameheader(value.name)
			
			-- does this family already exist?
			if headers[header] == nil then
			
				-- create new
				headers[header] = { value }
				numfamilies = numfamilies + 1
				
			else	
				-- add
				table.insert(headers[header], value)
			end
			
			-- set my family ref
			value.family = headers[header]
		end
	end
	
	-- make a file level variable
	me.families = headers
	me.frames = allframes
	
	-- print
	mod.out.print(string.format("Combined the %s active frames into %s groups.", framesleft, numfamilies))
	
	-- now let's hook them!
	numonevents = 0
	numonupdates = 0
	
	for key, value in allframes do

		-- some unknowable frames are left in - don't hook them.
		if value.name then
		
			if value.onevent then
				me.overridescript(key, "OnEvent", value)
				numonevents = numonevents + 1
			end
			
			if value.onupdate then
				me.overridescript(key, "OnUpdate", value)
				numonupdates = numonupdates + 1
			end
		end
	end
	
	-- set as loaded
	me.ishooking = true
	
	-- print
	--mod.out.print(string.format("Found %s onevent, %s onupdate.", numonevents, numonupdates))
	
end

me.getnameheader = function(name)

	-- still nil? return nil
	if name == nil then
		return "<nil>"
	end

	local length = string.len(name)

	-- really short stuff, to stop annoying cases
	if length < 6 then
		return name
	end

	-- check 4th char
	local current, previous, next_
	local position = 3
	
	previous = string.sub(name, position - 1, position - 1)
	current = string.sub(name, position, position)
	next_ = string.sub(name, position + 1, position + 1)

	local x = 0
	while true do 
	
		x = x + 1
		if x > 20 then
			mod.out.print("emergency stop!")
			return name
		end
	
		-- iterate
		position = position + 1
		previous = current
		current = next_
		next_ = string.sub(name, position + 1, position + 1)
		
		-- check for end of string
		if next_ == "" then
			return name
		end
		
		-- check for underscore
		if current == "_" then
			return string.sub(name, 1, position)
		end
		
		-- check for UUl
		if string.find(previous, "[A-Z]") and string.find(current, "[A-Z]") then
			-- if the string is 5 or longer, that's enough
			if position >= 5 then
				return string.sub(name, 1, position)
			end
			

		end
		
		-- check for lU
		if string.find(current, "[a-z]") and string.find(next_, "[A-Z]") then
			return string.sub(name, 1, position)
		end

	end

end

me.print2 = function(datatype, property)

	if me.ishooking == false then
		mod.out.print(string.format("The monitor is not loaded, so there's no data to print. Run the command |cffffff00%s load|r to start the monitor.", mod.string.get("print", "console", "short")))
		return
	end

	-- default values
	if datatype == nil then
		datatype = "time" -- or "memory"
	end
	
	if property == nil then
		property = "total" -- or recent
	end
	
	-- let's just get the total values for all the families, and print off a random few
	
	local header, family, index, framedata
	local total, prints
	prints = 0
	local values = { }
	
	for header, family in me.families do
		total = 0
		if family == nil then
			mod.out.print("Nil family for header = " .. header)
		end
		
		for index = 1, table.getn(family) do
			framedata = family[index]
			if framedata.onupdate then
				total = total + framedata.onupdate[datatype][property]
			end
			if framedata.onevent then
				total = total + framedata.onevent[datatype][property]
			end
		end
		
		-- add to values
		table.insert(values, {header, total})
	end
	
	-- sort
	table.sort(values, function(a, b) return a[2] > b[2] end)
	
	for index = 1, 10 do
	--[[ the values are
	1) The rank, from 1 to 10
	2) The header / name of the family
	3) An example of a frame name in that family
	4) The actual value
	]]
		mod.out.print(string.format("%d %s (%s):  %s", index, values[index][1], 
			me.families[values[index][1]][1].name, math.floor(0.5 + values[index][2])))
	end

end


-- script = "OnUpdate" or "OnEvent"
me.overridescript = function(frame, script, value)

	local framename = value.name
	local varname = string.lower(script)
	local original = frame:GetScript(script)
	
	if original == nil then
		mod.out.print("There's no " .. script .. " script for the frame " .. frame)
		return
	end
	
	me.nexthook = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) 
		me.hookproc(frame, varname, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	end
		
	me.frames[frame][varname] = { }
	me.frames[frame][varname].original = original
	me.frames[frame][varname].replacement = me.nexthook
	me.frames[frame][varname].memory = mod.dataset.createnewdataset(5.0, 6)
	me.frames[frame][varname].time = mod.dataset.createnewdataset(5.0, 6)
	
	-- set the new script
	frame:SetScript(script, me.nexthook)
	
end

-- frame is the name of a frame. script = "onupdate" or "onevent"
me.hookproc = function(frame, script, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

	local gcbefore = gcinfo()
	local timebefore = GetTime()
	
	me.frames[frame][script].original(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

	local timetaken = 1000 * (GetTime() - timebefore)
	local memory = gcinfo() - gcbefore
	if memory < 0 then
		memory = 0
	end
	
	mod.dataset.adddatapoint(me.frames[frame][script].memory, memory)
	mod.dataset.adddatapoint(me.frames[frame][script].time, timetaken)	
end


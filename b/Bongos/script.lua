--[[
	BScript
		Functions for creating and calling events on the fly for Bongos
--]]

local eventScripts = {}; --do stuff, not attached to a specific bar
local barScripts = {}; --do stuff, attached to a barID, or all bars
local eventFrame = CreateFrame("Frame");

local function UnregisterUnused(unusedEvents)
	for event in unusedEvents do
		eventFrame:UnregisterEvent(event);
	end
end

BScript = {	
	--[[ Add ]]--
	AddEventAction = function(event, action, runNow)
		assert(event, "No event given");
		
		if action then
			if not eventScripts[event] then
				eventScripts[event] = {};
				if not barScripts[event] then
					eventFrame:RegisterEvent(event);
				end
			end
			table.insert(eventScripts[event], action);
			
			if runNow then
				action(action);
			end
		end
	end,
	
	AddStartupAction = function(action, runNow)
		if action then
			BScript.AddEventAction("VARIABLES_LOADED", action)
		end
	end,
	
	AddBarEventAction = function(barID, event, action, runNow)
		assert(barID, "No barID given");
		assert(event, "No event given");
		
		if action then
			if not barScripts[event] then
				if not eventScripts[event] then
					eventFrame:RegisterEvent(event);
				end
				barScripts[event] = {};
			end	
			barScripts[event][barID] = action;
			if runNow then
				BScript.CallBarEventForBar(event, barID);
			end
		end
	end,
	
	--[[ Removal ]]--
	
	RemoveEventAction = function(event, action)
		assert(event, "No event given.");
		assert(action, "No action given");
		
		if eventScripts[event] then
			for i, eventAction in pairs(eventScripts[event]) do
				if eventAction == action then
					table.remove(eventScripts[event], i)
					break;
				end
			end
			if table.getn(eventScripts[event]) == 0 then
				eventScripts[event] = nil;
				if not barScripts[event] then
					eventFrame:UnregisterEvent(event);
				end
			end
		end
	end,
	
	RemoveEvent = function(event)
		assert(event, "No event given");
		assert(event == "VARIABLES_LOADED", "Cannot remove event: " .. event);
		
		if eventScripts[event] then
			eventScripts[event] = nil;
			if not barScripts[event] then
				eventFrame:UnregisterEvent(event);
			end
		end
	end,
	
	RemoveAllEvents = function()
		local unusedEvents = {};
		
		for event in eventScripts[event] do
			if event ~= "VARIABLES_LOADED" then
				unusedEvents[event] = true
				eventScripts[event] = nil;
			end
		end	
		for event in barScripts[event] do
			if unusedEvents[event] then
				unusedEvents[event] = nil;
			end
		end
		
		UnregisterUnused(unusedEvents);
	end,
	
	--bar events
	RemoveEventForBar = function(event, barID)
		assert(barID, "No barID given");
		assert(event, "No event given");
		
		if barScripts[event] and barScripts[event][barID] then
			barScripts[event][barID] = nil;
			for i in barScripts[event] do
				return;
			end
			--there weren't any bar actions for the given event, so check if its used
			barScripts[event] = nil;
			if not eventScripts[event] then
				eventFrame:UnregisterEvent(event);
			end
		end
	end,
	
	RemoveAllEventsForBar = function(barID)
		assert(barID, "No barID given");
		
		for event in barScripts do
			if barScripts[event][barID] then
				barScripts[event][barID] = nil;
				
				local eventUsed;
				for i in barScripts[event] do
					eventUsed = true;
					break;
				end
				if not eventUsed then
					barScripts[event] = nil;
					if not eventScripts[event] then
						eventFrame:UnregisterEvent(event);
					end
				end
			end
		end	
	end,
	
	--[[ Execution ]]--
	CallEvent = function(event)
		assert(event, "No event given");
		
		if eventScripts[event] then
			for _, action in pairs(eventScripts[event]) do
				action(action);
			end
		end
	end,
	
	CallStartup = function()
		BScript.CallEvent("VARIABLES_LOADED");
	end,
	
	CallBarEvent = function(event)
		assert(event, "No event given");
	
		if barScripts[event] then
			for barID in barScripts[event] do
				BScript.CallBarEventForBar(event, barID);
			end
		end
	end,
	
	CallBarEventForBar = function(event, barList)
		assert(event, "No event given");
		assert(barList, "No bar list given");
		
		if barScripts[event] and barScripts[event][barList] then
			if barList == "all" then
				BBar.ForAll(barScripts[event][barList], event);
			else
				for barID in string.gfind(barList, "[^%s]+") do
					local _, _, startID, endID = string.find(barID, "(%d+)-(%d+)")
					if startID then
						for id = tonumber(startID), tonumber(endID) do	
							local bar = BBar.IDToBar(id);
							if bar then
								barScripts[event][barList](bar, event);
							end
						end
					else
						local bar = BBar.IDToBar(barID);
						if bar then
							barScripts[event][barList](bar, event);
						end
					end
				end
			end
		end
	end,
}

eventFrame:SetScript("OnEvent", function()	
	BScript.CallEvent(event);
	BScript.CallBarEvent(event);
end);
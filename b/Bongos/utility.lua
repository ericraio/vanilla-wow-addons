--[[
	Bongos\core\utility.lua
		Utility functions for Bongos
--]]

--takes a Bongos BarID, and performs the specified action on that bar
--this adds two special IDs, "all" for all bars and number-number for a range of IDs
function Bongos_ForBar(barID, action, ...)
	assert(barID and barID ~= "", "Invalid barID");
	
	if barID == "all" then
		BBar.ForAll(action, unpack(arg));
	else
		local _, _, startID, endID = string.find(barID, "(%d+)-(%d+)");
		startID = tonumber(startID);
		endID = tonumber(endID);
		if startID and endID then
			for id = startID, endID do
				local bar = BBar.IDToBar(id);
				if(bar) then
					action(bar, unpack(arg));
				end
			end
		else
			local bar = BBar.IDToBar(barID);
			if bar then
				action(bar, unpack(arg));
			end
		end
	end
end

--same thing as the previous function, except we pass the bar's ID as an arg instead of the bar itself
function Bongos_ForBarID(barID, action, ...)
	assert(barID and barID ~= "", "Invalid barID");
	
	if barID == "all" then
		BBar.ForAllIDs(action, unpack(arg));
	else
		local _, _, startID, endID = string.find(barID, "(%d+)-(%d+)");
		if startID and endID then
			for id = tonumber(startID), tonumber(endID) do
				action(id, unpack(arg));
			end
		else
			if tonumber(barID) then
				barID = tonumber(barID);
			end
			action(barID, unpack(arg));
		end
	end
end

--[[ Configuration Functions ]]--

function Bongos_SetLock(enable)
	if enable then
		BongosSets.locked = 1;	
		BBar.ForAll(BBar.Lock);
	else
		BongosSets.locked = nil;
		BBar.ForAll(BBar.Unlock);
	end
end

--enable disable "sticky" bars
function Bongos_SetStickyBars(enable)
	if enable then
		BongosSets.sticky = 1;
	else
		BongosSets.sticky = nil;
	end
	BBar.ForAll(BBar.Reanchor);
end

--Print a chat message
function BMsg(msg)
	ChatFrame1:AddMessage("Bongos:  " .. (msg or "error"), 0,1,0.4);
end
--------------------------------------------------------------------------
-- TitanClockOffsetFix.lua 
--------------------------------------------------------------------------
--[[
Titan Panel [ClockOffsetFix]

author: Vimrasha <vimrasha@fastmail.fm>

Fixes the Titan Panel Clock so that its offset is stored per server not per character.

]]--

function TitanClockOffsetFix_OnLoad()
	-- register events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");

end

function TitanClockOffsetFix_OnEvent(event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		if ( not ServerTimeOffsets ) then
			ServerTimeOffsets = {};
		end

		local realmName = GetCVar("realmName");

		if ( ServerTimeOffsets[realmName] ) then
			TitanSetVar(TITAN_CLOCK_ID, "OffsetHour", ServerTimeOffsets[realmName]);
		end
	end
	
	if ( event == "PLAYER_LEAVING_WORLD" ) then
		local realmName = GetCVar("realmName");
		ServerTimeOffsets[realmName] = TitanGetVar(TITAN_CLOCK_ID, "OffsetHour");
	end
end


SlashCmdList["HAIL"] = function()
	local string = "Hail";
	local name = UnitName("target");
	if ( name ) then
		string = string .. ", " .. name;
	end
	if ( UnitIsDead("target") or UnitIsCorpse("target") ) then
		string = string .. "'s Corpse";
	end
	SendChatMessage(string, "SAY");
end

SLASH_HAIL1 = "/hail";

BINDING_HEADER_CT_HAILMOD = "CT_HailMod";
BINDING_NAME_CT_HAILMOD_HAIL = "Button Trigger";

function CT_Zep_SecondsSinceHour()
	local _, _, min, sec = string.find(date(), "%d+:(%d+):(%d+)$");
	return tonumber(min)*60+tonumber(sec);
end

function CT_Zep_GetNextArrival()
	local secs = mod(CT_Zep_SecondsSinceHour(), 360);
	if ( secs > 356 ) then
		secs = 360-secs;
	end
	if ( secs <= 127 ) then
		CT_Print("Arriving in UC in " .. 127-secs);
	elseif ( secs <= 187 ) then
		CT_Print("Departing from UC in " .. 187-secs);
	elseif ( secs <= 296 ) then
		CT_Print("Arriving in Org in " .. 296-secs);
	else
		CT_Print("Departing from Org in " .. 356-secs);
	end
end

-- 127 = UC
-- 187 = UC Depart
-- 296 = Org
-- 356 = Org Depart
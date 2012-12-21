
-- Title: CastingBar Time v0.1
-- Notes: Displays remaining casting / channeling time
-- Author: lua@lumpn.de

local function CastingBarTime_toString(end_time)
	return string.format(" (%.1fs)", end_time - GetTime());
end

function CastingBarTime_OnLoad()
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this.SpellName = "";
end


function CastingBarTime_OnEvent()
	if ( event == "SPELLCAST_START" ) then
		this.SpellName = arg1;
	elseif ( event == "SPELLCAST_CHANNEL_START" ) then
		this.SpellName = arg2;
	end
end


function CastingBarTime_OnUpdate()

	if ( CastingBarFrame.casting ) then
		CastingBarText:SetText(this.SpellName..CastingBarTime_toString(CastingBarFrame.maxValue));
	elseif ( CastingBarFrame.channeling ) then
		CastingBarText:SetText(this.SpellName..CastingBarTime_toString(CastingBarFrame.endTime));
	end
	
end
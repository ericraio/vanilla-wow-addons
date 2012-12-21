-------------------------------------------------------------------------
local RegisteredRings = {};
RingSavedValues = {};

function StatRings_RegisterRing(frame, name)
	-- sr_pr("Stat Ring Registering " .. name);
	if RegisteredRings[frame] == nil then
		RegisteredRings[frame] = {};
	end
	RegisteredRings[frame].friendlyName = name;
end

function StatRings_SaveValue(key, value)
	if RingSavedValues[this:GetName()] == nil then
		RingSavedValues[this:GetName()] = {};
	end
	RingSavedValues[this:GetName()][key] = value;
end

function StatRings_LoadValue(key)
	if RingSavedValues[this:GetName()] == nil then
		return nil;
	end
	return RingSavedValues[this:GetName()][key];
end

function StatRings_OnLoad()
end
--[[
	Bongos\core\profiles.lua
		Code for saving and loading Bongos Settings
--]]

local savedList = {};

BProfile = {
	Load = function(name)
		if not BongosProfiles then
			BMsg("No profiles saved yet.");
		elseif not name then
			BMsg("No profile name specified.");
		elseif not BongosProfiles[name] then
			BMsg("'" .. (name or "null") .. "' is an invalid profile.");
		else
			BBar.ForAllIDs(BBar.Delete);
			for field, value in pairs(BongosProfiles[name]) do
				setfield(field, tcopy(value));
				local action = savedList[name];
				if action and not tonumber(action) then
					action();
				end
			end
			BScript.CallStartup();
			
			BMsg("Loaded profile '" .. name .. "'.");
		end
	end,
	
	Save = function(name)
		if not BongosProfiles then
			BongosProfiles = {};
		end
		BongosProfiles[name] = {};
		
		--save all bar and position information
		for _, bar in pairs(BBar.GetAll()) do
			BongosProfiles[name][bar.setsGlobal] = tcopy(bar.sets) or {};
			BongosProfiles[name][bar.setsGlobal].x = bar:GetLeft();
			BongosProfiles[name][bar.setsGlobal].y = bar:GetTop();
			local scale = bar:GetScale();
			if scale == 1 then
				scale = nil;
			end
			BongosProfiles[name][bar.setsGlobal].scale = scale;
		end
		for var in savedList do
			BongosProfiles[name][var] = tcopy(getfield(var));
		end

		BMsg("Saved your current configuration as the profile '" .. name .. "'.");
	end,

	Delete = function(name)
		if not BongosProfiles then
			BMsg("No profiles saved yet.");
		elseif(not name) then
			BMsg("No profile specified.");
		elseif not BongosProfiles[name] then
			BMsg("'" .. (name or "null") .. "' is an invalid profile.");
		else
			BongosProfiles[name] = nil;
			BMsg("Deleted profile '" .. name .. "'.");
		end
	end,

	SetDefault = function(name)
		if not name then
			if BongosProfiles then
				BongosProfiles.default = nil;
				BMsg("Default profile disabled.");
			end
		elseif BongosProfiles and BongosProfiles[name] then
			BongosProfiles.default = name;
			BMsg("'" .. name .. "' has been set as the default Bongos profile.");
		else
			BMsg("Invalid profile name.");
		end
	end,
	
	GetDefault = function()
		if BongosProfiles then
			return BongosProfiles.default;
		end
	end,
	
	RegisterForSave = function(varName, loadAction)
		if not savedList[varName] then
			savedList[varName] = (loadAction or 1);
		end
	end,
	
	GetDefaultValue = function(varName)
		if not (varName and BongosProfiles and BongosProfiles.default and BongosProfiles[BongosProfiles.default]) then
			return nil;
		end
		local defaults = BongosProfiles[BongosProfiles.default][varName];
		if defaults then
			return tcopy(defaults);
		end
	end,
}
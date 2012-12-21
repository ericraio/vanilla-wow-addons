--[[
	Dominos\main.lua
		Intializes and updates BongosSets, the global settings variable for Bongos
--]]
local function LoadDefaults(currentVersion)
	BongosSets = BProfile.GetDefaultValue("BongosSets") or {
		sticky = 1,
		locked = 1,
		version = currentVersion,
		dontReuse = 1,
	}
	BMsg("New user detected. Default settings loaded.");
end

local function UpdateVersion(currentVersion)
	BongosSets.dontReuse = 1;
	BongosSets.version = currentVersion;
	BMsg("Updated to v" .. currentVersion);
end

local function LoadVariables()
	local currentVersion = GetAddOnMetadata("Bongos", "Version");
	if not BongosSets or not BongosSets.version or BongosSets.version > currentVersion then
		LoadDefaults(currentVersion);
	elseif BongosSets.version < currentVersion then
		UpdateVersion(currentVersion);
	end
end

BScript.AddEventAction("ADDON_LOADED", function(thisAction)
	if arg1 == "Bongos" then
		BScript.RemoveEventAction("ADDON_LOADED", thisAction);
		LoadVariables();
		BProfile.RegisterForSave("BongosSets", LoadVariables);
		BProfile.RegisterForSave("BongosCustomScripts", LoadVariables);
		
		if IsAddOnLoaded("CT_BottomBar") then
			message("There is a conflict between CT_BottomBar and Bongos. Please disable CT_BottomBar if you want to use Bongos without issue.");
		end
	end
end)

BScript.AddEventAction("PLAYER_LOGIN", function(thisAction)
	BScript.RemoveEventAction("PLAYER_LOGIN", thisAction);
	BCustomScript.LoadAll();
end)
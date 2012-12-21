--bgab_versionUpdate; a flag to tell 

local function UpdateVersion(currentVersion)
	BActionSets.version = currentVersion;
end

local function LoadVariables()
	local currentVersion = GetAddOnMetadata("Bongos_ActionBar", "Version")

	if not BActionSets or not BActionSets.g.version then
		BMsg("Loading Defaults");
		local defaults = BProfile.GetDefaultValue("BActionSets.g");
		BActionSets = {
			g = defaults or {
				version = currentVersion,
				buttonLocked = 1,
				tooltips = 1,
				altCast = 1,
				quickMove = 2,
				colorOutOfRange = 1,
				rangeColor = { r = 1, g = 0.5, b = 0.5 },
				numActionBars = 10,
			},
		};
	elseif BActionSets.version ~= currentVersion then
		UpdateVersion(currentVersion);
	end
end

BScript.AddEventAction("ADDON_LOADED", function(thisAction)
	if arg1 == "Bongos_ActionBar" then
		BScript.RemoveEventAction("ADDON_LOADED", thisAction);
		LoadVariables();
		BProfile.RegisterForSave("BActionSets.g", LoadVariables);
	end
end);

--make the first actionbar switch when changing stances/forms/stealthing
local _, class = UnitClass("player");
if class == "DRUID" or class == "WARRIOR" or class == "ROGUE" then
	BScript.AddBarEventAction(1, "UPDATE_BONUS_ACTIONBAR", function(bar)
		if GetBonusBarOffset() ~= 0 then
			BActionBar.SetStanceOffset(bar.id, 5 + GetBonusBarOffset())
		else
			BActionBar.SetStanceOffset(bar.id, 0)
		end
	end)
end
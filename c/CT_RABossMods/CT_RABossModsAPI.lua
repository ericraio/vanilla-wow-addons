-----------------------------------------------------
--                   Changelog                     --
-----------------------------------------------------
-- Version 1.1                                     --
-----------------------------------------------------
-- # Changed first parameter of CT_RABoss_Schedule --
-- to take either a string or a function as its    --
-- first argument.                                 --
--                                                 --
-- # Added CT_RABoss_PlaySound, which takes an id  --
-- between 1-3 and plays the corresponding sound.  --
--                                                 --
-- # Added CT_RABoss_Debug, which prints to chat   --
-- if and when debug is enabled for that debug     --
-- level. See the function for more details.       --
--                                                 --
-- # Added slash command /rabossdebug [level] or   --
-- /rabd, which toggles debugg for the chosen      --
-- level if specified, otherwise toggles debugging --
-- for all levels.                                 --
-----------------------------------------------------
-- Version 1.0                                     --
-----------------------------------------------------
-- # Release version.                              --
-----------------------------------------------------

CT_RABoss_ModsToLoad = { };
CT_RABoss_ScheduledActions = { };
CT_RABoss_Events = { };
CT_RABoss_Mods = { };
CT_RABoss_Save = { };
CT_RABoss_DropDown = { };
CT_RABoss_HasLoadedVars = nil;

CT_RABoss_Locations = {
	{ CT_RABOSS_LOCATIONS_NAXXRAMAS, 0 }, { CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE, 0 }, { CT_RABOSS_LOCATIONS_AHNQIRAJRUINS, 0 }, { CT_RABOSS_LOCATIONS_MOLTENCORE, 0 }, { CT_RABOSS_LOCATIONS_BLACKWINGSLAIR, 0 }, { CT_RABOSS_LOCATIONS_ONYXIASLAIR, 0 }, { CT_RABOSS_LOCATIONS_ZULGURUB, 0 }, { CT_RABOSS_LOCATIONS_OUTDOOR, 0 }, { CT_RABOSS_LOCATIONS_OTHER, 0 }
};

CT_RABoss_DebugLevels = {
	["enableDebug"] = false,
	[1] = true,
	[2] = true,
	[3] = true,
	[4] = true,
	[5] = true
};

-- Displays the message(s) if the debug level specified is enabled, and enableDebug is set to true.
function CT_RABoss_Debug(level, ...)
	if ( CT_RABoss_DebugLevels["enableDebug"] and CT_RABoss_DebugLevels[(level or 1)] ) then
		local msg = "";
		for i = 1, arg.n, 1 do
			if ( strlen(msg) > 0 ) then
				msg = msg .. " |r#|c00FFFFFF ";
			end
			if ( type(arg[i]) == "string" ) then
				msg = msg .. "\"" .. arg[i] .. "\"";
			elseif ( type(arg[i]) == "number" ) then
				msg = msg .. arg[i];
			else
				msg = msg .. strupper(type(arg[i]));
			end
		end
		CT_RA_Print("<CTRA Debug " .. (level or 1) .. "> |c00FFFFFF" .. msg .. "|r", 1, 1, 0);
	end
end

-- Function to schedule a function
function CT_RABoss_Schedule(nameOrFunction, timeUntil, optParam)
	tinsert(CT_RABoss_ScheduledActions, { nameOrFunction, GetTime()+timeUntil, optParam });
end

-- Function to unschedule all functions where the first index is "name"
function CT_RABoss_UnSchedule(name, optParam)
	local v;
	for k = getn(CT_RABoss_ScheduledActions), 1, -1 do
		v = CT_RABoss_ScheduledActions[k];
		if ( v[1] == name and ( not optParam or v[3] == optParam ) ) then
			tremove(CT_RABoss_ScheduledActions, k);
		end
	end
end

-- Function to process scheduled actions
function CT_RABoss_OnUpdate(elapsed)
	this.elapsed = this.elapsed + elapsed;
	if ( this.elapsed >= 0.1 ) then
		this.elapsed = this.elapsed - 0.1;
		local currTime = GetTime();
		local v;
		for k = getn(CT_RABoss_ScheduledActions), 1, -1 do
			v = CT_RABoss_ScheduledActions[k];
			if ( v and currTime >= v[2] ) then
				tremove(CT_RABoss_ScheduledActions, k);
				if ( type(v[1]) == "function" ) then
					v[1](v[3]);
				else
					getglobal(v[1])(v[3]);
				end
			end
		end
	end
end

-- Handles all the events
function CT_RABoss_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		CT_RABoss_LoadMods();
		CT_RABoss_HasLoadedVars = 1;
		-- Add new mods that aren't saved yet
		for k, v in CT_RABoss_Save do
			if ( CT_RABoss_Mods[k] ) then
				for key, val in v do
					CT_RABoss_Mods[k][key] = val;
				end
			else
				CT_RABoss_Save[k] = nil;
			end
		end
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		CT_RABoss_Schedule("CT_RABoss_ScanModZones", 20);
	end
	
	for k, v in CT_RABoss_Events do
		if ( v[event] ) then
			v[event](event);
		end
	end
end

-- Function to disable/enable mods based on zone
function CT_RABoss_ScanModZones()
	local zone = GetRealZoneText();
	for k, v in CT_RABoss_Mods do
		if ( v["location"] ) then
			if ( v["location"] == CT_RABOSS_LOCATIONS_NAXXRAMAS ) then
				CT_RABoss_Mods[k].enabled = ( zone == CT_RABOSS_MINIMAPLOC_NAXXRAMAS );
			elseif ( v["location"] == CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE ) then
				CT_RABoss_Mods[k].enabled = ( zone == CT_RABOSS_MINIMAPLOC_AHNQIRAJTEMPLE );
			elseif ( v["location"] == CT_RABOSS_LOCATIONS_AHNQIRAJRUINS ) then
				CT_RABoss_Mods[k].enabled = ( zone == CT_RABOSS_MINIMAPLOC_AHNQIRAJRUINS );
			elseif ( v["location"] == CT_RABOSS_LOCATIONS_BLACKWINGSLAIR ) then
				CT_RABoss_Mods[k].enabled = ( zone == CT_RABOSS_MINIMAPLOC_BLACKWINGSLAIR );
			elseif ( v["location"] == CT_RABOSS_LOCATIONS_ONYXIASLAIR ) then
				CT_RABoss_Mods[k].enabled = ( zone == CT_RABOSS_MINIMAPLOC_ONYXIASLAIR );
			elseif ( v["location"] == CT_RABOSS_LOCATIONS_MOLTENCORE ) then
				CT_RABoss_Mods[k].enabled = ( zone == CT_RABOSS_MINIMAPLOC_MOLTENCORE );
			elseif ( v["location"] == CT_RABOSS_LOCATIONS_ZULGURUB ) then
				CT_RABoss_Mods[k].enabled = ( zone == CT_RABOSS_MINIMAPLOC_ZULGURUB );
			elseif ( v["location"] == CT_RABOSS_LOCATIONS_OUTDOOR ) then
				local x, y = GetPlayerMapPosition("player");
				CT_RABoss_Mods[k].enabled = ( x ~= 0 or y ~= 0 );
			else
				CT_RABoss_Mods[k].enabled = true;
			end
		end
	end
end
-- Add event
function CT_RABoss_AddEvent(modName, event, func)
	if ( not CT_RABoss_Events[modName] ) then
		CT_RABoss_Events[modName] = { };
	end
	CT_RABoss_Events[modName][event] = func;
	CT_RABossModsFrame:RegisterEvent(event);
end

-- Add mod
function CT_RABoss_AddMod(modName, modDescript, modStatus, modLocation)
	if ( not modLocation ) then
		modLocation = "Other";
	end
	
	local found;
	for k, v in CT_RABoss_Locations do
		if ( v[1] == modLocation ) then
			found = 1;
			break;
		end
	end
	if ( not found ) then
		tinsert(CT_RABoss_Locations, { modLocation, 0 });
	end
	if ( not CT_RABoss_HasLoadedVars and not CT_RABoss_Save[modName]) then
		CT_RABoss_Save[modName] = { ["status"] = modStatus };
	end
	if ( not CT_RABoss_HasLoadedVars or not CT_RABoss_Mods[modName] ) then
		CT_RABoss_Mods[modName] = { ["status"] = modStatus, ["descript"] = modDescript, ["location"] = modLocation };
	end
end

-- Enable/Disable mod
function CT_RABoss_EnableMod()
	CT_RABoss_Mods[this.value]["status"] = not CT_RABoss_Mods[this.value]["status"];
	if ( not CT_RABoss_Save[this.value] ) then
		CT_RABoss_Save[this.value] = {
			["status"] = CT_RABoss_Mods[this.value]["status"]
		};
	else
		CT_RABoss_Save[this.value]["status"] = not CT_RABoss_Save[this.value]["status"];
	end
	CT_RAMenuBoss_Update();
end

-- Get mod info
function CT_RABoss_ModInfo(modName, modVar)
	if ( CT_RABoss_Mods[modName] and CT_RABoss_Mods[modName][modVar] ) then
		if ( type(CT_RABoss_Mods[modName][modVar]) or CT_RABoss_Mods[modName][modVar] ~= 0 ) then
			return 1;
		end
	end
end

-- Set mod info
function CT_RABoss_SetInfo()
	CT_RABoss_SetVar(this.value[1], this.value[2], not CT_RABoss_Mods[this.value[1]][this.value[2]]);
end

function CT_RABoss_SetVar(modName, modVar, modValue)
	CT_RABoss_Mods[modName][modVar] = modValue;
	if ( CT_RABoss_HasLoadedVars ) then
		if ( not CT_RABoss_Save[modName] ) then
			CT_RABoss_Save[modName] = { };
		end
		CT_RABoss_Save[modName][modVar] = modValue;
	end
	if ( CT_RAMenuBoss_Update ) then
		CT_RAMenuBoss_Update();
	end
end

-- Add dropdown buttons
function CT_RABoss_AddDropDownButton(modName, btnDesc, btnVar, btnParams, btnSetFunc)
	if ( not CT_RABoss_DropDown[modName] ) then
		CT_RABoss_DropDown[modName] = { };
	end
	tinsert( CT_RABoss_DropDown[modName], { btnDesc, btnVar, btnParams, btnSetFunc } );
end

-- Announce function
function CT_RABoss_Announce(msg, fullRaid)
	if ( fullRaid and CT_RA_Level >= 1 ) then
		CT_RA_AddMessage("MS " .. msg);
		SendChatMessage(msg, "RAID");
	end
	CT_RA_WarningFrame:AddMessage(msg, 1, 1, 1, 1, UIERRORS_HOLD_TIME);
end

function CT_RABoss_PlaySound(id)
	local soundTable = {
		"Sound\\Doodad\\BellTollHorde.wav",
		"Sound\\Doodad\\BellTollAlliance.wav",
		"Sound\\Doodad\\BellTollNightElf.wav",
	};
	PlaySoundFile(soundTable[id]);
end
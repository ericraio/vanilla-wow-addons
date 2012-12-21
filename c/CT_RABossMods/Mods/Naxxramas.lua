-- Abomination Wing
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Grobbulus_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Gluth_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Thaddius_OnLoad");
-- Plague Wing
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Heigan_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Gothik_OnLoad");
function CT_RABoss_Heigan_OnLoad()
	CT_RABoss_AddMod("Heigan the Unclean", CT_RABOSS_HEIGAN_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Heigan the Unclean", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Heigan_EventHandler);
	CT_RABoss_AddEvent("Heigan the Unclean", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Heigan_EventHandler);
	CT_RABoss_AddDropDownButton("Heigan the Unclean", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddEvent("Heigan the Unclean", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Heigan_EventHandler);
	CT_RABoss_AddEvent("Heigan the Unclean", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Heigan_EventHandler);
	CT_RABoss_AddEvent("Heigan the Unclean", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Heigan_EventHandler);
	CT_RA_RegisterSlashCmd("/heiganstop", "Stop the Heigan the Unclean bossmod timer.", 30, "HEIGANSTOP", function()
		CT_RABoss_UnSchedule("CT_RABoss_Heigan_EventHandler");
	end, "/heiganstop");
end

function CT_RABoss_Heigan_EventHandler(event)
	local mod = CT_RABoss_Mods["Heigan the Unclean"];
	if ( not mod or not mod["status"] or not mod.enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( not mod.engaged and ( arg1 == CT_RABOSS_HEIGAN_ENGAGE1 or arg1 == CT_RABOSS_HEIGAN_ENGAGE2 or arg1 == CT_RABOSS_HEIGAN_ENGAGE3 ) ) then
			CT_RABoss_UnSchedule("CT_RABoss_Heigan_EventHandler");
			CT_RABoss_Announce(CT_RABOSS_HEIGAN_ENGAGED, mod["announce"]);
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 10, "splash5");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 75, "cloud15");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 85, "cloud5");
			mod.feverTrip = nil;
		elseif ( arg1 == CT_RABOSS_HEIGAN_CLOUD ) then
			CT_RABoss_Announce(CT_RABOSS_HEIGAN_CLOUDALERT, mod["announce"]);
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 40, "cloudstop5");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 45, "cloudstop");
		end
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if ( arg2 == CT_RABOSS_HEIGAN_NAME and arg1 == CT_RABOSS_HEIGAN_DEATH ) then
			CT_RABoss_UnSchedule("CT_RABoss_Heigan_EventHandler");
		end
	elseif ( event == "splash5" ) then
		CT_RABoss_Announce(CT_RABOSS_HEIGAN_SPLASH5, mod["announce"]);
	elseif ( event == "cloud15" ) then
		CT_RABoss_Announce(format(CT_RABOSS_HEIGAN_PRECLOUD, 15), mod["announce"]);
	elseif ( event == "cloud5" ) then
		CT_RABoss_Announce(format(CT_RABOSS_HEIGAN_PRECLOUD, 5), mod["announce"]);
	elseif ( event == "cloudstop5" ) then
		CT_RABoss_Announce(CT_RABOSS_HEIGAN_CLOUDSTOP5, mod["announce"]);
	elseif ( event == "cloudstop" ) then
		CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 5, "splash5");
		CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 75, "cloud15");
		CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 85, "cloud5");
		CT_RABoss_Announce(CT_RABOSS_HEIGAN_CLOUDSTOP, mod["announce"]);
	elseif ( event == "feverUntrip" ) then
		mod.feverTrip = nil;
	elseif ( not mod.feverTrip ) then
		if ( string.find(arg1, CT_RABOSS_HEIGAN_FEVERREGEXP) ) then
			SendChatMessage(CT_RABOSS_HEIGAN_FEVERWARNING, "RAID");
			mod.feverTrip = true;
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 8, "feverUntrip");
		end
	end
end
-- Grobbulus
function CT_RABoss_Grobbulus_OnLoad()
	CT_RABoss_AddMod("Grobbulus", CT_RABOSS_GROBBULUS_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddDropDownButton("Grobbulus", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Grobbulus", { CT_RABOSS_GROBBULUS_INJECTIONTELL, CT_RABOSS_GROBBULUS_INJECTIONTELL_INFO }, "CT_RABoss_ModInfo", "sendInjectionTells", "CT_RABoss_SetInfo");
end

function CT_RABoss_Grobbulus_EventHandler(event)
	if ( not CT_RABoss_Mods["Grobbulus"] or not CT_RABoss_Mods["Grobbulus"]["status"] or not CT_RABoss_Mods["Grobbulus"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		local _, _, playerName, playerType = string.find(arg1, CT_RABOSS_GROBBULUS_INJECTIONREGEXP);
		if ( playerName ) then
			if ( playerType == CT_RABOSS_GROBBULUS_TYPE_YOU and playerName == CT_RABOSS_GROBBULUS_YOU ) then
				playerName = UnitName("player");
				CT_RABoss_Announce(string.format(CT_RABOSS_GROBBULUS_INJECTIONWARNING, CT_RABOSS_GROBBULUS_YOUHAVE));
				CT_RABoss_Announce(string.format(CT_RABOSS_GROBBULUS_INJECTIONWARNING, CT_RABOSS_GROBBULUS_YOUHAVE));
				CT_RABoss_PlaySound(2);
			else
				if ( CT_RABoss_Mods["Grobbulus"]["sendInjectionTells"] ) then
					SendChatMessage(CT_RABOSS_GROBBULUS_INJECTIONWARNING_TELL, "WHISPER", nil, playerName);
				end
				CT_RABoss_PlaySound(1);
				CT_RABoss_Announce(string.format(CT_RABOSS_GROBBULUS_INJECTIONWARNING, playerName .. CT_RABOSS_GROBBULUS_HAS));
			end
			if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Grobbulus"]["announce"] ) then
				CT_RA_AddMessage("MS " .. string.format(CT_RABOSS_GROBBULUS_INJECTIONWARNING, playerName));
			end
		end
	end
end

-- Gluth
function CT_RABoss_Gluth_OnLoad()
	CT_RABoss_AddMod("Gluth", CT_RABOSS_GLUTH_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "PLAYER_LEAVING_WORLD", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddDropDownButton("Gluth", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Gluth_EventHandler(event)
	local mod = CT_RABoss_Mods["Gluth"];
	if ( not mod or not mod["status"] or not mod.enabled ) then
		return;
	end
	if ( event == "PLAYER_LEAVING_WORLD" ) then
		CT_RABoss_UnSchedule("CT_RABoss_Gluth_EventHandler");
		mod.engaged = nil;
	elseif ( event == "fear3" ) then
		mod.fearTrip = nil;
		CT_RABoss_Announce(CT_RABOSS_GLUTH_PREFEAR, mod.announce);
	elseif ( event == "preDecimate15" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_GLUTH_PREDECIMATE, 15), mod.announce);
		mod.decimateTrip = nil;
	elseif ( event == "preDecimate5" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_GLUTH_PREDECIMATE, 5), mod.announce);
		
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		if ( not mod.decimateTrip and string.find(arg1, CT_RABOSS_GLUTH_DECIMATESTRING) ) then
			CT_RABoss_UnSchedule("CT_RABoss_Gluth_EventHandler", "preDecimate15");
			CT_RABoss_UnSchedule("CT_RABoss_Gluth_EventHandler", "preDecimate5");
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 90, "preDecimate15");
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 100, "preDecimate5");
			mod.decimateTrip = true;
			CT_RABoss_Announce(CT_RABOSS_GLUTH_DECIMATE, mod.announce);
		end
	elseif ( not mod.fearTrip and string.find(arg1, CT_RABOSS_GLUTH_FEARSTRING) ) then
		CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 15, "fear3");
		mod.fearTrip = true;
		CT_RABoss_Announce(CT_RABOSS_GLUTH_FEAR, mod.announce);
		if ( not mod.engaged ) then
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 70, "preDecimate15");
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 80, "preDecimate5");
			mod.engaged = true;
		end
	end
end

-- Gothik the Harvest
function CT_RABoss_Gothik_OnLoad()
	CT_RABoss_AddMod("Gothik the Harvester", CT_RABOSS_GOTHIK_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Gothik the Harvester", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Gothik_EventHandler);
	CT_RABoss_AddEvent("Gothik the Harvester", "CHAT_MSG_COMBAT_HOSTILE_DEATH", CT_RABoss_Gothik_EventHandler);
	CT_RABoss_AddDropDownButton("Gothik the Harvester", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Gothik the Harvester", { CT_RABOSS_GOTHIK_RIDERSPAWN, CT_RABOSS_GOTHIK_RIDERSPAWN_INFO }, "CT_RABoss_ModInfo", "riderSpawn", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Gothik the Harvester", { CT_RABOSS_GOTHIK_DKSPAWN, CT_RABOSS_GOTHIK_DKSPAWN_INFO }, "CT_RABoss_ModInfo", "dkSpawn", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Gothik the Harvester", { CT_RABOSS_GOTHIK_TRAINEESPAWN, CT_RABOSS_GOTHIK_TRAINEESPAWN_INFO }, "CT_RABoss_ModInfo", "traineeSpawn", "CT_RABoss_SetInfo");
	CT_RA_RegisterSlashCmd("/gothikstop", "Stop Gothik's timers.", 30, "GOTHIKSTOP", function()
		CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler");
	end, "/gothikstop");
end

function CT_RABoss_Gothik_EventHandler(event)
	local mod = CT_RABoss_Mods["Gothik the Harvester"];
	if ( not mod or not mod["status"] or not mod.enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 == CT_RABOSS_GOTHIK_ENGAGE ) then
			mod.riderCount = 0;
			mod.traineeCount = 0;
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_ENGAGED, mod.announce);
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 7, "trainee");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 57, "deathknight");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 117, "rider");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 195, "preteleport");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 245, "preteleport10");
			
		elseif ( arg1 == CT_RABOSS_GOTHIK_TELEPORT ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_FIGHT, mod.announce);
			CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler");
		end
	elseif ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
		if ( arg1 == CT_RABOSS_GOTHIK_RIDERDEATHSTRING ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_RIDERDEATH, mod.announce);
		elseif ( arg1 == CT_RABOSS_GOTHIK_DEATHKNIGHTDEATHSTRING ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_DEATHKNIGHTDEATH, mod.announce);
		end
	elseif ( event == "rider" or event == "riderRepeat" ) then
		mod.riderCount = mod.riderCount + 1;
		if ( mod.riderCount == 4 ) then
			CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler", "riderRepeat");
			CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler", "riderTimer");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 7, "spawnsStopped");
		else
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 30, "riderRepeat");
		end
		if ( event == "rider" or mod.riderSpawn ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_RIDER, mod.announce);
		end
	elseif ( event == "deathknight" or event == "deathknightRepeat" ) then
		if ( mod.riderCount == 4 ) then
			CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler", "deathknightRepeat");
			CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler", "deathknightTimer");
		else
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 25, "deathknightRepeat");
		end
		if ( event == "deathknight" or mod.dkSpawn ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_DEATHKNIGHT, mod.announce);
		end
	elseif ( event == "trainee" or event == "traineeRepeat" ) then
		mod.traineeCount = mod.traineeCount + 1;
		if ( mod.riderCount == 4 ) then
			CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler", "traineeRepeat");
			CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler", "traineeTimer");
		else
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 20, "traineeRepeat");
		end
		if ( event == "trainee" or mod.traineeSpawn ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_GOTHIK_TRAINEE, mod.traineeCount), mod.announce);
		end
	elseif ( event == "preteleport" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_GOTHIK_PRESPAWN, "1 MIN"), mod.announce);
	elseif ( event == "preteleport10" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_GOTHIK_PRESPAWN, "10 SEC"), mod.announce);
		
	elseif ( event == "spawnsStopped" ) then
		CT_RABoss_Announce(CT_RABOSS_GOTHIK_SPAWNSSTOPPED, mod.announce);
	end
end

-- Thaddius
function CT_RABoss_Thaddius_OnLoad()
	CT_RABoss_AddMod("Thaddius", "Stuff.", 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "PLAYER_LEAVING_WORLD", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddDropDownButton("Thaddius", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Thaddius", { CT_RABOSS_THADDIUS_THROW, CT_RABOSS_THADDIUS_THROW_INFO }, "CT_RABoss_ModInfo", "throw", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Thaddius", { CT_RABOSS_THADDIUS_TELLS, CT_RABOSS_THADDIUS_TELLS_INFO }, "CT_RABoss_ModInfo", "tells", "CT_RABoss_SetInfo");
end

function CT_RABoss_Thaddius_EventHandler(event)
	local mod = CT_RABoss_Mods["Thaddius"];
	if ( not mod or not mod["status"] or not mod.enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( not mod.engaged and ( arg1 == CT_RABOSS_THADDIUS_ENGAGEYELL1 or arg1 == CT_RABOSS_THADDIUS_ENGAGEYELL2 ) ) then
			mod.engaged = true;
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_PHASE1, mod.announce);
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 15, "throw5");
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 20, "throw");
		elseif ( arg1 == CT_RABOSS_THADDIUS_PHASETWOYELL1 or arg1 == CT_RABOSS_THADDIUS_PHASETWOYELL2 or arg1 == CT_RABOSS_THADDIUS_PHASETWOYELL3 ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_PHASE2, mod.announce);
			CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler", "throw5");
			CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler", "throw");
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 120, "enrage3 min");
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 240, "enrage1 min");
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 285, "enrage15 sec");
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 295, "enrage5 sec");
			
			if ( not mod.charges ) then
				mod.charges = { };
			else
				for key, val in pairs(mod.charges) do
					mod.charges[key] = nil;
				end
			end
		end
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		mod.engaged = nil;
		CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler");
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( arg1 == CT_RABOSS_THADDIUS_SURGESTRING ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_SURGE, mod.announce);
		end
		
	elseif ( event == "throw5" ) then
		CT_RABoss_Announce(CT_RABOSS_THADDIUS_THROWMSG5, mod.announce);
	elseif ( event == "throw" ) then
		CT_RABoss_Announce(CT_RABOSS_THADDIUS_THROWMSG, mod.announce);
		CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 16, "throw5");
		CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 21, "throw");
	
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) then
		if ( arg1 == CT_RABOSS_THADDIUS_POLARITYCASTSTRING ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_POLARITY, mod.announce);
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		if ( mod.tells ) then
			local _, _, name, type, debuff = string.find(arg1, CT_RABOSS_THADDIUS_CHARGEREGEXP);
			if ( name ) then
				local charges = mod.charges;
				if ( name == CT_RABOSS_THADDIUS_YOU and type == CT_RABOSS_THADDIUS_TYPE_YOU ) then
					name = UnitName("player");
				end

				if ( debuff ~= charges[name] ) then
					CT_RaidAssist2:SendSilentMessage(getglobal("CT_RABOSS_THADDIUS_CHARGE_"..debuff), "WHISPER", name);
				end
				charges[name] = debuff;
			end
		end
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if ( arg1 == CT_RABOSS_THADDIUS_ENRAGESTRING and arg2 == CT_RABOSS_THADDIUS_BOSSNAME ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_ENRAGE, mod.announce);
		end
	elseif ( string.sub(event, 0, 6) == "enrage" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_THADDIUS_ENRAGEIN, string.sub(event, 7)), mod.announce);
	end
end

--[[ Simulate Polarity Shift, uncomment if you want to have a go!
SLASH_PRACTICETHADDIUS1 = "/practicethaddius";
SLASH_PRACTICETHADDIUS2 = "/pt";
local positive = { };
SlashCmdList["PRACTICETHADDIUS"] = function()
	-- Clear the "positive" table
	for key, val in pairs(positive) do
		positive[key] = nil;
	end
	
	-- Grab four groups
	local num = 0;
	while ( num < 4 ) do
		local rnd = math.random(1, 8);
		if ( not positive[rnd] ) then
			num = num + 1;
			positive[rnd] = true;
		end
	end
	
	-- Send tells
	local name, rank, subgroup;
	for i = 1, GetNumRaidMembers(), 1 do
		name, rank, subgroup = GetRaidRosterInfo(i);
		if ( positive[subgroup] ) then
			CT_RaidAssist2:SendSilentMessage("YOU ARE POSITIVE", "WHISPER", name);
		else
			CT_RaidAssist2:SendSilentMessage("YOU ARE NEGATIVE", "WHISPER", name);
		end
	end
end ]]
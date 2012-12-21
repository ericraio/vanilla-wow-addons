tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Razorgore_OnLoad");

function CT_RABoss_Razorgore_OnLoad()
	CT_RABoss_AddMod("Razorgore", "Displays warnings for the razorgore encounter.", 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	CT_RABoss_AddEvent("Razorgore", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Razorgore_EventHandler);
	CT_RABoss_AddEvent("Razorgore", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Razorgore_EventHandler);
	
	CT_RABoss_AddDropDownButton("Razorgore", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Razorgore", "Display approximately how many eggs should be popped", "CT_RABoss_ModInfo", "displayapproxprogress", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Razorgore", "Announce approximate progress to raid", "CT_RABoss_ModInfo", "announceapproxprogress", "CT_RABoss_SetInfo");
end

function CT_RABoss_Razorgore_EventHandler(event)
	if ( not CT_RABoss_Mods["Razorgore"] or not CT_RABoss_Mods["Razorgore"]["status"] or not CT_RABoss_Mods["Razorgore"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, "breached the hatchery") ) then
		CT_RABoss_Razorgore_StartEncounter();
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, "device shall never torment me") ) then
--		CT_RABoss_Announce("Failed attempt", CT_RABoss_Mods["Razorgore"]["announce"]);
		CT_RABoss_Razorgore_StopWarnings();
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, "controlling power of the orb is drained") ) then
		CT_RABoss_Announce("All eggs popped!", CT_RABoss_Mods["Razorgore"]["announce"]);
		CT_RABoss_Razorgore_StopWarnings();
	end
end

function CT_RABoss_Razorgore_StartEncounter()
	DEFAULT_CHAT_FRAME:AddMessage("Razorgore encounter started, use /rabrr to reset the timers.");
	CT_RABoss_Announce("*** ATTACK THE ORB CONTROLLER!  ENCOUNTER STARTED! ***", CT_RABoss_Mods["Razorgore"]["announce"])
	
	--Timex:AddSchedule("MyAddOn", 5, nil, nil, ace.print, ace, "Hello World!")
	Timex:AddSchedule("CT_RABoss_Razorgore_A", 45, nil, nil, CT_RABoss_Razorgore_WarningA);
	Timex:AddSchedule("CT_RABoss_Razorgore_WarningsStart", 63, nil, nil, CT_RABoss_Razorgore_StartWarnings);
--	Timex:AddSchedule("CT_RABoss_Razorgore_3", 78, nil, nil, CT_RABoss_Razorgore_Warning);
--	Timex:AddSchedule("CT_RABoss_Razorgore_4", 93, nil, nil, CT_RABoss_Razorgore_Warning);
--	Timex:AddSchedule("CT_RABoss_Razorgore_5", 108, nil, nil, CT_RABoss_Razorgore_Warning);
	Timex:AddSchedule("CT_RABoss_Razorgore_B", 123, nil, nil, CT_RABoss_Razorgore_WarningB);
--	Timex:AddSchedule("CT_RABoss_Razorgore_7", 138, nil, nil, CT_RABoss_Razorgore_Warning);
--	Timex:AddSchedule("CT_RABoss_Razorgore_8", 153, nil, nil, CT_RABoss_Razorgore_Warning);
--	Timex:AddSchedule("CT_RABoss_Razorgore_9", 168, nil, nil, CT_RABoss_Razorgore_Warning);
	Timex:AddSchedule("CT_RABoss_Razorgore_C", 183, nil, nil, CT_RABoss_Razorgore_WarningC);
--	Timex:AddSchedule("CT_RABoss_Razorgore_11", 198, nil, nil, CT_RABoss_Razorgore_Warning);
--	Timex:AddSchedule("CT_RABoss_Razorgore_12", 213, nil, nil, CT_RABoss_Razorgore_Warning);
--	Timex:AddSchedule("CT_RABoss_Razorgore_13", 228, nil, nil, CT_RABoss_Razorgore_Warning);
	Timex:AddSchedule("CT_RABoss_Razorgore_D", 243, nil, nil, CT_RABoss_Razorgore_WarningD);
--	Timex:AddSchedule("CT_RABoss_Razorgore_15", 258, nil, nil, CT_RABoss_Razorgore_Warning);
--	Timex:AddSchedule("CT_RABoss_Razorgore_16", 273, nil, nil, CT_RABoss_Razorgore_Warning);
--	Timex:AddSchedule("CT_RABoss_Razorgore_17", 288, nil, nil, CT_RABoss_Razorgore_Warning);
	Timex:AddSchedule("CT_RABoss_Razorgore_E", 303, nil, nil, CT_RABoss_Razorgore_WarningE);
--	Timex:AddSchedule("CT_RABoss_Razorgore_19", 318, nil, nil, CT_RABoss_Razorgore_Warning);
	Timex:AddSchedule("CT_RABoss_Razorgore_F", 333, nil, nil, CT_RABoss_Razorgore_WarningF);
--	Timex:AddSchedule("CT_RABoss_Razorgore_21", 348, nil, nil, CT_RABoss_Razorgore_Warning);
	Timex:AddSchedule("CT_RABoss_Razorgore_G", 363, nil, nil, CT_RABoss_Razorgore_WarningG);
end

function CT_RABoss_Razorgore_StartWarnings()
	CT_RABoss_Razorgore_Warning();
	Timex:AddSchedule("CT_RABoss_Razorgore_Spawns", 15, true, nil, CT_RABoss_Razorgore_Warning);
end

function CT_RABoss_Razorgore_Warning()
	CT_RABoss_Announce("*** Spawns in 2 seconds ***", CT_RABoss_Mods["Razorgore"]["announce"]);
end


function CT_RABoss_Razorgore_WarningA()
	CT_RABoss_Announce("*** Get into Position - Spawns in 5 seconds ***", CT_RABoss_Mods["Razorgore"]["announce"]);
end

function CT_RABoss_Razorgore_WarningB()
	if (CT_RABoss_Mods["Razorgore"]["displayapproxprogress"]) then
		CT_RABoss_Announce("(hopefully 9 eggs down)", CT_RABoss_Mods["Razorgore"]["announceapproxprogress"]);
	end
end

function CT_RABoss_Razorgore_WarningC()
	if (CT_RABoss_Mods["Razorgore"]["displayapproxprogress"]) then
		CT_RABoss_Announce("(hopefully 14 eggs down)", CT_RABoss_Mods["Razorgore"]["announceapproxprogress"]);
	end
end

function CT_RABoss_Razorgore_WarningD()
	if (CT_RABoss_Mods["Razorgore"]["displayapproxprogress"]) then
		CT_RABoss_Announce("(hopefully 19 eggs down)", CT_RABoss_Mods["Razorgore"]["announceapproxprogress"]);
	end
end

function CT_RABoss_Razorgore_WarningE()
	if (CT_RABoss_Mods["Razorgore"]["displayapproxprogress"]) then
		CT_RABoss_Announce("(hopefully 24 eggs down)", CT_RABoss_Mods["Razorgore"]["announceapproxprogress"]);
	end
end

function CT_RABoss_Razorgore_WarningF()
	if (CT_RABoss_Mods["Razorgore"]["displayapproxprogress"]) then
		CT_RABoss_Announce("(hopefully 27 eggs down)", CT_RABoss_Mods["Razorgore"]["announceapproxprogress"]);
	end
end

function CT_RABoss_Razorgore_WarningG()
	if (CT_RABoss_Mods["Razorgore"]["displayapproxprogress"]) then
		CT_RABoss_Announce("(hopefully Razorgore up - 30 eggs down)", CT_RABoss_Mods["Razorgore"]["announce"]);
	end
end

function CT_RABoss_Razorgore_StopWarnings()
	CT_RABoss_Announce("Razorgore encounter timers reset");
	DEFAULT_CHAT_FRAME:AddMessage("Razorgore encounter timers reset");
	
	Timex:DeleteSchedule("CT_RABoss_Razorgore_A");
	Timex:DeleteSchedule("CT_RABoss_Razorgore_B");
	Timex:DeleteSchedule("CT_RABoss_Razorgore_C");
	Timex:DeleteSchedule("CT_RABoss_Razorgore_D");
	Timex:DeleteSchedule("CT_RABoss_Razorgore_E");
	Timex:DeleteSchedule("CT_RABoss_Razorgore_F");
	Timex:DeleteSchedule("CT_RABoss_Razorgore_G");
	Timex:DeleteSchedule("CT_RABoss_Razorgore_WarningsStart");
	Timex:DeleteSchedule("CT_RABoss_Razorgore_Spawns");
end

-- Slash command to start the timers
CT_RA_RegisterSlashCmd("/rabossrazorgorestart", "Starts the razorgore timers", 15, "RABOSSRAZORGORESTART", function(msg)
	CT_RABoss_Razorgore_StartEncounter();
end, "/rabrs");

-- Slash command to reset the timers
CT_RA_RegisterSlashCmd("/rabossrazorgorereset", "Resets the razorgore timers", 15, "RABOSSRAZORGORERESET", function(msg)
	CT_RABoss_Razorgore_StopWarnings();
end, "/rabrr");

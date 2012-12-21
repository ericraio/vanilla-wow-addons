tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Majordomo_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_BaronGeddon_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Magmadar_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Gehennas_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ragnaros_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Shazzrah_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Lucifron_OnLoad");

-- Majordomo
function CT_RABoss_Majordomo_OnLoad()
	-- This adds the mod to the listing. The first parameter is the mod name, the second is the description, and the third is the initial status (nil for off, 1 for on).
	-- The fourth parameter is for the zone, which is used to sort the mods into categories in the Boss Mods menu.
	CT_RABoss_AddMod("Majordomo", CT_RABOSS_DOMO_INFO, 1, CT_RABOSS_LOCATIONS_MOLTENCORE);
	
	-- This adds an event to the mod. The second parameter is obviously the event, and the third is the function which should be called when the event is called.
	CT_RABoss_AddEvent("Majordomo", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Majordomo_EventHandler);
	CT_RABoss_AddEvent("Majordomo", "CHAT_MSG_SPELL_AURA_GONE_OTHER", CT_RABoss_Majordomo_EventHandler);
	
	-- This adds a dropdown button when you right-click the mod in the boss mod listing.
	-- The second parameter is either 1) a table, where the first index is the title of the button, and the second the tooltip description, or 2) just the title as a string.
	-- The third parameter is a function or variable which is called to check if the button should be checked or not. Look up the function "CT_RABoss_ModInfo" for info on how that works. If it's a variable, it will just check that value (nil/false = unchecked, other = checked)
	-- The fourth parameter is the parameter which is sent as the second parameter to the third parameter in case it is a function, and to the fifth parameter as the second parameter too.
	-- The fifth parameter is the function called when you press the button. The parameters passed to this function is the same as the third parameter (in case that is a function), #1 being modName and #2 being the optional third parameter (below "announce").
	CT_RABoss_AddDropDownButton("Majordomo", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Majordomo", { "Hide 5 second warning", "Hides the 5 second warning from being announced." }, "CT_RABoss_ModInfo", "priorWarning", "CT_RABoss_SetInfo");
end

function CT_RABoss_Majordomo_EventHandler(event)
	if ( not CT_RABoss_Mods["Majordomo"] or not CT_RABoss_Mods["Majordomo"]["status"] or not CT_RABoss_Mods["Majordomo"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( string.find(arg1, CT_RABOSS_DOMO_REFLECT_GAIN) and not CT_RABoss_Mods["Majordomo"]["AurasUp"] ) then
			CT_RABoss_Mods["Majordomo"]["AurasUp"] = 1;
			CT_RABoss_Announce("*** MAGIC REFLECTION FOR 10 SECONDS ***", CT_RABoss_Mods["Majordomo"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_Schedule("CT_RABoss_Majordomo_EventHandler", 25, "priorWarning");
		elseif ( string.find(arg1, CT_RABOSS_DOMO_DMGSHIELD_GAIN) and not CT_RABoss_Mods["Majordomo"]["AurasUp"] ) then
			CT_RABoss_Mods["Majordomo"]["AurasUp"] = 2;
			CT_RABoss_Announce(CT_RABOSS_DOMO_DMGSHIELDWARN, CT_RABoss_Mods["Majordomo"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_Schedule("CT_RABoss_Majordomo_EventHandler", 25, "priorWarning");
		end
	elseif ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and CT_RABoss_Mods["Majordomo"]["AurasUp"] ) then
		if ( string.find(arg1, CT_RABOSS_DOMO_REFLECT_FADE) or string.find(arg1, CT_RABOSS_DOMO_DMGSHIELD_FADE) )  then
			CT_RABoss_Announce("*** " .. CT_RABOSS_DOMO_SHIELDS[CT_RABoss_Mods["Majordomo"]["AurasUp"]] .. CT_RABOSS_DOMO_SHIELD_DOWN, CT_RABoss_Mods["Majordomo"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Mods["Majordomo"]["AurasUp"] = nil;
		end
	elseif ( event == "priorWarning" and not CT_RABoss_Mods["Majordomo"]["priorWarning"] ) then
		CT_RABoss_Announce(CT_RABOSS_DOMO_5SECWARN, CT_RABoss_Mods["Majordomo"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end

-- Baron Geddon
function CT_RABoss_BaronGeddon_OnLoad()
	CT_RABoss_AddMod("Baron Geddon", CT_RABOSS_BARON_INFO, 1, CT_RABOSS_LOCATIONS_MOLTENCORE);
	CT_RABoss_AddEvent("Baron Geddon", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_BaronGeddon_EventHandler);
	CT_RABoss_AddEvent("Baron Geddon", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_BaronGeddon_EventHandler);
	CT_RABoss_AddEvent("Baron Geddon", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_BaronGeddon_EventHandler);
	
	CT_RABoss_AddDropDownButton("Baron Geddon", { CT_RABOSS_BARON_ALERT_NEARBY, CT_RABOSS_BARON_ALERT_NEARBY_INFO }, "CT_RABoss_ModInfo", "alertNearby", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Baron Geddon", { CT_RABOSS_BARON_TELL_TARGET, CT_RABOSS_BARON_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Baron Geddon", "alertNearby", 1);
end

function CT_RABoss_BaronGeddon_EventHandler(event)
	if ( not CT_RABoss_Mods["Baron Geddon"] or not CT_RABoss_Mods["Baron Geddon"]["status"] or not CT_RABoss_Mods["Baron Geddon"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Baron Geddon"]["alertNearby"] ) ) then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, CT_RABOSS_BARON_AFFLICT_BOMB);
		if ( sPlayer and sType ) then
			if ( sPlayer == CT_RABOSS_BARON_AFFLICT_SELF_MATCH1 and sType == CT_RABOSS_BARON_AFFLICT_SELF_MATCH2 ) then
				CT_RABoss_Announce(CT_RABOSS_BARON_BOMBWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_BARON_BOMBWARNYOU);
				CT_RABoss_PlaySound(2);
			elseif ( CT_RABoss_Mods["Baron Geddon"]["alertNearby"] or CT_RABoss_Mods["Baron Geddon"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Baron Geddon"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_BARON_BOMBWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Baron Geddon"]["alertNearby"] ) then
					CT_RABoss_Announce(sPlayer .. CT_RABOSS_BARON_BOMBWARNRAID);
					CT_RABoss_PlaySound(2);
				end
			end
		end
	end
end

-- Magmadar
function CT_RABoss_Magmadar_OnLoad()
	CT_RABoss_AddMod("Magmadar", CT_RABOSS_MAGMADAR_INFO, 1, CT_RABOSS_LOCATIONS_MOLTENCORE);
	CT_RABoss_AddEvent("Magmadar", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Magmadar_EventHandler);				-- Frenzy
	CT_RABoss_AddEvent("Magmadar", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Magmadar_EventHandler);		-- Fear
	CT_RABoss_AddEvent("Magmadar", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Magmadar_EventHandler);			-- Fear
	CT_RABoss_AddEvent("Magmadar", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Magmadar_EventHandler);	-- Fear
	CT_RABoss_AddDropDownButton("Magmadar", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Magmadar", { "Frenzy Alert", "When enabled, alerts you of Magmadar's Frenzy as well as the Fear." }, "CT_RABoss_ModInfo", "frenzyAlert", "CT_RABoss_SetInfo");
end

function CT_RABoss_Magmadar_EventHandler(event)
	if ( not CT_RABoss_Mods["Magmadar"] or not CT_RABoss_Mods["Magmadar"]["status"] or not CT_RABoss_Mods["Magmadar"].enabled ) then
		return;
	end
	if ( (event == "CHAT_MSG_MONSTER_EMOTE") and (arg1 == CT_RABOSS_MAGMADAR_FRENZY) and (CT_RABoss_Mods["Magmadar"]["frenzyAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_MAGMADAR_TRANQSHOT, CT_RABoss_Mods["Magmadar"]["announce"]);
		CT_RABoss_PlaySound(2);

	elseif ( event == "preFearWarning" ) then
		CT_RABoss_Mods["Magmadar"]["FearTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_MAGMADAR_5SECWARN, CT_RABoss_Mods["Magmadar"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (string.find(arg1, CT_RABOSS_MAGMADAR_PANIC)) and not CT_RABoss_Mods["Magmadar"]["FearTrip"] ) then
		CT_RABoss_Mods["Magmadar"]["FearTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_MAGMADAR_30SECWARN, CT_RABoss_Mods["Magmadar"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Magmadar_EventHandler", 25, "preFearWarning");
	end
end

-- Gehennas
function CT_RABoss_Gehennas_OnLoad()
	CT_RABoss_AddMod("Gehennas", CT_RABOSS_GEHENNAS_INFO, 1, CT_RABOSS_LOCATIONS_MOLTENCORE);
	CT_RABoss_AddEvent("Gehennas", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Gehennas_EventHandler);
	CT_RABoss_AddEvent("Gehennas", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Gehennas_EventHandler);
	CT_RABoss_AddEvent("Gehennas", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Gehennas_EventHandler);
	CT_RABoss_AddDropDownButton("Gehennas", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Gehennas_EventHandler(event)
	if ( not CT_RABoss_Mods["Gehennas"] or not CT_RABoss_Mods["Gehennas"]["status"] or not CT_RABoss_Mods["Gehennas"].enabled ) then
		return;
	end
	if ( event == "preCurseWarning" ) then
		CT_RABoss_Mods["Gehennas"]["CurseTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_GEHENNAS_5SECWARN, CT_RABoss_Mods["Gehennas"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (string.find(arg1, CT_RABOSS_GEHENNAS_CURSE)) and not CT_RABoss_Mods["Gehennas"]["CurseTrip"] ) then
		CT_RABoss_Mods["Gehennas"]["CurseTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_GEHENNAS_30SECWARN, CT_RABoss_Mods["Gehennas"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Gehennas_EventHandler", 25, "preCurseWarning");
	end
end

-- Ragnaros
-- TODO: missing autostart for non-first attempts and detection of early son kills (use ragnaros melee/spell events to trigger)
function CT_RABoss_Ragnaros_OnLoad()
	CT_RABoss_AddMod("Ragnaros", CT_RABOSS_RAGNAROS_INFO, 1, CT_RABOSS_LOCATIONS_MOLTENCORE);
	CT_RABoss_AddEvent("Ragnaros", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Ragnaros_EventHandler);
	CT_RABoss_AddDropDownButton("Ragnaros", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	
	CT_RA_RegisterSlashCmd("/ragstart", "Starts the Ragnaros boss mod timer. This needs to be used when you engage after the first attempt, should you wipe.", 30, "RAGSTART", function()
		CT_RABoss_UnSchedule("CT_RABoss_Ragnaros_EventHandler");
		CT_RABoss_Ragnaros_EventHandler("RagUp")
	end, "/ragstart");
end

function CT_RABoss_Ragnaros_EventHandler(event)
	if ( not CT_RABoss_Mods["Ragnaros"] or not CT_RABoss_Mods["Ragnaros"]["status"] or not CT_RABoss_Mods["Ragnaros"].enabled ) then
		return;
	end
	-- Rag Emerge
	if ( event == "RagUp" or ( (event == "CHAT_MSG_MONSTER_YELL") and (string.find(arg1, CT_RABOSS_RAGNAROS_START)) ) ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_EMERGE, CT_RABoss_Mods["Ragnaros"]["announce"]);
		CT_RABoss_PlaySound(1);
		CT_RABoss_UnSchedule("CT_RABoss_Ragnaros_EventHandler");  -- Remove outstanding RagUpWarn if all sons die before 15 second warning
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 120, "RagWarn1");
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 160, "RagWarn2");

	elseif ( event == "RagWarn1" ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_60SECSSONS, CT_RABoss_Mods["Ragnaros"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "RagWarn2" ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_20SECSSONS, CT_RABoss_Mods["Ragnaros"]["announce"]);
		CT_RABoss_PlaySound(1);

	-- WOR Warning
	elseif ( event == "preRagKB" ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_5SECSKNOCKB, CT_RABoss_Mods["Ragnaros"]["announce"]);
		CT_RABoss_PlaySound(3);
		
	-- WOR
	elseif ( (event == "CHAT_MSG_MONSTER_YELL") and (string.find(arg1, CT_RABOSS_RAGNAROS_KNOCKBACK)) ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_KNOCKB, CT_RABoss_Mods["Ragnaros"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 23, "preRagKB");

	-- Rag Submerge
	elseif ( (event == "CHAT_MSG_MONSTER_YELL") and (string.find(arg1, CT_RABOSS_RAGNAROS_SONS)) ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_SUBMERGE, CT_RABoss_Mods["Ragnaros"]["announce"]);
		CT_RABoss_PlaySound(1);
		CT_RABoss_UnSchedule("CT_RABoss_Ragnaros_EventHandler");  -- remove outstanding WOR warning
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 75, "RagUpWarn");
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 90, "RagUp");
		
	elseif ( event == "RagUpWarn" ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_15SECSUP, CT_RABoss_Mods["Ragnaros"]["announce"]);
		CT_RABoss_PlaySound(1);
	end
end

-- Shazzrah
function CT_RABoss_Shazzrah_OnLoad()
	CT_RABoss_AddMod("Shazzrah", CT_RABOSS_SHAZZRAH_INFO, 1, CT_RABOSS_LOCATIONS_MOLTENCORE);
	CT_RABoss_AddEvent("Shazzrah", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Shazzrah_EventHandler);
	CT_RABoss_AddDropDownButton("Shazzrah", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Shazzrah_EventHandler(event)
	if ( not CT_RABoss_Mods["Shazzrah"] or not CT_RABoss_Mods["Shazzrah"]["status"] or not CT_RABoss_Mods["Shazzrah"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_SHAZZRAH_BLINK) ) then
		CT_RABoss_Announce(CT_RABOSS_SHAZZRAH_30SECSBLINK, CT_RABoss_Mods["Shazzrah"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Shazzrah_EventHandler", 25, "preBlink");
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_SHAZZRAH_DEADENMAGIC) ) then
		CT_RABoss_Announce(CT_RABOSS_SHAZZRAH_SELFBUFF, CT_RABoss_Mods["Shazzrah"]["announce"]);
		CT_RABoss_PlaySound(1);
	elseif ( event == "preBlink" ) then
		CT_RABoss_Announce(CT_RABOSS_SHAZZRAH_5SECSBLINK, CT_RABoss_Mods["Shazzrah"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end

-- Lucifron
function CT_RABoss_Lucifron_OnLoad()
	CT_RABoss_AddMod("Lucifron", CT_RABOSS_LUCIFRON_INFO, 1, CT_RABOSS_LOCATIONS_MOLTENCORE);
	CT_RABoss_AddEvent("Lucifron", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Lucifron_EventHandler);
	CT_RABoss_AddEvent("Lucifron", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Lucifron_EventHandler);
	CT_RABoss_AddEvent("Lucifron", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Lucifron_EventHandler);
	CT_RABoss_AddDropDownButton("Lucifron", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Lucifron", { CT_RABOSS_LUCIFRON_DOOMMENU, CT_RABOSS_LUCIFRON_DOOMMENU_INFO }, "CT_RABoss_ModInfo", "enableDoom", "CT_RABoss_SetInfo");
end

function CT_RABoss_Lucifron_EventHandler(event)
	if ( not CT_RABoss_Mods["Lucifron"] or not CT_RABoss_Mods["Lucifron"]["status"] or not CT_RABoss_Mods["Lucifron"].enabled ) then
		return;
	end
	if ( event == "preCurseWarning" ) then
		CT_RABoss_Mods["Lucifron"]["CurseTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_LUCIFRON_5SECSCURSE, CT_RABoss_Mods["Lucifron"]["announce"]);
		CT_RABoss_PlaySound(3);
	elseif ( event == "impendingWarning" and CT_RABoss_Mods["Lucifron"]["enableDoom"] ) then
		CT_RABoss_Mods["Lucifron"]["ImpendingTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_LUCIFRON_5SECSDOOM, CT_RABoss_Mods["Lucifron"]["announce"]);
		CT_RABoss_PlaySound(3);
	elseif ( ( string.find(arg1, CT_RABOSS_LUCIFRON_CURSE) ) and not CT_RABoss_Mods["Lucifron"]["CurseTrip"] ) then
		CT_RABoss_Mods["Lucifron"]["CurseTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_LUCIFRON_30SECSCURSE, CT_RABoss_Mods["Lucifron"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Lucifron_EventHandler", 15, "preCurseWarning");
	elseif ( ( string.find(arg1, CT_RABOSS_LUCIFRON_DOOM) ) and not CT_RABoss_Mods["Lucifron"]["ImpendingTrip"] and CT_RABoss_Mods["Lucifron"]["enableDoom"] ) then
		CT_RABoss_Mods["Lucifron"]["ImpendingTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_LUCIFRON_30SECSDOOM, CT_RABoss_Mods["Lucifron"]["announce"]);
		CT_RABoss_PlaySound(1);
		CT_RABoss_Schedule("CT_RABoss_Lucifron_EventHandler", 15, "impendingWarning");
	end
end
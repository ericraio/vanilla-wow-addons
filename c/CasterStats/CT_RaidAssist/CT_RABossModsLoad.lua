CT_RABoss_ModsToLoad = { };

function CT_RABoss_LoadMods()
	for k, v in CT_RABoss_ModsToLoad do
		if ( getglobal(v) ) then
			getglobal(v)();
		end
	end
end

-- Insert mods
	-- MC
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Majordomo_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_BaronGeddon_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Magmadar_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Gehennas_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ragnaros_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Shazzrah_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Lucifron_OnLoad");

	-- Outdoor
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Onyxia_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Azuregos_OnLoad");

	-- BWL
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Vaelastrasz_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Firemaw_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ebonroc_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Flamegor_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Chromaggus_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Nefarian_OnLoad");

	-- ZG
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Jeklik_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Venoxis_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Marli_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_BloodlordMandokir_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Jindo_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Arlokk_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Hakkar_OnLoad");

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
			PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
			CT_RABoss_Schedule("CT_RABoss_Majordomo_EventHandler", 25, "priorWarning");
		elseif ( string.find(arg1, CT_RABOSS_DOMO_DMGSHIELD_GAIN) and not CT_RABoss_Mods["Majordomo"]["AurasUp"] ) then
			CT_RABoss_Mods["Majordomo"]["AurasUp"] = 2;
			CT_RABoss_Announce(CT_RABOSS_DOMO_DMGSHIELDWARN, CT_RABoss_Mods["Majordomo"]["announce"]);
			PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
			CT_RABoss_Schedule("CT_RABoss_Majordomo_EventHandler", 25, "priorWarning");
		end
	elseif ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and CT_RABoss_Mods["Majordomo"]["AurasUp"] ) then
		if ( string.find(arg1, CT_RABOSS_DOMO_REFLECT_FADE) or string.find(arg1, CT_RABOSS_DOMO_DMGSHIELD_FADE) )  then
			CT_RABoss_Announce("*** " .. CT_RABOSS_DOMO_SHIELDS[CT_RABoss_Mods["Majordomo"]["AurasUp"]] .. CT_RABOSS_DOMO_SHIELD_DOWN, CT_RABoss_Mods["Majordomo"]["announce"]);
			PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
			CT_RABoss_Mods["Majordomo"]["AurasUp"] = nil;
		end
	elseif ( event == "priorWarning" and not CT_RABoss_Mods["Majordomo"]["priorWarning"] ) then
		CT_RABoss_Announce(CT_RABOSS_DOMO_5SECWARN, CT_RABoss_Mods["Majordomo"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
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
				PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
			elseif ( CT_RABoss_Mods["Baron Geddon"]["alertNearby"] or CT_RABoss_Mods["Baron Geddon"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Baron Geddon"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_BARON_BOMBWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Baron Geddon"]["alertNearby"] ) then
					CT_RABoss_Announce(sPlayer .. CT_RABOSS_BARON_BOMBWARNRAID);
					PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
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
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");

	elseif ( event == "preFearWarning" ) then
		CT_RABoss_Mods["Magmadar"]["FearTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_MAGMADAR_5SECWARN, CT_RABoss_Mods["Magmadar"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (string.find(arg1, CT_RABOSS_MAGMADAR_PANIC)) and not CT_RABoss_Mods["Magmadar"]["FearTrip"] ) then
		CT_RABoss_Mods["Magmadar"]["FearTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_MAGMADAR_30SECWARN, CT_RABoss_Mods["Magmadar"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
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
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (string.find(arg1, CT_RABOSS_GEHENNAS_CURSE)) and not CT_RABoss_Mods["Gehennas"]["CurseTrip"] ) then
		CT_RABoss_Mods["Gehennas"]["CurseTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_GEHENNAS_30SECWARN, CT_RABoss_Mods["Gehennas"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
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
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
		CT_RABoss_UnSchedule("CT_RABoss_Ragnaros_EventHandler");  -- Remove outstanding RagUpWarn if all sons die before 15 second warning
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 120, "RagWarn1");
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 160, "RagWarn2");

	elseif ( event == "RagWarn1" ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_60SECSSONS, CT_RABoss_Mods["Ragnaros"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "RagWarn2" ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_20SECSSONS, CT_RABoss_Mods["Ragnaros"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	-- WOR Warning
	elseif ( event == "preRagKB" ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_5SECSKNOCKB, CT_RABoss_Mods["Ragnaros"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
		
	-- WOR
	elseif ( (event == "CHAT_MSG_MONSTER_YELL") and (string.find(arg1, CT_RABOSS_RAGNAROS_KNOCKBACK)) ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_KNOCKB, CT_RABoss_Mods["Ragnaros"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 23, "preRagKB");

	-- Rag Submerge
	elseif ( (event == "CHAT_MSG_MONSTER_YELL") and (string.find(arg1, CT_RABOSS_RAGNAROS_SONS)) ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_SUBMERGE, CT_RABoss_Mods["Ragnaros"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
		CT_RABoss_UnSchedule("CT_RABoss_Ragnaros_EventHandler");  -- remove outstanding WOR warning
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 75, "RagUpWarn");
		CT_RABoss_Schedule("CT_RABoss_Ragnaros_EventHandler", 90, "RagUp");
		
	elseif ( event == "RagUpWarn" ) then
		CT_RABoss_Announce(CT_RABOSS_RAGNAROS_15SECSUP, CT_RABoss_Mods["Ragnaros"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
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
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Shazzrah_EventHandler", 25, "preBlink");
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_SHAZZRAH_DEADENMAGIC) ) then
		CT_RABoss_Announce(CT_RABOSS_SHAZZRAH_SELFBUFF, CT_RABoss_Mods["Shazzrah"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
	elseif ( event == "preBlink" ) then
		CT_RABoss_Announce(CT_RABOSS_SHAZZRAH_5SECSBLINK, CT_RABoss_Mods["Shazzrah"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
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
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	elseif ( event == "impendingWarning" and CT_RABoss_Mods["Lucifron"]["enableDoom"] ) then
		CT_RABoss_Mods["Lucifron"]["ImpendingTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_LUCIFRON_5SECSDOOM, CT_RABoss_Mods["Lucifron"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	elseif ( ( string.find(arg1, CT_RABOSS_LUCIFRON_CURSE) ) and not CT_RABoss_Mods["Lucifron"]["CurseTrip"] ) then
		CT_RABoss_Mods["Lucifron"]["CurseTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_LUCIFRON_30SECSCURSE, CT_RABoss_Mods["Lucifron"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Lucifron_EventHandler", 15, "preCurseWarning");
	elseif ( ( string.find(arg1, CT_RABOSS_LUCIFRON_DOOM) ) and not CT_RABoss_Mods["Lucifron"]["ImpendingTrip"] and CT_RABoss_Mods["Lucifron"]["enableDoom"] ) then
		CT_RABoss_Mods["Lucifron"]["ImpendingTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_LUCIFRON_30SECSDOOM, CT_RABoss_Mods["Lucifron"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
		CT_RABoss_Schedule("CT_RABoss_Lucifron_EventHandler", 15, "impendingWarning");
	end
end

-- Onyxia
function CT_RABoss_Onyxia_OnLoad()
	CT_RABoss_AddMod("Onyxia", CT_RABOSS_ONYXIA_INFO, 1, CT_RABOSS_LOCATIONS_ONYXIASLAIR);
	CT_RABoss_AddEvent("Onyxia", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Onyxia_EventHandler);
	CT_RABoss_AddEvent("Onyxia", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Onyxia_EventHandler);
	
	CT_RABoss_AddDropDownButton("Onyxia", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Onyxia", { CT_RABOSS_ONYXIA_PHASE2INFO1, CT_RABOSS_ONYXIA_PHASE2INFO2 }, "CT_RABoss_ModInfo", "warnPhase2", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Onyxia", { CT_RABOSS_ONYXIA_PHASE3INFO1, CT_RABOSS_ONYXIA_PHASE3INFO2 }, "CT_RABoss_ModInfo", "warnPhase3", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Onyxia", "warnPhase2", 1);
	CT_RABoss_SetVar("Onyxia", "warnPhase3", 1);
end


function CT_RABoss_Onyxia_EventHandler(event)
	if ( not CT_RABoss_Mods["Onyxia"] or not CT_RABoss_Mods["Onyxia"]["status"] or not CT_RABoss_Mods["Onyxia"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_EMOTE" and arg1 == CT_RABOSS_ONYXIA_BREATH ) then
		CT_RABoss_Announce(CT_RABOSS_ONYXIA_DEEPBREATH, CT_RABoss_Mods["Onyxia"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_ONYXIA_PHASE2) and CT_RABoss_Mods["Onyxia"]["warnPhase2"] ) then
		CT_RABoss_Announce(CT_RABOSS_ONYXIA_PHASE2TEXT, CT_RABoss_Mods["Onyxia"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_ONYXIA_PHASE3) and CT_RABoss_Mods["Onyxia"]["warnPhase3"] ) then
		CT_RABoss_Announce(CT_RABOSS_ONYXIA_PHASE3TEXT, CT_RABoss_Mods["Onyxia"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	end
end

-- Azuregos
function CT_RABoss_Azuregos_OnLoad()
	CT_RABoss_AddMod("Azuregos", CT_RABOSS_AZUREGOS_INFO, 1, CT_RABOSS_LOCATIONS_OUTDOOR);
	CT_RABoss_AddEvent("Azuregos", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Azuregos_EventHandler);
	CT_RABoss_AddEvent("Azuregos", "CHAT_MSG_SPELL_AURA_GONE_OTHER", CT_RABoss_Azuregos_EventHandler);
	CT_RABoss_AddEvent("Azuregos", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Azuregos_EventHandler);
	CT_RABoss_AddDropDownButton("Azuregos", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Azuregos_EventHandler(event)
	if ( not CT_RABoss_Mods["Azuregos"] or not CT_RABoss_Mods["Azuregos"]["status"] or not CT_RABoss_Mods["Azuregos"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_AZUREGOS_REFLECTION) ) then
		CT_RABoss_Announce(CT_RABOSS_AZUREGOS_SHIELDWARN, CT_RABoss_Mods["Azuregos"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	elseif ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and string.find(arg1, CT_RABOSS_AZUREGOS_REFLECTION_END) ) then
		CT_RABoss_Announce(CT_RABOSS_AZUREGOS_SHIELDDOWN, CT_RABoss_Mods["Azuregos"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_AZUREGOS_TELEPORT) ) then
		CT_RABoss_Announce(CT_RABOSS_AZUREGOS_PORTWARN, CT_RABoss_Mods["Azuregos"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
	end
end

-- Vaelastrasz (Not yet recoded to use translation variables)
function CT_RABoss_Vaelastrasz_OnLoad()
	CT_RABoss_AddMod("Vaelastrasz", "Displays a warning when you or nearby players are inflicted by Burning Adrenaline.", 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	CT_RABoss_AddEvent("Vaelastrasz", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Vaelastrasz_EventHandler);
	CT_RABoss_AddEvent("Vaelastrasz", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Vaelastrasz_EventHandler);
	CT_RABoss_AddEvent("Vaelastrasz", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Vaelastrasz_EventHandler);
	
	CT_RABoss_AddDropDownButton("Vaelastrasz", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Vaelastrasz", { "Alert for nearby players", "Alert you when nearby players are affected with Living Bomb" }, "CT_RABoss_ModInfo", "alertNearby", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Vaelastrasz", { CT_RABOSS_VAEL_TELL_TARGET, CT_RABOSS_VAEL_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Vaelastrasz", "alertNearby", 1);
end

function CT_RABoss_Vaelastrasz_EventHandler(event)
	if ( not CT_RABoss_Mods["Vaelastrasz"] or not CT_RABoss_Mods["Vaelastrasz"]["status"] or not CT_RABoss_Mods["Vaelastrasz"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Vaelastrasz"]["alertNearby"] ) ) then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, "^([^%s]+) ([^%s]+) afflicted by Burning Adrenaline");
		if ( sPlayer and sType ) then
			if ( sPlayer == "You" and sType == "are" ) then
				CT_RABoss_Announce("*** YOU ARE BURNING ***");
				CT_RABoss_Announce("*** YOU ARE BURNING ***");
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Vaelastrasz"]["announce"] ) then
					CT_RA_AddMessage("MS *** " .. UnitName("player") .. " IS BURNING ***");
				end
				PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
			elseif ( CT_RABoss_Mods["Vaelastrasz"]["alertNearby"] or CT_RABoss_Mods["Vaelastrasz"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Vaelastrasz"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_VAEL_BURNINGWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Vaelastrasz"]["alertNearby"] ) then
					CT_RABoss_Announce("*** " .. sPlayer .. " IS BURNING ***", CT_RABoss_Mods["Vaelastrasz"]["announce"]);
					PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
				end
			end
		end
	end
end

-- Firemaw Wing Buffet and Shadowflame (Thanks to Puddy and Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Firemaw_OnLoad()
	CT_RABoss_AddMod("Firemaw", "Displays to the raid when Firemaw casts Wing Buffet and Shadowflame.", 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	CT_RABoss_AddEvent("Firemaw", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Firemaw_EventHandler);
	CT_RABoss_AddDropDownButton("Firemaw", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");	
	CT_RABoss_AddDropDownButton("Firemaw", { "Shadowflame", "When enabled, alerts you of shadowflame." }, "CT_RABoss_ModInfo", "shadowflame", "CT_RABoss_SetInfo");
	CT_RABoss_SetVar("Firemaw", "shadowflame", 1);
end

function CT_RABoss_Firemaw_EventHandler(event)
	if ( not CT_RABoss_Mods["Firemaw"] or not CT_RABoss_Mods["Firemaw"]["status"] or not CT_RABoss_Mods["Firemaw"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, "Firemaw begins to cast Wing Buffet") and not CT_RABoss_Mods["Firemaw"]["BuffetTrip"] ) then
		CT_RABoss_Announce(CT_RABOSS_FIREMAW_BUFFET_WARN, CT_RABoss_Mods["Firemaw"]["announce"]);
		CT_RABoss_Mods["Firemaw"]["BuffetTrip"] = true;
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Firemaw_EventHandler", 29, "preBuffetWarning")

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Firemaw"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_FIREMAW_3SECWARN, CT_RABoss_Mods["Firemaw"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_FIREMAW_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Firemaw"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FIREMAW_SHADOWFLAME_WARN, CT_RABoss_Mods["Firemaw"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	end
end

-- Ebonroc Wing Buffet and Shadowflame (Thanks to Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Ebonroc_OnLoad()
	CT_RABoss_AddMod("Ebonroc", "Displays when Ebonroc casts Wing Buffet, Shadowflame, and Shadow of Ebonroc.", 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	CT_RABoss_AddEvent("Ebonroc", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Ebonroc_EventHandler);
	CT_RABoss_AddEvent("Ebonroc", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Ebonroc_EventHandler);
	CT_RABoss_AddEvent("Ebonroc", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Ebonroc_EventHandler);
	CT_RABoss_AddEvent("Ebonroc", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Ebonroc_EventHandler);
	CT_RABoss_AddDropDownButton("Ebonroc", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");	
	CT_RABoss_AddDropDownButton("Ebonroc", { "Shadowflame", "When enabled, alerts you of shadowflame." }, "CT_RABoss_ModInfo", "shadowflame", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Ebonroc", { "Shadow of Ebonroc", "When enabled, alerts you of Shadow of Ebonroc." }, "CT_RABoss_ModInfo", "shadowEbonroc", "CT_RABoss_SetInfo");
	CT_RABoss_SetVar("Ebonroc", "shadowflame", 1);
	CT_RABoss_SetVar("Ebonroc", "shadowEbonroc", 1);
end

function CT_RABoss_Ebonroc_EventHandler(event)
	if ( not CT_RABoss_Mods["Ebonroc"] or not CT_RABoss_Mods["Ebonroc"]["status"] or not CT_RABoss_Mods["Ebonroc"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, "Ebonroc begins to cast Wing Buffet") and not CT_RABoss_Mods["Ebonroc"]["BuffetTrip"] ) then
		CT_RABoss_Announce(CT_RABOSS_EBONROC_BUFFET_WARN, CT_RABoss_Mods["Ebonroc"]["announce"]);
		CT_RABoss_Mods["Ebonroc"]["BuffetTrip"] = true;
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Ebonroc_EventHandler", 29, "preBuffetWarning")

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Ebonroc"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_EBONROC_3SECWARN, CT_RABoss_Mods["Ebonroc"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_EBONROC_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Ebonroc"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_EBONROC_SHADOWFLAME_WARN, CT_RABoss_Mods["Ebonroc"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) ) then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, CT_RABOSS_EBONROC_AFFLICT_BOMB);
		if ( sPlayer and sType ) then
			if ( sPlayer == CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH1 and sType == CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH2 ) then
				CT_RABoss_Announce(CT_RABOSS_EBONROC_BOMBWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_EBONROC_BOMBWARNYOU);
				PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
			elseif ( CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) then
				if ( CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) then
					CT_RABoss_Announce(sPlayer .. CT_RABOSS_EBONROC_BOMBWARNRAID);
					PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

						end
					end
				end
			end
		end

-- Flamegor Wing Buffet, Shadowflame, and Frenzy (Thanks to Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Flamegor_OnLoad()
	CT_RABoss_AddMod("Flamegor", "Displays when Flamegor casts Wing Buffet, Shadowflame, and goes into a frenzy.", 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	CT_RABoss_AddEvent("Flamegor", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Flamegor_EventHandler);
	CT_RABoss_AddEvent("Flamegor", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Flamegor_EventHandler);				-- Frenzy
	CT_RABoss_AddDropDownButton("Flamegor", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");	
	CT_RABoss_AddDropDownButton("Flamegor", { "Frenzy Alert", "When enabled, alerts you of Flamegor's Frenzy." }, "CT_RABoss_ModInfo", "frenzyAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Flamegor", { "Shadowflame", "When enabled, alerts you of shadowflame." }, "CT_RABoss_ModInfo", "shadowflame", "CT_RABoss_SetInfo");
	CT_RABoss_SetVar("Flamegor", "shadowflame", 1);
	CT_RABoss_SetVar("Flamegor", "frenzyAlert", 1);
end

function CT_RABoss_Flamegor_EventHandler(event)
	if ( not CT_RABoss_Mods["Flamegor"] or not CT_RABoss_Mods["Flamegor"]["status"] or not CT_RABoss_Mods["Flamegor"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, "Flamegor begins to cast Wing Buffet") and not CT_RABoss_Mods["Flamegor"]["BuffetTrip"] ) then
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_BUFFET_WARN, CT_RABoss_Mods["Flamegor"]["announce"]);
		CT_RABoss_Mods["Flamegor"]["BuffetTrip"] = true;
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Flamegor_EventHandler", 29, "preBuffetWarning")

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Flamegor"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_3SECWARN, CT_RABoss_Mods["Flamegor"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_FLAMEGOR_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Flamegor"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_SHADOWFLAME_WARN, CT_RABoss_Mods["Flamegor"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_MONSTER_EMOTE") and (arg1 == CT_RABOSS_FLAMEGOR_FRENZY) and (CT_RABoss_Mods["Flamegor"]["frenzyAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_TRANQSHOT, CT_RABoss_Mods["Flamegor"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
	end
end

-- Chromaggus Frenzy, Resistance change, and Breath attacks (Thanks to Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Chromaggus_OnLoad()
	CT_RABoss_AddMod("Chromaggus", CT_RABOSS_CHROMAGGUS_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	CT_RABoss_AddEvent("Chromaggus", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Chromaggus_EventHandler);				-- Frenzy/Resist Changes
	CT_RABoss_AddEvent("Chromaggus", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Chromaggus_EventHandler); -- Breaths
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { "Frenzy Alerts", "When enabled, alerts you of Chromaggus' Frenzy." }, "CT_RABoss_ModInfo", "frenzyAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { "Resists Alerts", "When enabled, alerts you of Chromaggus' Resistance changes." }, "CT_RABoss_ModInfo", "resistAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { "Breath Alerts", "When enabled, alerts you of Chromaggus' Breath changes." }, "CT_RABoss_ModInfo", "breathAlert", "CT_RABoss_SetInfo");
	CT_RABoss_SetVar("Chromaggus", "resistAlert", 1);
end

function CT_RABoss_Chromaggus_EventHandler(event)
	if ( not CT_RABoss_Mods["Chromaggus"] or not CT_RABoss_Mods["Chromaggus"]["status"] or not CT_RABoss_Mods["Chromaggus"].enabled ) then
		return;
	end
	if ( (event == "CHAT_MSG_MONSTER_EMOTE") and (arg1 == CT_RABOSS_CHROMAGGUS_FRENZY) and (CT_RABoss_Mods["Chromaggus"]["frenzyAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_TRANQSHOT, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( (event == "CHAT_MSG_MONSTER_EMOTE") and (arg1 == CT_RABOSS_CHROMAGGUS_RESIST) and (CT_RABoss_Mods["Chromaggus"]["resistAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_RESIST_CHANGE, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_CHROMAGGUS_FROSTBURNCAST) and (CT_RABoss_Mods["Chromaggus"]["breathAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_FROSTBURN, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Chromaggus_EventHandler", 54, "FROSTBURN8SEC");

	elseif ( event == "FROSTBURN8SEC" ) then
		CT_RABoss_Mods["Chromaggus"]["breathAlert"] = true;
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_FROSTBURN8SEC, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_CHROMAGGUS_TIMELAPSECAST) and (CT_RABoss_Mods["Chromaggus"]["breathAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_TIMELAPSE, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Chromaggus_EventHandler", 54, "TIMELAPSE8SEC");

	elseif ( event == "TIMELAPSE8SEC" ) then
		CT_RABoss_Mods["Chromaggus"]["breathAlert"] = true;
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_TIMELAPSE8SEC, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_CHROMAGGUS_IGNITECAST) and (CT_RABoss_Mods["Chromaggus"]["breathAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_IGNITE, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Chromaggus_EventHandler", 54, "IGNITE8SEC");

	elseif ( event == "IGNITE8SEC" ) then
		CT_RABoss_Mods["Chromaggus"]["breathAlert"] = true;
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_IGNITE8SEC, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_CHROMAGGUS_ACIDCAST) and (CT_RABoss_Mods["Chromaggus"]["breathAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_ACID, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Chromaggus_EventHandler", 54, "ACID8SEC");

	elseif ( event == "ACID8SEC" ) then
		CT_RABoss_Mods["Chromaggus"]["breathAlert"] = true;
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_ACID8SEC, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_CHROMAGGUS_INCINERATECAST) and (CT_RABoss_Mods["Chromaggus"]["breathAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_INCINERATE, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		CT_RABoss_Schedule("CT_RABoss_Chromaggus_EventHandler", 54, "INCINERATE8SEC");

	elseif ( event == "INCINERATE8SEC" ) then
		CT_RABoss_Mods["Chromaggus"]["breathAlert"] = true;
		CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_INCINERATE8SEC, CT_RABoss_Mods["Chromaggus"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	end
end

-- Nefarian (Thanks to Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Nefarian_OnLoad()
	CT_RABoss_AddMod("Nefarian", CT_RABOSS_NEFARIAN_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Nefarian_EventHandler);
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Nefarian_EventHandler);
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { "Shadowflame", "When enabled, alerts you of shadowflame." }, "CT_RABoss_ModInfo", "shadowflame", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { "Fear", "When enabled, alerts you of incoming fears." }, "CT_RABoss_ModInfo", "fearAlert", "CT_RABoss_SetInfo");
end

function CT_RABoss_Nefarian_EventHandler(event)
	if ( not CT_RABoss_Mods["Nefarian"] or not CT_RABoss_Mods["Nefarian"]["status"] or not CT_RABoss_Mods["Nefarian"].enabled ) then
		return;
	end
		if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_SHAMAN_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_SHAMAN_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_DRUID_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_DRUID_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_WARLOCK_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_WARLOCK_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_PRIEST_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PRIEST_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_HUNTER_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_HUNTER_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_WARRIOR_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_WARRIOR_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_ROGUE_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_ROGUE_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_PALADIN_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PALADIN_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_MAGE_CALL) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_MAGE_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_NEFARIAN_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Nefarian"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_SHADOWFLAME_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_NEFARIAN_FEAR_DETECT) and (CT_RABoss_Mods["Nefarian"]["fearAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_FEAR_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_LAND_20SEC_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_LAND_20SEC, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_LANDING_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_LANDING, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_ZERG_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_ZERG, CT_RABoss_Mods["Nefarian"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
	end
end

-- Jeklik (Not yet recoded to use translation variables)
function CT_RABoss_Jeklik_OnLoad()
	CT_RABoss_AddMod("Jeklik", "Displays a warning when High Priestess Jeklik begins to heal and summons bats.", 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Jeklik", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Jeklik_EventHandler);
	CT_RABoss_AddEvent("Jeklik", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Jeklik_EventHandler);
	
	CT_RABoss_AddDropDownButton("Jeklik", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Jeklik_EventHandler(event)
	if ( not CT_RABoss_Mods["Jeklik"] or not CT_RABoss_Mods["Jeklik"]["status"] or not CT_RABoss_Mods["Jeklik"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, "I command you to rain fire down upon these invaders!$") ) then
		CT_RABoss_Announce("*** BOMB BATS INCOMING ***", CT_RABoss_Mods["Jeklik"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, "begins to cast a Great Heal!$") ) then
		CT_RABoss_Announce("*** CASTING HEAL ***", CT_RABoss_Mods["Jeklik"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	end
end

-- Venoxis (Not yet recoded to use translation variables)
function CT_RABoss_Venoxis_OnLoad()
	CT_RABoss_AddMod("Venoxis", "Displays a warning when High Priest Venoxis casts Renew on himself.", 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Venoxis", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Venoxis_EventHandler);
	
	CT_RABoss_AddDropDownButton("Venoxis", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Venoxis_EventHandler(event)
	if ( not CT_RABoss_Mods["Venoxis"] or not CT_RABoss_Mods["Venoxis"]["status"] or not CT_RABoss_Mods["Venoxis"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and arg1 == "High Priest Venoxis gains Renew." ) then
		CT_RABoss_Announce("*** RENEW - DISPEL NOW ***", CT_RABoss_Mods["Venoxis"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
	end
end

-- Mar'li
function CT_RABoss_Marli_OnLoad()
	CT_RABoss_AddMod("Mar'li", CT_RABOSS_MARLI_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Mar'li", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Marli_EventHandler);
	
	CT_RABoss_AddDropDownButton("Mar'li", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Marli_EventHandler(event)
	if ( not CT_RABoss_Mods["Mar'li"] or not CT_RABoss_Mods["Mar'li"]["status"] or not CT_RABoss_Mods["Mar'li"].enabled ) then
	end
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_MARLI_REGEXP) ) then
		CT_RABoss_Announce("*** " .. CT_RABOSS_MARLI_ADDS .. " ***", CT_RABoss_Mods["Mar'li"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
	end
end

-- Bloodlord Mandokir
function CT_RABoss_BloodlordMandokir_OnLoad()
	CT_RABoss_AddMod("Bloodlord Mandokir", CT_RABOSS_MANDOKIR_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Bloodlord Mandokir", "CHAT_MSG_MONSTER_YELL", CT_RABoss_BloodlordMandokir_EventHandler);
	
	CT_RABoss_AddDropDownButton("Bloodlord Mandokir", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Bloodlord Mandokir", { CT_RABOSS_MANDOKIR_TELL_TARGET, CT_RABOSS_MANDOKOIR_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Bloodlord Mandokir", "alertNearby", 1);
end

function CT_RABoss_BloodlordMandokir_EventHandler(event)
	if ( not CT_RABoss_Mods["Bloodlord Mandokir"] or not CT_RABoss_Mods["Bloodlord Mandokir"]["status"] or not CT_RABoss_Mods["Bloodlord Mandokir"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_MANDOKIR_REGEXP) ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_MANDOKIR_REGEXP);
		if ( sPlayer ) then
			if ( sPlayer == UnitName("player") ) then
				CT_RABoss_Announce(CT_RABOSS_MANDOKIR_WATCHWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_MANDOKIR_WATCHWARNYOU);
				PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
			else
				if ( CT_RABoss_Mods["Bloodlord Mandokir"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_MANDOKIR_WATCHWARNTELL, "WHISPER", nil, sPlayer);
				end
				CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_MANDOKIR_WATCHWARNRAID .. " ***");
				PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
			end
		end
		if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Bloodlord Mandokir"]["announce"] ) then
			CT_RA_AddMessage("MS *** " .. sPlayer .. CT_RABOSS_MANDOKIR_WATCHWARNRAID .. " ***");
		end
	end
end

-- Jin'do (Not yet recoded to use translation variables)
function CT_RABoss_Jindo_OnLoad()
	CT_RABoss_AddMod("Jin'do", "Displays a warning when you have Delusions of Jin'do.", 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Jin'do", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Jindo_EventHandler);
	CT_RABoss_AddEvent("Jin'do", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Jindo_EventHandler);
	CT_RABoss_AddEvent("Jin'do", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Jindo_EventHandler);
	CT_RABoss_AddDropDownButton("Jin'do", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Jin'do", { CT_RABOSS_JINDO_ALERT_NEARBY, CT_RABOSS_JINDO_ALERT_NEARBY_INFO }, "CT_RABoss_ModInfo", "alertNearby", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Jin'do", { CT_RABOSS_JINDO_TELL_TARGET, CT_RABOSS_JINDO_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
end

function CT_RABoss_Jindo_EventHandler(event)
	if ( not CT_RABoss_Mods["Jin'do"] or not CT_RABoss_Mods["Jin'do"]["status"] or not CT_RABoss_Mods["Jin'do"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, CT_RABOSS_JINDO_AFFLICT_CURSE);
		if ( sPlayer and sType ) then
			if ( sPlayer == CT_RABOSS_JINDO_AFFLICT_SELF_MATCH1 and sType == CT_RABOSS_JINDO_AFFLICT_SELF_MATCH2 ) then
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Jin'do"]["announce"] ) then
					CT_RA_AddMessage("MS *** " .. UnitName("player") .. " IS CURSED - DO NOT DISPEL ***");
				end
				PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
			elseif ( CT_RABoss_Mods["Jin'do"]["alertNearby"] or CT_RABoss_Mods["Jin'do"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Jin'do"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_JINDO_CURSEWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Jin'do"]["alertNearby"] ) then
					CT_RABoss_Announce("*** " .. sPlayer .. " IS CURSED - DO NOT DISPEL ***", CT_RABoss_Mods["Jin'do"]["announce"]);
					PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
				end
			end
		end
	end
end

-- Hakkar
function CT_RABoss_Hakkar_OnLoad()
	CT_RABoss_AddMod("Hakkar", "Displays a warning when Hakkar life drains.", 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Hakkar", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", CT_RABoss_Hakkar_EventHandler);
	CT_RABoss_AddDropDownButton("Hakkar", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Hakkar_EventHandler(event)
	if ( not CT_RABoss_Mods["Hakkar"] or not CT_RABoss_Mods["Hakkar"]["status"] or not CT_RABoss_Mods["Hakkar"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" and not CT_RABoss_Mods["Hakkar"]["priorWarning"] ) then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, CT_RABOSS_HAKKAR_AFFLICT_POISON);
		if ( sPlayer and sType ) then
			CT_RABoss_Mods["Hakkar"]["priorWarning"] = 1;
			CT_RABoss_Announce("*** LIFE DRAIN - 40 SECONDS UNTIL NEXT ***", CT_RABoss_Mods["Hakkar"]["announce"]);
			PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
			CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 20, "priorWarning");
		end
	elseif ( event == "priorWarning" ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_20SECWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
		CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 10, "priorWarning2");
	elseif ( event == "priorWarning2" and CT_RABoss_Mods["Hakkar"]["priorWarning"] ) then
		CT_RABoss_Mods["Hakkar"]["priorWarning"] = nil;
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_10SECWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	end
end

-- Arlokk
function CT_RABoss_Arlokk_OnLoad()
	CT_RABoss_AddMod("Arlokk", "Lets you know when you or others are marked.", 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Arlokk", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Arlokk_EventHandler);

	CT_RABoss_AddDropDownButton("Arlokk", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Arlokk", { CT_RABOSS_ARLOKK_TELL_TARGET, CT_RABOSS_ARLOKK_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Arlokk", "alertNearby", 1);
end

function CT_RABoss_Arlokk_EventHandler(event)
	if ( not CT_RABoss_Mods["Arlokk"] or not CT_RABoss_Mods["Arlokk"]["status"] or not CT_RABoss_Mods["Arlokk"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_ARLOKK_REGEXP) ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_ARLOKK_REGEXP);
		if ( sPlayer ) then
			if ( sPlayer == UnitName("player") ) then
				CT_RABoss_Announce(CT_RABOSS_ARLOKK_WATCHWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_ARLOKK_WATCHWARNYOU);
				PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
			else
				if ( CT_RABoss_Mods["Arlokk"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_ARLOKK_WATCHWARNTELL, "WHISPER", nil, sPlayer);
				end
				CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_ARLOKK_WATCHWARNRAID .. " ***");
				PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
			end
		end
		if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Arlokk"]["announce"] ) then
			CT_RA_AddMessage("MS *** " .. sPlayer .. CT_RABOSS_ARLOKK_WATCHWARNRAID .. " ***");
		end
	end
end
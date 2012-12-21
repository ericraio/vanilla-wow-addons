tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Vaelastrasz_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Firemaw_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ebonroc_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Flamegor_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Chromaggus_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Nefarian_OnLoad");

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
				CT_RABoss_PlaySound(2);
			elseif ( CT_RABoss_Mods["Vaelastrasz"]["alertNearby"] or CT_RABoss_Mods["Vaelastrasz"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Vaelastrasz"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_VAEL_BURNINGWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Vaelastrasz"]["alertNearby"] ) then
					CT_RABoss_Announce("*** " .. sPlayer .. " IS BURNING ***", CT_RABoss_Mods["Vaelastrasz"]["announce"]);
					CT_RABoss_PlaySound(3);
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
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Firemaw_EventHandler", 29, "preBuffetWarning")

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Firemaw"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_FIREMAW_3SECWARN, CT_RABoss_Mods["Firemaw"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_FIREMAW_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Firemaw"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FIREMAW_SHADOWFLAME_WARN, CT_RABoss_Mods["Firemaw"]["announce"]);
		CT_RABoss_PlaySound(3);
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
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Ebonroc_EventHandler", 27, "preBuffetWarning")

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Ebonroc"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_EBONROC_3SECWARN, CT_RABoss_Mods["Ebonroc"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_EBONROC_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Ebonroc"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_EBONROC_SHADOWFLAME_WARN, CT_RABoss_Mods["Ebonroc"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) ) then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, CT_RABOSS_EBONROC_AFFLICT_BOMB);
		if ( sPlayer and sType ) then
			if ( sPlayer == CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH1 and sType == CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH2 ) then
				CT_RABoss_Announce(CT_RABOSS_EBONROC_SOEOYOU);
				CT_RABoss_Announce(CT_RABOSS_EBONROC_SOEOYOU);
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Ebonroc"]["announce"] ) then
					CT_RA_AddMessage("MS " .. format(CT_RABOSS_EBONROC_SOEOTHER, UnitName("player")));
				end
				CT_RABoss_PlaySound(1);
			elseif ( CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) then
				if ( CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) then
					CT_RABoss_Announce(format(CT_RABOSS_EBONROC_SOEOTHER, sPlayer), CT_RABoss_Mods["Ebonroc"]["announce"]);
					CT_RABoss_PlaySound(1);
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
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Flamegor_EventHandler", 29, "preBuffetWarning")

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Flamegor"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_3SECWARN, CT_RABoss_Mods["Flamegor"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and (arg1 == CT_RABOSS_FLAMEGOR_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Flamegor"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_SHADOWFLAME_WARN, CT_RABoss_Mods["Flamegor"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_MONSTER_EMOTE") and (arg1 == CT_RABOSS_FLAMEGOR_FRENZY) and (CT_RABoss_Mods["Flamegor"]["frenzyAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_TRANQSHOT, CT_RABoss_Mods["Flamegor"]["announce"]);
		CT_RABoss_PlaySound(1);
	end
end

-- Chromaggus

CT_RABoss_Chromaggus_PlayerDamageEvents =
{
	["CHAT_MSG_SPELL_SELF_DAMAGE"] = true,
	["CHAT_MSG_SPELL_PET_DAMAGE"] = true,
	["CHAT_MSG_SPELL_PARTY_DAMAGE"] = true,
	["CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"] = true
};

function CT_RABoss_Chromaggus_OnLoad() -- Many many thanks to Silmalia of Ebon Order for the majority of code for this mod
	CT_RABoss_AddMod("Chromaggus", "Displays stuff I don't have enough time to describe now!", 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);

	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_CHROMAGGUS_BREATHWARNING, CT_RABOSS_CHROMAGGUS_BREATHWARNING_INFO }, "CT_RABoss_ModInfo", "breathWarning", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_CHROMAGGUS_CASTWARNING, CT_RABOSS_CHROMAGGUS_CASTWARNING_INFO }, "CT_RABoss_ModInfo", "castWarning", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_CHROMAGGUS_SHIELDWARNING, CT_RABOSS_CHROMAGGUS_SHIELDWARNING_INFO }, "CT_RABoss_ModInfo", "shieldWarning", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_CHROMAGGUS_FRENZYWARNING, CT_RABOSS_CHROMAGGUS_FRENZYWARNING_INFO }, "CT_RABoss_ModInfo", "frenzyWarning", "CT_RABoss_SetInfo");

	CT_RABoss_UnSchedule("CT_RABoss_Chromaggus_OnEvent");

	CT_RABoss_Mods["Chromaggus"]["Breath 1"] = nil;
	CT_RABoss_Mods["Chromaggus"]["Breath 2"] = nil;
	CT_RABoss_Mods["Chromaggus"]["LastBreath"] = nil;
	CT_RABoss_Mods["Chromaggus"]["Vulnerability"] = nil;
	CT_RABoss_Mods["Chromaggus"]["checkStart"] = nil;

	CT_RABoss_SetVar("Chromaggus", "breathWarning", true);
	CT_RABoss_SetVar("Chromaggus", "castWarning", false);
	CT_RABoss_SetVar("Chromaggus", "frenzyWarning", false);
	CT_RABoss_SetVar("Chromaggus", "shieldWarning", false);

	CT_RABoss_AddEvent("Chromaggus", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Chromaggus_OnEvent); -- Breaths
	CT_RABoss_AddEvent("Chromaggus", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Chromaggus_OnEvent); -- Frenzy
	CT_RABoss_AddEvent("Chromaggus", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Chromaggus_OnEvent); -- Elemental Shield
	CT_RABoss_AddEvent("Chromaggus", "PLAYER_REGEN_DISABLED", CT_RABoss_Chromaggus_OnEvent); -- Start of encounter

	for k, v in CT_RABoss_Chromaggus_PlayerDamageEvents do
		CT_RABoss_AddEvent("Chromaggus", k, CT_RABoss_Chromaggus_OnEvent); -- Detect Elemental Shield vulnerable school
	end
end

function CT_RABoss_Chromaggus_ResetMod()
	CT_RABoss_Mods["Chromaggus"]["Breath 1"] = nil;
	CT_RABoss_Mods["Chromaggus"]["Breath 2"] = nil;
	CT_RABoss_Mods["Chromaggus"]["LastBreath"] = nil;
	CT_RABoss_Mods["Chromaggus"]["CheckStart"] = nil;
	CT_RABoss_Mods["Chromaggus"]["Vulnerability"] = nil;

	CT_RABoss_UnSchedule("CT_RABoss_Chromaggus_OnEvent");
end

function CT_RABoss_Chromaggus_OnEvent(event)
	-- Return if the mod is not enabled
	if ( not CT_RABoss_Mods["Chromaggus"] or not CT_RABoss_Mods["Chromaggus"]["enabled"] or not CT_RABoss_Mods["Chromaggus"]["status"] ) then
		return;
	end
	
	-- Set to current time
	local currTime = GetTime();
	
	if ( CT_RABoss_Mods["Chromaggus"]["Breath 1"] and ( not CT_RABoss_Mods["Chromaggus"]["LastAction"] or ( currTime - CT_RABoss_Mods["Chromaggus"]["LastAction"] ) > CT_RABOSS_CHROMAGGUS_COMBATLIMIT ) and not CT_RABoss_Mods["Chromaggus"]["checkStart"] ) then
		CT_RABoss_Debug(1, "Resetting mod", currTime - ( CT_RABoss_Mods["Chromaggus"]["LastAction"] or currTime+1 ));
		CT_RABoss_Chromaggus_ResetMod();
	end
	
	if ( CT_RABoss_Mods["Chromaggus"]["breathWarning"] and ( event == "Breath 1" or event == "Breath 2" ) ) then
		-- Breath warnings
		local name = event;
		if ( CT_RABoss_Mods["Chromaggus"][event] ) then
			name = CT_RABoss_Mods["Chromaggus"][event];
		end
		CT_RABoss_Debug(2, "Warning for scheduled breath", event, name);
		CT_RABoss_Announce(format(CT_RABOSS_CHROMAGGUS_BREATH10SECWARNING, name), CT_RABoss_Mods["Chromaggus"]["announce"]);
		CT_RABoss_PlaySound(1);
		
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		-- Breath attack
		local iStart, iEnd, spellName = string.find(arg1, CT_RABOSS_CHROMAGGUS_BREATHCASTSTRING);
		
		if ( spellName ) then
			-- Set the names if they are not set yet
			if ( not CT_RABoss_Mods["Chromaggus"]["Breath 1"] ) then
				CT_RABoss_Mods["Chromaggus"]["Breath 1"] = spellName;
				CT_RABoss_Debug(3, "Setting breath 1", spellName);
			elseif ( not CT_RABoss_Mods["Chromaggus"]["Breath 2"] ) then
				CT_RABoss_Mods["Chromaggus"]["Breath 2"] = spellName;
				CT_RABoss_Debug(3, "Setting breath 2", spellName);
			end
			
			-- Used to make sure we're still fighting
			CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
			
			if ( CT_RABoss_Mods["Chromaggus"]["castWarning"] ) then
				CT_RABoss_Announce(format(CT_RABOSS_CHROMAGGUS_BREATHCASTINGWARNING, spellName), CT_RABoss_Mods["Chromaggus"]["announce"]);
			end
			
			if ( CT_RABoss_Mods["Chromaggus"]["Breath 1"] == spellName ) then
				CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME, "Breath 1");
				CT_RABoss_Debug(2, "Scheduling breath", "Breath 1");
			elseif ( CT_RABoss_Mods["Chromaggus"]["Breath 2"] == spellName ) then
				CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME, "Breath 2");
				CT_RABoss_Debug(2, "Scheduling breath", "Breath 2");
			end
		end
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		-- Frenzy
		if ( arg1 == CT_RABOSS_CHROMAGGUS_FRENZYEMOTE and arg2 == CT_RABOSS_CHROMAGGUS_BOSSNAME ) then
			if ( CT_RABoss_Mods["Chromaggus"]["frenzyWarning"] ) then
				CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_FRENZYCASTWARNING, CT_RABoss_Mods["Chromaggus"]["announce"]);
				CT_RABoss_PlaySound(2);
			end
			-- Used to make sure we're still fighting
			CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
			
		-- Elemental Shield
		elseif ( arg1 == CT_RABOSS_CHROMAGGUS_SHIELDEMOTE and arg2 == CT_RABOSS_CHROMAGGUS_BOSSNAME ) then
			if ( CT_RABoss_Mods["Chromaggus"]["shieldWarning"] ) then
				CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYWARNING, CT_RABoss_Mods["Chromaggus"]["announce"]);
				CT_RABoss_PlaySound(1);
			end
			-- Used to make sure we're still fighting
			CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
			
			-- Since spells that are in the air when Chromaggus changes resists will still hit him with vulnerability bonus, we wait 2.5 seconds before we clear resists.
			CT_RABoss_Schedule( function() CT_RABoss_Mods["Chromaggus"]["Vulnerability"] = nil CT_RABoss_Debug(4, "Resetting vulnerability"); end, CT_RABOSS_CHROMAGGUS_WAITSHIELDCLEAR);
		end
		
	elseif ( CT_RABoss_Chromaggus_PlayerDamageEvents[event] ) then
		-- Check for new vulnerabilities
		if ( not CT_RABoss_Mods["Chromaggus"]["Vulnerability"] ) then
			local iStart, iEnd, hittype, damage, school = string.find(arg1, CT_RABOSS_CHROMAGGUS_SPELLDAMAGESTRING);
			
			if ( hittype and tonumber(damage or "") and school and ( hittype == CT_RABOSS_CHROMAGGUS_HIT or hittype == CT_RABOSS_CHROMAGGUS_CRIT ) ) then
				CT_RABoss_Debug(1, "Registered hit", hittype, tonumber(damage), school);
				-- Used to make sure we're still fighting
				CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
				
				if ( 
					( tonumber(damage) >= CT_RABOSS_CHROMAGGUS_ELEMENTALSHIELDLIMIT_HIT and hittype == CT_RABOSS_CHROMAGGUS_HIT ) or
					( tonumber(damage) >= CT_RABOSS_CHROMAGGUS_ELEMENTALSHIELDLIMIT_CRIT and hittype == CT_RABOSS_CHROMAGGUS_CRIT )
				) then
					CT_RABoss_Debug(4, "Setting vulnerability", school, hittype, (tonumber(damage) or -1));
					CT_RABoss_Mods["Chromaggus"]["Vulnerability"] = school;
					
					if ( CT_RABoss_Mods["Chromaggus"]["shieldWarning"] ) then
						CT_RABoss_Announce(format(CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYFOUNDWARNING, school), CT_RABoss_Mods["Chromaggus"]["announce"]);
						CT_RABoss_PlaySound(2);
					end
				end
			end
		end
			
	elseif ( event == "PLAYER_REGEN_DISABLED" ) then
		CT_RABoss_Mods["Chromaggus"]["checkStart"] = true;
		CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", 5, "checkStart");

	elseif ( event == "checkStart" ) then
		local shallRestoreTarget = false;
		
		if ( CT_RABoss_Mods["Chromaggus"]["checkStart"] ) then
			if ( not UnitExists("target") or ( UnitName("target") ~= CT_RABOSS_CHROMAGGUS_BOSSNAME and UnitClass("player") ~= CT_RA_ROGUE ) ) then
				TargetByName(CT_RABOSS_CHROMAGGUS_BOSSNAME);
				shallRestoreTarget = true;
			end
			
			if ( UnitExists("target") and UnitName("target") == CT_RABOSS_CHROMAGGUS_BOSSNAME and UnitAffectingCombat("target") ) then
				CT_RABoss_Chromaggus_ResetMod();
				-- Used to make sure we're still fighting
				CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
				
				CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME - CT_RABOSS_CHROMAGGUS_BREATHINTERVAL - 5, "Breath 1");
				CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME - 5, "Breath 2");
			else
				CT_RABoss_Mods["Chromaggus"]["LastAction"] = nil;
			end
			
			if ( shallRestoreTarget ) then
				TargetLastTarget();
			end
		end
		CT_RABoss_Mods["Chromaggus"]["checkStart"] = nil;
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
	if ( event == "incYell" ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_5SECCALLWARNING, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(2);
		
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_SHAMAN_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_SHAMAN_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_DRUID_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_DRUID_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_WARLOCK_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_WARLOCK_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_PRIEST_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PRIEST_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_HUNTER_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_HUNTER_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_WARRIOR_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_WARRIOR_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_ROGUE_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_ROGUE_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_PALADIN_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PALADIN_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_MAGE_CALL) ) then
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 28, "incYell");
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_MAGE_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and string.find(arg1, CT_RABOSS_NEFARIAN_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Nefarian"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_SHADOWFLAME_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and string.find(arg1, CT_RABOSS_NEFARIAN_FEAR_DETECT) and (CT_RABoss_Mods["Nefarian"]["fearAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_FEAR_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_LAND_20SEC_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_LAND_20SEC, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_LANDING_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_LANDING, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_ZERG_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_ZERG, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
	end
end
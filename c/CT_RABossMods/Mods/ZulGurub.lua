tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Jeklik_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Venoxis_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Marli_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_BloodlordMandokir_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Jindo_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Arlokk_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Hakkar_OnLoad");

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
		CT_RABoss_PlaySound(2);
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, "begins to cast a Great Heal!$") ) then
		CT_RABoss_Announce("*** CASTING HEAL ***", CT_RABoss_Mods["Jeklik"]["announce"]);
		CT_RABoss_PlaySound(3);
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
		CT_RABoss_PlaySound(2);
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
		CT_RABoss_PlaySound(2);
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
				CT_RABoss_PlaySound(2);
			else
				if ( CT_RABoss_Mods["Bloodlord Mandokir"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_MANDOKIR_WATCHWARNTELL, "WHISPER", nil, sPlayer);
				end
				CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_MANDOKIR_WATCHWARNRAID .. " ***");
				CT_RABoss_PlaySound(3);
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
				CT_RABoss_PlaySound(2);
			elseif ( CT_RABoss_Mods["Jin'do"]["alertNearby"] or CT_RABoss_Mods["Jin'do"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Jin'do"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_JINDO_CURSEWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Jin'do"]["alertNearby"] ) then
					CT_RABoss_Announce("*** " .. sPlayer .. " IS CURSED - DO NOT DISPEL ***", CT_RABoss_Mods["Jin'do"]["announce"]);
					CT_RABoss_PlaySound(3);
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
	CT_RABoss_AddDropDownButton("Hakkar", { CT_RABOSS_HAKKAR_ANNOUNCE_45, CT_RABOSS_HAKKAR_ANNOUNCE_45_INFO }, "CT_RABoss_ModInfo", "warn45", "CT_RABoss_SetInfo");
end

function CT_RABoss_Hakkar_EventHandler(event)
	if ( not CT_RABoss_Mods["Hakkar"] or not CT_RABoss_Mods["Hakkar"]["status"] or not CT_RABoss_Mods["Hakkar"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" and not CT_RABoss_Mods["Hakkar"]["priorWarning"] ) then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, CT_RABOSS_HAKKAR_AFFLICT_POISON);
		if ( sPlayer and sType ) then
			CT_RABoss_Mods["Hakkar"]["priorWarning"] = 1;
			CT_RABoss_Announce(CT_RABOSS_HAKKAR_LIFEDRAIN, CT_RABoss_Mods["Hakkar"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 45, "priorWarning");
			CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 75, "priorWarning2");
		end
	elseif ( event == "priorWarning" and CT_RABoss_Mods["Hakkar"]["warn45"] ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_HAKKAR_TIMEWARN, 45), CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
	elseif ( event == "priorWarning2" ) then
		CT_RABoss_Mods["Hakkar"]["priorWarning"] = nil;
		CT_RABoss_Announce(string.format(CT_RABOSS_HAKKAR_TIMEWARN, 15), CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
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
				CT_RABoss_PlaySound(2);
			else
				if ( CT_RABoss_Mods["Arlokk"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_ARLOKK_WATCHWARNTELL, "WHISPER", nil, sPlayer);
				end
				CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_ARLOKK_WATCHWARNRAID .. " ***");
				CT_RABoss_PlaySound(3);
			end
		end
		if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Arlokk"]["announce"] ) then
			CT_RA_AddMessage("MS *** " .. sPlayer .. CT_RABOSS_ARLOKK_WATCHWARNRAID .. " ***");
		end
	end
end
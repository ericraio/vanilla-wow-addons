tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Azuregos_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Emeriss_OnLoad");

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
		CT_RABoss_PlaySound(3);
	elseif ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and string.find(arg1, CT_RABOSS_AZUREGOS_REFLECTION_END) ) then
		CT_RABoss_Announce(CT_RABOSS_AZUREGOS_SHIELDDOWN, CT_RABoss_Mods["Azuregos"]["announce"]);
		CT_RABoss_PlaySound(2);
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_AZUREGOS_TELEPORT) ) then
		CT_RABoss_Announce(CT_RABOSS_AZUREGOS_PORTWARN, CT_RABoss_Mods["Azuregos"]["announce"]);
		CT_RABoss_PlaySound(1);
	end
end

-- Emeriss
function CT_RABoss_Emeriss_OnLoad()
	CT_RABoss_AddMod("Emeriss", CT_RABOSS_EMERISS_INFO, 1, CT_RABOSS_LOCATIONS_OUTDOOR);
	CT_RABoss_AddEvent("Emeriss", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Emeriss_EventHandler);
	CT_RABoss_AddEvent("Emeriss", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Emeriss_EventHandler);
	CT_RABoss_AddEvent("Emeriss", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Emeriss_EventHandler);

	CT_RABoss_AddDropDownButton("Emeriss", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Emeriss", { CT_RABOSS_EMERISS_BREATHMENU, CT_RABOSS_EMERISS_BREATHMENU_INFO }, "CT_RABoss_ModInfo", "enableBreath", "CT_RABoss_SetInfo");
	
	CT_RABoss_AddDropDownButton("Emeriss", { CT_RABOSS_EMERISS_ALERT_NEARBY, CT_RABOSS_EMERISS_ALERT_NEARBY_INFO }, "CT_RABoss_ModInfo", "alertNearby", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Emeriss", { CT_RABOSS_EMERISS_TELL_TARGET, CT_RABOSS_EMERISS_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Emeriss", "alertNearby", 1);
end

function CT_RABoss_Emeriss_EventHandler(event)
	if ( not CT_RABoss_Mods["Emeriss"] or not CT_RABoss_Mods["Emeriss"]["status"] or not CT_RABoss_Mods["Emeriss"].enabled ) then
		return;
	end
	
	if ( event == "breathWarning" and CT_RABoss_Mods["Emeriss"]["enableBreath"] ) then
		CT_RABoss_Mods["Emeriss"]["BreathTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_EMERISS_5SECSBREATH, CT_RABoss_Mods["Emeriss"]["announce"]);
		CT_RABoss_PlaySound(3);
	elseif ( ( string.find(arg1, CT_RABOSS_EMERISS_BREATH) ) and not CT_RABoss_Mods["Emeriss"]["BreathTrip"] and CT_RABoss_Mods["Emeriss"]["enableBreath"] ) then
		CT_RABoss_Mods["Emeriss"]["BreathTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_EMERISS_30SECSBREATH, CT_RABoss_Mods["Emeriss"]["announce"]);
		CT_RABoss_PlaySound(1);
		CT_RABoss_Schedule("CT_RABoss_Emeriss_EventHandler", 25, "breathWarning");
	end
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Emeriss"]["alertNearby"] ) ) then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, CT_RABOSS_EMERISS_AFFLICT_BOMB);
		if ( sPlayer and sType ) then
			if ( sPlayer == CT_RABOSS_EMERISS_AFFLICT_SELF_MATCH1 and sType == CT_RABOSS_EMERISS_AFFLICT_SELF_MATCH2 ) then
				CT_RABoss_Announce(CT_RABOSS_EMERISS_BOMBWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_EMERISS_BOMBWARNYOU);
				CT_RABoss_PlaySound(2);
			elseif ( CT_RABoss_Mods["Emeriss"]["alertNearby"] or CT_RABoss_Mods["Emeriss"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Emeriss"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_EMERISS_BOMBWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Emeriss"]["alertNearby"] ) then
					CT_RABoss_Announce(sPlayer .. CT_RABOSS_EMERISS_BOMBWARNRAID);
					CT_RABoss_PlaySound(2);
				end
			end
		end
	end
end

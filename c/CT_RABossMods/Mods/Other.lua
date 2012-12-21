tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Onyxia_OnLoad");

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
		CT_RABoss_PlaySound(2);
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_ONYXIA_PHASE2) and CT_RABoss_Mods["Onyxia"]["warnPhase2"] ) then
		CT_RABoss_Announce(CT_RABOSS_ONYXIA_PHASE2TEXT, CT_RABoss_Mods["Onyxia"]["announce"]);
		CT_RABoss_PlaySound(3);
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_ONYXIA_PHASE3) and CT_RABoss_Mods["Onyxia"]["warnPhase3"] ) then
		CT_RABoss_Announce(CT_RABOSS_ONYXIA_PHASE3TEXT, CT_RABoss_Mods["Onyxia"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end
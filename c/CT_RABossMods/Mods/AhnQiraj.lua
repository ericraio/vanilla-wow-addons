tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_ProphetSkeram_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Sartura_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Huhuran_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_TwinEmperors_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Defender_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Viscidus_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_CThun_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Buru_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ayamiss_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ossirian_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Rajaxx_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Moam_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Guardian_OnLoad");

-- Prophet Skeram
function CT_RABoss_ProphetSkeram_OnLoad()
	CT_RABoss_AddMod("Prophet Skeram", CT_RABOSS_PROPHETSKERAM_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE);
	CT_RABoss_AddEvent("Prophet Skeram", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_ProphetSkeram_EventHandler);
	CT_RABoss_AddEvent("Prophet Skeram", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", CT_RABoss_ProphetSkeram_EventHandler);
	CT_RABoss_AddDropDownButton("Prophet Skeram", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end


function CT_RABoss_ProphetSkeram_EventHandler(event)
	if ( not CT_RABoss_Mods["Prophet Skeram"] or not CT_RABoss_Mods["Prophet Skeram"]["status"] or not CT_RABoss_Mods["Prophet Skeram"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		if ( arg1 == CT_RABOSS_PROPHETSKERAM_AECASTSTRING ) then
			CT_RABoss_Announce(CT_RABOSS_PROPHETSKERAM_AECASTMESSAGE, CT_RABoss_Mods["Prophet Skeram"]["announce"]);
			CT_RABoss_PlaySound(2);
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" ) then
		local _, _, playerName, playerType = string.find(arg1, CT_RABOSS_PROPHETSKERAM_MCREGEXP);
		if ( playerName ) then
			if ( playerType == CT_RABOSS_PROPHETSKERAM_TYPE_YOU and playerName == CT_RABOSS_PROPHETSKERAM_YOU ) then
				playerName = UnitName("player");
				CT_RABoss_Announce(CT_RABOSS_PROPHETSKERAM_MCCASTMESSAGE_YOU);
				CT_RABoss_Announce(CT_RABOSS_PROPHETSKERAM_MCCASTMESSAGE_YOU);
				CT_RABoss_PlaySound(2);
			else
				CT_RABoss_Announce(string.format(CT_RABOSS_PROPHETSKERAM_MCCASTMESSAGE, playerName));
				CT_RABoss_PlaySound(1);
			end
			if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Prophet Skeram"]["announce"] ) then
				CT_RA_AddMessage("MS " .. string.format(CT_RABOSS_PROPHETSKERAM_MCCASTMESSAGE, playerName));
			end
		end
	end
end

-- Battleguard Sartura
function CT_RABoss_Sartura_OnLoad()
	CT_RABoss_AddMod("Battleguard Sartura", CT_RABOSS_SARTURA_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE );
	CT_RABoss_AddEvent("Battleguard Sartura", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Sartura_EventHandler);
	CT_RABoss_AddEvent("Battleguard Sartura", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Sartura_EventHandler);
	CT_RABoss_AddDropDownButton("Battleguard Sartura", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Battleguard Sartura", { CT_RABOSS_SARTURA_DISPLAYWHIRLWIND, CT_RABOSS_SARTURA_DISPLAYWHIRLWIND }, "CT_RABoss_ModInfo", "displayWhirlwind", "CT_RABoss_SetInfo");
	CT_RABoss_SetVar("Battleguard Sartura", "displayWhirlwind", 1);
end

function CT_RABoss_Sartura_EventHandler(event)
	if ( not CT_RABoss_Mods["Battleguard Sartura"] or not CT_RABoss_Mods["Battleguard Sartura"]["status"] or not CT_RABoss_Mods["Battleguard Sartura"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( CT_RABoss_Mods["Battleguard Sartura"]["displayWhirlwind"] ) then
			if ( arg1 == CT_RABOSS_SARTURA_WHIRLWIND ) then
				CT_RABoss_Announce(CT_RABOSS_SARTURA_WHIRLWINDWARNING);
				CT_RABoss_PlaySound(1);
			elseif ( arg1 == CT_RABOSS_SARTURA_WHIRLWINDFADE ) then
				CT_RABoss_Announce(CT_RABOSS_SARTURA_WHIRLWINDFADEWARNING);
				CT_RABoss_PlaySound(1);
			end
		end
	elseif ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 == CT_RABOSS_SARTURA_DEATH ) then
			CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler", "enrage5m");
			CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler", "enrage1m");
			CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler", "enrage30s");
			CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler", "enrage15s");
		elseif ( arg1 == CT_RABOSS_SARTURA_ENGAGE ) then
			CT_RABoss_Announce(CT_RABOSS_SARTURA_ENGAGEWARNING, CT_RABoss_Mods["Battleguard Sartura"]["announce"]);
			CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 300, "enrage5m");
			CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 540, "enrage1m");
			CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 570, "enrage30s");
			CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 585, "enrage15s");
			CT_RABoss_PlaySound(2);
		end
	elseif ( event == "enrage5m" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_SARTURA_ENRAGEWARNING, CT_RABOSS_SARTURA_5MIN), CT_RABoss_Mods["Battleguard Sartura"]["announce"]);
	elseif ( event == "enrage1m" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_SARTURA_ENRAGEWARNING, CT_RABOSS_SARTURA_1MIN), CT_RABoss_Mods["Battleguard Sartura"]["announce"]);
	elseif ( event == "enrage30s" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_SARTURA_ENRAGEWARNING, CT_RABOSS_SARTURA_30SEC), CT_RABoss_Mods["Battleguard Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);
	elseif ( event == "enrage15s" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_SARTURA_ENRAGEWARNING, CT_RABOSS_SARTURA_15SEC), CT_RABoss_Mods["Battleguard Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end

-- Princess Huhuran
function CT_RABoss_Huhuran_OnLoad()
	CT_RABoss_AddMod("Princess Huhuran", CT_RABOSS_HUHURAN_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE );
	CT_RABoss_AddEvent("Princess Huhuran", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Huhuran_EventHandler);
	CT_RABoss_AddEvent("Princess Huhuran", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Huhuran_EventHandler);
	CT_RABoss_AddDropDownButton("Princess Huhuran", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Princess Huhuran", { CT_RABOSS_HUHURAN_FRENZY, CT_RABOSS_HUHURAN_FRENZY_INFO }, "CT_RABoss_ModInfo", "displayFrenzy", "CT_RABoss_SetInfo");
end

function CT_RABoss_Huhuran_EventHandler(event)
	if ( not CT_RABoss_Mods["Princess Huhuran"] or not CT_RABoss_Mods["Princess Huhuran"]["status"] or not CT_RABoss_Mods["Princess Huhuran"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_HUHURAN_BOSSNAME ) then
		if ( arg1 == CT_RABOSS_HUHURAN_BERSERKSTRING ) then
			CT_RABoss_Announce(CT_RABOSS_HUHURAN_BERSERKWARNING);
			CT_RABoss_PlaySound(1);
		elseif ( CT_RABoss_Mods["Princess Huhuran"]["displayFrenzy"] and arg1 == CT_RABOSS_HUHURAN_FRENZYSTRING ) then
			CT_RABoss_Announce(CT_RABOSS_HUHURAN_FRENZYWARNING);
			CT_RABoss_PlaySound(2);
		end
	end
end

-- Anubisath Defenders
function CT_RABoss_Defender_OnLoad()
	CT_RABoss_AddMod("Anubisath Defenders", CT_RABOSS_DEFENDER_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE);
	CT_RABoss_AddEvent("Anubisath Defenders", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defenders", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defenders", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defenders", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defenders", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defenders", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defenders", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defenders", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddDropDownButton("Anubisath Defenders", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Defenders", { CT_RABOSS_DEFENDER_PLAGUETELL, CT_RABOSS_DEFENDER_PLAGUETELL_INFORM }, "CT_RABoss_ModInfo", "sendPlagueTells", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Defenders", { CT_RABOSS_DEFENDER_SUMMON, CT_RABOSS_DEFENDER_SUMMON_INFO }, "CT_RABoss_ModInfo", "notifySummon", "CT_RABoss_SetInfo");
end


function CT_RABoss_Defender_EventHandler(event)
	if ( not CT_RABoss_Mods["Anubisath Defenders"] or not CT_RABoss_Mods["Anubisath Defenders"]["status"] or not CT_RABoss_Mods["Anubisath Defenders"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( arg1 == CT_RABOSS_DEFENDER_EXPLODESTRING ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_EXPLODING, CT_RABoss_Mods["Anubisath Defenders"]["announce"]);
		elseif ( arg1 == CT_RABOSS_DEFENDER_ENRAGESTRING ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_ENRAGING, CT_RABoss_Mods["Anubisath Defenders"]["announce"]);
		end
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) then
		if ( CT_RABoss_Mods["Anubisath Defenders"]["notifySummon"] ) then
			if ( arg1 == CT_RABOSS_DEFENDER_SUMMONGUARDSTRING ) then
				CT_RABoss_Announce(CT_RABOSS_DEFENDER_SUMMONEDGUARD, CT_RABoss_Mods["Anubisath Defenders"]["announce"]);
			elseif ( arg1 == CT_RABOSS_DEFENDER_SUMMONWARRIORSTRING ) then
				CT_RABoss_Announce(CT_RABOSS_DEFENDER_SUMMONEDWARRIOR, CT_RABoss_Mods["Anubisath Defenders"]["announce"]);
			end
		end
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") then
		if ( string.find(arg1, CT_RABOSS_DEFENDER_THUNDERCLAPSTRING) ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_THUNDERCLAP, CT_RABoss_Mods["Anubisath Defenders"]["announce"]);
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		local _, _, playerName, playerType = string.find(arg1, CT_RABOSS_DEFENDER_PLAGUEREGEXP);
		if ( playerName ) then
			if ( playerType == CT_RABOSS_DEFENDER_TYPE_YOU and playerName == CT_RABOSS_DEFENDER_YOU ) then
				playerName = UnitName("player");
				CT_RABoss_Announce(string.format(CT_RABOSS_DEFENDER_PLAGUEWARNING, CT_RABOSS_DEFENDER_YOUHAVE));
				CT_RABoss_Announce(string.format(CT_RABOSS_DEFENDER_PLAGUEWARNING, CT_RABOSS_DEFENDER_YOUHAVE));
				CT_RABoss_PlaySound(2);
			else
				if ( CT_RABoss_Mods["Anubisath Defenders"]["sendPlagueTells"] ) then
					SendChatMessage(CT_RABOSS_DEFENDER_PLAGUEWARNING_TELL, "WHISPER", nil, playerName);
				end
				CT_RABoss_PlaySound(1);
				CT_RABoss_Announce(string.format(CT_RABOSS_DEFENDER_PLAGUEWARNING, playerName .. CT_RABOSS_DEFENDER_HAS));
			end
			if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Anubisath Defenders"]["announce"] ) then
				CT_RA_AddMessage("MS " .. string.format(CT_RABOSS_DEFENDER_PLAGUEWARNING, playerName .. CT_RABOSS_DEFENDER_HAS));
			end
		end
	end
end

-- Twin Emperors
function CT_RABoss_TwinEmperors_OnLoad()
	CT_RABoss_AddMod("Twin Emperors", CT_RABOSS_TWINEMPERORS_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE);
	CT_RABoss_AddEvent("Twin Emperors", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_TwinEmperors_EventHandler);
	CT_RABoss_AddEvent("Twin Emperors", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_TwinEmperors_EventHandler);
	CT_RABoss_AddDropDownButton("Twin Emperors", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Twin Emperors", { CT_RABOSS_TWINEMPERORS_EXPLODE, CT_RABOSS_TWINEMPERORS_EXPLODE_INFO }, "CT_RABoss_ModInfo", "explodeBug", "CT_RABoss_SetInfo");
	CT_RABoss_SetVar("Twin Emperors", "explodeBug", 1);
end

function CT_RABoss_TwinEmperors_EventHandler(event)
	if ( not CT_RABoss_Mods["Twin Emperors"] or not CT_RABoss_Mods["Twin Emperors"]["status"] or not CT_RABoss_Mods["Twin Emperors"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		if ( not CT_RABoss_Mods["Twin Emperors"]["tripTeleport"] and arg1 == CT_RABOSS_TWINEMPERORS_TELEPORTSTRING_CASTER or arg1 == CT_RABOSS_TWINEMPERORS_TELEPORTSTRING_MELEE ) then
			CT_RABoss_SetVar("Twin Emperors", "tripTeleport", 1);
			CT_RABoss_Announce(CT_RABOSS_TWINEMPERORS_TELEPORT, CT_RABoss_Mods["Twin Emperors"]["announce"]);
			CT_RABoss_Schedule("CT_RABoss_TwinEmperors_EventHandler", 20, "teleport10");
			CT_RABoss_Schedule("CT_RABoss_TwinEmperors_EventHandler", 25, "teleport5");
			CT_RABoss_PlaySound(1);
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( CT_RABoss_Mods["Twin Emperors"]["explodeBug"] and string.find(arg1, CT_RABOSS_TWINEMPERORS_EXPLODEBUGSTRING) ) then
			CT_RABoss_Announce(CT_RABOSS_TWINEMPERORS_EXPLODEBUGWARNING);
			CT_RABoss_PlaySound(2);
		end
	elseif ( event == "teleport10" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_TWINEMPERORS_TELEPORTINC, 10), CT_RABoss_Mods["Twin Emperors"]["announce"]);
		CT_RABoss_SetVar("Twin Emperors", "tripTeleport", nil);
		CT_RABoss_PlaySound(3);
	elseif ( event == "teleport5" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_TWINEMPERORS_TELEPORTINC, 5), CT_RABoss_Mods["Twin Emperors"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end

-- Viscidus
function CT_RABoss_Viscidus_OnLoad()
	CT_RABoss_AddMod("Viscidus", CT_RABOSS_VISCIDUS_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE);
	CT_RABoss_AddEvent("Viscidus", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Viscidus_EventHandler);
	CT_RABoss_AddEvent("Viscidus", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Viscidus_EventHandler);
	CT_RABoss_AddEvent("Viscidus", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Viscidus_EventHandler);
	CT_RABoss_AddEvent("Viscidus", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Viscidus_EventHandler);
	CT_RABoss_AddDropDownButton("Viscidus", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Viscidus", { CT_RABOSS_VISCIDUS_CLOUD, CT_RABOSS_VISCIDUS_CLOUD_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
end

function CT_RABoss_Viscidus_EventHandler(event)
	if ( not CT_RABoss_Mods["Viscidus"] or not CT_RABoss_Mods["Viscidus"]["status"] or not CT_RABoss_Mods["Viscidus"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if ( arg1 == CT_RABOSS_VISCIDUS_FREEZE_STRING ) then
			CT_RABoss_Announce(CT_RABOSS_VISCIDUS_FREEZE_MESSAGE, CT_RABoss_Mods["Viscidus"]["announce"]);
		end
	else
		local _, _, playerName, playerType = string.find(arg1, CT_RABOSS_VISCIDUS_TOXINREGEXP);
		if ( playerName ) then
			if ( playerType == CT_RABOSS_VISCIDUS_TYPE_YOU and playerName == CT_RABOSS_VISCIDUS_YOU ) then
				playerName = UnitName("player");
				CT_RABoss_Announce(CT_RABOSS_VISCIDUS_TOXIN_WARNING);
				CT_RABoss_Announce(CT_RABOSS_VISCIDUS_TOXIN_WARNING);
				CT_RABoss_Announce(CT_RABOSS_VISCIDUS_TOXIN_WARNING);
				CT_RABoss_PlaySound(2);
			elseif ( CT_RABoss_Mods["Viscidus"]["sendTell"] ) then
				SendChatMessage(CT_RABOSS_VISCIDUS_TOXIN_WARNING, "WHISPER", nil, playerName);
			end
		end
	end
end

--C'Thun
function CT_RABoss_CThun_OnLoad()
	CT_RABoss_AddMod("C'Thun", CT_RABOSS_CTHUN_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE );
	CT_RABoss_AddEvent("C'Thun", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddEvent("C'Thun", "PLAYER_REGEN_DISABLED", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddEvent("C'Thun", "PLAYER_ENTERING_WORLD", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddEvent("C'Thun", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddDropDownButton("C'Thun", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RA_RegisterSlashCmd("/racthunstart", "Type this when you engage C'Thun.", 15, "CTHUNSTART", function() 
		CT_RABoss_Announce(CT_RABOSS_CTHUN_TENT45, CT_RABoss_Mods["C'Thun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 40, "tent5");
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 45, "glareinc");
		CT_RABoss_SetVar("C'Thun", "engaged", 1);
	end, "/racthunstart");
end

function CT_RABoss_CThun_EventHandler(event)
	if ( not CT_RABoss_Mods["C'Thun"] or not CT_RABoss_Mods["C'Thun"]["status"] or not CT_RABoss_Mods["C'Thun"].enabled ) then
		return;
	end
	-- This part is for stage 1.
	if ( event == "PLAYER_REGEN_DISABLED" ) then
		if ( not CT_RABoss_Mods["C'Thun"]["engaged"] ) then
			local swapTarget = false;
			if ( not UnitExists("target") or ( UnitName("target") ~= CT_RABOSS_CTHUN_BOSSNAME_PHASE1 and UnitClass("player") ~= CT_RA_ROGUE ) ) then
				swapTarget = true;
			end
			TargetByName(CT_RABOSS_CTHUN_BOSSNAME_PHASE1);
			if ( UnitName("target") == CT_RABOSS_CTHUN_BOSSNAME_PHASE1 and UnitAffectingCombat("target") ) then
				CT_RABoss_Announce(CT_RABOSS_CTHUN_TENT45, CT_RABoss_Mods["C'Thun"]["announce"]);
				CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 35, "tent5");
				CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 45, "glareinc");
			end
			if ( swapTarget ) then
				TargetLastTarget();
			end
			CT_RABoss_SetVar("C'Thun", "engaged", 1);
		end
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		CT_RABoss_UnSchedule("CT_RABoss_CThun_EventHandler", "glareinc");
		CT_RABoss_UnSchedule("CT_RABoss_CThun_EventHandler", "glarestop");
		CT_RABoss_UnSchedule("CT_RABoss_CThun_EventHandler", "tent5");
		CT_RABoss_UnSchedule("CT_RABoss_CThun_EventHandler", "tentspawn");
		CT_RABoss_SetVar("C'Thun", "engaged", nil);
	elseif ( event == "tentspawn" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_TENTSPAWN, CT_RABoss_Mods["C'Thun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 40, "tent5");
	
	elseif ( event == "tent5" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_TENT5, CT_RABoss_Mods["C'Thun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 5, "tentspawn");
		
	elseif ( event == "glareinc" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_GLAREINC, CT_RABoss_Mods["C'Thun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 5, "glare");
		
	elseif ( event == "glare" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_GLARE, CT_RABoss_Mods["C'Thun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 33, "glareincstop");
	
	elseif ( event == "glareincstop" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_GLARESTOPINC, CT_RABoss_Mods["C'Thun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 5, "glarestop");
		
	elseif ( event == "glarestop" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_GLARESTOP, CT_RABoss_Mods["C'Thun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 42, "glareinc");
		
	-- This part is for stage 2.
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_CTHUN_BOSSNAME_PHASE2 ) then
		if ( arg1 == CT_RABOSS_CTHUN_WEAKENED ) then
			CT_RABoss_Announce(CT_RABOSS_CTHUN_VULNERABLE45, CT_RABoss_Mods["C'Thun"]["announce"]);
			CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 35, "weakened10");
		end

	elseif (event == "weakened10" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_INVULNERABLE10, CT_RABoss_Mods["C'Thun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 10, "invuln");
		
	elseif (event == "invuln" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_INVULN, CT_RABoss_Mods["C'Thun"]["announce"]);
	end
end

-- Buru the Gorger
function CT_RABoss_Buru_OnLoad()
	CT_RABoss_AddMod("Buru the Gorger", CT_RABOSS_BURU_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJRUINS );
	CT_RABoss_AddEvent("Buru the Gorger", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Buru_EventHandler);
	CT_RABoss_AddDropDownButton("Buru the Gorger", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Buru the Gorger", { CT_RABOSS_BURU_TELL_TARGET, CT_RABOSS_BURU_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
end

function CT_RABoss_Buru_EventHandler(event)
	if ( not CT_RABoss_Mods["Buru the Gorger"] or not CT_RABoss_Mods["Buru the Gorger"]["status"] or not CT_RABoss_Mods["Buru the Gorger"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		local _, _, sPlayer = string.find(arg1, CT_RABOSS_BURU_EYEREGEXP);
		if ( sPlayer ) then
			local playerName = UnitName("player");
			CT_RABoss_Announce(string.format(CT_RABOSS_BURU_EYEWARNING, sPlayer), CT_RABoss_Mods["Buru the Gorger"]["announce"]);
			if ( sPlayer ~= playerName and CT_RABoss_Mods["Buru the Gorger"]["sendTell"] ) then
				SendChatMessage(CT_RABOSS_BURU_EYEWARNING_YOU, "WHISPER", nil, sPlayer);
			elseif ( sPlayer == playerName ) then
				CT_RABoss_PlaySound(2);
			end
		end
	end
end

-- Ayamiss the Hunter
function CT_RABoss_Ayamiss_OnLoad()
	CT_RABoss_AddMod("Ayamiss the Hunter", CT_RABOSS_AYAMISS_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJRUINS );
	CT_RABoss_AddEvent("Ayamiss the Hunter", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Ayamiss_EventHandler);
	CT_RABoss_AddEvent("Ayamiss the Hunter", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Ayamiss_EventHandler);
	CT_RABoss_AddEvent("Ayamiss the Hunter", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Ayamiss_EventHandler);
	CT_RABoss_AddDropDownButton("Ayamiss the Hunter", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end


function CT_RABoss_Ayamiss_EventHandler(event)
	if ( not CT_RABoss_Mods["Ayamiss the Hunter"] or not CT_RABoss_Mods["Ayamiss the Hunter"]["status"] or not CT_RABoss_Mods["Ayamiss the Hunter"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		local _, _, sPlayer,sType = string.find(arg1, CT_RABOSS_AYAMISS_SACRIFICEREGEXP);
		if ( sPlayer and sType ) then
			if ( sPlayer == CT_RABOSS_AYAMISS_SELF_MATCH1 and sType == CT_RABOSS_AYAMISS_SELF_MATCH2 ) then
				sPlayer = UnitName("player");
			end
			CT_RABoss_PlaySound(1);
			CT_RABoss_Announce(format(CT_RABOSS_AYAMISS_WARNING, sPlayer), CT_RABoss_Mods["Ayamiss the Hunter"]["announce"]);
		end
	end
end

-- Ossirian the Unscarred
function CT_RABoss_Ossirian_OnLoad()
	CT_RABoss_AddMod("Ossirian the Unscarred", CT_RABOSS_OSSIRIAN_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJRUINS );
	CT_RABoss_AddEvent("Ossirian the Unscarred", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian the Unscarred", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian the Unscarred", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddDropDownButton("Ossirian the Unscarred", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Ossirian the Unscarred", { CT_RABOSS_OSSIRIAN_DISPLAYWEAKNESSES, CT_RABOSS_OSSIRIAN_DISPLAYWEAKNESSES_INFO }, "CT_RABoss_ModInfo", "displayWeakness", "CT_RABoss_SetInfo");
	CT_RABoss_SetVar("Ossirian the Unscarred", "displayWeakness", 1);
end

function CT_RABoss_Ossirian_EventHandler(event)
	if ( not CT_RABoss_Mods["Ossirian the Unscarred"] or not CT_RABoss_Mods["Ossirian the Unscarred"]["status"] or not CT_RABoss_Mods["Ossirian the Unscarred"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( arg1 == CT_RABOSS_OSSIRIAN_SUPREMEBUFF ) then
			CT_RABoss_Announce(CT_RABOSS_OSSIRIAN_SUPREMEBUFFWARNING, CT_RABoss_Mods["Ossirian the Unscarred"]["announce"]);
			CT_RABoss_PlaySound(1);
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" ) then
		if ( CT_RABoss_Mods["Ossirian the Unscarred"]["displayWeakness"] ) then
			local _, _, debuffName = string.find(arg1, CT_RABOSS_OSSIRIAN_DEBUFFREGEXP);
			if ( debuffName ) then
				CT_RABoss_Announce(format(CT_RABOSS_OSSIRIAN_WEAKNESS, strupper(debuffName)), CT_RABoss_Mods["Ossirian the Unscarred"]["announce"]);
				CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler", "debuffFade5");
				CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler", "debuffFade15");
				CT_RABoss_Schedule("CT_RABoss_Ossirian_EventHandler", 40, "debuffFade5");
				CT_RABoss_Schedule("CT_RABoss_Ossirian_EventHandler", 30, "debuffFade15");
				CT_RABoss_PlaySound(2);
			end
		end
	elseif ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 == CT_RABOSS_OSSIRIAN_DEATH ) then
			CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler", "debuffFade5");
			CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler", "debuffFade15");
		end
	elseif ( event == "debuffFade15" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_OSSIRIAN_DEBUFFFADE, 15), CT_RABoss_Mods["Ossirian the Unscarred"]["announce"]);
		CT_RABoss_PlaySound(3);
	elseif ( event == "debuffFade5" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_OSSIRIAN_DEBUFFFADE, 5), CT_RABoss_Mods["Ossirian the Unscarred"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end

-- General Rajaxx
function CT_RABoss_Rajaxx_OnLoad()
	CT_RABoss_AddMod("General Rajaxx", CT_RABOSS_RAJAXX_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJRUINS );
	CT_RABoss_AddEvent("General Rajaxx", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Rajaxx_EventHandler);
	CT_RABoss_AddDropDownButton("General Rajaxx", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Rajaxx_EventHandler(event)
	if ( not CT_RABoss_Mods["General Rajaxx"] or not CT_RABoss_Mods["General Rajaxx"]["status"] or not CT_RABoss_Mods["General Rajaxx"].enabled ) then
		return;
	end
	if ( arg2 == CT_RABOSS_RAJAXX_LIEUTENANT or arg2 == CT_RABOSS_RAJAXX_GENERAL ) then
		if ( arg1 == CT_RABOSS_RAJAXX_WAVE1 ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_INCOMINGWAVE, 1), CT_RABoss_Mods["General Rajaxx"]["announce"]);
		elseif ( arg1 == CT_RABOSS_RAJAXX_WAVE3 ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_INCOMINGWAVE, 3), CT_RABoss_Mods["General Rajaxx"]["announce"]);
		elseif ( arg1 == CT_RABOSS_RAJAXX_WAVE4 ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_INCOMINGWAVE, 4), CT_RABoss_Mods["General Rajaxx"]["announce"]);
		elseif ( arg1 == CT_RABOSS_RAJAXX_WAVE5 ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_INCOMINGWAVE, 5), CT_RABoss_Mods["General Rajaxx"]["announce"]);
		elseif ( arg1 == CT_RABOSS_RAJAXX_WAVE6 ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_INCOMINGWAVE, 6), CT_RABoss_Mods["General Rajaxx"]["announce"]);
		elseif ( arg1 == CT_RABOSS_RAJAXX_WAVE7 ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_INCOMINGWAVE, 7), CT_RABoss_Mods["General Rajaxx"]["announce"]);
		elseif ( arg1 == CT_RABOSS_RAJAXX_WAVE8 ) then
			CT_RABoss_Announce(CT_RABOSS_RAJAXX_FINALWAVE, CT_RABoss_Mods["General Rajaxx"]["announce"]);
		end
	elseif ( arg2 == CT_RABOSS_RAJAXX_TUUBID ) then
		local _, _, playerName = string.find(arg1, CT_RABOSS_RAJAXX_TUUBID_REGEXP);
		if ( playerName ) then
			if ( playerName == UnitName("player") ) then
				CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_HEALTARGET, CT_RABOSS_RAJAXX_YOURSELF));
				CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_HEALTARGET, CT_RABOSS_RAJAXX_YOURSELF));
				CT_RABoss_PlaySound(2);
			else
				CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_HEALTARGET, playerName));
				CT_RABoss_PlaySound(3);
			end
			if ( CT_RA_Level >= 1 and CT_RABoss_Mods["General Rajaxx"]["announce"] ) then
				CT_RA_AddMessage("MS " .. string.format(CT_RABOSS_RAJAXX_HEALTARGET, playerName));
			end
		end
	end
end

-- Moam
function CT_RABoss_Moam_OnLoad()
	CT_RABoss_AddMod("Moam", CT_RABOSS_MOAM_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJRUINS );
	CT_RABoss_AddEvent("Moam", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Moam_EventHandler);
	CT_RABoss_AddEvent("Moam", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Moam_EventHandler);
	CT_RABoss_AddDropDownButton("Moam", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Moam_EventHandler(event)
	if ( not CT_RABoss_Mods["Moam"] or not CT_RABoss_Mods["Moam"]["status"] or not CT_RABoss_Mods["Moam"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if ( arg1 == CT_RABOSS_MOAM_FEAR ) then
			CT_RABoss_Announce(CT_RABOSS_MOAM_ENGAGE, CT_RABoss_Mods["Moam"]["announce"]);
			CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 60, "adds30");
		elseif ( arg1 == CT_RABOSS_MOAM_STONE ) then
			CT_RABoss_Announce(CT_RABOSS_MOAM_ADDS, CT_RABoss_Mods["Moam"]["announce"]);
			CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 75, "return15");
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( string.find(arg1, CT_RABOSS_MOAM_RETURNREGEXP) ) then
			CT_RABoss_Announce(CT_RABOSS_MOAM_RETURN, CT_RABoss_Mods["Moam"]["announce"]);
			CT_RABoss_UnSchedule("CT_RABoss_Moam_EventHandler", "adds30");
			CT_RABoss_UnSchedule("CT_RABoss_Moam_EventHandler", "adds15");
			CT_RABoss_UnSchedule("CT_RABoss_Moam_EventHandler", "adds5");
			CT_RABoss_UnSchedule("CT_RABoss_Moam_EventHandler", "return15");
		end
	elseif ( event == "adds30" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_MOAM_ADDSINC, 30), CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 15, "adds15");
	elseif ( event == "adds15" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_MOAM_ADDSINC, 15), CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 5, "adds5");
	elseif ( event == "adds5" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_MOAM_ADDSINC, 5), CT_RABoss_Mods["Moam"]["announce"]);
	elseif ( event == "return15" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_MOAM_RETURNINC, 15), CT_RABoss_Mods["Moam"]["announce"]);
	end
end

-- Anubisath Guardians
function CT_RABoss_Guardian_OnLoad()
	CT_RABoss_AddMod("Anubisath Guardians", CT_RABOSS_DEFENDER_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJRUINS);
	CT_RABoss_AddEvent("Anubisath Guardians", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardians", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardians", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardians", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardians", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardians", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardians", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddDropDownButton("Anubisath Guardians", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Guardians", { CT_RABOSS_DEFENDER_PLAGUETELL, CT_RABOSS_DEFENDER_PLAGUETELL_INFOM }, "CT_RABoss_ModInfo", "sendPlagueTells", "CT_RABoss_SetInfo");
end


function CT_RABoss_Guardian_EventHandler(event)
	if ( not CT_RABoss_Mods["Anubisath Guardians"] or not CT_RABoss_Mods["Anubisath Guardians"]["status"] or not CT_RABoss_Mods["Anubisath Guardians"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( arg1 == CT_RABOSS_GUARDIAN_EXPLODESTRING ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_EXPLODING, CT_RABoss_Mods["Anubisath Guardians"]["announce"]);
		elseif ( arg1 == CT_RABOSS_GUARDIAN_ENRAGESTRING ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_ENRAGING, CT_RABoss_Mods["Anubisath Guardians"]["announce"]);
		end
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") then
		if ( string.find(arg1, CT_RABOSS_GUARDIAN_THUNDERCLAPSTRING) ) then
			CT_RABoss_Announce(CT_RABOSS_GUARDIAN_THUNDERCLAP, CT_RABoss_Mods["Anubisath Guardians"]["announce"]);
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		local _, _, playerName, playerType = string.find(arg1, CT_RABOSS_DEFENDER_PLAGUEREGEXP);
		if ( playerName ) then
			if ( playerType == CT_RABOSS_DEFENDER_TYPE_YOU and playerName == CT_RABOSS_DEFENDER_YOU ) then
				playerName = UnitName("player");
				CT_RABoss_Announce(string.format(CT_RABOSS_DEFENDER_PLAGUEWARNING, CT_RABOSS_DEFENDER_YOUHAVE));
				CT_RABoss_Announce(string.format(CT_RABOSS_DEFENDER_PLAGUEWARNING, CT_RABOSS_DEFENDER_YOUHAVE));
				CT_RABoss_PlaySound(2);
			else
				if ( CT_RABoss_Mods["Anubisath Guardians"]["sendPlagueTells"] ) then
					SendChatMessage(CT_RABOSS_DEFENDER_PLAGUEWARNING_TELL, "WHISPER", nil, playerName);
				end
				CT_RABoss_PlaySound(1);
			end
			if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Anubisath Guardians"]["announce"] ) then
				CT_RA_AddMessage("MS " .. string.format(CT_RABOSS_DEFENDER_PLAGUEWARNING, playerName .. CT_RABOSS_DEFENDER_HAS));
			end
		end
	end
end
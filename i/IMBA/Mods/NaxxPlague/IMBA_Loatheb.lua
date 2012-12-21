IMBA_LOATHEB_DECURSE_STRING = "Loatheb casts Remove Curse on Loatheb."
IMBA_LOATHEB_SUMMON_SPORE_MSG	=	"Loatheb casts Summon Spore."
IMBA_LOATHEB_SPORE_DEATH_MSG	=	"Spore dies"
IMBA_LOATHEB_DEATH_MSG	= "Loatheb dies"
IMBA_LOATHEB_DOOM_MSG	=	"afflicted by Inevitable Doom."
IMBA_LOATHEB_DECURSE_ALERT = "** Loatheb has Decursed Himself **"
IMBA_Spores_Killed=0;

IMBA_Loatheb_Doom_Time	= 30;
IMBA_Loatheb_Doom_Time_First = 115;
IMBA_Loatheb_Doom_Time_Fast = 15;
IMBA_Loatheb_Normal_Dooms=7;

IMBA_Loatheb_Enrage_Time = 300-5;

IMBA_Silence_Time=30;
IMBA_Enrage_Time=60;

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_LOATHEB_DECURSE_STRING = "Horreb lance D\195\169livrance de la mal\195\169diction sur Horreb."
	IMBA_LOATHEB_SPORE_DEATH_MSG	= "Spore meurt."
	IMBA_LOATHEB_DEATH_MSG	= "Horreb meurt."
	IMBA_LOATHEB_DOOM_MSG	= "subit les effets de Mal\195\169diction in\195\169vitable."
	IMBA_LOATHEB_DECURSE_ALERT = "** Horreb s'est D\195\169curs\195\169 **"
end


function IMBA_Loatheb_UpdateBarNumbers()
	IMBA_Loatheb_SporeGroup:SetValText(math.mod(IMBA_Spores_Killed,8)+1);
end

function IMBA_Loatheb_InitNumbers()
	IMBA_Loatheb_Dooms=0;
	IMBA_Spores_Killed=0;
	SendAddonMessage("IMBA", "VARSYNC IMBA_Spores_Killed 0 REPLACE","RAID");
	IMBA_Loatheb_UpdateBarNumbers();
end


function IMBA_Loatheb_Start()
	IMBA_Loatheb_InitNumbers();
	IMBA_Loatheb_TimerDoom:StartTimer(IMBA_Loatheb_Doom_Time_First);
	IMBA_Loatheb_TimerEnrageDoom:StartTimer(IMBA_Loatheb_Enrage_Time);
end

function IMBA_Loatheb_RegenActivator()
	IMBA_Loatheb_Start()
	--SendAddonMessage("IMBA", "VARSYNC IMBA_Spores_Killed 0 REPLACE","RAID");
	IMBA_Loatheb:Show();
	IMBA_SporeLockout=0;	
end

function IMBA_Loatheb_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
end

function IMBA_Loatheb_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
end

function IMBA_Loatheb_CheckSporeAnnounce()
	if IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore==nil then
		IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore=false;
		return false;
	end
	return IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore;
end

function IMBA_Loatheb_ToggleSporeAnnounce()
	if IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore==nil then
		IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore=true;
		return;
	end
	if IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore then
		IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore=false
	else
		IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore=true;
	end
end

function IMBA_Loatheb_CheckDecurseAnnounce()
	if IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse==nil then
		IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse=false;
		return false;
	end
	return IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse;
end

function IMBA_Loatheb_ToggleDecurseAnnounce()
	if IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse==nil then
		IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse=true;
		return;
	end
	if IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse then
		IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse=false
	else
		IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse=true;
	end
end

function IMBA_Loatheb_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Loatheb_Title:SetText("Loatheb Status");

	IMBA_Loatheb_SporeGroup:SetBarText("Spore Group");
	IMBA_Loatheb_TimerDoom:SetBarText("Next Doom");
	IMBA_Loatheb_TimerEnrageDoom:SetBarText("Enraged Dooms in");

	IMBA_Loatheb_InitNumbers();
	

	
	IMBA_AddAddon("Loatheb", "Tracks Spore Group & Doom Timers", IMBA_LOCATIONS_NAXX_PLAGUE, "IMBA_Loatheb_RegenActivator", nil, nil, "IMBA_Loatheb");
	if (GetLocale()=="frFR") then
		IMBA_AddBossName("Loatheb","Horreb")
	end
	--IMBA_AddSyncVar("Loatheb","IMBA_Spores_Killed","MAX");
	IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore=false;
	IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse=false;
	IMBA_AddOption("Loatheb","Announce Spore Groups",IMBA_Loatheb_ToggleSporeAnnounce,IMBA_Loatheb_CheckSporeAnnounce)
	IMBA_AddOption("Loatheb","Announce Decurse",IMBA_Loatheb_ToggleDecurseAnnounce,IMBA_Loatheb_CheckDecurseAnnounce)
	IMBA_DoomTimer=0;
	IMBA_SporeLockout=0;
end

function IMBA_Loatheb_OnEvent(event)
	if ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
		if string.find(arg1,IMBA_LOATHEB_SPORE_DEATH_MSG) then
			IMBA_Spores_Killed=IMBA_Spores_Killed+1;
			IMBA_SporeLockout=GetTime()+14;
			IMBA_Loatheb_UpdateBarNumbers();
			IMBA_AddRaidAlert("** Spore Group "..(math.mod(IMBA_Spores_Killed,8)+1).." Go! **",IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore,IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore);
		elseif string.find(arg1,IMBA_LOATHEB_DEATH_MSG) then
			IMBA_Loatheb_TimerDoom.active=false;
			IMBA_Loatheb_TimerEnrageDoom.active=false;
		end
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) then
		if arg1 == IMBA_LOATHEB_DECURSE_STRING then
			IMBA_AddRaidAlert(IMBA_LOATHEB_DECURSE_ALERT,IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore,IMBA_SavedVariables.Mods["Loatheb"].AnnounceDecurse);
		elseif string.find(arg1,IMBA_LOATHEB_SUMMON_SPORE_MSG) and IMBA_SporeLockout<GetTime() then
			if IMBA_Spores_Killed~=0 then
				IMBA_Spores_Killed=IMBA_Spores_Killed+1;
				IMBA_Loatheb_UpdateBarNumbers();
			end
			IMBA_AddRaidAlert("** Spore Group "..(math.mod(IMBA_Spores_Killed,8)+1).." Go! **",IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore,IMBA_SavedVariables.Mods["Loatheb"].AnnounceSpore);
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") then
		if IMBA_DoomTimer<GetTime() and string.find(arg1,IMBA_LOATHEB_DOOM_MSG) then
			IMBA_DoomTimer=GetTime()+5;
			IMBA_Loatheb_Dooms=IMBA_Loatheb_Dooms+1;
			if IMBA_Loatheb_Dooms>7 then
				IMBA_Loatheb_TimerDoom:StartTimer(IMBA_Loatheb_Doom_Time_Fast)
			else
				IMBA_Loatheb_TimerDoom:StartTimer(IMBA_Loatheb_Doom_Time);
			end
		end
	end
end


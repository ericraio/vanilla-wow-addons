IMBA_SAPPHIRON_LIFEDRAIN_TIME	=	22;
IMBA_SAPPHIRON_LIFEDRAIN_MSG	=	"is afflicted by Life Drain."

IMBA_SAPPHIRON_ICEBOMB_TIME	=	7;
IMBA_SAPPHIRON_ICEBOMB_MSG	=	"Sapphiron begins to cast Frost Breath."


IMBA_SAPPHIRON_LANDING_MSG	=	"Icebolt fades from"
IMBA_SAPPHIRON_GROUND_TIME_INIT	=	35;
IMBA_SAPPHIRON_GROUND_TIME	=	70;
IMBA_SAPPHIRON_FLIGHT_TIME	=	30;

function IMBA_Sapphiron_StartLifeDrainTimer()
	IMBA_Sapphiron_TimerLifeDrain.timeLength=IMBA_SAPPHIRON_LIFEDRAIN_TIME;
	IMBA_Sapphiron_TimerLifeDrain.timeEnd=GetTime()+IMBA_SAPPHIRON_LIFEDRAIN_TIME;
	IMBA_Sapphiron_TimerLifeDrain.repeating=false;
	IMBA_Sapphiron_TimerLifeDrain.active=true;
end

function IMBA_Sapphiron_StartIceBombTimer()
	IMBA_Sapphiron_TimerIceBomb.timeLength=IMBA_SAPPHIRON_ICEBOMB_TIME;
	IMBA_Sapphiron_TimerIceBomb.timeEnd=GetTime()+IMBA_SAPPHIRON_ICEBOMB_TIME;
	IMBA_Sapphiron_TimerIceBomb.repeating=false;
	IMBA_Sapphiron_TimerIceBomb.active=true;
end

function IMBA_Sapphiron_Null()
	IMBA_RangeChecker_Active=false;
end

function IMBA_Sapphiron_StartFlightTimer()
	IMBA_RangeChecker_Active=true;
	IMBA_Sapphiron_TimerFlight:SetBarText("Time in Air");
	IMBA_Sapphiron_TimerFlight.timeLength=IMBA_SAPPHIRON_FLIGHT_TIME;
	IMBA_Sapphiron_TimerFlight.timeEnd=GetTime()+IMBA_SAPPHIRON_FLIGHT_TIME;
	IMBA_Sapphiron_TimerFlight.repeating=false;
	IMBA_Sapphiron_TimerFlight.active=true;
	IMBA_Sapphiron_TimerFlight.callback=IMBA_Sapphiron_Null;
end

function IMBA_Sapphiron_StartGroundTimerInit()
	IMBA_Sapphiron_TimerFlight:SetBarText("Time on Ground");
	IMBA_Sapphiron_TimerFlight.timeLength=IMBA_SAPPHIRON_GROUND_TIME_INIT;
	IMBA_Sapphiron_TimerFlight.timeEnd=GetTime()+IMBA_SAPPHIRON_GROUND_TIME_INIT;
	IMBA_Sapphiron_TimerFlight.repeating=false;
	IMBA_Sapphiron_TimerFlight.active=true;
	
	IMBA_Sapphiron_TimerFlight.callback=IMBA_Sapphiron_StartFlightTimer;
end

function IMBA_Sapphiron_StartGroundTimer()
	IMBA_Sapphiron_TimerFlight:SetBarText("Time on Ground");
	IMBA_Sapphiron_TimerFlight.timeLength=IMBA_SAPPHIRON_GROUND_TIME;
	IMBA_Sapphiron_TimerFlight.timeEnd=GetTime()+IMBA_SAPPHIRON_GROUND_TIME;
	IMBA_Sapphiron_TimerFlight.repeating=false;
	IMBA_Sapphiron_TimerFlight.active=true;
	IMBA_Sapphiron_TimerFlight.oldcallback=IMBA_Sapphiron_TimerFlight.callback;
	IMBA_Sapphiron_TimerFlight.callback=IMBA_Sapphiron_StartFlightTimer;
end

function IMBA_Sapphiron_Start()
	IMBA_Sapphiron_Blocks=1;
	IMBA_Minimap_ClearBossMarkers();
	IMBA_Sapphiron_StartGroundTimerInit();

	if IMBA_CheckVar("Sapphiron","ActivateRangeChecker") then
		IMBA_RangeChecker:Show();
	end
end

function IMBA_Sapphiron_RegenActivator()
	IMBA_Sapphiron_Start();
	IMBA_Sapphiron:Show();
end

function IMBA_Sapphiron_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
end

function IMBA_Sapphiron_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
end

function IMBA_Sapphiron_CheckBombAnnounce()
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb==nil then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb=false;
		return false;
	end
	return IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb;
end

function IMBA_Sapphiron_ToggleBombAnnounce()
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb==nil then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb=true;
		return;
	end
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb=false
	else
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb=true;
	end
end

function IMBA_Sapphiron_CheckLifeDrainAnnounce()
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain==nil then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain=false;
		return false;
	end
	return IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain;
end

function IMBA_Sapphiron_ToggleLifeDrainAnnounce()
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain==nil then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain=true;
		return;
	end
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain=false
	else
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain=true;
	end
end

function IMBA_Sapphiron_CheckAnnounceBlocks()
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks==nil then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks=false;
		return false;
	end
	return IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks;
end

function IMBA_Sapphiron_ToggleAnnounceBlocks()
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks==nil then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks=true;
		return;
	end
	if IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks then
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks=false
	else
		IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks=true;
	end
end


function IMBA_Sapphiron_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Sapphiron_Title:SetText("Sapphiron Timers");

	IMBA_Sapphiron_TimerLifeDrain:SetBarText("Life Drain");
	IMBA_Sapphiron_TimerIceBomb:SetBarText("Ice Bomb");
	IMBA_Sapphiron_TimerFlight:SetBarText("Time on Ground");

	IMBA_Sapphiron_DrainLockout=0;
	IMBA_Sapphiron_LandLockout=0;

	local playerClass, englishClass = UnitClass("player");

	if (englishClass=="DRUID") or (englishClass=="MAGE") then
		IMBA_Sapphiron_Decurser=true;
	else
		IMBA_Sapphiron_Decurser=false;
	end
	IMBA_AddAddon("Sapphiron", "Timers for Life Drain, Ice Bomb, Flight Time, and marks Ice Blocks on the Minimap", IMBA_LOCATIONS_NAXX_LAIR, "IMBA_Sapphiron_RegenActivator", nil,nil,"IMBA_Sapphiron");
	IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb=false;
	IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain=false;
	IMBA_SavedVariables.Mods["Sapphiron"].MarkBlocks=false;
	IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks=false;
	IMBA_AddOption("Sapphiron","Announce Bombs",IMBA_Sapphiron_ToggleBombAnnounce,IMBA_Sapphiron_CheckBombAnnounce)
	IMBA_AddOption("Sapphiron","Announce Life Drains",IMBA_Sapphiron_ToggleLifeDrainAnnounce,IMBA_Sapphiron_CheckLifeDrainAnnounce)
	IMBA_AddOption("Sapphiron","Announce Ice Blocks",IMBA_Sapphiron_ToggleAnnounceBlocks,IMBA_Sapphiron_CheckAnnounceBlocks)
	IMBA_AddOption2("Sapphiron","ActivateRangeChecker","Activate Range Checker");
	IMBA_Sapphiron_TimerFlight.oldcallback=IMBA_Sapphiron_TimerFlight.callback;
end


function IMBA_Sapphiron_OnEvent(event)
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		if string.find(arg1,IMBA_SAPPHIRON_ICEBOMB_MSG) then
			IMBA_RangeChecker_Active=false;
			IMBA_AddRaidAlert("** Ice Bomb Incoming! **",true,IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBomb);
			IMBA_Sapphiron_StartIceBombTimer();
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		if ( string.find(arg1,IMBA_SAPPHIRON_LIFEDRAIN_MSG) ) and ( IMBA_Sapphiron_DrainLockout < GetTime() ) then
			IMBA_Sapphiron_DrainLockout=GetTime()+5;
			
			if IMBA_Sapphiron_Decurser then
				IMBA_AddAlert("** Decurse Life Drains **");
			end

			IMBA_AddRaidAlert("** Decurse Life Drains **",false,IMBA_SavedVariables.Mods["Sapphiron"].AnnounceLifeDrain);
			IMBA_Sapphiron_StartLifeDrainTimer();
		else
			local iStart, iEnd, sPlayer, sType = string.find(arg1, "^([^%s]+) ([^%s]+) afflicted by Icebolt");
			if ( sPlayer and sType ) then
				IMBA_RangeChecker_Active=true;
				if ( sPlayer == "You" and sType == "are" ) then
					IMBA_Minimap_SetBossMarker();
					IMBA_AddRaidAlert("** Ice Block "..IMBA_Sapphiron_Blocks.." ("..UnitName("player")..") **",true,IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks);
				else
					IMBA_AddRaidAlert("** Ice Block "..IMBA_Sapphiron_Blocks.." ("..sPlayer..") **",true,IMBA_SavedVariables.Mods["Sapphiron"].AnnounceBlocks);
				end
				IMBA_Sapphiron_Blocks=IMBA_Sapphiron_Blocks+1;
			end
		end
	elseif ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" or event == "CHAT_MSG_SPELL_AURA_GONE_SELF") then
		if (string.find(arg1, IMBA_SAPPHIRON_LANDING_MSG) ) and ( IMBA_Sapphiron_LandLockout < GetTime() ) then
			IMBA_RangeChecker_Active=false;
			IMBA_Minimap_ClearBossMarkers();
			IMBA_Sapphiron_Blocks=1;
			IMBA_Sapphiron_LandLockout=GetTime()+5;
			IMBA_Sapphiron_StartGroundTimer();
		end
	end
end
IMBA_HAKKAR_YELL		=	"PRIDE HERALDS THE END OF YOUR WORLD.  COME, MORTALS!  FACE THE WRATH OF THE SOULFLAYER!"

IMBA_HAKKAR_MC_MSG		=	"(.+) (.+) afflicted by Cause Insanity."
IMBA_HAKKAR_MC_TIME		=	20;

IMBA_HAKKAR_BLOODSIPHON_MSG	=	"Hakkar gains Blood Siphon."
IMBA_HAKKAR_BLOODSIPHON_TIME	=	90;

IMBA_HAKKAR_ENRAGE_TIME		=	600;


function IMBA_Hakkar_YellActivator(msg)
	if string.find(msg,IMBA_HAKKAR_YELL) then
		IMBA_Hakkar_TimerEnrage:StartTimer(IMBA_HAKKAR_ENRAGE_TIME);
		IMBA_Hakkar:Show();
	end
end

function IMBA_Hakkar_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");

	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
end

function IMBA_Hakkar_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");

	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
end

function IMBA_Hakkar_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Hakkar_Title:SetText("Hakkar Timers");

	IMBA_Hakkar_TimerBloodSiphon:SetBarText("Blood Siphon");
	IMBA_Hakkar_TimerMindControl:SetBarText("Mind Control");
	IMBA_Hakkar_TimerEnrage:SetBarText("Enrage");
	IMBA_Hakkar_HealthHakkar.UnitName="Hakkar";

	
	IMBA_AddAddon("Hakkar", "Timers for Blood Siphon, Mind Control, and Enrage", IMBA_LOCATIONS_ZG, nil, "IMBA_Hakkar_YellActivator",IMBA_HAKKAR_YELL,"IMBA_Hakkar");
	IMBA_AddOption2("Hakkar","AnnounceBloodSiphon","Announce Blood Siphon");
	IMBA_AddOption2("Hakkar","AnnounceMindControl","Announce Mind Control");
end



function IMBA_Hakkar_OnEvent(event)
	if event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" then
		if string.find(arg1,IMBA_HAKKAR_BLOODSIPHON_MSG)  then
			IMBA_Hakkar_TimerBloodSiphon:StartTimer(IMBA_HAKKAR_BLOODSIPHON_TIME,false);
			IMBA_Hakkar_TimerBloodSiphon:StartWarningTimer("** Blood Siphon in ~15 Seconds **",15,IMBA_CheckVar("Hakkar","AnnounceBloodSiphon"),IMBA_CheckVar("Hakkar","AnnounceBloodSiphon"));
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE") then		
		local _, _, sPlayer, sType = string.find(arg1, IMBA_HAKKAR_MC_MSG);
		if ( sPlayer and sType ) then
			if ( sPlayer == "You" and sType == "are" ) then
				IMBA_AddRaidAlert("** "..UnitName("player").." is Mind Controlled **",IMBA_CheckVar("Hakkar","AnnounceMindControl"),IMBA_CheckVar("Hakkar","AnnounceMindControl"));
			else
				IMBA_AddRaidAlert("** "..sPlayer.." is Mind Controlled **",IMBA_CheckVar("Hakkar","AnnounceMindControl"),IMBA_CheckVar("Hakkar","AnnounceMindControl"));
			end
			IMBA_Hakkar_TimerMindControl:StartTimer(IMBA_HAKKAR_MC_TIME,false);
			return;
		end	
	end
end
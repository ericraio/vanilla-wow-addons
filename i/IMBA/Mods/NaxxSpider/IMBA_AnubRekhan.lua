IMBA_ANUB_YELL1				= "There is no way out.";
IMBA_ANUB_YELL2				= "Just a little taste...";
IMBA_ANUB_YELL3				= "Yes, run! It makes the blood pump faster!";

IMBA_ANUB_LOCUSTSWARM_CASTTIME	=	3;
IMBA_ANUB_LOCUSTSWARM_DURATION	=	20;
IMBA_ANUB_LOCUSTSWARM_COOLDOWN	=	80;

IMBA_ANUB_LOCUSTSWARM_CAST	=	"begins to cast Locust Swarm";
IMBA_ANUB_LOCUSTSWARM_START	=	"Anub'Rekhan gains Locust Swarm.";
IMBA_ANUB_LOCUSTSWARM_FADE	=	"Locust Swarm fades from Anub'Rekhan."


if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_ANUB_YELL1				= "Nulle part pour s'enfuir.";
	IMBA_ANUB_YELL2				= "Rien qu'une petite bouch\195\169e";
	IMBA_ANUB_YELL3				= "Oui, courez ! Faites circulez le sang !";

	IMBA_ANUB_LOCUSTSWARM_CAST	=	"commence \195\160 lancer Nu\195\169e de sauterelles.";
	IMBA_ANUB_LOCUSTSWARM_START	=	"Anub'Rekhan gagne Nu\195\169e de sauterelles.";
	IMBA_ANUB_LOCUSTSWARM_FADE	=	"Nu\195\169e de sauterelles sur Anub'Rekhan vient de se dissiper."
end

function IMBA_AnubRekhan_LocustSwarmCasting()
	IMBA_AnubRekhan_TimerLocustSwarmCast:SetBarText("Locust Swarm is Casting");
	IMBA_AnubRekhan_TimerLocustSwarmCast:StartTimer(IMBA_ANUB_LOCUSTSWARM_CASTTIME);
end

function IMBA_AnubRekhan_StartLocustSwarm()
	IMBA_AnubRekhan_TimerLocustSwarmCast:SetBarText("Locust Swarm");
	IMBA_AnubRekhan_TimerLocustSwarmCast:StartTimer(IMBA_ANUB_LOCUSTSWARM_DURATION);
end


function IMBA_AnubRekhan_YellActivator(arg1)
	if string.find(arg1,IMBA_ANUB_YELL1) or string.find(arg1,IMBA_ANUB_YELL2) or string.find(arg1,IMBA_ANUB_YELL3) then
		IMBA_AnubRekhan_TimerLocustSwarmCooldown:StartTimer(IMBA_ANUB_LOCUSTSWARM_COOLDOWN);
		IMBA_AnubRekhan_TimerLocustSwarmCooldown:StartWarningTimer("** Locust Swarm in ~5 Seconds **",5,IMBA_CheckVar("Anub'Rekhan","AnnounceLocust"),IMBA_CheckVar("Anub'Rekhan","AnnounceLocust"));
		IMBA_AnubRekhan:Show();
	end
end

function IMBA_AnubRekhan_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
end

function IMBA_AnubRekhan_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
end

function IMBA_AnubRekhan_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_AnubRekhan_Title:SetText("Anub'Rekhan Timers");

	IMBA_AnubRekhan_TimerLocustSwarmCast:SetBarText("Locust Swarm");
	IMBA_AnubRekhan_TimerLocustSwarmCooldown:SetBarText("Next Locust Swarm in");

	
	IMBA_AddAddon("Anub'Rekhan", "Timers for Locust Swarm", IMBA_LOCATIONS_NAXX_SPIDER, nil, "IMBA_AnubRekhan_YellActivator", IMBA_ANUB_YELL1,"IMBA_AnubRekhan");
	IMBA_AddOption2("Anub'Rekhan","AnnounceLocust","Announce Locust Swarms")
end



function IMBA_AnubRekhan_OnEvent(event)
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) or ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) or ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" ) then 
		if string.find(arg1, IMBA_ANUB_LOCUSTSWARM_CAST) then
			IMBA_AddRaidAlert("** Locust Swarm is Casting **",IMBA_CheckVar("Anub'Rekhan","AnnounceLocust"),IMBA_CheckVar("Anub'Rekhan","AnnounceLocust"));
			IMBA_AnubRekhan_LocustSwarmCasting();
		elseif string.find(arg1, IMBA_ANUB_LOCUSTSWARM_START) then
			IMBA_AnubRekhan_StartLocustSwarm();
			IMBA_AnubRekhan_TimerLocustSwarmCooldown:StartTimer(IMBA_ANUB_LOCUSTSWARM_COOLDOWN);
			IMBA_AnubRekhan_TimerLocustSwarmCooldown:StartWarningTimer("** Locust Swarm in ~5 Seconds **",5,IMBA_CheckVar("Anub'Rekhan","AnnounceLocust"),IMBA_CheckVar("Anub'Rekhan","AnnounceLocust"));
		elseif string.find(arg1,IMBA_ANUB_LOCUSTSWARM_FADE) then
			IMBA_AddRaidAlert("** Locust Swarm is Over **",IMBA_CheckVar("Anub'Rekhan","AnnounceLocust"),IMBA_CheckVar("Anub'Rekhan","AnnounceLocust"));
		end
	end
end
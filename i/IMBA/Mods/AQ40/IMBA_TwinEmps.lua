IMBA_TWINEMPS_TELEPORT_MSG		=	"casts Twin Teleport."
IMBA_TWINEMPS_TELEPORT_TIME		=	29;

IMBA_TWINEMPS_ARCANEBURST_MSG		=	"Emperor Vek'lor's Arcane Burst"
IMBA_TWINEMPS_ARCANEBURST_TIME		=	8;

IMBA_TWINEMPS_MUTATEBUG_MSG		=	"gains Mutate Bug."
IMBA_TWINEMPS_MUTATEBUG_TIME		=	10;

IMBA_TWINEMPS_UNBALANCING_MSG		=	"Emperor Vek'nilash's Unbalancing Strike"
IMBA_TWINEMPS_UNBALANCING_TIME		=	10

IMBA_TWINEMPS_EXPLODEBUG_MSG		=	"gains Explode Bug"

function IMBA_TwinEmps_RegenActivator()
	IMBA_TwinEmps:Show();
end

function IMBA_TwinEmps_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
end

function IMBA_TwinEmps_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
end

function IMBA_TwinEmps_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_TwinEmps_Title:SetText("Twin Emperor Timers");

	IMBA_TwinEmps_TimerArcaneBurst:SetBarText("Arcane Burst");
	IMBA_TwinEmps_TimerMutateBug:SetBarText("Mutate Bug");
	IMBA_TwinEmps_TimerUnbalancing:SetBarText("Unbalancing Strike");
	IMBA_TwinEmps_TimerTeleport:SetBarText("Teleport");

	
	IMBA_AddAddon("Twin Emperors", "Timers for Arcane Burst, Mutate Bug, Unbalancing Strike, and Teleport", IMBA_LOCATIONS_AQ40, "IMBA_TwinEmps_RegenActivator", nil,nil,"IMBA_TwinEmps");
	IMBA_AddBossName("Twin Emperors","Emperor Vek'lor");
	IMBA_AddBossName("Twin Emperors","Emperor Vek'nilash");
	IMBA_AddOption2("Twin Emperors","AlertExplosion","Alert for Exploding Bugs");
	IMBA_AddOption2("Twin Emperors","AnnounceTeleport","Announce Teleports");
end



function IMBA_TwinEmps_OnEvent(event)
	if string.find(event,"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
		if string.find(arg1,IMBA_TWINEMPS_EXPLODEBUG_MSG) then
			IMBA_AddRaidAlert("** A Bug is Exploding **",IMBA_CheckVar("Twin Emperors","AlertExplosion"),false);
		elseif string.find(arg1,IMBA_TWINEMPS_MUTATEBUG_MSG) then
			IMBA_TwinEmps_TimerMutateBug:StartTimer(IMBA_TWINEMPS_MUTATEBUG_TIME);
		end		
	elseif string.find(event,"CHAT_MSG_SPELL_CREATURE_VS") then
		if string.find(arg1,IMBA_TWINEMPS_TELEPORT_MSG)  then
			IMBA_TwinEmps_TimerTeleport:StartTimer(IMBA_TWINEMPS_TELEPORT_TIME);
			IMBA_TwinEmps_TimerTeleport:StartWarningTimer("** Twin Emps Teleporting in ~5 Seconds **",5,IMBA_CheckVar("Twin Emperors","AnnounceTeleport"),IMBA_CheckVar("Twin Emperors","AnnounceTeleport"));
		elseif string.find(arg1,IMBA_TWINEMPS_ARCANEBURST_MSG) then
			IMBA_TwinEmps_TimerArcaneBurst:StartTimer(IMBA_TWINEMPS_ARCANEBURST_TIME);
		elseif string.find(arg1,IMBA_TWINEMPS_UNBALANCING_MSG) then
			IMBA_TwinEmps_TimerUnbalancing:StartTimer(IMBA_TWINEMPS_UNBALANCING_TIME);
		end	
	end
end
IMBA_NOTH_AGGRO_YELL1	=	"Your life is forfeit!"
IMBA_NOTH_AGGRO_YELL2	=	"Glory to the master!"
IMBA_NOTH_AGGRO_YELL3	=	"Die, trespasser!"
IMBA_NOTH_DEATH_MSG	=	"I will serve the master... in death!"

IMBA_NOTH_BLINK_TIME	=	35
IMBA_NOTH_BLINK_MSG	=	"Noth the Plaguebringer gains Blink."

IMBA_NOTH_CURSE_TIME	=	50
IMBA_NOTH_CURSE_MSG	=	"is afflicted by Curse of the Plaguebringer."

IMBA_NOTH_GROUND_TIME	=	{90, 110, 180};
IMBA_NOTH_BALCONY_TIME	=	{70, 95, 120};

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_NOTH_AGGRO_YELL1	=	"Vos vies ne valent plus rien !"
	IMBA_NOTH_AGGRO_YELL2	=	"Gloire au ma\195\174tre !"
	IMBA_NOTH_AGGRO_YELL3	=	"Mourez, intrus !"
	IMBA_NOTH_DEATH_MSG	=	"Je servirais le ma\195\174tre... dans la mort!"


	IMBA_NOTH_BLINK_MSG	=	"Noth le Porte%-peste gagne Transfert."

	IMBA_NOTH_CURSE_MSG	=	"les effets de Mal\195\169diction de Porte%-peste."
end

function IMBA_Noth_StartGroundTimer()
	IMBA_Noth_TimerBalconyTime:SetBarText("Time on Ground");
	IMBA_Noth_TimerBalconyTime:StartTimer(IMBA_NOTH_GROUND_TIME[IMBA_Noth_Phase],false,IMBA_Noth_StartBalconyTimer)
end

function IMBA_Noth_StartBalconyTimer()
	IMBA_Noth_TimerBalconyTime:SetBarText("Time on Balcony");
	IMBA_Noth_TimerBalconyTime:StartTimer(IMBA_NOTH_BALCONY_TIME[IMBA_Noth_Phase],false,IMBA_Noth_StartGroundTimer)
	IMBA_Noth_Phase=IMBA_Noth_Phase+1;

	if(IMBA_Noth_Phase>3) then
		IMBA_Noth_Phase=3;
	end
end

function IMBA_Noth_Start()
	IMBA_Noth_TimerBlink:StartTimer(IMBA_NOTH_BLINK_TIME);
	IMBA_Noth_Phase=1;
	IMBA_Noth_StartGroundTimer();
end

function IMBA_Noth_YellActivator(arg1)
	if string.find(arg1,IMBA_NOTH_AGGRO_YELL1) then
		IMBA_Noth_Start();
		IMBA_Noth:Show();
		return true;
	elseif string.find(arg1,IMBA_NOTH_AGGRO_YELL2) then
		IMBA_Noth_Start();
		IMBA_Noth:Show();
		return true;
	elseif string.find(arg1,IMBA_NOTH_AGGRO_YELL3) then
		IMBA_Noth_Start();
		IMBA_Noth:Show();
		return true;
	end
	return false;
end

function IMBA_Noth_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
end

function IMBA_Noth_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
end

function IMBA_Noth_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Noth_Title:SetText("Noth Timers");

	IMBA_Noth_TimerBlink:SetBarText("Blink");
	IMBA_Noth_TimerCurse:SetBarText("Curse");
	IMBA_Noth_TimerBalconyTime:SetBarText("Time on Ground");

	IMBA_AddAddon("Noth the Plaguebringer", "Timers for Blink, Curse, and Ground/Balcony Time", IMBA_LOCATIONS_NAXX_PLAGUE, nil, "IMBA_Noth_YellActivator",IMBA_NOTH_AGGRO_YELL1,"IMBA_Noth");
end



function IMBA_Noth_OnEvent(event)
	if event == "CHAT_MSG_MONSTER_YELL" then 
		if arg1 == IMBA_NOTH_DEATH_MSG then
			IMBA_Noth_TimerBlink.active=false;
			IMBA_Noth_TimerCurse.active=false;
			IMBA_Noth_TimerBalconyTime.active=false;
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if arg1==IMBA_NOTH_BLINK_MSG then
			IMBA_Noth_TimerBlink:StartTimer(IMBA_NOTH_BLINK_TIME);
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		if string.find(arg1,IMBA_NOTH_CURSE_MSG)  then
			IMBA_Noth_TimerCurse:StartTimer(IMBA_NOTH_CURSE_TIME);
		end
	end
end
IMBA_Follower_Count=2;
IMBA_Worshipper_Count=4;

IMBA_Silence_Time=30;
IMBA_Enrage_Time=60;

IMBA_FAERLINA_AGGRO_YELL1	= "You cannot hide from me!";
IMBA_FAERLINA_AGGRO_YELL2	= "Run while you still can!";
IMBA_FAERLINA_AGGRO_YELL3	= "Kneel before me, worm!";
IMBA_FAERLINA_AGGRO_YELL4	= "Slay them in the master's name!";

IMBA_FAERLINA_ENRAGE_MSG	=	"Grand Widow Faerlina gains Enrage.";
IMBA_FAERLINA_SILENCE		=	"Grand Widow Faerlina is afflicted by Widow's Embrace";
IMBA_FAERLINA_SILENCE_FADE	=	"Widow's Embrace fades from Grand Widow Faerlina."

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_FAERLINA_AGGRO_YELL1	= "Vous ne pouvez pas m'\195\169chapper !";
	IMBA_FAERLINA_AGGRO_YELL2	= "Fuyez tant que vous le pouvez !";
	IMBA_FAERLINA_AGGRO_YELL3	= "genoux, vermisseau !";
	IMBA_FAERLINA_AGGRO_YELL4	= "Tuez%-les au nom du ma\195\174tre !";

	IMBA_FAERLINA_ENRAGE_MSG	=	"Grande veuve Faerlina gagne Enrager.";
	IMBA_FAERLINA_SILENCE		=	"Grande veuve Faerlina subit les effets de Etreinte de la veuve.";
	IMBA_FAERLINA_SILENCE_FADE	=	"Enrager sur Grande veuve Faerlina vient de se dissiper."
end

function IMBA_Faerlina_UpdateBarNumbers()
	IMBA_Faerlina_Follower:SetValText(IMBA_Follower_Count);
	IMBA_Faerlina_Worshipper:SetValText(IMBA_Worshipper_Count);
end

function IMBA_Faerlina_InitNumbers()
	IMBA_Follower_Count=2;
	IMBA_Worshipper_Count=4;
	IMBA_Faerlina_UpdateBarNumbers();

	SendAddonMessage("IMBA", "VARSYNC IMBA_Follower_Count 2 REPLACE","RAID");
	SendAddonMessage("IMBA", "VARSYNC IMBA_Worshipper_Count 4 REPLACE","RAID");
end


function IMBA_Faerlina_Start()
	IMBA_Faerlina_TimerSilence.timeEnd=0;
	IMBA_Faerlina_TimerSilence.timeLength=IMBA_Silence_Time;
	IMBA_Faerlina_TimerSilence.active=true;

	IMBA_Faerlina_InitNumbers();
	IMBA_Faerlina_TimerEnrage:StartTimer(IMBA_Enrage_Time)
	IMBA_Faerlina_TimerEnrage:StartWarningTimer("** Faerlina Enrages in ~5 Seconds **",5,IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"));
end

function IMBA_Faerlina_YellActivator(arg1)
	if IMBA_CheckIfRunning("Grand Widow Faerlina") then
		return false;
	end

	if string.find(arg1,IMBA_FAERLINA_AGGRO_YELL1) or string.find(arg1,IMBA_FAERLINA_AGGRO_YELL2) or string.find(arg1,IMBA_FAERLINA_AGGRO_YELL3) or string.find(arg1,IMBA_FAERLINA_AGGRO_YELL4) then	
		IMBA_Faerlina_Start()
		IMBA_Faerlina:Show();
		return true;
	end
	return false;
end

function IMBA_Faerlina_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DEBUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
end

function IMBA_Faerlina_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DEBUFF");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
end

function IMBA_Faerlina_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Faerlina_Title:SetText("Faerlina Status");

	IMBA_Faerlina_Follower:SetBarText("Followers");
	IMBA_Faerlina_Follower:SetValText("2");
	IMBA_Faerlina_Worshipper:SetBarText("Worshippers");
	IMBA_Faerlina_Worshipper:SetValText("4");

	IMBA_Faerlina_TimerSilence.timeLength=IMBA_Silence_Time;
	IMBA_Faerlina_TimerSilence.timeEnd=0;
	IMBA_Faerlina_TimerSilence.repeating=false;
	IMBA_Faerlina_TimerSilence.active=true;
	IMBA_Faerlina_TimerSilence:SetBarText("Silenced for");

	IMBA_Faerlina_TimerEnrage.timeLength=IMBA_Enrage_Time;
	IMBA_Faerlina_TimerEnrage.timeEnd=0;
	IMBA_Faerlina_TimerEnrage.repeating=false;
	IMBA_Faerlina_TimerEnrage.active=true;
	IMBA_Faerlina_TimerEnrage:SetBarText("Enraging in");


	IMBA_Faerlina_InitNumbers();
	
	
	IMBA_AddAddon("Grand Widow Faerlina", "Tracks Follower & Worshipper Counts and Silence & Enrage Timers", IMBA_LOCATIONS_NAXX_SPIDER, nil, "IMBA_Faerlina_YellActivator",IMBA_FAERLINA_AGGRO_YELL1, "IMBA_Faerlina");
	IMBA_AddSyncVar("Grand Widow Faerlina","IMBA_Follower_Count","MIN");
	IMBA_AddSyncVar("Grand Widow Faerlina","IMBA_Worshipper_Count","MIN");
	IMBA_AddOption2("Grand Widow Faerlina","AnnounceEnrage","Announce Enrages")
	IMBA_AddOption2("Grand Widow Faerlina","AnnounceSilence","Announce Silencing and Fading")
	Faerline_Silence=0;
end

function IMBA_Faerlina_OnEvent(event)
	if ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
		if ( arg1 == "Naxxramas Worshipper dies." ) then
			IMBA_Worshipper_Count=IMBA_Worshipper_Count-1;
			IMBA_Faerlina_UpdateBarNumbers();
		elseif ( arg1 == "Naxxramas Follower dies." ) then
			IMBA_Follower_Count=IMBA_Follower_Count-1;
			IMBA_Faerlina_UpdateBarNumbers();
		end
	elseif(event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DEBUFF") then
		
		if string.find(arg1,IMBA_FAERLINA_SILENCE) then
			if Faerline_Silence > GetTime() then
				return;
			end
			Faerline_Silence=GetTime()+5;
			IMBA_Faerlina_TimerSilence:StartTimer(IMBA_Silence_Time)
			IMBA_Faerlina_TimerSilence:StartWarningTimer("** Silence Wears Off in ~5 Seconds **",5,IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"));
			IMBA_AddRaidAlert("** Faerlina is Silenced **",IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"));

			if IMBA_Faerlina_TimerEnrage.timeEnd < (GetTime()+IMBA_Silence_Time) then
				IMBA_Faerlina_TimerEnrage:StartTimer(IMBA_Silence_Time+0.1) --Slightly offset so the message pops up after silence wearing off message
				IMBA_Faerlina_TimerEnrage:StartWarningTimer("** Faerlina Enrages in ~5 Seconds **",5,IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"));
			end
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") then

		if string.find(arg1,"Widow's Embrace") then
			if Faerline_Silence > GetTime() then
				return;
			end
			Faerline_Silence=GetTime()+5;
			IMBA_Faerlina_TimerSilence:StartTimer(IMBA_Silence_Time)
			IMBA_Faerlina_TimerSilence:StartWarningTimer("** Silence Wears Off in ~5 Seconds **",5,IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"));
			IMBA_AddRaidAlert("** Faerlina is Silenced **",IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"));

			if IMBA_Faerlina_TimerEnrage.timeEnd < (GetTime()+IMBA_Silence_Time) then
				IMBA_Faerlina_TimerEnrage:StartTimer(IMBA_Silence_Time+0.1) --Slightly offset so the message pops up after silence wearing off message
				IMBA_Faerlina_TimerEnrage:StartWarningTimer("** Faerlina Enrages in ~5 Seconds **",5,IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"));
			end
		end
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) or (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
		if string.find(arg1,IMBA_FAERLINA_ENRAGE_MSG) then
			IMBA_Faerlina_TimerEnrage:StartTimer(IMBA_Enrage_Time)
			IMBA_Faerlina_TimerEnrage:StartWarningTimer("** Faerlina Enrages in ~5 Seconds **",5,IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"));
			IMBA_AddRaidAlert("** Faerlina is Enraged! **",IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceEnrage"));
		end
	elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" ) then
		if string.find(arg1,IMBA_FAERLINA_SILENCE_FADE) then
			IMBA_AddRaidAlert("** Silence has Faded **",IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"),IMBA_CheckVar("Grand Widow Faerlina","AnnounceSilence"));
		end
	end
end
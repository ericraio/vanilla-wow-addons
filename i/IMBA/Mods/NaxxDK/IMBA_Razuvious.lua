IMBA_RAZUVIOUS_SHOUT_MSG	=	"Instructor Razuvious ?'s Disrupting Shout hits"
IMBA_RAZUVIOUS_SHOUT_TIME	=	25.5;

IMBA_RAZUVIOUS_AGGRO_YELL1	=	"Do as I taught you!";
IMBA_RAZUVIOUS_AGGRO_YELL2	=	"Show them no mercy!";
IMBA_RAZUVIOUS_AGGRO_YELL3	=	"Sweep the leg... Do you have a problem with that?";
IMBA_RAZUVIOUS_AGGRO_YELL4	=	"The time for practice is over! Show me what you have learned!";

IMBA_RAZUVIOUS_DEATH_YELL	=	"An honorable... death.";

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_RAZUVIOUS_SHOUT_MSG	=	"Instructeur Razuvious ?'s Cri perturbant et touche"  -- i think just Cri perturbant will work or maybe lance Cri pertubant, i don't know what means ?'s -- 

	IMBA_RAZUVIOUS_AGGRO_YELL1	=	"Faites ce que vous ai appris !";
	IMBA_RAZUVIOUS_AGGRO_YELL2	=	"Pas de quartier !";
	IMBA_RAZUVIOUS_AGGRO_YELL3	=	"Frappe%-le \195\160 la jambe";
	IMBA_RAZUVIOUS_AGGRO_YELL4	=	"Les cours sont termin\195\169s ! Montrez%-moi ce que vous avez appris !";

	IMBA_RAZUVIOUS_DEATH_YELL	=	"Une mort... honorable.";
end

IMBA_Razuvious_Shout_Lockout=0;
function IMBA_Razuvious_Shouted()
	if IMBA_Razuvious_Shout_Lockout<GetTime() then
		IMBA_AddRaidAlert("** Razuvious Shouted! **",IMBA_CheckVar("Instructor Razuvious","AnnounceShouts"),IMBA_CheckVar("Instructor Razuvious","AnnounceShouts"));
		IMBA_Razuvious_Shout_Lockout=GetTime()+5;
	end
end

function IMBA_Razuvious_YellActivator(arg1)
	if string.find(arg1,IMBA_RAZUVIOUS_AGGRO_YELL1) or string.find(arg1,IMBA_RAZUVIOUS_AGGRO_YELL2) or string.find(arg1,IMBA_RAZUVIOUS_AGGRO_YELL3) or string.find(arg1,IMBA_RAZUVIOUS_AGGRO_YELL4) then
		IMBA_Razuvious_TimerShout:StartTimer(IMBA_RAZUVIOUS_SHOUT_TIME,true,IMBA_Razuvious_Shouted);
		IMBA_Razuvious_TimerShout:StartWarningTimer("** Razuvious is shouting in ~5 Seconds **",5,IMBA_CheckVar("Instructor Razuvious","AnnounceShouts"),IMBA_CheckVar("Instructor Razuvious","AnnounceShouts"));
		IMBA_Razuvious:Show();
		return true;
	end
	return false;
end


function IMBA_Razuvious_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
end

function IMBA_Razuvious_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
end

function IMBA_Razuvious_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Razuvious_Title:SetText("Razuvious Timer");

	IMBA_Razuvious_TimerShout:SetBarText("Disrupting Shout");

	IMBA_AddAddon("Instructor Razuvious", "Timer for Disrupting Shout", IMBA_LOCATIONS_NAXX_DK, nil, "IMBA_Razuvious_YellActivator",IMBA_RAZUVIOUS_AGGRO_YELL1,"IMBA_Razuvious");
	IMBA_AddOption2("Instructor Razuvious","AnnounceShouts","Announce Shouts")
end



function IMBA_Razuvious_OnEvent(event)
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" ) then
		if string.find(arg1,IMBA_RAZUVIOUS_SHOUT_MSG) then
			IMBA_Razuvious_Shouted();
			IMBA_Razuvious_TimerShout:StartTimer(IMBA_RAZUVIOUS_SHOUT_TIME,true,IMBA_Razuvious_Shouted);
			IMBA_Razuvious_TimerShout:StartWarningTimer("** Razuvious is shouting in ~5 Seconds **",5,IMBA_CheckVar("Instructor Razuvious","AnnounceShouts"),IMBA_CheckVar("Instructor Razuvious","AnnounceShouts"));
		end
	elseif ( event == "CHAT_MSG_MONSTER_YELL") then
		if string.find(arg1,IMBA_RAZUVIOUS_DEATH_YELL) then
			IMBA_Razuvious_TimerShout.active=false;
		end
	end
end
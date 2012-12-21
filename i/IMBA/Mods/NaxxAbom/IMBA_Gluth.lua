IMBA_GLUTH_FRENZY_TIME	=	10;
IMBA_GLUTH_FEAR_TIME	=	20;
IMBA_GLUTH_DECIMATE_TIME	=	112;

IMBA_GLUTH_FRENZY_MSG		=	"%s goes into a frenzy!"
IMBA_GLUTH_DECIMATE_MSG		=	"Gluth ?'s Decimate hits"
IMBA_GLUTH_FEAR_MSG		=	"is afflicted by Terrifying Roar"
IMBA_GLUTH_FEAR_FAILS_MSG	=	"Gluth's Terrifying Roar fails."

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_GLUTH_FRENZY_MSG		=	"%s gagne Fr\195\169n\195\169sie."
	IMBA_GLUTH_DECIMATE_MSG		=	"Gluth ?'s lance D\195\169cimer et touche"
	IMBA_GLUTH_FEAR_MSG		=	"subit les effets de Rugissement terrifiant."
	IMBA_GLUTH_FEAR_FAILS_MSG	=	"Rugissement terrifiant de Gluth echoue."
end


function IMBA_Gluth_Start()
	IMBA_Gluth_TimerFrenzy:StartTimer(IMBA_GLUTH_FRENZY_TIME,false,nil,6)
	IMBA_Gluth_TimerFear:StartTimer(IMBA_GLUTH_FEAR_TIME,false,nil,6)
	IMBA_Gluth_TimerDecimate:StartTimer(IMBA_GLUTH_DECIMATE_TIME,false,nil,6)
end

function IMBA_Gluth_RegenActivator()
	IMBA_Gluth_Start();
	IMBA_Gluth:Show();
end

function IMBA_Gluth_RegisterEvents()
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
end

function IMBA_Gluth_UnregisterEvents()
	this:UnregisterEvent("PLAYER_REGEN_DISABLED");
	this:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
end

function IMBA_Gluth_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Gluth_Title:SetText("Gluth Timers");

	IMBA_Gluth_TimerFrenzy:SetBarText("Frenzy");
	IMBA_Gluth_TimerFear:SetBarText("Fear");
	IMBA_Gluth_TimerDecimate:SetBarText("Decimate");

	

	IMBA_Gluth_Check = false;
	IMBA_Gluth_TimerCheck = 0;
	IMBA_Gluth_LastFear = 0;

	IMBA_AddAddon("Gluth", "Timers for Frenzy, Fear, and Decimate", IMBA_LOCATIONS_NAXX_ABOM, "IMBA_Gluth_RegenActivator", nil,nil,"IMBA_Gluth");
end



function IMBA_Gluth_OnEvent(event)
	if event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == "Gluth" then 
		if arg1 == IMBA_GLUTH_FRENZY_MSG then
			IMBA_Gluth_TimerFrenzy:StartTimer(IMBA_GLUTH_FRENZY_TIME);
		end
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" ) then
		if string.find(arg1,IMBA_GLUTH_DECIMATE_MSG) then
			IMBA_Gluth_TimerDecimate:StartTimer(IMBA_GLUTH_DECIMATE_TIME);
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		if ( ( string.find(arg1,IMBA_GLUTH_FEAR_MSG) ) or ( string.find(arg1,IMBA_GLUTH_FEAR_FAILS_MSG) ) ) and ( (IMBA_Gluth_LastFear + 5) < GetTime() ) then
			IMBA_Gluth_LastFear=GetTime();
			IMBA_Gluth_TimerFear:StartTimer(IMBA_GLUTH_FEAR_TIME);
		end
	end
end
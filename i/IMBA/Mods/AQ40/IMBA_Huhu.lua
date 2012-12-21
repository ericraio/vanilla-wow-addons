IMBA_HUHU_NOXIOUSPOISON_MSG		=	"is afflicted by Noxious Poison."
IMBA_HUHU_NOXIOUSPOISON_TIME		=	10;

IMBA_HUHU_WYVERNSTING_MSG		=	"is afflicted by Wyvern Sting."
IMBA_HUHU_WYVERNSTING_TIME		=	25;

IMBA_HUHU_FRENZY_MSG			=	"goes into a frenzy!"
IMBA_HUHU_FRENZY_TIME			=	10

IMBA_HUHU_ENRAGE_MSG			=	"goes into a berserker rage!"

function IMBA_Huhu_RegenActivator()
	IMBA_Huhu:Show();
end

function IMBA_Huhu_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
end

function IMBA_Huhu_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE");
end

function IMBA_Huhu_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Huhu_Title:SetText("Huhuran Timers");

	IMBA_Huhu_TimerFrenzy:SetBarText("Frenzy");
	IMBA_Huhu_TimerNoxiousPoison:SetBarText("Noxious Poison");
	IMBA_Huhu_TimerWyvernSting:SetBarText("Wyvern Sting");

	
	IMBA_AddAddon("Princess Huhuran", "Timers for Frenzy, Noxious Poison, and Wyvern Sting", IMBA_LOCATIONS_AQ40, "IMBA_Huhu_RegenActivator", nil,nil,"IMBA_Huhu");
	IMBA_AddOption2("Princess Huhuran","AnnounceFrenzy","Announce Frenzy");
	IMBA_AddOption2("Princess Huhuran","AnnounceEnrage","Announce Enrage");
end



function IMBA_Huhu_OnEvent(event)
	if string.find(event,"CHAT_MSG_SPELL_PERIODIC") then
		if string.find(arg1,IMBA_HUHU_NOXIOUSPOISON_MSG)  then
			IMBA_Huhu_TimerNoxiousPoison:StartTimer(IMBA_HUHU_NOXIOUSPOISON_TIME,false);
		elseif string.find(arg1,IMBA_HUHU_WYVERNSTING_MSG) then
			IMBA_Huhu_TimerWyvernSting:StartTimer(IMBA_HUHU_WYVERNSTING_TIME,false);
		end
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		if string.find(arg1,IMBA_HUHU_ENRAGE_MSG) then
			IMBA_AddRaidAlert("** Princess Huhuran is Enraged **",IMBA_CheckVar("Princess Huhuran","AnnounceEnrage"),IMBA_CheckVar("Princess Huhuran","AnnounceEnrage"));
		elseif string.find(arg1,IMBA_HUHU_FRENZY_MSG) then
			IMBA_Huhu_TimerFrenzy:StartTimer(IMBA_HUHU_FRENZY_TIME);
			IMBA_AddRaidAlert("** Princess Huhuran is Frenzied! Tranq Shot **",IMBA_CheckVar("Princess Huhuran","AnnounceFrenzy"),IMBA_CheckVar("Princess Huhuran","AnnounceFrenzy"));
		end		
	end
end
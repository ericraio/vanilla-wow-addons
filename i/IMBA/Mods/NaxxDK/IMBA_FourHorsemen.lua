
IMBA_4H_MARK_INITIAL	=	20;
IMBA_4H_MARK_NORMAL	=	12;
IMBA_4H_MARK_DURATION	=	75;

IMBA_4H_METEOR_TIME	=	11;
IMBA_4H_METEOR_MSG	=	"Thane Korth'azz ?'s Meteor hits";

IMBA_4H_HOLY_WRATH_TIME	=	11;
IMBA_4H_HOLY_WRATH_MSG	=	"Sir Zeliek ?'s Holy Wrath hits";

IMBA_4H_VOID_ZONE_TIME	=	11;
IMBA_4H_VOID_ZONE_MSG	=	"Lady Blaumeux casts Void Zone.";
IMBA_4H_VOID_CONSUMPTION =	"Void Zone's Consumption hits you";


IMBA_Mark=1;
function IMBA_FourHorsemen_StartNormal()
	IMBA_FourHorsemen_TimerMark:StartTimer(IMBA_4H_MARK_NORMAL);
	IMBA_AddRaidAlert("** Mark "..IMBA_Mark.." **",false,IMBA_CheckVar("Four Horsemen","AnnounceMarks"));
	IMBA_Mark=IMBA_Mark+1;
	IMBA_FourHorsemen_TimerMark:SetBarText("Mark "..IMBA_Mark.." in");
end


function IMBA_FourHorsemen_StartInitial()
	IMBA_FourHorsemen_TimerMark:StartTimer(IMBA_4H_MARK_INITIAL);
	IMBA_Mark=1;
	IMBA_FourHorsemen_TimerMark:SetBarText("Mark "..IMBA_Mark.." in");
end


function IMBA_FourHorsemen_RegenActivator()
	IMBA_FourHorsemen_StartInitial()
	IMBA_FourHorsemen:Show();

	if IMBA_CheckVar("Four Horsemen","ActivateRangeChecker") then
		IMBA_RangeChecker:Show();
	end
end

function IMBA_FourHorsemen_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("PLAYER_DEAD");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	IMBA_RangeChecker_Active=true;
end

function IMBA_FourHorsemen_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:UnregisterEvent("PLAYER_DEAD");

	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	IMBA_RangeChecker_Active=false;
end

function IMBA_FourHorsemen_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_FourHorsemen_Title:SetText("Four Horsemen Timers");

	IMBA_FourHorsemen_TimerMeteor:SetBarText("Meteor");
	IMBA_FourHorsemen_TimerHolyWrath:SetBarText("Holy Wrath");
	IMBA_FourHorsemen_TimerVoidZone:SetBarText("Void Zone");
	IMBA_Mark=1;
	IMBA_FourHorsemen_TimerMark:SetBarText("Mark "..IMBA_Mark.." in");


	IMBA_AddAddon("Four Horsemen", "Timers for Meteor, Holy Wrath, Void Zones, and Mark", IMBA_LOCATIONS_NAXX_DK, "IMBA_FourHorsemen_RegenActivator", nil, nil,"IMBA_FourHorsemen");
	IMBA_AddBossName("Four Horsemen","Lady Blaumeux");
	IMBA_AddBossName("Four Horsemen","Thane Korth'azz");
	IMBA_AddBossName("Four Horsemen","Highlord Mograine");
	IMBA_AddBossName("Four Horsemen","Sir Zeliek");	
	
	IMBA_AddOption2("Four Horsemen","AnnounceMarks","Announce Marks")
	IMBA_AddOption2("Four Horsemen","ActivateRangeChecker","Activate Range Checker");
	IMBA_FourHorsemen_LockoutTime=0;
end

function IMBA_FourHorsemen_OnEvent(event)
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) or ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) or ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" ) or ( event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") then 
		if IMBA_FourHorsemen_LockoutTime>GetTime() then
			return;
		end
		if string.find(arg1, "is afflicted by Mark of Blaumeux") then
			IMBA_FourHorsemen_StartNormal();
			IMBA_FourHorsemen_LockoutTime=GetTime()+11;
		elseif string.find(arg1, "is afflicted by Mark of Korth'azz") then
			IMBA_FourHorsemen_StartNormal();
			IMBA_FourHorsemen_LockoutTime=GetTime()+11;
		elseif string.find(arg1, "is afflicted by Mark of Mograine") then
			IMBA_FourHorsemen_StartNormal();
			IMBA_FourHorsemen_LockoutTime=GetTime()+11;
		elseif string.find(arg1, "is afflicted by Mark of Zeliek") then
			IMBA_FourHorsemen_StartNormal();
			IMBA_FourHorsemen_LockoutTime=GetTime()+11;
		end
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") or ( event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE") or ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		if string.find(arg1,IMBA_4H_METEOR_MSG) then
			IMBA_FourHorsemen_TimerMeteor:StartTimer(IMBA_4H_METEOR_TIME)
		elseif string.find(arg1,IMBA_4H_HOLY_WRATH_MSG) then
			IMBA_FourHorsemen_TimerHolyWrath:StartTimer(IMBA_4H_HOLY_WRATH_TIME)
		elseif string.find(arg1,IMBA_4H_VOID_ZONE_MSG) then
			IMBA_FourHorsemen_TimerVoidZone:StartTimer(IMBA_4H_VOID_ZONE_TIME)
			IMBA_AddAlert("Blaumeux summons a Void Zone");
			IMBA_Flash_Warning();
		elseif string.find(arg1,IMBA_4H_VOID_CONSUMPTION) then
			IMBA_AddAlert("Standing in a Void Zone!");
			IMBA_Flash_Warning();
		end
	end
end
IMBA_THADDIUS_POWERSURGE_TIME	=	10;
IMBA_THADDIUS_POWERSURGECD_TIME	=	25;
IMBA_THADDIUS_POWERSURGE_MSG	=	"gains Power Surge"
IMBA_THADDIUS_THROW_TIME	=	20.75;
IMBA_THADDIUS1_YELL1		=	"Feed you to master!";
IMBA_THADDIUS1_YELL2		=	"Stalagg crush you!";

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_THADDIUS_POWERSURGE_MSG	=	"gains Power Surge"	--Still needs to be added
	IMBA_THADDIUS1_YELL1		=	"manger pour maitre !";
	IMBA_THADDIUS1_YELL2		=	"Stalagg \195\169craser toi !";
end

function IMBA_Thaddius1_YellActivator(arg1)
	if string.find(arg1,IMBA_THADDIUS1_YELL1) or string.find(arg1,IMBA_THADDIUS1_YELL2) then
		IMBA_Thaddius1_TimerThrow:StartTimer(IMBA_THADDIUS_THROW_TIME,true,nil,-0.5)
		IMBA_Thaddius1:Show();
		return true;
	end
	return false;
end

function IMBA_Thaddius1_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
end

function IMBA_Thaddius1_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:UnregisterEvent("CHAT_MSG_COMBAT_PARTY_HITS");
	this:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS");
	this:UnregisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
end

function IMBA_Thaddius1_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Thaddius1_Title:SetText("Thaddius - Phase 1");

	IMBA_Thaddius1_TimerPowerSurge:SetBarText("Power Surging");
	IMBA_Thaddius1_TimerPowerSurgeCD:SetBarText("Power Surge in");
	IMBA_Thaddius1_TimerThrow:SetBarText("Throw in");
	IMBA_Thaddius1_HealthFeugen.UnitName="Feugen";
	IMBA_Thaddius1_HealthStalagg.UnitName="Stalagg";	

	IMBA_Thaddius_FallTime=0;
	IMBA_AddAddon("Thaddius - Phase 1", "Timers for Power Surge and Throw with Health Monitors for Feugen and Stalagg", IMBA_LOCATIONS_NAXX_ABOM, nil, "IMBA_Thaddius1_YellActivator",IMBA_THADDIUS1_YELL1,"IMBA_Thaddius1");
end


function IMBA_Thaddius1_OnEvent(event)
	if event=="CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" then
		if string.find(arg1,IMBA_THADDIUS_POWERSURGE_MSG) then
			IMBA_Thaddius1_TimerPowerSurge:StartTimer(IMBA_THADDIUS_POWERSURGE_TIME)
			IMBA_Thaddius1_TimerPowerSurgeCD:StartTimer(IMBA_THADDIUS_POWERSURGECD_TIME)
		end
	elseif event=="CHAT_MSG_COMBAT_PARTY_HITS" or "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS" then
		if IMBA_Thaddius_FallTime<GetTime() and (string.find(arg1,"falls and loses") or string.find(arg1,"fall and lose")) then
			IMBA_Thaddius1_TimerThrow:StartTimer(IMBA_THADDIUS_THROW_TIME,true,nil,3.5)
			IMBA_Thaddius_FallTime=IMBA_Thaddius_FallTime+5;
		end
	elseif event=="CHAT_MSG_COMBAT_SELF_HITS" then		
		if IMBA_Thaddius_FallTime<GetTime() and string.find(arg1,"fall and lose") then
			IMBA_Thaddius1_TimerThrow:StartTimer(IMBA_THADDIUS_THROW_TIME,true,nil,3.5)
			IMBA_Thaddius_FallTime=IMBA_Thaddius_FallTime+5;
		end
	elseif event=="CHAT_MSG_MONSTER_YELL" then
		if string.find(arg1,IMBA_THADDIUS2_YELL1) or string.find(arg1,IMBA_THADDIUS2_YELL2) or string.find(arg1,IMBA_THADDIUS2_YELL3) then
			IMBA_Thaddius1:Hide()
		end
	end
end
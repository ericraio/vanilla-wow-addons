IMBA_Maexxna_Wrapped={};
IMBA_Maexxna_WrappedTexture = "Interface\\Icons\\Spell_Nature_Web";

IMBA_MAEXXNA_WEBWRAP_TIME	=	20
IMBA_MAEXXNA_SPIDERSPAWN_TIME	=	30
IMBA_MAEXXNA_WEBSPIN_TIME	=	40

IMBA_MAEXXNA_WEBWRAP_MSG = "^([^%s]+) ([^%s]+) afflicted by Web Wrap"
IMBA_MAEXXNA_WEBSRAY_MSG = "Maexxna ?'s Web Spray hits"
IMBA_MAEXXNA_ENRAGE = "Maexxna gains Enrage."

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_MAEXXNA_WEBWRAP_MSG = "^([^%s]+) ([^%s]+) les effets de Entoilage."
	IMBA_MAEXXNA_WEBSRAY_MSG = "les effets de Jet de rets"
	IMBA_MAEXXNA_ENRAGE = "Maexxna devient folle furieuse"
end

function IMBA_Maexxna_RegenActivator()
	IMBA_Maexxna_Wrapped={};
	IMBA_Maexxna_TimerWebWrap:StartTimer(IMBA_MAEXXNA_WEBWRAP_TIME,false,nil,6)
	IMBA_Maexxna_TimerSpiderSpawn:StartTimer(IMBA_MAEXXNA_SPIDERSPAWN_TIME,false,nil,6);
	IMBA_Maexxna_TimerSpiderSpawn:StartWarningTimer("** Spider Spawns in ~5 Seconds **",5,IMBA_CheckVar("Maexxna","AnnounceSpawns"),IMBA_CheckVar("Maexxna","AnnounceSpawns"));
	IMBA_Maexxna_TimerWebSpin:StartTimer(IMBA_MAEXXNA_WEBSPIN_TIME,false,nil,6);
	IMBA_Maexxna_TimerWebSpin:StartWarningTimer("** Web Spin in ~5 Seconds **",5,IMBA_CheckVar("Maexxna","AnnounceWebSpin"),IMBA_CheckVar("Maexxna","AnnounceWebSpin"));

	IMBA_Maexxna:Show();
end

function IMBA_Maexxna_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
end

function IMBA_Maexxna_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");

	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
end

function IMBA_Maexxna_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Maexxna_Title:SetText("Maexxna Timers");

	IMBA_Maexxna_WebWrapped:SetText("Web Wrapped");
	IMBA_Maexxna_TimerWebWrap:SetBarText("Web Wrap in");
	IMBA_Maexxna_TimerSpiderSpawn:SetBarText("Spiders Spawn in");
	IMBA_Maexxna_TimerWebSpin:SetBarText("Web Spray in");




	IMBA_AddAddon("Maexxna", "Timers for Web Wrap, Spider Spawns, and Web Spray and Unit Bars for those Wrapped", IMBA_LOCATIONS_NAXX_SPIDER, "IMBA_Maexxna_RegenActivator", nil, nil,"IMBA_Maexxna");
	IMBA_AddOption2("Maexxna","AnnounceSpawns","Warn for Spider Spawns")
	IMBA_AddOption2("Maexxna","AnnounceWebSpin","Warn for Web Spray")
	IMBA_AddOption2("Maexxna","AnnounceEnrage","Announce Enrage")
	IMBA_AddOption2("Maexxna","AnnounceWebWraps","Announce who is Web Wrapped")
	IMBA_MaexxnaDelay=0;
	IMBA_MaexxnaWrapCheckTime=0;
end

function IMBA_Maexxna_AddWrapped(name)
	IMBA_MaexxnaWrapCheckTime=GetTime()+5;
	tinsert(IMBA_Maexxna_Wrapped,IMBA_FindPlayerUnitByName(name));
end

function IMBA_Maexxna_OnUpdate()
	local numEntries = getn(IMBA_Maexxna_Wrapped), Wrapped,Removed;

	for i=1,3,1 do
		if i<=numEntries then
			getglobal("IMBA_Maexxna_WebWrap"..i).unit=IMBA_Maexxna_Wrapped[i];
		else
			getglobal("IMBA_Maexxna_WebWrap"..i).unit=nil;
		end
	end

	if (numEntries>0) and (IMBA_MaexxnaWrapCheckTime<GetTime()) then
		IMBA_MaexxnaWrapCheckTime=GetTime()+0.5;
		Removed=0;
		for i=1,numEntries,1 do
			Wrapped=false
			for a=1,16 do
				local t,c = UnitDebuff(IMBA_Maexxna_Wrapped[i-Removed],a);
				if(t == nil) then break; end;
				if(t == IMBA_Maexxna_WrappedTexture)
				then
					Wrapped=true;
					break;
				end
			end
			
			if (Wrapped==false) then
				tremove(IMBA_Maexxna_Wrapped,i-Removed);
				Removed=Removed+1;
			end		
		end
	end
end


function IMBA_Maexxna_OnEvent(event)
	if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") or (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") or (event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, IMBA_MAEXXNA_WEBWRAP_MSG);
		if ( sPlayer and sType ) then
			if ( sPlayer == "You" and sType == "are" ) or ( sPlayer == "Vous" and sType == "subissez" ) then
				IMBA_Maexxna_AddWrapped(UnitName("player"));
				IMBA_AddRaidAlert("** "..UnitName("player").." is Web Wrapped **",IMBA_CheckVar("Maexxna","AnnounceWebWraps"),IMBA_CheckVar("Maexxna","AnnounceWebWraps"));
			else
				IMBA_Maexxna_AddWrapped(sPlayer);
				IMBA_AddRaidAlert("** "..sPlayer.." is Web Wrapped **",IMBA_CheckVar("Maexxna","AnnounceWebWraps"),IMBA_CheckVar("Maexxna","AnnounceWebWraps"));
			end
		end

		if string.find(arg1,IMBA_MAEXXNA_WEBSRAY_MSG) and GetTime()>IMBA_MaexxnaDelay then
			IMBA_MaexxnaDelay=GetTime()+5.0;
			IMBA_Maexxna_TimerWebWrap:StartTimer(IMBA_MAEXXNA_WEBWRAP_TIME)
			IMBA_Maexxna_TimerSpiderSpawn:StartTimer(IMBA_MAEXXNA_SPIDERSPAWN_TIME);
			IMBA_Maexxna_TimerSpiderSpawn:StartWarningTimer("** Spider Spawns in ~5 Seconds **",5,IMBA_CheckVar("Maexxna","AnnounceSpawns"),IMBA_CheckVar("Maexxna","AnnounceSpawns"));
			IMBA_Maexxna_TimerWebSpin:StartTimer(IMBA_MAEXXNA_WEBSPIN_TIME);
			IMBA_Maexxna_TimerWebSpin:StartWarningTimer("** Web Spray in ~5 Seconds **",5,IMBA_CheckVar("Maexxna","AnnounceWebSpin"),IMBA_CheckVar("Maexxna","AnnounceWebSpin"));
			IMBA_Maexxna_Wrapped={};
		end
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) or (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
		if string.find(arg1,IMBA_MAEXXNA_ENRAGE) then
			IMBA_AddRaidAlert("** Maexxna is Enraged **",IMBA_CheckVar("Maexxna","AnnounceEnrage"),IMBA_CheckVar("Maexxna","AnnounceEnrage"));
		end
	end
end
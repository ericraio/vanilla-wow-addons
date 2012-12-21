local IMBA_HEIGAN_ERUPT_NORM	 = 10;
local IMBA_HEIGAN_ERUPT_PLAGUE = 2.75;
local IMBA_HEIGAN_PHASE_NORM	 = 90;
local IMBA_HEIGAN_PHASE_PLAGUE = 45;

local IMBA_HEIGAN_AGGRO_YELL1	= "You... are next.";
local IMBA_HEIGAN_AGGRO_YELL2	= "You are mine now.";
local IMBA_HEIGAN_AGGRO_YELL3	= "I see you...";
local IMBA_HEIGAN_PLAGUE_CLOUD	= "The end is upon you.";

local IMBA_Heigan_Resetting=false;

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	local IMBA_HEIGAN_AGGRO_YELL1	= "Tu es%.%.%. le suivant.";
	local IMBA_HEIGAN_AGGRO_YELL2	= "Vous \195\170tes \195\160 moi, maintenant.";
	local IMBA_HEIGAN_AGGRO_YELL3	= "Je vous vois%.%.%.";
	local IMBA_HEIGAN_PLAGUE_CLOUD	= "Votre fin est venue.";
end


function IMBA_Heigan_Reset()
	IMBA_Heigan_EruptNum=0;
	IMBA_Heigan_PlaguePhase=false;
	IMBA_Heigan_Resetting=true;
	IMBA_Heigan_UpdateImage();
	IMBA_Heigan_Resetting=false;
	IMBA_Heigan_TimerEruption.active=false
	IMBA_Heigan_TimerPlague.active=false;
	IMBA_Heigan_TimerPlague:SetBarText("Plague Cloud Start");
end

function IMBA_Heigan_UpdateImage()
	if IMBA_Heigan_EruptNum==IMBA_Heigan_Cycle_Num then
		return;
	end
	if IMBA_Heigan_NextErupt<GetTime() then
		IMBA_Heigan_NextErupt=GetTime()+1.5;

		if IMBA_Heigan_PlaguePhase then
			IMBA_Heigan_ImageSafe:SetTexture("Interface\\AddOns\\IMBA\\Mods\\NaxxPlague\\heigan\\perupt"..4-abs(IMBA_Heigan_Pos)..".blp");
		else
			IMBA_Heigan_ImageSafe:SetTexture("Interface\\AddOns\\IMBA\\Mods\\NaxxPlague\\heigan\\erupt"..4-abs(IMBA_Heigan_Pos)..".blp");
		end

		IMBA_Heigan_Pos=IMBA_Heigan_Pos+1;

		if IMBA_Heigan_Pos==3 then
			IMBA_Heigan_Pos=-3;
		end

		IMBA_Heigan_EruptNum=IMBA_Heigan_EruptNum+1;
		if IMBA_Heigan_EruptNum==IMBA_Heigan_Cycle_Num then
			IMBA_Heigan_TimerEruption.repeating=false;
		end
	end

	if (IMBA_AddonRunning==false) and (IMBA_Heigan_Resetting==false) then
		IMBA_Heigan_Reset();
	end
end

function IMBA_Heigan_UpdateErupt()
	if IMBA_Heigan_PlaguePhase then
		IMBA_Heigan_TimerEruption.timeLength=IMBA_HEIGAN_ERUPT_PLAGUE;
		IMBA_Heigan_TimerEruption.timeEnd=GetTime()+IMBA_HEIGAN_ERUPT_PLAGUE;
	else
		IMBA_Heigan_TimerEruption.timeLength=IMBA_HEIGAN_ERUPT_NORM;
		IMBA_Heigan_TimerEruption.timeEnd=GetTime()+IMBA_HEIGAN_ERUPT_NORM;
	end
	IMBA_Heigan_TimerEruption.repeating=true;
	IMBA_Heigan_TimerEruption.active=true;

	if IMBA_AddonRunning==false then
		IMBA_Heigan_Reset();
	end
end

function IMBA_Heigan_NullCallback()
	if IMBA_AddonRunning==false then
		IMBA_Heigan_Reset();
	end
end

function IMBA_Heigan_StartNormalTimer()
	IMBA_Heigan_EruptNum=0;
	IMBA_Heigan_PlaguePhase=false;
	IMBA_Heigan_Pos=-3;

	IMBA_Heigan_TimerPlague.timeLength=IMBA_HEIGAN_PHASE_NORM;
	IMBA_Heigan_TimerPlague.timeEnd=GetTime()+IMBA_HEIGAN_PHASE_NORM;
	IMBA_Heigan_TimerPlague.repeating=false;
	IMBA_Heigan_TimerPlague.active=true;

	IMBA_Heigan_TimerPlague.callback=IMBA_Heigan_NullCallback;
	IMBA_Heigan_TimerPlague:SetBarText("Plague Cloud Start");
	
	IMBA_Heigan_UpdateErupt();
	IMBA_Heigan_TimerEruption.timeEnd=GetTime()+10.1;
	IMBA_Heigan_UpdateImage();

	IMBA_Heigan_Cycle_Num=9;
end

function IMBA_Heigan_StartPlagueTimer()
	IMBA_Heigan_EruptNum=0;
	IMBA_Heigan_PlaguePhase=true;
	IMBA_Heigan_Pos=-3;

	IMBA_Heigan_TimerPlague.timeLength=IMBA_HEIGAN_PHASE_PLAGUE;
	IMBA_Heigan_TimerPlague.timeEnd=GetTime()+IMBA_HEIGAN_PHASE_PLAGUE+0.45;
	IMBA_Heigan_TimerPlague.repeating=false;
	IMBA_Heigan_TimerPlague.active=true;

	IMBA_Heigan_TimerPlague.callback=IMBA_Heigan_StartNormalTimer;
	IMBA_Heigan_TimerPlague:SetBarText("Plague Cloud End");

	IMBA_Heigan_UpdateErupt();
	IMBA_Heigan_UpdateImage();

	IMBA_Heigan_Cycle_Num=15;
end

function IMBA_Heigan_Start()
	IMBA_Heigan_StartNormalTimer();
	IMBA_Heigan_TimerEruption.timeEnd=GetTime()+16.3;
end


function IMBA_Heigan_YellActivator(arg1)
	if string.find(arg1,IMBA_HEIGAN_AGGRO_YELL1) then
		IMBA_Heigan_Start()
		IMBA_Heigan:Show();
		return true;
	elseif string.find(arg1,IMBA_HEIGAN_AGGRO_YELL2) then
		IMBA_Heigan_Start()
		IMBA_Heigan:Show();
		return true;
	elseif string.find(arg1,IMBA_HEIGAN_AGGRO_YELL3) then
		IMBA_Heigan_Start()
		IMBA_Heigan:Show();
		return true;
	end
	return false;
end

function IMBA_Heigan_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
end

function IMBA_Heigan_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
end

function IMBA_Heigan_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Heigan_Title:SetText("Heigan Timers");

	IMBA_Heigan_TimerEruption:SetBarText("Eruption");
	IMBA_Heigan_TimerPlague:SetBarText("Plague Cloud Start");
	IMBA_Heigan_TimerEruption.callback=IMBA_Heigan_UpdateImage;

	
	IMBA_Heigan_NextErupt=0;
	IMBA_Heigan_Pos=-3;
	IMBA_Heigan_PlaguePhase=false;
	IMBA_Heigan_ImageSafe:SetAlpha(0.75);


	IMBA_AddAddon("Heigan the Unclean", "Eruption Timer, Plague Cloud Timer, and Safe Zone Image", IMBA_LOCATIONS_NAXX_PLAGUE, nil, "IMBA_Heigan_YellActivator", IMBA_HEIGAN_AGGRO_YELL1, "IMBA_Heigan");
end

function IMBA_Heigan_OnEvent(event)
	if event == "CHAT_MSG_MONSTER_YELL" then 
		if string.find(arg1,IMBA_HEIGAN_PLAGUE_CLOUD) then
			IMBA_Heigan_StartPlagueTimer();
		end
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" ) then
		if string.find(arg1,"Plague Fissure ?'s Eruption") then
			IMBA_Heigan_UpdateImage();
			IMBA_Heigan_UpdateErupt();
		end
	end
end
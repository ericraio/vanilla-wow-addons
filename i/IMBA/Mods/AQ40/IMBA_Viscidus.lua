IMBA_Viscidus_GlobsLeft_Num =20
IMBA_Viscidus_GlobsLeft_Num2	=	20;
IMBA_Viscidus_GlobDie_Msg	=	"Glob of Viscidus dies"

IMBA_Viscidus_PoisonVolley_Msg	=	"Viscidus's Poison Bolt Volley hits"
IMBA_Viscidus_PoisonVolley_Time	=	10

IMBA_Viscidus_Frozen		=	false
IMBA_Viscidus_Frozen_Msg	=	"is frozen solid!"
IMBA_Viscidus_Frozen_Time	=	15

function IMBA_Viscidus_RegenActivator()	
	IMBA_Viscidus_GlobsLeft_Num = 20;
	IMBA_Viscidus_GlobsLeft_Num2 = 20;
	IMBA_Viscidus_GlobsLeft:SetValText(20);
	--SendAddonMessage("IMBA", "VARSYNC IMBA_Viscidus_GlobsLeft_Num 20 REPLACE","RAID");
	IMBA_Viscidus_ResetFrostHits()

	IMBA_Viscidus_TimerPoisonVolley:SetBarText("Poison Volley");
	IMBA_Viscidus_TimerPoisonVolley:StartTimer(IMBA_Viscidus_PoisonVolley_Time,false,nil,5)
	IMBA_Viscidus_TimerPoisonVolley.callback=nil;

	IMBA_Viscidus:Show();
end

function IMBA_Viscidus_ResetFrostHits()
	IMBA_Viscidus_Frozen=false;
	IMBA_Viscidus_CounterHits:SetBarText("Frost Hits Left");
	IMBA_Viscidus_CounterHits.maxNumber=200;
	IMBA_Viscidus_CounterHits:SetNum(200);
	IMBA_Viscidus_GlobsLeft_Num=IMBA_Viscidus_GlobsLeft_Num2;
end

function IMBA_Viscidus_ResetPhysicalHits()
	IMBA_Viscidus_Frozen=true;
	IMBA_Viscidus_CounterHits:SetBarText("Physical Hits Left");
	IMBA_Viscidus_CounterHits.maxNumber=150;
	IMBA_Viscidus_CounterHits:SetNum(150);
end

function IMBA_Viscidus_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");

	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");

	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");

end

function IMBA_Viscidus_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");

	this:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE");

	this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
end

function IMBA_Viscidus_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Viscidus_Title:SetText("Viscidus Status");

	IMBA_Viscidus_GlobsLeft:SetBarText("Globs Left");
	IMBA_Viscidus_GlobsLeft:SetValText(20);
	IMBA_Viscidus_TimerPoisonVolley:SetBarText("Poison Volley");
	IMBA_Viscidus_CounterHits:SetBarText("Frost Hits Left");

	
	IMBA_AddAddon("Viscidus", "Timer for Poison Bolt Volley, Shatter, and counting of Frost/Physical Hits", IMBA_LOCATIONS_AQ40, "IMBA_Viscidus_RegenActivator", nil,nil,"IMBA_Viscidus");
	IMBA_AddSyncVar("Viscidus","IMBA_Viscidus_GlobsLeft_Num","MIN");
end



function IMBA_Viscidus_OnEvent(event)
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE") then
		if string.find(arg1,IMBA_Viscidus_PoisonVolley_Msg)  then
			IMBA_Viscidus_TimerPoisonVolley:SetBarText("Poison Volley");
			IMBA_Viscidus_TimerPoisonVolley:StartTimer(IMBA_Viscidus_PoisonVolley_Time)
			IMBA_Viscidus_TimerPoisonVolley.callback=nil;
		end
	elseif event=="CHAT_MSG_MONSTER_EMOTE" then
		if string.find(arg1,IMBA_Viscidus_Frozen_Msg) then
			IMBA_Viscidus_TimerPoisonVolley:SetBarText("Thaws in");
			IMBA_Viscidus_TimerPoisonVolley:StartTimer(IMBA_Viscidus_Frozen_Time)
			IMBA_Viscidus_TimerPoisonVolley.callback=IMBA_Viscidus_ResetFrostHits;
			IMBA_Viscidus_ResetPhysicalHits();
		end
	elseif event=="CHAT_MSG_COMBAT_HOSTILE_DEATH" then
		if string.find(arg1,IMBA_Viscidus_GlobDie_Msg) then
			IMBA_Viscidus_GlobsLeft_Num2=IMBA_Viscidus_GlobsLeft_Num2-1;
			IMBA_Viscidus_GlobsLeft_Num=IMBA_Viscidus_GlobsLeft_Num2;
			IMBA_Viscidus_GlobsLeft:SetValText(IMBA_Viscidus_GlobsLeft_Num2);
			IMBA_Viscidus_ResetFrostHits()
		end
	else
		if string.find(arg1,"Viscidus") and (not string.find(arg1,"Glob of")) and (string.find(arg1,"hit") or string.find(arg1,"crit"))  then
			if (not IMBA_Viscidus_Frozen) and string.find(arg1, "Frost") then
				IMBA_Viscidus_CounterHits:Decrement();
			elseif IMBA_Viscidus_Frozen and not (string.find(arg1, "Arcane") or string.find(arg1, "Fire") or string.find(arg1, "Frost") or string.find(arg1, "Holy") or string.find(arg1, "Nature") or string.find(arg1, "Shadow")) then
				IMBA_Viscidus_CounterHits:Decrement();
			end
		end
	end
end
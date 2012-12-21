IMBA_KelThuzad_FrostBlasted={};
IMBA_KelThuzad_FrostBlastTexture="Spell_Frost_FreezingBreath"

IMBA_KelThuzad_ShadowFissure_Time	=	15
IMBA_KelThuzad_ShadowFissure_Msg	=	"Kel'Thuzad casts Shadow Fissure."

IMBA_KelThuzad_FrostboltVolley_Time	=	15
IMBA_KelThuzad_FrostboltVolley_Msg	=	"Kel'Thuzad ?'s Frostbolt hits ([^%s]+) for ([^%s]+) Frost damage."	--(2295-4140)

IMBA_KelThuzad_DetonateMana_Time	=	20
IMBA_KelThuzad_DetonateMana_Msg		=	"^([^%s]+) ([^%s]+) afflicted by Detonate Mana"

IMBA_KelThuzad_FrostBlast_Time		=	30
IMBA_KelThuzad_FrostBlast_Msg		=	"^([^%s]+) ([^%s]+) afflicted by Frost Blast."

IMBA_KelThuzad_Stage1_Yell		=	"Minions, servants, soldiers of the cold dark! Obey the call of Kel'Thuzad!"
IMBA_KelThuzad_Stage1_Time		=	315
IMBA_KelThuzad_Stage1_End_Yell1		=	"Pray for mercy!"
IMBA_KelThuzad_Stage1_End_Yell2		=	"Scream your dying breath!"
IMBA_KelThuzad_Stage1_End_Yell3		=	"The end is upon you!"
IMBA_KelThuzad_Stage1_End_Time		=	15

IMBA_KelThuzad_Stage3_Time		=	15
IMBA_KelThuzad_Stage3_Yell1		=	"Master, I require aid!"
IMBA_KelThuzad_Stage3_Yell2		=	"Very well. Warriors of the frozen wastes, rise up! I command you to fight, kill and die for your master! Let none survive!"

IMBA_KelThuzad_Chains_Msg		=	"^([^%s]+) ([^%s]+) afflicted by Chains of Kel'Thuzad."
IMBA_KelThuzad_Chains_Time		=	20
IMBA_KelThuzad_Chains_Time2		=	50


function IMBA_KelThuzad_FrostBlastWarning()
	IMBA_KelThuzad_TimerFrostBlast.active=false;
	IMBA_RangeChecker_Active=true;
	IMBA_AddRaidAlert("** Frost Blast Incoming! Spread Out! **",IMBA_CheckVar("Kel'Thuzad","AnnounceFrostBlast"),IMBA_CheckVar("Kel'Thuzad","AnnounceFrostBlast"));
end

function IMBA_KelThuzad_Stage1Start()
	IMBA_KelThuzad_TimerStage1:SetBarText("Stage 1 Ends in");
	IMBA_KelThuzad_TimerStage1:StartTimer(IMBA_KelThuzad_Stage1_Time,false);
end

function IMBA_KelThuzad_Stage1End()
	IMBA_KelThuzad_TimerStage1:SetBarText("Kel'Thuzad targetable in");
	IMBA_KelThuzad_TimerStage1:StartTimer(IMBA_KelThuzad_Stage1_End_Time,false);
	IMBA_RangeChecker_Active=true;
end

function IMBA_MindControlWarn()
	IMBA_AddRaidAlert("** Mind Control in the Next 30 Seconds **",IMBA_CheckVar("Kel'Thuzad","WarnMindControl"),IMBA_CheckVar("Kel'Thuzad","WarnMindControl"));
	IMBA_KelThuzad_TimerStage1.callback=IMBA_Null;
end

function IMBA_KelThuzad_ChainsNext()
	IMBA_KelThuzad_TimerStage1:SetBarText("Next Mind Control in");
	IMBA_KelThuzad_TimerStage1:StartTimer(IMBA_KelThuzad_Chains_Time2,false,IMBA_MindControlWarn);
end

function IMBA_KelThuzad_ChainsEnd()
	IMBA_KelThuzad_TimerStage1:SetBarText("Mind Control ends in");
	IMBA_KelThuzad_TimerStage1:StartTimer(IMBA_KelThuzad_Chains_Time2,false,IMBA_KelThuzad_ChainsNext);
end

function IMBA_KelThuzad_Stage3Start()
	IMBA_KelThuzad_TimerStage1:SetBarText("First Guardian in");
	IMBA_KelThuzad_TimerStage1:StartTimer(IMBA_KelThuzad_Stage3_Time,false);
end

function IMBA_KelThuzad_YellActivator(arg1)
	if string.find(arg1,IMBA_KelThuzad_Stage1_Yell) then
		IMBA_KelThuzad_Stage1Start();
		if IMBA_CheckVar("Kel'Thuzad","ActivateRangeChecker") then
			IMBA_RangeChecker:Show();
		end
		IMBA_KelThuzad:Show();
	end
end

function IMBA_KelThuzad_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");

	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");

	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");

	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
end

function IMBA_KelThuzad_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");

	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");

	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");

	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");

	this:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
end

function IMBA_KelThuzad_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_KelThuzad_Title:SetText("Kel'Thuzad Status");

	IMBA_KelThuzad_TimerFissure:SetBarText("Shadow Fissure in");
	IMBA_KelThuzad_TimerVolley:SetBarText("Frostbolt Volley in");
	IMBA_KelThuzad_TimerDetonateMana:SetBarText("Detonate Mana in");
	IMBA_KelThuzad_TimerFrostBlast:SetBarText("Frost Blast in");
	IMBA_KelThuzad_TimerStage1:SetBarText("Stage 1 Ends in");

	IMBA_KelThuzad_HealthKelThuzad.UnitName="Kel'Thuzad";

	IMBA_KelThuzad_TitleFrostBlasted:SetText("Frost Blasted Players");

	IMBA_KelThuzad_FrostBlastCheckTime=0;
	IMBA_KelThuzad_FrostBlast_Lockout=0;
	IMBA_KelThuzad_Frostbolt_Lockout=0;

	IMBA_AddAddon("Kel'Thuzad", "Timers for Shadow Fissure, Frostbolt, Detonate Mana, and Frost Blast", IMBA_LOCATIONS_NAXX_LAIR, nil, "IMBA_KelThuzad_YellActivator", IMBA_KelThuzad_Stage1_Yell,"IMBA_KelThuzad");
	IMBA_AddOption2("Kel'Thuzad","AnnounceShadow","Announce Shadow Fissure");
	IMBA_AddOption2("Kel'Thuzad","AnnounceDetonate","Announce Detonate Mana");
	IMBA_AddOption2("Kel'Thuzad","MarkDetonate","Marks Detonate Mana with Skull");
	IMBA_AddOption2("Kel'Thuzad","AnnounceMindControl","Announce Mind Controls");
	IMBA_AddOption2("Kel'Thuzad","WarnMindControl","Warn for Mind Controls");
	IMBA_AddOption2("Kel'Thuzad","AnnounceFrostBlast","Announce Frost Blasts");
	IMBA_AddOption2("Kel'Thuzad","AnnounceStage2","Announce Stage Transitions");
	IMBA_AddOption2("Kel'Thuzad","ActivateRangeChecker","Activate Range Checker");
	IMBA_KelThuzad_FrostBlastCheckTime=0;
end

function IMBA_KelThuzad_AddFrostBlasted(name)
	tinsert(IMBA_KelThuzad_FrostBlasted,{IMBA_FindPlayerUnitByName(name),0});
end

function IMBA_KelThuzad_Sort(v1,v2)
	if v1[2]==v2[2] then
		return v1[1]<v2[1];
	else
		return v1[2]<v2[2];
	end
end

function IMBA_KelThuzad_OnUpdate()
	local i, Blasted, Remove;
	local numEntries = getn(IMBA_KelThuzad_FrostBlasted);

	for k, v in IMBA_KelThuzad_FrostBlasted do
		v[2]=UnitHealth(v[1]);
	end

	table.sort(IMBA_KelThuzad_FrostBlasted, IMBA_KelThuzad_Sort);
	for i=1,3,1 do
		if i<=numEntries then
			getglobal("IMBA_KelThuzad_FrostBlast"..i).unit=IMBA_KelThuzad_FrostBlasted[i][1];
		else
			getglobal("IMBA_KelThuzad_FrostBlast"..i).unit=nil;
		end
	end

	if (numEntries>0) and (IMBA_KelThuzad_FrostBlastCheckTime<GetTime()) then
		IMBA_KelThuzad_FrostBlastCheckTime=GetTime()+0.5;
		Removed=0;
		for i=1,numEntries,1 do
			Blasted=false
			for a=1,16 do
				local t,c = UnitDebuff(IMBA_KelThuzad_FrostBlasted[i-Removed][1],a);
				if(t == nil) then break; end;
				if string.find(t,IMBA_KelThuzad_FrostBlastTexture) then
					Blasted=true;
					break;
				end
			end
			
			if (Blasted==false) then
				tremove(IMBA_KelThuzad_FrostBlasted,i-Removed);
				Removed=Removed+1;
			end		
		end
	end
end


function IMBA_KelThuzad_OnEvent(event)
	if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE") then
		
		local iStart, iEnd, sPlayer, sType = string.find(arg1, IMBA_KelThuzad_FrostBlast_Msg);
		if ( sPlayer and sType ) then
			if ( sPlayer == "You" and sType == "are" ) then
				IMBA_KelThuzad_AddFrostBlasted(UnitName("player"));
				IMBA_AddRaidAlert("** "..UnitName("player").." is Frost Blasted **",IMBA_CheckVar("Kel'Thuzad","AnnounceFrostBlast"),IMBA_CheckVar("Kel'Thuzad","AnnounceFrostBlast"));
			else
				IMBA_KelThuzad_AddFrostBlasted(sPlayer);
				IMBA_AddRaidAlert("** "..sPlayer.." is Frost Blasted **",IMBA_CheckVar("Kel'Thuzad","AnnounceFrostBlast"),IMBA_CheckVar("Kel'Thuzad","AnnounceFrostBlast"));
			end
			if GetRaidTargetIndex("player")~=8 then
				IMBA_RangeChecker_Active=false;
			end
			if IMBA_KelThuzad_FrostBlast_Lockout<GetTime() then
				IMBA_KelThuzad_FrostBlast_Lockout=GetTime()+5;
				IMBA_KelThuzad_TimerFrostBlast:StartTimer(IMBA_KelThuzad_FrostBlast_Time,false,IMBA_KelThuzad_FrostBlastWarning);
				IMBA_KelThuzad_TimerFrostBlast:StartWarningTimer("** Frost Blast Incoming in ~5 Seconds! **",5.1,IMBA_CheckVar("Kel'Thuzad","AnnounceFrostBlast"),IMBA_CheckVar("Kel'Thuzad","AnnounceFrostBlast"));
			end
			return;
		end

		iStart, iEnd, sPlayer, sType = string.find(arg1, IMBA_KelThuzad_DetonateMana_Msg);
		if ( sPlayer and sType ) then
			if ( sPlayer == "You" and sType == "are" ) then
				IMBA_RangeChecker_Active=true;
				IMBA_AddRaidAlert("** "..UnitName("player").."'s Mana is Detonating **",IMBA_CheckVar("Kel'Thuzad","AnnounceDetonate"),IMBA_CheckVar("Kel'Thuzad","AnnounceDetonate"));
				if IMBA_CheckVar("Kel'Thuzad","MarkDetonate") then
					SetRaidTarget("player",8);
				end

			else	
				if IsRaidLeader() or IsRaidOfficer() then
					SendChatMessage("YOUR MANA IS DETONATING!!!", "WHISPER", nil, sPlayer);
				end

				IMBA_AddRaidAlert("** "..sPlayer.."'s Mana is Detonating **",IMBA_CheckVar("Kel'Thuzad","AnnounceDetonate"),IMBA_CheckVar("Kel'Thuzad","AnnounceDetonate"));
				if IMBA_CheckVar("Kel'Thuzad","MarkDetonate") then
					local markUnit=IMBA_FindPlayerUnitByName(sPlayer)
					if UnitExists(markUnit) then
						SetRaidTarget(markUnit,8);
					end
				end
			end
			IMBA_KelThuzad_TimerDetonateMana:StartTimer(IMBA_KelThuzad_DetonateMana_Time,false);
			return;
		end
			
		iStart, iEnd, sPlayer, sType = string.find(arg1, IMBA_KelThuzad_Chains_Msg);
		if ( sPlayer and sType ) then
			if ( sPlayer == "You" and sType == "are" ) then
				IMBA_AddRaidAlert("** "..UnitName("player").." is Mind Controlled **",IMBA_CheckVar("Kel'Thuzad","AnnounceMindControl"),IMBA_CheckVar("Kel'Thuzad","AnnounceMindControl"));
			else
				IMBA_AddRaidAlert("** "..sPlayer.." is Mind Controlled **",IMBA_CheckVar("Kel'Thuzad","AnnounceMindControl"),IMBA_CheckVar("Kel'Thuzad","AnnounceMindControl"));
			end
			IMBA_KelThuzad_ChainsEnd();
			return;
		end	

	elseif  (event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		local iStart, iEnd, sPlayer, dDamage = string.find(arg1, IMBA_KelThuzad_FrostboltVolley_Msg);
		if sPlayer and dDamage then
			dDamage=tonumber(dDamage);
			if (IMBA_KelThuzad_Frostbolt_Lockout<GetTime()) and (dDamage>2290) and (dDamage<4145) then
				IMBA_KelThuzad_TimerVolley:StartTimer(IMBA_KelThuzad_FrostboltVolley_Time,false);
				IMBA_KelThuzad_Frostbolt_Lockout=GetTime()+7.5;
			end
			return;
		end

		if  arg1==IMBA_KelThuzad_ShadowFissure_Msg then
			IMBA_AddRaidAlert("** Shadow Fissure about to Explode **",IMBA_CheckVar("Kel'Thuzad","AnnounceShadow"),IMBA_CheckVar("Kel'Thuzad","AnnounceShadow"));
			IMBA_KelThuzad_TimerFissure:StartTimer(IMBA_KelThuzad_ShadowFissure_Time,false);
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") or (event == "CHAT_MSG_SPELL_AURA_GONE_SELF") or (event == "CHAT_MSG_SPELL_AURA_GONE_PARTY") then
		local 	iStart, iEnd, sPlayer = string.find(arg1, "Detonate Mana fades from ([^%s]+)[.]");
		if ( sPlayer ) then
			if ( sPlayer == "you" ) then
				if IMBA_KelThuzad_TimerFrostBlast.timeEnd>GetTime() then
					IMBA_RangeChecker_Active=false;
				end
				if IMBA_CheckVar("Kel'Thuzad","MarkDetonate") then
					SetRaidTarget("player",0);
				end
			else				
				if IMBA_CheckVar("Kel'Thuzad","MarkDetonate") then
					local markUnit=IMBA_FindPlayerUnitByName(sPlayer)

					if UnitExists(markUnit) then
						SetRaidTarget(markUnit,0);
					end
				end
			end
			return;
		end

		if string.find(arg1,"Frost Blast fades") then			
			IMBA_KelThuzad_FrostBlasted={};
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if string.find(arg1,IMBA_KelThuzad_Stage1_End_Yell1) or string.find(arg1,IMBA_KelThuzad_Stage1_End_Yell2) or string.find(arg1,IMBA_KelThuzad_Stage1_End_Yell3) then
			IMBA_AddRaidAlert("** Stage 1 About to End (Kel'Thuzad Targetable in 15 Seconds) **",IMBA_CheckVar("Kel'Thuzad","AnnounceStage2"),IMBA_CheckVar("Kel'Thuzad","AnnounceStage2"));
			IMBA_KelThuzad_Stage1End();
		elseif string.find(arg1,IMBA_KelThuzad_Stage3_Yell1) then
			IMBA_AddRaidAlert("** First Guardian in ~15 Seconds **",IMBA_CheckVar("Kel'Thuzad","AnnounceStage2"),IMBA_CheckVar("Kel'Thuzad","AnnounceStage2"));
			IMBA_KelThuzad_Stage3Start();
		elseif string.find(arg1,IMBA_KelThuzad_Stage3_Yell2) then
			IMBA_AddRaidAlert("** First Guardian in ~10 Seconds **",IMBA_CheckVar("Kel'Thuzad","AnnounceStage2"),IMBA_CheckVar("Kel'Thuzad","AnnounceStage2"));
		end
	end
end
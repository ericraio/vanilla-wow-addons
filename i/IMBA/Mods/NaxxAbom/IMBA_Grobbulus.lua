IMBA_GROBBULUS_SLIMESPRAY_MSG	=	"Grobbulus ?'s Slime Spray"
IMBA_GROBBULUS_SLIMESPRAY_TIME	=	30;

IMBA_GROBBULUS_POISONCLOUD_MSG	=	"Grobbulus casts Poison Cloud."
IMBA_GROBBULUS_POISONCLOUD_TIME	=	15;

IMBA_GROBBULUS_INJECTION_MSG	=	"^([^%s]+) ([^%s]+) afflicted by Mutating Injection"
IMBA_GROBBULUS_INJECTION_MSGR	=	"Mutating Injection fades from ([^%s]+)[.]"

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_GROBBULUS_POISONCLOUD_MSG	=	"Grobbulus lance Nuage de poison."

	IMBA_GROBBULUS_INJECTION_MSG	=	"^([^%s]+) ([^%s]+) les effets de Injection mutante."
	IMBA_GROBBULUS_INJECTION_MSGR	=	"Injection mutante sur ([^%s]+)[.] vient de se dissiper."
end

function IMBA_Grobbulus_RegenActivator()
	IMBA_Grobbulus:Show();
end

function IMBA_Grobbulus_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");

	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");

	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
end

function IMBA_Grobbulus_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");

	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");

	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");

	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
end

function IMBA_Grobbulus_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Grobbulus_Title:SetText("Grobbulus Timers");

	IMBA_Grobbulus_TimerPoisonCloud:SetBarText("Poison Cloud");
	IMBA_Grobbulus_TimerSlimeSpray:SetBarText("Slime Spray");

	
	IMBA_AddAddon("Grobbulus", "Timer for Poison Cloud, Slime Spray, and announce/marking of injection", IMBA_LOCATIONS_NAXX_ABOM, "IMBA_Grobbulus_RegenActivator", nil,nil,"IMBA_Grobbulus");
	IMBA_AddOption2("Grobbulus","AnnounceInjection","Announce Mutating Injection");
	IMBA_AddOption2("Grobbulus","MarkInjection","Mark Mutating Injectee");
end



function IMBA_Grobbulus_OnEvent(event)
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE") then
		if string.find(arg1,IMBA_GROBBULUS_SLIMESPRAY_MSG)  then
			IMBA_Grobbulus_TimerSlimeSpray:StartTimer(IMBA_GROBBULUS_SLIMESPRAY_TIME)
		end
	elseif event=="CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" then
		if string.find(arg1,IMBA_GROBBULUS_POISONCLOUD_MSG) then
			IMBA_Grobbulus_TimerPoisonCloud:StartTimer(IMBA_GROBBULUS_POISONCLOUD_TIME)
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") then
		local iStart, iEnd, sPlayer, sType = string.find(arg1, IMBA_GROBBULUS_INJECTION_MSG);
		if ( sPlayer and sType ) then
			if ( sPlayer == "You" and sType == "are" ) then
				IMBA_RangeChecker_Active=true;
				IMBA_AddRaidAlert("** "..UnitName("player").." is Injected **",IMBA_CheckVar("Grobbulus","AnnounceInjection"),true);
				if IMBA_CheckVar("Grobbulus","MarkInjection") then
					SetRaidTarget("player",8);
				end

			else	
				if IsRaidLeader() or IsRaidOfficer() then
					SendChatMessage("You've been injected!", "WHISPER", nil, sPlayer);
				end

				IMBA_AddRaidAlert("** "..sPlayer.." is Injected **",IMBA_CheckVar("Grobbulus","AnnounceInjection"),IMBA_CheckVar("Grobbulus","AnnounceInjection"));
				if IMBA_CheckVar("Grobbulus","MarkInjection") then
					local markUnit=IMBA_FindPlayerUnitByName(sPlayer)
					if UnitExists(markUnit) then
						SetRaidTarget(markUnit,8);
					end
				end
			end
			return;
		end
	elseif IMBA_CheckVar("Grobbulus","MarkInjection") and ((event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") or (event == "CHAT_MSG_SPELL_AURA_GONE_SELF") or (event == "CHAT_MSG_SPELL_AURA_GONE_PARTY")) then
		local 	iStart, iEnd, sPlayer = string.find(arg1, IMBA_GROBBULUS_INJECTION_MSGR);
		if ( sPlayer ) then
			if ( sPlayer == "you" ) then				
				SetRaidTarget("player",0);				
			else				
				local markUnit=IMBA_FindPlayerUnitByName(sPlayer)
				if UnitExists(markUnit) then
					SetRaidTarget(markUnit,0);
				end
			end
			return;
		end
	end
end
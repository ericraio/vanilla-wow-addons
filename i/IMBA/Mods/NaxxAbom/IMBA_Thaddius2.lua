IMBA_THADDIUS_POLARITY_TIME	=	30;
IMBA_THADDIUS_POLARITY_MSG	=	"Thaddius begins to cast Polarity Shift."
IMBA_THADDIUS_ENRAGE_TIME	=	300;
IMBA_THADDIUS2_YELL1		=	"Kill...";
IMBA_THADDIUS2_YELL2		=	"Eat... your... bones...";
IMBA_THADDIUS2_YELL3		=	"Break... you!!";
IMBA_THADDIUS2_DEATH		=	"Thank... you...";

IMBA_THADDIUS2_POSITIVECHARGE	=	"Spell_ChargePositive"
IMBA_THADDIUS2_NEGATIVECHARGE	=	"Spell_ChargeNegative"


if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_THADDIUS_POLARITY_MSG	=	"Thaddius commence \195\160 lancer Changement de polarit\195\169."
	IMBA_THADDIUS2_YELL1		=	"Tuer...";
	IMBA_THADDIUS2_YELL2		=	"Manger.. tes... os...";
	IMBA_THADDIUS2_YELL3		=	"Casser... toi !";
	IMBA_THADDIUS2_DEATH		=	"Mer...ci";
end

function IMBA_Thaddius2_Start()
	--Reduced range on combat logs to help performance
	IMBA_SetLogDistance(30);

	IMBA_Thaddius2_TimerEnrage:StartTimer(IMBA_THADDIUS_ENRAGE_TIME);
	IMBA_OldCharge=1;
end

function IMBA_Thaddius2_YellActivator(arg1)
	if arg1==IMBA_THADDIUS2_YELL1 then
		IMBA_Thaddius2_Start();
		IMBA_Thaddius1:Hide();
		IMBA_Thaddius2:Show();
		return true;
	elseif string.find(arg1,IMBA_THADDIUS2_YELL2) then
		IMBA_Thaddius2_Start();
		IMBA_Thaddius1:Hide();
		IMBA_Thaddius2:Show();
		return true;
	elseif string.find(arg1,IMBA_THADDIUS2_YELL3) then
		IMBA_Thaddius2_Start();
		IMBA_Thaddius1:Hide();
		IMBA_Thaddius2:Show();
		return true;
	end
	return false;
end

function IMBA_Thaddius2_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
end

function IMBA_Thaddius2_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
	IMBA_SetLogDistance(IMBA_SavedVariables.CombatLogDist);
end

function IMBA_Thaddius2_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Thaddius2_Title:SetText("Thaddius - Phase 2");

	IMBA_Thaddius2_TimerPolarity:SetBarText("Polarity Shift");
	IMBA_Thaddius2_TimerEnrage:SetBarText("Enrage in");
	IMBA_Thaddius2_HealthThaddius.UnitName="Thaddius";	

	IMBA_Thaddius2_PolarityCheckTime=0;
	IMBA_Thaddius2_PolarityCheckNum=0;
	IMBA_AddAddon("Thaddius - Phase 2", "Timers for Polarity Shift and Enrage, Health for Thaddius and Polarity Change Warning", IMBA_LOCATIONS_NAXX_ABOM, nil, "IMBA_Thaddius2_YellActivator",IMBA_THADDIUS2_YELL1,"IMBA_Thaddius2");
end

function IMBA_Thaddius2_CheckCharge()
	local i, d;
	local IMBA_Charge = 0;
	for i = 1, 16 do
		d = UnitDebuff("player",i);
		if(d == nil) then
			break; 
		elseif string.find(d, IMBA_THADDIUS2_POSITIVECHARGE) then
			IMBA_Charge = 1;
			break;
		elseif string.find(d, IMBA_THADDIUS2_NEGATIVECHARGE) then
			IMBA_Charge = -1;
			break;
		end
	end
		
	if ( IMBA_Charge ~= IMBA_OldCharge) then
		if ( IMBA_Charge == 1 ) then
			IMBA_AddAlert("*** Charge has changed to Positive! MOVE! ***");
		elseif ( IMBA_Charge == -1 ) then
			IMBA_AddAlert("*** Charge has changed to Negative! MOVE! ***");
		end
	end

	IMBA_OldCharge = IMBA_Charge;
end

function IMBA_Thaddius2_OnUpdate()
	if (IMBA_Thaddius2_PolarityCheckNum<10) and (IMBA_Thaddius2_PolarityCheckTime<GetTime()) then
		IMBA_Thaddius2_CheckCharge();
		IMBA_Thaddius2_PolarityCheckTime=IMBA_Thaddius2_PolarityCheckTime+0.5;
		IMBA_Thaddius2_PolarityCheckNum=IMBA_Thaddius2_PolarityCheckNum+1;
	end
end
function IMBA_Thaddius2_OnEvent(event)
	if event=="CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" then
		if arg1==IMBA_THADDIUS_POLARITY_MSG then
			IMBA_Thaddius2_TimerPolarity:StartTimer(IMBA_THADDIUS_POLARITY_TIME)
			IMBA_Thaddius2_PolarityCheckNum=0;
			IMBA_Thaddius2_PolarityCheckTime=GetTime()+4;
		end
	elseif event=="CHAT_MSG_MONSTER_YELL" then
		if string.find(arg1,IMBA_THADDIUS2_DEATH) then
			IMBA_Thaddius2_TimerEnrage.active=false;
			IMBA_Thaddius2_TimerPolarity.active=false;
			IMBA_SetLogDistance();
		elseif string.find(arg1,IMBA_THADDIUS1_YELL1) or string.find(arg1,IMBA_THADDIUS1_YELL2) then
			IMBA_Thaddius2:Hide()
		end
	end
end
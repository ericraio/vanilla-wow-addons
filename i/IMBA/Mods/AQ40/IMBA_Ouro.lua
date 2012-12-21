IMBA_OURO_SWEEP_MSG		=	"Ouro begins to cast Sweep."
IMBA_OURO_SWEEP_TIME		=	20;

IMBA_OURO_SANDBLAST_MSG		=	"Ouro begins to perform Sand Blast."
IMBA_OURO_SANDBLAST_TIME	=	20;

IMBA_OURO_SUBMERGE_MSG		=	"Ouro casts Summon Ouro Mounds."
IMBA_OURO_SUBMERGE_TIME		=	30

IMBA_OURO_EMERGE_MSG		=	"Dirt Mound casts Summon Ouro Scarabs."
IMBA_OURO_EMERGE_TIME		=	90

IMBA_OURO_ENRAGE_MSG		=	"goes into a berserker rage!"

function IMBA_Ouro_RegenActivator()
	IMBA_Ouro_TimerSubmerge:SetBarText("Ouro Submerging in");
	IMBA_Ouro_TimerSubmerge:StartTimer(IMBA_OURO_EMERGE_TIME,true,nil,5);
	IMBA_Ouro:Show();
	IMBA_Ouro_Enraged=false;
end

function IMBA_Ouro_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
end

function IMBA_Ouro_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
end

function IMBA_Ouro_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Ouro_Title:SetText("Ouro Timers");

	IMBA_Ouro_TimerSweep:SetBarText("Sweep");
	IMBA_Ouro_TimerSandBlast:SetBarText("Sand Blast");
	IMBA_Ouro_TimerSubmerge:SetBarText("Ouro Submerging in");
	IMBA_Ouro_HealthOuro.UnitName="Ouro";

	
	IMBA_AddAddon("Ouro", "Timers for Sweep, Sand Blasts, and Submerge/Emerge", IMBA_LOCATIONS_AQ40, "IMBA_Ouro_RegenActivator", nil,nil,"IMBA_Ouro");
	IMBA_AddOption2("Ouro","AnnounceSweep","Announce Sweep");
	IMBA_AddOption2("Ouro","AnnounceSandBlast","Announce Sand Blast");
	IMBA_AddOption2("Ouro","AnnounceSubmerge","Announce Submerge/Emerge");
	IMBA_AddOption2("Ouro","AnnounceEnrage","Announce Enrage");

	IMBA_Ouro_Enraged=false;
end



function IMBA_Ouro_OnEvent(event)
	if event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" then
		if string.find(arg1,IMBA_OURO_SWEEP_MSG)  then
			IMBA_Ouro_TimerSweep:StartTimer(IMBA_OURO_SWEEP_TIME,false);
			IMBA_AddRaidAlert("** Ouro is Sweeping **",IMBA_CheckVar("Ouro","AnnounceSweep"),IMBA_CheckVar("Ouro","AnnounceSweep"));
		elseif string.find(arg1,IMBA_OURO_SANDBLAST_MSG) then
			IMBA_Ouro_TimerSandBlast:StartTimer(IMBA_OURO_SWEEP_TIME,false);
			IMBA_Ouro_TimerSandBlast:StartWarningTimer("** Ouro is Sand Blastin in ~5 Seconds **",5,IMBA_CheckVar("Ouro","AnnounceSandBlast"),IMBA_CheckVar("Ouro","AnnounceSandBlast"));
			IMBA_AddRaidAlert("** Ouro is Sand Blasting **",IMBA_CheckVar("Ouro","AnnounceSandBlast"),IMBA_CheckVar("Ouro","AnnounceSandBlast"));
		end
	elseif event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" then
		if string.find(arg1,IMBA_OURO_SUBMERGE_MSG)  then
			IMBA_Ouro_TimerSubmerge:SetBarText("Ouro Emerging in");
			IMBA_Ouro_TimerSubmerge:StartTimer(IMBA_OURO_SUBMERGE_TIME,false);
			IMBA_Ouro_TimerSubmerge:StartWarningTimer("** Ouro is Emerging in 5 Seconds **",5,IMBA_CheckVar("Ouro","AnnounceSubmerge"),IMBA_CheckVar("Ouro","AnnounceSubmerge"));
			IMBA_AddRaidAlert("** Ouro is Submerging **",IMBA_CheckVar("Ouro","AnnounceSubmerge"),IMBA_CheckVar("Ouro","AnnounceSubmerge"));
		elseif string.find(arg1,IMBA_OURO_EMERGE_MSG) and IMBA_Ouro_Enraged==false then
			IMBA_Ouro_TimerSubmerge:SetBarText("Ouro Submerging in");
			IMBA_Ouro_TimerSubmerge:StartTimer(IMBA_OURO_EMERGE_TIME,true);			
			IMBA_AddRaidAlert("** Ouro is Emerging **",IMBA_CheckVar("Ouro","AnnounceSubmerge"),IMBA_CheckVar("Ouro","AnnounceSubmerge"));
		end
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		if string.find(arg1,IMBA_OURO_ENRAGE_MSG) then
			IMBA_AddRaidAlert("** Ouro is Enraged **",IMBA_CheckVar("Ouro","AnnounceEnrage"),IMBA_CheckVar("Ouro","AnnounceEnrage"));
			IMBA_Ouro_Enraged=true;
		end
	elseif (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
		if string.find(arg1,"Ouro dies") then
			IMBA_Ouro_TimerSweep.active=false;
			IMBA_Ouro_TimerSandBlast.active=false;
			IMBA_Ouro_TimerSubmerge.active=false;
			IMBA_Ouro:Hide();
		end		
	end
end
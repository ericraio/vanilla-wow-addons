
--[[

	CombatStats3 - Stat Damage Tracking
	AUTHOR:	DmgInc on most forums / Glacier on official WoW forums
	THANKS TO:	The dude(ette) who made DPSPlus for showing me the light on how to parse the combat log
				The dude(ette) who made Clock for the time conversion routines 

	Rev. 3.3	- ReEnabled the option to only show the stats on a mouseclick
	2.16.05		- DPS caluculated is now 15 seconds w/no option to change
				- Added end of fight stats option to turn on/off
				- Slash commands will save between sessions when not using w/cosmos
				
	Rev. 3.2	- Added end of fight statistics
	2.09.05		- Using PLAYER_REGEN_DISABLED ENABLED to tell when you
                  are in/out of combat for end of fight info

	Rev. 3.1	- Lots of fixes to track pet stats
	2.07.05	

	Rev. 3.0	- Initial version to track Defensive DPS	
	12.xx.04

	Rev 2.03 	- Now really really works w/o cosmos
	11.15.04
	
	Rev 2.02	- Now works w/o cosmos
	11.14.04	- Changed the text display frame
			- Fixed the crit % running out of the frame when it was 100%
			- Put "Default" attack at top of the list
			- Added in a "Total", put it at the bottom of the list
			- UI is now movalbe
			- UI will update itself while you are attacking if it is visible
			- Fixed a bug where the close "X" button couldn't be pressed
			- Now uses OnEvent and OnUpdate 
			- Pet damage is now tracked
			- DOT damage totals are correctly shown
			- Hopefully got rid of bogus entries
				

	Rev 2.01	- First release w/new UI
	11.05.04
	
  ]]

if ( CT_AddMovable ) then
	CT_AddMovable("CombatStatsFrame", "CombatStats", "TOPLEFT", "TOPLEFT", "UIParent", 150, 0, function(status) end);
end



--
--	Cosmos Cofig variables
--

CombatStats_Config = { };
CombatStats_Config.CombatStats_OnOff = 1;
CombatStats_Config.CombatStats_HideOnNoTarget = 0;
CombatStats_Config.CombatStats_EndOfFight = 0;
CombatStats_Config.CombatStats_UseMouseOver = 0;

CombatStats_LastUpdate = 0;
CombatStats_UpdateFreq = 0.1; 
CombatStats_DPSLen = 15;	-- Calculate DPS over the last 60 seconds
 
defcritCount = 0;
speccritCount= 0;

timestamps = {};
takenTimestamps = {};

players = {};
playersTaken = {};

dmg = {};
dmgTaken = {};

dpstotals = {};
dpsTakenTotals = {};

defCrits = {0};
specCrits = {0};

defCritTotals = {};
specCritTotals = {};

bInCombat = 0;
bHasDefault = 0;

totalDamage = 0;

--
--	Last fight info
--

lastFightStart		=	0;
lastFightFinish		=	 0;
lastFightPlayerDamage	=	0;
lastFightPetDamage	=	0;

mobDied				=	0;
regenEnabled		=	0;
leaveCombat		=	0;

overallCombatTime	=	0;

overallSwings		=	0;
overallMisses		=	0;
overallDodged		=	0;
overallParried		=	0;
overallEvaded		=	0;
overallBlocked		=	0;
overallResisted		=	0;
overallImmuned		=	0;
overallDeflected	=	0;
overallHits		=	0;
overallNonCrits		=	0;
overallCrits		=	0;
overallmaxCrit		=	0;
overallminCrit		=	0;
overallmaxReg		=	0;
overallminReg		=	0;
overallRegDmg		=	0;
overallCritDmg		=	0;
overallLastcrit		=	0;


attackNames = {};
specialAttacks = {};
specialAttackLog = {};

totalHits = 0;
totalCrits = 0;
specialsCount = 0;
combatTime = 1;

CombatStats_Old_TargetFrame_OnShow = nil;
CombatStats_Old_TargetFrame_OnHide = nil;

CombatStats_ChatCommandHandlers={};

bFirstTime = 1;

CombatStatsVars = { };
CombatStatsSessionVars = { };
DeathCount = 0;
DeathLog = { };
CombatStatsRecentVars = { };
CombatStatsByName = { };
CombatStatsSessionByName = { };
CombatStatsDisplay = { };

function CombatStats_ChatCommandHandler(msg)
	msg = string.lower(msg);
	local firsti, lasti, command, setStr = string.find (msg, "(%w+) ([%w%.]+)");
	if ((not command) and msg) then
		command = msg;
	end
	if (command) then
		for curCommand in CombatStats_ChatCommandHandlers do
			if (command == curCommand) then
				if (setStr) then
					CombatStats_ChatCommandHandlers[curCommand](setStr);
				else
					CombatStats_ChatCommandHandlers[curCommand]();
				end
				return;
			end
		end
	end
	Print("All slash command can start with either /cs or /combatstats example: /cs enable or /combatstats enable");
	Print("Then you can pass on or off to them, or pass a number for ones that need a number ex.");
	Print("/cs enable on");
	Print("/cs enable off");
	Print("");
	Print("enable [on | off] - 'Enable/disabwle CombatStats, on or off'");
	Print("target [on | off] - 'Only show DPS meter when you have a target'");
	Print("mouseover [on | off] - 'Show detailed window on mouseover'");
	Print("endoffight [on | off] - 'Show end of fight information'");
	Print("reset yes - 'Rest all stats to 0'");

end

--
--	Slash command handler
--

function CombatStats_Enable_ChatCommandHandler(msg)

	if (msg) then
		msg = string.upper(msg);
		-- Toggle appropriately
		if (string.find(msg, "ON")) then
			CombatStats_Config.CombatStats_OnOff = 1;
		elseif (string.find(msg, "OFF")) then
			CombatStats_Config.CombatStats_OnOff = 0;		
		end
	end
	
	if(Cosmos_RegisterConfiguration ~= nil) then
		Cosmos_UpdateValue("COMBATSTATS_CONFIG_ONOFF", CSM_CHECKONOFF, CombatStats_Config.CombatStats_OnOff);
	end

	CombatStats_UpdateVisibility();

end
CombatStats_ChatCommandHandlers["enable"] = CombatStats_Enable_ChatCommandHandler;

function CombatStats_Target_ChatCommandHandler(msg)

	if (msg) then
		msg = string.upper(msg);
		-- Toggle appropriately
		if (string.find(msg, "ON")) then
			CombatStats_Config.CombatStats_HideOnNoTarget = 1;
		elseif (string.find(msg, "OFF")) then
			CombatStats_Config.CombatStats_HideOnNoTarget = 0;		
		end
	end
	
	if(Cosmos_RegisterConfiguration ~= nil) then
		Cosmos_UpdateValue("COMBATSTATS_CONFIG_HIDEONNOTARGET", CSM_CHECKONOFF, CombatStats_Config.CombatStats_HideOnNoTarget);
	end

	CombatStats_UpdateVisibility();

end
CombatStats_ChatCommandHandlers["target"] = CombatStats_Target_ChatCommandHandler;

function CombatStats_Mouseover_ChatCommandHandler(msg)

	if (msg) then
		msg = string.upper(msg);
		-- Toggle appropriately
		if (string.find(msg, "ON")) then
			CombatStats_Config.CombatStats_UseMouseOver = 1;
		elseif (string.find(msg, "OFF")) then
			CombatStats_Config.CombatStats_UseMouseOver = 0;		
		end
	end
	
	if(Cosmos_RegisterConfiguration ~= nil) then
		Cosmos_UpdateValue("COMBATSTATS_CONFIG_USEMOUSEOVER", CSM_CHECKONOFF, CombatStats_Config.CombatStats_UseMouseOver);
	end

	CombatStats_UpdateVisibility();

end
CombatStats_ChatCommandHandlers["mouseover"] = CombatStats_Target_ChatCommandHandler;

function CombatStats_Endoffight_ChatCommandHandler(msg)

	if (msg) then
		msg = string.upper(msg);
		-- Toggle appropriately
		if (string.find(msg, "ON")) then
			CombatStats_Config.CombatStats_EndOfFight = 1;
		elseif (string.find(msg, "OFF")) then
			CombatStats_Config.CombatStats_EndOfFight = 0;		
		end
	end
	
	if(Cosmos_RegisterConfiguration ~= nil) then
		Cosmos_UpdateValue("COMBATSTATS_CONFIG_ENDOFFIGHT", CSM_CHECKONOFF, CombatStats_Config.CombatStats_EndOfFight);
	end

	CombatStats_UpdateVisibility();

end
CombatStats_ChatCommandHandlers["endoffight"] = CombatStats_Target_ChatCommandHandler;

function CombatStats_Reset_ChatCommandHandler(msg)

	if (msg) then
		msg = string.upper(msg);
		-- Toggle appropriately
		if (string.find(msg, "YES")) then
			CombatStats_Reset();
		end		
	end

end
CombatStats_ChatCommandHandlers["reset"] = CombatStats_Reset_ChatCommandHandler;

--
--	Cosmos Config Handlers
--

function CombatStats_HideOnNoTarget_OnOff(toggle)
	CombatStats_Config.CombatStats_HideOnNoTarget = toggle;
	CombatStats_UpdateVisibility();
end

function CombatStats_Watch_OnOff(toggle) 
	CombatStats_Config.CombatStats_OnOff = toggle;
	CombatStats_UpdateVisibility();	
end

function CombatStats_UseMouseOver_OnOff(toggle)
	CombatStats_Config.CombatStats_UseMouseOver = toggle;
	CombatStats_UpdateVisibility();
end

function CombatStats_EndOfFight_OnOff(toggle)
	CombatStats_Config.CombatStats_EndOfFight = toggle;
	CombatStats_UpdateVisibility();
end


function CombatStats_UpdateVisibility(hasTarget)
	if (not hasTarget) then
		if (TargetFrame:IsVisible()) then
			hasTarget = 1;
		else
			hasTarget = 0;
		end
	end
	if (CombatStats_Config.CombatStats_OnOff == 1) then
		if (CombatStats_Config.CombatStats_HideOnNoTarget == 1) then
			if (hasTarget == 1) then
				CombatStatsFrame:Show();
			else
				CombatStatsFrame:Hide();
			end
		else
			CombatStatsFrame:Show();
		end
		
		--
		--	Register the events to watch
		--
		
		
	else
		CombatStatsFrame:Hide();
	end
end

function CombatStats_Reset()

	defcritCount = 0;
	speccritCount= 0;
	timestamps = {};
	players = {};
	dmg = {};
	dpstotals = {};
	defCrits = {0};
	specCrits = {0};
	defCritTotals = {};
	specCritTotals = {};

	totalDamage = 0;

	attackNames = {};
	specialAttacks = {};
	specialAttackLog = {};

	totalHits = 0;
	totalCrits = 0;
	specialsCount = 0;
	bHasDefault = 0;
	
	overallSwings		=	0;
	overallMisses		=	0;
	overallDodged		=	0;
	overallParried		=	0;
	overallEvaded		=	0;
	overallBlocked		=	0;
	overallResisted		=	0;
	overallImmuned		=	0;
	overallDeflected	=	0;
	overallHits			=	0;
	overallNonCrits		=	0;
	overallCrits		=	0;
	overallmaxCrit		=	0;
	overallminCrit		=	0;
	overallmaxReg		=	0;
	overallminReg		=	0;
	overallRegDmg		=	0;
	overallCritDmg		=	0;
	overallLastcrit		=	0;
	
	CombatStatsText:SetText("Overall DPS :: ");
	
	CombatStatsGeneralNameTextLabel:SetText("N/A");
		
		CombatStatsNonCritHitsStatText:SetText("0");	
		CombatStatsNonCritDamageStatText:SetText("0");		
		CombatStatsNonCritMinMaxStatText:SetText("0 / 0");	
		CombatStatsNonCritAvgStatText:SetText("0.0");	
		CombatStatsNonCritPercentDamageStatText:SetText("0.0 %");	
	
		CombatStatsCritHitsStatText:SetText("0");
		CombatStatsCritDamageStatText:SetText("0");
		CombatStatsCritMinMaxStatText:SetText("0 / 0");
		CombatStatsCritAvgStatText:SetText("0.0");
		CombatStatsCritPercentDamageStatText:SetText("0.0 %");
	
		CombatStatsGeneralTotalHitsHits:SetText("0");	
		CombatStatsGeneralSwingsLabel:SetText("0");
			
		CombatStatsGeneralMissesTextLabel:SetText("0");	
		CombatStatsGeneralMissesPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralDodgesTextLabel:SetText("0");	
		CombatStatsGeneralDodgesPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralParriedTextLabel:SetText("0");	
		CombatStatsGeneralParriedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralBlockedTextLabel:SetText("0");	
		CombatStatsGeneralBlockedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralResistedTextLabel:SetText("0");	
		CombatStatsGeneralResistedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralImmunedTextLabel:SetText("0");	
		CombatStatsGeneralImmunedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralEvadedTextLabel:SetText("0");	
		CombatStatsGeneralEvadedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralPercentDmgPctLabel:SetText("0.0%");
		
		CombatStatsGeneralTimeLastCritTimeLabel:SetText(GREEN_FONT_COLOR_CODE.."N/A");
	
		CombatStatsOverallCritPctLabel:SetText(RED_FONT_COLOR_CODE.."0.0 %");		
		
		CombatStatsAttackNonCritPctLabel:SetText(GREEN_FONT_COLOR_CODE.."0.0 %");		
		CombatStatsAttackCritPctLabel:SetText(RED_FONT_COLOR_CODE.."0.0 %");
		
		UIDropDownMenu_SetText(CS_DROPDOWN_SELECT_TEXT,CombatStatsAttackDropDown);
				
	
end


function CombatStatDPSLen(checked,value)
	CombatStats_DPSLen = value;	
end

-- Register w/ Cosmos Config and set up a chat watch
function CombatStats_RegisterCosmos()
	if( (Cosmos_RegisterConfiguration ~= nil)) then
		Cosmos_RegisterConfiguration(
			"COS_COMBATSTATS",
			"SECTION",
			COMBATSTATS_CONFIG_HEADER,
			COMBATSTATS_CONFIG_HEADER_INFO
			);
		Cosmos_RegisterConfiguration(
			"COS_COMBATSTATS_HEADER",
			"SEPARATOR",
			COMBATSTATS_CONFIG_HEADER,
			COMBATSTATS_CONFIG_HEADER_INFO
			);
		Cosmos_RegisterConfiguration(
			"COS_COMBATSTATS_ONOFF", 
			"CHECKBOX",
			COMBATSTATS_CONFIG_ONOFF,
			COMBATSTATS_CONFIG_ONOFF_INFO,
			CombatStats_Watch_OnOff,
			CombatStats_Config.CombatStats_OnOff
			);		
		Cosmos_RegisterConfiguration(
			"COS_COMBATSTATS_USEMOUSEOVER_ONOFF", 
			"CHECKBOX",
			COMBATSTATS_CONFIG_USEMOUSEOVER,
			COMBATSTATS_CONFIG_USEMOUSEOVER_INFO,
			CombatStats_UseMouseOver_OnOff,
			CombatStats_Config.CombatStats_UseMouseOver,
			0
			);
		Cosmos_RegisterConfiguration(
			"COS_COMBATSTATS_HIDEONNOTARGET_ONOFF", 
			"CHECKBOX",
			COMBATSTATS_CONFIG_HIDEONNOTARGET,
			COMBATSTATS_CONFIG_HIDEONNOTARGET_INFO,
			CombatStats_HideOnNoTarget_OnOff,
			CombatStats_Config.CombatStats_HideOnNoTarget
			);	
		Cosmos_RegisterConfiguration(
			"COS_COMBATSTATS_ENDOFFIGHT_ONOFF", 
			"CHECKBOX",
			COMBATSTATS_CONFIG_ENDOFFIGHT,
			COMBATSTATS_CONFIG_ENDOFFIGHT_INFO,
			CombatStats_EndOfFight_OnOff,
			CombatStats_Config.CombatStats_EndOfFight
			);	

						
		Cosmos_RegisterChatCommand (
			"COMBATSTATS_COMMANDS",
			{"/cs", "/combatsats"},
			CombatStats_ChatCommandHandler,
			CS_CHAT_COMMAND_INFO
			);					
	end

end

function ShowLastFightDPS()

	--
	--	Show the last fight DPS
	--
	
	local totalFightTime
	local playerDPS
	local petDPS
	local petPct
	local playerText = "%.1f sec.\nTotal Damage :  %d\nOverall Fight DPS : %.1f\n";
	local petText = "Your pet did %d or %.1f%% of your overall damage.\nPet DPS : %.1f";
	local text = "Fight Statistics\nDuration : ";
	
	
	if( (bInCombat == 0) and (lastFightFinish > lastFightStart)) then
			
		totalFightTime = lastFightFinish - lastFightStart;
		petDPS = lastFightPetDamage / totalFightTime;
		playerDPS = lastFightPlayerDamage / totalFightTime;
		
		if(lastFightPetDamge ~=0) then
			petPct =  (lastFightPetDamage / lastFightPlayerDamage) * 100;
		end
		
		text = text ..format(playerText, totalFightTime,lastFightPlayerDamage,playerDPS);
		
		if(lastFightPetDamage ~= 0) then		
			text = text ..format(petText,lastFightPetDamage,petPct,petDPS);		
		end
				
		if(DEFAULT_CHAT_FRAME) then
			
			DEFAULT_CHAT_FRAME:AddMessage(text);
		
		end
			
	end
	
	
end

function CombatStats_OnEvent()

	--
	--	Don't do all this unless
	--	combat stats is turned on
	--
	
	if ( not CombatStats_Config.CombatStats_OnOff ) then
		return;
	end
	
			
	if (event == "PLAYER_REGEN_ENABLED") then
		regenEnabled = GetTime();
		if( (lastFightPlayerDamage > 0) and (bInCombat == 1) ) then
			lastFightFinish = GetTime();
			bInCombat = 0;					
			if(CombatStats_Config.CombatStats_EndOfFight  == 1) then
				ShowLastFightDPS();
			end
		end
		
	end

--	if (event == "PLAYER_LEAVE_COMBAT") then
--		leaveCombat = GetTime();
--		if( (lastFightPlayerDamage > 0) and (bInCombat == 1) ) then
--			lastFightFinish = GetTime();
--			bInCombat = 0;					
--			if(CombatStats_Config.CombatStats_EndOfFight  == 1) then
--				ShowLastFightDPS();
--			end
--		end
--	end
	
	if (event == "PLAYER_REGEN_DISABLED") then	
		if (bInCombat == 0) then
			lastFightStart = GetTime();
 		    	bInCombat = 1;			
			lastFightPlayerDamage = 0;
			lastFightPetDamage = 0;			
		end								
	end	
	
	local p, d;
	local curtime = combatTime;
	
	if(	event == "CHAT_MSG_COMBAT_SELF_HITS" 
		or event == "CHAT_MSG_COMBAT_SELF_MISSES"
		or event == "CHAT_MSG_SPELL_SELF_DAMAGE"
		or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		or event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
		) then			

		for creatureName, damage,damageType, spell in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from your (.+).") do
			CombatStats_AddSpecialData(spell,"dot",damage,curtime);			
			CombatStats_AddDPSEntry("Your", damage);			
			return;
		end
		
		for spell, creatureName, damage in string.gfind(arg1, "Your (.+) hits (.+) for (%d+).") do
			CombatStats_AddSpecialData(spell,"hit",damage,curtime);
			CombatStats_AddDPSEntry("Your", damage);
			return;
		end

		for creatureName, damage in string.gfind(arg1, "You hit (.+) for (%d+)") do
			CombatStats_AddSpecialData("Default","hit",damage,curtime);
			CombatStats_AddDPSEntry("Your", damage);
			return;
		end
		for spell, creatureName, damage in string.gfind(arg1, "Your (.+) crits (.+) for (%d+).") do
			CombatStats_AddSpecialData(spell,"crit",damage,curtime);
			CombatStats_AddDPSEntry("Your", damage);
			return;
		end
		for creatureName, damage in string.gfind(arg1, "You crit (.+) for (%d+)") do
			CombatStats_AddSpecialData("Default","crit",damage,curtime);
			CombatStats_AddDPSEntry("Your", damage);
			return;
		end
		for creatureName in string.gfind(arg1, "You miss (.+).") do
			CombatStats_AddSpecialData("Default","miss",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "You attack. (.+) parries.") do
			CombatStats_AddSpecialData("Default","parry",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "You attack. (.+) evades.") do
			CombatStats_AddSpecialData("Default","evade",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "You attack. (.+) dodges.") do
			CombatStats_AddSpecialData("Default","dodge",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "You attack. (.+) deflects.") do
			CombatStats_AddSpecialData("Default","deflect",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "You attack. (.+) blocks.") do
			CombatStats_AddSpecialData("Default","block",0,curtime);
			return;
		end
		for spell, creatureName in string.gfind(arg1, "Your (.+) was blocked by (.+).") do
			CombatStats_AddSpecialData(spell,"block",0,curtime);
			return;
		end
		for spell, creatureName in string.gfind(arg1, "Your (.+) was deflected by (.+).") do
			CombatStats_AddSpecialData(spell,"deflect",0,curtime);
			return;
		end
		for spell, creatureName in string.gfind(arg1, "Your (.+) was dodged by (.+).") do
			CombatStats_AddSpecialData(spell,"dodge",0,curtime);
			return;
		end
		for spell, creatureName in string.gfind(arg1, "Your (.+) was evaded by (.+).") do
			CombatStats_AddSpecialData(spell,"evade",0,curtime);
			return;
		end
		for spell, creatureName in string.gfind(arg1, "Your (.+) is parried by (.+)") do
			CombatStats_AddSpecialData(spell,"parry",0,curtime);
			return;
		end
		for spell, creatureName in string.gfind(arg1, "Your (.+) was resisted by (.+).") do
			CombatStats_AddSpecialData(spell,"resist",0,curtime);
			return;
		end
		for spell, creatureName in string.gfind(arg1, "Your (.+) failed. (.+) is immune.") do
			CombatStats_AddSpecialData(spell,"immune",0,curtime);
			return;
		end
		for spell, creatureName in string.gfind(arg1, "Your (.+) missed (.+).") do
			CombatStats_AddSpecialData(spell,"miss",0,curtime);
			return;
		end
		
	end
	
	if(	event == "CHAT_MSG_COMBAT_PET_HITS" ) then
		
		bInCombat = 1;
		
		for petName, creatureName, damage in string.gfind(arg1, "(.+) crits (.+) for (%d+).") do
			CombatStats_AddSpecialData("[Pet] Default","crit",damage,curtime);
			CombatStats_AddDPSEntry("Your", damage);
			return;
		end
		
		for petName, creatureName, damage in string.gfind(arg1, "(.+) hits (.+) for (%d+).") do
			CombatStats_AddSpecialData("[Pet] Default","hit",damage,curtime);
			CombatStats_AddDPSEntry("Your", damage);
			return;
		end
	end

	if (event == "CHAT_MSG_SPELL_PET_DAMAGE") then

		for petName, spell, creatureName, damage in string.gfind(arg1, "(.+)'s (.+) hits (.+) for (%d+).") do			
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"hit",damage,curtime);
				CombatStats_AddDPSEntry("Your", damage);
			end
			return;
		end
		
		for petName, spell, creatureName, damage in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (%d+).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"crit",damage,curtime);
				CombatStats_AddDPSEntry("Your", damage);
			end
			return;
		end
		
		for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) was blocked by (.*).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"block",0,curtime);				
			end
			return;
		end
		
		for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) was dodged by (.*).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"dodge",0,curtime);				
			end			
			return;
		end
  
        for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) was evaded by (.*).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"evade",0,curtime);				
			end			
			return;
		end

       for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) fails. (.+) is immune.") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"immune",0,curtime);				
			end						
			return;
		end
	
		for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) was resisted by (.*).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"resist",0,curtime);				
			end						
			return;
		end

        for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) misses (.*).") do
     		if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"miss",0,curtime);				
			end						
			return;
		end
		
		for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) missed (.*).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"miss",0,curtime);				
			end						
			return;
		end
		
		for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) failed. (.+) is immune.") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"immune",0,curtime);
			end
			return;
		end
		for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) missed (.+).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"miss",0,curtime);
			end
			return;
		end
		for petName, spell, creatureName in string.gfind(arg1, "(.+)'s (.+) was deflected by (.+).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] "..spell,"deflect",0,curtime);
			end
			return;
		end	
		
	end
	
	if (event == "CHAT_MSG_COMBAT_PET_MISSES") then

		bInCombat = 1;	
	
		for petName, creatureName in string.gfind(arg1, "(.+) misses (.*).") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] Default","miss",0,curtime);
			end	
			return;
		end
		
		for petName, creatureName in string.gfind(arg1, "(.+) attacks. (.+) parries.") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] Default","parry",0,curtime);
			end
			return;
		end
		for petName, creatureName in string.gfind(arg1, "(.+) attacks. (.+) evades.") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] Default","evade",0,curtime);
			end
			return;
		end
		for petName, creatureName in string.gfind(arg1, "(.+) attacks. (.+) dodges.") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] Default","dodge",0,curtime);
			end
			return;
		end
		for petName, creatureName in string.gfind(arg1, "(.+) attacks. (.+) deflects.") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] Default","deflect",0,curtime);
			end
			return;
		end
		for petName, creatureName in string.gfind(arg1, "(.+) attacks. (.+) blocks.") do
			if (petName == UnitName('pet') or petName == 'your pet') then
				CombatStats_AddSpecialData("[Pet] Default","block",0,curtime);
			end
			return;
		end
		
		
	end
	
	if(event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS") then

		bInCombat = 1;
	
		for creatureName, damage,tmpStr in string.gfind(arg1, "(.+) hits you for (%d+). (.+) blocked") do
			CombatStats_AddDefDPSEntry("Your",damage);
			CombatStats_AddSpecialData("Defensive","hit",damage,curtime);
			CombatStats_AddSpecialData("Defensive","block",0,curtime);			
			return;
		end
		for creatureName, damage in string.gfind(arg1, "(.+) hits you for (%d+)") do
			CombatStats_AddDefDPSEntry("Your",damage);
			CombatStats_AddSpecialData("Defensive","hit",damage,curtime);			
			return;
		end
		for creatureName, damage in string.gfind(arg1, "(.+) crits you for (%d+).") do
			CombatStats_AddDefDPSEntry("Your",damage);
			CombatStats_AddSpecialData("Defensive","crit",damage,curtime);
			return;
		end
	
	end
	
	if( event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") then


		for creatureName, spell, damage in string.gfind(arg1, "(.+)'s (.+) hits you for (%d+).") do
			CombatStats_AddDefDPSEntry("Your",damage);
			CombatStats_AddSpecialData("Defensive","hit",damage,curtime);
			return;
		end
		
		for creatureName, spell, damage in string.gfind(arg1, "(.+)'s (.+) crits you for (%d+).") do
			CombatStats_AddDefDPSEntry("Your",damage);
			CombatStats_AddSpecialData("Defensive","crit",damage,curtime);
			return;
		end
	     
		for creatureName, spell in string.gfind(arg1, "(.+)'s (.+) was blocked%.") do
			CombatStats_AddSpecialData("Defensive","block",0,curtime);
			return;
		end
		for creatureName, spell in string.gfind(arg1, "(.+)'s (.+) was deflected%.") do
			CombatStats_AddSpecialData("Defensive","deflect",0,curtime);
			return;
		end
		for creatureName, spell in string.gfind(arg1, "(.+)'s (.+) was dodged%.") do
			CombatStats_AddSpecialData("Defensive","dodge",0,curtime);
			return;
		end
		for creatureName, spell in string.gfind(arg1, "(.+)'s (.+) was evaded%.") do
			CombatStats_AddSpecialData("Defensive","evade",0,curtime);
			return;
		end
		for creatureName, spell in string.gfind(arg1, "(.+)'s (.+) failed. You are immune.") do
			CombatStats_AddSpecialData("Defensive","immune",0,curtime);
			return;
		end
		for creatureName, spell in string.gfind(arg1, "(.+)'s (.+) misses you.") do
			CombatStats_AddSpecialData("Defensive","miss",0,curtime);
			return;
		end
		for creatureName, spell in string.gfind(arg1, "You parry (.+)'s (.+)") do
			CombatStats_AddSpecialData("Defensive","parry",0,curtime);
			return;
		end
		for creatureName, spell in string.gfind(arg1, "(.+)'s (.+) was resisted%.") do
			CombatStats_AddSpecialData("Defensive","resist",0,curtime);
			return;
		end
	end
	if (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES") then

		
		for creatureName in string.gfind(arg1, "(.+) misses you.") do
			CombatStats_AddSpecialData("Defensive","miss",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "(.+) attacks. You parry.") do
			CombatStats_AddSpecialData("Defensive","parry",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "(.+) attacks. You evade.") do
			CombatStats_AddSpecialData("Defensive","evade",0,curtime);			
			return;
		end
		for creatureName in string.gfind(arg1, "(.+) attacks. You dodge.") do
			CombatStats_AddSpecialData("Defensive","dodge",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "(.+) attacks. You deflect.") do
			CombatStats_AddSpecialData("Defensive","deflect",0,curtime);
			return;
		end
		for creatureName in string.gfind(arg1, "(.+) attacks. You block.") do
			CombatStats_AddSpecialData("Defensive","block",0,curtime);
			return;
		end
	end

	if ( event == "CHAT_MSG_SPELL_SELF_BUFF" or event == "CHAT_MSG_SPELL_PARTY_BUFF" or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" ) then
		local useless, useless, spell, amount = string.find(arg1, "Your (.+) critically heals .+ for (%d+)%.");
		if ( spell and amount ) then
			CombatStats_AddSpecialData("[Heal] Total","crit",amount,curtime, 1);
			CombatStats_AddSpecialData("[Heal] "..spell,"crit",amount,curtime, 1);		
		elseif ( string.find(arg1, "Your (.+) heals .+ for (%d+)%.") ) then
			local useless, useless, spell, amount = string.find(arg1, "Your (.+) heals .+ for (%d+)%.");
			if ( spell and amount ) then
				CombatStats_AddSpecialData("[Heal] Total","hit",amount,curtime, 1);
				CombatStats_AddSpecialData("[Heal] "..spell,"hit",amount,curtime, 1);
			end
		end
	end

	if ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" ) then
		local useless, useless, amount, spell = string.find(arg1, ".+ gains (%d+) health from your (.+)%.");
		if ( spell and amount ) then
			CombatStats_AddSpecialData("[Heal] Total","hit",amount,curtime, 1);
			CombatStats_AddSpecialData("[Heal] "..spell,"hot",amount,curtime, 1);		
		end
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" ) then
		local useless, useless, amount, spell = string.find(arg1, "You gain (%d+) health from (.+)%.");
		if ( not string.find(arg1, "'s") and spell and amount ) then
			CombatStats_AddSpecialData("[Heal] Total","hit",amount,curtime, 1);
			CombatStats_AddSpecialData("[Heal] "..spell,"hot",amount,curtime, 1);		
		end
	end
end

--
--	Add/Check for attack(s)
--

function CombatStats_AddSpecialData(specialName,type,dmg,time, heal)
		
	
	--
	--	If we haven't logged this attack
	--	Create a record in the table for it
	--		

	--print2("Adding : "..specialName .." with damage : "..dmg.."at : "..time);	
			
	if(specialName ~= "Defensive" and not heal ) then
		lastFightPlayerDamage = lastFightPlayerDamage + dmg;
		totalDamage = totalDamage + dmg;
	end
	
	for creatureName,tempJunk in string.gfind(specialName, "(.+)Pet(.+)") do
	--	print2("creatureName : "..creatureName);
	--	print2("tempJunk : "..tempJunk);
	--	print2("Adding pet special : "..specialName.. " with damage of : "..dmg);
		lastFightPetDamage = lastFightPetDamage + dmg;
	end
	
	if (type == "dot") then
		specialName = specialName .." [DOT]";
	elseif ( type == "hot" ) then
		specialName = specialName .." [HOT]";
	end

	if(specialName == "Default") then
		bHasDefault = 1;
	end
	
	if ( not specialAttacks[specialName] ) then
		specialsCount = specialsCount + 1;
		table.insert(attackNames,specialName);
		
		specialAttackLog[specialsCount] = {
			index				=	specialsCount,
			name				=	specialName,
			isDOT				=	0,
			dotDmg				=	0,
			dotTicks			=	0,
			totalSwings			=	0,
			totalMisses			=	0,
			totalDodged			=	0,
			totalParried		=	0,
			totalEvaded			=	0,
			totalBlocked		=	0,
			totalResisted		=	0,
			totalImmuned		=	0,
			totalDeflected		=	0,
			totalHits			=	0,
			totalNonCrits		=	0,
			totalCrits			=	0,
			maxCrit				=	0,
			minCrit				=	0,
			maxReg				=	0,
			minReg				=	0,
			totalRegDmg			=	0,
			totalCritDmg		=	0,
			lastCrit			=	0,
		}
		
		specialAttacks[specialName]	= specialAttackLog[specialsCount];
		
		local info;
		
		info = {};
		info.text = specialName;
		info.func = CombatStatsAttack_OnClick;
		UIDropDownMenu_AddButton(info);
				
	end
	
	--
	--	Now add the data
	--


	if(specialName ~= "Defensive" and not heal ) then	
		specialAttacks[specialName].totalSwings = specialAttacks[specialName].totalSwings + 1;	
		overallSwings = overallSwings + 1;
	
		if(type == "crit") then
		
			totalHits = totalHits + 1;
			totalCrits = totalCrits + 1;
			specialAttacks[specialName].totalCrits = specialAttacks[specialName].totalCrits +1;
			specialAttacks[specialName].totalCritDmg = specialAttacks[specialName].totalCritDmg + dmg;
			specialAttacks[specialName].lastCrit = time;	
			specialAttacks[specialName].totalHits = specialAttacks[specialName].totalHits + 1;
		
			overallCrits = overallCrits + 1;
			overallCritDmg = overallCritDmg + dmg;
			overallLastcrit = time;
				
			--
			--	Set the initial min/max		
			--
		
			if(specialAttacks[specialName].maxCrit == 0) then
				specialAttacks[specialName].maxCrit = dmg;
			end
		
			if(specialAttacks[specialName].minCrit == 0) then
				specialAttacks[specialName].minCrit = dmg;
			end
		
			if(overallmaxCrit == 0) then
				overallmaxCrit = dmg;
			end
		
			if(overallminCrit == 0) then
				overallminCrit = dmg;
			end
		
			--
			--	Check to see if this dmg
			--	is a new min or max
			--
				
			if(tonumber(dmg) < tonumber(specialAttacks[specialName].minCrit)) then
				specialAttacks[specialName].minCrit = dmg;
			end
		
			if(tonumber(dmg) > tonumber(specialAttacks[specialName].maxCrit)) then
				specialAttacks[specialName].maxCrit = dmg;
			end	
		
			if(tonumber(dmg) < tonumber(overallminCrit)) then
				overallminCrit = dmg;
			end
		
			if(tonumber(dmg) > tonumber(overallmaxCrit)) then
				overallmaxCrit = dmg;
			end	
		
		end
	
		if(type == "hit") then
		
			totalHits = totalHits + 1;
			specialAttacks[specialName].isDOT = 0;
			specialAttacks[specialName].totalNonCrits = specialAttacks[specialName].totalNonCrits +1;
			specialAttacks[specialName].totalRegDmg = specialAttacks[specialName].totalRegDmg + dmg;
			specialAttacks[specialName].totalHits = specialAttacks[specialName].totalHits + 1;
		
			overallNonCrits = overallNonCrits + 1;
			overallRegDmg = overallRegDmg + dmg;
		
			--
			--	Set the initial min/max		
			--
		
			if(specialAttacks[specialName].maxReg == 0) then
				specialAttacks[specialName].maxReg = dmg;
			end
		
			if(specialAttacks[specialName].minReg == 0) then
				specialAttacks[specialName].minReg = dmg;
			end
		
			if(overallmaxReg == 0) then
				overallmaxReg = dmg;
			end
		
			if(overallminReg == 0) then
				overallminReg = dmg;
			end
		
			--
			--	Check to see if this dmg
			--	is a new min or max
			--
		
			if(tonumber(dmg) < tonumber(specialAttacks[specialName].minReg)) then
				specialAttacks[specialName].minReg = dmg;
			end
		
			if(tonumber(dmg) > tonumber(specialAttacks[specialName].maxReg)) then
				specialAttacks[specialName].maxReg = dmg;
			end
		
			if(tonumber(dmg) < tonumber(overallminReg)) then
				overallminReg = dmg;
			end
		
			if(tonumber(dmg) > tonumber (overallmaxReg)) then
				overallmaxReg = dmg;
			end	
		
		end
	
		if(type == "dot") then
		
			totalHits = totalHits + 1;
			specialAttacks[specialName].isDOT = 1;
			specialAttacks[specialName].dotTicks = specialAttacks[specialName].dotTicks +1;
			specialAttacks[specialName].dotDmg = specialAttacks[specialName].dotDmg + dmg;
			specialAttacks[specialName].totalHits = specialAttacks[specialName].totalHits + 1;		
		
			overallNonCrits = overallNonCrits + 1;
			overallRegDmg = overallRegDmg + dmg;
		
			--
			--	Set the initial min/max		
			--
		
			if(specialAttacks[specialName].maxReg == 0) then
				specialAttacks[specialName].maxReg = dmg;
			end
			
			if(specialAttacks[specialName].minReg == 0) then
				specialAttacks[specialName].minReg = dmg;
			end
		
			if(overallmaxReg == 0) then
				overallmaxReg = dmg;
			end
		
			if(overallminReg == 0) then
				overallminReg = dmg;
			end
		
			--
			--	Check to see if this dmg
			--	is a new min or max
			--
		
			if(tonumber(dmg) < tonumber(specialAttacks[specialName].minReg)) then
				specialAttacks[specialName].minReg = dmg;
			end
		
			if(tonumber(dmg) > tonumber(specialAttacks[specialName].maxReg)) then
				specialAttacks[specialName].maxReg = dmg;
			end
		
			if(tonumber(dmg) < tonumber(overallminReg)) then
				overallminReg = dmg;
			end
		
			if(tonumber(dmg) > tonumber (overallmaxReg)) then
				overallmaxReg = dmg;
			end	
		
		end
	         
		if(type == "miss") then
		
			specialAttacks[specialName].totalMisses = 	specialAttacks[specialName].totalMisses + 1;
			overallMisses = overallMisses +1;
			
		end
	
		if(type == "dodge") then
			
			specialAttacks[specialName].totalDodged = 	specialAttacks[specialName].totalDodged + 1;
			overallDodged = overallDodged + 1;
		
		end
	
		if(type == "parry") then
			
			specialAttacks[specialName].totalParried = 	specialAttacks[specialName].totalParried + 1;
			overallParried = overallParried + 1;
		
		end
	
		if(type == "block") then
		
			specialAttacks[specialName].totalBlocked = 	specialAttacks[specialName].totalBlocked + 1;
			overallBlocked = overallBlocked + 1;
	
		end
	
		if(type == "evade") then
		
			specialAttacks[specialName].totalEvaded = 	specialAttacks[specialName].totalEvaded + 1;
			overallEvaded = overallEvaded + 1;
		
		end
	
		if(type == "resist") then
			
			specialAttacks[specialName].totalResisted = 	specialAttacks[specialName].totalResisted + 1;
			overallResisted = overallResisted + 1;
			
		end
	
		if(type == "immune") then
		
			specialAttacks[specialName].totalImmuned = 	specialAttacks[specialName].totalImmuned + 1;
			overallImmuned = overallImmuned + 1;
		
		end
	
		if(type == "deflect") then
			
			specialAttacks[specialName].totalDeflected = 	specialAttacks[specialName].totalDeflected + 1;
			overallDeflected = overallDeflected + 1;
		
		end
	
	else
	
		--
		--	Defesnsive info
		--	Don't add to overall stats and overa
		--
		
		specialAttacks[specialName].totalSwings = specialAttacks[specialName].totalSwings + 1;
		
		if(type == "crit") then
		
			specialAttacks[specialName].totalCrits = specialAttacks[specialName].totalCrits +1;
			specialAttacks[specialName].totalCritDmg = specialAttacks[specialName].totalCritDmg + dmg;
			specialAttacks[specialName].lastCrit = time;	
			specialAttacks[specialName].totalHits = specialAttacks[specialName].totalHits + 1;
						
			--
			--	Set the initial min/max		
			--
		
			if(specialAttacks[specialName].maxCrit == 0) then
				specialAttacks[specialName].maxCrit = dmg;
			end
		
			if(specialAttacks[specialName].minCrit == 0) then
				specialAttacks[specialName].minCrit = dmg;
			end
				
			--
			--	Check to see if this dmg
			--	is a new min or max
			--
				
			if(tonumber(dmg) < tonumber(specialAttacks[specialName].minCrit)) then
				specialAttacks[specialName].minCrit = dmg;
			end
		
			if(tonumber(dmg) > tonumber(specialAttacks[specialName].maxCrit)) then
				specialAttacks[specialName].maxCrit = dmg;
			end			
		
		end
	
		if(type == "hit") then
		
			specialAttacks[specialName].isDOT = 0;
			specialAttacks[specialName].totalNonCrits = specialAttacks[specialName].totalNonCrits +1;
			specialAttacks[specialName].totalRegDmg = specialAttacks[specialName].totalRegDmg + dmg;
			specialAttacks[specialName].totalHits = specialAttacks[specialName].totalHits + 1;
				
			--
			--	Set the initial min/max		
			--
		
			if(specialAttacks[specialName].maxReg == 0) then
				specialAttacks[specialName].maxReg = dmg;
			end
		
			if(specialAttacks[specialName].minReg == 0) then
				specialAttacks[specialName].minReg = dmg;
			end
			
			--
			--	Check to see if this dmg
			--	is a new min or max
			--
		
			if(tonumber(dmg) < tonumber(specialAttacks[specialName].minReg)) then
				specialAttacks[specialName].minReg = dmg;
			end
		
			if(tonumber(dmg) > tonumber(specialAttacks[specialName].maxReg)) then
				specialAttacks[specialName].maxReg = dmg;
			end			
		
		end

		if(type == "hot") then
			specialAttacks[specialName].isDOT = 2;
			specialAttacks[specialName].dotTicks = specialAttacks[specialName].dotTicks +1;
			specialAttacks[specialName].dotDmg = specialAttacks[specialName].dotDmg + dmg;
			specialAttacks[specialName].totalHits = specialAttacks[specialName].totalHits + 1;
		
			--
			--	Set the initial min/max		
			--
		
			if(specialAttacks[specialName].maxReg == 0) then
				specialAttacks[specialName].maxReg = dmg;
			end
			
			if(specialAttacks[specialName].minReg == 0) then
				specialAttacks[specialName].minReg = dmg;
			end
		
		
			--
			--	Check to see if this dmg
			--	is a new min or max
			--
		
			if(tonumber(dmg) < tonumber(specialAttacks[specialName].minReg)) then
				specialAttacks[specialName].minReg = dmg;
			end
		
			if(tonumber(dmg) > tonumber(specialAttacks[specialName].maxReg)) then
				specialAttacks[specialName].maxReg = dmg;
			end	
		
		end
		
		if(type == "miss") then		
			specialAttacks[specialName].totalMisses = 	specialAttacks[specialName].totalMisses + 1;
		end
	
		if(type == "dodge") then
			specialAttacks[specialName].totalDodged = 	specialAttacks[specialName].totalDodged + 1;
		end
	
		if(type == "parry") then
			specialAttacks[specialName].totalParried = 	specialAttacks[specialName].totalParried + 1;
		end
	
		if(type == "block") then
			specialAttacks[specialName].totalBlocked = 	specialAttacks[specialName].totalBlocked + 1;
		end
	
		if(type == "evade") then
			specialAttacks[specialName].totalEvaded = 	specialAttacks[specialName].totalEvaded + 1;
		end
	
		if(type == "resist") then
			specialAttacks[specialName].totalResisted = 	specialAttacks[specialName].totalResisted + 1;
		end
	
		if(type == "immune") then
			specialAttacks[specialName].totalImmuned = 	specialAttacks[specialName].totalImmuned + 1;
		end
	
		if(type == "deflect") then
			specialAttacks[specialName].totalDeflected = 	specialAttacks[specialName].totalDeflected + 1;
		end
		
	end
	if ( CombatStatsDataFrame.currAttack and CombatStatsDataFrame.currAttack == specialName ) then
		CombatStats_UpdateDetails(specialName);
	end
						
end

-- CombatStats Event Watcher
--
-- Update Handler
--


function CombatStats_OnUpdate(elapsed)
	local curtime = GetTime();
	local oldesttime = 0;
	local oldesttimeTaken = 0;
	local deleteindex = 0;
	local deleteindexTaken = 0;
	local playerFrame;
	if ( bInCombat == 1 ) then
		combatTime = combatTime + elapsed;
	end
	--print2("In Combat == " ..bInCombat);

	
	
	
	if (bInCombat == 1) then

		-- Check to see if its time to update the on screen DPS and only update if there are dps entries to save CPU
		if ( ((curtime - CombatStats_LastUpdate) > CombatStats_UpdateFreq) and (table.getn(timestamps) > 0) ) then
	
			-- TODO: Change this to a high to low loop so we can do our subtracts and deletes in the same run
			
			--
			--	Offensive
			--
		
			for k,v in pairs(timestamps) do
				
				-- Get rid of old dps entries and adjust the totals				
				if ( (curtime - CombatStats_DPSLen) > v ) then

					-- Subtract this entry from the totals
					dpstotals[players[k]] = dpstotals[players[k]] - dmg[k];					
				
					-- Mark for later removal *We can't do the remove here cause table.remove reindexes the list and bones our loop
					deleteindex = k;
				else
					-- were into the good stuff now, stop
					oldesttime = v;
					break;
				end
			end
					
			
			-- Remove entries from deleteindex down so we don't miss em
			while (deleteindex > 0) do
				table.remove(timestamps, deleteindex);
				table.remove(players, deleteindex);
				table.remove(dmg, deleteindex);
				deleteindex = deleteindex -1;
			end
			
		end
			
		if ( ((curtime - CombatStats_LastUpdate) > CombatStats_UpdateFreq) and (table.getn(takenTimestamps) > 0) ) then
		
			--
			--	Defensive
			--
			
			for w,y in pairs(takenTimestamps) do
			
				-- Get rid of old dps entries and adjust the totals				
				if ( (curtime - CombatStats_DPSLen) > y ) then

					-- Subtract this entry from the totals
					dpsTakenTotals[playersTaken[w]] = dpsTakenTotals[playersTaken[w]] - dmgTaken[w];
			
					-- Mark for later removal *We can't do the remove here cause table.remove reindexes the list and bones our loop
					deleteindexTaken = w;
				else
					-- were into the good stuff now, stop
					oldesttimeTaken = y;
					break;
				end
			end
			
			-- Remove entries from deleteindex down so we don't miss em
			while (deleteindexTaken > 0) do
				table.remove(takenTimestamps, deleteindexTaken);
				table.remove(playersTaken, deleteindexTaken);
				table.remove(dmgTaken, deleteindexTaken);
				deleteindexTaken = deleteindexTaken -1;
			end
			
		end
	
				
			-- NOTE: Everyone calcs off the same oldest time, not their own oldest time.
			--       This should give more accurate dps on a per group fight basis.

	
		if ( ((curtime - CombatStats_LastUpdate) > CombatStats_UpdateFreq) and (table.getn(timestamps) > 0) ) then
			
			--local text = "CurTime - Oldesettime : %.1f";
			--text = format(text,(curtime - oldesttime));
			--print2(text);
			
			-- Update player DPS
			if ( dpstotals["Your"] ~= nil ) then
					if(dpsTakenTotals["Your"] ~= nil) then
						CombatStatsText:SetText( RED_FONT_COLOR_CODE.. format(TEXT(DPS_DISPLAY), (dpsTakenTotals["Your"] / (curtime - oldesttimeTaken) )) ..NORMAL_FONT_COLOR_CODE.. " / " ..GREEN_FONT_COLOR_CODE.. format(TEXT(DPS_DISPLAY), (dpstotals["Your"] / (curtime - oldesttime) )) );
					else						
						CombatStatsText:SetText( RED_FONT_COLOR_CODE.. "0.0" ..NORMAL_FONT_COLOR_CODE.. " / " ..GREEN_FONT_COLOR_CODE.. format(TEXT(DPS_DISPLAY), (dpstotals["Your"] / (curtime - oldesttime) )) );
					end
					
				
			end

			CombatStats_LastUpdate = curtime;
		end
		
		--
		--	If the data frame is visible
		--	update the selected attack "Real time"
		--
		
		if (CombatStatsDataFrame:IsVisible()) then
			
			if( UIDropDownMenu_GetText(CombatStatsAttackDropDown) ~= CS_DROPDOWN_SELECT_TEXT) then
				CombatStats_UpdateDetails( UIDropDownMenu_GetText(CombatStatsAttackDropDown));
			end
		end
		
	end
end


-- Called from XML
function CombatStats_OnLoad()
	if ( Cosmos_RegisterConfiguration ~= nil) then 
		CombatStats_RegisterCosmos();
		HookFunction("TargetFrame_OnShow", "CombatStats_TargetFrame_OnShow", "after");
		HookFunction("TargetFrame_OnHide", "CombatStats_TargetFrame_OnHide", "after");
	else
	-- Standalone (chatwatch)
		CombatStats_Old_TargetFrame_OnShow = TargetFrame_OnShow;
		CombatStats_Old_TargetFrame_OnHide = TargetFrame_OnHide;
		TargetFrame_OnShow = CombatStats_TargetFrame_OnShow;
		TargetFrame_OnHide = CombatStats_TargetFrame_OnHide;			
		
		SLASH_CSSLASH1 = "/combatstats";
		SLASH_CSSLASH2 = "/cs";	
		SlashCmdList["CSSLASH"] = CombatStats_ChatCommandHandler;
					
	end
		
		if (not Print) then
				setglobal("Print", function(msg, r, g, b, frame, id)
					if (not r) then r = 1.0; end
					if (not g) then g = 1.0; end
					if (not b) then b = 1.0; end
					if (not frame) then frame = DEFAULT_CHAT_FRAME; end
					if (frame) then
						if (not id) then
							frame:AddMessage(msg,r,g,b);
						else
							frame:AddMessage(msg,r,g,b,id);
						end
					end
				end);
			end		

		this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
		this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
		this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");
		this:RegisterEvent("CHAT_MSG_COMBAT_PET_MISSES");
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
	
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
		this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");
		this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
		this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
		
		this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		
		this:RegisterEvent("CHAT_MSG_SYSTEM");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_LEAVE_COMBAT");
		this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");	
		this:RegisterEvent("CHAT_MSG_COMBAT_LOG_ENEMY");
		this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

		-- Heals
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");

		this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
		this:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
		this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
			
		CombatStatsText:SetText("Overall DPS :: ");
		CombatStats_UpdateVisibility();
end

function CombatStatsAttack_OnClick()
		
	local attackID = this:GetID();
			
	UIDropDownMenu_SetSelectedID(CombatStatsAttackDropDown, attackID);	
	--print2("GetID :: ".. UIDropDownMenu_GetSelectedID(CombatStatsAttackDropDown));
	local attackName =  UIDropDownMenu_GetText(CombatStatsAttackDropDown);
	UIDropDownMenu_SetSelectedValue(CombatStatsAttackDropDown, attackName);
	--print2("GetValue :: ".. UIDropDownMenu_GetSelectedValue(CombatStatsAttackDropDown));
	UIDropDownMenu_SetText(attackName,CombatStatsAttackDropDown);
	--this:SetText(CombatStatsDetailTypes[detailID].value);
	--this.text = CombatStatsDetailTypes[detailID].value;
	
	CombatStats_UpdateDetails(attackName);
	
end

function CombatStatsAttackDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CombatStatsAttackDropDown_Initialize);
end


function CombatStatsAttackDropDown_Initialize()
	CombatStats_LoadAttackNames();
end

function CombatStats_LoadAttackNames()

	local info;
	
	if(table.getn(attackNames) ~= 0) then	
		if(bHasDefault == 1) then
			info = {};
			info.text = "Default";
			info.func = CombatStatsAttack_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
	
	for i=1, table.getn(attackNames), 1 do
		
		if(attackNames[i] ~= "Default") then	
			info = {};
			info.text = attackNames[i];
			info.func = CombatStatsAttack_OnClick;
			UIDropDownMenu_AddButton(info);
		end
		
	end
	
	if(table.getn(attackNames) ~= 0) then		
		info = {};
		info.text = "Total";
		info.func = CombatStatsAttack_OnClick;
		UIDropDownMenu_AddButton(info);
	end
			
end

--
--	Add the damage to the DPS table
--

function CombatStats_AddDPSEntry(p, d)
	
	
	table.insert(timestamps, GetTime());
	table.insert(players, p);
	table.insert(dmg, d);

	-- Keep running totals on group members to shorten calculation times
	-- We'll subtract off the expired entries during OnUpdate				
	if (dpstotals[p] == nil) then
	--	print2("dpstotals[p] == nil");
		dpstotals[p] = d;
	else
	--	print2("dpstotals[p] == " ..dpstotals[p] );
		dpstotals[p] = dpstotals[p] + d;
	--	print2("AFTER : dpstotals[p] == " ..dpstotals[p] );
	end
	
	--print2("Total : " ..dpstotals[p]);
end


--
--	Add damage taken to the DPS table
--

function CombatStats_AddDefDPSEntry(p, d)

	--print2("Adding Entry[" .. p .. "] = " .. d);	-- debug
	table.insert(takenTimestamps, GetTime());
	table.insert(playersTaken, p);
	table.insert(dmgTaken, d);

	-- Keep running totals on group members to shorten calculation times
	-- We'll subtract off the expired entries during OnUpdate				
	if (dpsTakenTotals[p] == nil) then
	--	print2("dpstotals[p] == nil");
		dpsTakenTotals[p] = d;
	else
	--	print2("dpstotals[p] == " ..dpstotals[p] );
		dpsTakenTotals[p] = dpsTakenTotals[p] + d;
	--	print2("AFTER : dpstotals[p] == " ..dpstotals[p] );
	end
	
	--print2("Total : " ..dpstotals[p]);
end

--	Show the stats collected

function CombatStatsText_OnClick()
   if (CombatStatsDataFrame:IsVisible()) then 
   	CombatStatsDataFrame:Hide();
   else
		if (CombatStats_Config.CombatStats_UseMouseOver == 0) then
			CombatStatsText_ShowFrame();
		end
	end
end

function CombatStatsText_OnEnter()
	if (CombatStats_Config.CombatStats_UseMouseOver == 1) then
		CombatStatsText_ShowFrame();
	end
end

function CombatStatsText_ShowFrame()

	
	if(bFirstTime == 1) then
		
		--
		--	Set all the default values
		--
		
		CombatStatsGeneralNameLabel:SetText(TEXT(CS_FRAME_GEN_ATTACK_NAME));	
		CombatStatsGeneralHitsTextLabel:SetText(CS_FRAME_HITS_TEXT);
		CombatStatsGeneralSwingsTextLabel:SetText(CS_FRAME_SWINGS_TEXT);
		CombatStatsGeneralMissesLabel:SetText(CS_FRAME_MISSES_TEXT);
		CombatStatsGeneralDodgesLabel:SetText(CS_FRAME_DODGES_TEXT);
		CombatStatsGeneralParriedLabel:SetText(CS_FRAME_PARRIES_TEXT);
		CombatStatsGeneralBlockedLabel:SetText(CS_FRAME_BLOCKS_TEXT);
		CombatStatsGeneralResistedLabel:SetText(CS_FRAME_RESISTS_TEXT);
		CombatStatsGeneralImmunedLabel:SetText(CS_FRAME_IMMUNE_TEXT);
		CombatStatsGeneralEvadedLabel:SetText(CS_FRAME_EVADES_TEXT );
		CombatStatsGeneralDeflectedLabel:SetText(CS_FRAME_DEFLECTS_TEXT);
		CombatStatsGeneralPercentDmgLabel:SetText(CS_FRAME_PERCENT_OVERALL_TEXT);
		CombatStatsGeneralTimeLastCritLabel:SetText(CS_FRAME_TIME_LASTCRIT_TEXT);
		
		CombatStatsNonCritHitsLabel:SetText(CS_FRAME_TOTAL_TEXT);
		CombatStatsNonCritDamageLabel:SetText(CS_FRAME_DAMAGE_TEXT);
		CombatStatsNonCritMinMaxLabel:SetText(CS_FRAME_MINMAX_TEXT);
		CombatStatsNonCritAvgLabel:SetText(CS_FRAME_AVGDMG_TEXT);
		CombatStatsNonCritPercentDamageLabel:SetText(CS_FRAME_PERCENTDMG_TEXT);
		
		CombatStatsCritHitsLabel:SetText(CS_FRAME_TOTAL_TEXT);
		CombatStatsCritDamageLabel:SetText(CS_FRAME_DAMAGE_TEXT);
		CombatStatsCritMinMaxLabel:SetText(CS_FRAME_MINMAX_TEXT);
		CombatStatsCritAvgLabel:SetText(CS_FRAME_AVGDMG_TEXT);
		CombatStatsCritPercentDamageLabel:SetText(CS_FRAME_PERCENTDMG_TEXT);
		
		CombatStatsGeneralNameTextLabel:SetText("N/A");
		
		CombatStatsNonCritHitsStatText:SetText("0");	
		CombatStatsNonCritDamageStatText:SetText("0");		
		CombatStatsNonCritMinMaxStatText:SetText("0 / 0");	
		CombatStatsNonCritAvgStatText:SetText("0.0");	
		CombatStatsNonCritPercentDamageStatText:SetText("0.0 %");	
	
		CombatStatsCritHitsStatText:SetText("0");
		CombatStatsCritDamageStatText:SetText("0");
		CombatStatsCritMinMaxStatText:SetText("0 / 0");
		CombatStatsCritAvgStatText:SetText("0.0");
		CombatStatsCritPercentDamageStatText:SetText("0.0 %");
	
		CombatStatsGeneralTotalHitsHits:SetText("0");	
		CombatStatsGeneralSwingsLabel:SetText("0");
			
		CombatStatsGeneralMissesTextLabel:SetText("0");	
		CombatStatsGeneralMissesPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralDodgesTextLabel:SetText("0");	
		CombatStatsGeneralDodgesPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralParriedTextLabel:SetText("0");	
		CombatStatsGeneralParriedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralBlockedTextLabel:SetText("0");	
		CombatStatsGeneralBlockedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralResistedTextLabel:SetText("0");	
		CombatStatsGeneralResistedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralImmunedTextLabel:SetText("0");	
		CombatStatsGeneralImmunedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralEvadedTextLabel:SetText("0");	
		CombatStatsGeneralEvadedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralDeflectedTextLabel:SetText("0");
		CombatStatsGeneralDeflectedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		
		CombatStatsGeneralPercentDmgPctLabel:SetText("0.0%");
		
		CombatStatsGeneralTimeLastCritTimeLabel:SetText(GREEN_FONT_COLOR_CODE.."N/A");
	
		CombatStatsOverallCritPctLabel:SetText(RED_FONT_COLOR_CODE.."0.0 %");		
		
		CombatStatsAttackNonCritPctLabel:SetText(GREEN_FONT_COLOR_CODE.."0.0 %");		
		CombatStatsAttackCritPctLabel:SetText(RED_FONT_COLOR_CODE.."0.0 %");
		
		UIDropDownMenu_SetText(CS_DROPDOWN_SELECT_TEXT,CombatStatsAttackDropDown);
		
		bFirstTime = 0;
		
	end
	
	if( UIDropDownMenu_GetText(CombatStatsAttackDropDown) ~= CS_DROPDOWN_SELECT_TEXT) then
		
		CombatStats_UpdateDetails( UIDropDownMenu_GetText(CombatStatsAttackDropDown));
		
	end
	
	CombatStatsDataFrame:Show();
	
end

function CS_ToggleGameMenu(clicked)
	if ( clicked ) then
		if ( OptionsFrame:IsVisible() ) then
			OptionsFrameCancel:Click();
		end
		if ( GameMenuFrame:IsVisible() ) then
			PlaySound("igMainMenuQuit");
			HideUIPanel(GameMenuFrame);
		else
			CloseMenus();
			CloseAllWindows()
			PlaySound("igMainMenuOpen");
			ShowUIPanel(GameMenuFrame);
		end
		return;
	end
	if ( StaticPopup_EscapePressed() ) then
	elseif ( OptionsFrame:IsVisible() ) then
		OptionsFrameCancel:Click();
	elseif ( GameMenuFrame:IsVisible() ) then
		PlaySound("igMainMenuQuit");
		HideUIPanel(GameMenuFrame);
	elseif ( CloseMenus() ) then
	elseif ( SpellStopCasting() ) then
	elseif ( SpellStopTargeting() ) then
	elseif ( CloseAllWindows() ) then
		CombatStatsDataFrame:Hide();
	elseif ( ClearTarget() ) then
	else
		if ( CombatStatsDataFrame:IsVisible() ) then
			CombatStatsDataFrame:Hide();
			return;
		end
		PlaySound("igMainMenuOpen");
		ShowUIPanel(GameMenuFrame);
	end
end

ToggleGameMenu = CS_ToggleGameMenu;

function CombatStats_UpdateDetails(attackName)
	CombatStatsDataFrame.currAttack = attackName;
	if ( strsub(attackName, 0, 6) == "[Heal]" ) then
	
		CS_TT_NONCRIT_HITSPCT_TEXT = CS_TT_NONCRIT_HITSPCT_TEXT_HEAL;
		CS_TT_CRIT_HITSPCT_TEXT = CS_TT_CRIT_HITSPCT_TEXT_HEAL;
		CS_TT_OVERALLDMGPCT_TEXT = CS_TT_OVERALLDMGPCT_TEXT_HEAL;
		CS_TT_CRIT_DMGPCT_TEXT = CS_TT_CRIT_DMGPCT_TEXT_HEAL;
		CS_TT_NONCRIT_DMGPCT_TEXT = CS_TT_NONCRIT_DMGPCT_TEXT_HEAL;

		CombatStatsGeneralHitsTextLabel:SetText(CS_FRAME_HITS_TEXT_HEAL);
		CombatStatsGeneralPercentDmgLabel:SetText(CS_FRAME_PERCENT_OVERALL_TEXT_HEAL);
		CombatStatsNonCritDamageLabel:SetText(CS_FRAME_DAMAGE_TEXT_HEAL);
		CombatStatsNonCritAvgLabel:SetText(CS_FRAME_AVGDMG_TEXT_HEAL);
		CombatStatsNonCritPercentDamageLabel:SetText(CS_FRAME_PERCENTDMG_TEXT_HEAL);
		CombatStatsCritDamageLabel:SetText(CS_FRAME_DAMAGE_TEXT_HEAL);
		CombatStatsCritAvgLabel:SetText(CS_FRAME_AVGDMG_TEXT_HEAL);
		CombatStatsCritPercentDamageLabel:SetText(CS_FRAME_PERCENTDMG_TEXT_HEAL);

		CombatStatsGeneralSwingsTextLabel:Hide();
	else
		CS_TT_NONCRIT_HITSPCT_TEXT = CS_TT_NONCRIT_HITSPCT_TEXT_NONHEAL;
		CS_TT_CRIT_HITSPCT_TEXT = CS_TT_CRIT_HITSPCT_TEXT_NONHEAL;
		CS_TT_OVERALLDMGPCT_TEXT = CS_TT_OVERALLDMGPCT_TEXT_NONHEAL;
		CS_TT_CRIT_DMGPCT_TEXT = CS_TT_CRIT_DMGPCT_TEXT_NONHEAL;
		CS_TT_NONCRIT_DMGPCT_TEXT = CS_TT_NONCRIT_DMGPCT_TEXT_NONHEAL;

		CombatStatsGeneralHitsTextLabel:SetText(CS_FRAME_HITS_TEXT);
		CombatStatsGeneralPercentDmgLabel:SetText(CS_FRAME_PERCENT_OVERALL_TEXT);
		CombatStatsNonCritDamageLabel:SetText(CS_FRAME_DAMAGE_TEXT);
		CombatStatsNonCritAvgLabel:SetText(CS_FRAME_AVGDMG_TEXT);
		CombatStatsNonCritPercentDamageLabel:SetText(CS_FRAME_PERCENTDMG_TEXT);
		CombatStatsCritDamageLabel:SetText(CS_FRAME_DAMAGE_TEXT);
		CombatStatsCritAvgLabel:SetText(CS_FRAME_AVGDMG_TEXT);
		CombatStatsCritPercentDamageLabel:SetText(CS_FRAME_PERCENTDMG_TEXT);

		CombatStatsGeneralSwingsTextLabel:Show();
	end

	local x,y,info;
	
	--
	--	Draw the text for the hits/swings 
	--
	
	if(attackName ~= "Total") then
			
	--
	-- Calculate % of hits that are crits
	-- 		
	
	if( (totalCrits) ~= 0) then		
		CombatStatsOverallCritPctLabel:SetText( format(RED_FONT_COLOR_CODE.."%.2f %%", ( totalCrits / totalHits) * 100.0));			
	end
	
	CombatStatsGeneralNameTextLabel:SetText(attackName);
	CombatStatsGeneralTotalHitsHits:SetText(specialAttacks[attackName].totalHits);
	if ( strsub(attackName, 0, 6) ~= "[Heal]" ) then
		CombatStatsGeneralSwingsLabel:SetText(specialAttacks[attackName].totalSwings);
		CombatStatsGeneralSwingsLabel:Show();
	else
		CombatStatsGeneralSwingsLabel:Hide();
	end
	
	CombatStatsGeneralMissesTextLabel:SetText(specialAttacks[attackName].totalMisses);
	
	if(specialAttacks[attackName].totalMisses ~= 0) then
		CombatStatsGeneralMissesPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalMisses / (specialAttacks[attackName].totalSwings) * 100)));
	else
		CombatStatsGeneralMissesPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralDodgesTextLabel:SetText(specialAttacks[attackName].totalDodged);
	
	if(specialAttacks[attackName].totalDodged ~= 0) then
		CombatStatsGeneralDodgesPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalDodged / (specialAttacks[attackName].totalSwings) * 100)));
	else
		CombatStatsGeneralDodgesPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralBlockedTextLabel:SetText(specialAttacks[attackName].totalBlocked);
	
	if(attackName == "Defensive") then
	
		if(specialAttacks[attackName].totalBlocked ~= 0) then
			CombatStatsGeneralBlockedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalBlocked / (specialAttacks[attackName].totalHits) * 100)));
		else
			CombatStatsGeneralBlockedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		end
		
	else
	
		if(specialAttacks[attackName].totalBlocked ~= 0) then
			CombatStatsGeneralBlockedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalBlocked / (specialAttacks[attackName].totalSwings) * 100)));
		else
			CombatStatsGeneralBlockedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
		end
	
	end
	
	CombatStatsGeneralParriedTextLabel:SetText(specialAttacks[attackName].totalParried);
	
	if(specialAttacks[attackName].totalParried ~= 0) then
		CombatStatsGeneralParriedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalParried / (specialAttacks[attackName].totalSwings) * 100)));
	else
		CombatStatsGeneralParriedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralResistedTextLabel:SetText(specialAttacks[attackName].totalResisted);
	
	if(specialAttacks[attackName].totalResisted ~= 0) then
		CombatStatsGeneralResistedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalResisted / (specialAttacks[attackName].totalSwings) * 100)));
	else
		CombatStatsGeneralResistedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralImmunedTextLabel:SetText(specialAttacks[attackName].totalImmuned);
	
	if(specialAttacks[attackName].totalImmuned ~= 0) then
		CombatStatsGeneralImmunedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalImmuned / (specialAttacks[attackName].totalSwings) * 100)));
	else
		CombatStatsGeneralImmunedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralEvadedTextLabel:SetText(specialAttacks[attackName].totalEvaded);
	
	if(specialAttacks[attackName].totalEvaded ~= 0) then
		CombatStatsGeneralEvadedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalEvaded / (specialAttacks[attackName].totalSwings) * 100)));
	else
		CombatStatsGeneralEvadedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralDeflectedTextLabel:SetText(specialAttacks[attackName].totalDeflected);
	
	if(specialAttacks[attackName].totalDeflected ~= 0) then
		CombatStatsGeneralDeflectedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (specialAttacks[attackName].totalDeflected / (specialAttacks[attackName].totalSwings) * 100)));
	else
		CombatStatsGeneralDeflectedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	--
	--	Percent of total damage
	--
	
	if(attackName ~= "Defensive") then	
		if ( attackName == "[Heal] Total" ) then
			CombatStatsGeneralPercentDmgPctLabel:SetText("100.0%");
		elseif ( strsub(attackName, 0, 6) == "[Heal]" ) then
			if ( specialAttacks[attackName].totalHits ~= 0 ) then
				CombatStatsGeneralPercentDmgPctLabel:SetText( format("%.2f %%",  ((specialAttacks[attackName].totalRegDmg + specialAttacks[attackName].totalCritDmg + specialAttacks[attackName].dotDmg) / (specialAttacks["[Heal] Total"].totalRegDmg + specialAttacks["[Heal] Total"].totalCritDmg + specialAttacks["[Heal] Total"].dotDmg)) * 100) );
			else
				CombatStatsGeneralPercentDmgPctLabel:SetText("0.0%");
			end
		else
			
			if(specialAttacks[attackName].totalHits ~=0) then
				CombatStatsGeneralPercentDmgPctLabel:SetText( format("%.2f %%",  ((specialAttacks[attackName].totalRegDmg + specialAttacks[attackName].totalCritDmg + specialAttacks[attackName].dotDmg) / totalDamage) * 100) );
			else
				CombatStatsGeneralPercentDmgPctLabel:SetText("0.0%");
			end
		end
	end
	
	--
	--	Time since last crit
	--
	
	local timeNow;
	timeNow = combatTime;
	
	if(specialAttacks[attackName].lastCrit ~= 0) then
		CombatStatsGeneralTimeLastCritTimeLabel:SetText(GREEN_FONT_COLOR_CODE ..Clock_FormatTime( (timeNow - specialAttacks[attackName].lastCrit)));
	else
		CombatStatsGeneralTimeLastCritTimeLabel:SetText(GREEN_FONT_COLOR_CODE.."N/A");	
	end
	
	--
	--	Attack Crit %
	--
	
	if (specialAttacks[attackName].totalHits ~= 0) and (specialAttacks[attackName].totalCrits ~= 0) then
		CombatStatsAttackCritPctLabel:SetText(format(RED_FONT_COLOR_CODE.."%.1f%%", ( (specialAttacks[attackName].totalCrits) / (specialAttacks[attackName].totalHits)) * 100.0 ));			
	else
		CombatStatsAttackCritPctLabel:SetText(RED_FONT_COLOR_CODE.."0.0 %");
	end
	
	--
	--	Attack Non Crit %
	--
	
	if (specialAttacks[attackName].totalHits ~= 0) and (specialAttacks[attackName].totalNonCrits ~= 0) then
		CombatStatsAttackNonCritPctLabel:SetText( format(GREEN_FONT_COLOR_CODE.."%.1f%%", ( (specialAttacks[attackName].totalNonCrits) / (specialAttacks[attackName].totalHits)) * 100.0 ));			
	else
		CombatStatsAttackNonCritPctLabel:SetText(GREEN_FONT_COLOR_CODE.."0.0 %");
	end
	
	--
	--	Non Crit stats
	--
	
	CombatStatsNonCritHitsStatText:SetText(specialAttacks[attackName].totalNonCrits);	
	CombatStatsNonCritDamageStatText:SetText(specialAttacks[attackName].totalRegDmg);	
	CombatStatsNonCritMinMaxStatText:SetText(specialAttacks[attackName].minReg .." / "..specialAttacks[attackName].maxReg);
	
	if( specialAttacks[attackName].totalRegDmg ~= 0) then
												
		if( (specialAttacks[attackName].totalHits - specialAttacks[attackName].totalCrits) < 0) then
			CombatStatsNonCritAvgStatText:SetText(format("%.1f",  specialAttacks[attackName].totalRegDmg / (specialAttacks[attackName].totalCrits - specialAttacks[attackName].totalHits ) ));
		end
						
		if(	(specialAttacks[attackName].totalHits - specialAttacks[attackName].totalCrits) == 0 ) then
			CombatStatsNonCritAvgStatText:SetText(format("%1.f", specialAttacks[attackName].totalRegDmg / (specialAttacks[attackName].totalCrits) ));
		end
						
		if(	(specialAttacks[attackName].totalHits - specialAttacks[attackName].totalCrits) > 0 ) then
			CombatStatsNonCritAvgStatText:SetText(format("%1.f",specialAttacks[attackName].totalRegDmg / (specialAttacks[attackName].totalHits - specialAttacks[attackName].totalCrits) ));
		end
						
	else		
		CombatStatsNonCritAvgStatText:SetText("0.0");
	end
	
	if(specialAttacks[attackName].totalNonCrits ~=0) then
		CombatStatsNonCritPercentDamageStatText:SetText( format("%.2f %%", ( specialAttacks[attackName].totalRegDmg   / (specialAttacks[attackName].totalRegDmg + specialAttacks[attackName].totalCritDmg )) * 100.0));
	else
		CombatStatsNonCritPercentDamageStatText:SetText("0.0 %");
	end
	
	--
	--	Crit stats
	--
	
	CombatStatsCritHitsStatText:SetText(specialAttacks[attackName].totalCrits);	
	CombatStatsCritDamageStatText:SetText(specialAttacks[attackName].totalCritDmg);	
	CombatStatsCritMinMaxStatText:SetText(specialAttacks[attackName].minCrit .." / "..specialAttacks[attackName].maxCrit);
	
	if( specialAttacks[attackName].totalCritDmg ~= 0) then
		CombatStatsCritAvgStatText:SetText(format("%1.f", (specialAttacks[attackName].totalCritDmg / specialAttacks[attackName].totalCrits) ));
	else
		CombatStatsCritAvgStatText:SetText("0.0");
	end
	
	if(specialAttacks[attackName].totalCrits ~=0) then
		CombatStatsCritPercentDamageStatText:SetText(format("%.2f %%", (specialAttacks[attackName].totalCritDmg / ( specialAttacks[attackName].totalRegDmg + specialAttacks[attackName].totalCritDmg )) * 100.10 ));
	else
		CombatStatsCritPercentDamageStatText:SetText("0.0 %");
	end	
				
	--
	--	Show DOT Stats
	--
	
	
			
	if (specialAttacks[attackName].isDOT ==1) then
		
		CombatStatsGeneralHitsTextLabel:SetText(CS_FRAME_TICKS_TEXT);
		CombatStatsGeneralSwingsTextLabel:SetText("");
		CombatStatsGeneralSwingsLabel:SetText("");
		
		CombatStatsGeneralTotalHitsHits:SetText(specialAttacks[attackName].dotTicks);
		CombatStatsNonCritHitsStatText:SetText(specialAttacks[attackName].dotTicks);
		CombatStatsNonCritDamageStatText:SetText(specialAttacks[attackName].dotDmg);
		
		CombatStatsNonCritMinMaxStatText:SetText(specialAttacks[attackName].minReg .." / "..specialAttacks[attackName].maxReg);
		CombatStatsNonCritAvgStatText:SetText(format("%.1f",  specialAttacks[attackName].dotDmg /  specialAttacks[attackName].dotTicks  ));
		CombatStatsNonCritPercentDamageStatText:SetText("100.0 %");
		CombatStatsAttackNonCritPctLabel:SetText(GREEN_FONT_COLOR_CODE.."100.0%");
		
		--
		--	Should never be a 0 tick entry but just in case
		--
--		if(specialAttacks[attackNames[y]].dotTicks ~= 0) then	
--			text = text.."\n"..format(TEXT(DOT_AVERAGE),(specialAttacks[attackNames[y]].dotDmg / specialAttacks[attackNames[y]].dotTicks));
--		end
	elseif ( specialAttacks[attackName].isDOT ==2) then
		CombatStatsGeneralHitsTextLabel:SetText(CS_FRAME_HOT_TEXT);
		CombatStatsGeneralSwingsTextLabel:SetText("");
		CombatStatsGeneralSwingsLabel:SetText("");
		
		CombatStatsGeneralTotalHitsHits:SetText(specialAttacks[attackName].dotTicks);
		CombatStatsNonCritHitsStatText:SetText(specialAttacks[attackName].dotTicks);
		CombatStatsNonCritDamageStatText:SetText(specialAttacks[attackName].dotDmg);
		
		CombatStatsNonCritMinMaxStatText:SetText(specialAttacks[attackName].minReg .." / "..specialAttacks[attackName].maxReg);
		CombatStatsNonCritAvgStatText:SetText(format("%.1f",  specialAttacks[attackName].dotDmg /  specialAttacks[attackName].dotTicks  ));
		CombatStatsNonCritPercentDamageStatText:SetText("100.0 %");
		CombatStatsAttackNonCritPctLabel:SetText(GREEN_FONT_COLOR_CODE.."100.0%");
	end

	
	else
		
	--
	-- Calculate % of hits that are crits
	-- 		
	
	if( (totalCrits) ~= 0) then		
		CombatStatsOverallCritPctLabel:SetText( format(RED_FONT_COLOR_CODE.."%.2f %%", ( totalCrits / totalHits) * 100.0));			
	end
	
	CombatStatsGeneralNameTextLabel:SetText("Total");
	CombatStatsGeneralTotalHitsHits:SetText(totalHits);
	CombatStatsGeneralSwingsLabel:SetText(overallSwings);
	
	CombatStatsGeneralMissesTextLabel:SetText(overallMisses);
	
	if(overallMisses ~= 0) then
		CombatStatsGeneralMissesPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (overallMisses / (overallSwings) * 100)));
	else
		CombatStatsGeneralMissesPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralDodgesTextLabel:SetText(overallDodged);
	
	if(overallDodged ~= 0) then
		CombatStatsGeneralDodgesPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (overallDodged / (overallSwings) * 100)));
	else
		CombatStatsGeneralDodgesPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralParriedTextLabel:SetText(overallParried);
	
	if(overallParried ~= 0) then
		CombatStatsGeneralParriedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (overallParried / (overallSwings) * 100)));
	else
		CombatStatsGeneralParriedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralResistedTextLabel:SetText(overallResisted);
	
	if(overallResisted ~= 0) then
		CombatStatsGeneralResistedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (overallResisted / (overallSwings) * 100)));
	else
		CombatStatsGeneralResistedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralImmunedTextLabel:SetText(overallImmuned);
	
	if(overallImmuned ~= 0) then
		CombatStatsGeneralImmunedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (overallImmuned / (overallSwings) * 100)));
	else
		CombatStatsGeneralImmunedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralEvadedTextLabel:SetText(overallEvaded);
	
	if(overallEvaded ~= 0) then
		CombatStatsGeneralEvadedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (overallEvaded / (overallSwings) * 100)));
	else
		CombatStatsGeneralEvadedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	CombatStatsGeneralDeflectedTextLabel:SetText(overallDeflected);
	
	if(overallDeflected ~= 0) then
		CombatStatsGeneralDeflectedPercentLabel:SetText( format(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.. "%.1f%%" .. NORMAL_FONT_COLOR_CODE.." ]", (overallDeflected / (overallSwings) * 100)));
	else
		CombatStatsGeneralDeflectedPercentLabel:SetText(NORMAL_FONT_COLOR_CODE.."[ "..WHITE_FONT_COLOR_CODE.."0.0%"..NORMAL_FONT_COLOR_CODE.." ]");
	end
	
	--
	--	Percent of total damage
	--
	
	if(totalHits ~=0) then
		CombatStatsGeneralPercentDmgPctLabel:SetText( format("%.2f %%",  ((overallRegDmg + overallCritDmg ) / totalDamage) * 100) );
	else
		CombatStatsGeneralPercentDmgPctLabel:SetText("0.0%");
	end
	
	--
	--	Time since last crit
	--
	
	local timeNow;
	timeNow = GetTime();
	
	if(overallLastcrit ~= 0) then
		CombatStatsGeneralTimeLastCritTimeLabel:SetText(GREEN_FONT_COLOR_CODE ..Clock_FormatTime( (timeNow - overallLastcrit)));
	else
		CombatStatsGeneralTimeLastCritTimeLabel:SetText(GREEN_FONT_COLOR_CODE.."N/A");	
	end
	
	--
	--	Attack Crit %
	--
	
	if (totalHits ~= 0) and (overallCrits ~= 0) then
		CombatStatsAttackCritPctLabel:SetText(format(RED_FONT_COLOR_CODE.."%.1f%%", ( (overallCrits) / (totalHits)) * 100.0 ));			
	else
		CombatStatsAttackCritPctLabel:SetText(RED_FONT_COLOR_CODE.."0.0 %");
	end
	
	--
	--	Attack Non Crit %
	--
	
	if (totalHits ~= 0) and (overallNonCrits ~= 0) then
		CombatStatsAttackNonCritPctLabel:SetText( format(GREEN_FONT_COLOR_CODE.."%.1f%%", ( (overallNonCrits) / (totalHits)) * 100.0 ));			
	else
		CombatStatsAttackNonCritPctLabel:SetText(GREEN_FONT_COLOR_CODE.."0.0 %");
	end
	
	--
	--	Non Crit stats
	--
	
	CombatStatsNonCritHitsStatText:SetText(overallNonCrits);	
	CombatStatsNonCritDamageStatText:SetText(overallRegDmg);	
	CombatStatsNonCritMinMaxStatText:SetText(overallminReg .." / "..overallmaxReg);
	
	if( overallRegDmg ~= 0) then
												
		if( (totalHits - overallCrits) < 0) then
			CombatStatsNonCritAvgStatText:SetText(format("%.1f",  overallRegDmg / (overallCrits - totalHits ) ));
		end
						
		if(	(totalHits - overallCrits) == 0 ) then
			CombatStatsNonCritAvgStatText:SetText(format("%1.f", overallRegDmg / (overallCrits) ));
		end
						
		if(	(totalHits - overallCrits) > 0 ) then
			CombatStatsNonCritAvgStatText:SetText(format("%1.f", overallRegDmg / (totalHits - overallCrits) ));
		end
						
	else		
		CombatStatsNonCritAvgStatText:SetText("0.0");
	end
	
	if(overallNonCrits ~=0) then
		CombatStatsNonCritPercentDamageStatText:SetText( format("%.2f %%", ( overallRegDmg  / (overallRegDmg + overallCritDmg )) * 100.0));
	else
		CombatStatsNonCritPercentDamageStatText:SetText("0.0 %");
	end
	
	--
	--	Crit stats
	--
	
	CombatStatsCritHitsStatText:SetText(overallCrits);	
	CombatStatsCritDamageStatText:SetText(overallCritDmg);	
	CombatStatsCritMinMaxStatText:SetText(overallminCrit .." / "..overallmaxCrit);
	
	if( overallCritDmg ~= 0) then
		CombatStatsCritAvgStatText:SetText(format("%1.f", (overallCritDmg / overallCrits) ));
	else
		CombatStatsCritAvgStatText:SetText("0.0");
	end
	
	if(overallCrits ~=0) then
		CombatStatsCritPercentDamageStatText:SetText(format("%.2f %%", (overallCritDmg / ( overallRegDmg + overallCritDmg )) * 100.10 ));
	else
		CombatStatsCritPercentDamageStatText:SetText("0.0 %");
	end	
	
	end
	
end					


--
--  Time functions
--  from Clock.lua
--

local function Clock_FormatPart(fmt, val)
	local part;

	part = format(TEXT(fmt), val);
	if( val ~= 1 ) then
		part = part.."s";
	end

	return part;
end

function Clock_FormatTime(time)
	local d, h, m, s;
	local text = "";
	local skip = 1;

	if ( time == 0 ) then return Clock_FormatPart(CLOCK_TIME_SECOND, 0); end

	d, h, m, s = ChatFrame_TimeBreakDown(time);
	if( d > 0 ) then
		text = text..Clock_FormatPart(CLOCK_TIME_DAY, d)..", ";
		skip = 0;
	end
	if( (skip == 0) or (h > 0) ) then
		text = text..Clock_FormatPart(CLOCK_TIME_HOUR, h)..", ";
		skip = 0;
	end
	if( (skip == 0) or (m > 0) ) then
		text = text..Clock_FormatPart(CLOCK_TIME_MINUTE, m)..", ";
		skip = 0;
	end
	if( (skip == 0) or (s > 0) ) then
		text = text..Clock_FormatPart(CLOCK_TIME_SECOND, s);
	end

	return text;
end

function CombatStats_TargetFrame_OnShow()
	if (CombatStats_Old_TargetFrame_OnShow) then
		CombatStats_Old_TargetFrame_OnShow();
	end
	CombatStats_UpdateVisibility(1);
end

function CombatStats_TargetFrame_OnHide()
	if (CombatStats_Old_TargetFrame_OnHide) then
		CombatStats_Old_TargetFrame_OnHide();
	end
	CombatStats_UpdateVisibility(0);
end

function SmartHeal:OnLoad()

	-- register events
	SmartHeal:RegisterEvent();

end

function SmartHeal:OnEvent(event,arg1,arg2)
	
	if (event == "PLAYER_LOGIN" and SmartHeal.isActive()) then

		SmartHeal:Init()
		SmartHeal:InitClickMode()
		SmartHeal:InitHotList()
		SmartHeal:InitMiniMapButton()
		SmartHeal:ErrorMsg(SH_SMARTHEAL_LOADED.." Version "..SMARTHEAL_CURRENT_VERSION,0.5,0.6,0.8);
		
		if (SmartHeal.InitializeSave) then
			SmartHeal:setDefault();
		end
		
		if (not SmartHeal:getConfig('enabled','minimapbutton')) then
			MyMinimapButton:Disable('SmartHeal')
		end
		
		SmartHeal.Loaded=1
		
	elseif event == "VARIABLES_LOADED" then

		local _, playerClass = UnitClass("player");
		SmartHeal.playerClass=playerClass;

		if (not SMARTHEAL_HEALTABLE[playerClass]) then
			SmartHeal.active=false;
			SmartHeal:ErrorMsg(SH_IS_NOT_ACTIVE_CLASS)
			SmartHeal:UnregisterEvent()

		else
			SmartHeal.spellList=SMARTHEAL_HEALTABLE[playerClass];
			SmartHeal.buffList=SMARTHEAL_BUFFTABLE[playerClass];
			SmartHeal.active=1;
			--SmartHeal:ErrorMsg(SmartHeal_Version)
			
		end
		
				
		-- save to varaible
		SmartHeal_Version=SMARTHEAL_VERSION
		
	elseif event=="PLAYER_ENTER_COMBAT" then
		SmartHeal.Attacking=1
	elseif event=="PLAYER_LEAVE_COMBAT" then
		SmartHeal.Attacking=false
	elseif 	event=="SPELLCAST_START" then
		
		SmartHeal.SpellIsCasting=1
		SmartHeal.timer=arg2
		SmartHeal.HealUnitId=SmartHeal.CacheUnitId
		
		-- Trigger excess healing alert
		if(SmartHeal.spellList[arg1] and not SmartHeal.spellList[arg1].HoT and SmartHeal.HealUnitId and SmartHeal:getConfig("excesshealalert")) then
			SmartHeal.DoExcessHealAlert=1
		end
		
	--elseif event=="SPELLCAST_CHANNEL_UPDATE" then
	--	SmartHeal.SpellIsChanneling=1
	--	SmartHeal.timer=arg1
		
	elseif 	(event=="SPELLCAST_STOP" or event=="SPELLCAST_INTERRUPTED"
			--or event=="SPELLCAST_CHANNEL_STOP"
		)
	then
		
		SmartHeal.SpellIsCasting=false
		SmartHeal.SpellIsChanneling=false
		SmartHeal.HealUnitId=nil
		
		if(SmartHeal.AttackingBeforeCast) then
			SmartHeal.ResumeAttack=1
		end
		
	--elseif event=="SPELLCAST_FAILED" then	
		
	elseif event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" then
		
		if (SmartHeal:getConfig("alert") and UnitAffectingCombat("player")) then
			
			if (InspectFrame) then
				if (not InspectFrame:IsShown()) then
					SmartHeal:AlertHealer(arg1)
				end
			else
				SmartHeal:AlertHealer(arg1)
			end
			
		end
	end

end -- end of function

function SmartHeal:RegisterEvent(event)
	
	if (event~=nil) then
		this:RegisterEvent(event);
	else 
		for i=1, table.getn(SmartHeal.Events) do
			this:RegisterEvent(SmartHeal.Events[i]);
		end
	end
end

function SmartHeal:UnregisterEvent(event)
	
	if (event~=nil) then
		this:UnregisterEvent(event);
	else 
		for i=1, table.getn(SmartHeal.Events) do
			this:UnregisterEvent(SmartHeal.Events[i]);
		end
	end
end

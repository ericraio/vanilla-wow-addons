dontattack = 0;


--Attack Command
function SmartPet_Attack()
	local pet = UnitName("pet");
	local target = UnitName("target");

	-- Check if Enabled
	if not (SmartPet_Config.Enabled) then
	SmartPet_AddDebugMessage("SmartPet Disabled, using default petAttack", "spew");
		Pre_SmartPet_PetAttack();
		return;
	end

	if (SmartPet_Config.DebufCheck ) then
		if (SmartPet_CheckDebuff()) then
			UIErrorsFrame:AddMessage("Breakable DeBuff Found, not attacking", 0, 0, 1, 1.0, UIERRORS_HOLD_TIME);

			return;
		end
	end

	--Casts Spell if Spell Attack is active
	SmartPetSpellAttack();

	if  (not (pet == nil) and not ( UnitIsDead("pet") ) )then

		-- check for PVP Ability toggle
		SmartPet_StartPVP();

		--Assist Other.  If target is assistable player then we will have pet assist them
		if  ( UnitIsPlayer("target") ) and ( UnitCanCooperate("player", "target")) and (UnitIsEnemy("player", "targettarget")) and  not (UnitIsDead("targettarget") ) then
			player = target;
			AssistUnit("target");
			target = UnitName("target");

			if (target == nil) then
				return;
			end

			if not (UnitCanAttack("player", "target")) then
				return;
			end
			message = SetMessage(pet, target, player, "assist_other");
		
		elseif (UnitCanAttack("player", "target")) then
		
			-- Assist Player
			if UnitIsTappedByPlayer("target") then
				message = SetMessage(pet, target, "me", "assist_me");

			-- Attack Mob
			else
				message = SetMessage(pet, target, "none", "attack");
			end

		end

		if (UnitExists("target") and UnitCanAttack("player", "target") ) then
			
			if not ( UnitIsDead("target") ) then
				SmartPet_AddDebugMessage("Attack", "spew");
				SmartPet_AddDebugMessage(SmartPet_Vars.lastAttack, "spew");

				SmartPet_AddDebugMessage(SmartPet_Config.AlertTimeout, "spew");

			-- Check Alert
				if (SmartPet_Config.Alert and ((GetTime() - SmartPet_Vars.lastAttack) > SmartPet_Config.AlertTimeout)  ) then
					SmartPet_SendChatMessage(message,string.upper(SMARTPET_CHANNELS_DROPDOWN_LIST[SmartPet_Config.AlertChannel]),SmartPet_Config.AlertChannelNumber);
					SmartPet_Vars.lastAttack = GetTime();
				end

				Pre_SmartPet_PetAttack();
		
				--Check to see if we want to use Dash/Dive on attack start
				SmartPetChargeCheck();
			end
		else
			--Turns Pet Attack command into Pet Follow if no target is selected
			PetFollow();
		end
	end
end


--Casts a Selected Spell on attack command
function SmartPetChargeCheck()
	if ((SmartPet_Config.RushAttack) and (not SmartPet_Vars.InCombat))then
		local SkillToUse = "";
		SmartPet_AddDebugMessage("Trying to cast Dash/Dive", "spew");
		if (SmartPet_Actions["Dash"].id > 0) then
			SkillToUse = "Dash";
		elseif (SmartPet_Actions["Dive"].id > 0) then
			SkillToUse = "Dive";
		else
		SmartPet_AddDebugMessage("Dash/Dive Not Found", "spew");
			--SkillToUse = "";
			return;
		end
	
		local start, duration = GetSpellCooldown((SmartPet_Actions[SkillToUse].id), "Pet");
		if ( start == 0 and duration == 0) then
			CastSpell((SmartPet_Actions[SkillToUse].id), "Pet"); 
		end
	end

end

-- PVP Start Handler.  Checks to see if combat is PVP and optimises settings for it
function SmartPet_StartPVP()
	if ((UnitExists("target")) and (UnitIsPlayer("target")) and (UnitCanAttack("player", "target"))) then
		   if not (SmartPet_Vars.InPVP) then
			SmartPet_AddDebugMessage("Storing prePVP Settings", "spew");
			SmartPet_Vars.InPVP = true;
			SmartPet_Vars.UseTaunt = SmartPet_Config.UseTaunt;
			SmartPet_Vars.UseDetaunt = SmartPet_Config.UseDetaunt;
			SmartPet_Vars.AutoCower = SmartPet_Config.AutoCower;
			if (SmartPet_Config.UseTaunt) then
				SmartPet_ToggleUse(SmartPet_Actions["Taunt"].index);
			end
			if (SmartPet_Config.UseDetaunt) then
				SmartPet_ToggleUse(SmartPet_Actions["Detaunt"].index);
			end
			SmartPet_Config.AutoCower = false;
			--SmartPet_EnableAction("Burst");
			--SmartPet_EnableAction("Sustain");
		end
	end
end

-- PVP End Handler. Resets taunt variables to orginal config that was changed on entering PVP
function SmartPet_EndPVP()
	SmartPet_AddDebugMessage("Restoring to PrePVP conditions", "spew");
	SmartPet_Vars.InPVP = false;
		if (SmartPet_Vars.UseTaunt) then
			SmartPet_ToggleUse(SmartPet_Actions["Taunt"].index);
		end
		if (SmartPet_Vars.UseDetaunt) then 
			SmartPet_ToggleUse(SmartPet_Actions["Detaunt"].index);
		end
		if (SmartPet_Vars.AutoCower) then
			SmartPet_Config.AutoCower = true;
		end
end



function SmartPetAttack_OnEvent()


	if ( event == "PLAYER_REGEN_DISABLED") then
		SmartPet_CheckDebuff();
	end

	if ( event == "CHAT_MSG_SPELL_SELF_DAMAGE" or event == "CHAT_MSG_COMBAT_SELF_MISSES" or event == "CHAT_MSG_COMBAT_SELF_HITS") then
		SmartPet_CheckDebuff();
	elseif( event == "PLAYER_ENTER_COMBAT") then
		SmartPet_CheckDebuff();
	elseif( event == "PLAYER_LEAVE_COMBAT" ) then
		SmartPet_CheckDebuff();
	elseif( event == "PLAYER_REGEN_ENABLED") then
		SmartPet_CheckDebuff();
	elseif( event == "PLAYER_REGEN_DISABLED") then
		SmartPet_CheckDebuff();
	elseif( event == "SPELLCAST_START") then
		SmartPet_CheckDebuff();
	elseif( event == "SPELLCAST_STOP") then
		SmartPet_CheckDebuff();
	elseif( event == "PLAYER_TARGET_CHANGED") then
		SmartPet_CheckDebuff();
	elseif( event == "START_AUTOREPEAT_SPELL") then
		SmartPet_CheckDebuff();
	elseif( event == "STOP_AUTOREPEAT_SPELL") then
		SmartPet_CheckDebuff();
	elseif( event == "PLAYER_CONTROL_LOST") then
		SmartPet_CheckDebuff();
	elseif( event == "PLAYER_CONTRL_GAINED") then
		SmartPet_CheckDebuff();
	elseif( event == "UI_ERROR_MESSAGE") then
		SmartPet_CheckDebuff();
	end

end

function SmartPetAttack_OnLoad()
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	this:RegisterEvent("PLAYER_CONTROL_LOST");
	this:RegisterEvent("UI_ERROR_MESSAGE");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
	this:RegisterEvent("VARIABLES_LOADED");
end

-- Checks for debufs on the target
function SmartPet_CheckDebuff()
	unit = "target";
	SmartPetTip:ClearLines();

		for j = 1, 10 do
		local msg = "";	

			if (UnitDebuff(unit,j)) then
			SmartPetTip:SetUnitDebuff(unit, j);
			msg = SmartPetTipTextLeft1:GetText();
			--UIErrorsFrame:AddMessage(msg, 0, 0, 1, 1.0, 2);	
				for i = 1, getn(SMARTPET_NOATTACK), 1 do			
					if (msg == SMARTPET_NOATTACK[i]) then
						--UIErrorsFrame:AddMessage("Debuf found", 0, 0, 1, 1.0, 1);
						return "true";
					end
				end
			elseif (not UnitDebuff(unit,j)) then
				pop = 0;
				break;
			end

		end
end

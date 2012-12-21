--[[
 Combat Caller
    By Alex Brazie
  
  Automates Low-HP and Out-Of-Mana calls

  This was written for testing of the shared
  configuration module I'm writing. 
  (But first, I need a module to configure!) 
  
  ]]--

-- Modded by Arys 02-02-05
-- Changed limit sliders to move at 5% increments and range from 10%-90%
-- Force a minimum cooldown of 1 second even when disabled

-- These will be the values with checkboxes
CombatCaller_HealthCall = true;
CombatCaller_ManaCall = true;
CombatCaller_Cooldown = true; 

-- These will be the variable variables. ;)
CombatCaller_HealthRatio = .4;
CombatCaller_HealthLimit = 100;
CombatCaller_ManaRatio = .3;
CombatCaller_ManaLimit = 150;
CombatCaller_CooldownTime = 30;

function CombatCaller_OnLoad() 
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	
	this.hp = -1;
	this.mana = -1;
	this.lasthp = -1;
	this.lastmana = -1;
	this.InCombat = 0;
	this.IsGhost = 0;
	this.LastHPShout = 0;
	this.LastManaShout = 0;

	if ( UltimateUI_RegisterConfiguration ) then
	-- Register with the UltimateUIMaster
	UltimateUI_RegisterConfiguration(
		"UUI_COMCALLER",
		"SECTION",
		COMBATC_SEP,
		COMBATC_SEP_INFO
		);
	UltimateUI_RegisterConfiguration(
		"UUI_COMCALLER_HEADER",
		"SEPARATOR",
		COMBATC_SEP,
		COMBATC_SEP_INFO
		);
 	UltimateUI_RegisterConfiguration(
 		"UUI_COMCALLER_HEALTHSLIMIT", --CVar
 		"BOTH",									 --Things to use
 		COMBATC_HEALTH,			 --Simple String
 		COMBATC_HEALTH_INFO,
 												 --Description 
 		CombatCaller_OnHealthConfigUpdate,		 --Callback
 		0,										 --Default Checked/Unchecked
 		.2,										 --Default Value
 		.1,										 --Min value
 		.9,									 --Max value
 		COMBATC_HEALTH_LIMIT,					 --Slider Text
 		.05,									 --Slider Increment
 		1,										 --Slider state text on/off
 		"\%",									 --Slider state text append
 		100										 --Slider state text multiplier 
 		);
 	UltimateUI_RegisterConfiguration(
 		"UUI_COMCALLER_MANASLIMIT", 
 		"BOTH", 
 		COMBATC_MANA, 
 		COMBATC_MANA_INFO,
 												 --Description 
 		CombatCaller_OnManaConfigUpdate,
 		0,
 		.2, 
 		.1, 
 		.9, 
 		COMBATC_MANA_LIMIT, 
 		.05, 
 		1, 
 		"\%",
 		100
 		);
 	UltimateUI_RegisterConfiguration(
 		"UUI_COMCALLER_COOLDOWN", 
 		"SLIDER", 
 		COMBATC_COOL, 
 		COMBATC_COOL_INFO,
 												 --Description 
 		CombatCaller_OnCooldownUpdate,
 		1, 
 		30, 
 		1, 
 		60, 
 		COMBATC_COOL_LIMIT, 
 		1, 
 		1, 
 		COMBATC_COOL_SEC,
 		1	
 		);
 	end
end

function CombatCaller_OnEvent(event) 
	if ( UnitIsDeadOrGhost("player") ) then
		this.IsGhost = 1;
		return;
	elseif ( this.IsGhost == 1 ) then
		this.hp = UnitHealth("player");
		this.lasthp = this.hp;
		this.mana = UnitMana("player");
		this.lastmana = this.mana;
		this.IsGhost = 0;
		this.InCombat = 0;
		return;
	end
	if (event == "PLAYER_ENTER_COMBAT") then
		this.InCombat = 1;
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		this.InCombat = 0;
	end
	if( this.InCombat == 0 ) then
		return;
	end
	if ( event == "UNIT_HEALTH" ) then
		local ratio = UnitHealth("player")/UnitHealthMax("player");
		local oldratio = this.lasthp/UnitHealthMax("player");

		
		if ( (this.hp < this.lasthp) and 
		     (ratio < CombatCaller_HealthRatio) and 
		     (GetTime() - this.LastHPShout > CombatCaller_CooldownTime) and
		     (oldratio > CombatCaller_HealthRatio)) then
			CombatCaller_ShoutLowHealth();
			this.LastHPShout = GetTime();
		end
		
		this.lasthp = this.hp;
		this.hp = UnitHealth("player");
	end
	if ( event == "UNIT_MANA" ) then
		if(UnitPowerType("player") ~= 0) then
		  this.lastmana = 0;
		else 
		  local ratio = UnitMana("player")/UnitManaMax("player");
		  local oldratio = this.lastmana/UnitManaMax("player");

		  if ( (this.mana < this.lastmana) and 
		       (ratio < CombatCaller_ManaRatio) and 
		       (GetTime() - this.LastManaShout > CombatCaller_CooldownTime) and
		       (oldratio > CombatCaller_ManaRatio) ) then
			CombatCaller_ShoutLowMana();
			this.LastManaShout = GetTime();
		  end
	  
		  this.lastmana = this.mana;
		  this.mana = UnitMana("player");
		end
	end
end

function CombatCaller_OnHealthConfigUpdate(toggle, value) 
	if ( toggle == 0 ) then
		CombatCaller_HealthCall = false;
	else 
		CombatCaller_HealthCall = true;
		CombatCaller_HealthRatio = value;
	end
end

function CombatCaller_OnManaConfigUpdate(toggle, value) 
	if ( toggle == 0 ) then
		CombatCaller_ManaCall = false;
	else 
		CombatCaller_ManaCall = true;
		CombatCaller_ManaRatio = value;
	end
end
function CombatCaller_OnCooldownUpdate(toggle, value) 
	CombatCaller_Cooldown = true; 
	CombatCaller_CooldownTime = value;
end

function CombatCaller_ShoutLowHealth()
	if ( CombatCaller_HealthCall and this.InCombat == 1 ) then
		DoEmote("HEALME");
	end
end

function CombatCaller_ShoutLowMana()
	if ( CombatCaller_ManaCall and this.InCombat == 1 ) then
		DoEmote("OUTOFMANA");
	end
end

function CombatCaller_TurnOff()
	CombatCaller_HealthCall = false;
	CombatCaller_ManaCall = false;
end

function CombatCaller_TurnOn()
	CombatCaller_HealthCall = true;
	CombatCaller_ManaCall = true;
end

	

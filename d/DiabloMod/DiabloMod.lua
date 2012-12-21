DiabloMod_Combat = false;
function DiabloMod_OnLoad()
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_RUNIC_POWER");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	MainMenuBarArtFrame:RegisterEvent('KNOWN_CURRENCY_TYPES_UPDATE')
	MainMenuBarArtFrame:RegisterEvent('CURRENCY_DISPLAY_UPDATE') 
end  
function DiabloMod_AdjustOrbs()
	local healthPercent = (UnitHealth("player")/UnitHealthMax("player"));
	DiabloMod_HealthText:SetText(UnitHealth("player").." / ".. UnitHealthMax("player"));
	DiabloMod_RedOrb:SetHeight(healthPercent*86);
	DiabloMod_RedOrb:SetTexCoord(0, 1, 1-healthPercent, 1);
	local manaPercent = (UnitMana("player")/UnitManaMax("player"));
	DiabloMod_ManaText:SetText(UnitMana("player").." / ".. UnitManaMax("player"));
	DiabloMod_BlueOrb:SetHeight(manaPercent*86);
	DiabloMod_BlueOrb:SetTexCoord(0, 1, 1-manaPercent, 1);
end        
function DiabloMod_OnEvent(event)
	if (event=="PLAYER_ENTERING_WORLD") then 
		DiabloMod_InitialiseOrbs();
		DiabloMod_AdjustOrbs();
		return;
	end 
	if (event=="PLAYER_REGEN_DISABLED") then 
		DiabloMod_Combat = true;
	end 
	if (event=="PLAYER_REGEN_ENABLED") then 
		DiabloMod_Combat = false;
	end 
	if (event=="UNIT_DISPLAYPOWER") then 
		DiabloMod_InitialiseOrbs();
		DiabloMod_AdjustOrbs();
		return;
	end
	if (event=="UNIT_HEALTH") then 
		local healthPercent = (UnitHealth("player")/UnitHealthMax("player"));
		DiabloMod_HealthText:SetText(UnitHealth("player").." / ".. UnitHealthMax("player"));
		DiabloMod_RedOrb:SetHeight(healthPercent*86);
		DiabloMod_RedOrb:SetTexCoord(0, 1, 1-healthPercent, 1);
		return;
	end
	if (event=="UNIT_MANA" or event=="UNIT_RAGE" or event=="UNIT_ENERGY" or event=="UNIT_RUNIC_POWER" ) then    
		local manaPercent = (UnitMana("player")/UnitManaMax("player"));
		DiabloMod_ManaText:SetText(UnitMana("player").." / ".. UnitManaMax("player"));
		DiabloMod_BlueOrb:SetHeight(manaPercent*86);
		DiabloMod_BlueOrb:SetTexCoord(0, 1, 1-manaPercent, 1);
		return;
	end
end
function DiabloMod_InitialiseOrbs()
	DiabloMod_HealthText:SetText(UnitHealth("player").." / ".. UnitHealthMax("player")); 
	--DiabloMod_RedOrb:SetVertexColor(0.85,0.2,0.2);
	DiabloMod_RedOrb:SetVertexColor(1.0,0.2,0.2);        
	--DiabloMod_RedOrb:SetAlpha(0.95);
	DiabloMod_RedOrb:SetTexCoord(0, 1, 0, 1);
	local powerType = UnitPowerType("player");
	DiabloMod_ManaText:SetText(UnitMana("player").." / ".. UnitManaMax("player"));
	if (powerType == 0) then -- Mana
		DiabloMod_BlueOrb:SetVertexColor(0.2,0.2,1.0);
		--DiabloMod_BlueOrb:SetAlpha(0.95);
		DiabloMod_BlueOrb:SetTexCoord(0, 1, 0, 1); 
	end
	if (powerType == 1) then -- Rage
		DiabloMod_BlueOrb:SetVertexColor(0.75,0.15,0.15);
		--DiabloMod_BlueOrb:SetAlpha(0.95);
		DiabloMod_BlueOrb:SetTexCoord(0, 1, 0, 1); 
	end
	if (powerType == 3) then -- Energy
		DiabloMod_BlueOrb:SetVertexColor(1.0,0.75,0);
		--DiabloMod_BlueOrb:SetAlpha(0.95);
		DiabloMod_BlueOrb:SetTexCoord(0, 1, 0, 1); 
	end
	if (powerType == 6) then -- Runic_Power
		DiabloMod_BlueOrb:SetVertexColor(0.2,0.75,1.0);
		--DiabloMod_BlueOrb:SetAlpha(0.95);
		DiabloMod_BlueOrb:SetTexCoord(0, 1, 0, 1); 
	end
end
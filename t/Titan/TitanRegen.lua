TITAN_REGEN_ID			= "TitanRegen"
TITAN_REGEN_HP_FORMAT = "%d";
TITAN_REGEN_HP_FORMAT_PERCENT = "%.2f";
TITAN_REGEN_MP_FORMAT = "%d";
TITAN_REGEN_MP_FORMAT_PERCENT = "%.2f";

TITAN_Regen_FREQUENCY = 1;
TITAN_RegenCurrHealth = 0;
TITAN_RegenCurrMana = 0;
TITAN_RegenMP	    = 0;
TITAN_RegenHP	    = 0;
TITAN_RegenCheckedManaState = 0;
TITAN_RegenMaxHPRate = 0;
TITAN_RegenMinHPRate = 9999;
TITAN_RegenMaxMPRate = 0;
TITAN_RegenMinMPRate = 9999;
TITAN_RegenMPDuringCombat = 0;
TITAN_RegenMPCombatTrack = 0;

function TitanPanelTitanRegenButton_OnLoad()
	this.registry = { 
		id = TITAN_REGEN_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_REGEN_MENU_TEXT, 
		buttonTextFunction = "TitanPanelTitanRegenButton_GetButtonText",
		tooltipTitle = TITAN_REGEN_MENU_TOOLTIP_TITLE, 
		tooltipTextFunction = "TitanPanelTitanRegenButton_GetTooltipText",
		savedVariables = {
			ShowLabelText = 1,
			ShowMPRegen = 1,
			ShowHPRegen = 1,
			ShowPercentage = TITAN_NIL,
			ShowColoredText = TITAN_NIL
		}

	};

	this.timer = 0;	
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
end

function TitanPanelTitanRegenButton_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD") then
		if (UnitManaMax("player") == 0) then
			TitanSetVar(TITAN_REGEN_ID, "ShowMPRegen", 0);
		end
	end
	
	if ( event == "PLAYER_REGEN_DISABLED") then
		TITAN_RegenMPDuringCombat = 0;
		TITAN_RegenMPCombatTrack = 1;
	end

	if ( event == "PLAYER_REGEN_ENABLED") then
		TITAN_RegenMPCombatTrack = 0;
	end
	
	local currHealth = 0;
	local currMana = 0;
	local runUpdate = 0;
	
	if (TitanGetVar(TITAN_REGEN_ID,"ShowHPRegen") == 1) then
		if ( event == "UNIT_HEALTH" and arg1 == "player" ) then
			currHealth = UnitHealth("player");
			runUpdate = 1;
			if ( currHealth > TITAN_RegenCurrHealth and TITAN_RegenCurrHealth ~= 0 ) then
				TITAN_RegenHP = currHealth-TITAN_RegenCurrHealth;
				
				if (TITAN_RegenHP > TITAN_RegenMaxHPRate) then 
					TITAN_RegenMaxHPRate = TITAN_RegenHP;
				end
				if (TITAN_RegenHP < TITAN_RegenMinHPRate or TITAN_RegenMinHPRate == 9999) then 
					TITAN_RegenMinHPRate = TITAN_RegenHP;
				end				
			end
			TITAN_RegenCurrHealth = currHealth;
		end
	end

	if (TitanGetVar(TITAN_REGEN_ID,"ShowMPRegen") == 1) then
		if ( event == "UNIT_MANA" and arg1 == "player" ) then
			currMana = UnitMana("player");
			runUpdate = 1;
			if ( currMana  > TITAN_RegenCurrMana and TITAN_RegenCurrMana ~= 0 ) then
				TITAN_RegenMP = currMana-TITAN_RegenCurrMana;

				if (TITAN_RegenMPCombatTrack == 1) then
					TITAN_RegenMPDuringCombat = TITAN_RegenMPDuringCombat + TITAN_RegenMP;
				end 

				if (TITAN_RegenMP > TITAN_RegenMaxMPRate) then 
					TITAN_RegenMaxMPRate = TITAN_RegenMP;
				end
				if (TITAN_RegenMP < TITAN_RegenMinMPRate or TITAN_RegenMinMPRate == 9999) then 
					TITAN_RegenMinMPRate = TITAN_RegenMP;
				end								
			end
			TITAN_RegenCurrMana = currMana;
		end
	end			
	
	if (runUpdate == 1) then
		TitanPanelButton_UpdateButton(TITAN_REGEN_ID);
		TitanPanelButton_UpdateTooltip();
	end
end

function TitanPanelTitanRegenButton_GetButtonText(id)
	local labelTextHP = "";
	local valueTextHP = "";
	local labelTextMP = "";
	local valueTextMP = "";
	local OutputStr = "";
	
	if UnitHealth("player") == UnitHealthMax("player") then
		TITAN_RegenHP = 0;
	end
	if UnitMana("player") == UnitManaMax("player") then
		TITAN_RegenMP = 0;
	end	
			
	-- safety in case both are off, then cant ever turn em on
	if (TitanGetVar(TITAN_REGEN_ID,"ShowHPRegen") == nil and TitanGetVar(TITAN_REGEN_ID,"ShowMPRegen") == nil) then
		TitanSetVar(TITAN_REGEN_ID,"ShowHPRegen",1);
	end
	
	if (TitanGetVar(TITAN_REGEN_ID,"ShowHPRegen") == 1) then
		labelTextHP = "HP: ";
		if (TitanGetVar(TITAN_REGEN_ID,"ShowPercentage") == 1) then
			valueTextHP = format(TITAN_REGEN_HP_FORMAT_PERCENT, (TITAN_RegenHP/UnitHealthMax("player"))*100);
		else
			valueTextHP = format(TITAN_REGEN_HP_FORMAT, TITAN_RegenHP);	
		end
		if (TitanGetVar(TITAN_REGEN_ID, "ShowColoredText")) then
			valueTextHP = TitanUtils_GetGreenText(valueTextHP);
		else
			valueTextHP = TitanUtils_GetHighlightText(valueTextHP);
		end		
	end
	
	if (TitanGetVar(TITAN_REGEN_ID,"ShowMPRegen") == 1) then
		labelTextMP = "MP: ";
		if (TitanGetVar(TITAN_REGEN_ID,"ShowPercentage") == 1) then
			valueTextMP = format(TITAN_REGEN_MP_FORMAT_PERCENT, (TITAN_RegenMP/UnitManaMax("player"))*100);
		else
			valueTextMP = format(TITAN_REGEN_MP_FORMAT, TITAN_RegenMP);			
		end
		if (TitanGetVar(TITAN_REGEN_ID, "ShowColoredText")) then
			valueTextMP = TitanRegenTemp_GetColoredTextRGB(valueTextMP, 0.0, 0.0, 1.0);
		else
			valueTextMP = TitanUtils_GetHighlightText(valueTextMP);
		end			
	end

	-- supports turning off labels
	return labelTextHP, valueTextHP, labelTextMP, valueTextMP;
end

function TitanPanelTitanRegenButton_GetTooltipText()

	local minHP = TITAN_RegenMinHPRate;
	local minMP = TITAN_RegenMinMPRate;
	
	if minHP == 9999 then minHP = 0 end;
	if minMP == 9999 then minMP = 0 end;	

	if (TitanGetVar(TITAN_REGEN_ID,"ShowMPRegen") == 1) then
		local regenPercent;		
		regenPercent = (TITAN_RegenMPDuringCombat/UnitManaMax("player"))*100;
		
		return ""..
			format(TITAN_REGEN_TOOLTIP1, UnitHealth("player"),UnitHealthMax("player"),UnitHealthMax("player")-UnitHealth("player")).."\n"..
			format(TITAN_REGEN_TOOLTIP2, UnitMana("player"),UnitManaMax("player"),UnitManaMax("player")-UnitMana("player")).."\n"..
			format(TITAN_REGEN_TOOLTIP3, TITAN_RegenMaxHPRate).."\n"..
			format(TITAN_REGEN_TOOLTIP4, minHP).."\n"..
			format(TITAN_REGEN_TOOLTIP5, TITAN_RegenMaxMPRate).."\n"..
			format(TITAN_REGEN_TOOLTIP6, minMP).."\n"..
			format(TITAN_REGEN_TOOLTIP7, TITAN_RegenMPDuringCombat, regenPercent).."\n"			
			;				
	else
		return ""..
			format(TITAN_REGEN_TOOLTIP1, UnitHealth("player"),UnitHealthMax("player"),UnitHealthMax("player")-UnitHealth("player")).."\n"..
			format(TITAN_REGEN_TOOLTIP3, TITAN_RegenMaxHPRate).."\n"..
			format(TITAN_REGEN_TOOLTIP4, minHP).."\n"
			;				
	end
end

function TitanPanelRightClickMenu_PrepareTitanRegenMenu()
	local id = TITAN_REGEN_ID;
	local info;

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);
			
	info = {};
	info.text = TITAN_REGEN_MENU_SHOW2;
	info.func = TitanRegen_ShowHPRegen;
	info.checked = TitanGetVar(TITAN_REGEN_ID,"ShowHPRegen");
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_REGEN_MENU_SHOW3;
	info.func = TitanRegen_ShowMPRegen;
	info.checked = TitanGetVar(TITAN_REGEN_ID,"ShowMPRegen");
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_REGEN_MENU_SHOW4;
	info.func = TitanRegen_ShowPercentage;
	info.checked = TitanGetVar(TITAN_REGEN_ID,"ShowPercentage");
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	
	info = {};
	info.text = TITAN_PANEL_MENU_SHOW_COLORED_TEXT;
	info.func = TitanRegen_ShowColoredText;
	info.checked = TitanGetVar(TITAN_REGEN_ID, "ShowColoredText");
	UIDropDownMenu_AddButton(info);		
	
	TitanPanelRightClickMenu_AddToggleLabelText("TitanRegen");
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);	
end

function TitanRegen_UpdateSettings()	
	-- safety in case both are off, then cant ever turn em on
	if (TitanGetVar(TITAN_REGEN_ID,"ShowHPRegen") == nil and TitanGetVar(TITAN_REGEN_ID,"ShowMPRegen") == nil) then
		TitanSetVar(TITAN_REGEN_ID,"ShowHPRegen",1);
	end
	TitanPanelButton_UpdateButton(TITAN_REGEN_ID);
end

function TitanRegen_ShowHPRegen()
	TitanToggleVar(TITAN_REGEN_ID, "ShowHPRegen");
	TitanRegen_UpdateSettings();
end

function TitanRegen_ShowMPRegen()
	TitanToggleVar(TITAN_REGEN_ID, "ShowMPRegen");
	TitanRegen_UpdateSettings();
end

function TitanRegen_ShowPercentage()
	TitanToggleVar(TITAN_REGEN_ID, "ShowPercentage");
	TitanRegen_UpdateSettings();
end

function TitanRegen_ShowColoredText()
	TitanToggleVar(TITAN_REGEN_ID, "ShowColoredText");
	TitanRegen_UpdateSettings();
end

function TitanRegenTemp_GetColoredTextRGB(text, r, g, b)
	if (text and r and g and b) then
		local redColorCode = format("%02x", r * 255);		
		local greenColorCode = format("%02x", g * 255);
		local blueColorCode = format("%02x", b * 255);		
		local colorCode = "|cff"..redColorCode..greenColorCode..blueColorCode;
		return colorCode..text..FONT_COLOR_CODE_CLOSE;
	end
end
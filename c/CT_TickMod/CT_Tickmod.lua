CT_CurrHealth = 0;
CT_CurrMana = 0;

-- Titan stuff
CT_TickMod_LastHP = 0;
CT_TickMod_LastMP = 0;
CT_TICKMOD_TITAN_BUTTONTEXT_HP = "HP/Tick: |c00FFFFFF%s|r";
CT_TICKMOD_TITAN_BUTTONTEXT_MP = "MP/Tick: |c00FFFFFF%s|r";
CT_TickMod_Titan_ShowHP = 1;
CT_TickMod_Titan_ShowMP = 1;
CT_TickMod_Titan_HideFrame = nil;

if ( CT_AddMovable ) then
	CT_AddMovable("CT_TicksFrame", CT_TICKMOD_MOVABLE, "RIGHT", "LEFT", "Minimap", -14, 67);
end

function CT_TickMod_Print(msg, r, g, b)
	if ( CT_Print ) then
		CT_Print(msg, r, g, b);
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
	end
end

if ( CT_RegisterMod ) then

	--Start of Function Mod

	tbfunc = function (modId)
		local val = CT_Mods[modId]["modStatus"];
		if ( val == "on" ) then
			CT_TickMod_Print("<CTMod> " .. CT_TICBORDER_ON, 1, 1, 0);
			CT_TicksFrame:SetBackdropColor(0, 0.1, 0.9, 0.25);
			CT_TicksFrame:SetBackdropBorderColor(1, 1, 1, 0.5);
		else
			CT_TickMod_Print("<CTMod> " .. CT_TICBORDER_OFF, 1, 1, 0);
			CT_TicksFrame:SetBackdropColor(1, 1, 1, 0);
			CT_TicksFrame:SetBackdropBorderColor(1, 1, 1, 0);
		end
	end

	function tbinitfunc(modId)
		local val = CT_Mods[modId]["modStatus"];
		if ( val == "on" ) then
			CT_TickMod_HideBorder = nil;
			CT_TicksFrame:SetBackdropColor(0, 0.1, 0.9, 0.25);
			CT_TicksFrame:SetBackdropBorderColor(1, 1, 1, 0.5);
		else
			CT_TickMod_HideBorder = 1;
			CT_TicksFrame:SetBackdropColor(1, 1, 1, 0);
			CT_TicksFrame:SetBackdropBorderColor(1, 1, 1, 0);
		end
	end

	--End of Function Mod

	tickfunction = function (modId)
		local val = CT_Mods[modId]["modStatus"]
		if ( val == "on" ) then
			CT_TickMod_Print("<CTMod> " .. CT_TICKMOD_ON, 1.0, 1.0, 0.0);
			CT_TicksFrame:Show();
		else
			CT_TicksFrame:Hide();
			CT_TickMod_Print("<CTMod> " .. CT_TICKMOD_OFF, 1.0, 1.0, 0.0);
		end
	end

	function tickInitFunction(modId)
		local val = CT_Mods[modId]["modStatus"];
		if ( val == "on" ) then
			CT_TicksFrame:Show();
		else
			CT_TicksFrame:Hide();
		end
	end

	CT_RegisterMod(CT_TICKMOD_MODNAME, CT_TICKMOD_SUBNAME, 4, "Interface\\Icons\\Spell_Nature_HealingTouch", CT_TICKMOD_TOOLTIP, "off", nil, tickfunction, tickInitFunction);

	--Start of Registration Mod

	CT_RegisterMod(CT_TICBORDER_MODNAME,
		CT_TICBORDER_SUBNAME,
		4,
		"Interface\\Icons\\Spell_Nature_HealingTouch",
		CT_TICBORDER_TOOLTIP,
		"on",
		nil,
		tbfunc,
		tbinitfunc
	);
else
	SlashCmdList["TICKMOD"] = function(msg)
		if ( msg == "hide border" ) then
			CT_TickMod_HideBorder = 1;
			CT_TicksFrame:SetBackdropColor(1, 1, 1, 0);
			CT_TicksFrame:SetBackdropBorderColor(1, 1, 1, 0);
		elseif ( msg == "show border" ) then
			CT_TickMod_HideBorder = nil;
			CT_TicksFrame:SetBackdropColor(0, 0.1, 0.9, 0.25);
			CT_TicksFrame:SetBackdropBorderColor(1, 1, 1, 0.5);
		elseif ( msg == "hide" ) then
			CT_TickMod_Titan_HideFrame = 1;
			CT_TicksFrame:Hide();
		elseif ( msg == "show" ) then
			CT_TickMod_Titan_HideFrame = nil;
			CT_TicksFrame:Show();
		else
			CT_TickMod_Print("You can use the following commands to customize CT_TickMod:", 1, 1, 0);
			CT_TickMod_Print("|c00FFFFFF/tickmod hide|r - Hides the TickMod frame", 1, 1, 0);
			CT_TickMod_Print("|c00FFFFFF/tickmod show|r - Shows the TickMod frame", 1, 1, 0);
			CT_TickMod_Print("|c00FFFFFF/tickmod hide border|r - Hides the TickMod border", 1, 1, 0);
			CT_TickMod_Print("|c00FFFFFF/tickmod show border|r - Shows the TickMod border", 1, 1, 0);
			CT_TickMod_Print("You can substitute |c00FFFFFF/tickmod|r with |c00FFFFFF/tm|r.", 1, 1, 0);
		end
	end
	SLASH_TICKMOD1 = "/tickmod";
	SLASH_TICKMOD2 = "/tm";
	CT_TickMod_Print("CT_TickMod loaded. Type /tickmod for more information.", 1, 1, 0);
end
		
	


--End of Registration Mod

function CT_TickMod_FadeMana()
	if ( this.alphamana <= 0.25 ) then return; end
	this.alphamana = this.alphamana - 0.0075;
	CT_TicksMana:SetAlpha(this.alphamana);
end

function CT_TickMod_FadeHealth()
	if ( this.alphahealth <= 0.25 ) then return; end
	this.alphahealth = this.alphahealth - 0.0075;
	CT_TicksHealth:SetAlpha(this.alphahealth);
end

function CT_TickMod_Fade(elapsed)
	this.update = this.update + elapsed;
	if ( this.update >= 0.01 ) then
		this.update = this.update - 0.01;
		CT_TickMod_FadeMana();
		CT_TickMod_FadeHealth();
	end
end

function CT_TickMod_OnEvent(event)
	if ( event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" and arg1 == "player" ) then
		local curr = UnitHealth("player");
		if ( curr > CT_CurrHealth and CT_CurrHealth ~= 0 ) then
			CT_TicksHealth:SetText("HP/Tick: |c00FFFFFF" .. curr-CT_CurrHealth .. "|r");
			CT_TickMod_LastHP = curr-CT_CurrHealth;
			CT_TicksFrame.alphahealth = 1;
			CT_TicksHealth:SetAlpha(1);
		end
		CT_CurrHealth = curr;
	end
	if ( event == "UNIT_MANA" or event == "UNIT_MAXMANA" and arg1 == "player" ) then
		local curr = UnitMana("player");
		if ( curr > CT_CurrMana and CT_CurrMana ~= 0 ) then
			CT_TicksMana:SetText("MP/Tick: |c00FFFFFF" .. curr-CT_CurrMana .. "|r");
			CT_TickMod_LastMP = curr-CT_CurrMana;
			CT_TicksFrame.alphamana = 1;
			CT_TicksMana:SetAlpha(1);
		end
		CT_CurrMana = curr;
	end
	if ( event == "VARIABLES_LOADED" ) then
		local class, eClass = UnitClass("player");
		if ( UnitPowerType("player") > 0 and eClass ~= "DRUID" ) then
			CT_TicksMana:Hide();
			CT_TicksFrame:SetHeight(25); -- Decrease height
		end
		if ( CT_TickMod_Titan_HideFrame ) then
			CT_TicksFrame:Hide();
		end
		if ( CT_TickMod_HideBorder ) then
			CT_TicksFrame:SetBackdropColor(1, 1, 1, 0);
			CT_TicksFrame:SetBackdropBorderColor(1, 1, 1, 0);
		else
			CT_TicksFrame:SetBackdropColor(0, 0.1, 0.9, 0.25);
			CT_TicksFrame:SetBackdropBorderColor(1, 1, 1, 0.5);
		end
	end
end

function CT_TickMod_OnEnter()
	if ( not CT_RegisterMod or CT_MF_ShowFrames ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText("Click to drag");
	end
end

function TitanPanelRegenButton_OnLoad()
	this.registry={
		id="Regen",
		menuText="CT_Regen",
		buttonTextFunction="TitanPanelRegenButton_GetButtonText",
		frequency=0.1,
	};
end

function TitanPanelRegenButton_GetButtonText()
	local str = "";
	if ( CT_TickMod_Titan_ShowHP ) then
		if ( type(CT_TickMod_LastHP) == "number" ) then
			if ( CT_TickMod_LastHP < 10 ) then
				CT_TickMod_LastHP = "  " .. CT_TickMod_LastHP;
			elseif ( CT_TickMod_LastHP < 100 ) then
				CT_TickMod_LastHP = " " .. CT_TickMod_LastHP;
			else
				CT_TickMod_LastHP = tostring(CT_TickMod_LastHP);
			end
		end
		str = format(CT_TICKMOD_TITAN_BUTTONTEXT_HP, CT_TickMod_LastHP);
	end
	if ( CT_TickMod_Titan_ShowMP ) then
		if ( type(CT_TickMod_LastMP) == "number" ) then
			if ( CT_TickMod_LastMP < 10 ) then
				CT_TickMod_LastMP = "  " .. CT_TickMod_LastMP;
			elseif ( CT_TickMod_LastMP < 100 ) then
				CT_TickMod_LastMP = " " .. CT_TickMod_LastMP;
			else
				CT_TickMod_LastMP = tostring(CT_TickMod_LastMP);
			end
		end
		if ( strlen(str) > 0 ) then
			str = str .. "  ";
		end
		str = str .. format(CT_TICKMOD_TITAN_BUTTONTEXT_MP, CT_TickMod_LastMP);
	end
	return str;
end

function TitanPanelRegenButton_ToggleHPDisplay()
	CT_TickMod_Titan_ShowHP = not CT_TickMod_Titan_ShowHP;
	if ( not CT_TickMod_Titan_ShowMP and not CT_TickMod_Titan_ShowHP ) then
		CT_TickMod_Titan_ShowHP = 1;
		TitanPanel_RemoveButton("Regen");
	end
	TitanPanelButton_UpdateButton("Regen");
end

function TitanPanelRegenButton_ToggleMPDisplay()
	CT_TickMod_Titan_ShowMP = not CT_TickMod_Titan_ShowMP;
	if ( not CT_TickMod_Titan_ShowMP and not CT_TickMod_Titan_ShowHP ) then
		CT_TickMod_Titan_ShowMP = 1;
		TitanPanel_RemoveButton("Regen");
	end
	TitanPanelButton_UpdateButton("Regen");
end

function TitanPanelRegenButton_ToggleShowFrame()
	CT_TickMod_Titan_HideFrame = not CT_TickMod_Titan_HideFrame;
	if ( CT_TickMod_Titan_HideFrame ) then
		CT_TicksFrame:Hide();
	else
		CT_TicksFrame:Show();
	end
end

function TitanPanelRightClickMenu_PrepareRegenMenu()
	local id = "Regen";
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);
	
	info = {};
	info.text = "Display HP Regen";
	info.func = TitanPanelRegenButton_ToggleHPDisplay;
	info.checked = CT_TickMod_Titan_ShowHP;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Display MP Regen";
	info.func = TitanPanelRegenButton_ToggleMPDisplay;
	info.checked = CT_TickMod_Titan_ShowMP;
	UIDropDownMenu_AddButton(info);
	info = {};

	info.text = "Hide CT Frame";
	info.func = TitanPanelRegenButton_ToggleShowFrame;
	info.checked = CT_TickMod_Titan_HideFrame;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
end

--[[

Titan Combat Info v1.52c by Aegean of Proudmoore...err...Muradin ;)

]]--

TITAN_COMBATINFO_TOGGLE_TABLE = {
	"ShowBlock","ShowCrit","ShowDodge","ShowParry","ShowStatLabel",
}

function TitanPanelCombatInfoButton_OnLoad()
	-- Register the addon with Titan Panel
	this.registry={
		id = TITAN_COMBATINFO_ID,
		menuText = TITAN_COMBATINFO_MENU_TEXT,
		buttonTextFunction = "TitanPanelCombatInfoButton_GetButtonText",
		tooltipTitle = TITAN_COMBATINFO_TOOLTIP,
		tooltipTextFunction = "TitanPanelCombatInfoButton_GetTooltipText",
		icon = TITAN_COMBATINFO_BUTTON_ICON,
		iconWidth = 16,
		savedVariables = {
			ShowBlock = TITAN_NIL,
			ShowCrit = TITAN_NIL,
			ShowDodge = TITAN_NIL,
			ShowParry = TITAN_NIL,
			ShowStatLabel = TITAN_NIL,
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};
	-- Register events
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_AURASTATE");
end

function TitanPanelCombatInfoButton_GetButtonText(id)
	-- monitored stat to display on bar
	local button, id = TitanUtils_GetButton(id, true);
	local buttonText = "";
	local displayText = "";
	
	if (TitanGetVar(TITAN_COMBATINFO_ID,"ShowLabelText")) then
		buttonText = TITAN_COMBATINFO_BUTTON_LABEL;
	end

	if (TitanGetVar(TITAN_COMBATINFO_ID,"ShowBlock")) then
		local blockChance = format(TITAN_COMBATINFO_BLOCK,GetBlockChance());
		displayText = format(TITAN_COMBATINFO_BUTTON_TEXT,blockChance);
		if (TitanGetVar(TITAN_COMBATINFO_ID,"ShowStatLabel")) then		
			buttonText = TITAN_COMBATINFO_BLOCK_TEXT;
		end
		button.registry.icon = TITAN_COMBATINFO_BLOCK_ICON;
	elseif (TitanGetVar(TITAN_COMBATINFO_ID,"ShowCrit")) then
		local critChance = format(TITAN_COMBATINFO_CRIT,GetCritChance());
		displayText = format(TITAN_COMBATINFO_BUTTON_TEXT,critChance);
		if (TitanGetVar(TITAN_COMBATINFO_ID,"ShowStatLabel")) then		
			buttonText = TITAN_COMBATINFO_CRIT_TEXT;
		end
		button.registry.icon = TITAN_COMBATINFO_CRIT_ICON;
	elseif (TitanGetVar(TITAN_COMBATINFO_ID,"ShowDodge")) then
		local dodgeChance = format(TITAN_COMBATINFO_DODGE,GetDodgeChance());
		displayText = format(TITAN_COMBATINFO_BUTTON_TEXT,dodgeChance);
		if (TitanGetVar(TITAN_COMBATINFO_ID,"ShowStatLabel")) then
			buttonText = TITAN_COMBATINFO_DODGE_TEXT;
		end
		button.registry.icon = TITAN_COMBATINFO_DODGE_ICON;
	elseif (TitanGetVar(TITAN_COMBATINFO_ID,"ShowParry")) then
		local parryChance = format(TITAN_COMBATINFO_PARRY,GetParryChance());
		displayText = format(TITAN_COMBATINFO_BUTTON_TEXT,parryChance);
		if (TitanGetVar(TITAN_COMBATINFO_ID,"ShowStatLabel")) then
			buttonText = TITAN_COMBATINFO_PARRY_TEXT;
		end
		button.registry.icon = TITAN_COMBATINFO_PARRY_ICON;
	else
		button.registry.icon = TITAN_COMBATINFO_BUTTON_ICON;
	end

	return buttonText.." "..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_BUTTON_TEXT,displayText));
end

function TitanPanelCombatInfoButton_GetTooltipText()
	-- local critChance = GetCritChance(); -- N/A at this time from Bliz API
	local critChance = GetCritChance();
	local blockChance = GetBlockChance();
	local dodgeChance = GetDodgeChance();
	local parryChance = GetParryChance();
	-- melee
	local meleeBase, meleePosBuff, meleeNegBuff = UnitAttackPower("player");
	local meleeMainSpeed, meleeOffSpeed = UnitAttackSpeed("player");
	local meleeOffHasWeapon = OffhandHasWeapon();
	local meleeMainLowDmg, meleeMainHiDmg, meleeOffLowDmg, meleeOffHiDmg, meleePosDmg, meleeNegDmg, percent = UnitDamage("player");
	local meleeMainAvgDmg = 0.0;
	local meleeOffAvgDmg = 0.0;
	local meleeOffhandText = "";
	-- melee dps average	
	meleeMainAvgDmg = ((meleeMainHiDmg + meleeMainLowDmg)*.5) / meleeMainSpeed;
	meleeMainHiDmg = ceil(meleeMainHiDmg);
	meleeMainLowDmg = floor(meleeMainLowDmg);
	-- offhand check
	if ( meleeOffSpeed == nil or meleeOffSpeed == 0 and not meleeOffHasWeapon) then
		meleeOffSpeed = 0.0;
		meleeOffLowDmg = 0;
		meleeOffHiDmg = 0;
	else
		meleeOffAvgDmg = ((meleeOffHiDmg + meleeOffLowDmg)*.5) / meleeOffSpeed;
		meleeOffHiDmg = ceil(meleeOffHiDmg);
		meleeOffLowDmg = floor(meleeOffLowDmg);
		meleeOffhandText = "\n"..
		TITAN_COMBATINFO_MELEE_OFFHANDSPEED_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_MELEE_OFFHANDSPEED,meleeOffSpeed)).."\n"..
		TITAN_COMBATINFO_MELEE_OFFHANDDMG_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_MELEE_OFFHANDDMG,meleeOffLowDmg,meleeOffHiDmg)).."\n"..
		TITAN_COMBATINFO_MELEE_OFFAVGDMG_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_MELEE_OFFAVGDMG,meleeOffAvgDmg)).."\n"
	end
	-- ranged
	local rangedAtkBase, rangedPosBuff, rangedNegBuff = UnitRangedAttackPower("player");
	local rangedBase, rangedModifier = UnitRangedAttack("player");
	local rangedSpeed, rangedLowDmg, rangedHiDmg = UnitRangedDamage("player");
	local baseDamage = (rangedLowDmg + rangedHiDmg) * 0.5;
	local fullDamage = (baseDamage + meleePosDmg + meleeNegDmg) * percent;
	local rangedAvgDmg = (max(fullDamage,1) / rangedSpeed);
	local rangedBonus = (fullDamage - baseDamage);
	rangedLowDmg = max(floor(rangedLowDmg + rangedBonus),1);
	rangedHiDmg = max(ceil(rangedHiDmg + rangedBonus),1);
	-- ranged	
	local rangedText = "";
	--local rangedAvgDmg = ((rangedHiDmg + rangedLowDmg)/2) / rangedSpeed;
	if (rangedSpeed > 0) then
		rangedText = ""..
		"\n"..TitanUtils_GetHighlightText(TITAN_COMBATINFO_RANGE_TEXT).." "..TitanUtils_GetHighlightText(format("(+%.1f dps)",(rangedAtkBase/TITAN_COMBATINFO_ATKPWR_MAGIC))).."\n"..
		TITAN_COMBATINFO_RANGEPWR_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_RANGEPWR,(rangedAtkBase + rangedPosBuff - rangedNegBuff),rangedAtkBase)).."\n"..
		TITAN_COMBATINFO_RANGEATTACKSPEED.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_RANGESPEED,rangedSpeed)).."\n"..
		TITAN_COMBATINFO_RANGEDMG_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_RANGEDMG,rangedLowDmg,rangedHiDmg)).."\n"..
		TITAN_COMBATINFO_RANGEAVGDMG_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_RANGEAVGDMG,rangedAvgDmg)).."\n"
	else
		rangedText = "";
	end
	
	-- armor
	local armorBase, armorEffective, armorList, armorPosBuff, armorNegBuff = UnitArmor("player");
	local armorReduction = armorEffective/((85 * UnitLevel("player")) + 400);
	armorReduction = 100 * (armorReduction/(armorReduction + 1));
	local armorText = ""..
		"\n"..TitanUtils_GetHighlightText("Armor").."\n"..
		TITAN_COMBATINFO_ARMOR_TEXT.."\t"..TitanUtils_GetHighlightText(armorEffective.." ("..armorBase.." base)").."\n"..
		"(Dmg vs. lvl "..UnitLevel("player").." attacker reduced "..format("%.1f%%",armorReduction)..")\n"

	return ""..
		TITAN_COMBATINFO_BLOCK_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_BLOCK,blockChance)).."\n"..
		TITAN_COMBATINFO_CRIT_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_CRIT,critChance)).."\n"..
		TITAN_COMBATINFO_DODGE_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_DODGE,dodgeChance)).."\n"..
		TITAN_COMBATINFO_PARRY_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_PARRY,parryChance)).."\n\n"..
		TitanUtils_GetHighlightText(TITAN_COMBATINFO_MELEE_TEXT).." "..TitanUtils_GetHighlightText(format("(+%.1f dps)",(max((meleeBase + meleePosBuff + meleeNegBuff),0)/TITAN_COMBATINFO_ATKPWR_MAGIC))).."\n"..
		TITAN_COMBATINFO_MELEE_POWER_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_MELEE_POWER,max(meleeBase + meleePosBuff + meleeNegBuff),meleeBase)).."\n"..
		TITAN_COMBATINFO_MELEE_MAINSPEED_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_MELEE_MAINSPEED,meleeMainSpeed)).."\n"..
		TITAN_COMBATINFO_MELEE_MAINDMG_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_MELEE_MAINDMG,meleeMainLowDmg,meleeMainHiDmg)).."\n"..
		TITAN_COMBATINFO_MELEE_MAINAVGDMG_TEXT.."\t"..TitanUtils_GetHighlightText(format(TITAN_COMBATINFO_MELEE_MAINAVGDMG,meleeMainAvgDmg)).."\n"..
		meleeOffhandText..
		rangedText..
		armorText.."\n";
end


function TitanPanelCombatInfoButton_OnUpdate()

end

function TitanPanelCombatInfoButton_ToggleDisplayBlock()
	TitanToggleVar(TITAN_COMBATINFO_ID,"ShowBlock");
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowCrit",TITAN_NIL);
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowDodge",TITAN_NIL);
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowParry",TITAN_NIL);
	TitanPanelButton_UpdateButton(TITAN_COMBATINFO_ID);
end

function TitanPanelCombatInfoButton_ToggleDisplayCrit()
	TitanToggleVar(TITAN_COMBATINFO_ID,"ShowCrit");
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowBlock",TITAN_NIL);
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowDodge",TITAN_NIL);
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowParry",TITAN_NIL);
	TitanPanelButton_UpdateButton(TITAN_COMBATINFO_ID);
end

function TitanPanelCombatInfoButton_ToggleDisplayDodge()
	TitanToggleVar(TITAN_COMBATINFO_ID,"ShowDodge");
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowCrit",TITAN_NIL);
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowBlock",TITAN_NIL);
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowParry",TITAN_NIL);
	TitanPanelButton_UpdateButton(TITAN_COMBATINFO_ID);
end

function TitanPanelCombatInfoButton_ToggleDisplayParry()
	TitanToggleVar(TITAN_COMBATINFO_ID,"ShowParry");
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowCrit",TITAN_NIL);
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowBlock",TITAN_NIL);
	TitanSetVar(TITAN_COMBATINFO_ID,"ShowDodge",TITAN_NIL);
	TitanPanelButton_UpdateButton(TITAN_COMBATINFO_ID);
end

function TitanPanelCombatInfoButton_ToggleDisplayStatLabel()
	TitanToggleVar(TITAN_COMBATINFO_ID,"ShowStatLabel");
	TitanPanelButton_UpdateButton(TITAN_COMBATINFO_ID);
end

function TitanPanelRightClickMenu_PrepareCombatInfoMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_COMBATINFO_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_COMBATINFO_OPTIONS_SHOWBLOCK_TEXT,TITAN_COMBATINFO_ID,"TitanPanelCombatInfoButton_ToggleDisplayBlock");
	TitanPanelRightClickMenu_AddCommand(TITAN_COMBATINFO_OPTIONS_SHOWCRIT_TEXT,TITAN_COMBATINFO_ID,"TitanPanelCombatInfoButton_ToggleDisplayCrit");
	TitanPanelRightClickMenu_AddCommand(TITAN_COMBATINFO_OPTIONS_SHOWDODGE_TEXT,TITAN_COMBATINFO_ID,"TitanPanelCombatInfoButton_ToggleDisplayDodge");
	TitanPanelRightClickMenu_AddCommand(TITAN_COMBATINFO_OPTIONS_SHOWPARRY_TEXT,TITAN_COMBATINFO_ID,"TitanPanelCombatInfoButton_ToggleDisplayParry");
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleVar(TITAN_COMBATINFO_OPTIONS_SHOWSTATLABEL_TEXT,TITAN_COMBATINFO_ID,"ShowStatLabel");
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_COMBATINFO_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_COMBATINFO_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_COMBATINFO_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function GetCritChance()
	local critChance = 0;
	local id = 1;
	local attackSpell = GetSpellName(id,BOOKTYPE_SPELL);
	-- find the attack spell button if not in slot 1
	if ( attackSpell ~= TITAN_COMBATINFO_CRIT_ATTACKTEXT ) then
		name, texture, offset, numSpells = GetSpellTabInfo(1);
		for i=1, numSpells do
			if ( GetSpellName(i,BOOKTYPE_SPELL) == TITAN_COMBATINFO_CRIT_ATTACKTEXT ) then
				id = i;
			end
		end
	end
	-- populate tooltip for parsing
	TitanCombatInfo_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	TitanCombatInfo_Tooltip:SetSpell(id, BOOKTYPE_SPELL);
	local attackInfo = TitanCombatInfo_TooltipTextLeft2:GetText();
	-- parse crit line
	local iCritInfo = string.find(attackInfo, "%s");
	critChance = string.sub(attackInfo,0,(iCritInfo -2));
	return critChance;
end

function TitanPanelCombatInfoButton_OnEvent()
	--DEFAULT_CHAT_FRAME:AddMessage("event triggered: ".. event);
	
	if (event == "UNIT_INVENTORY_CHANGED") or 
	   (event == "UNIT_AURA") or 
	   (event == "UNIT_AURASTATE") then
		TitanPanelButton_UpdateButton(TITAN_COMBATINFO_ID);
	end
end
DL_CONDITIONS_MENU = {
	{ text="No Condition", value=0, desc="Using this condition causes the response to be run everytime the loop checks the condition, in other words, a number of times per second equal to the Updates Per Second set in Misc Options."},
	{ text="Action Cooling Down", value=1, params=1, desc="Detects if the action you choose is cooling down." },
	{ text="Action In Range", value=2,  params=2, desc="Detects if the action you choose is in range." },
	{ text="Action Is Equipped", value=57, params=2, desc="Detects if the action you choose is an item that's currently equipped."},
	{ text="Action Is Not Equipped", value=58, params=2, desc="Detects if the action you choose is not an item that's currently equipped."},
	{ text="Action Item Count", value=29, params=11, desc="Use this to check the number of items left in a stack the specified action holds." },
	{ text="Action Just Used", value=54, params=2, desc="Used to check the last action used by any means: clicking an action button, pressing a keybinding, auto-cast, etc." },
	{ text="Action Not Cooling Down", value=3, params=1, desc="Detects if the action you choose is not cooling down." },
	{ text="Action Out of Range", value=4,  params=2, desc="Detects if the action you choose is out of range." },
	{ text="Action Unusable", value=37,  params=2, desc="Detects if the action you choose is unusable.  It checks if you have enough mana, the action is in range, and not cooling down as well as the unusable flag."},
	{ text="Action Usable", value=5,  params=2, desc="Detects if the action you choose is usable.  It checks if you have enough mana, the action is in range, and not cooling down as well as the unusable flag." },
	{ text="Aggro Gained", value=40, desc="Detects if you've done anything to generate threat from a mob." },
	{ text="Aggro Lost", value=41, desc="Detects if you've lost all threat from any mobs." },
	{ text="Alt Key Down", value=66, desc="Detects if you're pressing the Alt key." },
	{ text="Alt Key Up", value=67, desc="Detects if you're not pressing the Alt key." },
	{ text="Auto-attack Off", value=42, desc="Detects if you're not currently using an auto-attack action." },
	{ text="Auto-attack On", value=43, desc="Detects if you're currently using an auto-attack action." },
	{ text="Buff Active", value=6, params=3, desc="Detects if a unit currently has a specified buff on them.  You don't have to use the full name of the buff, a partial name will do. For example: 'Power Word' will detect Power Word: Shield and Power Word: Fortitude." },
	{ text="Buff Inactive", value=38, params=3, desc="Detects if a unit does not currently have a specified buff on them.  You don't have to use the full name of the buff, a partial name will do. For example: 'Power Word' will detect Power Word: Shield and Power Word: Fortitude." },
	{ text="Combo Points", value=7, params=4, desc="Used to check how many combo points you currently have." },
	{ text="Creature Type", value=8, params=5, desc="Used to check the creature type (Humanoid, Undead, etc.) of your current target." },
	{ text="Creature Type Is Not", value=30, params=5, desc="Used to check if your target is not the specified creature type (Humanoid, Undead, etc.)." },
	{ text="Ctrl Key Down", value=68, desc="Used to check if you're pressing the Ctrl key." },
	{ text="Ctrl Key Up", value=69, desc="Used to check if you're not pressing the Ctrl key." },
	{ text="Cursor Is Not Over", value=9, desc="Used to check if the mouse cursor is over this object." },
	{ text="Cursor Is Over", value=10, desc="Used to check if the mouse cursor is not over this object." },
	{ text="Debuff Active", value=12, params=3, desc="Used to check if a certain debuff is currently active on a unit.  You don't have to use the full name of the debuff, a partial name will do.  For example: 'Curse of' will detect Curse of Agony and Curse of Weakness." },
	{ text="Debuff Inactive", value=39, params=3, desc="Used to check if a certain debuff is not currently active on a unit.  You don't have to use the full name of the debuff, a partial name will do.  For example: 'Curse of' will detect Curse of Agony and Curse of Weakness." },
	{ text="Debuff Status", value=11, params=6, desc="Used to check if a Poison, Disease, Curse, or Magic debuff is on the specified unit and how many of that status effect the unit has." },
	{ text="Frame Is Hidden", value=49, params=12, desc="Used to check if any frame is not currently visible.  Type in the name of the frame." },
	{ text="Frame Is Visible", value=50, params=12, desc="Used to check if any frame is currently visible.  Type in the name of the frame." },
	{ text="Function Returned False", value=72, params=12, desc="Calls the specified function and checks if it returned a false value.  Type in the name of the function." },
	{ text="Function Returned True", value=73, params=12, desc="Calls the specified function and checks if it returned a true value.  Type in the name of the function." },
	{ text="Health", value=13, params=7, desc="Used to check the current amount of health remaining on any unit.  Use unit <= 0 to detect a dead unit." },
	{ text="Health Lost", value=44, params=7, desc="Used to check to total amount of damage a unit has taken." },
	{ text="In Combat", value=14, desc="Used to check if you're in combat." },
	{ text="Main-Hand Buff Active", value=15, desc="Used to check if you have a buff active on your main-hand weapon." },
	{ text="Main-Hand Buff Inactive", value=46, desc="Used to check if you don't have a buff active on your main-hand weapon." },
	{ text="Mana", value=16, params=7, desc="Used to check the amount of mana, rage, energy, or focus a unit has left." },
	{ text="Mana Lost", value=45, params=7, desc="Used to check the amount of mana, rage, energy, or focus a unit has used." },
	{ text="No Target Selected", value=55, desc="Used to check if you're not currently targetting anything." },
	{ text="Not In Combat", value=17, desc="Used to check if you're not in combat." },
	{ text="Off-Hand Buff Active", value=18, desc="Used to check if you have a buff active on your off-hand weapon." },
	{ text="Off-Hand Buff Inactive", value=47, desc="Used to check if you don't have a buff active on your off-hand weapon." },
	{ text="Party Members", value=19, params=4, desc="Used to check the number of members currently in your party." },
	{ text="Pet Named", value=33, params=12, desc="Used to check the name of your currently summoned pet." },
	{ text="Pet Not Named", value=34, params=12, desc="Used to check if your currently summoned pet doesn't have a particular name." },
	{ text="Pet Not Summoned", value=20, desc="Used to check if you don't have a pet summoned." },
	{ text="Pet Summoned", value=48, desc="Used to check if you have a pet summoned." },
	{ text="Raid Members", value=21, params=4, desc="Used to check the number of members in your raid." },
	{ text="Shapeshift Form Active", value=22, params=8, desc="Used to check which shapeshift form (stealth, stance, animal form) you're currently in." },
	{ text="Shapeshift Form Inactive", value=53, params=8, desc="Used to check if you're not in a particular shapeshift form (stealth, stance, animal form)." },
	{ text="Shift Key Down", value=64, desc="Used to check if the Shift key is being pressed." },
	{ text="Shift Key Up", value=65, desc="Used to check if the Shift key is not being pressed." },
	{ text="Target Is", value=23, params=9, desc="Used to check if your target is friendly, hostile, a player, an NPC, or a spellcaster." },
	{ text="Target Is Not", value=26, params=9, desc="Used to check if your target is not friendly, hostile, a player, an NPC, or a spellcaster." },
	{ text="Target Just Blocked", value=59, desc="Used to check if your target just blocked one of your attacks." },
	{ text="Target Just Dodged", value=60, desc="Used to check if your target just dodged one of your attacks." },
	{ text="Target Just Parried", value=61, desc="Used to check if your target just parried one of your attacks." },
	{ text="Target Selected", value=56, desc="Used to check if you currently have a target."},
	{ text="Timer Active", value=70, params=12, desc="Check if a timer you set is counting down.  Set such a timer with the Set Timer response." },
	{ text="Timer Finished", value=71, params=12,  desc="Check if a timer you set is finished counting down.  Set such a timer with the Set Timer response." },
	{ text="Unit In Detection Range", value=75, params=13, desc="Used to check if a unit is within detection range, around 78 yards." },
	{ text="Unit Not In Detection Range", value=76, params=13, desc="Used to check if a unit is not within detection range, around 78 yards." },
	{ text="Unit Is Class", value=24, params=5, desc="Used to check the class of any unit." },
	{ text="Unit Is Not Class", value=25, params=5, desc="Used to check if a unit is not a particular class." },
	{ text="Unit Is Connected", value=62, params=13, desc="Used to check if a unit is online." },
	{ text="Unit Is Not Connected", value=63, params=13, desc="Used to check if a unit is offline." },
	{ text="Unit Is Ghost", value=35, params=13, desc="Used to check if a unit is a ghost." },
	{ text="Unit Is Not Ghost", value=36, params=13, desc="Used to check if any unit is not a ghost." },
	{ text="Unit Level", value=74, params=7, desc="Used to check how the level of the specified unit compares to a number you specify." },
	{ text="Unit Is Unit", value=51, params=14, desc="Used to check if two units are the same unit.  Useful for checking if someone has the same target as you." },
	{ text="Unit Is Not Unit", value=52, params=14, desc="Used to check if two units are not the same unit.  Useful for checking if someone doesn't have the same target as you." },
	{ text="Unit Is PvP-flagged", value=77, params=13, desc="Used to check if a unit is pvp-flagged." },
	{ text="Unit Is Not PvP-flagged", value=78, params=13, desc="Used to check if a unit is not pvp-flagged." },
	{ text="Variable Is False", value=31, params=12, desc="Used to check if any global variable is false.  Type in the name of the variable." },
	{ text="Variable Is True", value=32, params=12, desc="Used to check if any global variable is true.  Type in the name of the variable." },
	{ text="Variable Keybinding Down", value=27, params=10, desc="Used to check if a Variable Keybinding is currently pressed.  Type in the number you set in the Variable Keybinding's middle drop-down menu." },
	{ text="Variable Keybinding Up", value=28, params=10, desc="Used to check if a Variable Keybinding is not currently pressed.  Type in the number you set in the Variable Keybinding's middle drop-down menu." },
	{ text="Zone Is", value=79, params=5, desc="Used to check if you're in a certain zone." },
	{ text="Zone Isn't", value=80, params=5, desc="Used to check if you're not in a certain zone." },
}

DL_CheckCondition = {};

-- Action Cooling Down
DL_CheckCondition[1] = function(conditions)
	local cd = DL_CooldownLeft(conditions.action);
	if (conditions.ignoreGlobal and cd > 2) then
		return true;
	elseif ((not conditions.ignoreGlobal) and cd > 0) then
		return true;
	end
end

-- Action In Range
DL_CheckCondition[2] = function(conditions)
	if (UnitName("target") and IsActionInRange(conditions.action) ~= 0) then
		return true;
	end
end

-- Action Not Cooling Down
DL_CheckCondition[3] = function(conditions)
	local cd = DL_CooldownLeft(conditions.action);
	if (conditions.ignoreGlobal and cd <= 2) then
		return true;
	elseif ((not conditions.ignoreGlobal) and cd <= 0) then
		return true;
	end
end

-- Action Not In Range
DL_CheckCondition[4] = function(conditions)
	if (UnitName("target") and IsActionInRange(conditions.action) == 0) then
		return true;
	end
end

-- Action Usable
DL_CheckCondition[5] = function(conditions)
	return DL_ActionUsable(conditions.action);
end

-- Buff Active
DL_CheckCondition[6] = function(conditions)
	local buff;
	if (string.sub(conditions.buff, 1, 6) == "action") then
		local actionID = tonumber(string.sub(conditions.buff, 7));
		buff = DL_Get_ActionName(tonumber(actionID), 1);
	else
		buff = conditions.buff;
	end
	return DL_CheckBuff(conditions.unit, buff);
end

-- Combo Points
DL_CheckCondition[7] = function(conditions)
	if (DL_Compare(GetComboPoints(), conditions.number, conditions.compare)) then
		return true;
	end
end

-- Creature Type Is
DL_CheckCondition[8] = function(conditions)
	if (UnitCreatureType(conditions.unit) == conditions.text) then
		return true;
	end
end

-- Cursor Is Not Over
DL_CheckCondition[9] = function(frame)
	if (not DL_IsMouseOver(frame)) then
		return true;
	end
end

-- Cursor Is Over
DL_CheckCondition[10] = function(frame)
	return DL_IsMouseOver(frame);
end

-- Status Count
DL_CheckCondition[11] = function(conditions)
	if (DL_Compare(DL_CheckStatus(conditions.unit, conditions.text), conditions.number, conditions.compare)) then
		return true;
	end
end

-- Debuff Active
DL_CheckCondition[12] = function(conditions)
	local buff;
	if (string.sub(conditions.buff, 1, 6) == "action") then
		local actionID = tonumber(string.sub(conditions.buff, 7));
		buff = DL_Get_ActionName(tonumber(actionID), 1);
	else
		buff = conditions.buff;
	end
	return DL_CheckDebuff(conditions.unit, buff);
end

-- Health
DL_CheckCondition[13] = function(conditions)
	if (conditions.number < 1) then
		return DL_Compare(DL_Get_Health(conditions.unit)/DL_Get_HealthMax(conditions.unit), conditions.number, conditions.compare);
	else
		return DL_Compare(DL_Get_Health(conditions.unit), conditions.number, conditions.compare);
	end
end

-- In Combat
DL_CheckCondition[14] = function()
	return DL_INCOMBAT;
end

-- Main Hand Buff Active
DL_CheckCondition[15] = function()
	local hasMainHandEnchant = GetWeaponEnchantInfo();
	return hasMainHandEnchant;
end

-- Mana
DL_CheckCondition[16] = function(conditions)
	if (conditions.number < 1) then
		return DL_Compare(UnitMana(conditions.unit)/UnitManaMax(conditions.unit), conditions.number, conditions.compare);
	else
		return DL_Compare(UnitMana(conditions.unit), conditions.number, conditions.compare);
	end
end

-- Not In Combat
DL_CheckCondition[17] = function()
	if (not DL_INCOMBAT) then
		return true;
	end
end

-- Off Hand Buff Active
DL_CheckCondition[18] = function()
	local _, _, _, hasOffHandEnchant = GetWeaponEnchantInfo();
	return hasOffHandEnchant;
end

-- Num Party Members
DL_CheckCondition[19] = function(conditions)
	return DL_Compare(GetNumPartyMembers(), conditions.number, conditions.compare);
end

-- Pet Not Summoned
DL_CheckCondition[20] = function()
	if (not UnitExists("pet")) then
		return true;
	end
end

-- Num Raid Members
DL_CheckCondition[21] = function(conditions)
	return DL_Compare(GetNumRaidMembers(), conditions.number, conditions.compare);
end

-- Shapeshift Form
DL_CheckCondition[22] = function(conditions)
	if (DL_Get_ShapeshiftForm() == conditions.form) then
		return true;
	end
end

-- Target Is
DL_CheckCondition[23] = function(conditions)
	if (UnitName("target")) then
		if (conditions.target == 1) then
			return UnitIsPlayer("target");
		elseif (conditions.target == 2) then
			if (not UnitIsPlayer("target")) then
				return true;
			end
		elseif (conditions.target == 3) then
			if (UnitHealth("target") <= 0) then
				return;
			else
				return UnitCanAttack("player", "target");
			end
		elseif (conditions.target == 4) then
			if (not UnitCanAttack("player", "target")) then
				return true;
			end
		elseif (conditions.target == 5) then
			if (UnitIsPlayer("target") and UnitCanAttack("player", "target")) then
				return true;
			end
		elseif (conditions.target == 6) then
			if (UnitIsPlayer("target") and (not UnitCanAttack("player", "target"))) then
				return true;
			end
		elseif (conditions.target == 7) then
			if (UnitPowerType("target") == 0 and UnitManaMax("target") > 0) then
				return true;
			end
		end
	else
		return;
	end
end

-- Unit Class Is
DL_CheckCondition[24] = function(conditions)
	if (UnitClass(conditions.unit) == conditions.text) then
		return true;
	end
end

-- Unit Class Is Not
DL_CheckCondition[25] = function(conditions)
	if (UnitClass(conditions.unit) ~= conditions.text) then
		return true;
	end
end

-- Target Is Not
DL_CheckCondition[26] = function(conditions)
	if (UnitName("target")) then
		if (conditions.target == 1) then
			if (not UnitIsPlayer("target")) then
				return true;
			end
		elseif (conditions.target == 2) then
			if (UnitIsPlayer("target")) then
				return true;
			end
		elseif (conditions.target == 3) then
			if ((not UnitCanAttack("player", "target")) or UnitHealth("target") <= 0) then
				return true;
			end
		elseif (conditions.target == 4) then
			if (UnitCanAttack("player", "target")) then
				return true;
			end
		elseif (conditions.target == 5) then
			if (UnitIsPlayer("target") and UnitCanAttack("player", "target")) then
				return;
			else
				return true;
			end
		elseif (conditions.target == 6) then
			if (UnitIsPlayer("target") and (not UnitCanAttack("player", "target"))) then
				return;
			else
				return true;
			end
		elseif (conditions.target == 7) then
			if (UnitPowerType("target") == 0 and UnitManaMax("target") > 0) then
				return;
			else
				return true;
			end
		end
	else
		return;
	end
end

-- Variable Keybinding Down
DL_CheckCondition[27] = function(conditions)
	if (DAB_VARIABLE_KEYBINDINGS[conditions.number] == 1) then return true; end
end

-- Variable Keybinding Up
DL_CheckCondition[28] = function(conditions)
	if (DAB_VARIABLE_KEYBINDINGS[conditions.number] == 2) then return true; end
end

-- Action Item Count
DL_CheckCondition[29] = function(conditions)
	if (IsConsumableAction(conditions.action)) then
		return DL_Compare(GetActionCount(conditions.action), conditions.number, conditions.compare);
	end
end

-- Creature Type Is Not
DL_CheckCondition[30] = function(conditions)
	if (UnitCreatureType(conditions.unit) ~= conditions.text) then
		return true;
	end
end

-- Variable Is False
DL_CheckCondition[31] = function(conditions)
	if (not getglobal(conditions.text)) then
		return true;
	end
end

-- Variable Is True
DL_CheckCondition[32] = function(conditions)
	return getglobal(conditions.text);
end

-- Pet Name Is
DL_CheckCondition[33] = function(conditions)
	if (UnitExists("pet") and UnitName("pet") == conditions.text) then
		return true;
	end
end

-- Pet Name Is Not
DL_CheckCondition[34] = function(conditions)
	if (UnitExists("pet") and UnitName("pet") ~= conditions.text) then
		return true;
	end
end

-- Unit Is Ghost
DL_CheckCondition[35] = function(conditions)
	return UnitIsGhost(conditions.unit);
end

-- Unit Is Not Ghost
DL_CheckCondition[36] = function(conditions)
	if (not UnitIsGhost(conditions.unit)) then
		return true;
	end
end

-- Action Unusable
DL_CheckCondition[37] = function(conditions)
	if (not DL_ActionUsable(conditions.action)) then
		return true;
	end
end

-- Buff Inactive
DL_CheckCondition[38] = function(conditions)
	local buff;
	if (string.sub(conditions.buff, 1, 6) == "action") then
		local actionID = tonumber(string.sub(conditions.buff, 7));
		buff = DL_Get_ActionName(tonumber(actionID), 1);
	else
		buff = conditions.buff;
	end
	if (not DL_CheckBuff(conditions.unit, buff)) then
		return true;
	end
end

-- Debuff Inactive
DL_CheckCondition[39] = function(conditions)
	local buff;
	if (string.sub(conditions.buff, 1, 6) == "action") then
		local actionID = tonumber(string.sub(conditions.buff, 7));
		buff = DL_Get_ActionName(tonumber(actionID), 1);
	else
		buff = conditions.buff;
	end
	if (not DL_CheckDebuff(conditions.unit, buff)) then
		return true;
	end
end

-- Player Has Threat
DL_CheckCondition[40] = function()
	if (not DL_REGEN) then
		return true;
	end
end

-- Player Does Not Have Threat
DL_CheckCondition[41] = function()
	return DL_REGEN;
end

-- Player Not In Attack Mode
DL_CheckCondition[42] = function()
	if (not DL_ATTACKING) then
		return true;
	end
end

-- Player In Attack Mode
DL_CheckCondition[43] = function()
	return DL_ATTACKING;
end

-- Health Lost
DL_CheckCondition[44] = function(conditions)
	if (conditions.number < 1) then
		return DL_Compare(1 - DL_Get_Health(conditions.unit)/DL_Get_HealthMax(conditions.unit), conditions.number, conditions.compare);
	else
		return DL_Compare(DL_Get_HealthMax(conditions.unit) - DL_Get_Health(conditions.unit), conditions.number, conditions.compare);
	end
end

-- Mana Lost
DL_CheckCondition[45] = function(conditions)
	if (conditions.number < 1) then
		return DL_Compare(1 - UnitMana(conditions.unit)/UnitManaMax(conditions.unit), conditions.number, conditions.compare);
	else
		return DL_Compare(UnitManaMax(conditions.unit) - UnitMana(conditions.unit), conditions.number, conditions.compare);
	end
end

-- Main Hand Buff Inactive
DL_CheckCondition[46] = function()
	local hasMainHandEnchant = GetWeaponEnchantInfo();
	if (not hasMainHandEnchant) then
		return true;
	end
end

-- Off Hand Buff Inactive
DL_CheckCondition[47] = function()
	local _, _, _, hasOffHandEnchant = GetWeaponEnchantInfo();
	if (not hasOffHandEnchant) then
		return true;
	end
end

-- Pet Summoned
DL_CheckCondition[48] = function()
	if (UnitName("pet") and UnitExists("pet")) then
		return true;
	end
end

-- Frame Is Hidden
DL_CheckCondition[49] = function(conditions)
	local frame = getglobal(conditions.text);
	if (frame and ((not frame:IsVisible()) or frame.fauxhidden)) then
		return true;
	end
end

-- Frame Is Visible
DL_CheckCondition[50] = function(conditions)
	local frame = getglobal(conditions.text);
	if (frame and frame:IsVisible() and (not frame.fauxhidden)) then
		return true;
	end
end

-- Unit Is Unit
DL_CheckCondition[51] = function(conditions)
	return UnitIsUnit(conditions.unit, conditions.unit2);
end

-- Unit Is Not Unit
DL_CheckCondition[52] = function(conditions)
	if (not UnitIsUnit(conditions.unit, conditions.unit2)) then
		return true;
	end
end

-- Not In Shapeshift Form
DL_CheckCondition[53] = function(conditions)
	if (DL_Get_ShapeshiftForm() ~= conditions.form) then
		return true;
	end
end

-- Action Just Used
DL_CheckCondition[54] = function(conditions)
	if (conditions.action == DL_LAST_ACTION) then
		return true;
	end
end

-- No Target Selected
DL_CheckCondition[55] = function()
	if (not UnitName("target")) then return true; end
end

-- Target Selected
DL_CheckCondition[56] = function()
	if (UnitName("target")) then return true; end
end

-- Action Is Equipped
DL_CheckCondition[57] = function(conditions)
	return IsEquippedAction(conditions.action);
end

-- Action Is Not Equipped
DL_CheckCondition[58] = function(conditions)
	if (not IsEquippedAction(conditions.action)) then
		return true;
	end
end

-- Target Just Blocked
DL_CheckCondition[59] = function()
	return DL_TARGET_BLOCKED;
end

-- Target Just Dodged
DL_CheckCondition[60] = function()
	return DL_TARGET_DODGED;
end

-- Target Just Parried
DL_CheckCondition[61] = function()
	return DL_TARGET_PARRIED;
end

-- Unit Is Connected
DL_CheckCondition[62] = function(conditions)
	return UnitIsConnected(conditions.unit);
end

-- Unit Is Not Connected
DL_CheckCondition[63] = function(conditions)
	if (not UnitIsConnected(conditions.unit)) then
		return true;
	end
end

-- Shift Key Down
DL_CheckCondition[64] = function()
	return IsShiftKeyDown();
end

-- Shift Key Up
DL_CheckCondition[65] = function()
	if (not IsShiftKeyDown()) then
		return true;
	end
end

-- Alt Key Down
DL_CheckCondition[66] = function()
	return IsAltKeyDown();
end

-- Alt Key Up
DL_CheckCondition[67] = function()
	if (not IsAltKeyDown()) then
		return true;
	end
end

-- Ctrl Key Down
DL_CheckCondition[68] = function()
	return IsControlKeyDown();
end

-- Ctrl Key Up
DL_CheckCondition[69] = function()
	if (not IsControlKeyDown()) then
		return true;
	end
end

-- Timer is Counting Down
DL_CheckCondition[70] = function(conditions)
	if (DL_TIMERS and DL_TIMERS[conditions.text] and DL_TIMERS[conditions.text] > 0) then
		return true;
	end
end

-- Timer is Finished
DL_CheckCondition[71] = function(conditions)
	if (DL_TIMERS and DL_TIMERS[conditions.text] and DL_TIMERS[conditions.text] <= 0) then
		return true;
	end
end

-- Function Returned False
DL_CheckCondition[72] = function(conditions)
	if (not getglobal(conditions.text)()) then
		return true;
	end
end

-- Function Returned True
DL_CheckCondition[73] = function(conditions)
	return getglobal(conditions.text)();
end

-- Unit Level
DL_CheckCondition[74] = function(conditions)
	return DL_Compare(UnitLevel(conditions.unit), conditions.number, conditions.compare);
end

-- Unit In Detection Range
DL_CheckCondition[75] = function(conditions)
	return UnitIsVisible(conditions.unit);
end

-- Unit Not In Detection Range
DL_CheckCondition[76] = function(conditions)
	if (not UnitIsVisible(conditions.unit)) then
		return true;
	end
end

-- Unit Is PvP-flagged
DL_CheckCondition[77] = function(conditions)
	if (UnitIsPVP(conditions.unit) or UnitIsPVPFreeForAll(conditions.unit)) then
		return true;
	end
end

-- Unit Is Not PvP-flagged
DL_CheckCondition[78] = function(conditions)
	if (not UnitIsPVP(conditions.unit)) and (not UnitIsPVPFreeForAll(conditions.unit)) then
		return true;
	end
end

-- Zone Is
DL_CheckCondition[79] = function(conditions)
	if (conditions.text == GetRealZoneText()) then
		return true;
	end
end

-- Zone Isn;t
DL_CheckCondition[80] = function(conditions)
	if (conditions.text ~= GetRealZoneText()) then
		return true;
	end
end
function GB_ActionButton_Initialize(bar, button)
	if (button > GB_UNITS_ARRAY[bar].buttons) then
		return;
	end
	local settings = GB_Get(bar, button);
	local count;
	if (settings.idType == "item") then
		if (GB_ITEMS[settings.name]) then
			if (GB_Get_ItemCount(settings.name) == 0) then
				GB_Settings[GB_INDEX][bar].Button[button] = GB_Get_DefaultButtonSettings();
				settings = GB_Get(bar, button);
			end
		else
			GB_Settings[GB_INDEX][bar].Button[button] = GB_Get_DefaultButtonSettings();
			settings = GB_Get(bar, button);
		end
	elseif (settings.idType == "inv") then
		if (GB_INVENTORY[settings.name]) then
			if (GB_INVENTORY[settings.name].count == 0) then
				GB_Settings[GB_INDEX][bar].Button[button] = GB_Get_DefaultButtonSettings();
				settings = GB_Get(bar, button);
			end
		else
			GB_Settings[GB_INDEX][bar].Button[button] = GB_Get_DefaultButtonSettings();
			settings = GB_Get(bar, button);
		end
	end
	local texture = GB_Get_Texture(bar, button);
	for _, unitBar in GB_UNITS_ARRAY[bar].frames do
		local actionButton = unitBar.."_Button_"..button;
		getglobal(actionButton.."_Icon"):SetTexture(texture);
		getglobal(actionButton.."TextFrame_Name"):SetText("");
		if (settings.name) then
			GB_ActionButton_SetCount(bar, button);
			if (settings.idType == "macro") then
				getglobal(actionButton.."TextFrame_Name"):SetText(settings.name);
			end
		end
		actionButton = getglobal(actionButton);
		actionButton.InContext = {};
		if (not settings.name) then
			if  (not GB_Get("showEmpty")) then
				actionButton.InContext.empty = -1;
				actionButton:Hide();
			else
				actionButton.InContext.empty = nil;
				actionButton:Show();
			end
		else
			actionButton.InContext.empty = nil;
			if (settings.hide) then
				actionButton.InContext.userhidden = -1;
				actionButton:Hide();
			else
				actionButton.InContext.userhidden = nil;
				actionButton:Show();
			end
		end
		if (GB_Options:IsVisible()) then
			actionButton:Show();
		end

		actionButton:UnregisterEvent("PARTY_MEMBERS_CHANGED");
		actionButton:UnregisterEvent("PLAYER_ENTER_COMBAT");
		actionButton:UnregisterEvent("PLAYER_LEAVE_COMBAT");
		actionButton:UnregisterEvent("PLAYER_REGEN_DISABLED");
		actionButton:UnregisterEvent("PLAYER_REGEN_ENABLED");
		actionButton:UnregisterEvent("PLAYER_TARGET_CHANGED");
		actionButton:UnregisterEvent("RAID_ROSTER_UPDATE");
		actionButton:UnregisterEvent("UNIT_AURA");
		actionButton:UnregisterEvent("UNIT_HEALTH");
		actionButton:UnregisterEvent("UNIT_MANA");
		actionButton:UnregisterEvent("UPDATE_BONUS_ACTIONBAR");

		actionButton:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");

		if (bar == "party" or bar == "lowesthealth") then
			actionButton:RegisterEvent("PARTY_MEMBERS_CHANGED");
		elseif (string.find(bar, "target")) then
			actionButton:RegisterEvent("PLAYER_TARGET_CHANGED");
		elseif (bar == "raid") then
			actionButton:RegisterEvent("RAID_ROSTER_UPDATE");
		end
		actionButton.contextType = "";
		if (settings.name and settings.context ~= "Always") then
			if (settings.context == "Mana") then
				actionButton.contextType = "mana";
				actionButton:RegisterEvent("UNIT_MANA");
				actionButton:RegisterEvent("UNIT_MAXMANA");
			elseif (settings.context == "Health1" or settings.context == "Health2" or settings.context == "Health3" or settings.context == "Health4" or settings.context == "Area" or settings.context == "Dead" or settings.context == "DmgGTHeal") then
				actionButton.contextType = "health";
				actionButton:RegisterEvent("UNIT_HEALTH");
				actionButton:RegisterEvent("UNIT_MAXHEALTH");
			elseif (settings.context == "Diseased" or settings.context == "Poisoned" or settings.context == "Cursed" or settings.context == "MagicDebuffed" or settings.context == "NotBuffed" or settings.context == "NotDebuffed") then
				actionButton.contextType = "buffs";
				if (bar == "player") then
					actionButton:RegisterEvent("PLAYER_AURAS_CHANGED");
				end
				actionButton:RegisterEvent("UNIT_AURA");
			end
		end
		if (settings.name and bar == "lowesthealth") then
			if (actionButton.contextType == "") then
				if (settings.idType=="spell") then
					if (GB_SPELLS[settings.name][settings.rank].type == "cure" or GB_SPELLS[settings.name][settings.rank].type == "buff") then
						actionButton:RegisterEvent("UNIT_AURA");
					end
				else
					actionButton:RegisterEvent("UNIT_HEALTH");
					actionButton:RegisterEvent("UNIT_MAXHEALTH");
				end
			end
		end
		if (settings.name == GB_MINLVL_SPELLS.PWShield and settings.validTarget) then
			actionButton:RegisterEvent("UNIT_AURA");
		end
		if (settings.inCombat or settings.notInCombat) then
			actionButton:RegisterEvent("PLAYER_LEAVE_COMBAT");
			actionButton:RegisterEvent("PLAYER_ENTER_COMBAT");
			actionButton:RegisterEvent("PLAYER_REGEN_DISABLED");
			actionButton:RegisterEvent("PLAYER_REGEN_ENABLED");
		end
		if (settings.form) then
			actionButton:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
		end
--		if (settings.outdoors) then
--			actionButton:RegisterEvent("ZONE_CHANGED");
--			actionButton:RegisterEvent("ZONE_CHANGED_INDOORS");
--		end
		GB_ActionButton_CheckAllContexts(actionButton);
	end
end

function GB_ActionButton_CheckAllContexts(actionbutton)
	if (not GB_INITIALIZED) then return; end

	if (GB_Options:IsVisible()) then
		actionbutton:Show();
		return;
	end

	if (not actionbutton:GetParent():IsVisible()) then return; end

	local bar = actionbutton:GetParent().index;
	local button = actionbutton:GetID();
	local target = actionbutton:GetParent().unit;

	if (actionbutton:GetParent().index == "lowesthealth") then
		local spellname = GB_Settings[GB_INDEX][bar].Button[button].name;
		local spellrank = GB_Settings[GB_INDEX][bar].Button[button].rank;
		if (GB_SPELLS[spellname] and GB_SPELLS[spellname][spellrank].type == "cure") then
			target = GB_Get_CureTarget(spellname);
		elseif (GB_SPELLS[spellname] and GB_SPELLS[spellname][spellrank].type == "buff") then
			target = GB_Get_BuffTarget(spellname);
		else
			target = actionbutton:GetParent().unit();
		end
		if (target) then
			getglobal(actionbutton:GetName().."TextFrame_Name"):SetText(UnitName(target));
		else
			getglobal(actionbutton:GetName().."TextFrame_Name"):SetText("");
			target = "player";
		end
	end
	local origContext = GB_Get_InContext(actionbutton);

	actionbutton.InContext.class = GB_ActionButton_CheckClassContext(
		target,
		GB_Settings[GB_INDEX][bar].Button[button].classes);
	if (GB_Settings[GB_INDEX][bar].Button[button].playerOnly) then
		if (not UnitIsPlayer(target)) then
			actionbutton.InContext.playerOnly = -1;
		else
			actionbutton.InContext.playerOnly = nil;
		end
	else
		actionbutton.InContext.playerOnly = nil;
	end
	actionbutton.InContext.combat = GB_ActionButton_CheckCombatContext(
		GB_Settings[GB_INDEX][bar].Button[button].inCombat,
		GB_Settings[GB_INDEX][bar].Button[button].notInCombat);
	if (actionbutton.contextType == "buffs") then
		actionbutton.InContext.main = GB_ActionButton_CheckBuffContexts(
			GB_Settings[GB_INDEX][bar].Button[button].context,
			target,
			GB_Settings[GB_INDEX][bar].Button[button].name);
	elseif (actionbutton.contextType == "health") then
		actionbutton.InContext.main = GB_ActionButton_CheckHealthContexts(
			GB_Settings[GB_INDEX][bar].Button[button].context,
			target,
			GB_Settings[GB_INDEX][bar].Button[button].name,
			GB_Settings[GB_INDEX][bar].Button[button].rank);
	elseif (actionbutton.contextType == "mana") then
		actionbutton.InContext.main = GB_ActionButton_CheckManaContexts(
			GB_Settings[GB_INDEX][bar].Button[button].context, target);
	end
	actionbutton.InContext.form = GB_ActionButton_CheckFormContext(GB_Settings[GB_INDEX][bar].Button[button].form);
	actionbutton.InContext.validTarget = GB_ActionButton_CheckValidTargetContext(
		GB_Settings[GB_INDEX][bar].Button[button].validTarget,
		target,
		GB_Settings[GB_INDEX][bar].Button[button].name);

	GB_ActionButton_ShowInContext(actionbutton, origContext, GB_Settings[GB_INDEX][bar].Button[button].OOCoption, GB_Settings[GB_INDEX][bar].Button[button].flashInContext);
end

function GB_ActionButton_CheckBuffContexts(context, target, name)
	if (not UnitIsPlayer(target)) then
		if (UnitHealth(target) <= 0) then return 0; end
	end
	if (context == "NotBuffed") then
		if (GB_Get_BuffMatch(name, target)) then
			return -1;
		elseif (name == GB_MINLVL_SPELLS.PWShield) then
			if (GB_Get_DebuffMatch(GB_TEXT.WeakenedSoul, target)) then return -1; end
		elseif (GB_AREA_BUFFS[name]) then
			if (GB_Get_BuffMatch(GB_AREA_BUFFS[name], target)) then return -1; end
		elseif (GB_Get("hideAllBlessings") and string.find(name, GB_TEXT.Blessing)) then
			if (GB_Get_BuffMatch(GB_TEXT.Blessing, target)) then return -1; end
		end
	elseif (context == "NotDebuffed") then
		if (GB_Get_DebuffMatch(name, target)) then return -1; end
	elseif (context == "MagicDebuffed") then
		if (not GB_Get_DebuffMatch(GB_FILTERS.Magic, target, 1)) then return -1; end
	elseif (context == "Cursed") then
		if (not GB_Get_DebuffMatch(GB_FILTERS.Curse, target, 1)) then return -1; end
	elseif (context == "Diseased") then
		if (name ~= GB_TEXT.Purify) then
			if (not GB_Get_DebuffMatch(GB_FILTERS.Disease, target, 1)) then return -1; end
		else
			if ((not GB_Get_DebuffMatch(GB_FILTERS.Disease, target, 1)) and (not GB_Get_DebuffMatch(GB_FILTERS.Poison, target, 1))) then
				return -1;
			end
		end
	elseif (context == "Poisoned") then
		if (name ~= GB_TEXT.Purify) then
			if (not GB_Get_DebuffMatch(GB_FILTERS.Poison, target, 1)) then return -1; end
		else
			if ((not GB_Get_DebuffMatch(GB_FILTERS.Disease, target, 1)) and (not GB_Get_DebuffMatch(GB_FILTERS.Poison, target, 1))) then
				return -1;
			end
		end
	end
	return 0;
end

function GB_ActionButton_CheckClassContext(target, classes)
	if (UnitIsPlayer(target)) then
		if (not classes[UnitClass(target)]) then return -1; end
	end
	return 0;
end

function GB_ActionButton_CheckCombatContext(inCombat, notInCombat)
	if (inCombat and (not GB_INCOMBAT)) then
		return -1;
	end
	if (notInCombat and GB_INCOMBAT) then
		return -1;
	end
	return 0;
end

function GB_ActionButton_CheckFormContext(context)
	if (context and GB_Get_CurrentForm() ~= context) then
		return -1;
	else
		return 0;
	end
end

function GB_ActionButton_CheckHealthContexts(context, target, name, rank)
	if (not UnitIsPlayer(target)) then
		if (UnitHealth(target) <= 0) then return; end
	end
	local threshold;
	if (context == "Health1") then
		threshold = 1;
	elseif (context == "Health2") then
		threshold = 2;
	elseif (context == "Health3") then
		threshold = 3;
	elseif (context == "Health4") then
		threshold = 4;
	end
	if (threshold) then
		if (not GB_Get_PastThreshold("healthThresholds", target, threshold)) then return -1; end
	elseif (context == "Dead") then
		if (UnitHealth(target) > 0 and (not UnitIsDeadOrGhost(target))) then
			return -1;
		end
		if (not UnitIsVisible(target)) then
			return -1;
		end
	elseif (context == "DmgGTHeal") then
		if (rank and UnitHealthMax(target) and UnitHealthMax(target) ~= 100) then
			if (GB_SPELLS[name][rank].avg > (UnitHealthMax(target) - UnitHealth(target))) then
				return -1;
			end
		end
	elseif (context == "Area") then
		local numPast = 0;
		if (GB_Get_PastThreshold("aeThreshold", "player")) then
			numPast = numPast + 1;
		end
		for i = 1,GetNumPartyMembers() do
			if (UnitHealth("party"..i) and UnitHealth("party"..i) > 0 and UnitIsVisible("party"..i) and (not GB_Get("limitaerange") or CheckInteractDistance("party"..i, 4))) then
				if (GB_Get_PastThreshold("aeThreshold", "party"..i)) then
					numPast = numPast + 1;
				end
			end
		end
		if (numPast < GB_Settings[GB_INDEX].numPastAEThreshold) then
			return -1;
		end
	end
	return 0;
end

function GB_ActionButton_CheckOutdoorsContext(context)
	if (not context) then return 0; end
	local outdoors = GetMapInfo();
	if (not outdoors) then
		return -1;
	else
		return 0;
	end
end

function GB_ActionButton_CheckManaContexts(context, target)
	if (not UnitIsPlayer(target)) then
		if (UnitHealth(target) <= 0) then return; end
	end
	local threshold = GB_Get("manaThreshold");
	local damage;
	if (string.find(threshold, "%%")) then
		_,_,threshold = string.find(threshold, "(%d*)%%");
		damage = 100 - UnitMana(target) / UnitManaMax(target) * 100;
	else
		if (UnitManaMax(target) == 100) then return 0; end
		damage = UnitManaMax(target) - UnitMana(target);
	end
	threshold = tonumber(threshold);
	if (not threshold) then return 0; end
	if (damage < threshold) then
		return -1;
	end
	return 0;
end

function GB_ActionButton_CheckValidTargetContext(validTarget, target, name)
	if (not validTarget) then return 0; end
	if (not UnitIsPlayer(target)) then
		if (UnitHealth(target) <= 0) then return; end
	end
	local creatureType = UnitCreatureType(target);
	if (not creatureType) then creatureType = GB_TEXT.Humanoid; end
	if (name == GB_TEXT.ManaBurn or name == GB_TEXT.ViperSting or name == GB_TEXT.Silence or name == GB_TEXT.Counterspell) then
		if (UnitPowerType(target) ~= 0 or UnitManaMax(target) == 0) then
			return -1;
		end
	elseif (name == GB_TEXT.CurseOfDoom) then
		if (UnitIsPlayer(target)) then
			return -1;
		end
	elseif (name == GB_MINLVL_SPELLS.PWShield) then
		if (not UnitInParty(target)) then
			if (not GB_UnitInRaid(target)) then
				return -1;
			end
		end
		if (GB_Get_DebuffMatch(GB_TEXT.WeakenedSoul, target)) then return -1; end
	elseif (not GB_TARGET_SPELLS[name]) then
		return 0;
	elseif (not GB_TARGET_SPELLS[name][creatureType]) then
		return -1;
	end
	return 0;
end

function GB_ActionButton_OnClick(unitBar, button, clickcasttoggle, unitoverride)
	if (unitBar == "target") then
		unitBar = GB_Get_UnitBar(unitBar);
	end
	if (not unitBar) then return; end
	unitBar = getglobal(unitBar);
	
	local retarget = false;
	local hadTarget, targetName;

	local idType = GB_Settings[GB_INDEX][unitBar.index].Button[button].idType;
	local name = GB_Settings[GB_INDEX][unitBar.index].Button[button].name;
	local rank = GB_Settings[GB_INDEX][unitBar.index].Button[button].rank;
	local target = unitBar.unit;
	if (unitBar:GetName() == "GB_LowestHealthBar") then
		if (GB_SPELLS[name][rank].type == "cure") then
			target = GB_Get_CureTarget(name);
		elseif (GB_SPELLS[name][rank].type == "buff" and name ~= GB_MINLVL_SPELLS.PWShield) then
			target = GB_Get_BuffTarget(name);
		else
			target = unitBar.unit();
		end
		if (not target) then
			local text = string.gsub(GB_TEXT.TargetNotFound, '$n', name);
			GB_Feedback(text);
			return;
		end
	end
	if (unitoverride) then
		target = unitoverride;
	end
	GB_LAST_UNIT = target;

	local overridePO;
	if (UnitName("target")) then
		hadTarget = true;
		if (not UnitCanAttack("player", "target")) then
			if (UnitIsPlayer("target")) then
				targetName = UnitName("target");
			else
				targetName = "NPC";
			end
			TargetUnit(target);
			retarget = true;
		elseif (UnitFactionGroup("target") == UnitFactionGroup("player") and UnitIsPlayer("target")) then
			targetName = UnitName("target");
			TargetUnit(target);
			retarget = true;
		end
	end

	if (not clickcasttoggle) then
		if (IsShiftKeyDown() and (not GB_Get("dontTargetPet")) and target ~= "target") then
			local unitnum;
			if (target == "player") then
				target = "pet";
			elseif (string.find(target, "party")) then
				_,_,unitnum = string.find(target, "party(%d*)");
				target = "partypet"..unitnum;
			elseif (string.find(target, "raid")) then
				_,_,unitnum = string.find(target, "raid(%d*)");
				target = "raidpet"..unitnum;
			end
			TargetUnit(target);
			target = "target";
			retarget = true;
		end
		if (IsControlKeyDown()) then
			if (not GB_Settings[GB_INDEX].applyPOonCtrl) then
				overridePO = true;
			end
		elseif (GB_Settings[GB_INDEX].applyPOonCtrl) then
			overridePO = true;
		end
	end
	if (idtype == "macro") then
		TargetUnit(target);
		retarget = true;
	end
	if (name == GB_TEXT.DispelMagic and UnitCanAttack("player", "target")) then
		TargetUnit(target);
		retarget = true;
	end
	if (GB_Settings[GB_INDEX].changeTarget) then
		TargetUnit(target);
		retarget = false;
	end
	if (target == "target") then
		retarget = false;
	end
	if (GB_Settings[GB_INDEX][unitBar.index].Button[button].assist) then
		retarget = false;
		AssistUnit(target);
		target = "target";
	end

	if (name ~= GB_TEXT.Attack) then
		GB_AttackTarget();		
	end

	GB_LAST_SPELL = nil;
	GB_LAST_SPELLNUM = GB_LAST_SPELLNUM + 1;
	GB_ANNOUNCEFAILURE = nil;
	GB_ANNOUNCEINTERRUPTED = nil;
	GB_ISCASTING = nil;
	GB_INSTANTCASTING = nil;
	if (idType == "spell") then
		local spellName, spellRank = GB_Get_CorrectSpell(unitBar.index, button, target, overridePO);
		if (spellName) then
			if (GB_Get_ActionUsuable(spellName, spellRank, getglobal(unitBar:GetName().."_Button_"..button))) then
				local castit = true;
				if (GB_Settings[GB_INDEX][unitBar.index].Button[button].cancelHeal) then
					if (not GB_Get_PastThreshold("cancelHealThreshold", target, threshold)) then
						castit = false;
					end
				end
				if (castit) then
					if (GB_Settings[GB_INDEX].autoleaveform and GB_SPELLS[spellName][spellRank].type == "heal") then
						if (GB_PLAYER_CLASS == "PRIEST" and GB_SHADOWFORM_INDEX) then
							CancelPlayerBuff(GB_SHADOWFORM_INDEX);
						elseif (GB_PLAYER_CLASS == "DRUID") then
							local f = GB_Get_CurrentForm()
							if (f > 0) then
								CastShapeshiftForm(f)
							end
						end
					end
					CastSpell( GB_SPELLS[spellName][spellRank].id, "BOOKTYPE_SPELL" );
					if (GB_Settings[GB_INDEX][unitBar.index].Button[button].announce) then
						GB_ANNOUNCEFAILURE = nil;
						GB_ANNOUNCEINTERRUPTED = nil;
						GB_ISCASTING = true;
						GB_INSTANTCASTING = nil;
						GB_ANNOUNCETEXT = GB_Get_AnnounceText(spellName, spellRank, target, GB_Settings[GB_INDEX][unitBar.index].Button[button].announceText);
						GB_WHISPERTARGET = UnitName(target);
						if (GB_SPELLS[spellName][spellRank].castingTime == 0) then
							GB_INSTANTCASTING = true;
						end
					end
				elseif (not GB_Settings[GB_INDEX][unitBar.index].Button[button].preventOverhealing) then
					GB_Feedback(GB_TEXT.NotPastCancelHeal);
				end
				if (GB_Settings[GB_INDEX][unitBar.index].Button[button].cancelHeal and castit) then
					GB_CURRENT_HEAL = {spellName, spellRank, target};
				end
			end
		end
	elseif (idType == "item") then
		UseContainerItem(GB_ITEMS[name].bag, GB_ITEMS[name].slot);
	elseif (idType == "inv") then
		UseInventoryItem(GB_INVENTORY[name].id);
	elseif (idType == "macro") then
		GB_RunMacro(name);
	end

	if (SpellIsTargeting()) then
		if ( unitBar.index == "hostiletarget") then
			SpellTargetUnit("player");
		else
			SpellTargetUnit(target);
		end
	end

	if (retarget) then
		if (not hadTarget) then
			ClearTarget();
		elseif (targetName) then
			if (targetName == "NPC") then
				TargetLastTarget();
			else
				TargetByName(targetName);
			end
		else
			TargetLastEnemy();
		end
	end
	GB_LAST_UNIT = nil;
end

function GB_ActionButton_OnEvent(event)
	if (not GB_INITIALIZED) then return; end

	if (event == "UNIT_AURA" and arg1 == "target" and (not GroupButtonsFrame.targetauras)) then return; end

	if (event == "ACTIONBAR_UPDATE_COOLDOWN") then
		GB_ActionButton_UpdateCooldown();
		return;
	end
	if (GB_Options:IsVisible()) then
		this:Show();
		return;
	end
	if (event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE") then
		GB_ActionButton_CheckAllContexts(this);
		return;
	elseif (event == "PLAYER_TARGET_CHANGED") then
		if (UnitCanAttack("player", "target") and this:GetParent():GetName() == "GB_HostileTargetBar") then
			GB_ActionButton_CheckAllContexts(this);
			return;
		end
		if ((not UnitCanAttack("player", "target")) and this:GetParent():GetName() == "GB_FriendlyTargetBar") then
			GB_ActionButton_CheckAllContexts(this);
			return;
		end
	end

	local origContext = GB_Get_InContext(this);
	local target = this:GetParent().unit;
	local lhbar;
	if (this:GetParent().index == "lowesthealth") then
		lhbar = true;
		if (GB_SPELLS[GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].name] and GB_SPELLS[GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].name][GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].rank].type == "cure") then
			target = GB_Get_CureTarget(GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].name);
		elseif (GB_SPELLS[GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].name] and GB_SPELLS[GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].name][GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].rank].type == "buff" and GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].name ~= GB_MINLVL_SPELLS.PWShield) then
			target = GB_Get_BuffTarget(GB_Settings[GB_INDEX]["lowesthealth"].Button[this:GetID()].name);
		else
			target = this:GetParent().unit();
		end
		if (target) then
			getglobal(this:GetName().."TextFrame_Name"):SetText(UnitName(target));
		else
			getglobal(this:GetName().."TextFrame_Name"):SetText("");
			target = "player";
		end
	end
	if (GB_Settings[GB_INDEX][this:GetParent().index].Button[this:GetID()].assist) then
		target = target.."target";
	end
	if (not UnitExists(target)) then return; end
	local bar = this:GetParent().index;
	local buttNum = this:GetID();

	if (event == "UPDATE_BONUS_ACTIONBAR") then
		this.InContext.form = GB_ActionButton_CheckFormContext(GB_Settings[GB_INDEX][bar].Button[buttNum].form);
	elseif (event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_LEAVE_COMBAT" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED") then
		this.InContext.combat = GB_ActionButton_CheckCombatContext(
			GB_Settings[GB_INDEX][bar].Button[buttNum].inCombat,
			GB_Settings[GB_INDEX][bar].Button[buttNum].notInCombat);
	elseif (event == "UNIT_AURA") then
		if (arg1 == target or lhbar) then
			this.InContext.main = GB_ActionButton_CheckBuffContexts(GB_Settings[GB_INDEX][bar].Button[buttNum].context, target, GB_Settings[GB_INDEX][bar].Button[buttNum].name);
			if (GB_Settings[GB_INDEX][bar].Button[buttNum].name == GB_MINLVL_SPELLS.PWShield and GB_Settings[GB_INDEX][bar].Button[buttNum].validTarget) then
				this.InContext.validTarget = GB_ActionButton_CheckValidTargetContext(
					GB_Settings[GB_INDEX][bar].Button[buttNum].validTarget,
					target,
					GB_Settings[GB_INDEX][bar].Button[buttNum].name);
			end
		end
	elseif (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" ) then
		if (arg1 == target or lhbar or GB_Settings[GB_INDEX][bar].Button[buttNum].context == "Area") then
			this.InContext.main = GB_ActionButton_CheckHealthContexts( GB_Settings[GB_INDEX][bar].Button[buttNum].context, target, GB_Settings[GB_INDEX][bar].Button[buttNum].name, GB_Settings[GB_INDEX][bar].Button[buttNum].rank);
		end
	elseif (event == "UNIT_MANA" or event == "UNIT_MAXMANA") then
		if (arg1 == target) then
			this.InContext.main = GB_ActionButton_CheckManaContexts(GB_Settings[GB_INDEX][bar].Button[buttNum].context, target);
		end
--	elseif (event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS") then
--		this.InContext.outdoors = GB_ActionButton_CheckOutdoorsContext(settings.outdoors);
	end

	GB_ActionButton_ShowInContext(this, origContext, GB_Settings[GB_INDEX][bar].Button[buttNum].OOCoption, GB_Settings[GB_INDEX][bar].Button[buttNum].flashInContext);
end

function GB_ActionButton_OnUpdate(elapsed)
	if (not GB_INITIALIZED) then return; end

	if (this.timer) then
		this.timer = this.timer - elapsed;
		if (this.timer > 0) then
			return;
		else
			this.timer = TOOLTIP_UPDATE_TIME;
		end
	end

	if (this.flashing) then
		this.flashtimer = this.flashtimer - arg1;
		if (this.flashtimer < 0) then
			this.flashtimer = .5;
			if (this.Direction) then
				this.Direction = nil;
			else
				this.Direction = 1;
			end
		else
			if (this.Direction) then
				local a = this.flashtimer * 2;
				this:SetAlpha(a);
			else
				local a = 1 - this.flashtimer * 2;
				this:SetAlpha(a);
			end
		end
	end

	if (this.cooldowncount) then
		this.cooldowncount = this.cooldowncount - elapsed;
		if (this.cooldowncount <= 0) then
			this.cooldowncount = nil;
			getglobal(this:GetName().."TextFrame_CooldownCount"):SetText("");
		else
			local count = math.ceil(this.cooldowncount);
			if (count < 60) then
				getglobal(this:GetName().."TextFrame_CooldownCount"):SetText(count.."s");
			else
				count = math.ceil(count / 60);
				getglobal(this:GetName().."TextFrame_CooldownCount"):SetText(count.."m");
			end
		end
	end

	local idType = GB_Settings[GB_INDEX][this:GetParent().index].Button[this:GetID()].idType;
	local name = GB_Settings[GB_INDEX][this:GetParent().index].Button[this:GetID()].name;
	local rank = GB_Settings[GB_INDEX][this:GetParent().index].Button[this:GetID()].rank;

	local textscale = getglobal(this:GetName().."TextFrame").textscale;
	if (textscale) then
		if (getglobal(this:GetName().."TextFrame"):GetScale() ~= textscale) then
			getglobal(this:GetName().."TextFrame"):SetScale(textscale);
		end
	end

	if (idType == "spell") then
		local inRange, enoughMana = true, true;
		local texture = getglobal(this:GetName().."_Icon");
		local range = GB_SPELLS[name][rank].range;
		local unit = this:GetParent().unit;
		if (this:GetParent().index == "lowesthealth") then
			unit = this:GetParent().unit();
		end
		if (unit ~= "target") then
			range = tonumber(GB_SPELLS[name][rank].rangeinyds);
		end
		local mana = GB_SPELLS[name][rank].mana;
		if (range) then
			if (unit == "target") then
				if (IsActionInRange(range) == 0) then
					inRange = false;
				elseif ((not UnitIsVisible("target")) and UnitExists("target")) then
					inRange = false;
				end
--			elseif (unit == "player") then
--			elseif (MapLibrary_Updater and (not GB_Settings[GB_INDEX].disablePartyRange)) then
--				local inInstance = MapLibrary.InInstance();
--				if (MapLibrary.Ready and (not inInstance)) then
--					local dist = MapLibrary.UnitDistance(unit, "player", 1);
--					if (dist and dist > range) then inRange = false; end
--				end
			end
		end
		if (mana) then
			if (UnitMana("player") < mana and (not GB_Get_BuffMatch(GB_TEXT.InnerFocus, "player"))) then
				enoughMana = false;
			end
		end
		if (not inRange) then
			texture:SetVertexColor(GB_Settings[GB_INDEX].OORcolor.r, GB_Settings[GB_INDEX].OORcolor.g, GB_Settings[GB_INDEX].OORcolor.b);
		elseif (not enoughMana) then
			texture:SetVertexColor(GB_Settings[GB_INDEX].OOMcolor.r, GB_Settings[GB_INDEX].OOMcolor.g, GB_Settings[GB_INDEX].OOMcolor.b);
		elseif (this.grey) then
			texture:SetVertexColor(GB_Settings[GB_INDEX].greycolor.r, GB_Settings[GB_INDEX].greycolor.g, GB_Settings[GB_INDEX].greycolor.b);
		else
			texture:SetVertexColor(1, 1, 1);
		end
	end
end

function GB_ActionButton_SetCount(bar, button)
	if (not GB_INITIALIZED) then return; end
	if (bar == "raid" or bar == "partypet") then return; end
	local name = GB_Settings[GB_INDEX][bar].Button[button].name;
	local idType = GB_Settings[GB_INDEX][bar].Button[button].idType;
	local count;
	if (not name) then
		GB_ActionButton_Initialize(bar, button);
		GB_Set_Appearance(bar);
		return;
	end
	if (idType == "item") then
		count = GB_Get_ItemCount(name);
	elseif (idType == "inv") then
		count = GB_INVENTORY[name].count;
	else
		for _, unitBar in GB_UNITS_ARRAY[bar].frames do
			getglobal(unitBar.."_Button_"..button.."TextFrame_Count"):SetText("");
		end
		return;
	end
	for _, unitBar in GB_UNITS_ARRAY[bar].frames do
		if (count > 1) then
			getglobal(unitBar.."_Button_"..button.."TextFrame_Count"):SetText(count);
		else
			getglobal(unitBar.."_Button_"..button.."TextFrame_Count"):SetText("");
		end
	end
	if (count == 0) then
		GB_ActionButton_Initialize(bar, button);
		GB_Set_Appearance(bar);
	end
end

function GB_ActionButton_ShowInContext(button, origContext, OOCoption, FlashInContext)
	local currentContext = GB_Get_InContext(button);
	if (currentContext) then
		button:Show();
		if (FlashInContext) then
			button.flashtimer = .5;
			button.flashing = true;
		else
			button.flashing = nil;
			button.flashtimer = nil;
		end
		button.grey = nil;
		getglobal(button:GetName().."_Icon"):SetVertexColor(1, 1, 1);
		button:SetAlpha(GB_Settings[GB_INDEX][button:GetParent().index].alpha);
	else
		if (OOCoption == "hide") then
			button:Hide();
		elseif (OOCoption == "grey") then
			button.grey = true;
			getglobal(button:GetName().."_Icon"):SetVertexColor(.4, .4, .4);
			button.flashing = nil;
			button.flashtimer = nil;
			button:SetAlpha(GB_Settings[GB_INDEX][button:GetParent().index].alpha);
		elseif (OOCoption == "flash") then
			button.flashtimer = .5;
			button.flashing = true;
		end
	end
	if (currentContext ~= origContext) then
		local unitBar;
		if (button:GetParent().index == "party" or button:GetParent().index == "pet" or button:GetParent().index == "partypet" or button:GetParent().index == "raid") then
			unitBar = GB_Get_UnitBar(button:GetParent().unit);
		else
			unitBar = GB_Get_UnitBar(button:GetParent().index);
		end
		GB_Set_Layout(button:GetParent().index, unitBar);
	end
end

function GB_ActionButton_UpdateCooldown()
	if (not GB_INITIALIZED) then return; end
	local start, duration, enable;
	local idType = GB_Settings[GB_INDEX][this:GetParent().index].Button[this:GetID()].idType;
	local name = GB_Settings[GB_INDEX][this:GetParent().index].Button[this:GetID()].name;
	local rank = GB_Settings[GB_INDEX][this:GetParent().index].Button[this:GetID()].rank;

	if (idType == "spell") then
		start, duration, enable = GetSpellCooldown(GB_SPELLS[name][rank].id, BOOKTYPE_SPELL);
	elseif (idType == "item") then
		start, duration, enable = GetContainerItemCooldown(GB_ITEMS[name].bag, GB_ITEMS[name].slot);
	elseif (idType == "inv") then
		start, duration, enable = GetInventoryItemCooldown("player", GB_INVENTORY[name].id);
	end
	if (start and start > 0) then
		if (GB_Settings[GB_INDEX].showCooldown) then
			if (this.cooldowncount) then
				this.cooldowncount = duration - (GetTime() - start);
			else
				this.cooldowncount = duration;
			end
		end
		CooldownFrame_SetTimer(getglobal(this:GetName().."_Cooldown"), start, duration, enable);	
	else
		if (GB_Settings[GB_INDEX].showCooldown) then
			this.cooldowncount = 0;
		end
	end
end
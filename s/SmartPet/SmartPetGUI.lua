SmartPet_OPTIONS_TITLE = "SmartPet Options";

function SmartPetOptions_Toggle() --Toggles SmartPet GUI
	if (SmartPetOptionsFrame:IsVisible()) then
		SmartPetOptionsFrame:Hide();
	else
		SmartPetOptionsFrame:Show();
	end
end

function SmartPetEnable_Toggle() --Toggles SmartPet On/Off
	if (SmartPet_Config.Enabled) then
		SmartPet_Config.Enabled = false;
		SmartPet_AllOptions:Hide();
	else
		SmartPet_Config.Enabled = true;
		SmartPet_AllOptions:Show();
	end
	SmartPet_UpdateActionIcons(true);
end

function SmartPetChannelSet()	--Sets Pet Health Warning Channel
	if ( (SmartPet_AutoWarnChannelEditBox:GetNumber() < 0 )  or (SmartPet_AutoWarnChannelEditBox == nil) )then
		SmartPet_Config.ChannelNumber = 1;
	else
		SmartPet_Config.ChannelNumber = SmartPet_AutoWarnChannelEditBox:GetNumber();
	end
	SmartPet_Config.Channel = "channel";
end


function SmartPetAutowarn_Toggle()
	SmartPet_OnSlashCommand(SMARTPET_AUTOWARN);
end


function SmartPetOptions_OnLoad()
	UIPanelWindows['SmartPetOptionsFrame'] = {area = 'center', pushable = 0};
	tinsert(UISpecialFrames, "SmartPetOptionsFrame")
end


function SmartPetOptions_OnShow()
	SmartPetEnableToggleButton:SetChecked(SmartPet_Config.Enabled);
	SmartPetToolTipsToggleButton:SetChecked(SmartPet_Config.ToolTips);
	SmartPetAutoWarnToggleButton:SetChecked(SmartPet_Config.AutoWarn);
	SmartPetAutoCowerToggleButton:SetChecked(SmartPet_Config.AutoCower);
	SmartPetAutoWarnPercentEditBox:SetText(SmartPet_Config.WarnHealth);
	SmartPetAutoCowerPercentEditBox:SetText(SmartPet_Config.CowerHealth);
	SmartPetNoChaseToggleButton:SetChecked(SmartPet_Config.NoChase);
	SmartPetOptionsToggleButton:SetChecked(SmartPet_Config.Icon);
	SmartPetSmartFocusCheckBox:SetChecked(SmartPet_Config.SmartFocus);
	SmartPetAttackAlert:SetChecked(SmartPet_Config.Alert);
	SmartPetScatterToggleButton:SetChecked(SmartPet_Config.Scatter);
	SmartPetSpellOnAttackToggleButton:SetChecked(SmartPet_Config.SpellAttack);
	SmartPetHealthWarning_Group:SetChecked((SmartPet_Config.Channel == "party"));
	SmartPetHealthWarning_Say:SetChecked((SmartPet_Config.Channel == "say"));
	SmartPetHealthWarning_Raid:SetChecked((SmartPet_Config.Channel == "raid"));
	SmartPetHealthWarning_Guild:SetChecked((SmartPet_Config.Channel == "guild"));
	SmartPetHealthWarning_Channel:SetChecked((SmartPet_Config.Channel == "channel"));
	SmartPet_AutoWarnChannelEditBox:SetText(SmartPet_Config.ChannelNumber);
	SmartPetAttackRunCheckBox:SetChecked(SmartPet_Config.RushAttack);
	SmartPetRecallAlert:SetChecked(SmartPet_Config.RecallWarn);

	if (SmartPet_Config.Spell ~= "") then
		local spellName, spellRank = GetSpellName( SmartPet_Config.Spell, SmartPet_Config.SpellBook);
		SmartPetAttackSpell:SetNormalTexture(GetSpellTexture(SmartPet_Config.Spell, SmartPet_Config.SpellBook));
		SmartPetAttackSpellText:SetText(spellName.." "..spellRank);
	end

	if (SmartPet_Config.Enabled) then
		SmartPet_AllOptions:Show();
	else
		SmartPet_AllOptions:Hide();
	end
	if (SmartPet_Config.AutoWarn) then
		SmartPet_HealthWarningChanels:Show();
	else 
		SmartPet_HealthWarningChanels:Hide();
	end
	if (SmartPet_Config.Scatter) then
		SmartPet_ScatterOptions:Show();
	else 
		SmartPet_ScatterOptions:Hide();
	end

	if (SmartPet_Config.ScatterMood == PetPassiveMode) then
		SmartPetScatterPassiveButton:SetChecked(true);
		SmartPetScatterDefensiveButton:SetChecked(false);
	elseif (SmartPet_Config.ScatterMood == PetDefensiveMode) then
		SmartPetScatterDefensiveButton:SetChecked(true);
		SmartPetScatterPassiveButton:SetChecked(false);
	else
		SmartPetScatterDefensiveButton:SetChecked(false);
		SmartPetScatterPassiveButton:SetChecked(false);
	end

	if (SmartPet_Config.ScatterOrder == PetFollow) then
		SmartPetScatterFollowButton:SetChecked(true);
		SmartPetScatterStayButton:SetChecked(false);
	elseif (SmartPet_Config.ScatterOrder == PetWait) then
		SmartPetScatterStayButton:SetChecked(true);
		SmartPetScatterFollowButton:SetChecked(false);
	else
		SmartPetScatterStayButton:SetChecked(false);
		SmartPetScatterFollowButton:SetChecked(false);
	end

--Hides settings not relevent to warlocks
	if (SmartPet_Vars.Class == "WARLOCK") then
		SmartPetAutoCowerToggleButton:Hide();
		SmartPetAutoCowerPercentEditBox:Hide();
		SmartPetSmartFocusCheckBox:Hide();
		SmartPetAttackRunCheckBox:Hide();
		SmartPetScatterToggleButton:Hide();
		SmartPet_ScatterOptions:Hide();
	end

end


function SmartPetOptions_Init()
end


function SmartPetOptions_OnHide()
	if(MYADDONS_ACTIVE_OPTIONSFRAME == this) then
		ShowUIPanel(myAddOnsFrame);
	end
end

--Sets spell to use on attack when droped in attack spell slot
function SmartPetSelectedSpell()
	if (SmartPet_Vars.PickedUp_Spell == "") then
		SmartPetClearSpell();
		return
	end

	local spellName, spellRank = GetSpellName( SmartPet_Vars.PickedUp_Spell , SmartPet_Vars.PickedUp_SpellBook);
	--SmartPet_AddInfoMessage(spellName);
	--SmartPet_AddInfoMessage(spellRank);
	--SmartPet_AddInfoMessage(GetSpellTexture(SmartPet_Vars.PickedUp_Spell , SmartPet_Vars.PickedUp_SpellBook  ));
	SmartPetAttackSpell:SetNormalTexture(GetSpellTexture(SmartPet_Vars.PickedUp_Spell , SmartPet_Vars.PickedUp_SpellBook  ));
	ResetCursor();
	PickupSpell(SmartPet_Vars.PickedUp_Spell , SmartPet_Vars.PickedUp_SpellBook) ;
	SmartPetAttackSpellText:SetText(spellName..spellRank);
	SmartPet_Config.Spell = SmartPet_Vars.PickedUp_Spell;
	SmartPet_Config.SpellBook = SmartPet_Vars.PickedUp_SpellBook;
	SmartPet_Vars.PickedUp_Spell = "";
	SmartPet_Vars.PickedUp_SpellBook = "";
end

--removes selected spell from cursor when droping on attack spell slot
function SmartPetClearSpell()
	SmartPetAttackSpell:SetNormalTexture("Interface\\Buttons\\UI-EmptySlot-Disabled");
	SmartPetAttackSpellText:SetText("None");
	SmartPet_Config.Spell = "";
	SmartPet_Config.SpellBook = "";
end

--
function SmartPetScatterMoodToggle(mood)
	if (mood == "passive") then
	SmartPet_Config.ScatterMood = PetPassiveMode;
	SmartPetScatterPassiveButton:SetChecked(true);
	SmartPetScatterDefensiveButton:SetChecked(false);
	elseif (mood == "defensive") then
	SmartPet_Config.ScatterMood = PetDefensiveMode;
	SmartPetScatterDefensiveButton:SetChecked(true);
	SmartPetScatterPassiveButton:SetChecked(false);
	else
	SmartPet_Config.ScatterMood = "";
	SmartPetScatterDefensiveButton:SetChecked(false);
	SmartPetScatterPassiveButton:SetChecked(false);
	end
end

function SmartPetScatterCommandToggle(order)
	if (order == "follow") then
	SmartPet_Config.ScatterOrder = PetFollow;
	SmartPetScatterFollowButton:SetChecked(true);
	SmartPetScatterStayButton:SetChecked(false);
	elseif (order == "stay") then
	SmartPet_Config.ScatterOrder = PetWait;
	SmartPetScatterStayButton:SetChecked(true);
	SmartPetScatterFollowButton:SetChecked(false);
	else
	SmartPet_Config.ScatterOrder = "";
	SmartPetScatterStayButton:SetChecked(false);
	SmartPetScatterFollowButton:SetChecked(false);
	end
end
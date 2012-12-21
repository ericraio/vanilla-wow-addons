function CT_RA_ResetOptions()
	CT_RAMenu_Options = {
		["Default"] = {
			PlayRSSound = 1,
			MenuLocked = 1,
			ShowMTs = { 1, 1, 1, 1, 1 },
			NotifyDebuffsClass = { 1, 1, 1, 1, 1, 1, 1, 1 },
			NotifyDebuffs = { 1, 1, 1, 1, 1, 1, 1, 1 },
			DefaultColor = { r = 0, g = 0.1, b = 0.9, a = 0.5 },
			MemberHeight = 40,
			PercentColor = { r = 1, g = 1, b = 1 },
			DefaultAlertColor = { r = 1, g = 1, b = 1 },
			BGOpacity = 0.4,
			WindowPositions = { },
			BuffArray = {
				{ ["show"] = 1, ["name"] = CT_RA_POWERWORDFORTITUDE, ["index"] = 1 },
				{ ["show"] = 1, ["name"] = CT_RA_MARKOFTHEWILD, ["index"] = 2 },
				{ ["show"] = 1, ["name"] = CT_RA_ARCANEINTELLECT, ["index"] = 3 },
				{ ["show"] = 1, ["name"] = CT_RA_SHADOWPROTECTION, ["index"] = 5 },
				{ ["show"] = 1, ["name"] = CT_RA_POWERWORDSHIELD, ["index"] = 6 },
				{ ["show"] = 1, ["name"] = CT_RA_SOULSTONERESURRECTION, ["index"] = 7 },
				{ ["show"] = 1, ["name"] = CT_RA_DIVINESPIRIT, ["index"] = 8 },
				{ ["show"] = 1, ["name"] = CT_RA_THORNS, ["index"] = 9 },
				{ ["show"] = 1, ["name"] = CT_RA_FEARWARD, ["index"] = 10 },
				{ ["show"] = 1, ["name"] = CT_RA_BLESSINGOFMIGHT, ["index"] = 11 },
				{ ["show"] = 1, ["name"] = CT_RA_BLESSINGOFWISDOM, ["index"] = 12 },
				{ ["show"] = 1, ["name"] = CT_RA_BLESSINGOFKINGS, ["index"] = 13 },
				{ ["show"] = 1, ["name"] = CT_RA_BLESSINGOFSALVATION, ["index"] = 14 },
				{ ["show"] = 1, ["name"] = CT_RA_BLESSINGOFLIGHT, ["index"] = 15 },
				{ ["show"] = 1, ["name"] = CT_RA_BLESSINGOFSANCTUARY, ["index"] = 16 },
				{ ["show"] = 1, ["name"] = CT_RA_RENEW, ["index"] = 17 },
				{ ["show"] = 1, ["name"] = CT_RA_REJUVENATION, ["index"] = 18 },
				{ ["show"] = 1, ["name"] = CT_RA_REGROWTH, ["index"] = 19 }
			},
			DebuffColors = {
				{ ["type"] = CT_RA_CURSE, ["r"] = 1, ["g"] = 0, ["b"] = 0.75, ["a"] = 0.5, ["id"] = 4, ["index"] = 1 },
				{ ["type"] = CT_RA_MAGIC, ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 0.5, ["id"] = 6, ["index"] = 2 },
				{ ["type"] = CT_RA_POISON, ["r"] = 0, ["g"] = 0.5, ["b"] = 0, ["a"] = 0.5, ["id"] = 3, ["index"] = 3 },
				{ ["type"] = CT_RA_DISEASE, ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 0.5, ["id"] = 5, ["index"] = 4 },
				{ ["type"] = CT_RA_WEAKENEDSOUL, ["r"] = 1, ["g"] = 0, ["b"] = 1, ["a"] = 0.5, ["id"] = 2, ["index"] = 5 },
				{ ["type"] = CT_RA_RECENTLYBANDAGED, ["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 0.5, ["id"] = 1, ["index"] = 6 }
			},
			ShowGroups = { },
			SpellCastDelay = 0.5,
			SORTTYPE = "group"
		},
		["temp"] = { }
	}
	for k, v in CT_RAMenu_Options["Default"] do
		CT_RAMenu_Options["temp"][k] = v;
	end
	CT_RAMenu_Options["temp"]["unchanged"] = 1;
	CT_RAMenu_CurrSet = "Default";
	
	CT_RASets_ButtonPosition = 16;
end

CT_RA_ResetOptions();

function CT_RASets_MoveButton()
	CT_RASets_Button:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(CT_RASets_ButtonPosition)), (80 * sin(CT_RASets_ButtonPosition)) - 52);
end

function CT_RASets_ToggleDropDown()
	CT_RASets_DropDown.point = "TOPRIGHT";
	CT_RASets_DropDown.relativePoint = "BOTTOMLEFT";
	ToggleDropDownMenu(1, nil, CT_RASets_DropDown);
end

function CT_RASets_DropDown_Initialize()
	local dropdown;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	CT_RASets_DropDown_InitButtons();
end

function CT_RASets_DropDown_OnClick()
	local offset = 1;
	if ( ( CT_RASets_OpenedLevel or 0 ) >= 1 ) then
		offset = 0;
	end
	local id = this:GetID();
	if ( id == 2 ) then
		ShowUIPanel(CT_RAMenuFrame);
	elseif ( id == 3 and offset == 0 ) then
		ShowUIPanel(CT_RATargetFrame);
	elseif ( id == 4-offset ) then
		ShowUIPanel(CT_RAMenuFrame);
		CT_RAMenuButton_OnClick(7);
	elseif ( id == 5-offset ) then
		CT_RAMenu_Options["temp"]["LockGroups"] = not CT_RAMenu_Options["temp"]["LockGroups"];
		CT_RAMenu_UpdateOptionSets();
		CT_RA_UpdateRaidGroup(0);
		CT_RA_UpdateMTs();
		CT_RAMenu_UpdateMenu();
		CT_RAOptions_Update();
	elseif ( id >= 6-offset ) then
		local num = 0;
		for k, v in CT_RAMenu_Options do
			if ( k ~= "temp" ) then
				num = num + 1;
				if ( num == id-(5-offset) ) then
					
					CT_RAMenu_CurrSet = k;
					CT_RAMenu_Options["temp"] = { };
					for k, v in CT_RAMenu_Options[CT_RAMenu_CurrSet] do
						CT_RAMenu_Options["temp"][k] = v;
					end
					CT_RAMenu_UpdateOptionSets();
					CT_RA_UpdateRaidGroup(0);
					CT_RA_UpdateMTs();
					CT_RAMenu_UpdateMenu();
					CT_RAOptions_Update();
					return;
				end
			end
		end
	end
end

function CT_RASets_DropDown_InitButtons()
	CT_RASets_OpenedLevel = CT_RA_Level;
	local info = {};

	info.text = "Option Sets";
	info.isTitle = 1;
	info.justifyH = "CENTER";
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	info.text = "Open Options";
	info.notCheckable = 1;
	info.func = CT_RASets_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	if ( ( CT_RASets_OpenedLevel or 0 ) >= 1 ) then
		info = { };
		info.text = "Target Management";
		info.notCheckable = 1;
		info.func = CT_RASets_DropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
	
	info = { };
	info.text = "Edit Sets";
	info.notCheckable = 1;
	info.func = CT_RASets_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	if ( CT_RAMenu_Options["temp"]["LockGroups"] ) then
		info.text = "Unlock Windows";
	else
		info.text = "Lock Windows";
	end
	info.notCheckable = 1;
	info.func = CT_RASets_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	local numSets = 0;
	for k, v in CT_RAMenu_Options do
		if ( k ~= "temp" ) then
			numSets = numSets + 1;
			if ( numSets == 2 ) then
				break;
			end
		end
	end
	if ( numSets == 2 ) then
		for k, v in CT_RAMenu_Options do
			if ( k ~= "temp" ) then
				info = { };
				info.text = k;
				info.isTitle = nil;
				if ( CT_RAMenu_CurrSet == k ) then
					info.checked = 1;
				end
				info.tooltipTitle = "Change Set";
				info.tooltipText = "Changes the current option set to this one, updating all your settings to match the ones specified in the option set.";
				info.func = CT_RASets_DropDown_OnClick;
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

function CT_RASets_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RASets_DropDown_Initialize, "MENU");
end

tinsert(UISpecialFrames, "CT_RAMenu_NewSetFrame");
tinsert(UISpecialFrames, "CT_RAMenu_DeleteSetFrame");
CT_RASetsEditFrame_NumButtons = 7;

function CT_RASetsEditFrame_Update()
	local numEntries = 0;
	for k, v in CT_RAMenu_Options do
		numEntries = numEntries + 1;
	end
	FauxScrollFrame_Update(CT_RASetsEditFrameScrollFrame, numEntries, CT_RASetsEditFrame_NumButtons , 32);

	for i = 1, CT_RASetsEditFrame_NumButtons, 1 do
		local button = getglobal("CT_RASetsEditFrameBackdropButton" .. i);
		local index = i + FauxScrollFrame_GetOffset(CT_RASetsEditFrameScrollFrame);
		local num, name = 0, nil;
		if ( i <= numEntries ) then
			
			for k, v in CT_RAMenu_Options do
				num = num + 1;
				if ( num == index ) then
					name = k;
					break;
				end
			end
			if ( name ) then
				button:Show();
				if ( CT_RASetsEditFrame.selected == name ) then
					getglobal(button:GetName() .. "CheckButton"):SetChecked(1);
				else
					getglobal(button:GetName() .. "CheckButton"):SetChecked(nil);
				end
				getglobal(button:GetName() .. "Name"):SetText(name);
			end
		else
			button:Hide();
		end
	end
end

function CT_RASetsEditCB_Check(id)
	for i = 1, CT_RASetsEditFrame_NumButtons, 1 do
		getglobal("CT_RASetsEditFrameBackdropButton" .. i .. "CheckButton"):SetChecked(nil);
	end
	if ( not id ) then
		return;
	end
	getglobal("CT_RASetsEditFrameBackdropButton" .. id .. "CheckButton"):SetChecked(1);
	local num = 0;
	for k, v in CT_RAMenu_Options do
		if ( k ~= "temp" ) then
			num = num + 1;
			if ( num == id+FauxScrollFrame_GetOffset(CT_RASetsEditFrameScrollFrame) ) then
				CT_RASetsEditFrame.selected = k;
				if ( k == "Default" ) then
					CT_RASetsEditFrame_EnableDelete(nil);
				else
					CT_RASetsEditFrame_EnableDelete(1);
				end
				return;
			end
		end
	end
	CT_RASetsEditFrame_EnableDelete(nil);
end

function CT_RASetsEditFrame_EnableDelete(enable)
	if ( enable ) then
		CT_RASetsEditFrameDeleteButton:Enable();
	else
		CT_RASetsEditFrameDeleteButton:Disable();
	end
end

function CT_RASetsEdit_Delete()
	if ( CT_RASetsEditFrame.selected ) then
		CT_RAMenu_Options[CT_RASetsEditFrame.selected] = nil;
		if ( CT_RASetsEditFrame.selected == CT_RAMenu_CurrSet ) then
			CT_RAMenu_CurrSet = "Default";
			CT_RA_UpdateRaidGroup(0);
			CT_RAOptions_Update();
			CT_RA_UpdateMTs();
			CT_RAMenu_UpdateMenu();
		end
	end
	CT_RASetsEditFrame.selected = nil;
	CT_RASetsEditFrame_Update();
	CT_RASetsEditFrame_EnableDelete(nil);
end

function CT_RASetsEditNewDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RASetsEditNew_DropDown_Initialize);
	UIDropDownMenu_SetWidth(180);
	UIDropDownMenu_SetSelectedName(CT_RASetsEditNew_DropDown, "Default");
end

function CT_RASetsEditNew_DropDown_Initialize()
	local info = {};
	for k, v in CT_RAMenu_Options do
		if ( k ~= "temp" ) then
			info = { };
			info.text = k;
			info.func = CT_RASetsEditNew_DropDown_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
end

function CT_RASetsEditNew_DropDown_OnClick()
	local num = 0;
	for k, v in CT_RAMenu_Options do
		if ( k ~= "temp" ) then
			num = num + 1;
			if ( num == this:GetID() ) then
				CT_RASetsEditNewFrame.set = k;
				UIDropDownMenu_SetSelectedName(CT_RASetsEditNew_DropDown, k);
				return;
			end
		end
	end
	CT_RASetsEditNewFrame.set = "Default";
	UIDropDownMenu_SetSelectedName(CT_RASetsEditNew_DropDown, "Default");
end

function CT_RASet_New()
	local name = CT_RASetsEditNewFrameNameEB:GetText();
	if ( strlen(name) > 0 and CT_RASetsEditNewFrame.set and CT_RAMenu_Options[CT_RASetsEditNewFrame.set] and not CT_RAMenu_Options[name] ) then
		CT_RAMenu_Options[name] = { };
		for k, v in CT_RAMenu_Options[CT_RASetsEditNewFrame.set] do
			CT_RAMenu_Options[name][k] = v;
		end
	end
	CT_RASetsEditFrame_Update();
end

CT_RA_BuffTextures = {
	[CT_RA_POWERWORDFORTITUDE[1]] = { "Spell_Holy_WordFortitude", 30*60 },
	[CT_RA_POWERWORDFORTITUDE[2]] = { "Spell_Holy_PrayerOfFortitude", 60*60 },
	[CT_RA_MARKOFTHEWILD[1]] = { "Spell_Nature_Regeneration", 30*60 },
	[CT_RA_MARKOFTHEWILD[2]] = { "Spell_Nature_Regeneration", 60*60 },
	[CT_RA_ARCANEINTELLECT[1]] = { "Spell_Holy_MagicalSentry", 30*60 },
	[CT_RA_ARCANEINTELLECT[2]] = { "Spell_Holy_ArcaneIntellect", 60*60 },
	[CT_RA_SHADOWPROTECTION[1]] = { "Spell_Shadow_AntiShadow", 10*60 },
	[CT_RA_SHADOWPROTECTION[2]] = { "Spell_Holy_PrayerofShadowProtection", 20*60 },
	[CT_RA_POWERWORDSHIELD] = { "Spell_Holy_PowerWordShield", 30 },
	[CT_RA_SOULSTONERESURRECTION] = { "Spell_Shadow_SoulGem", 30*60 },
	[CT_RA_DIVINESPIRIT[1]] = { "Spell_Holy_DivineSpirit", 30*60 },
	[CT_RA_DIVINESPIRIT[2]] = { "Spell_Holy_PrayerofSpirit", 60*60 },
	[CT_RA_THORNS] = { "Spell_Nature_Thorns", 10*60 },
	[CT_RA_FEARWARD] = { "Spell_Holy_Excorcism", 10*60 },
	[CT_RA_BLESSINGOFMIGHT[1]] = { "Spell_Holy_FistOfJustice" },
	[CT_RA_BLESSINGOFMIGHT[2]] = { "Spell_Holy_GreaterBlessingofKings" },
	[CT_RA_BLESSINGOFWISDOM[1]] = { "Spell_Holy_SealOfWisdom" },
	[CT_RA_BLESSINGOFWISDOM[2]] = { "Spell_Holy_GreaterBlessingofWisdom" },
	[CT_RA_BLESSINGOFKINGS[1]] = { "Spell_Magic_MageArmor" },
	[CT_RA_BLESSINGOFKINGS[2]] = { "Spell_Magic_GreaterBlessingofKings" },
	[CT_RA_BLESSINGOFSALVATION[1]] = { "Spell_Holy_SealOfSalvation" },
	[CT_RA_BLESSINGOFSALVATION[2]] = { "Spell_Holy_GreaterBlessingofSalvation" },
	[CT_RA_BLESSINGOFLIGHT[1]] = { "Spell_Holy_PrayerOfHealing02" },
	[CT_RA_BLESSINGOFLIGHT[2]] = { "Spell_Holy_GreaterBlessingofLight" },
	[CT_RA_BLESSINGOFSANCTUARY[1]] = { "Spell_Nature_LightningShield" },
	[CT_RA_BLESSINGOFSANCTUARY[2]] = { "Spell_Holy_GreaterBlessingofSanctuary" },
	[CT_RA_RENEW] = { "Spell_Holy_Renew", 15 },
	[CT_RA_REJUVENATION] = { "Spell_Nature_Rejuvenation", 12 },
	[CT_RA_REGROWTH] = { "Spell_Nature_ResistNature", 21 },
	[CT_RA_AMPLIFYMAGIC] = { "Spell_Holy_FlashHeal", 10*60 },
	[CT_RA_DAMPENMAGIC] = { "Spell_Nature_AbolishMagic", 10*60 },
};
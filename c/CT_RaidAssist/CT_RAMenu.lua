tinsert(UISpecialFrames, "CT_RAMenuFrame");
CT_RA_Ressers = { };
CT_RAMenu_Locked = 1;
CT_RA_PartyMembers = { };
CT_RA_InCombat = nil;

function CT_RAMenu_OnLoad()
	CT_RAMenuFrameHomeButton1Text:SetText("General Options");
	CT_RAMenuFrameHomeButton2Text:SetText("Buff Options");
	CT_RAMenuFrameHomeButton3Text:SetText("Misc Options");
	CT_RAMenuFrameHomeButton4Text:SetText("Additional Options");
	CT_RAMenuFrameHomeButton5Text:SetText("Debuff Curing");
	CT_RAMenuFrameHomeButton6Text:SetText("Option Sets");

	CT_RAMenuFrameHomeButton1Description:SetText("Change general stuff, such as whether to show mana bars, etc etc.");
	CT_RAMenuFrameHomeButton2Description:SetText("Change the way Buffs and Debuffs are displayed.");
	CT_RAMenuFrameHomeButton3Description:SetText("Things that do not fit in other categories go here.");
	CT_RAMenuFrameHomeButton4Description:SetText("Regulating message spam, scaling of windows, etc.");
	CT_RAMenuFrameHomeButton5Description:SetText("Configure the debuff curing feature.");
	CT_RAMenuFrameHomeButton6Description:SetText("Save and load sets of options for easier setup.");
end

function CT_RAMenu_OnShow()
	CT_RAMenu_ShowHome();
	this:SetScale(1/UIParent:GetScale()*0.8);
	CT_RAMenuFrameHomeButton1:SetScale(0.9111);
	CT_RAMenuFrameHomeButton2:SetScale(0.9111);
	CT_RAMenuFrameHomeButton3:SetScale(0.9111);
	CT_RAMenuFrameHomeButton4:SetScale(0.9111);
	CT_RAMenuFrameHomeButton5:SetScale(0.9111);
	CT_RAMenuFrameHomeButton6:SetScale(0.9111);
end

function CT_RAMenuButton_OnClick(id)
	if ( not id ) then
		id = this:GetID();
	end
	CT_RAMenuFrameHome:Hide();
	if ( id == 1 ) then
		CT_RAMenuFrameGeneral:Show();
	elseif ( id == 2 ) then
		CT_RAMenuFrameBuffs:Show();
	elseif ( id == 3 ) then
		CT_RAMenuFrameMisc:Show();
	elseif ( id == 4 ) then
		CT_RAMenuFrameAdditional:Show();
	elseif ( id == 5 ) then
		CT_RAMenuFrameDebuff:Show();
	elseif ( id == 6 ) then
		CT_RAMenuFrameOptionSets:Show();
	end
end

function CT_RAMenu_ShowHome()
	CT_RAMenuFrameHome:Show();
	CT_RAMenuFrameGeneral:Hide();
	CT_RAMenuFrameBuffs:Hide();
	CT_RAMenuFrameMisc:Hide();
	CT_RAMenuFrameAdditional:Hide();
	CT_RAMenuFrameDebuff:Hide();
	CT_RAMenuFrameOptionSets:Hide();
end

function CT_RAMenu_UpdateMenu()
	local tempOptions = CT_RAMenu_Options["temp"];
	local admiralsHat, foundDampen;
	for k, v in tempOptions["BuffArray"] do
		if ( v["name"] == CT_RA_DAMPENMAGIC ) then
			foundDampen = k;
		elseif ( v["name"] == CT_RA_ADMIRALSHAT ) then
			admiralsHat = k;
		elseif ( v["name"] == "Don du fauve" ) then
			-- Change name of buffs.. Not a too great way of doing it, but it works (I'll fix this design as soon as possible, it's terrible I know)
			tempOptions["BuffArray"][k]["name"] = CT_RA_MARKOFTHEWILD[2];
		elseif ( v["name"] == "Marque du fauve" ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_MARKOFTHEWILD[1];
		elseif ( v["name"] == CT_RA_BLESSINGOFMIGHT[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFMIGHT;
		elseif ( v["name"] == CT_RA_BLESSINGOFWISDOM[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFWISDOM;
		elseif ( v["name"] == CT_RA_BLESSINGOFKINGS[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFKINGS;
		elseif ( v["name"] == CT_RA_BLESSINGOFSALVATION[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFSALVATION;
		elseif ( v["name"] == CT_RA_BLESSINGOFLIGHT[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFLIGHT;
		elseif ( v["name"] == CT_RA_BLESSINGOFSANCTUARY[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFSANCTUARY;
		elseif ( v["name"] == CT_RA_DIVINESPIRIT[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_DIVINESPIRIT;
		elseif ( v["name"] == CT_RA_SHADOWPROTECTION[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_SHADOWPROTECTION;
		end
	end
	if ( admiralsHat ) then
		tremove(tempOptions["BuffArray"], admiralsHat);
	end
	if ( not foundDampen ) then
		tinsert(tempOptions["BuffArray"], { ["show"] = -1, ["name"] = CT_RA_AMPLIFYMAGIC, ["index"] = 20 });
		tinsert(tempOptions["BuffArray"], { ["show"] = -1, ["name"] = CT_RA_DAMPENMAGIC, ["index"] = 21 });
	end
	for i = 1, 6, 1 do
		if ( type(tempOptions["DebuffColors"][i]["type"]) == "table" ) then
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetText(string.gsub(tempOptions["DebuffColors"][i]["type"][CT_RA_GetLocale()], "_", " "));
		else
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetText(string.gsub(tempOptions["DebuffColors"][i]["type"], "_", " "));
		end
		local val = tempOptions["DebuffColors"][i];
		getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "SwatchNormalTexture"):SetVertexColor(val.r, val.g, val.b);

		if ( val["id"] ~= -1 ) then
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "CheckButton"):SetChecked(1);
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "CheckButton"):SetChecked(nil);
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
		end
	end
	for key, val in tempOptions["BuffArray"] do
		if ( val["show"] ~= -1 ) then
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "CheckButton"):SetChecked(1);
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "CheckButton"):SetChecked(nil);
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "Text"):SetTextColor(0.3, 0.3, 0.3);
		end
		local spell = val["name"];
		if ( type(spell) == "table" ) then
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "Text"):SetText(spell[1]);
			getglobal("CT_RAMenuFrameBuffsBuff" .. key).tooltip = spell[1] .. " & " .. spell[2];
		else
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "Text"):SetText(spell);
			getglobal("CT_RAMenuFrameBuffsBuff" .. key).tooltip = nil;
		end
	end
	CT_RAMenuFrameBuffsNotifyDebuffs:SetChecked(tempOptions["NotifyDebuffs"]);

	for i = 1, 8, 1 do
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "Text"):SetText("Group " .. i);
		if ( not tempOptions["NotifyDebuffs"] or ( not tempOptions["NotifyDebuffs"]["main"] and tempOptions["NotifyDebuffs"]["hidebuffs"] ) ) then
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "CheckButton"):Disable();
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "CheckButton"):Disable();
		end
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffs"):SetChecked(tempOptions["NotifyDebuffs"]["main"]);
		getglobal("CT_RAMenuFrameBuffsNotifyBuffs"):SetChecked(not tempOptions["NotifyDebuffs"]["hidebuffs"]);

		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "CheckButton"):SetChecked(tempOptions["NotifyDebuffs"][i]);
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "CheckButton"):SetChecked(tempOptions["NotifyDebuffsClass"][i]);
	end
	for k, v in CT_RA_ClassPositions do
		if ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) then
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. v .. "Text"):SetText(k);
		end
	end
	CT_RAMenuFrameGeneralDisplayShowMPCB:SetChecked(tempOptions["HideMP"]);
	CT_RAMenuFrameGeneralDisplayShowRPCB:SetChecked(tempOptions["HideRP"]);
	if ( tempOptions["MemberHeight"] == 32 ) then
		CT_RAMenuFrameGeneralDisplayShowHealthCB:SetChecked(1);
	else
		CT_RAMenuFrameGeneralDisplayShowHealthCB:SetChecked(nil);
	end

	CT_RAMenuFrameGeneralDisplayShowGroupsCB:SetChecked(not tempOptions["HideNames"]);
	CT_RAMenuFrameGeneralDisplayLockGroupsCB:SetChecked(tempOptions["LockGroups"]);
	CT_RAMenuFrameGeneralDisplayWindowColorSwatchNormalTexture:SetVertexColor(tempOptions["DefaultColor"].r, tempOptions["DefaultColor"].g, tempOptions["DefaultColor"].b);
	CT_RAMenuFrameGeneralDisplayShowHPSwatchNormalTexture:SetVertexColor(tempOptions["PercentColor"].r, tempOptions["PercentColor"].g, tempOptions["PercentColor"].b);
	CT_RAMenuFrameGeneralDisplayAlertColorSwatchNormalTexture:SetVertexColor(tempOptions["DefaultAlertColor"].r, tempOptions["DefaultAlertColor"].g, tempOptions["DefaultAlertColor"].b);

	CT_RA_UpdateRaidGroupColors();
	CT_RA_UpdateRaidMovability();
	if ( tempOptions["ShowHP"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, tempOptions["ShowHP"]);
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, 5);
	end
	if ( tempOptions["ShowDebuffs"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 2);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show debuffs");
	elseif ( tempOptions["ShowBuffsDebuffed"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 3);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show buffs until debuffed");
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 1);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show buffs");
	end
	local num = 0;
	if ( tempOptions["ShowGroups"] ) then
		for k, v in tempOptions["ShowGroups"] do
			num = num + 1;
			getglobal("CT_RAOptionsGroupCB" .. k):SetChecked(1);
		end
		if ( num > 0 ) then
			CT_RACheckAllGroups:SetChecked(1);
		else
			CT_RACheckAllGroups:SetChecked(nil);
		end
	else
		for i = 1, 8, 1 do
			getglobal("CT_RAOptionsGroupCB" .. i):SetChecked(nil);
		end
	end
	CT_RAMenuFrameGeneralMiscHideOfflineCB:SetChecked(tempOptions["HideOffline"]);
	CT_RAMenuFrameGeneralMiscSortAlphaCB:SetChecked(tempOptions["SubSortByName"]);
	CT_RAMenuFrameGeneralMiscBorderCB:SetChecked(tempOptions["HideBorder"]);
	CT_RAMenuFrameGeneralMiscRemoveSpacingCB:SetChecked(tempOptions["HideSpace"]);
	CT_RAMenuFrameGeneralMiscShowHorizontalCB:SetChecked(tempOptions["ShowHorizontal"]);
	CT_RAMenuFrameGeneralMiscShowReversedCB:SetChecked(tempOptions["ShowReversed"]);
	CT_RAMenuFrameGeneralMiscShowMTsCB:SetChecked(not tempOptions["HideMTs"]);
	CT_RAMenuFrameGeneralMiscShowMetersCB:SetChecked( (tempOptions["StatusMeters"] and tempOptions["StatusMeters"]["Show"] ) );
	CT_RAMenuFrameMiscNotificationsShowTankDeathCB:SetChecked(not tempOptions["HideTankNotifications"]);
	CT_RAMenuFrameMiscNotificationsPlayRSSoundCB:SetChecked(tempOptions["PlayRSSound"]);
	CT_RAMenuFrameMiscNotificationsSendRARSCB:SetChecked(tempOptions["SendRARS"]);
	CT_RAMenuFrameMiscDisplayShowAFKCB:SetChecked(tempOptions["ShowAFK"]);
	CT_RAMenuFrameMiscDisplayShowTooltipCB:SetChecked(not tempOptions["HideTooltip"]);
	CT_RAMenuFrameMiscNotificationsDisableQueryCB:SetChecked(tempOptions["DisableQuery"]);
	CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCB:SetChecked(tempOptions["NotifyGroupChange"]);
	CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCBSound:SetChecked(tempOptions["NotifyGroupChangeSound"]);
	CT_RAMenuFrameMiscDisplayNoColorChangeCB:SetChecked(tempOptions["HideColorChange"]);
	CT_RAMenuFrameMiscDisplayShowResMonitorCB:SetChecked(tempOptions["ShowMonitor"]);
	CT_RAMenuFrameMiscDisplayHideButtonCB:SetChecked(tempOptions["HideButton"]);
	CT_RAMenuFrameMiscDisplayShowPTTCB:SetChecked(tempOptions["ShowPTT"]);
	CT_RAMenuFrameMiscDisplayShowMTTTCB:SetChecked(tempOptions["ShowMTTT"]);
	CT_RAMenuFrameAdditionalEMShowCB:SetChecked(tempOptions["ShowEmergency"]);
	CT_RAMenuFrameMiscNotificationsAggroNotifierCB:SetChecked(tempOptions["AggroNotifier"]);
	CT_RAMenuFrameMiscNotificationsAggroNotifierSoundCB:SetChecked(tempOptions["AggroNotifierSound"]);
	CT_RAMenuFrameMiscDisplayColorLeaderCB:SetChecked( ( not tempOptions["leaderColor"] or tempOptions["leaderColor"].enabled ) );
	
	if ( tempOptions["leaderColor"] ) then
		CT_RAMenuFrameMiscDisplayColorLeaderColorSwatchNormalTexture:SetVertexColor(tempOptions["leaderColor"].r, tempOptions["leaderColor"].g, tempOptions["leaderColor"].b);
	else
		CT_RAMenuFrameMiscDisplayColorLeaderColorSwatchNormalTexture:SetVertexColor(1, 1, 0);
	end
	
	if ( not tempOptions["HideBorder"] ) then
		CT_RAMenuFrameGeneralMiscRemoveSpacingCB:Disable();
		CT_RAMenuFrameGeneralMiscRemoveSpacingText:SetTextColor(0.3, 0.3, 0.3);
	end
	
	local numMts = tempOptions["ShowNumMTs"];
	if ( numMts == 1 ) then
		CT_RAMenuFrameGeneralMTsSubtract:Disable();
	elseif ( numMts == 10 ) then
		CT_RAMenuFrameGeneralMTsAdd:Disable();
	end
	CT_RAMenuFrameGeneralMTsNum:SetText(numMts or 10);
	
	if ( not tempOptions["AggroNotifier"] ) then
		CT_RAMenuFrameMiscNotificationsAggroNotifierSoundCB:Disable();
		CT_RAMenuFrameMiscNotificationsAggroNotifierSound:SetTextColor(0.3, 0.3, 0.3);
	end
	if ( not tempOptions["ShowEmergency"] ) then
		CT_RAMenuFrameAdditionalEMPartyCB:Disable();
		CT_RAMenuFrameAdditionalEMPartyText:SetTextColor(0.3, 0.3, 0.3);
		CT_RAMenuFrameAdditionalEMOutsideRaidCB:Disable();
		CT_RAMenuFrameAdditionalEMOutsideRaidText:SetTextColor(0.3, 0.3, 0.3);
	end
	CT_RAMenuFrameAdditionalEMPartyCB:SetChecked(tempOptions["ShowEmergencyParty"]);
	CT_RAMenuFrameAdditionalEMOutsideRaidCB:SetChecked(tempOptions["ShowEmergencyOutsideRaid"]);
	if ( tempOptions["HideButton"] ) then
		CT_RASets_Button:Hide();
	else
		CT_RASets_Button:Show();
	end
	if ( not tempOptions["NotifyGroupChange"] ) then
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCBSound:Disable();
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeSound:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCBSound:Enable();
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeSound:SetTextColor(1, 1, 1);
	end
	if ( not tempOptions["ShowMTTT"] ) then
		CT_RAMenuFrameMiscDisplayNoColorChangeCB:Disable();
		CT_RAMenuFrameMiscDisplayNoColorChange:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscDisplayNoColorChangeCB:Enable();
		CT_RAMenuFrameMiscDisplayNoColorChange:SetTextColor(1, 1, 1);
	end
	if ( tempOptions["WindowScaling"] ) then
		CT_RAMenuGlobalFrame.scaleupdate = 0.1;
	end
	if ( tempOptions["SORTTYPE"] == "class" ) then
		CT_RA_SetSortType("class");
	elseif ( tempOptions["SORTTYPE"] == "custom" ) then
		CT_RA_SetSortType("custom");
	elseif ( tempOptions["SORTTYPE"] == "virtual" ) then
		CT_RA_SetSortType("virtual");
	else
		CT_RA_SetSortType("group");
	end
	if ( tempOptions["StatusMeters"] ) then
		CT_RAMetersFrame:SetBackdropColor(tempOptions["StatusMeters"]["Background"].r, tempOptions["StatusMeters"]["Background"].g, tempOptions["StatusMeters"]["Background"].b, tempOptions["StatusMeters"]["Background"].a);
		CT_RAMetersFrame:SetBackdropBorderColor(1, 1, 1, tempOptions["StatusMeters"]["Background"].a);
		if ( tempOptions["StatusMeters"]["Show"] and GetNumRaidMembers() > 0 ) then
			CT_RAMetersFrame:Show();
		else
			CT_RAMetersFrame:Hide();
		end
	end
	if ( tempOptions["EMBG"] ) then
		CT_RA_EmergencyFrame:SetBackdropColor(tempOptions["EMBG"].r, tempOptions["EMBG"].g, tempOptions["EMBG"].b, tempOptions["EMBG"].a);
		CT_RA_EmergencyFrame:SetBackdropBorderColor(1, 1, 1, tempOptions["EMBG"].a);
	end
	if ( tempOptions["RMBG"] ) then
		CT_RA_ResFrame:SetBackdropColor(tempOptions["RMBG"].r, tempOptions["RMBG"].g, tempOptions["RMBG"].b, tempOptions["RMBG"].a);
		CT_RA_ResFrame:SetBackdropBorderColor(1, 1, 1, tempOptions["RMBG"].a);
	end
	if ( tempOptions["ShowHP"] ) then
		local table = { "Show Values", "Show Percentages", "Show Deficit", "Show only MTT HP %" };
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, tempOptions["ShowHP"]);
		CT_RAMenuFrameGeneralDisplayHealthDropDownText:SetText(table[tempOptions["ShowHP"]]);
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, 5);
		CT_RAMenuFrameGeneralDisplayHealthDropDownText:SetText("Show None");
	end
	CT_RAMenuAdditional_Scaling_OnShow(CT_RAMenuFrameAdditionalScalingSlider1);
	CT_RAMenuAdditional_ScalingMT_OnShow(CT_RAMenuFrameAdditionalScalingSlider2);
	CT_RAMenuAdditional_EM_OnShow(CT_RAMenuFrameAdditionalEMSlider);
	CT_RAMenuAdditional_EM_OnShow(CT_RAMenuFrameAdditionalEMSlider2);
	CT_RAMenuAdditional_BG_OnShow(CT_RAMenuFrameAdditionalBGSlider);
	CT_RA_Emergency_UpdateHealth();
	CT_RAMenu_UpdateWindowPositions();
end

function CT_RAMenuBuffs_OnEvent(event)
	local changed;
	for k, v in CT_RAMenu_Options do
		if ( v["WindowPositions"] and v["WindowPositions"]["CT_RA_EmergencyFrame"] ) then
			CT_RAMenu_Options[k]["WindowPositions"]["CT_RA_EmergencyFrame"] = nil;
			changed = 1;
		end
	end
	if ( changed ) then
		CT_RAMenu_SaveWindowPositions();
		CT_RAMenu_UpdateWindowPositions();
	end
	if ( not CT_RA_ModVersion or CT_RA_ModVersion ~= CT_RA_VersionNumber ) then
		if ( not CT_RA_ModVersion or CT_RA_ModVersion < 1.465 ) then
			CT_RA_UpdateFrame.showDialog = 5;
		end
		if ( not CT_RA_ModVersion or CT_RA_ModVersion < 1.165 ) then
			DEFAULT_CHAT_FRAME:AddMessage("<CTRaid> All options reset due to new options format. We apoligize for this.", 1, 1, 0);
			CT_RA_ResetOptions();
		end
		CT_RA_ModVersion = CT_RA_VersionNumber;
	end
	if ( not CT_RAMenu_Options["temp"] or CT_RAMenu_Options["temp"]["unchanged"] ) then
		CT_RAMenu_Options["temp"] = { };
		for k, v in CT_RAMenu_Options[CT_RAMenu_CurrSet] do
			CT_RAMenu_Options["temp"][k] = v;
		end
		CT_RAMenu_Options["temp"]["unchanged"] = nil;
	end
	CT_RAMenu_UpdateMenu();
	CT_RASets_Button:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(CT_RASets_ButtonPosition)), (80 * sin(CT_RASets_ButtonPosition)) - 52);
	if ( CT_RAMenu_Locked == 0 ) then
		CT_RAMenuFrameHomeLock:SetText("Lock");
	end

	if ( CT_RAMenu_Options["temp"]["ShowMonitor"] and GetNumRaidMembers() > 0 ) then
		CT_RA_ResFrame:Show();
	end
	
	CT_RA_UpdateRaidGroup(0);
end

function CT_RAMenuNotify_SetChecked()
	if ( this == CT_RAMenuFrameBuffsNotifyDebuffs ) then
		CT_RAMenu_Options["temp"]["NotifyDebuffs"]["main"] = this:GetChecked();
	else
		CT_RAMenu_Options["temp"]["NotifyDebuffs"]["hidebuffs"] = not this:GetChecked();
	end
	for i = 1, 8, 1 do
		if ( not CT_RAMenu_Options["temp"]["NotifyDebuffs"]["main"] and CT_RAMenu_Options["temp"]["NotifyDebuffs"]["hidebuffs"] ) then
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "CheckButton"):Disable();
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "CheckButton"):Disable();
		else
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "Text"):SetTextColor(1, 1, 1);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "CheckButton"):Enable();
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "Text"):SetTextColor(1, 1, 1);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "CheckButton"):Enable();
		end
	end
end

function CT_RAMenuGeneralMisc_AddMTs()
	local new = ( CT_RAMenu_Options["temp"]["ShowNumMTs"] or 9 ) + 1;
	if ( new == 10 ) then
		this:Disable();
	end
	CT_RAMenuFrameGeneralMTsSubtract:Enable();
	CT_RAMenu_Options["temp"]["ShowNumMTs"] = new;
	CT_RAMenuFrameGeneralMTsNum:SetText(new);
end

function CT_RAMenuGeneralMisc_SubtractMTs()
	local new = ( CT_RAMenu_Options["temp"]["ShowNumMTs"] or 10 ) - 1;
	if ( new == 1 ) then
		this:Disable();
	end
	CT_RAMenuFrameGeneralMTsAdd:Enable();
	CT_RAMenu_Options["temp"]["ShowNumMTs"] = new;
	CT_RAMenuFrameGeneralMTsNum:SetText(new);
end

function CT_RAMenuNotifyGroup_SetChecked()
	CT_RAMenu_Options["temp"]["NotifyDebuffs"][this:GetParent():GetID()] = this:GetChecked();
end

function CT_RAMenuNotifyClass_SetChecked()
	CT_RAMenu_Options["temp"]["NotifyDebuffsClass"][this:GetParent():GetID()] = this:GetChecked();
end

function CT_RAMenuDebuff_OnClick()
	local frame = this:GetParent();
	local type = getglobal(this:GetParent():GetName() .. "Text"):GetText();
	type = gsub(type, " ", "");
	frame.r = CT_RAMenu_Options["temp"]["DebuffColors"][frame:GetID()]["r"];
	frame.g = CT_RAMenu_Options["temp"]["DebuffColors"][frame:GetID()]["g"];
	frame.b = CT_RAMenu_Options["temp"]["DebuffColors"][frame:GetID()]["b"];
	frame.opacity = CT_RAMenu_Options["temp"]["DebuffColors"][frame:GetID()]["a"];
	frame.opacityFunc = CT_RAMenuDebuff_SetColor;
	frame.swatchFunc = CT_RAMenuDebuff_SetOpacity;
	frame.hasOpacity = 1;
	ColorPickerFrame.frame = frame;
	CloseMenus();
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function CT_RAMenuDebuff_SetColor()
	local type = getglobal(ColorPickerFrame.frame:GetName() .. "Text"):GetText();
	local r, g, b = ColorPickerFrame:GetColorRGB();
	CT_RAMenu_Options["temp"]["DebuffColors"][ColorPickerFrame.frame:GetID()]["r"] = r;
	CT_RAMenu_Options["temp"]["DebuffColors"][ColorPickerFrame.frame:GetID()]["g"] = g;
	CT_RAMenu_Options["temp"]["DebuffColors"][ColorPickerFrame.frame:GetID()]["b"] = b;
	getglobal(ColorPickerFrame.frame:GetName() .. "SwatchNormalTexture"):SetVertexColor(r, g, b);
end

function CT_RAMenuDebuff_SetOpacity()
	local type = getglobal(ColorPickerFrame.frame:GetName() .. "Text"):GetText();
	local a = OpacitySliderFrame:GetValue();
	CT_RAMenu_Options["temp"]["DebuffColors"][ColorPickerFrame.frame:GetID()]["a"] = a;
end

function CT_RAMenuBuff_Move(move)

	if ( string.find(this:GetParent():GetName(), "Debuff") ) then
		-- Debuff
		if ( not getglobal("CT_RAMenuFrameBuffsDebuff" .. (this:GetParent():GetID()+move) .. "Text") ) then return; end
		local temp = getglobal("CT_RAMenuFrameBuffsDebuff" .. (this:GetParent():GetID()+move) .. "Text"):GetText();
		local temp2 = getglobal(this:GetParent():GetName() .. "Text"):GetText();
		getglobal("CT_RAMenuFrameBuffsDebuff" .. (this:GetParent():GetID()+move) .. "Text"):SetText(temp2);
		getglobal(this:GetParent():GetName() .. "Text"):SetText(temp);

		local temparr = CT_RAMenu_Options["temp"]["DebuffColors"][this:GetParent():GetID()];
		local temparr2 = CT_RAMenu_Options["temp"]["DebuffColors"][this:GetParent():GetID()+move];
		CT_RAMenu_Options["temp"]["DebuffColors"][this:GetParent():GetID()] = temparr2;
		CT_RAMenu_Options["temp"]["DebuffColors"][this:GetParent():GetID()+move] = temparr;

		getglobal("CT_RAMenuFrameBuffsDebuff" .. this:GetParent():GetID()+move .. "SwatchNormalTexture"):SetVertexColor(temparr.r, temparr.g, temparr.b);
		getglobal("CT_RAMenuFrameBuffsDebuff" .. this:GetParent():GetID() .. "SwatchNormalTexture"):SetVertexColor(temparr2.r, temparr2.g, temparr2.b);

		if ( temparr2["id"] ~= -1 ) then
			getglobal(this:GetParent():GetName() .. "CheckButton"):SetChecked(1);
			getglobal(this:GetParent():GetName() .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal(this:GetParent():GetName() .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal(this:GetParent():GetName() .. "CheckButton"):SetChecked(nil);
		end
		if ( temparr["id"] ~= -1 ) then
			getglobal("CT_RAMenuFrameBuffsDebuff" .. (this:GetParent():GetID()+move) .. "CheckButton"):SetChecked(1);
			getglobal("CT_RAMenuFrameBuffsDebuff" .. (this:GetParent():GetID()+move) .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal("CT_RAMenuFrameBuffsDebuff" .. (this:GetParent():GetID()+move) .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsDebuff" .. (this:GetParent():GetID()+move) .. "CheckButton"):SetChecked(nil);
		end

	else
		-- Buff
		if ( not getglobal("CT_RAMenuFrameBuffsBuff" .. (this:GetParent():GetID()+move) .. "Text") ) then return; end
		local temp = getglobal("CT_RAMenuFrameBuffsBuff" .. (this:GetParent():GetID()+move) .. "Text"):GetText();
		local temp2 = getglobal(this:GetParent():GetName() .. "Text"):GetText();
		getglobal("CT_RAMenuFrameBuffsBuff" .. (this:GetParent():GetID()+move) .. "Text"):SetText(temp2);
		getglobal(this:GetParent():GetName() .. "Text"):SetText(temp);

		local temparr = CT_RAMenu_Options["temp"]["BuffArray"][this:GetParent():GetID()];
		local temparr2 = CT_RAMenu_Options["temp"]["BuffArray"][this:GetParent():GetID()+move];
		CT_RAMenu_Options["temp"]["BuffArray"][this:GetParent():GetID()] = temparr2;
		CT_RAMenu_Options["temp"]["BuffArray"][this:GetParent():GetID()+move] = temparr;
		if ( temparr2["show"] ~= -1 ) then
			getglobal(this:GetParent():GetName() .. "CheckButton"):SetChecked(1);
			getglobal(this:GetParent():GetName() .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal(this:GetParent():GetName() .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal(this:GetParent():GetName() .. "CheckButton"):SetChecked(nil);
		end
		if ( temparr["show"] ~= -1 ) then
			getglobal("CT_RAMenuFrameBuffsBuff" .. (this:GetParent():GetID()+move) .. "CheckButton"):SetChecked(1);
			getglobal("CT_RAMenuFrameBuffsBuff" .. (this:GetParent():GetID()+move) .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal("CT_RAMenuFrameBuffsBuff" .. (this:GetParent():GetID()+move) .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsBuff" .. (this:GetParent():GetID()+move) .. "CheckButton"):SetChecked(nil);
		end
	end
	CT_RA_UpdateRaidGroup(2);
end
	
function CT_RAMenuBuff_ShowToggle()
	local newid;
	if ( this:GetChecked() ) then
		newid = this:GetParent():GetID();
		getglobal(this:GetParent():GetName() .. "Text"):SetTextColor(1, 1, 1);
	else
		getglobal(this:GetParent():GetName() .. "Text"):SetTextColor(0.3, 0.3, 0.3);
		newid = -1;
	end
	local type = getglobal(this:GetParent():GetName() .. "Text"):GetText();
	if ( string.find(this:GetParent():GetName(), "Debuff") ) then
		-- Debuff
		CT_RAMenu_Options["temp"]["DebuffColors"][this:GetParent():GetID()].id = newid;
	else
		-- Buff
		if ( this:GetChecked() ) then
			CT_RAMenu_Options["temp"]["BuffArray"][this:GetParent():GetID()]["show"] = 1;
		else
			CT_RAMenu_Options["temp"]["BuffArray"][this:GetParent():GetID()]["show"] = -1;
		end
	end
	CT_RA_UpdateRaidGroup(2);
end

function CT_RAMenuDisplay_ShowMP()
	CT_RAMenu_Options["temp"]["HideMP"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
	CT_RA_UpdateMTs();
end

function CT_RAMenuDisplay_ShowRP()
	CT_RAMenu_Options["temp"]["HideRP"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
	CT_RA_UpdateMTs();
end

function CT_RAMenuDisplay_ShowHealth()
	if ( not this:GetChecked() ) then
		CT_RAMenu_Options["temp"]["MemberHeight"] = CT_RAMenu_Options["temp"]["MemberHeight"]+8;
	else
		CT_RAMenu_Options["temp"]["MemberHeight"] = CT_RAMenu_Options["temp"]["MemberHeight"]-8;
	end
	CT_RA_UpdateRaidGroup(0);
	CT_RA_UpdateMTs();
end

function CT_RAMenuDisplay_ShowHP()
	if ( this:GetChecked() ) then
		if ( CT_RAMenuFrameGeneralDisplayShowHPPercentCB:GetChecked() ) then
			CT_RAMenu_Options["temp"]["ShowHP"] = 2;
		else
			CT_RAMenu_Options["temp"]["ShowHP"] = 1;
		end
	else
		CT_RAMenu_Options["temp"]["ShowHP"] = nil;
	end
	if ( this:GetChecked() ) then
		CT_RAMenuFrameGeneralDisplayHealthPercentsText:SetTextColor(1, 1, 1);
		CT_RAMenuFrameGeneralDisplayShowHPPercentCB:Enable();
		CT_RAMenuFrameGeneralDisplayShowHPSwatchNormalTexture:SetVertexColor(CT_RAMenu_Options["temp"]["PercentColor"].r, CT_RAMenu_Options["temp"]["PercentColor"].g, CT_RAMenu_Options["temp"]["PercentColor"].b);
		CT_RAMenuFrameGeneralDisplayShowHPSwatchBG:SetVertexColor(1, 1, 1);
	else
		CT_RAMenuFrameGeneralDisplayHealthPercentsText:SetTextColor(0.3, 0.3, 0.3);
		CT_RAMenuFrameGeneralDisplayShowHPPercentCB:Disable();
		CT_RAMenuFrameGeneralDisplayShowHPSwatchNormalTexture:SetVertexColor(0.3, 0.3, 0.3);
		CT_RAMenuFrameGeneralDisplayShowHPSwatchBG:SetVertexColor(0.3, 0.3, 0.3);
	end
	for i = 1, GetNumRaidMembers(), 1 do
		if ( CT_RA_Stats[UnitName("raid" .. i)] ) then
			CT_RA_UpdateUnitHealth(getglobal("CT_RAMember" .. i), CT_RA_Stats[UnitName("raid" .. i)]["Health"], CT_RA_Stats[UnitName("raid" .. i)]["Healthmax"]);
		end
	end
	CT_RA_UpdateMTs();
end

function CT_RAMenuDisplay_ShowHPPercents()
	if ( this:GetChecked() ) then
		CT_RAMenu_Options["temp"]["ShowHP"] = 2;
	else
		CT_RAMenu_Options["temp"]["ShowHP"] = 1;
	end
	for i = 1, GetNumRaidMembers(), 1 do
		if ( CT_RA_Stats[UnitName("raid" .. i)] ) then
			CT_RA_UpdateUnitHealth(getglobal("CT_RAMember" .. i), CT_RA_Stats[UnitName("raid" .. i)]["Health"], CT_RA_Stats[UnitName("raid" .. i)]["Healthmax"]);
		end
	end
end

function CT_RAMenuDisplay_ShowGroupNames()
	CT_RAMenu_Options["temp"]["HideNames"] = not this:GetChecked();
	CT_RA_UpdateVisibility();
end

function CT_RAMenuDisplay_ChangeWC()
	local frame = this:GetParent();
	frame.r = CT_RAMenu_Options["temp"]["DefaultColor"]["r"];
	frame.g = CT_RAMenu_Options["temp"]["DefaultColor"]["g"];
	frame.b = CT_RAMenu_Options["temp"]["DefaultColor"]["b"];
	frame.opacity = CT_RAMenu_Options["temp"]["DefaultColor"]["a"];
	frame.opacityFunc = CT_RAMenuDisplay_SetOpacity;
	frame.swatchFunc = CT_RAMenuDisplay_SetColor;
	frame.cancelFunc = CT_RAMenuDisplay_CancelColor;
	frame.hasOpacity = 1;
	CloseMenus();
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function CT_RAMenuDisplay_SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	CT_RAMenu_Options["temp"]["DefaultColor"]["r"] = r;
	CT_RAMenu_Options["temp"]["DefaultColor"]["g"] = g;
	CT_RAMenu_Options["temp"]["DefaultColor"]["b"] = b;
	CT_RAMenuFrameGeneralDisplayWindowColorSwatchNormalTexture:SetVertexColor(r, g, b);
	CT_RA_UpdateRaidGroupColors();
end

function CT_RAMenuDisplay_SetOpacity()
	CT_RAMenu_Options["temp"]["DefaultColor"]["a"] = OpacitySliderFrame:GetValue();
	CT_RA_UpdateRaidGroupColors();
end

function CT_RAMenuDisplay_CancelColor(val)
	CT_RAMenu_Options["temp"]["DefaultColor"]["r"] = val.r;
	CT_RAMenu_Options["temp"]["DefaultColor"]["g"] = val.g;
	CT_RAMenu_Options["temp"]["DefaultColor"]["b"] = val.b;
	CT_RAMenu_Options["temp"]["DefaultColor"]["a"] = val.opacity;
	CT_RAMenuFrameGeneralDisplayWindowColorSwatchNormalTexture:SetVertexColor(val.r, val.g, val.b);
	CT_RA_UpdateRaidGroupColors();
end

function CT_RAMenuDisplay_LockGroups()
	CT_RAMenu_Options["temp"]["LockGroups"] = this:GetChecked();
	CT_RA_UpdateVisibility();
end

function CT_RAMenuFrameGeneralMiscDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RAMenuFrameGeneralMiscDropDown_Initialize);
	UIDropDownMenu_SetWidth(130);
	UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralMiscDropDown, 1);
end

function CT_RAMenuFrameGeneralMiscDropDown_Initialize()
	local info = {};
	info.text = "Group";
	info.func = CT_RAMenuFrameGeneralMiscDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Class";
	info.func = CT_RAMenuFrameGeneralMiscDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Custom";
	info.func = CT_RAMenuFrameGeneralMiscDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Virtual";
	info.func = CT_RAMenuFrameGeneralMiscDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end


function CT_RAMenuFrameGeneralMiscDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralMiscDropDown, this:GetID());
	if ( this:GetID() == 1 ) then
		CT_RA_SetSortType("group");
	elseif ( this:GetID() == 2 ) then
		CT_RA_SetSortType("class");
	elseif ( this:GetID() == 3 ) then
		CT_RA_SetSortType("custom");
	elseif ( this:GetID() == 4 ) then
		CT_RA_SetSortType("virtual");
	end
	CT_RA_UpdateRaidGroup(0);
	CT_RA_UpdateMTs();
	CT_RAOptions_Update();
end

function CT_RAMenuFrameBuffsBuffsDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RAMenuFrameBuffsBuffsDropDown_Initialize);
	UIDropDownMenu_SetWidth(180);
	UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 1);
end

function CT_RAMenuFrameBuffsBuffsDropDown_Initialize()
	local info = {};
	info.text = "Show buffs";
	info.func = CT_RAMenuFrameBuffsBuffsDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Show debuffs";
	info.func = CT_RAMenuFrameBuffsBuffsDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Show buffs until debuffed";
	info.func = CT_RAMenuFrameBuffsBuffsDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end


function CT_RAMenuFrameBuffsBuffsDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, this:GetID());
	if ( this:GetID() == 1 ) then
		CT_RAMenu_Options["temp"]["ShowDebuffs"] = nil;
		CT_RAMenu_Options["temp"]["ShowBuffsDebuffed"] = nil;
	elseif ( this:GetID() == 2 ) then
		CT_RAMenu_Options["temp"]["ShowDebuffs"] = 1;
		CT_RAMenu_Options["temp"]["ShowBuffsDebuffed"] = nil;
	else
		CT_RAMenu_Options["temp"]["ShowDebuffs"] = nil;
		CT_RAMenu_Options["temp"]["ShowBuffsDebuffed"] = 1;
	end
	CT_RA_UpdateRaidGroup(0);
	CT_RA_UpdateMTs();
	CT_RAOptions_Update();
end

function CT_RAMenuFrameGeneralDisplayHealthDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RAMenuFrameGeneralDisplayHealthDropDown_Initialize);
	UIDropDownMenu_SetWidth(130);
	UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, 1);
end

function CT_RAMenuFrameGeneralDisplayHealthDropDown_Initialize()
	local info = {};
	info.text = "Show Values";
	info.func = CT_RAMenuFrameGeneralDisplayHealthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Show Percentages";
	info.func = CT_RAMenuFrameGeneralDisplayHealthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Show Deficit";
	info.func = CT_RAMenuFrameGeneralDisplayHealthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Show only MTT HP %";
	info.func = CT_RAMenuFrameGeneralDisplayHealthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Show None";
	info.func = CT_RAMenuFrameGeneralDisplayHealthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end


function CT_RAMenuFrameGeneralDisplayHealthDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, this:GetID());
	if ( this:GetID() < 5 ) then
		CT_RAMenu_Options["temp"]["ShowHP"] = this:GetID();
	else
		CT_RAMenu_Options["temp"]["ShowHP"] = nil;
	end
	CT_RA_UpdateRaidGroup(0);
	CT_RAOptions_Update();
end

function CT_RAMenu_General_ResetWindows()
	CT_RAGroupDrag1:ClearAllPoints();
	CT_RAGroupDrag2:ClearAllPoints();
	CT_RAGroupDrag3:ClearAllPoints();
	CT_RAGroupDrag4:ClearAllPoints();
	CT_RAGroupDrag5:ClearAllPoints();
	CT_RAGroupDrag6:ClearAllPoints();
	CT_RAGroupDrag7:ClearAllPoints();
	CT_RAGroupDrag8:ClearAllPoints();
	CT_RAMTGroupDrag:ClearAllPoints();
	CT_RA_EmergencyFrameDrag:ClearAllPoints();

	CT_RAGroupDrag1:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 950, -35);
	CT_RAGroupDrag2:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 950, -275);
	CT_RAGroupDrag3:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 855, -35);
	CT_RAGroupDrag4:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 855, -275);
	CT_RAGroupDrag5:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 760, -35);
	CT_RAGroupDrag6:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 760, -275);
	CT_RAGroupDrag7:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 665, -35);
	CT_RAGroupDrag8:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 665, -275);
	CT_RAMTGroupDrag:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 570, -35);
	CT_RA_EmergencyFrameDrag:SetPoint("CENTER", "UIParent", "CENTER");
	CT_RA_LinkDrag(CT_RA_EmergencyFrame, CT_RA_EmergencyFrameDrag, "TOP", "TOP", 0, -12);
	CT_RAMenu_SaveWindowPositions();
end

function CT_RAMenuDisplay_ChangeAC()
	local frame = this:GetParent();
	frame.r = CT_RAMenu_Options["temp"]["DefaultAlertColor"]["r"];
	frame.g = CT_RAMenu_Options["temp"]["DefaultAlertColor"]["g"];
	frame.b = CT_RAMenu_Options["temp"]["DefaultAlertColor"]["b"];
	frame.swatchFunc = CT_RAMenuDisplay_SetAlertColor;
	frame.cancelFunc = CT_RAMenuDisplay_CancelAlertColor;
	CloseMenus();
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function CT_RAMenuDisplay_SetAlertColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	CT_RAMenu_Options["temp"]["DefaultAlertColor"]["r"] = r;
	CT_RAMenu_Options["temp"]["DefaultAlertColor"]["g"] = g;
	CT_RAMenu_Options["temp"]["DefaultAlertColor"]["b"] = b;
	CT_RAMenuFrameGeneralDisplayAlertColorSwatchNormalTexture:SetVertexColor(r, g, b);
end

function CT_RAMenuDisplay_CancelAlertColor(val)
	CT_RAMenu_Options["temp"]["DefaultAlertColor"]["r"] = val.r;
	CT_RAMenu_Options["temp"]["DefaultAlertColor"]["g"] = val.g;
	CT_RAMenu_Options["temp"]["DefaultAlertColor"]["b"] = val.b;
	CT_RAMenuFrameGeneralDisplayAlertColorSwatchNormalTexture:SetVertexColor(val.r, val.g, val.b);
end

function CT_RAMenuDisplay_ChangeWC()
	local frame = this:GetParent();
	frame.r = CT_RAMenu_Options["temp"]["DefaultColor"]["r"];
	frame.g = CT_RAMenu_Options["temp"]["DefaultColor"]["g"];
	frame.b = CT_RAMenu_Options["temp"]["DefaultColor"]["b"];
	frame.opacity = CT_RAMenu_Options["temp"]["DefaultColor"]["a"];
	frame.opacityFunc = CT_RAMenuDisplay_SetOpacity;
	frame.swatchFunc = CT_RAMenuDisplay_SetColor;
	frame.cancelFunc = CT_RAMenuDisplay_CancelColor;
	frame.hasOpacity = 1;
	CloseMenus();
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function CT_RAMenuDisplay_ChangeTC()
	local frame = this:GetParent();
	frame.r = CT_RAMenu_Options["temp"]["PercentColor"]["r"];
	frame.g = CT_RAMenu_Options["temp"]["PercentColor"]["g"];
	frame.b = CT_RAMenu_Options["temp"]["PercentColor"]["b"];
	frame.swatchFunc = CT_RAMenuDisplayPercent_SetColor;
	frame.cancelFunc = CT_RAMenuDisplayPercent_CancelColor;
	CloseMenus();
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function CT_RAMenuDisplayPercent_SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	CT_RAMenu_Options["temp"]["PercentColor"] = { ["r"] = r, ["g"] = g, ["b"] = b };
	CT_RAMenuFrameGeneralDisplayShowHPSwatchNormalTexture:SetVertexColor(r, g, b);
	CT_RA_UpdateRaidGroupColors();
end

function CT_RAMenuDisplayPercent_CancelColor(val)
	CT_RAMenu_Options["temp"]["PercentColor"] = { r = val.r, g = val.g, b = val.b };
	CT_RAMenuFrameGeneralDisplayShowHPSwatchNormalTexture:SetVertexColor(val.r, val.g, val.b);
	CT_RA_UpdateRaidGroupColors();
end

function CT_RAMenuGeneral_HideOffline()
	CT_RAMenu_Options["temp"]["HideOffline"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
end

function CT_RAMenuGeneral_HideShort()
	CT_RAMenu_Options["temp"]["HideShort"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
end

function CT_RAMenuBuff_ShowDebuffs()
	CT_RAMenu_Options["temp"]["ShowDebuffs"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
end

function CT_RAMenuGeneral_HideBorder()
	CT_RAMenu_Options["temp"]["HideBorder"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
	CT_RA_UpdateMTs();
	CT_RA_UpdatePTs();
	if ( this:GetChecked() ) then
		CT_RAMenuFrameGeneralMiscRemoveSpacingCB:Enable();
		CT_RAMenuFrameGeneralMiscRemoveSpacingText:SetTextColor(1, 1, 1);
	else
		CT_RAMenuFrameGeneralMiscRemoveSpacingCB:Disable();
		CT_RAMenuFrameGeneralMiscRemoveSpacingText:SetTextColor(0.3, 0.3, 0.3);
	end
end

function CT_RAMenuGeneral_RemoveSpacing()
	CT_RAMenu_Options["temp"]["HideSpace"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
	CT_RA_UpdateMTs();
	CT_RA_UpdatePTs();
end

function CT_RAMenu_Misc_ShowTankDeath()
	CT_RAMenu_Options["temp"]["HideTankNotifications"] = not this:GetChecked();
end

function CT_RAMenuGeneral_ShowHorizontal()
	CT_RAMenu_Options["temp"]["ShowHorizontal"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
end

function CT_RAMenuGeneral_ShowReversed()
	CT_RAMenu_Options["temp"]["ShowReversed"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(0);
	CT_RA_UpdateMTs();
	CT_RA_UpdatePTs();
end

function CT_RAMenuGeneral_ShowMTs()
	CT_RAMenu_Options["temp"]["HideMTs"] = not this:GetChecked();
	CT_RA_UpdateRaidGroup(3);
	CT_RA_UpdateMTs();
end

function CT_RAMenuGeneral_ShowMeters()
	if ( not CT_RAMenu_Options["temp"]["StatusMeters"]  ) then
		CT_RAMenu_Options["temp"]["StatusMeters"] = {
			["Health Display"] = { },
			["Mana Display"] = { },
			["Raid Health"] = { },
			["Raid Mana"] = { },
			["Background"] = {
				["r"] = 0,
				["g"] = 0,
				["b"] = 1,
				["a"] = 0.5
			}
		};
	end
	CT_RAMenu_Options["temp"]["StatusMeters"]["Show"] = this:GetChecked();
	if ( this:GetChecked() ) then
		CT_RAMetersFrame:Show();
		CT_RAMeters_UpdateWindow();
	else
		CT_RAMetersFrame:Hide();
	end
end

function CT_RAMenuMisc_Slider_OnChange()
	local spell = CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")][this:GetID()];
	local realVal = 0;
	if ( CT_RAMenu_Options["temp"]["UsePercentValues"] ) then
		realVal = this:GetValue();
		CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")][this:GetID()][5] = realVal;
		if ( type(spell[1]) == "table" ) then
			getglobal(this:GetName() .. "Text"):SetText(spell[1][1] .. ": " .. realVal .. "%");
		else
			getglobal(this:GetName() .. "Text"):SetText(spell[1] .. ": " .. realVal .. "%");
		end
	else
		realVal = 5000-this:GetValue();
		CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")][this:GetID()][3] = realVal;
		if ( type(spell[1]) == "table" ) then
			getglobal(this:GetName() .. "Text"):SetText(spell[1][1] .. ": -" .. realVal);
		else
			getglobal(this:GetName() .. "Text"):SetText(spell[1] .. ": -" .. realVal);
		end
	end
end

function CT_RAMenuMisc_OnUpdate(elapsed)
	if ( this.scaleupdate ) then
		this.scaleupdate = this.scaleupdate - elapsed;
		if ( this.scaleupdate <= 0 ) then
			this.scaleupdate = 10;
			if ( CT_RAMenu_Options["temp"]["WindowScaling"] ) then
				local newScaling = CT_RAMenu_Options["temp"]["WindowScaling"];
				for i = 1, 40, 1 do
					if ( i <= 8 ) then
						getglobal("CT_RAGroupDrag" .. i):SetWidth(CT_RAGroup1:GetWidth()*newScaling+(22*newScaling));
						getglobal("CT_RAGroupDrag" .. i):SetHeight(CT_RAMember1:GetHeight()*newScaling/2);
						getglobal("CT_RAGroup" .. i):SetScale(newScaling);
					end
					getglobal("CT_RAMember" .. i):SetScale(newScaling);
				end
			end
			if ( CT_RAMenu_Options["temp"]["MTScaling"] ) then
				local newScaling = CT_RAMenu_Options["temp"]["MTScaling"];
				for i = 1, 10, 1 do
					getglobal("CT_RAMTGroupMember" .. i):SetScale(newScaling);
					getglobal("CT_RAPTGroupMember" .. i):SetScale(newScaling);
				end
				CT_RAMTGroup:SetScale(newScaling);
				CT_RAPTGroup:SetScale(newScaling);
				CT_RAMTGroupDrag:SetWidth(CT_RAMTGroup:GetWidth()*newScaling+(22*newScaling));
				CT_RAMTGroupDrag:SetHeight(CT_RAMTGroupMember1:GetHeight()*newScaling/2);
				CT_RAPTGroupDrag:SetWidth(CT_RAPTGroup:GetWidth()*newScaling+(22*newScaling));
				CT_RAPTGroupDrag:SetHeight(CT_RAPTGroupMember1:GetHeight()*newScaling/2);
			end
			if ( CT_RAMenu_Options["temp"]["EMScaling"] ) then
				local newScaling = CT_RAMenu_Options["temp"]["EMScaling"];
				CT_RA_EmergencyFrame:SetScale(newScaling);
				CT_RA_EmergencyFrameDrag:SetWidth(CT_RA_EmergencyFrame:GetWidth()*newScaling+(27.5*newScaling));
				CT_RA_EmergencyFrameDrag:SetHeight(CT_RA_EmergencyFrame:GetHeight()*newScaling/5);
			end
		end
	end
end

function CT_RA_SpellStartCast(spell)
	if ( spell[1] == CT_RA_RESURRECTION or spell[1] == CT_RA_ANCESTRALSPIRIT or spell[1] == CT_RA_REBIRTH or spell[1] == CT_RA_REDEMPTION ) then
		CT_RA_AddMessage("RES " .. spell[2]);
		CT_RA_Ressers[UnitName("player")] = spell[2];
		CT_RA_UpdateResFrame();
	end
end

function CT_RA_SpellEndCast()
	if ( CT_RA_Ressers[UnitName("player")] ) then
		CT_RA_AddMessage("RESNO");
	end
end

function CT_RAMenuMisc_OnEvent(event)
	if ( event == "PLAYER_REGEN_ENABLED" ) then
		CT_RA_InCombat = nil;
	elseif ( event == "PLAYER_REGEN_DISABLED" ) then
		CT_RA_InCombat = 1;
	end
end

function CT_RAMenuAdditional_Scaling_OnShow(slider)
	if ( not slider ) then
		slider = this;
	end
	getglobal(slider:GetName().."High"):SetText("150%");
	getglobal(slider:GetName().."Low"):SetText("50%");
	if ( not CT_RAMenu_Options["temp"]["WindowScaling"] ) then
		CT_RAMenu_Options["temp"]["WindowScaling"] = 1;
	end
	getglobal(slider:GetName() .. "Text"):SetText("Group Scaling - " .. floor(CT_RAMenu_Options["temp"]["WindowScaling"]*100+0.5) .. "%");

	slider:SetMinMaxValues(0.5, 1.5);
	slider:SetValueStep(0.01);
	slider:SetValue(CT_RAMenu_Options["temp"]["WindowScaling"]);
end

function CT_RAMenuAdditional_Scaling_OnValueChanged()
	CT_RAMenu_Options["temp"]["WindowScaling"] = floor(this:GetValue()*100+0.5)/100;
	getglobal(this:GetName() .. "Text"):SetText("Group Scaling - " .. floor(this:GetValue()*100+0.5) .. "%");
	local newScaling = CT_RAMenu_Options["temp"]["WindowScaling"];
	for i = 1, 40, 1 do
		if ( i <= 8 ) then
			getglobal("CT_RAGroupDrag" .. i):SetWidth(CT_RAGroup1:GetWidth()*newScaling+(22*newScaling));
			getglobal("CT_RAGroupDrag" .. i):SetHeight(CT_RAMember1:GetHeight()*newScaling/2);
			getglobal("CT_RAGroup" .. i):SetScale(newScaling);
		end
		getglobal("CT_RAMember" .. i):SetScale(newScaling);
	end
end

function CT_RAMenuAdditional_EM_OnShow(slider)
	if ( not slider ) then
		slider = this;
	end
	local id = slider:GetID();
	
	if ( not CT_RAMenu_Options["temp"]["EMThreshold"] ) then
		CT_RAMenu_Options["temp"]["EMThreshold"] = 0.9;
	end
	if ( not CT_RAMenu_Options["temp"]["EMScaling"] ) then
		CT_RAMenu_Options["temp"]["EMScaling"] = 1;
	end
	
	local tbl = {
		["hl"] = {
			{ "99%", "25%" },
			{ "150%", "50%" }
		},
		["title"] = {
			"Health Threshold - " .. floor(CT_RAMenu_Options["temp"]["EMThreshold"]*100+0.5) .. "%",
			"Scaling - " .. floor(CT_RAMenu_Options["temp"]["EMScaling"]*100+0.5) .. "%"
		},
		["tooltip"] = {
			"Regulates the health threshold of when to display the health bars.",
			"Rescales the window to make it larger or smaller."
		},
		["minmax"] = {
			{ 0.25, 0.99 },
			{ 0.5, 1.5 }
		},
		["value"] = {
			CT_RAMenu_Options["temp"]["EMThreshold"],
			CT_RAMenu_Options["temp"]["EMScaling"]
		}
	};
	getglobal(slider:GetName().."High"):SetText(tbl["hl"][id][1]);
	getglobal(slider:GetName().."Low"):SetText(tbl["hl"][id][2]);
	getglobal(slider:GetName() .. "Text"):SetText(tbl["title"][id]);
	slider.tooltipText = tbl["tooltip"][id];
	slider:SetMinMaxValues(tbl["minmax"][id][1], tbl["minmax"][id][2]);
	slider:SetValueStep(0.01);
	slider:SetValue(tbl["value"][id]);
end

function CT_RAMenuAdditional_EM_OnValueChanged()
	if ( this:GetID() == 1 ) then
		CT_RAMenu_Options["temp"]["EMThreshold"] = floor(this:GetValue()*100+0.5)/100;
		getglobal(this:GetName() .. "Text"):SetText("Health Threshold - " .. floor(this:GetValue()*100+0.5) .. "%");
		CT_RA_Emergency_UpdateHealth();
	else
		CT_RAMenu_Options["temp"]["EMScaling"] = floor(this:GetValue()*100+0.5)/100;
		getglobal(this:GetName() .. "Text"):SetText("Scaling - " .. floor(this:GetValue()*100+0.5) .. "%");
		
		local newScaling = CT_RAMenu_Options["temp"]["EMScaling"];
		CT_RA_EmergencyFrame:SetScale(newScaling);
		CT_RA_EmergencyFrameDrag:SetWidth(CT_RA_EmergencyFrame:GetWidth()*newScaling+(27.5*newScaling));
		CT_RA_EmergencyFrameDrag:SetHeight(CT_RA_EmergencyFrame:GetHeight()*newScaling/5);
	end
end

function CT_RAMenuAdditional_BG_OnShow(slider)
	if ( not slider ) then
		slider = this;
	end
	if ( not CT_RAMenu_Options["temp"]["BGOpacity"] ) then
		CT_RAMenu_Options["temp"]["BGOpacity"] = 0.4;
	end
	getglobal(slider:GetName().."High"):SetText("75%");
	getglobal(slider:GetName().."Low"):SetText("0%");
	getglobal(slider:GetName() .. "Text"):SetText("Background Opacity - " .. floor(CT_RAMenu_Options["temp"]["BGOpacity"]*100+0.5) .. "%");

	slider:SetMinMaxValues(0, 0.75);
	slider:SetValueStep(0.01);
	slider:SetValue(CT_RAMenu_Options["temp"]["BGOpacity"]);
end

function CT_RAMenuAdditional_BG_OnValueChanged()
	CT_RAMenu_Options["temp"]["BGOpacity"] = floor(this:GetValue()*100+0.5)/100;
	getglobal(this:GetName() .. "Text"):SetText("Background Opacity - " .. floor(this:GetValue()*100+0.5) .. "%");
	CT_RA_UpdateRaidGroup(1);
end

function CT_RAMenuAdditional_Alpha_OnShow(slider)
	if ( not slider ) then
		slider = this;
	end
	if ( not CT_RAMenu_Options["temp"]["DefaultAlpha"] ) then
		CT_RAMenu_Options["temp"]["DefaultAlpha"] = 1;
	end
	local val = CT_RAMenu_Options["temp"]["DefaultAlpha"];
	local formattedVal = floor(val*100+0.5)
	getglobal(slider:GetName().."High"):SetText("Off");
	getglobal(slider:GetName().."Low"):SetText("25%");
	
	if ( formattedVal == 100 ) then
		getglobal(slider:GetName() .. "Text"):SetText("Frame Alpha - Off (100%)");
	else
		getglobal(slider:GetName() .. "Text"):SetText("Frame Alpha - " .. formattedVal .. "%");
	end

	slider:SetMinMaxValues(0.25, 1);
	slider:SetValueStep(0.01);
	slider:SetValue(val);
end

function CT_RAMenuAdditional_Alpha_OnValueChanged()
	CT_RAMenu_Options["temp"]["DefaultAlpha"] = floor(this:GetValue()*100+0.5)/100;
	local formattedVal = floor(this:GetValue()*100+0.5);
	if ( formattedVal == 100 ) then
		getglobal(this:GetName() .. "Text"):SetText("Frame Alpha - Off (100%)");
	else
		getglobal(this:GetName() .. "Text"):SetText("Frame Alpha - " .. formattedVal .. "%");
	end
	-- Update the health specifically
	for i = 1, 40, 1 do
		CT_RA_UpdateUnitHealth(getglobal("CT_RAMember"..i));
	end
end

function CT_RAMenuAdditional_ScalingMT_OnShow(slider)
	if ( not slider ) then
		slider = this;
	end
	getglobal(slider:GetName().."High"):SetText("150%");
	getglobal(slider:GetName().."Low"):SetText("50%");
	if ( not CT_RAMenu_Options["temp"]["MTScaling"] ) then
		CT_RAMenu_Options["temp"]["MTScaling"] = 1;
	end
	getglobal(slider:GetName() .. "Text"):SetText("MT/PT Scaling - " .. floor(CT_RAMenu_Options["temp"]["MTScaling"]*100+0.5) .. "%");

	slider:SetMinMaxValues(0.5, 1.5);
	slider:SetValueStep(0.01);
	slider:SetValue(CT_RAMenu_Options["temp"]["MTScaling"]);
end

function CT_RAMenuAdditional_ScalingMT_OnValueChanged()
	CT_RAMenu_Options["temp"]["MTScaling"] = floor(this:GetValue()*100+0.5)/100;
	getglobal(this:GetName() .. "Text"):SetText("MT/PT Scaling - " .. floor(this:GetValue()*100+0.5) .. "%");
	
	local newScaling = CT_RAMenu_Options["temp"]["MTScaling"];
	for i = 1, 10, 1 do
		getglobal("CT_RAMTGroupMember" .. i):SetScale(newScaling);
		getglobal("CT_RAPTGroupMember" .. i):SetScale(newScaling);
	end
	CT_RAMTGroup:SetScale(newScaling);
	CT_RAPTGroup:SetScale(newScaling);
	CT_RAMTGroupDrag:SetWidth(CT_RAMTGroup:GetWidth()*newScaling+(22*newScaling));
	CT_RAMTGroupDrag:SetHeight(CT_RAMTGroupMember1:GetHeight()*newScaling/2);
	CT_RAPTGroupDrag:SetWidth(CT_RAPTGroup:GetWidth()*newScaling+(22*newScaling));
	CT_RAPTGroupDrag:SetHeight(CT_RAPTGroupMember1:GetHeight()*newScaling/2);
end

function CT_RA_GetLocale()
	local locale = strsub(GetLocale(), 1, 2);
	if ( locale == "fr" or locale == "de" ) then
		return locale;
	else
		return "en";
	end
end

function CT_RAMenu_Misc_PlaySound()
	CT_RAMenu_Options["temp"]["PlayRSSound"] = this:GetChecked();
end

function CT_RAMenu_Misc_AggroNotifier()
	CT_RAMenu_Options["temp"]["AggroNotifier"] = this:GetChecked();
	if ( not this:GetChecked() ) then
		CT_RAMenuFrameMiscNotificationsAggroNotifierSoundCB:Disable();
		CT_RAMenuFrameMiscNotificationsAggroNotifierSound:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscNotificationsAggroNotifierSoundCB:Enable();
		CT_RAMenuFrameMiscNotificationsAggroNotifierSound:SetTextColor(1, 1, 1);
	end
end

function CT_RAMenu_Misc_AggroNotifierSound()
	CT_RAMenu_Options["temp"]["AggroNotifierSound"] = this:GetChecked();
end

function CT_RAMenu_Additional_ShowEmergency()
	CT_RAMenu_Options["temp"]["ShowEmergency"] = this:GetChecked();
	if ( not this:GetChecked() ) then
		CT_RAMenuFrameAdditionalEMPartyCB:Disable();
		CT_RAMenuFrameAdditionalEMPartyText:SetTextColor(0.3, 0.3, 0.3);
		CT_RAMenuFrameAdditionalEMOutsideRaidCB:Disable();
		CT_RAMenuFrameAdditionalEMOutsideRaidText:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameAdditionalEMPartyCB:Enable();
		CT_RAMenuFrameAdditionalEMPartyText:SetTextColor(1, 1, 1);
		CT_RAMenuFrameAdditionalEMOutsideRaidCB:Enable();
		CT_RAMenuFrameAdditionalEMOutsideRaidText:SetTextColor(1, 1, 1);
	end
	CT_RA_Emergency_UpdateHealth();
end

function CT_RAMenu_Additional_ShowEmergencyParty()
	CT_RAMenu_Options["temp"]["ShowEmergencyParty"] = this:GetChecked();
	CT_RA_Emergency_UpdateHealth();
end

function CT_RAMenu_Additional_ShowEmergencyOutsideRaid()
	CT_RAMenu_Options["temp"]["ShowEmergencyOutsideRaid"] = this:GetChecked();
	CT_RA_Emergency_UpdateHealth();
end

function CT_RAMenu_Misc_SendRARS()
	CT_RAMenu_Options["temp"]["SendRARS"] = this:GetChecked();
end

function CT_RAMenu_Misc_ShowAFK()
	CT_RAMenu_Options["temp"]["ShowAFK"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(1);
end

function CT_RAMenu_Misc_ShowPTT()
	CT_RAMenu_Options["temp"]["ShowPTT"] = this:GetChecked();
	CT_RA_UpdatePTs();
end

function CT_RAMenu_Misc_ShowMTTT()
	CT_RAMenu_Options["temp"]["ShowMTTT"] = this:GetChecked();
	if ( not this:GetChecked() ) then
		CT_RAMenuFrameMiscDisplayNoColorChangeCB:Disable();
		CT_RAMenuFrameMiscDisplayNoColorChange:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscDisplayNoColorChangeCB:Enable();
		CT_RAMenuFrameMiscDisplayNoColorChange:SetTextColor(1, 1, 1);
	end
	CT_RA_UpdateMTs();
end

function CT_RAMenu_Misc_NoColorChange()
	CT_RAMenu_Options["temp"]["HideColorChange"] = this:GetChecked();
end

function CT_RAMenu_Misc_ShowTooltip()
	CT_RAMenu_Options["temp"]["HideTooltip"] = not this:GetChecked();
end

function CT_RAMenu_Misc_DisableQuery()
	CT_RAMenu_Options["temp"]["DisableQuery"] = this:GetChecked();
end

function CT_RAMenu_Misc_ShowResMonitor()
	CT_RAMenu_Options["temp"]["ShowMonitor"] = this:GetChecked();
	if ( this:GetChecked() and GetNumRaidMembers() > 0 ) then
		CT_RA_ResFrame:Show();
	else
		CT_RA_ResFrame:Hide();
	end
end

function CT_RAMenu_Misc_HideButton()
	CT_RAMenu_Options["temp"]["HideButton"] = this:GetChecked();
	if ( this:GetChecked() ) then
		CT_RASets_Button:Hide();
	else
		CT_RASets_Button:Show();
	end
end

function CT_RAMenuGeneral_SortAlpha()
	CT_RAMenu_Options["temp"]["SubSortByName"] = this:GetChecked();
	CT_RA_UpdateRaidGroup(3);
	CT_RAOptions_Update();
end

function CT_RAMenu_Misc_ColorLeader()
	if ( CT_RAMenu_Options["temp"]["leaderColor"] ) then
		CT_RAMenu_Options["temp"]["leaderColor"].enabled = this:GetChecked();
	else
		CT_RAMenu_Options["temp"]["leaderColor"] = {
			r = 1, g = 1, b = 0, enabled = true
		};
	end
end

function CT_RAMenu_Misc_ColorLeader_ShowColorPicker(frame)
	if ( not CT_RAMenu_Options["temp"]["leaderColor"] ) then
		CT_RAMenu_Options["temp"]["leaderColor"] = {
			r = 1, g = 1, b = 0, enabled = true
		};
	end
	frame.r = CT_RAMenu_Options["temp"]["leaderColor"].r;
	frame.g = CT_RAMenu_Options["temp"]["leaderColor"].g;
	frame.b = CT_RAMenu_Options["temp"]["leaderColor"].b;
	frame.swatchFunc = CT_RAMenu_Misc_ColorLeader_SetColor;
	frame.cancelFunc = CT_RAMenu_Misc_ColorLeader_CancelColor;
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function CT_RAMenu_Misc_ColorLeader_SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	CT_RAMenu_Options["temp"]["leaderColor"].r = r;
	CT_RAMenu_Options["temp"]["leaderColor"].g = g;
	CT_RAMenu_Options["temp"]["leaderColor"].b = b;
	CT_RAMenuFrameMiscDisplayColorLeaderColorSwatchNormalTexture:SetVertexColor(CT_RAMenu_Options["temp"]["leaderColor"].r, CT_RAMenu_Options["temp"]["leaderColor"].g, CT_RAMenu_Options["temp"]["leaderColor"].b);
end

function CT_RAMenu_Misc_ColorLeader_CancelColor()
	CT_RAMenu_Options["temp"]["leaderColor"].r = CT_RAMenuFrameMiscDisplayColorLeaderColorSwatch.r;
	CT_RAMenu_Options["temp"]["leaderColor"].g = CT_RAMenuFrameMiscDisplayColorLeaderColorSwatch.g;
	CT_RAMenu_Options["temp"]["leaderColor"].b = CT_RAMenuFrameMiscDisplayColorLeaderColorSwatch.b;
	CT_RAMenuFrameMiscDisplayColorLeaderColorSwatchNormalTexture:SetVertexColor(CT_RAMenu_Options["temp"]["leaderColor"].r, CT_RAMenu_Options["temp"]["leaderColor"].g, CT_RAMenu_Options["temp"]["leaderColor"].b);
end

function CT_RAMenu_Misc_NotifyGroupChange()
	CT_RAMenu_Options["temp"]["NotifyGroupChange"] = this:GetChecked();
	if ( not this:GetChecked() ) then
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCBSound:Disable();
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeSound:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCBSound:Enable();
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeSound:SetTextColor(1, 1, 1);
	end
end

function CT_RAMenu_Misc_NotifyGroupChangeSound()
	CT_RAMenu_Options["temp"]["NotifyGroupChangeSound"] = this:GetChecked();
end

function CT_RA_UpdateResFrame()
	local text = "";
	local playerTarget, playerName = UnitName("target"), UnitName("player");
	for key, val in CT_RA_Ressers do
		if ( strlen(text) > 0 ) then
			text = text .. "\n";
		end
		if ( val == playerTarget and key ~= playerName ) then
			-- Color gold if we're targeting this player.
			text = text .. "|c00FFD100" .. key .. ": " .. val .. "|r";
		else
			text = text .. key .. ": " .. val;
		end
	end
	CT_RA_ResFrameText:SetText(text);
	CT_RA_ResFrame:SetWidth(max(CT_RA_ResFrameText:GetWidth()+15, 175));
	CT_RA_ResFrame:SetHeight(max(CT_RA_ResFrameText:GetHeight()+25, 50));
end

function CT_RAMenuHelp_LoadText()
	local texts = {
		"|c00FFFFFFShow Group Names -|r Turns on/off the headers for each group\n\n|c00FFFFFFLock Group Positions -|r Locks all CTRA windows in place\n\n|c00FFFFFFHide Mana Bars -|r Hides all players mana bars\n\n|c00FFFFFFHide Health Bars -|r Hides all players health bars\n\n|c00FFFFFFHide Rage/Energy Bars -|r Hides all players rage and energy bars\n\n|c00FFFFFFHealth Type -|r Allows you to show players health as a percentage,\nactual value, missing hp, only the percentage on MainTank targets,\nor not at all. You can also customize the color the text is shown in\n\n|c00FFFFFFWindow BG Color -|r Changes the color of CTRA window\nbackgrounds, dragging the slider all the way to 100%\nmakes them transparent\n\n|c00FFFFFFAlert Message Color -|r Sets the color the /rs alert messages\nshow in the middle of your screen",
		"|c00FFFFFFHide offline members -|r Allows you to hide members who\nare offline, so they don't show in CTRA groups\n\n|c00FFFFFFHide short duration debuffs -|r Allows you to hide debuffs with\na duration under 10 seconds\n\n|c00FFFFFFHide border -|r Allows you to hide the border of each CTRA window\n\n|c00FFFFFFSort Type -|r Sort by either group, class, or custom.Sorting\nby Class displays each member in a class category, sorting\nby Custom allows you to change who shows up in which groups",
		"Allows you to be notified via chat when someone\nbecomes debuffed with the types listed above,\nas well as allows you to be notified when someone\nloses a buff you are able to recast\n\n|c00FFFFFFNOTE:|r To quickly debuff a cured player, or recast a\nfaded buff, map a hotkey via the game key bindings\nmenu (|c00FFFFFFEscape|r > |c00FFFFFFKey Bindings|r > |c00FFFFFFCT_RaidAssist section|r)\nto one-click recast or cure";
		"Allows you to scale the CTRA group and MT windows.",
		CT_RAMENU_BUFFSDESCRIPT,
		CT_RAMENU_BUFFSTOOLTIP,
		CT_RAMENU_DEBUFFSTOOLTIP,
		CT_RAMENU_ADDITIONALEMTOOLTIP,
		"Allows you to change the name and details of the selected set. In any of the three bottom fields, you can use an asterix (|c00FFFFFF*|r) as a wildcard for zero or more characters. You can also use regular expressions, if you have the knowledge to use that.",
		"Allows you to regulate the classes this set will attempt to cure matching debuffs on."
	};
	this.text = texts[this:GetID()];
end

function CT_RAMenuHelp_SetTooltip()
	local uiX, uiY = UIParent:GetCenter();
	local thisX, thisY = this:GetCenter();

	local anchor = "";
	if ( thisY > uiY ) then
		anchor = "BOTTOM";
	else
		anchor = "TOP";
	end
	
	if ( thisX < uiX  ) then
		if ( anchor == "TOP" ) then
			anchor = "TOPLEFT";
		else
			anchor = "BOTTOMRIGHT";
		end
	else
		if ( anchor == "TOP" ) then
			anchor = "TOPRIGHT";
		else
			anchor = "BOTTOMLEFT";
		end
	end
	GameTooltip:SetOwner(this, "ANCHOR_" .. anchor);
end

function CT_RAMenu_SaveWindowPositions()
	CT_RAMenu_Options["temp"]["WindowPositions"] = { };
	local left, top, uitop;
	for i = 1, 8, 1 do
		local frame = getglobal("CT_RAGroupDrag" .. i);
		left, top, uitop = frame:GetLeft(), frame:GetTop(), UIParent:GetTop();
		if ( left and top and uitop ) then
			CT_RAMenu_Options["temp"]["WindowPositions"][frame:GetName()] = { left, top-uitop };
		end
	end
	left, top, uitop = CT_RAMTGroupDrag:GetLeft(), CT_RAMTGroupDrag:GetTop(), UIParent:GetTop();
	if ( left and top and uitop ) then
		CT_RAMenu_Options["temp"]["WindowPositions"]["CT_RAMTGroupDrag"] = { left, top-uitop };
	end
	left, top, uitop = CT_RA_EmergencyFrameDrag:GetLeft(), CT_RA_EmergencyFrameDrag:GetTop(), UIParent:GetTop();
	if ( left and top and uitop ) then
		CT_RAMenu_Options["temp"]["WindowPositions"]["CT_RA_EmergencyFrameDrag"] = { left, top-uitop };
	end
end

function CT_RAMenu_UpdateWindowPositions()
	if ( CT_RAMenu_Options["temp"]["WindowPositions"] ) then
		for k, v in CT_RAMenu_Options["temp"]["WindowPositions"] do
			getglobal(k):ClearAllPoints();
			getglobal(k):SetPoint("TOPLEFT" , "UIParent", "TOPLEFT", v[1], v[2]);
		end
	end
end

function CT_RAMenu_CopyTable(source)
	local dest = { };
	if ( type(source) == "table" ) then
		for k, v in source do
			dest[k] = CT_RAMenu_CopyTable(v);
		end
		return dest;
	else
		return source;
	end
end

function CT_RAMenu_CopySet(copyFrom, copyTo)
	CT_RAMenu_Options[copyTo] = nil;
	CT_RAMenu_Options[copyTo] = CT_RAMenu_CopyTable(CT_RAMenu_Options[copyFrom]);
	CT_RAMenu_UpdateOptionSets();
end

function CT_RAMenu_DeleteSet(name)
	if ( name ~= "Default" ) then
		if ( CT_RAMenu_CurrSet == name ) then
			CT_RAMenu_CurrSet = "Default";
			CT_RAMenu_Options["temp"] = CT_RAMenu_CopyTable(CT_RAMenu_Options[CT_RAMenu_CurrSet]);
		end
		CT_RAMenu_Options[name] = nil;
		CT_RAMenu_UpdateOptionSets();
		CT_RA_UpdateRaidGroup(0);
		CT_RA_UpdateMTs();
		CT_RAMenu_UpdateMenu();
		CT_RAOptions_Update();
	end
end

function CT_RAMenu_CompareTable(t1, t2)
	if ( not t1 or not t2 ) then
		return false;
	else
		if ( t1 == false ) then
			t1 = nil;
		end
		if ( t2 == false ) then
			t2 = nil;
		end
		if ( type(t1) ~= type(t2) ) then
			return false;
		elseif ( type(t1) ~= "table" ) then
			return ( t1 == t2 );
		end
	end

	for key, val in t1 do
		if ( key ~= "unchanged" and val ~= false ) then
			if ( type(val) ~= "table" ) then
				if ( not t2[key] or ( t2[key] ~= val and t2[key] ~= false ) ) then
					return false;
				end
			else
				if ( not CT_RAMenu_CompareTable(val, t2[key]) ) then
					return false;
				end
			end
		end
	end

	for key, val in t2 do
		if ( key ~= "unchanged" and val ~= false ) then
			if ( type(val) ~= "table" ) then
				if ( not t1[key] or ( t1[key] ~= val and t1[key] ~= false ) ) then
					return false;
				end
			else
				if ( not CT_RAMenu_CompareTable(val, t1[key]) ) then
					return false;
				end
			end
		end
	end

	return true;
end

function CT_RAMenu_ExistsSet(set)
	for k, v in CT_RAMenu_Options do
		if ( strlower(k) == strlower(set) ) then
			return true;
		end
	end
	return nil;
end

function CT_RAMenu_UpdateOptionSets()
	local num = 0;
	local postfix = "";
	if ( not CT_RAMenu_CompareTable(CT_RAMenu_Options["temp"], CT_RAMenu_Options[CT_RAMenu_CurrSet]) ) then
		postfix = "*";
		CT_RAMenuFrameOptionSetsUndo:Enable();
		CT_RAMenuFrameOptionSetsSave:Enable();
	else
		CT_RAMenuFrameOptionSetsUndo:Disable();
		CT_RAMenuFrameOptionSetsSave:Disable();
	end
	CT_RAMenuFrameOptionSetsCurrentSet:SetText("Current Set: |c00FFFF00" .. CT_RAMenu_CurrSet .. "|r" .. postfix);
	for k, v in CT_RAMenu_Options do
		if ( k ~= "temp" ) then
			num = num + 1;
			local obj = getglobal("CT_RAMenuFrameOptionSetsSet" .. num);
			getglobal(obj:GetName() .. "Name"):SetText(k);
			obj.setName = k;
			-- Make sure last line is hidden
			if ( num == 8 ) then
				getglobal(obj:GetName() .. "Line"):Hide();
			else
				getglobal(obj:GetName() .. "Line"):Show();
			end
			
			-- Disallow loading the current set
			if ( k == CT_RAMenu_CurrSet ) then
				getglobal(obj:GetName() .. "Load"):Disable();
				getglobal(obj:GetName() .. "Name"):SetTextColor(1, 1, 1);
			else
				getglobal(obj:GetName() .. "Load"):Enable();
				getglobal(obj:GetName() .. "Name"):SetTextColor(0.66, 0.66, 0.66);
			end
			
			-- Disallow deleting the default set
			if ( k == "Default" ) then
				getglobal(obj:GetName() .. "Delete"):Disable();
			else
				getglobal(obj:GetName() .. "Delete"):Enable();
			end
			obj:Show();
		end
	end
	for i = num+1, 8, 1 do
		getglobal("CT_RAMenuFrameOptionSetsSet" .. i):Hide();
	end
end

tinsert(UISpecialFrames, "CT_RA_PriorityFrame");

function CT_RAMenuFrameDebuff_Update()
	local numEntries = getn(CT_RA_DebuffTemplates);

	FauxScrollFrame_Update(CT_RAMenuFrameDebuffUseScrollFrame, numEntries, 12, 25);

	for i = 1, 12, 1 do
		local button = getglobal("CT_RAMenuFrameDebuffUseSet" .. i);
		local mouseOver = getglobal("CT_RAMenuFrameDebuffUseSet" .. i .. "MO");
		local index = i + FauxScrollFrame_GetOffset(CT_RAMenuFrameDebuffUseScrollFrame);
		if ( index <= numEntries ) then
			if ( index == CT_RAMenuFrameDebuff.selectedIndex ) then
				button.isHighlighted = 1;
				mouseOver:SetVertexColor(1, 1, 1, 0.25);
				mouseOver:Show();
			else
				if ( not button.isOver ) then
					mouseOver:Hide();
				end
				button.isHighlighted = nil;
				mouseOver:SetVertexColor(1, 1, 1, 0.1);
			end
			button:Show();
			local name = CT_RA_DebuffTemplates[index]["name"];
			if ( not name or name == "" ) then
				name = "<No name set>";
			end
			getglobal(button:GetName() .. "Name"):SetText(name);
		else
			button:Hide();
		end
	end

end

function CT_RAMenuFrameDebuff_UpdateSet()
	CT_RAMenuFrameDebuff_Update();
	local set = CT_RAMenuFrameDebuff.selectedIndex;
	if ( not set ) then
		CT_RAMenuFrameDebuffSettingsNameEB:Hide();
		CT_RAMenuFrameDebuffSettingsDebuffTitleEB:Hide();
		CT_RAMenuFrameDebuffSettingsDebuffTypeEB:Hide();
		CT_RAMenuFrameDebuffSettingsDebuffDescriptEB:Hide();
		for i = 1, 10, 1 do
			getglobal("CT_RAMenuFrameDebuffClassesClass" .. i):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameDebuffClassesClass" .. i .. "CB"):Disable();
			getglobal("CT_RAMenuFrameDebuffClassesClass" .. i .. "CB"):SetChecked(1);
		end
		CT_RAMenuFrameDebuffDelete:Disable();
		CT_RAMenuFrameDebuffEdit:Disable();
	else
		local tbl = CT_RA_DebuffTemplates[set];
		CT_RAMenuFrameDebuffSettingsNameEB:Show();
		CT_RAMenuFrameDebuffSettingsDebuffTitleEB:Show();
		CT_RAMenuFrameDebuffSettingsDebuffTypeEB:Show();
		CT_RAMenuFrameDebuffSettingsDebuffDescriptEB:Show();
		CT_RAMenuFrameDebuffSettingsNameEB:SetText(string.gsub(tbl["name"] or "", "%.%*", "*"));
		CT_RAMenuFrameDebuffSettingsDebuffTitleEB:SetText(string.gsub(tbl["debuffName"] or "*", "%.%*", "*"));
		CT_RAMenuFrameDebuffSettingsDebuffTypeEB:SetText(string.gsub(tbl["debuffType"] or "*", "%.%*", "*"));
		CT_RAMenuFrameDebuffSettingsDebuffDescriptEB:SetText(string.gsub(tbl["debuffDesc"] or "*", "%.%*", "*"));
		local classTbl = {
			CT_RA_WARRIOR, CT_RA_PALADIN, CT_RA_HUNTER, CT_RA_ROGUE, CT_RA_MAGE, CT_RA_WARLOCK, CT_RA_PRIEST, CT_RA_DRUID, CT_RA_SHAMAN, CT_RA_PETS
		};
		
		for i = 1, 10, 1 do
			getglobal("CT_RAMenuFrameDebuffClassesClass" .. i):SetTextColor(1, 1, 1);
			getglobal("CT_RAMenuFrameDebuffClassesClass" .. i .. "CB"):Enable();
			getglobal("CT_RAMenuFrameDebuffClassesClass" .. i .. "CB"):SetChecked(tbl["affectClasses"][classTbl[i]]);
		end
		CT_RAMenuFrameDebuffDelete:Enable();
		CT_RAMenuFrameDebuffEdit:Enable();
		
	end
end

function CT_RAMenuDebuff_MoveSetDown()
	local id = this:GetParent():GetID() + FauxScrollFrame_GetOffset(CT_RAMenuFrameDebuffUseScrollFrame);
	if ( id < getn(CT_RA_DebuffTemplates) ) then
		if ( ( CT_RAMenuFrameDebuff.selectedIndex or 0 ) == id ) then
			CT_RAMenuFrameDebuff.selectedIndex = id+1;
		elseif ( ( CT_RAMenuFrameDebuff.selectedIndex or 0 ) == id+1 ) then
			CT_RAMenuFrameDebuff.selectedIndex = id;
		end
		tinsert(CT_RA_DebuffTemplates, id, tremove(CT_RA_DebuffTemplates, id+1));
	end
	CT_RAMenuFrameDebuff_UpdateSet();
end

function CT_RAMenuDebuff_MoveSetUp()
	local id = this:GetParent():GetID() + FauxScrollFrame_GetOffset(CT_RAMenuFrameDebuffUseScrollFrame);
	if ( id > 1 ) then
		if ( ( CT_RAMenuFrameDebuff.selectedIndex or 0 ) == id ) then
			CT_RAMenuFrameDebuff.selectedIndex = id-1;
		elseif ( ( CT_RAMenuFrameDebuff.selectedIndex or 0 ) == id-1 ) then
			CT_RAMenuFrameDebuff.selectedIndex = id;
		end
		tinsert(CT_RA_DebuffTemplates, id-1, tremove(CT_RA_DebuffTemplates, id));
	end
	CT_RAMenuFrameDebuff_UpdateSet();
end

function CT_RAMenuDebuff_NewSet()
	tinsert(CT_RA_DebuffTemplates, 1, {
		["name"] = "<New set>",
		["debuffName"] = ".*",
		["debuffDesc"] = ".*",
		["debuffType"] = ".*",
		["affectClasses"] = {
			[CT_RA_WARRIOR] = 1,
			[CT_RA_DRUID] = 1,
			[CT_RA_MAGE] = 1,
			[CT_RA_WARLOCK] = 1,
			[CT_RA_ROGUE] = 1,
			[CT_RA_HUNTER] = 1,
			[CT_RA_PRIEST] = 1,
			[CT_RA_PALADIN] = 1,
			[CT_RA_SHAMAN] = 1,
			[CT_RA_PETS] = 1
		},
		["cureOrder"] = { 
			1, 2, 3, 4, 5, 6, 7
		}
	});
	CT_RAMenuFrameDebuffSettingsNameEB:ClearFocus();
	CT_RAMenuFrameDebuffSettingsDebuffTitleEB:ClearFocus();
	CT_RAMenuFrameDebuffSettingsDebuffTypeEB:ClearFocus();
	CT_RAMenuFrameDebuffSettingsDebuffDescriptEB:ClearFocus();
	CT_RAMenuFrameDebuff.selectedIndex = 1;
	CT_RAMenuFrameDebuff_UpdateSet();
end

function CT_RAMenuDebuff_DeleteSet()
	if ( CT_RAMenuFrameDebuff.selectedIndex ) then
		tremove(CT_RA_DebuffTemplates, CT_RAMenuFrameDebuff.selectedIndex);
		CT_RAMenuFrameDebuff.selectedIndex = nil;
		CT_RAMenuFrameDebuff_UpdateSet();
	end
end

function CT_RA_Priority_OnUpdate()
	if ( CT_RA_PriorityFrame.moving ) then
		local numUsed, numAvailable = 0, 0;
		CT_RA_PriorityFrame.isOver = nil;
		for i=1, 17, 1 do
			slot = getglobal("CT_RA_PriorityFramePriority" .. i);
			if ( slot.currParent == "CT_RA_PriorityFrameAvailable" ) then
				numAvailable = numAvailable + 1;
			elseif ( slot.currParent == "CT_RA_PriorityFrameUse" ) then
				numUsed = numUsed + 1;
			end
			if ( MouseIsOver(slot) and CT_RA_PriorityFrame.moving ~= slot ) then
				slot:SetBackdropBorderColor(1, 1, 0, 1);
				CT_RA_PriorityFrame.isOver = slot;
			else
				slot:SetBackdropBorderColor(1, 1, 1, 1);
			end
		end
		if ( MouseIsOver(CT_RA_PriorityFrameAvailable) ) then
			CT_RA_PriorityFrame.isOverParent = "CT_RA_PriorityFrameAvailable";
			CT_RA_PriorityFrame.numInParent = numAvailable;
		elseif ( MouseIsOver(CT_RA_PriorityFrameUse) ) then
			CT_RA_PriorityFrame.isOverParent = "CT_RA_PriorityFrameUse";
			CT_RA_PriorityFrame.numInParent = numUsed;
		else
			CT_RA_PriorityFrame.numInParent = nil;
			CT_RA_PriorityFrame.isOverParent = nil;
		end
	else
		for i = 1, 17, 1 do
			getglobal("CT_RA_PriorityFramePriority" .. i):SetBackdropBorderColor(1, 1, 1, 1);
		end
	end
end

function CT_RA_Priority_SetPosition()
	if ( CT_RA_PriorityFrame.isOver ) then
		local tempParent, tempIndex = this.currParent, this.currIndex;
		
		CT_RA_PriorityFrame.isOver:ClearAllPoints();
		this:ClearAllPoints();
		
		CT_RA_PriorityFrame.isOver:SetPoint("TOP", this.currParent, "TOP", 0, -5-(33*(this.currIndex-1)));
		this:SetPoint("TOP", CT_RA_PriorityFrame.isOver.currParent, "TOP", 0, -5-(33*(CT_RA_PriorityFrame.isOver.currIndex-1)));
		
		this.currParent = CT_RA_PriorityFrame.isOver.currParent;
		this.currIndex = CT_RA_PriorityFrame.isOver.currIndex;
		CT_RA_PriorityFrame.isOver.currParent = tempParent;
		CT_RA_PriorityFrame.isOver.currIndex = tempIndex;
		
	elseif ( CT_RA_PriorityFrame.isOverParent ) then
		for i = 1, 17, 1 do
			if ( i ~= this:GetID() ) then
				local slot = getglobal("CT_RA_PriorityFramePriority" .. i);
				if ( slot.currParent == this.currParent and slot.currIndex > this.currIndex ) then
					slot.currIndex = slot.currIndex - 1;
				end
			end
		end
		if ( CT_RA_PriorityFrame.isOverParent == this.currParent ) then
			this.currParent = CT_RA_PriorityFrame.isOverParent;
			this.currIndex = CT_RA_PriorityFrame.numInParent;
		else
			this.currParent = CT_RA_PriorityFrame.isOverParent;
			this.currIndex = CT_RA_PriorityFrame.numInParent+1;			
		end
		this:ClearAllPoints();
		this:SetPoint("TOP", CT_RA_PriorityFrame.isOverParent, "TOP", 0, -5-(33*(this.currIndex-1)));
	end
	
	CT_RA_Priority_ClearPositions();
end

function CT_RA_Priority_ClearPositions()
	for i = 1, 17, 1 do
		local btn = getglobal("CT_RA_PriorityFramePriority" .. i);
		btn:ClearAllPoints();
		btn:SetPoint("TOP", btn.currParent, "TOP", 0, -5-(33*(btn.currIndex-1)) );
	end
end

function CT_RA_Priority_InitPriorities()
	local tbl = {
		{ "Target", 1, 1, 0 },
		{ "Player", 0, 1, 0 },
		{ "Party", 0.7, 0.7, 1 },
		{ "Raid", 1, 0.5, 0 },
		{ "Pet", 0, 1, 1 },
		{ "Party's Pets", 0, 1, 0.7 },
		{ "Raid's Pets", 0, 1, 0.5 },
		{ "Main Tanks", 1, 0, 0 },
		{ CT_RA_WARRIOR, 0.78, 0.61, 0.43 },
		{ CT_RA_DRUID, 1.0, 0.49, 0.04 },
		{ CT_RA_MAGE, 0.41, 0.8, 0.94 },
		{ CT_RA_WARLOCK, 0.58, 0.51, 0.79 },
		{ CT_RA_ROGUE, 1.0, 0.96, 0.41 },
		{ CT_RA_HUNTER, 0.67, 0.83, 0.45 },
		{ CT_RA_PRIEST, 1.0, 1.0, 1.0 },
		{ CT_RA_PALADIN, 0.96, 0.55, 0.73 },
		{ CT_RA_SHAMAN, 0.96, 0.55, 0.73 }
	};
	local classTbl = {
		[9] = CT_RA_WARRIOR, 
		[10] = CT_RA_DRUID,
		[11] = CT_RA_MAGE,
		[12] = CT_RA_WARLOCK,
		[13] = CT_RA_ROGUE,
		[14] = CT_RA_HUNTER,
		[15] = CT_RA_PRIEST,
		[16] = CT_RA_PALADIN,
		[17] = CT_RA_SHAMAN
	};
	local numUsed, numAvailable = 0, 0;
	local debuffTbl = CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex];
	CT_RA_PriorityFrameSave:SetText("Editing set '|c00FFFFFF" .. debuffTbl["name"] .. "|r'.");
	for i = 1, 17, 1 do
		local used;
		if ( i > 8 and not debuffTbl["affectClasses"][classTbl[i]] ) then
			getglobal("CT_RA_PriorityFramePriority" .. i):Hide();
		else
			getglobal("CT_RA_PriorityFramePriority" .. i):Show();
		end
		for k, v in debuffTbl["cureOrder"] do
			if ( v == i and ( i <= 8 or debuffTbl["affectClasses"][classTbl[i]] ) ) then
				used = k;
				break;
			end
		end
		getglobal("CT_RA_PriorityFramePriority" .. i):ClearAllPoints();
		getglobal("CT_RA_PriorityFramePriority" .. i .. "Name"):SetText(tbl[i][1]);
		getglobal("CT_RA_PriorityFramePriority" .. i):SetBackdropColor(tbl[i][2], tbl[i][3], tbl[i][4], 0.5);
		if ( used ) then
			numUsed = numUsed + 1;
			getglobal("CT_RA_PriorityFramePriority" .. i):SetPoint("TOP", "CT_RA_PriorityFrameUse", "TOP", 0, -5-(33*(used-1)) );
			getglobal("CT_RA_PriorityFramePriority" .. i).currParent = "CT_RA_PriorityFrameUse";
			getglobal("CT_RA_PriorityFramePriority" .. i).currIndex = used;
		elseif ( getglobal("CT_RA_PriorityFramePriority" .. i):IsVisible() ) then
			numAvailable = numAvailable + 1;
			getglobal("CT_RA_PriorityFramePriority" .. i):SetPoint("TOP", "CT_RA_PriorityFrameAvailable", "TOP", 0, -5-(33*(numAvailable-1)) );
			getglobal("CT_RA_PriorityFramePriority" .. i).currParent = "CT_RA_PriorityFrameAvailable";
			getglobal("CT_RA_PriorityFramePriority" .. i).currIndex = numAvailable;
		end
	end
end

function CT_RA_Priority_SavePriorities()
	local tbl = CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex];
	CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex]["cureOrder"] = { };
	for i = 1, 17, 1 do
		local btn = getglobal("CT_RA_PriorityFramePriority" .. i);
		if ( btn.currParent == "CT_RA_PriorityFrameUse" ) then
			CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex]["cureOrder"][btn.currIndex] = btn:GetID();
		end
	end
end

function CT_RADebuff_SaveClass()
	local tbl = {
		CT_RA_WARRIOR, CT_RA_PALADIN, CT_RA_HUNTER, CT_RA_ROGUE, CT_RA_MAGE, CT_RA_WARLOCK, CT_RA_PRIEST, CT_RA_DRUID, CT_RA_SHAMAN, CT_RA_PETS
	};
	CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex]["affectClasses"][tbl[this:GetID()]] = this:GetChecked();
end

function CT_RADebuff_SaveName()
	local text = this:GetText() or "";
	text = string.gsub(text, "*", ".*");
	CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex]["name"] = text;
	CT_RAMenuFrameDebuff_UpdateSet();
end

function CT_RADebuff_SaveTitle()
	local text = this:GetText() or "";
	text = string.gsub(text, "*", ".*");
	CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex]["debuffName"] = text;
	CT_RAMenuFrameDebuff_UpdateSet();
end

function CT_RADebuff_SaveType()
	local text = this:GetText() or "";
	text = string.gsub(text, "*", ".*");
	CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex]["debuffType"] = text;
	CT_RAMenuFrameDebuff_UpdateSet();
end

function CT_RADebuff_SaveDescript()
	local text = this:GetText() or "";
	text = string.gsub(text, "*", ".*");
	CT_RA_DebuffTemplates[CT_RAMenuFrameDebuff.selectedIndex]["debuffDesc"] = text;
	CT_RAMenuFrameDebuff_UpdateSet();
end
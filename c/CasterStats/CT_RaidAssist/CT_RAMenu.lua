tinsert(UISpecialFrames, "CT_RAMenuFrame");
CT_RA_Ressers = { };
CT_RA_PartyFrame_IsShown = nil;
CT_RAMenu_Locked = 1;
CT_RA_PartyMembers = { };
CT_RA_CurrCast = nil;
CT_RA_InCombat = nil;

function CT_RAMenu_OnLoad()
	CT_RAMenuFrameHomeButton1Text:SetText("General Options");
	CT_RAMenuFrameHomeButton2Text:SetText("Buff Options");
	CT_RAMenuFrameHomeButton3Text:SetText("Misc Options");
	CT_RAMenuFrameHomeButton4Text:SetText("Additional Options");
	CT_RAMenuFrameHomeButton5Text:SetText("Installation Guide");
	CT_RAMenuFrameHomeButton6Text:SetText("Boss Mods");
	CT_RAMenuFrameHomeButton7Text:SetText("Debuff Curing");
	CT_RAMenuFrameHomeButton8Text:SetText("Option Sets");

	CT_RAMenuFrameHomeButton1Description:SetText("Change general stuff, such as whether to show mana bars, etc etc.");
	CT_RAMenuFrameHomeButton2Description:SetText("Change the way Buffs and Debuffs are displayed.");
	CT_RAMenuFrameHomeButton3Description:SetText("Things that do not fit in other categories go here.");
	CT_RAMenuFrameHomeButton4Description:SetText("Regulating message spam, scaling of windows, etc.");
	CT_RAMenuFrameHomeButton5Description:SetText("Just started using the mod? Look here for instructions on how to set it up.");
	CT_RAMenuFrameHomeButton6Description:SetText("Several features to aid you in killing raid bosses.");
	CT_RAMenuFrameHomeButton7Description:SetText("Configure the debuff curing feature.");
	CT_RAMenuFrameHomeButton8Description:SetText("Save and load sets of options for easier setup.");
end

function CT_RAMenu_OnShow()
	CT_RAMenu_ShowHome();
	if ( this:GetScale() <= 0.8 ) then
		this:SetScale(0.8);
	end
	CT_RAMenuFrameHomeButton1:SetScale(this:GetScale()/1.09758);
	CT_RAMenuFrameHomeButton2:SetScale(this:GetScale()/1.09758);
	CT_RAMenuFrameHomeButton3:SetScale(this:GetScale()/1.09758);
	CT_RAMenuFrameHomeButton4:SetScale(this:GetScale()/1.09758);
	CT_RAMenuFrameHomeButton5:SetScale(this:GetScale()/1.09758);
	CT_RAMenuFrameHomeButton6:SetScale(this:GetScale()/1.09758);
	CT_RAMenuFrameHomeButton7:SetScale(this:GetScale()/1.09758);
	CT_RAMenuFrameHomeButton8:SetScale(this:GetScale()/1.09758);
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
		CT_RAMenuFrameSort:Show();
	elseif ( id == 6 ) then
		CT_RAMenuFrameBoss:Show();
	elseif ( id == 7 ) then
		CT_RAMenuFrameDebuff:Show();
	elseif ( id == 8 ) then
		CT_RAMenuFrameOptionSets:Show();
	end
end

function CT_RAMenu_ShowHome()
	CT_RAMenuFrameHome:Show();
	CT_RAMenuFrameGeneral:Hide();
	CT_RAMenuFrameBuffs:Hide();
	CT_RAMenuFrameSort:Hide();
	CT_RAMenuFrameMisc:Hide();
	CT_RAMenuFrameAdditional:Hide();
	CT_RAMenuFrameBoss:Hide();
	CT_RAMenuFrameDebuff:Hide();
	CT_RAMenuFrameOptionSets:Hide();
end

function CT_RAMenu_UpdateMenu()
	local admiralsHat, foundDampen;
	for k, v in CT_RAMenu_Options["temp"]["BuffArray"] do
		if ( v["name"] == CT_RA_DAMPENMAGIC ) then
			foundDampen = k;
		elseif ( v["name"] == CT_RA_ADMIRALSHAT ) then
			admiralsHat = k;
		end
	end
	if ( admiralsHat ) then
		tremove(CT_RAMenu_Options["temp"]["BuffArray"], admiralsHat);
	end
	if ( not foundDampen ) then
		tinsert(CT_RAMenu_Options["temp"]["BuffArray"], { ["show"] = -1, ["name"] = CT_RA_AMPLIFYMAGIC, ["index"] = 20 });
		tinsert(CT_RAMenu_Options["temp"]["BuffArray"], { ["show"] = -1, ["name"] = CT_RA_DAMPENMAGIC, ["index"] = 21 });
	end
	for i = 1, 6, 1 do
		if ( type(CT_RAMenu_Options["temp"]["DebuffColors"][i]["type"]) == "table" ) then
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetText(string.gsub(CT_RAMenu_Options["temp"]["DebuffColors"][i]["type"][CT_RA_GetLocale()], "_", " "));
		else
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetText(string.gsub(CT_RAMenu_Options["temp"]["DebuffColors"][i]["type"], "_", " "));
		end
		local val = CT_RAMenu_Options["temp"]["DebuffColors"][i];
		getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "SwatchNormalTexture"):SetVertexColor(val.r, val.g, val.b);

		if ( val["id"] ~= -1 ) then
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "CheckButton"):SetChecked(1);
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "CheckButton"):SetChecked(nil);
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
		end
	end
	for key, val in CT_RAMenu_Options["temp"]["BuffArray"] do
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
	CT_RAMenuFrameBuffsNotifyDebuffs:SetChecked(CT_RAMenu_Options["temp"]["NotifyDebuffs"]);

	for i = 1, 8, 1 do
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "Text"):SetText("Group " .. i);
		if ( not CT_RAMenu_Options["temp"]["NotifyDebuffs"] or ( not CT_RAMenu_Options["temp"]["NotifyDebuffs"]["main"] and CT_RAMenu_Options["temp"]["NotifyDebuffs"]["hidebuffs"] ) ) then
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "CheckButton"):Disable();
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "CheckButton"):Disable();
		end
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffs"):SetChecked(CT_RAMenu_Options["temp"]["NotifyDebuffs"]["main"]);
		getglobal("CT_RAMenuFrameBuffsNotifyBuffs"):SetChecked(not CT_RAMenu_Options["temp"]["NotifyDebuffs"]["hidebuffs"]);

		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "CheckButton"):SetChecked(CT_RAMenu_Options["temp"]["NotifyDebuffs"][i]);
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "CheckButton"):SetChecked(CT_RAMenu_Options["temp"]["NotifyDebuffsClass"][i]);
	end
	for k, v in CT_RA_ClassPositions do
		if ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) then
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. v .. "Text"):SetText(k);
		end
	end
	CT_RAMenuFrameGeneralDisplayShowMPCB:SetChecked(CT_RAMenu_Options["temp"]["HideMP"]);
	CT_RAMenuFrameGeneralDisplayShowRPCB:SetChecked(CT_RAMenu_Options["temp"]["HideRP"]);
	if ( CT_RAMenu_Options["temp"]["MemberHeight"] == 32 ) then
		CT_RAMenuFrameGeneralDisplayShowHealthCB:SetChecked(1);
	else
		CT_RAMenuFrameGeneralDisplayShowHealthCB:SetChecked(nil);
	end

	CT_RAMenuFrameGeneralDisplayShowGroupsCB:SetChecked(not CT_RAMenu_Options["temp"]["HideNames"]);
	CT_RAMenuFrameGeneralDisplayLockGroupsCB:SetChecked(CT_RAMenu_Options["temp"]["LockGroups"]);
	CT_RAMenuFrameGeneralDisplayWindowColorSwatchNormalTexture:SetVertexColor(CT_RAMenu_Options["temp"]["DefaultColor"].r, CT_RAMenu_Options["temp"]["DefaultColor"].g, CT_RAMenu_Options["temp"]["DefaultColor"].b);
	CT_RAMenuFrameGeneralDisplayShowHPSwatchNormalTexture:SetVertexColor(CT_RAMenu_Options["temp"]["PercentColor"].r, CT_RAMenu_Options["temp"]["PercentColor"].g, CT_RAMenu_Options["temp"]["PercentColor"].b);
	CT_RAMenuFrameGeneralDisplayAlertColorSwatchNormalTexture:SetVertexColor(CT_RAMenu_Options["temp"]["DefaultAlertColor"].r, CT_RAMenu_Options["temp"]["DefaultAlertColor"].g, CT_RAMenu_Options["temp"]["DefaultAlertColor"].b);

	CT_RA_UpdateRaidGroupColors();
	CT_RA_UpdateRaidMovability();
	CT_RAMenu_CheckParty();
	if ( CT_RAMenu_Options["temp"]["ShowHP"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, CT_RAMenu_Options["temp"]["ShowHP"]);
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, 5);
	end
	if ( CT_RAMenu_Options["temp"]["ShowDebuffs"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 2);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show debuffs");
	elseif ( CT_RAMenu_Options["temp"]["ShowBuffsDebuffed"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 3);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show buffs until debuffed");
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 1);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show buffs");
	end
	local num = 0;
	if ( CT_RAMenu_Options["temp"]["ShowGroups"] ) then
		for k, v in CT_RAMenu_Options["temp"]["ShowGroups"] do
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
	CT_RAMenuFrameGeneralMiscHideOfflineCB:SetChecked(CT_RAMenu_Options["temp"]["HideOffline"]);
	CT_RAMenuFrameGeneralMiscSortAlphaCB:SetChecked(CT_RAMenu_Options["temp"]["SubSortByName"]);
	CT_RAMenuFrameGeneralMiscBorderCB:SetChecked(CT_RAMenu_Options["temp"]["HideBorder"]);
	CT_RAMenuFrameGeneralMiscShowMTsCB:SetChecked(not CT_RAMenu_Options["temp"]["HideMTs"]);
	CT_RAMenuFrameGeneralMiscShowMetersCB:SetChecked( (CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Show"] ) );
	CT_RAMenuFrameGeneralMiscHidePartyCB:SetChecked(CT_RAMenu_Options["temp"]["HideParty"]);
	CT_RAMenuFrameGeneralMiscHidePartyRaidCB:SetChecked(CT_RAMenu_Options["temp"]["HidePartyRaid"]);
	CT_RAMenuFrameMiscPlayRSSoundCB:SetChecked(CT_RAMenu_Options["temp"]["PlayRSSound"]);
	CT_RAMenuFrameMiscSendRARSCB:SetChecked(CT_RAMenu_Options["temp"]["SendRARS"]);
	CT_RAMenuFrameMiscShowAFKCB:SetChecked(CT_RAMenu_Options["temp"]["ShowAFK"]);
	CT_RAMenuFrameMiscShowTooltipCB:SetChecked(not CT_RAMenu_Options["temp"]["HideTooltip"]);
	CT_RAMenuFrameMiscDisableQueryCB:SetChecked(CT_RAMenu_Options["temp"]["DisableQuery"]);
	CT_RAMenuFrameMiscNotifyGroupChangeCB:SetChecked(CT_RAMenu_Options["temp"]["NotifyGroupChange"]);
	CT_RAMenuFrameMiscNotifyGroupChangeCBSound:SetChecked(CT_RAMenu_Options["temp"]["NotifyGroupChangeSound"]);
	CT_RAMenuFrameMiscNoColorChangeCB:SetChecked(CT_RAMenu_Options["temp"]["HideColorChange"]);
	CT_RAMenuFrameMiscShowResMonitorCB:SetChecked(CT_RAMenu_Options["temp"]["ShowMonitor"]);
	CT_RAMenuFrameMiscHideButtonCB:SetChecked(CT_RAMenu_Options["temp"]["HideButton"]);
	CT_RAMenuFrameMiscShowMTTTCB:SetChecked(CT_RAMenu_Options["temp"]["ShowMTTT"]);
	CT_RAMenuFrameAdditionalEMShowCB:SetChecked(CT_RAMenu_Options["temp"]["ShowEmergency"]);
	CT_RAMenuFrameMiscMCPercentCheck:SetChecked(CT_RAMenu_Options["temp"]["UsePercentValues"]);
	CT_RAMenuFrameMiscAggroNotifierCB:SetChecked(CT_RAMenu_Options["temp"]["AggroNotifier"]);
	CT_RAMenuFrameMiscAggroNotifierSoundCB:SetChecked(CT_RAMenu_Options["temp"]["AggroNotifierSound"]);
	if ( not CT_RAMenu_Options["temp"]["AggroNotifier"] ) then
		CT_RAMenuFrameMiscAggroNotifierSoundCB:Disable();
		CT_RAMenuFrameMiscAggroNotifierSound:SetTextColor(0.3, 0.3, 0.3);
	end
	if ( not CT_RAMenu_Options["temp"]["ShowEmergency"] ) then
		CT_RAMenuFrameAdditionalEMPartyCB:Disable();
		CT_RAMenuFrameAdditionalEMPartyText:SetTextColor(0.3, 0.3, 0.3);
		CT_RAMenuFrameAdditionalEMOutsideRaidCB:Disable();
		CT_RAMenuFrameAdditionalEMOutsideRaidText:SetTextColor(0.3, 0.3, 0.3);
	end
	CT_RAMenuFrameAdditionalEMPartyCB:SetChecked(CT_RAMenu_Options["temp"]["ShowEmergencyParty"]);
	CT_RAMenuFrameAdditionalEMOutsideRaidCB:SetChecked(CT_RAMenu_Options["temp"]["ShowEmergencyOutsideRaid"]);
	if ( CT_RAMenu_Options["temp"]["HideButton"] ) then
		CT_RASets_Button:Hide();
	else
		CT_RASets_Button:Show();
	end
	if ( not CT_RAMenu_Options["temp"]["NotifyGroupChange"] ) then
		CT_RAMenuFrameMiscNotifyGroupChangeCBSound:Disable();
		CT_RAMenuFrameMiscNotifyGroupChangeSound:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscNotifyGroupChangeCBSound:Enable();
		CT_RAMenuFrameMiscNotifyGroupChangeSound:SetTextColor(1, 1, 1);
	end
	if ( not CT_RAMenu_Options["temp"]["ShowMTTT"] ) then
		CT_RAMenuFrameMiscNoColorChangeCB:Disable();
		CT_RAMenuFrameMiscNoColorChange:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscNoColorChangeCB:Enable();
		CT_RAMenuFrameMiscNoColorChange:SetTextColor(1, 1, 1);
	end
	if ( CT_RAMenu_Options["temp"]["WindowScaling"] ) then
		CT_RAMenuGlobalFrame.scaleupdate = 0.1;
	end
	if ( CT_RAMenu_Options["temp"]["SORTTYPE"] == "class" ) then
		CT_RA_SetSortType("class");
	elseif ( CT_RAMenu_Options["temp"]["SORTTYPE"] == "custom" ) then
		CT_RA_SetSortType("custom");
	else
		CT_RA_SetSortType("group");
	end
	if ( CT_RAMenu_Options["temp"]["StatusMeters"] ) then
		CT_RAMetersFrame:SetBackdropColor(CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].r, CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].g, CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].b, CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].a);
		CT_RAMetersFrame:SetBackdropBorderColor(1, 1, 1, CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].a);
		if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Show"] and GetNumRaidMembers() > 0 ) then
			CT_RAMetersFrame:Show();
		else
			CT_RAMetersFrame:Hide();
		end
	end
	if ( CT_RAMenu_Options["temp"]["EMBG"] ) then
		CT_RA_EmergencyFrame:SetBackdropColor(CT_RAMenu_Options["temp"]["EMBG"].r, CT_RAMenu_Options["temp"]["EMBG"].g, CT_RAMenu_Options["temp"]["EMBG"].b, CT_RAMenu_Options["temp"]["EMBG"].a);
		CT_RA_EmergencyFrame:SetBackdropBorderColor(1, 1, 1, CT_RAMenu_Options["temp"]["EMBG"].a);
	end
	if ( CT_RAMenu_Options["temp"]["RMBG"] ) then
		CT_RA_ResFrame:SetBackdropColor(CT_RAMenu_Options["temp"]["RMBG"].r, CT_RAMenu_Options["temp"]["RMBG"].g, CT_RAMenu_Options["temp"]["RMBG"].b, CT_RAMenu_Options["temp"]["RMBG"].a);
		CT_RA_ResFrame:SetBackdropBorderColor(1, 1, 1, CT_RAMenu_Options["temp"]["RMBG"].a);
	end
	if ( CT_RAMenu_Options["temp"]["ShowHP"] ) then
		local table = { "Show Values", "Show Percentages", "Show Deficit", "Show only MTT HP %" };
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, CT_RAMenu_Options["temp"]["ShowHP"]);
		CT_RAMenuFrameGeneralDisplayHealthDropDownText:SetText(table[CT_RAMenu_Options["temp"]["ShowHP"]]);
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, 5);
		CT_RAMenuFrameGeneralDisplayHealthDropDownText:SetText("Show None");
	end
	CT_RAMenuMisc_Slider_Update("CT_RAMenuFrameMiscMCSlider1");
	CT_RAMenuMisc_Slider_Update("CT_RAMenuFrameMiscMCSlider2");
	CT_RAMenuMisc_Slider_InitLagSlider("CT_RAMenuFrameMiscMCSlider3");
	CT_RAMenuAdditional_Scaling_OnShow(CT_RAMenuFrameAdditionalScalingSlider1);
	CT_RAMenuAdditional_ScalingMT_OnShow(CT_RAMenuFrameAdditionalScalingSlider2);
	CT_RAMenuAdditional_EM_OnShow(CT_RAMenuFrameAdditionalEMSlider);
	CT_RAMenuAdditional_EM_OnShow(CT_RAMenuFrameAdditionalEMSlider2);
	CT_RAMenuAdditional_BG_OnShow(CT_RAMenuFrameAdditionalBGSlider);
	if ( CT_RA_Channel ) then
		CT_RAMenuFrameGeneralChannelChannelEB:SetText(CT_RA_Channel);
	else
		CT_RAMenuFrameGeneralChannelChannelEB:SetText("");
	end
	CT_RA_Emergency_UpdateHealth();
	CT_RAMenu_UpdateWindowPositions();
end

function CT_RAMenuBuffs_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
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
			if ( not CT_RA_ModVersion or CT_RA_ModVersion < 1.4 ) then
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
		
		CT_RA_UpdateRaidGroup();
	elseif ( event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" ) then
		CT_RAMenu_CheckParty();
	end
end

function CT_RA_Join(channel)
	if ( channel and GetChannelName(channel) == 0 ) then
		local name = channel;
		local zoneChannel, channelName = JoinChannelByName(name, nil, DEFAULT_CHAT_FRAME:GetID());
		CT_RA_UpdateFrame.SS = 3;
		if ( channelName ) then
			name = channelName;
		end
		if ( not zoneChannel ) then
			return;
		end
		
		local i = 1;

		while ( DEFAULT_CHAT_FRAME.channelList[i] ) do
			i = i + 1;
		end
		DEFAULT_CHAT_FRAME.channelList[i] = name;
		DEFAULT_CHAT_FRAME.zoneChannelList[i] = zoneChannel;
	end
end
			

function CT_RAMenu_CheckParty()
	if (  ( CT_RAMenu_Options["temp"]["HideParty"] and GetNumRaidMembers() > 0 ) or ( CT_RAMenu_Options["temp"]["HidePartyRaid"] and GetNumRaidMembers() == 0 ) ) then
		HidePartyFrame();
	else
		ShowPartyFrame();
	end
	if ( CT_CheckLSidebar ) then
		CT_CheckLSidebar();
	end
end

CT_oldShowPartyFrame = ShowPartyFrame;
function CT_newShowPartyFrame()
	CT_oldShowPartyFrame();
	if ( CT_RA_PartyFrame_IsShown ) then
		CT_RAMenu_CheckParty();
	end
end
ShowPartyFrame = CT_newShowPartyFrame;

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
	CT_RA_UpdateRaidGroup();
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
	CT_RA_UpdateRaidGroup();
end


function CT_RAMenu_General_JoinChannel()
	if ( CT_RA_Channel and GetChannelName(CT_RA_Channel) == 0 ) then
		local name = CT_RA_Channel;
		local zoneChannel, channelName = JoinChannelByName(name, nil, DEFAULT_CHAT_FRAME:GetID());
		if ( channelName ) then
			name = channelName;
		end
		if ( not zoneChannel ) then
			return;
		end
		
		local i = 1;

		while ( DEFAULT_CHAT_FRAME.channelList[i] ) do
			i = i + 1;
		end
		DEFAULT_CHAT_FRAME.channelList[i] = name;
		DEFAULT_CHAT_FRAME.zoneChannelList[i] = zoneChannel;
	end
end

function CT_RAMenu_General_EditChannel()
	if ( not this.editing ) then
		this.editing = 1;
		this:SetText("Set and Join Channel");
		getglobal(this:GetParent():GetName() .. "ChannelEB"):Show();
		if ( CT_RA_Channel ) then
			getglobal(this:GetParent():GetName() .. "ChannelEB"):SetText(CT_RA_Channel);
			getglobal(this:GetParent():GetName() .. "ChannelEB"):HighlightText();
		else
			getglobal(this:GetParent():GetName() .. "ChannelEB"):SetText("");
		end
		getglobal(this:GetParent():GetName() .. "ChannelNameText"):Hide();
		getglobal(this:GetParent():GetName() .. "BroadcastChannel"):Disable();
	else
		this:SetText("Edit Channel");
		getglobal(this:GetParent():GetName() .. "BroadcastChannel"):Enable();
		this.editing = nil;

		local name = getglobal(this:GetParent():GetName() .. "ChannelEB"):GetText();
		if ( strsub(name, strlen(name)) == " " ) then
			name = strsub(name, 1, strlen(name)-1);
		end
		getglobal(this:GetParent():GetName() .. "ChannelEB"):Hide();
		
		local new;
		if ( strlen(name) > 0 ) then
			new = name;
			getglobal(this:GetParent():GetName() .. "ChannelNameText"):SetText(name);
		else
			new = nil;
			getglobal(this:GetParent():GetName() .. "ChannelNameText"):SetText("<No Channel>");
		end
		if ( CT_RA_Channel ~= new or ( CT_RA_Channel and GetChannelName(CT_RA_Channel) == 0 ) ) then
			if ( CT_RA_Channel ) then
				LeaveChannelByName(CT_RA_Channel);
			end
			CT_RA_Channel = new;
			CT_RA_Join(new);
		end
		getglobal(this:GetParent():GetName() .. "ChannelNameText"):Show();
	end
end

function CT_RAMenu_General_ChannelOnShow()
	if ( CT_RA_Channel ) then
		getglobal(this:GetName() .. "ChannelNameText"):SetText(CT_RA_Channel);
	else
		getglobal(this:GetName() .. "ChannelNameText"):SetText("<No Channel>");
	end
	local edit = getglobal(this:GetName() .. "EditChannel");
	getglobal(this:GetName() .. "BroadcastChannel"):Enable();
	edit:SetText("Edit Channel");
	edit.editing = nil;
	getglobal(this:GetName() .. "ChannelEB"):Hide();
	getglobal(this:GetName() .. "ChannelNameText"):Show();
	for k, v in CT_RA_ClassPositions do
		if ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) then
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. v .. "Text"):SetText(k);
		end
	end
	if ( CT_RAMenu_Options["temp"]["SORTTYPE"] == "class" ) then
		CT_RA_SetSortType("class");
	elseif ( CT_RAMenu_Options["temp"]["SORTTYPE"] == "custom" ) then
		CT_RA_SetSortType("custom");
	else
		CT_RA_SetSortType("group");
	end
	if ( CT_RAMenu_Options["temp"]["ShowHP"] ) then
		local table = { "Show Values", "Show Percentages", "Show Deficit", "Show only MTT HP %" };
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, CT_RAMenu_Options["temp"]["ShowHP"]);
		CT_RAMenuFrameGeneralDisplayHealthDropDownText:SetText(table[CT_RAMenu_Options["temp"]["ShowHP"]]);
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, 5);
		CT_RAMenuFrameGeneralDisplayHealthDropDownText:SetText("Show None");
	end
end

function CT_RAMenu_General_BroadcastChannel()
	SlashCmdList["RABROADCAST"]();
end

function CT_RAMenuDisplay_ShowMP()
	CT_RAMenu_Options["temp"]["HideMP"] = this:GetChecked();
	CT_RA_UpdateRaidGroup();
	CT_RA_UpdateMTs();
end

function CT_RAMenuDisplay_ShowRP()
	CT_RAMenu_Options["temp"]["HideRP"] = this:GetChecked();
	CT_RA_UpdateRaidGroup();
	CT_RA_UpdateMTs();
end

function CT_RAMenuDisplay_ShowHealth()
	if ( not this:GetChecked() ) then
		CT_RAMenu_Options["temp"]["MemberHeight"] = CT_RAMenu_Options["temp"]["MemberHeight"]+8;
	else
		CT_RAMenu_Options["temp"]["MemberHeight"] = CT_RAMenu_Options["temp"]["MemberHeight"]-8;
	end
	CT_RA_UpdateRaidGroup();
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
end


function CT_RAMenuFrameGeneralMiscDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralMiscDropDown, this:GetID());
	if ( this:GetID() == 1 ) then
		CT_RA_SetSortType("group");
	elseif ( this:GetID() == 2 ) then
		CT_RA_SetSortType("class");
	else
		CT_RA_SetSortType("custom");
	end
	CT_RA_UpdateRaidGroup();
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
	CT_RA_UpdateRaidGroup();
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
	CT_RA_UpdateRaidGroup();
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

function CT_RAMenuGeneral_HideParty()
	CT_RAMenu_Options["temp"]["HideParty"] = this:GetChecked();
	CT_RAMenu_CheckParty();
end

function CT_RAMenuGeneral_HidePartyOutOfRaid()
	CT_RAMenu_Options["temp"]["HidePartyRaid"] = this:GetChecked();
	CT_RAMenu_CheckParty();
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
	CT_RA_UpdateRaidGroup();
end

function CT_RAMenuGeneral_HideShort()
	CT_RAMenu_Options["temp"]["HideShort"] = this:GetChecked();
	CT_RA_UpdateRaidGroup();
end

function CT_RAMenuBuff_ShowDebuffs()
	CT_RAMenu_Options["temp"]["ShowDebuffs"] = this:GetChecked();
	CT_RA_UpdateRaidGroup();
end

function CT_RAMenuGeneral_HideBorder()
	CT_RAMenu_Options["temp"]["HideBorder"] = this:GetChecked();
	CT_RA_UpdateRaidGroup();
	CT_RA_UpdateMTs();
end

function CT_RAMenuGeneral_ShowMTs()
	CT_RAMenu_Options["temp"]["HideMTs"] = not this:GetChecked();
	CT_RA_UpdateRaidGroup();
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

function CT_RAMenuMisc_Slider_OnShow()

end

function CT_RAMenuMisc_Slider_Update(slider)
	slider = getglobal(slider);
	if ( UnitClass("player") and CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")] ) then -- Assumes there are two heals/healing class
		if ( CT_RAMenu_Options["temp"]["UsePercentValues"] ) then
			getglobal(slider:GetName().."High"):SetText("100%");
			getglobal(slider:GetName().."Low"):SetText("10%");
			local spell = CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")][slider:GetID()];
			local val = spell[5]; -- Gotta love pointers!
			slider:SetMinMaxValues(0, 100);
			slider:SetValueStep(1);
			slider:SetValue(( val or 0));
			if ( type(spell[1]) == "table" ) then
				getglobal(slider:GetName() .. "Text"):SetText(spell[1][1] .. ": " .. slider:GetValue() .. "%");
			else
				getglobal(slider:GetName() .. "Text"):SetText(spell[1] .. ": " .. slider:GetValue() .. "%");
			end
		else
			getglobal(slider:GetName().."High"):SetText("-0");
			getglobal(slider:GetName().."Low"):SetText("-5000");
			local spell = CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")][slider:GetID()];
			local val = 5000-spell[3]; -- Gotta love pointers!
			slider:SetMinMaxValues(0, 5000);
			slider:SetValueStep(100);
			slider:SetValue(val);
			if ( type(spell[1]) == "table" ) then
				getglobal(slider:GetName() .. "Text"):SetText(spell[1][1] .. ": -" .. 5000-slider:GetValue());
			else
				getglobal(slider:GetName() .. "Text"):SetText(spell[1] .. ": -" .. 5000-slider:GetValue());
			end
		end
		slider.tooltipText = CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")][slider:GetID()][2];
		slider:Show();
		getglobal(slider:GetParent():GetName() .. "NoHealer"):Hide();
		getglobal(slider:GetParent():GetName() .. "Healer"):Show();
	else
		getglobal(slider:GetParent():GetName() .. "NoHealer"):Show();
		getglobal(slider:GetParent():GetName() .. "Healer"):Hide();
		slider:Hide();
	end
end

function CT_RAMenuMisc_Slider_InitLagSlider(slider)
	slider = getglobal(slider);
	if ( UnitClass("player") and CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")] ) then
		slider:Show();
		getglobal(slider:GetName().."High"):SetText("1.5 sec");
		getglobal(slider:GetName().."Low"):SetText("0.5 sec");
		getglobal(slider:GetName() .. "Text"):SetText("Check Time - " .. CT_RAMenu_Options["temp"]["SpellCastDelay"] .. " sec");
		slider.tooltipText = "Adjust the time when the 'mana conserve' point checks your targets health.  If you set 0.5 sec, the heal will cancel 0.5 seconds before it would cast. However if you lag, you may want to set it higher, so it would check earlier before the cast would occur.";
		slider:SetMinMaxValues(0.5, 1.5);
		slider:SetValueStep(0.05);
		slider:SetValue(CT_RAMenu_Options["temp"]["SpellCastDelay"]);
		slider:Show();
	else
		slider:Hide();
	end
end

function CT_RAMenuMisc_LagSlider_OnValueChanged()
	CT_RAMenu_Options["temp"]["SpellCastDelay"] = floor(this:GetValue()*100+0.5)/100;
	getglobal(this:GetName() .. "Text"):SetText("Check Time - " .. CT_RAMenu_Options["temp"]["SpellCastDelay"] .. " sec");
end

function CT_RAMenuMisc_Schedule(time)
	this.update = time;
end

function CT_RAMenuMisc_OnUpdate(elapsed)
	if ( this.scaleupdate ) then
		this.scaleupdate = this.scaleupdate - elapsed;
		if ( this.scaleupdate <= 0 ) then
			this.scaleupdate = 10;
			if ( CT_RAMenu_Options["temp"]["WindowScaling"] ) then
				local newScaling = CT_RAMenu_Options["temp"]["WindowScaling"]*UIParent:GetScale();
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
				local newScaling = CT_RAMenu_Options["temp"]["MTScaling"]*UIParent:GetScale();
				for i = 1, 10, 1 do
					getglobal("CT_RAMTGroupMember" .. i):SetScale(newScaling);
				end
				CT_RAMTGroup:SetScale(newScaling);
				CT_RAMTGroupDrag:SetWidth(CT_RAMTGroup:GetWidth()*newScaling+(22*newScaling));
				CT_RAMTGroupDrag:SetHeight(CT_RAMTGroupMember1:GetHeight()*newScaling/2);
			end
			if ( CT_RAMenu_Options["temp"]["EMScaling"] ) then
				local newScaling = CT_RAMenu_Options["temp"]["EMScaling"]*UIParent:GetScale();
				CT_RA_EmergencyFrame:SetScale(newScaling);
				CT_RA_EmergencyFrameDrag:SetWidth(CT_RA_EmergencyFrame:GetWidth()*newScaling+(27.5*newScaling));
				CT_RA_EmergencyFrameDrag:SetHeight(CT_RA_EmergencyFrame:GetHeight()*newScaling/5);
			end
		end
	end

	if ( this.update ) then
		this.update = this.update - elapsed;
		if ( this.update <= 0 ) then
			this.update = nil;
			CT_RAMenuMisc_CheckTargetHealth();
			CT_RA_CurrCast = nil;
		end
	end
end

function CT_RAMenuMisc_CheckTargetHealth()
	if ( not CT_RA_CurrCast or IsControlKeyDown() or not CT_RA_InCombat ) then return; end
	for k, v in CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")] do
		if ( type(v[1]) == "table" ) then
			for key, val in v[1] do
				if ( val == CT_RA_CurrCast[1] ) then
					if ( CT_RA_CurrCast[2] == "target" ) then
						for i = 1, GetNumRaidMembers(), 1 do
							if ( UnitName("raid" .. i) == CT_RA_CurrCast[3] ) then
								CT_RA_CurrCast[2] = "raid" .. i;
								break;
							end
						end
					end
					if ( UnitExists(CT_RA_CurrCast[2]) and UnitHealthMax(CT_RA_CurrCast[2]) > 100 and CT_RA_CurrCast[3] == UnitName(CT_RA_CurrCast[2]) ) then
						if ( 
							( not CT_RAMenu_Options["temp"]["UsePercentValues"] and UnitHealth(CT_RA_CurrCast[2])-UnitHealthMax(CT_RA_CurrCast[2]) >= -v[3] and v[3] > 0 ) or
							( CT_RAMenu_Options["temp"]["UsePercentValues"] and UnitHealth(CT_RA_CurrCast[2])/UnitHealthMax(CT_RA_CurrCast[2]) < (v[5]/100) and v[5] ~= 100 )
						) then
							CT_RA_Print("<CTRaid> Aborted spell '|c00FFFFFF" .. CT_RA_CurrCast[1] .. "|r'.", 1, 0.5, 0);
							SpellStopCasting();
							return;
						end
					end
				end
			end
		elseif ( v[1] == CT_RA_CurrCast[1] ) then
			if ( CT_RA_CurrCast[2] == "target" ) then
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitName("raid" .. i) == CT_RA_CurrCast[3] ) then
						CT_RA_CurrCast[2] = "raid" .. i;
						break;
					end
				end
			end
			if ( UnitExists(CT_RA_CurrCast[2]) and UnitHealthMax(CT_RA_CurrCast[2]) > 100 ) then
				if ( 
					( not CT_RAMenu_Options["temp"]["UsePercentValues"] and UnitHealth(CT_RA_CurrCast[2])-UnitHealthMax(CT_RA_CurrCast[2]) >= -v[3] and v[3] > 0  ) or
					( CT_RAMenu_Options["temp"]["UsePercentValues"] and UnitHealth(CT_RA_CurrCast[2])/UnitHealthMax(CT_RA_CurrCast[2]) >= (v[5]/100) and v[5] ~= 100 )
				) then
					CT_RA_Print("<CTRaid> Aborted spell '|c00FFFFFF" .. CT_RA_CurrCast[1] .. "|r'.", 1, 0.5, 0);
					SpellStopCasting();
					return;
				end
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
	if ( event == "SPELLCAST_START" and CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")] ) then
		if ( not CT_RA_SpellTarget and UnitExists("target") ) then
			CT_RA_SpellTarget = "target";
		elseif ( not CT_RA_SpellTarget and UnitExists("mouseover") ) then
			return; -- Can't check on mouseover :(
		end
		if ( not CT_RA_SpellTarget ) then return; end
		for k, v in CT_RAMenu_Options["temp"]["ClassHealings"][CT_RA_GetLocale()][UnitClass("player")] do
			if ( type(v[1]) == "table" ) then
				for key, val in v[1] do
					if ( val == arg1 ) then
						CT_RA_CurrCast = { arg1, CT_RA_SpellTarget, UnitName(CT_RA_SpellTarget) };

						local time = (arg2/1000)-CT_RAMenu_Options["temp"]["SpellCastDelay"];
						if ( time < 0 ) then
							time = 0;
						end
						CT_RAMenuMisc_Schedule(time);
						return;
					end
				end
			elseif ( v[1] == arg1 ) then
				CT_RA_CurrCast = { arg1, CT_RA_SpellTarget, UnitName(CT_RA_SpellTarget) };
				local time = (arg2/1000)-CT_RAMenu_Options["temp"]["SpellCastDelay"];
				if ( time < 0 ) then
					time = 0;
				end
				CT_RAMenuMisc_Schedule(time);
				return;
			end
		end
	elseif ( event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" ) then
		CT_RA_CurrCast = nil;
		CT_RA_SpellTarget = nil;
	elseif ( event == "PLAYER_REGEN_ENABLED" ) then
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
	local newScaling = CT_RAMenu_Options["temp"]["WindowScaling"]*UIParent:GetScale();
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
		
		local newScaling = CT_RAMenu_Options["temp"]["EMScaling"]*UIParent:GetScale();
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
	CT_RA_UpdateRaidGroup();
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
	getglobal(slider:GetName() .. "Text"):SetText("MT Scaling - " .. floor(CT_RAMenu_Options["temp"]["MTScaling"]*100+0.5) .. "%");

	slider:SetMinMaxValues(0.5, 1.5);
	slider:SetValueStep(0.01);
	slider:SetValue(CT_RAMenu_Options["temp"]["MTScaling"]);
end

function CT_RAMenuAdditional_ScalingMT_OnValueChanged()
	CT_RAMenu_Options["temp"]["MTScaling"] = floor(this:GetValue()*100+0.5)/100;
	getglobal(this:GetName() .. "Text"):SetText("MT Scaling - " .. floor(this:GetValue()*100+0.5) .. "%");
	
	local newScaling = CT_RAMenu_Options["temp"]["MTScaling"]*UIParent:GetScale();
	for i = 1, 10, 1 do
		getglobal("CT_RAMTGroupMember" .. i):SetScale(newScaling);
	end
	CT_RAMTGroup:SetScale(newScaling);
	CT_RAMTGroupDrag:SetWidth(CT_RAMTGroup:GetWidth()*newScaling+(22*newScaling));
	CT_RAMTGroupDrag:SetHeight(CT_RAMTGroupMember1:GetHeight()*newScaling/2);
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
		CT_RAMenuFrameMiscAggroNotifierSoundCB:Disable();
		CT_RAMenuFrameMiscAggroNotifierSound:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscAggroNotifierSoundCB:Enable();
		CT_RAMenuFrameMiscAggroNotifierSound:SetTextColor(1, 1, 1);
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

function CT_RAMenuMisc_ManaConserve_UsePercent()
	CT_RAMenu_Options["temp"]["UsePercentValues"] = this:GetChecked();
	CT_RAMenuMisc_Slider_Update(this:GetParent():GetName() .. "Slider1");
	CT_RAMenuMisc_Slider_Update(this:GetParent():GetName() .. "Slider2");
end
function CT_RAMenu_Misc_SendRARS()
	CT_RAMenu_Options["temp"]["SendRARS"] = this:GetChecked();
end

function CT_RAMenu_Misc_ShowAFK()
	CT_RAMenu_Options["temp"]["ShowAFK"] = this:GetChecked();
	CT_RA_UpdateRaidGroup();
end

function CT_RAMenu_Misc_ShowMTTT()
	CT_RAMenu_Options["temp"]["ShowMTTT"] = this:GetChecked();
	if ( not this:GetChecked() ) then
		CT_RAMenuFrameMiscNoColorChangeCB:Disable();
		CT_RAMenuFrameMiscNoColorChange:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscNoColorChangeCB:Enable();
		CT_RAMenuFrameMiscNoColorChange:SetTextColor(1, 1, 1);
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
	CT_RA_UpdateRaidGroup();
	CT_RAOptions_Update();
end

function CT_RAMenu_Misc_NotifyGroupChange()
	CT_RAMenu_Options["temp"]["NotifyGroupChange"] = this:GetChecked();
	if ( not this:GetChecked() ) then
		CT_RAMenuFrameMiscNotifyGroupChangeCBSound:Disable();
		CT_RAMenuFrameMiscNotifyGroupChangeSound:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscNotifyGroupChangeCBSound:Enable();
		CT_RAMenuFrameMiscNotifyGroupChangeSound:SetTextColor(1, 1, 1);
	end
end

function CT_RAMenu_Misc_NotifyGroupChangeSound()
	CT_RAMenu_Options["temp"]["NotifyGroupChangeSound"] = this:GetChecked();
end

function CT_RA_UpdateResFrame()
	local text = "";
	for key, val in CT_RA_Ressers do
		if ( strlen(text) > 0 ) then
			text = text .. "\n";
		end
		text = text .. key .. ": " .. val;
	end
	if ( text == "" ) then
		text = "No current resurrections";
	end
	CT_RA_ResFrameText:SetText(text);
	CT_RA_ResFrame:SetWidth(max(CT_RA_ResFrameText:GetWidth()+15, 175));
	CT_RA_ResFrame:SetHeight(max(CT_RA_ResFrameText:GetHeight()+25, 50));
end

function CT_RAMenuHelp_LoadText()
	local texts = {
		"|c00FFFFFFShow Group Names -|r Turns on/off the headers for each group\n\n|c00FFFFFFLock Group Positions -|r Locks all CTRA windows in place\n\n|c00FFFFFFHide Mana Bars -|r Hides all players mana bars\n\n|c00FFFFFFHide Health Bars -|r Hides all players health bars\n\n|c00FFFFFFHide Rage/Energy Bars -|r Hides all players rage and energy bars\n\n|c00FFFFFFHealth Type -|r Allows you to show players health as a percentage,\nactual value, missing hp, only the percentage on MainTank targets,\nor not at all. You can also customize the color the text is shown in\n\n|c00FFFFFFWindow BG Color -|r Changes the color of CTRA window\nbackgrounds, dragging the slider all the way to 100%\nmakes them transparent\n\n|c00FFFFFFAlert Message Color -|r Sets the color the /rs alert messages\nshow in the middle of your screen",
		"|c00FFFFFFHide party frame -|r Hides your group members when in a raid\n\n|c00FFFFFFHide party frame out of raid -|r Hides your party frame when\nout of raids, primarily used for users of UI mods that use\nalternate party frames\n\n|c00FFFFFFHide offline members -|r Allows you to hide members who\nare offline, so they don't show in CTRA groups\n\n|c00FFFFFFHide short duration debuffs -|r Allows you to hide debuffs with\na duration under 10 seconds\n\n|c00FFFFFFHide border -|r Allows you to hide the border of each CTRA window\n\n|c00FFFFFFSort Type -|r Sort by either group, class, or custom.Sorting\nby Class displays each member in a class category, sorting\nby Custom allows you to change who shows up in which groups",
		"|c00FFFFFFEdit Channel -|r Allows you to change the CTRaid channel. Clicking the button again will set and join the new channel, leaving any old channels\n\n|c00FFFFFFBroadcast Channel -|r Broadcasts your CTRaid channel to the CTRA users in your raid. This will automatically join the channel for these users. Requires a status of promoted or leader",
		"Turning on a unit's target allows you to see what that player has targeted. Raid Leaders and Promoted can set MTs (Main Tanks) via the CTRaid tab by right clicking and setting that player as a MT",
		"Allows you to be notified via chat when someone\nbecomes debuffed with the types listed above,\nas well as allows you to be notified when someone\nloses a buff you are able to recast\n\n|c00FFFFFFNOTE:|r To quickly debuff a cured player, or recast a\nfaded buff, map a hotkey via the game key bindings\nmenu (|c00FFFFFFEscape|r > |c00FFFFFFKey Bindings|r > |c00FFFFFFCT_RaidAssist section|r)\nto one-click recast or cure";
		"Allows you to have CTRA cancel healing spells\nif the target has above a certain percentage of health.\n\n|c00FFFFFFCheck Time -|r Sets the amount of time before\n a healing spell lands to perform the health check.\n\n|c00FFFFFFNOTE:|r Only visible if you have any healing spells.",
		"Allows you to control how often CTRA sends messages.",
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
		CT_RA_UpdateRaidGroup();
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

	local num1, num2 = 0, 0;

	for key, val in t1 do
		if ( key ~= "unchanged" and val ~= false ) then
			num1 = num1 + 1;
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
			num2 = num2 + 1;
		end
	end

	if ( num1 ~= num2 ) then
		return false;
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

function CT_RAMenuBoss_SortTable(t1, t2)
	local locs = { };
	for k, v in CT_RABoss_Locations do
		locs[v[1]] = k;
	end
	if ( t1[2] and t2[2] ) then
		return locs[t1[1]] < locs[t2[1]];
	else
		local loc1, loc2;
		if ( t1[2] ) then
			loc1 = locs[t1[1]];
		else
			loc1 = locs[t1[4]];
		end
		if ( t2[2] ) then
			loc2 = locs[t2[1]];
		else
			loc2 = locs[t2[4]];
		end
		if ( loc1 == loc2 ) then
			if ( t1[2] or t2[2] ) then
				return (t1[2]);
			else
				return t1[1] < t2[1];
			end
		else
			return loc1 < loc2;
		end
	end
end

function CT_RAMenuBoss_CalculateEntries()
	local locIndexes = { };
	local tbl = { };
	local numPerLoc = { };
	
	-- Calculate number of mods per location
	for k, v in CT_RABoss_Mods do
		local loc = v["location"];
		if ( not loc ) then
			loc = "Other";
		end
		if ( not numPerLoc[loc] ) then
			numPerLoc[loc] = 1;
		else
			numPerLoc[loc] = numPerLoc[loc] + 1;
		end
	end
	-- Populate the locIndexes table with the locations we have
	for k, v in CT_RABoss_Locations do
		-- Only add if there are mods for it
		if ( numPerLoc[v[1]] ) then
			locIndexes[v[1]] = v[2];
			tinsert(tbl, { v[1], 1, v[2] });
		end
	end
	
	-- Calculate which records to add
	for k, v in CT_RABoss_Mods do
		if ( not v["location"] ) then
			v["location"] = "Other";
		end
		if ( locIndexes[v["location"]] and locIndexes[v["location"]] == 1 ) then
			tinsert(tbl, { k, nil, v, v["location"] });
		end
	end
	
	-- Sort the table
	table.sort(tbl, CT_RAMenuBoss_SortTable);
	
	return tbl, numPerLoc;
end

function CT_RAMenuBoss_ToggleHeader(name)
	for k, v in CT_RABoss_Locations do
		if ( v[1] == name ) then
			if ( v[2] == 1 ) then
				CT_RABoss_Locations[k][2] = 0;
			else
				CT_RABoss_Locations[k][2] = 1;
			end
			break;
		end
	end
	CT_RAMenuBoss_Update();
end

function CT_RAMenuBoss_Update()
	local tbl, numPerLoc = CT_RAMenuBoss_CalculateEntries();
	local numEntries = getn(tbl);
	-- ScrollFrame update
	FauxScrollFrame_Update(CT_RAMenuFrameBossScrollFrame, numEntries, 10, 25 );
	
	for i=1, 10, 1 do
		local obj = getglobal("CT_RAMenuFrameBossMod" .. i);
		local nameText = getglobal("CT_RAMenuFrameBossMod" .. i .. "Name");
		local descriptText = getglobal("CT_RAMenuFrameBossMod" .. i .. "Descript");
		local statusText = getglobal("CT_RAMenuFrameBossMod" .. i .. "Status");
		local line = getglobal("CT_RAMenuFrameBossMod" .. i .. "Line");
		local dropdown = getglobal("CT_RAMenuFrameBossMod" .. i .. "Menu");
		local plusMinus = getglobal("CT_RAMenuFrameBossMod" .. i .. "ShowHide");
		local prevLine = getglobal("CT_RAMenuFrameBossMod" .. i-1 .. "Line");
		
		local index = i + FauxScrollFrame_GetOffset(CT_RAMenuFrameBossScrollFrame); 
		if ( index <= numEntries ) then
			obj:Show();
			line:Hide();
			if ( not tbl[index][2] ) then
				-- Not a header
				obj.header = nil;
				nameText:SetText(tbl[index][1]);
				nameText:SetTextColor(0.5, 0.5, 0.5);
				nameText:ClearAllPoints();
				nameText:SetPoint("TOPLEFT", obj:GetName(), "TOPLEFT", 45, 0);
				plusMinus:Hide();
				if ( tbl[index][3]["status"] ) then
					statusText:SetText("On");
					statusText:SetTextColor(0, 1, 0);
				else
					statusText:SetText("Off");
					statusText:SetTextColor(1, 0, 0);
				end
				if ( tbl[index][3]["descript"] ) then
					descriptText:SetText(tbl[index][3]["descript"]);
				else
					descriptText:SetText("");
				end
				obj.index = tbl[index][1];
				if ( not obj.hasBeenInitialized ) then
					UIDropDownMenu_Initialize(dropdown,  CT_RAMenuBoss_InitDropDown, "MENU");
					obj.hasBeenInitialized = 1;
				end
			else
				if ( prevLine ) then
					prevLine:Show();
				end
				-- Header
				obj.header = 1;
				obj.headername = tbl[index][1];
				local num = numPerLoc[tbl[index][1]];
				if ( not num ) then
					num = 0;
				end
				plusMinus:Show();
				if ( tbl[index][3] == 1 ) then
					if ( obj.mouseIsOver ) then
						GameTooltip:SetText("Click to contract");
					end
					plusMinus:SetText("-");
					obj.expanded = 1;
				else
					if ( obj.mouseIsOver ) then
						GameTooltip:SetText("Click to expand");
					end
					plusMinus:SetText("+");
					obj.expanded = nil;
				end
				nameText:SetText(tbl[index][1] .. " (" .. num .. ")");
				nameText:SetTextColor(1, 1, 1);
				nameText:ClearAllPoints();
				nameText:SetPoint("LEFT", obj:GetName(), "LEFT", 12, 0);
				statusText:SetText("");
				descriptText:SetText("");
			end
		else
			obj:Hide();
		end

	end
end

function CT_RAMenuBoss_InitDropDown()
	local modName = getglobal(UIDROPDOWNMENU_INIT_MENU):GetParent().index;
	local info = {};
	
	info.text = modName;
	info.isTitle = 1;
	info.justifyH = "CENTER";
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	info.text = "Enable mod";
	info.tooltipTitle = "Enable mod";
	info.tooltipText = "Enables the mod, turning on all enabled options.";
	info.checked = CT_RABoss_Mods[modName]["status"];
	info.func = CT_RABoss_EnableMod;
	info.keepShownOnClick = 1;
	info.value = modName;
	UIDropDownMenu_AddButton(info);
	
	if ( CT_RABoss_DropDown[modName] ) then
		for k, v in CT_RABoss_DropDown[modName] do
			info = { };
			info.value = { modName, v[3] };
			info.keepShownOnClick = 1;
			if ( type(v[1]) == "string" ) then
				info.text = v[1];
			elseif ( type(v[1]) == "table" ) then
				info.text = v[1][1];
				info.tooltipTitle = v[1][1];
				info.tooltipText = v[1][2];
			end
			if ( type(getglobal(v[2])) == "function" ) then
				info.checked = getglobal(v[2])(modName, v[3]);
			else
				info.checked = getglobal(v[2]);
			end
			info.func = getglobal(v[4]);
			UIDropDownMenu_AddButton(info);
		end
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
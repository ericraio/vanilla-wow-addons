function GB_Checkbox_Initialize(box, value)
	if (value) then
		box:SetChecked(1);
	else
		box:SetChecked(0);
	end
end

function GB_Checkbox_OnClick(index, func)
	local value = false;
	if (this:GetChecked()) then
		value = true;
	end
	if (GB_BAR) then
		GB_Set(GB_BAR, index, value);
		if (func) then
			func(GB_BAR);
		end
	else
		GB_Set(index, value);
		if (string.find(index, "Bindings")) then
			GB_Update_Bindings();
		elseif (index == "Disable") then
			GB_DisableGB();
		elseif (index == "HideInRaid") then
			GB_Initialize_AllBars();
		end
	end
end

function GB_Checkbox_OnClick2(index, func, index2)
	local value = false;
	if (this:GetChecked()) then
		value = true;
	end
	if (this.index2) then
		GB_Settings[GB_INDEX][GB_BAR].Button[GB_BUTTON][index][index2] = value;
	else
		GB_Settings[GB_INDEX][GB_BAR].Button[GB_BUTTON][index] = value;
	end
	if (func) then
		func(GB_BAR, GB_BUTTON);
	end
end

function GB_ColorPicker_ColorCancelled()
	local color = ColorPickerFrame.previousValues;
	GB_Settings[GB_INDEX][ColorPickerFrame.index] = color;
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
end

function GB_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local color = { r=r, g=g, b=b };
	GB_Settings[GB_INDEX][ColorPickerFrame.index] = color;
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
end

function GB_ColorPicker_Show(index)
	local color = GB_Settings[GB_INDEX][index];
	ColorPickerFrame.previousValues = color;
	ColorPickerFrame.cancelFunc = GB_ColorPicker_ColorCancelled;
	ColorPickerFrame.opacityFunc = GB_ColorPicker_ColorChanged;
	ColorPickerFrame.func = GB_ColorPicker_ColorChanged;
	ColorPickerFrame.colorBox = this:GetName();
	ColorPickerFrame.index = index;
	ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
	ColorPickerFrame:ClearAllPoints();
	ColorPickerFrame:SetPoint("CENTER", "GB_Options", "CENTER", 0, 0);
	ColorPickerFrame:Show();
end

function GB_Copy_BarSettings()
	if (GB_BAR == GB_BAR_TO_COPY or (not GB_BAR_TO_COPY)) then return; end
	GB_Copy_Table(GB_Settings[GB_INDEX][GB_BAR_TO_COPY], GB_Settings[GB_INDEX][GB_BAR]);
	GB_Initialize_BarOptions(GB_BAR);
end

function GB_EditBox_OnTextChanged(index, subindex)
	if (not GB_INITIALIZED) then return; end
	if (subindex < 6) then
		GB_Settings[GB_INDEX].announcements[subindex] = this:GetText();
	elseif (subindex > 100) then
		GB_Settings[GB_INDEX][index][subindex - 100] = this:GetText();
	else
		GB_Settings[GB_INDEX][index] = this:GetText();
	end
end

function GB_Initialize_BarOptions(frame)
	GB_BAR_OPTIONS_INIT = true;
	local settings = GB_Get(frame);
	for i=1, 20 do
		GB_Options_InitAction(frame, i);
	end
	GB_OptionsTitle_Label:SetText(GB_TEXT[frame.."BarOptions"]);
	GB_Checkbox_Initialize(GB_Options_HideBar, settings.hide);
	GB_Checkbox_Initialize(GB_Options_Collapse, settings.collapse);
	GB_Checkbox_Initialize(GB_Options_Attach, settings.attach);
	GB_Checkbox_Initialize(GB_Options_Mouseover, settings.mouseover);
	GB_Slider_Initialize(GB_Options_ButtonSize, settings.buttonSize);
	GB_Slider_Initialize(GB_Options_ButtonAlpha, settings.alpha * 100);
	GB_Slider_Initialize(GB_Options_ButtonSpacing, settings.spacing);
	GB_Slider_Initialize(GB_Options_ButtonRows, settings.rows);
	GB_Slider_Initialize(GB_Options_XOffset, settings.xoffset);
	GB_Slider_Initialize(GB_Options_YOffset, settings.yoffset);
	for i,v in GB_ANCHOR_POINTS do
		if (v.value == settings.attachTo) then
			GB_BarOptions_AnchorTo_Setting:SetText(v.text);
			break;
		end
	end
	for i,v in GB_ANCHOR_POINTS do
		if (v.value == settings.attachPoint) then
			GB_BarOptions_AnchorPoint_Setting:SetText(v.text);
			break;
		end
	end
	GB_BarOptions_DefaultLeftClick_Setting:SetText("");
	GB_BarOptions_DefaultRightClick_Setting:SetText("");
	for _,value in GB_CLICK_MENU do
		if (value.i == GB_Settings[GB_INDEX][GB_BAR].oldLeftClick) then
			GB_BarOptions_DefaultLeftClick_Setting:SetText(value.v);
		end
		if (value.i == GB_Settings[GB_INDEX][GB_BAR].oldRightClick) then
			GB_BarOptions_DefaultRightClick_Setting:SetText(value.v);
		end
	end
	GB_BAR_OPTIONS_INIT = nil;
end

function GB_Menu_Anchors_OnClick(id)
	GB_Set(GB_BAR, GB_ANCHORS_INDEX, this.value);
	if (GB_ANCHORS_INDEX == "attachTo") then
		GB_BarOptions_AnchorTo_Setting:SetText(GB_ANCHOR_POINTS[this:GetID()].text);		
	else
		GB_BarOptions_AnchorPoint_Setting:SetText(GB_ANCHOR_POINTS[this:GetID()].text);	
	end
	GB_Set_Appearance(GB_BAR);
end

function GB_Menu_Announce_OnClick(id)
	GB_Set(GB_BAR, GB_BUTTON, "announceText", id);
	GB_Action_Options_Cast_AnnounceNum_Setting:SetText(id);
end

function GB_Menu_Clickboxes_OnClick()
	GB_CLICKBOX = this.index;
	GB_MiscOptions_ChooseClickbox_Setting:SetText(GB_CLICKBOX_MENU[this:GetID()].text);
	local offsets = GB_Settings[GB_INDEX][GB_CLICKBOX].Clickbox;
	GB_MiscOptions_ClickboxX1:SetValue(offsets.x1);
	GB_MiscOptions_ClickboxX2:SetValue(offsets.x2);
	GB_MiscOptions_ClickboxY1:SetValue(offsets.y1);
	GB_MiscOptions_ClickboxY2:SetValue(offsets.y2);
end

function GB_Menu_ClickCast_OnClick()
	local text = getglobal(this:GetName().."_Text"):GetText();
	if (GB_CLICKCAST_BUTTON == -1) then
		GB_Settings[GB_INDEX][GB_BAR].oldLeftClick = this.index;
		getglobal("GB_BarOptions_DefaultLeftClick_Setting"):SetText(text);
	elseif (GB_CLICKCAST_BUTTON == -2) then
		GB_Settings[GB_INDEX][GB_BAR].oldRightClick = this.index;
		getglobal("GB_BarOptions_DefaultRightClick_Setting"):SetText(text);
	else
		getglobal("GB_ActionOptions"..GB_CLICKCAST_BUTTON.."_ClickCast_Setting"):SetText(text);
		for index, value in GB_Settings[GB_INDEX][GB_BAR].clickCast do
			if (value == GB_CLICKCAST_BUTTON) then
				GB_Settings[GB_INDEX][GB_BAR].clickCast[index] = nil;
			end
		end
		if (this.index) then
			GB_Settings[GB_INDEX][GB_BAR].clickCast[this.index] = GB_CLICKCAST_BUTTON;
		end
	end
end

function GB_Menu_Contexts_OnClick()
	GB_Set(GB_BAR, GB_BUTTON, "context", this.index);
	GB_Action_Options_Display_Context_Setting:SetText(getglobal(this:GetName().."_Text"):GetText());
	GB_ActionButton_Initialize(GB_BAR, GB_BUTTON);
end

function GB_Menu_CopyBar_OnClick(id)
	GB_BAR_TO_COPY = this.value;
	GB_BarOptions_CopyBarControl_Setting:SetText(GB_COPYBAR_MENU[id].text);
end

function GB_Menu_Forms_OnClick(id)
	local form = getglobal(this:GetName().."_Text"):GetText();
	if (id == 99) then id = false; end
	GB_Set(GB_BAR, GB_BUTTON, "form", id);
	GB_Action_Options_Display_Form_Setting:SetText(form);
	GB_ActionButton_Initialize(GB_BAR, GB_BUTTON);
end

function GB_Menu_NumParty_OnClick(id)
	GB_Set("numPastAEThreshold", id);
	GB_ThresholdsOptions_NumPartyToCheck_Setting:SetText(id);
end

function GB_Menu_OutOfContext_OnClick(id)
	GB_Set(GB_BAR, GB_BUTTON, "OOCoption", GB_OOC_MENU[id].value);
	GB_Action_Options_Display_OutOfContext_Setting:SetText(GB_OOC_MENU[id].text);
end

function GB_Options_CheckAllRaidMembers()
	for i=1, GetNumRaidMembers() do
		getglobal("GB_RaidMemberSelect"..i):SetChecked(1);
		GB_RAID_MEMBERS[UnitName("raid"..i)] = true;
		local raidframe = getglobal("GB_RaidBar"..i);
		raidframe.noshow = false;
		raidframe:Show();
	end
end

function GB_Options_HideAllWindows()
	GB_AnnounceOptions:Hide();
	GB_BarOptions:Hide();
	GB_MiscOptions:Hide();
	GB_ThresholdsOptions:Hide();
	GB_RaidMemberSelect:Hide();
end

function GB_Options_InitAction(bar, button)
	local settings = GB_Get(bar, button);
	local texture = GB_Get_Texture(bar, button);
	local name = "";
	if (settings.name) then
		name = settings.name.." "..settings.rank;
	end
	getglobal("GB_ActionOptions"..button.."_Dropbox_Texture"):SetTexture(texture);
	getglobal("GB_ActionOptions"..button.."_ActionName"):SetText(name);
	local menucontrol = getglobal("GB_ActionOptions"..button.."_ClickCast_Setting");
	local valueFound;
	for index,value in GB_Settings[GB_INDEX][bar].clickCast do
		if (value == button) then
			local text;
			for _,value2 in GB_CLICK_MENU do
				if (value2.i == index) then
					text = value2.v;
				end
			end
			menucontrol:SetText(text);
			valueFound = 1;
		end
	end
	if (not valueFound) then
		menucontrol:SetText("");
	end
end

function GB_Options_InitActionOptions(bar, button)
	local settings = GB_Get(bar, button);
	local spellname = settings.name;
	if (settings.rank and settings.rank ~= "") then
		spellname = spellname.." ("..settings.rank..")";
	end
	GB_Action_Options_Name:SetText(spellname);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_Assist, settings.assist);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_Announce, settings.announce);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_AutoUpdate, settings.autoUpdate);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_PreventRebuff, settings.preventRebuff);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_ScaleRank, settings.scaleRank);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_PreventOverhealing, settings.preventOverhealing);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_PreventOverkill, settings.preventOverkill);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_MatchSpellName, settings.matchSpellName);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_MatchCastingTime, settings.matchCastingTime);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_LowManaRank, settings.lowManaRank);
	GB_Checkbox_Initialize(GB_Action_Options_Cast_CancelHeal, settings.cancelHeal);
	GB_Checkbox_Initialize(GB_Action_Options_Display_InCombat, settings.inCombat);
	GB_Checkbox_Initialize(GB_Action_Options_Display_FlashInContext, settings.flashInContext);
	GB_Checkbox_Initialize(GB_Action_Options_Display_NotInCombat, settings.notInCombat);
	GB_Checkbox_Initialize(GB_Action_Options_Display_ValidTarget, settings.validTarget);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Druid, settings.classes[GB_TEXT.Druid]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Priest, settings.classes[GB_TEXT.Priest]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Warrior, settings.classes[GB_TEXT.Warrior]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Warlock, settings.classes[GB_TEXT.Warlock]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Hunter, settings.classes[GB_TEXT.Hunter]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Rogue, settings.classes[GB_TEXT.Rogue]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Mage, settings.classes[GB_TEXT.Mage]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Shaman, settings.classes[GB_TEXT.Shaman]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_Paladin, settings.classes[GB_TEXT.Paladin]);
	GB_Checkbox_Initialize(GB_Action_Options_Display_HideButton, settings.hide);
	GB_Checkbox_Initialize(GB_Action_Options_Display_PlayerOnly, settings.playerOnly);
	for i,v in GB_CONTEXTS do
		if (v.index == settings.context) then
			GB_Action_Options_Display_Context_Setting:SetText(v.text);
		end	
	end
	if (settings.form == 0) then
		GB_Action_Options_Display_Form_Setting:SetText(GB_TEXT.NoForm);
	elseif (settings.form) then
		local _, form = GetShapeshiftFormInfo(settings.form);
		GB_Action_Options_Display_Form_Setting:SetText(form);
	else
		GB_Action_Options_Display_Form_Setting:SetText("");
	end
	GB_Action_Options_Cast_AnnounceNum_Setting:SetText(settings.announceText);
	for i,v in GB_OOC_MENU do
		if (v.value == settings.OOCoption) then
			GB_Action_Options_Display_OutOfContext_Setting:SetText(v.text);
		end	
	end
end

function GB_Options_ShowClickCastMenu()
	if (GB_Menu_ClickCast:IsVisible()) then
		GB_Menu_ClickCast:Hide();
		return;
	end

	GB_CLICKCAST_BUTTON = this:GetParent():GetParent():GetID();

	if (this:GetID() > 0) then
		GB_CLICKCAST_BUTTON = -this:GetID();
	end
	
	local count = 1;
	GB_Menu_ClickCast_Option1_Text:SetText(GB_TEXT.None);
	local width = GB_Menu_ClickCast_Option1_Text:GetWidth();
	for _,menuoption in GB_CLICK_MENU do
		local indexFound;
		for index in GB_Settings[GB_INDEX][GB_BAR].clickCast do
			if (index == menuoption.i) then
				indexFound = 1;
			end
		end
		if (GB_Settings[GB_INDEX][GB_BAR].oldLeftClick == menuoption.i) then
			indexFound = 1;
		end
		if (GB_Settings[GB_INDEX][GB_BAR].oldRightClick == menuoption.i) then
			indexFound = 1;
		end
		if (not indexFound) then
			count = count + 1
			getglobal("GB_Menu_ClickCast_Option"..count).index = menuoption.i;
			local optiontext = getglobal("GB_Menu_ClickCast_Option"..count.."_Text");
			optiontext:SetText(menuoption.v);
			if (optiontext:GetWidth() > width) then
				width = optiontext:GetWidth();
			end
		end
	end
	for i=1,27 do
		getglobal("GB_Menu_ClickCast_Option"..i):SetWidth(width);
		if (i > count) then
			getglobal("GB_Menu_ClickCast_Option"..i):Hide();
		else
			getglobal("GB_Menu_ClickCast_Option"..i):Show();
		end
	end
	GB_Menu_ClickCast:SetWidth(width + 20);
	GB_Menu_ClickCast:SetHeight(count * 15 + 20);
	GB_Menu_ClickCast:ClearAllPoints();
	GB_Menu_ClickCast:SetPoint("TOPLEFT", this:GetParent():GetName(), "BOTTOMLEFT", 0, 0);
	local bottom = GB_Menu_ClickCast:GetBottom() / UIParent:GetScale();
	if (bottom < UIParent:GetBottom()) then
		GB_Menu_ClickCast:ClearAllPoints();
		GB_Menu_ClickCast:SetPoint("BOTTOMLEFT", this:GetParent():GetName(), "TOPLEFT", 0, 0);
	end
	GB_Menu_ClickCast:Show();
end

function GB_Options_ShowMenu(menu)
	menu = getglobal(menu);
	if (menu:IsVisible()) then
		menu:Hide();
	else
		if (this:GetParent().index == "attachTo" or this:GetParent().index == "attachPoint") then
			GB_ANCHORS_INDEX = this:GetParent().index;
		end
		menu:ClearAllPoints();
		menu:SetPoint("TOPLEFT", this:GetParent():GetName(), "BOTTOMLEFT", 0, 0);
		menu:Show();
	end
end

function GB_Options_ShowPopup(bar, button)
	if (GB_Action_Options:IsVisible()) then
		GB_BUTTON = nil;
		GB_Action_Options:Hide();
	else
		GB_BUTTON = button;
		GB_Options_InitActionOptions(bar, button);
		GB_Action_Options:ClearAllPoints();
		GB_Action_Options:SetPoint("TOPLEFT", this:GetName(), "BOTTOMLEFT", 0, 0);
		GB_Action_Options:Show();
		local xoffset = UIParent:GetRight() - GB_Action_Options:GetRight() - 110;
		local yoffset = GB_Action_Options:GetBottom();
		if (xoffset > 0) then xoffset = 0 end
		if (yoffset > 0) then yoffset = 0 end
		if ((xoffset + yoffset) < 0) then
			GB_Action_Options:ClearAllPoints();
			GB_Action_Options:SetPoint("TOPLEFT", this:GetName(), "BOTTOMLEFT", xoffset, -yoffset);
		end
	end
end

function GB_PickupAction(id, id2, idtype)
	if (idtype == "spell") then
		PickupSpell(GB_SPELLS[id][id2].id, "BOOKTYPE_SPELL");
	elseif (idtype == "item") then
		PickupContainerItem(GB_ITEMS[id].bag, GB_ITEMS[id].slot);
	elseif (idtype == "inv") then
		PickupInventoryItem(GB_INVENTORY[id].id);
	elseif (idtype == "macro") then
		GB_Old_PickupMacro(GB_MACROS[id].id);
	end
end

function GB_RaidMemberSelect_OnClick()
	local raidframe = getglobal("GB_RaidBar"..this:GetID());
	if (this:GetChecked()) then
		GB_RAID_MEMBERS[UnitName("raid"..this:GetID())] = true;
		raidframe.noshow = false;
		raidframe:Show();
	else
		GB_RAID_MEMBERS[UnitName("raid"..this:GetID())] = nil;
		GB_SKIP_NAMES[UnitName("raid"..this:GetID())] = 1;
		raidframe.noshow = true;
		raidframe:Hide();
	end
end

function GB_Set_Anchor(subframe, xoffset, yoffset)
	xoffset = getglobal(this:GetName().."_Label"):GetWidth() + xoffset + 5;
	this:SetPoint("TOPLEFT", this:GetParent():GetName()..subframe, "BOTTOMLEFT", xoffset, yoffset);
end

function GB_Set_BoxNum()
	local fn = this:GetName();
	getglobal(fn.."_BoxNum"):SetText(this:GetID());
end

function GB_Set_HealingBonus()
	local n = GB_MiscOptions_HealingBonus:GetNumber();
	if (not n) then n = 0; end
	GB_Settings[GB_INDEX].HealingBonus = n;
	GB_Update_Spells(1);
end

function GB_Set_Label(labeltext)
	local fn = this:GetName();
	getglobal(fn.."_Label"):SetText(labeltext);
end

function GB_Show_OptionsFrame(frame)
	if (frame == "main") then
		if (GB_Options:IsVisible()) then
			GB_Options:Hide();
			if (not GB_Settings[GB_INDEX].Disable) then
				for _,box in GB_CLICKBOXES do
					getglobal(box):Hide();
					getglobal(box.."_Texture"):Hide();
				end
				if (not GB_Get("hideClickboxes")) then
					GB_PlayerClickbox:Show();
					if (UnitName("target")) then
						GB_TargetClickbox:Show();
					end
					if (UnitName("pet")) then
						GB_Pet0Clickbox:Show();
					end
					for i=1,GetNumPartyMembers() do
						getglobal("GB_Party"..i.."Clickbox"):Show();
						if (UnitName("partypet"..i)) then
							getglobal("GB_Pet"..i.."Clickbox"):Show();
						end
					end
				end
			end
		else
			GB_Options:Show();
			if (not GB_Settings[GB_INDEX].Disable) then
				for _,box in GB_CLICKBOXES do
					if (not GB_Get("hideClickboxes")) then getglobal(box):Show(); end
					getglobal(box.."_Texture"):Show();
				end
			end
		end
		if (not GB_Settings[GB_INDEX].Disable) then
			GB_Initialize_AllBars();
		end
	elseif (frame == "misc") then
		GB_Options_HideAllWindows();
		GB_BAR = nil;
		GB_MiscOptions:Show();
		GB_OptionsTitle_Label:SetText(GB_TEXT.MiscellaneousOptions);
	elseif (frame == "announce") then
		GB_Options_HideAllWindows();
		GB_BAR = nil;
		GB_AnnounceOptions:Show();
		GB_OptionsTitle_Label:SetText(GB_TEXT.AnnounceOptions2);
	elseif (frame == "thresholds") then
		GB_Options_HideAllWindows();
		GB_BAR = nil;
		GB_ThresholdsOptions:Show();
		GB_OptionsTitle_Label:SetText(GB_TEXT.SetThresholdValues);
	elseif (frame == "raidmembers") then
		GB_Options_HideAllWindows();
		GB_RaidMemberSelect:Show();
		GB_OptionsTitle_Label:SetText(GB_TEXT.SelectRaidMembers);
	else
		GB_Options_HideAllWindows();
		GB_BAR = frame;
		if (not GB_Settings[GB_INDEX].Disable) then GB_Initialize_BarOptions(frame); end
		GB_BarOptions:Show();
	end
end

function GB_Slider_Initialize(slider, value)
	slider:SetValue(value);
	getglobal(slider:GetName().."_Display"):SetText(value);
end

function GB_Slider_OnValueChanged(index, func)
	if (not GB_INITIALIZED) then return; end
	if (GB_BAR_OPTIONS_INIT) then return; end
	if (this:GetID() == 555 and (not GB_CLICKBOX)) then return; end
	local value = this:GetValue();
	getglobal(this:GetName().."_Display"):SetText(value);
	if (this.scale) then
		value = value / this.scale;
	end
	if (this:GetID() == 555) then
		GB_Settings[GB_INDEX][GB_CLICKBOX].Clickbox[this.index] = value;
	else
		GB_Settings[GB_INDEX][GB_BAR][index] = value;
	end
	func(GB_BAR);
end

function GB_Slider_UpdateFromEditBox(maxlock, index, func)
	this:ClearFocus();
	local value = this:GetNumber();
	local min, max = this:GetParent():GetMinMaxValues();
	if (value < min) then
		value = min;
	elseif (value > max and maxlock) then
		value = max;
	end
	if (value <= max) then
		this:SetText(value);
		this:GetParent():SetValue(this:GetNumber());
	else
		if (this:GetParent():GetID() == 555) then
			GB_Settings[GB_INDEX][GB_CLICKBOX].Clickbox[this:GetParent().index] = value;
		else
			GB_Set(GB_BAR, index, value);
		end
		func(GB_BAR);
	end
end

function GB_Toggle_BarLock()
	if (GB_Get("barsLocked")) then
		GB_Set("barsLocked", false);
		GB_LockBars_Button:SetText(GB_TEXT.LockBars);
	else
		GB_Set("barsLocked", true);
		GB_LockBars_Button:SetText(GB_TEXT.UnlockBars);
	end
end

function GB_Toggle_Bars()
	local value = true;
	if (GB_Settings[GB_INDEX].player.hide) then value = false; end
	for bar in GB_UNITS_ARRAY do
		GB_Settings[GB_INDEX][bar].hide = value;
		GB_Set_Appearance(bar);
	end
end

function GB_Toggle_ButtonsLock()
	if (GB_Get("buttonsLocked")) then
		GB_Set("buttonsLocked", false);
		GB_LockButtons_Button:SetText(GB_TEXT.LockButtons);
	else
		GB_Set("buttonsLocked", true);
		GB_LockButtons_Button:SetText(GB_TEXT.UnlockButtons);
	end
end

function GB_Toggle_Clickboxes()
	if (GB_Get("hideClickboxes") and (not DUF_TargetOfTargetFrame)) then
		GB_Set("hideClickboxes", false);
		GB_HideClickboxes_Button:SetText(GB_TEXT.HideClickboxes);
		GB_PlayerClickbox:Show();
		if (UnitName("pet")) then
			GB_Pet0Clickbox:Show();
		end
		for i = 1, 4 do
			if (i <= GetNumPartyMembers()) then
				getglobal("GB_Party"..i.."Clickbox"):Show();
				if (UnitName("partypet"..i)) then
					getglobal("GB_Pet"..i.."Clickbox"):Show();
				end
			end
		end
		if (UnitName("target")) then
			GB_TargetClickbox:Show();
		end
	else
		GB_Set("hideClickboxes", true);
		GB_HideClickboxes_Button:SetText(GB_TEXT.ShowClickboxes);
		GB_PlayerClickbox:Hide();
		GB_Party1Clickbox:Hide();
		GB_Party2Clickbox:Hide();
		GB_Party3Clickbox:Hide();
		GB_Party4Clickbox:Hide();
		GB_Pet0Clickbox:Hide();
		GB_Pet1Clickbox:Hide();
		GB_Pet2Clickbox:Hide();
		GB_Pet3Clickbox:Hide();
		GB_Pet4Clickbox:Hide();
		GB_TargetClickbox:Hide();
	end
end

function GB_Toggle_EmptyButtons()
	if (GB_Get("showEmpty")) then
		GB_Settings[GB_INDEX].showEmpty = nil;
		GB_ShowEmpty_Button:SetText(GB_TEXT.ShowEmpty);
	else
		GB_Settings[GB_INDEX].showEmpty = true;
		GB_ShowEmpty_Button:SetText(GB_TEXT.HideEmpty);
	end
end

function GB_Toggle_Labels()
	if (GB_Get("showLabels")) then
		GB_Labels_Hide();
		GB_Set("showLabels", false);
		GB_ShowLabels_Button:SetText(GB_TEXT.ShowLabels);
	else
		GB_Labels_Show();
		GB_Set("showLabels", true);
		GB_ShowLabels_Button:SetText(GB_TEXT.HideLabels);
	end
end

function GB_Toggle_MiniSpellbook()
	if (GB_MiniSpellbook:IsVisible()) then
		GB_MiniSpellbook:Hide();
	else
		GB_MiniSpellbook:Show();
	end
end

function GB_Update_Spellbox(button, bar)
	if (not bar) then
		bar = GB_BAR;
	end
	local oldSettings = {};
	GB_Copy_Table(GB_Get(bar, button), oldSettings);
	if (GB_MOUSE_ACTION.id) then
		GB_Copy_Table(GB_MOUSE_ACTION.options, GB_Settings[GB_INDEX][bar].Button[button]);
		GB_Set(bar, button, "name", GB_MOUSE_ACTION.id);
		GB_Set(bar, button, "rank", GB_MOUSE_ACTION.id2);
		GB_Set(bar, button, "idType", GB_MOUSE_ACTION.idtype);
		GB_PickupAction(GB_MOUSE_ACTION.id, GB_MOUSE_ACTION.id2, GB_MOUSE_ACTION.idtype);
	else
		GB_Settings[GB_INDEX][bar].Button[button] = GB_Get_DefaultButtonSettings();
	end
	GB_Clear_MouseAction();
	if (oldSettings.name) then
		GB_PickupAction(oldSettings.name, oldSettings.rank, oldSettings.idType);
		GB_Set_MouseAction(oldSettings.name, oldSettings.rank, oldSettings.idType, oldSettings);
	end
	GB_Options_InitAction(bar, button);
	GB_ActionButton_Initialize(bar, button)
end
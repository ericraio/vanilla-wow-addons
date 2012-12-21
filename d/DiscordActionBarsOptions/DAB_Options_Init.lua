function DAB_Init_BarOptions()
	local settings = DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX];
	local text = string.gsub(DAB_TEXT.BarOptions, "$n", DAB_OBJECT_SUBINDEX);
	DAB_Options_Header_Text:SetText(text);
	DAB_BarOptions_BarControl_Condition_Setting:SetText("");
	DAB_BarOptions_BarControl_Response_Setting:SetText("");
	DAB_CONDITION_BUFFER = nil;
	DAB_Reset_Parameters("DAB_BarOptions_BarControl");
	DAB_Reset_Parameters("DAB_BarOptions_ButtonControl");
	DAB_BAR_PAGES = {};
	for i=1, settings.numBars do
		DAB_BAR_PAGES[i] = {text=i, value=i};
	end

	local index = 0;
	DAB_BAR_BUTTONS = {};
	for page = 1, settings.numBars do
		for button = 1, settings.numButtons do
			index = index + 1;
			DAB_BAR_BUTTONS[index] = {page = page, button = button};
		end
	end
	DAB_SELECTED_BARBUTTON = 1;
	DAB_BarButtonsMenu_Update();
	DAB_ConditionMenu_Update();

	-- Basic Bar Config
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_Hide, settings.hide);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_DisableMousewheel, settings.disableMW);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_HideOnClick, settings.hideonclick);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_LockButtons, settings.buttonsLocked);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_DisableTooltips, settings.disableTooltips);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_AutoAttack, settings.autoAttack);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_PetAutoAttack, settings.petAutoAttack);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_HideEmpty, settings.hideEmpty);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_Collapse, settings.collapse);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_CooldownCount, settings.cooldownCount);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_HideGlobalCooldown, settings.hideGlobalCD);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_TileOpt, settings.Background.tile);
	DL_Init_CheckBox(DAB_BarOptions_BarAppearance_HideBackdrop, settings.Background.hide);
	DAB_BarOptions_BarAppearance_Rows.minmaxset = nil;
	if (settings.numButtons == 0) then
		DAB_BarOptions_BarAppearance_Rows:SetMinMaxValues(1, 1);
	else
		DAB_BarOptions_BarAppearance_Rows:SetMinMaxValues(1, settings.numButtons);
	end
	DL_Init_Slider(DAB_BarOptions_BarAppearance_Rows, settings.rows);
	DL_Init_Slider(DAB_BarOptions_BarAppearance_Size, settings.size);
	DL_Init_Slider(DAB_BarOptions_BarAppearance_HSpacing, settings.hspacing);
	DL_Init_Slider(DAB_BarOptions_BarAppearance_VSpacing, settings.vspacing);
	DL_Init_Slider(DAB_BarOptions_BarAppearance_Alpha, settings.alpha);
	DL_Init_Slider(DAB_BarOptions_BarAppearance_BGAlpha, settings.Background.alpha);
	DL_Init_Slider(DAB_BarOptions_BarAppearance_BorderAlpha, settings.Background.balpha);
	DL_Init_MenuControl(DAB_BarOptions_BarAppearance_AnchorFrame, settings.Anchor.frame, 1);
	DL_Init_MenuControl(DAB_BarOptions_BarAppearance_AnchorPoint, settings.Anchor.point);
	DL_Init_MenuControl(DAB_BarOptions_BarAppearance_AnchorTo, settings.Anchor.to);
	DL_Init_MenuControl(DAB_BarOptions_BarAppearance_BGTexture, settings.Background.texture, 1);
	DL_Init_MenuControl(DAB_BarOptions_BarAppearance_BorderTexture, settings.Background.btexture, 1);
	DL_Init_ColorPicker(DAB_BarOptions_BarAppearance_BGColor, settings.Background.color);
	DL_Init_ColorPicker(DAB_BarOptions_BarAppearance_BorderColor, settings.Background.bcolor);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_SkipPages, settings.skipPages);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_XOffset, settings.Anchor.x);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_YOffset, settings.Anchor.y);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_TileSize, settings.Background.tileSize);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_EdgeSize, settings.Background.edgeSize);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_InsetLeft, settings.Background.left);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_InsetRight, settings.Background.right);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_InsetTop, settings.Background.top);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_InsetBottom, settings.Background.bottom);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_PadLeft, settings.Background.leftpadding);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_PadRight, settings.Background.rightpadding);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_PadTop, settings.Background.toppadding);
	DL_Init_EditBox(DAB_BarOptions_BarAppearance_PadBottom, settings.Background.bottompadding);

	-- Advanced Bar Config
	DL_Init_CheckBox(DAB_BarOptions_ButtonAppearance_DisableMouse, settings.disableMouse);
	DL_Init_CheckBox(DAB_BarOptions_ButtonAppearance_ExpandHidden, settings.expandHidden);
	DL_Init_CheckBox(DAB_BarOptions_ButtonAppearance_TrimEdges, settings.trimEdges);
	DL_Init_CheckBox(DAB_BarOptions_ButtonAppearance_ForceTarget, settings.forceTarget);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_CBGroup, settings.cbgroup);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_RightClick, settings.rightClick);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_MiddleClick, settings.middleClick);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_Target, settings.target);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_FrameStrata, settings.frameStrata);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_RangeRecolor, settings.rangerecolor);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_ManaRecolor, settings.manarecolor);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_UnusableRecolor, settings.unusablerecolor);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_ButtonBG, settings.buttonbg);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_Checked, settings.checked);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_Highlight, settings.highlight);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_Equipped, settings.ButtonBorder.etexture);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_Border, settings.ButtonBorder.texture);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_KBFont, settings.Keybinding.font);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_CCFont, settings.Cooldown.font);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_CntFont, settings.Count.font);
	DL_Init_MenuControl(DAB_BarOptions_ButtonAppearance_MNFont, settings.Macro.font);
	DL_Init_Slider(DAB_BarOptions_ButtonAppearance_BorderAlpha, settings.ButtonBorder.alpha);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_RangeColor, settings.rangecolor);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_ManaColor, settings.manacolor);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_UnusableColor, settings.unusablecolor);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_ButtonBGColor, settings.buttonbgcolor);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_CheckedColor, settings.checkedcolor);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_HighlightColor, settings.highlightcolor);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_EquippedColor, settings.ButtonBorder.ecolor);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_BorderColor, settings.ButtonBorder.color);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_KBColor, settings.Keybinding.color);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_CCColor, settings.Cooldown.color);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_CntColor, settings.Count.color);
	DL_Init_ColorPicker(DAB_BarOptions_ButtonAppearance_MNColor, settings.Macro.color);
	DL_Init_EditBox(DAB_BarOptions_ButtonAppearance_KBSize, settings.Keybinding.size);
	DL_Init_EditBox(DAB_BarOptions_ButtonAppearance_CCSize, settings.Cooldown.size);
	DL_Init_EditBox(DAB_BarOptions_ButtonAppearance_CntSize, settings.Count.size);
	DL_Init_EditBox(DAB_BarOptions_ButtonAppearance_MNSize, settings.Macro.size);
	DL_Init_EditBox(DAB_BarOptions_ButtonAppearance_PadLeft, settings.ButtonBorder.leftpadding);
	DL_Init_EditBox(DAB_BarOptions_ButtonAppearance_PadRight, settings.ButtonBorder.rightpadding);
	DL_Init_EditBox(DAB_BarOptions_ButtonAppearance_PadTop, settings.ButtonBorder.toppadding);
	DL_Init_EditBox(DAB_BarOptions_ButtonAppearance_PadBottom, settings.ButtonBorder.bottompadding);
	DL_Init_CheckBox(DAB_BarOptions_ButtonAppearance_KBHide, settings.Keybinding.hide);
	DL_Init_CheckBox(DAB_BarOptions_ButtonAppearance_CCHide, settings.Cooldown.hide);
	DL_Init_CheckBox(DAB_BarOptions_ButtonAppearance_CntHide, settings.Count.hide);
	DL_Init_CheckBox(DAB_BarOptions_ButtonAppearance_MNHide, settings.Macro.hide);

	-- Label Options
	DL_Init_CheckBox(DAB_BarOptions_Label_Hide, settings.Label.hide);
	DL_Init_CheckBox(DAB_BarOptions_Label_TileOpt, settings.Label.tile);
	DL_Init_EditBox(DAB_BarOptions_Label_EdgeSize, settings.Label.edgeSize);
	DL_Init_EditBox(DAB_BarOptions_Label_TileSize, settings.Label.tileSize);
	DL_Init_EditBox(DAB_BarOptions_Label_InsetLeft, settings.Label.left);
	DL_Init_EditBox(DAB_BarOptions_Label_InsetRight, settings.Label.right);
	DL_Init_EditBox(DAB_BarOptions_Label_InsetTop, settings.Label.top);
	DL_Init_EditBox(DAB_BarOptions_Label_Text, settings.Label.text);
	DL_Init_EditBox(DAB_BarOptions_Label_InsetBottom, settings.Label.bottom);
	DL_Init_Slider(DAB_BarOptions_Label_Alpha, settings.Label.alpha);
	DL_Init_Slider(DAB_BarOptions_Label_Height, settings.Label.height);
	DL_Init_Slider(DAB_BarOptions_Label_Width, settings.Label.width);
	DL_Init_Slider(DAB_BarOptions_Label_FontSize, settings.Label.fontsize);
	DL_Init_Slider(DAB_BarOptions_Label_BGAlpha, settings.Label.bgalpha);
	DL_Init_Slider(DAB_BarOptions_Label_BorderAlpha, settings.Label.bordalpha);
	DL_Init_MenuControl(DAB_BarOptions_Label_AnchorPoint, settings.Label.attachpoint);
	DL_Init_MenuControl(DAB_BarOptions_Label_AnchorTo, settings.Label.attachto);
	DL_Init_MenuControl(DAB_BarOptions_Label_JustifyH, settings.Label.justifyH);
	DL_Init_MenuControl(DAB_BarOptions_Label_JustifyV, settings.Label.justifyV);
	DL_Init_MenuControl(DAB_BarOptions_Label_Font, settings.Label.font);
	DL_Init_MenuControl(DAB_BarOptions_Label_BGTexture, settings.Label.texture, 1);
	DL_Init_MenuControl(DAB_BarOptions_Label_BorderTexture, settings.Label.btexture, 1);
	DL_Init_ColorPicker(DAB_BarOptions_Label_Color, settings.Label.color);
	DL_Init_ColorPicker(DAB_BarOptions_Label_BGColor, settings.Label.bgcolor);
	DL_Init_ColorPicker(DAB_BarOptions_Label_BorderColor, settings.Label.bordcolor);
	DL_Init_EditBox(DAB_BarOptions_Label_XOffset, settings.Label.x);
	DL_Init_EditBox(DAB_BarOptions_Label_YOffset, settings.Label.y);
end

function DAB_Init_ButtonLayout()
	DAB_NumButtons_FreeButtons:SetText(table.getn(DAB_Settings[DAB_INDEX].FreeButtons));
	for _,button in DAB_Settings[DAB_INDEX].FreeButtons do
		getglobal("DAB_ActionButton_"..button):Hide();
	end
	for i=1,10 do
		getglobal("DAB_NumButtons_Bar"..i.."_Label"):SetText("["..DAB_TEXT.Bar.." "..i.."] "..DAB_Settings[DAB_INDEX].Bar[i].Label.text);
		getglobal("DAB_NumButtons_Bar"..i.."_Setting"):SetText(DAB_Settings[DAB_INDEX].Bar[i].numButtons);
		getglobal("DAB_NumButtons_Bar"..i.."Pages_Setting"):SetText(DAB_Settings[DAB_INDEX].Bar[i].numBars);
		getglobal("DAB_NumButtons_Bar"..i.."Pages_Setting"):SetTextColor(0, 1, 0);
	end
	local count = 0;
	for x in DAB_Settings[DAB_INDEX].Floaters do
		count = count + 1;
	end
	DAB_NumButtons_Floaters_Setting:SetText(count);
end

function DAB_Init_ControlBoxOptions()
	local settings = DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX];
	if (not settings.changePageBar) then
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].changePageBar = 1;
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].changePageType = 1;
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].changePagePage = 1;
	end
	local text = string.gsub(DAB_TEXT.ControlBoxOptions, "$n", DAB_OBJECT_SUBINDEX);
	DAB_Options_Header_Text:SetText(text);
	DL_Init_CheckBox(DAB_CBoxOptions_Config_Hide, settings.hide);
	DL_Init_CheckBox(DAB_CBoxOptions_Config_HideTop, settings.b1hide);
	DL_Init_CheckBox(DAB_CBoxOptions_Config_HideBottom, settings.b2hide);
	DL_Init_CheckBox(DAB_CBoxOptions_Config_HideLeft, settings.b3hide);
	DL_Init_CheckBox(DAB_CBoxOptions_Config_HideRight, settings.b4hide);
	DL_Init_EditBox(DAB_CBoxOptions_Config_Text, settings.text);
	DL_Init_EditBox(DAB_CBoxOptions_Config_XOffset, settings.Anchor.x);
	DL_Init_EditBox(DAB_CBoxOptions_Config_YOffset, settings.Anchor.y);
	DL_Init_EditBox(DAB_CBoxOptions_Config_TextXOffset, settings.TextAnchor.x);
	DL_Init_EditBox(DAB_CBoxOptions_Config_TextYOffset, settings.TextAnchor.y);
	DL_Init_EditBox(DAB_CBoxOptions_Config_WidthTop, settings.b1width);
	DL_Init_EditBox(DAB_CBoxOptions_Config_WidthBottom, settings.b2width);
	DL_Init_EditBox(DAB_CBoxOptions_Config_WidthLeft, settings.b3width);
	DL_Init_EditBox(DAB_CBoxOptions_Config_WidthRight, settings.b4width);
	DL_Init_ColorPicker(DAB_CBoxOptions_Config_Color, settings.color);
	DL_Init_ColorPicker(DAB_CBoxOptions_Config_MColor, settings.mcolor);
	DL_Init_ColorPicker(DAB_CBoxOptions_Config_BGColor, settings.bgcolor);
	DL_Init_ColorPicker(DAB_CBoxOptions_Config_BGMColor, settings.mbgcolor);
	DL_Init_ColorPicker(DAB_CBoxOptions_Config_BordColor, settings.bordcolor);
	DL_Init_ColorPicker(DAB_CBoxOptions_Config_MBordColor, settings.mbordcolor);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_FrameStrata, settings.frameStrata);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_JustifyH, settings.justifyH);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_JustifyV, settings.justifyV);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_AnchorFrame, settings.Anchor.frame);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_AnchorPoint, settings.Anchor.point);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_AnchorTo, settings.Anchor.to);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_TextAnchorPoint, settings.TextAnchor.point);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_TextAnchorTo, settings.TextAnchor.to);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_Font, settings.font);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_BGTexture, settings.bgtexture);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_TextureTop, settings.b1texture);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_TextureBottom, settings.b2texture);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_TextureLeft, settings.b3texture);
	DL_Init_MenuControl(DAB_CBoxOptions_Config_TextureRight, settings.b4texture);
	DL_Init_Slider(DAB_CBoxOptions_Config_Height, settings.height);
	DL_Init_Slider(DAB_CBoxOptions_Config_Width, settings.width);
	DL_Init_Slider(DAB_CBoxOptions_Config_FontSize, settings.fontsize);
	DL_Init_Slider(DAB_CBoxOptions_Config_Alpha, settings.alpha);
	DL_Init_Slider(DAB_CBoxOptions_Config_MAlpha, settings.malpha);
	DL_Init_Slider(DAB_CBoxOptions_Config_BGAlpha, settings.bgalpha);
	DL_Init_Slider(DAB_CBoxOptions_Config_MBGAlpha, settings.mbgalpha);
	DL_Init_Slider(DAB_CBoxOptions_Config_BordAlpha, settings.bordalpha);
	DL_Init_Slider(DAB_CBoxOptions_Config_MBordAlpha, settings.mbordalpha);

	DL_Init_CheckBox(DAB_CBoxOptions_Control_OnClick, settings.onclick);
	DL_Init_CheckBox(DAB_CBoxOptions_Control_OnMouseover, settings.onmouseover);
	DL_Init_CheckBox(DAB_CBoxOptions_Control_OnRightClick, settings.onrightclick);
	DL_Init_CheckBox(DAB_CBoxOptions_Control_OnMiddleClick, settings.onmiddleclick);
	DL_Init_Slider(DAB_CBoxOptions_Control_Delay, settings.delay);
	DL_Init_MenuControl(DAB_CBoxOptions_Control_Group, settings.group);
	DL_Init_MenuControl(DAB_CBoxOptions_Control_CBGroup, settings.cbgroup);
	DL_Init_MenuControl(DAB_CBoxOptions_Control_RCGroup, settings.rcgroup);
	DL_Init_MenuControl(DAB_CBoxOptions_Control_MCGroup, settings.mcgroup);
	DL_Init_EditBox(DAB_CBoxOptions_Control_HideGroups, settings.hidegroups);
	DL_Init_CheckBox(DAB_CBoxOptions_Control_ChangePage, settings.changePage);
	DL_Init_CheckBox(DAB_CBoxOptions_Control_DisplayPage, settings.displayPage);
	DL_Init_MenuControl(DAB_CBoxOptions_Control_PageControlBar, settings.changePageBar);
	DL_Init_MenuControl(DAB_CBoxOptions_Control_PageControlType, settings.changePageType);
	DAB_CONTROL_PAGES = {};
	for i=1, DAB_Settings[DAB_INDEX].Bar[settings.changePageBar].numBars do
		DAB_CONTROL_PAGES[i] = {text=i, value=i};
	end
	DL_Init_MenuControl(DAB_CBoxOptions_Control_PageControlPage, settings.changePagePage);
	if (settings.changePageType == 3) then
		DAB_CBoxOptions_Control_PageControlPage:Show();
	else
		DAB_CBoxOptions_Control_PageControlPage:Hide();
	end
end

function DAB_Init_FloaterOptions()
	local settings = DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX];
	local text = string.gsub(DAB_TEXT.FloaterOptions, "$n", DAB_OBJECT_SUBINDEX);
	local action = DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].action;
	text = string.gsub(text, "$a", DAB_Get_ActionName(action));
	DAB_Options_Header_Text:SetText(text);
	DAB_FloaterOptions_Config_Preview.action = action;
	DAB_FloaterOptions_Config_Preview_Icon:SetTexture(GetActionTexture(action));
	DAB_FloaterOptions_Config_Preview_Text:SetText(DAB_Get_ActionName(action)..", Action ID: "..action);
	DAB_FloaterOptions_Control_Condition_Setting:SetText("");
	DAB_FloaterOptions_Control_Response_Setting:SetText("");
	DAB_CONDITION_BUFFER = nil;
	DAB_Reset_Parameters("DAB_FloaterOptions_Control");
	DAB_ConditionMenu_Update();

	DL_Init_CheckBox(DAB_FloaterOptions_Config_Hide, settings.hide);
	DL_Init_CheckBox(DAB_FloaterOptions_Config_HideOnClick, settings.hideonclick);
	DL_Init_CheckBox(DAB_FloaterOptions_Config_DisableTooltip, settings.disableTooltip);
	DL_Init_CheckBox(DAB_FloaterOptions_Config_AutoAttack, settings.autoAttack);
	DL_Init_CheckBox(DAB_FloaterOptions_Config_PetAutoAttack, settings.petAutoAttack);
	DL_Init_CheckBox(DAB_FloaterOptions_Config_CooldownCount, settings.cooldownCount);
	DL_Init_CheckBox(DAB_FloaterOptions_Config_HideGlobalCooldown, settings.hideGlobalCD);
	DL_Init_CheckBox(DAB_FloaterOptions_Config_LockButton, settings.buttonLocked);
	DL_Init_Slider(DAB_FloaterOptions_Config_Size, settings.size);
	DL_Init_Slider(DAB_FloaterOptions_Config_Alpha, settings.alpha);
	DL_Init_MenuControl(DAB_FloaterOptions_Config_AnchorFrame, settings.Anchor.frame, 1);
	DL_Init_MenuControl(DAB_FloaterOptions_Config_AnchorPoint, settings.Anchor.point);
	DL_Init_MenuControl(DAB_FloaterOptions_Config_AnchorTo, settings.Anchor.to);
	DL_Init_EditBox(DAB_FloaterOptions_Config_XOffset, settings.Anchor.x);
	DL_Init_EditBox(DAB_FloaterOptions_Config_YOffset, settings.Anchor.y);

	-- Advanced Bar Config
	DL_Init_CheckBox(DAB_FloaterOptions_AdvConfig_ExpandHidden, settings.expandHidden);
	DL_Init_CheckBox(DAB_FloaterOptions_AdvConfig_TrimEdges, settings.trimEdges);
	DL_Init_CheckBox(DAB_FloaterOptions_AdvConfig_ForceTarget, settings.forceTarget);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_CBGroup, settings.cbgroup);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_RightClick, settings.rightClick);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_MiddleClick, settings.middleClick);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_Target, settings.target);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_FrameStrata, settings.frameStrata);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_RangeRecolor, settings.rangerecolor);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_ManaRecolor, settings.manarecolor);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_UnusableRecolor, settings.unusablerecolor);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_ButtonBG, settings.buttonbg);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_Checked, settings.checked);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_Highlight, settings.highlight);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_Equipped, settings.ButtonBorder.etexture);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_Border, settings.ButtonBorder.texture);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_KBFont, settings.Keybinding.font);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_CCFont, settings.Cooldown.font);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_CntFont, settings.Count.font);
	DL_Init_MenuControl(DAB_FloaterOptions_AdvConfig_MNFont, settings.Macro.font);
	DL_Init_Slider(DAB_FloaterOptions_AdvConfig_BorderAlpha, settings.ButtonBorder.alpha);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_RangeColor, settings.rangecolor);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_ManaColor, settings.manacolor);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_UnusableColor, settings.unusablecolor);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_ButtonBGColor, settings.buttonbgcolor);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_CheckedColor, settings.checkedcolor);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_HighlightColor, settings.highlightcolor);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_EquippedColor, settings.ButtonBorder.ecolor);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_BorderColor, settings.ButtonBorder.color);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_KBColor, settings.Keybinding.color);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_CCColor, settings.Cooldown.color);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_CntColor, settings.Count.color);
	DL_Init_ColorPicker(DAB_FloaterOptions_AdvConfig_MNColor, settings.Macro.color);
	DL_Init_EditBox(DAB_FloaterOptions_AdvConfig_KBSize, settings.Keybinding.size);
	DL_Init_EditBox(DAB_FloaterOptions_AdvConfig_CCSize, settings.Cooldown.size);
	DL_Init_EditBox(DAB_FloaterOptions_AdvConfig_CntSize, settings.Count.size);
	DL_Init_EditBox(DAB_FloaterOptions_AdvConfig_MNSize, settings.Macro.size);
	DL_Init_EditBox(DAB_FloaterOptions_AdvConfig_PadLeft, settings.ButtonBorder.leftpadding);
	DL_Init_EditBox(DAB_FloaterOptions_AdvConfig_PadRight, settings.ButtonBorder.rightpadding);
	DL_Init_EditBox(DAB_FloaterOptions_AdvConfig_PadTop, settings.ButtonBorder.toppadding);
	DL_Init_EditBox(DAB_FloaterOptions_AdvConfig_PadBottom, settings.ButtonBorder.bottompadding);
	DL_Init_CheckBox(DAB_FloaterOptions_AdvConfig_KBHide, settings.Keybinding.hide);
	DL_Init_CheckBox(DAB_FloaterOptions_AdvConfig_CCHide, settings.Cooldown.hide);
	DL_Init_CheckBox(DAB_FloaterOptions_AdvConfig_CntHide, settings.Count.hide);
	DL_Init_CheckBox(DAB_FloaterOptions_AdvConfig_MNHide, settings.Macro.hide);
end

function DAB_Init_MainMenuOptions()
	local settings = DAB_Settings[DAB_INDEX].MainMenuBar;
	DL_Init_CheckBox(DAB_MainBarOptions_HideEverything, settings.hideEverything);
	DL_Init_CheckBox(DAB_MainBarOptions_ShowXP, settings.showXP);
	DL_Init_CheckBox(DAB_MainBarOptions_HideXPBorder, settings.hideXPborder);
	DL_Init_CheckBox(DAB_MainBarOptions_ShowLatency, settings.showLatency);
	DL_Init_CheckBox(DAB_MainBarOptions_ShowKeyring, settings.showKeyring);
	DL_Init_ColorPicker(DAB_MainBarOptions_XPColor, settings.xpcolor);
	DL_Init_ColorPicker(DAB_MainBarOptions_XPBorderColor, settings.xpbcolor);
	DL_Init_Slider(DAB_MainBarOptions_XPScale, settings.xpscale);
	DL_Init_Slider(DAB_MainBarOptions_XPAlpha, settings.xpalpha);
	DL_Init_Slider(DAB_MainBarOptions_LatencyScale, settings.latencyscale);
	DL_Init_Slider(DAB_MainBarOptions_KeyringScale, settings.keyringscale);
end

function DAB_Init_MiscOptions()
	DL_Init_MenuControl(DAB_MiscOptions_CooldownFormat, DAB_Settings[DAB_INDEX].CDFormat);
	DL_Init_MenuControl(DAB_MiscOptions_OptionsScale, DAB_Settings[DAB_INDEX].optionsScale);
	DL_Init_MenuControl(DAB_MiscOptions_ForceSelfCast, DAB_Settings[DAB_INDEX].SelfCast);
	DL_Init_MenuControl(DAB_MiscOptions_DragOverride, DAB_Settings[DAB_INDEX].DragLockOverride);
	DL_Init_MenuControl(DAB_MiscOptions_ButtonOverride, DAB_Settings[DAB_INDEX].ButtonLockOverride);
	DL_Init_Slider(DAB_MiscOptions_UpdateSpeed, DAB_Settings[DAB_INDEX].UpdateSpeed);
	DL_Init_CheckBox(DAB_MiscOptions_AutoConfigure, DAB_Settings[DAB_INDEX].AutoConfigureKB);
	DL_Init_CheckBox(DAB_MiscOptions_ModifyTooltip, DAB_Settings[DAB_INDEX].ModifyTooltip);
	DAB_MiscOptions_CurrentProfile:SetText(DAB_TEXT.CurrentProfile.." |cFFFFFFFF"..DAB_INDEX);
end

function DAB_Init_OtherBarOptions()
	local settings = DAB_Settings[DAB_INDEX].OtherBar[DAB_OBJECT_SUBINDEX];
	if (DAB_OBJECT_SUBINDEX == 11) then
		DAB_Options_Header_Text:SetText(string.upper(DAB_TEXT.PetBar));
	elseif (DAB_OBJECT_SUBINDEX == 12) then
		DAB_Options_Header_Text:SetText(string.upper(DAB_TEXT.ShapeshiftBar));
	elseif (DAB_OBJECT_SUBINDEX == 13) then
		DAB_Options_Header_Text:SetText(string.upper(DAB_TEXT.BagBar));
	elseif (DAB_OBJECT_SUBINDEX == 14) then
		DAB_Options_Header_Text:SetText(string.upper(DAB_TEXT.MenuBar));
	end
	if (DAB_OBJECT_SUBINDEX < 13) then
		DAB_OtherBarOptions_CooldownCount:Show();
		DAB_OtherBarOptions_HideGlobal:Show();
		DAB_OtherBarOptions_CCColor:Show();
		DAB_OtherBarOptions_CCSize:Show();
		DAB_OtherBarOptions_CCFont:Show();
	else
		DAB_OtherBarOptions_CooldownCount:Hide();
		DAB_OtherBarOptions_HideGlobal:Hide();
		DAB_OtherBarOptions_CCColor:Hide();
		DAB_OtherBarOptions_CCSize:Hide();
		DAB_OtherBarOptions_CCFont:Hide();
	end

	DL_Init_CheckBox(DAB_OtherBarOptions_Hide, settings.hide);
	DL_Init_CheckBox(DAB_OtherBarOptions_Mouseover, settings.mouseover);
	DL_Init_EditBox(DAB_OtherBarOptions_XOffset, settings.Anchor.x);
	DL_Init_EditBox(DAB_OtherBarOptions_YOffset, settings.Anchor.y);
	DL_Init_EditBox(DAB_OtherBarOptions_TileSize, settings.Background.tileSize);
	DL_Init_EditBox(DAB_OtherBarOptions_EdgeSize, settings.Background.edgeSize);
	DL_Init_EditBox(DAB_OtherBarOptions_InsetLeft, settings.Background.left);
	DL_Init_EditBox(DAB_OtherBarOptions_InsetRight, settings.Background.right);
	DL_Init_EditBox(DAB_OtherBarOptions_InsetTop, settings.Background.top);
	DL_Init_EditBox(DAB_OtherBarOptions_InsetBottom, settings.Background.bottom);
	DL_Init_EditBox(DAB_OtherBarOptions_PadLeft, settings.Background.leftpadding);
	DL_Init_EditBox(DAB_OtherBarOptions_PadRight, settings.Background.rightpadding);
	DL_Init_EditBox(DAB_OtherBarOptions_PadTop, settings.Background.toppadding);
	DL_Init_EditBox(DAB_OtherBarOptions_PadBottom, settings.Background.bottompadding);
	DL_Init_Slider(DAB_OtherBarOptions_BGAlpha, settings.Background.alpha);
	DL_Init_Slider(DAB_OtherBarOptions_BorderAlpha, settings.Background.balpha);
	DL_Init_Slider(DAB_OtherBarOptions_VSpacing, settings.vspacing);
	DL_Init_Slider(DAB_OtherBarOptions_HSpacing, settings.hspacing);
	DL_Init_Slider(DAB_OtherBarOptions_Scale, settings.scale);
	DL_Init_Slider(DAB_OtherBarOptions_Alpha, settings.alpha);
	DL_Init_CheckBox(DAB_OtherBarOptions_TileOpt, settings.Background.tile);
	DL_Init_CheckBox(DAB_OtherBarOptions_HideBackdrop, settings.Background.hide);
	DL_Init_MenuControl(DAB_OtherBarOptions_BGTexture, settings.Background.texture, 1);
	DL_Init_MenuControl(DAB_OtherBarOptions_BorderTexture, settings.Background.btexture, 1);
	DL_Init_ColorPicker(DAB_OtherBarOptions_BGColor, settings.Background.color);
	DL_Init_ColorPicker(DAB_OtherBarOptions_BorderColor, settings.Background.bcolor);
	DL_Init_MenuControl(DAB_OtherBarOptions_AnchorFrame, settings.Anchor.frame, 1);
	DL_Init_MenuControl(DAB_OtherBarOptions_AnchorPoint, settings.Anchor.point);
	DL_Init_MenuControl(DAB_OtherBarOptions_AnchorTo, settings.Anchor.to);
	DL_Init_MenuControl(DAB_OtherBarOptions_FrameStrata, settings.frameStrata);
	DL_Init_MenuControl(DAB_OtherBarOptions_Layout, settings.layout);
	DL_Init_MenuControl(DAB_OtherBarOptions_CBGroup, settings.cbgroup);
	if (DAB_OBJECT_SUBINDEX < 13) then
		DL_Init_CheckBox(DAB_OtherBarOptions_CooldownCount, settings.cooldownCount);
		DL_Init_CheckBox(DAB_OtherBarOptions_HideGlobal, settings.hideGlobalCD);
		DL_Init_ColorPicker(DAB_OtherBarOptions_CCColor, settings.Cooldown.color);
		DL_Init_EditBox(DAB_OtherBarOptions_CCSize, settings.Cooldown.size);
		DL_Init_MenuControl(DAB_OtherBarOptions_CCFont, settings.Cooldown.font);
	end
end
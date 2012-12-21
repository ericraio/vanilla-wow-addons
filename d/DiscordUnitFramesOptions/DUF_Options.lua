function DUF_CheckButton_OnClick()
	DUF_Update_Setting(this:GetChecked(), this.index, this.subindex);
	DUF_Run_Functions();
end

function DUF_ColorPicker_OnClick()
	local basecolor = DUF_Options_GetSetting(this.index);
	local color = {};
	color.r = basecolor.r;
	color.g = basecolor.g;
	color.b = basecolor.b;
	ColorPickerFrame.previousValues = color;
	ColorPickerFrame.cancelFunc = DUF_ColorPicker_ColorCancelled;
	ColorPickerFrame.opacityFunc = DUF_ColorPicker_ColorChanged;
	ColorPickerFrame.func = DUF_ColorPicker_ColorChanged;
	ColorPickerFrame.initfunc = this:GetParent().initFunc;
	ColorPickerFrame.colorBox = this:GetName();
	ColorPickerFrame.index = this.index;
	ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
	ColorPickerFrame:ClearAllPoints();
	if (DUF_Options:GetRight() < UIParent:GetWidth() / 2) then
		ColorPickerFrame:SetPoint("LEFT", "DUF_Options", "RIGHT", 10, 0);
	else
		ColorPickerFrame:SetPoint("RIGHT", "DUF_Options", "LEFT", -10, 0);
	end
	ColorPickerFrame:Show();
end

function DUF_ColorPicker_ColorCancelled()
	local color = ColorPickerFrame.previousValues;
	DUF_Update_Setting(color, ColorPickerFrame.index, ColorPickerFrame.subindex);
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
	if (ColorPickerFrame.initfunc) then
		for _,unit in DUF_INIT_FRAMES do
			ColorPickerFrame.initfunc(unit, DUF_ELEMENT_SUBINDEX);
		end
	end
end

function DUF_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local color = { r=r, g=g, b=b };
	DUF_Update_Setting(color, ColorPickerFrame.index, ColorPickerFrame.subindex);
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
	if (ColorPickerFrame.initfunc) then
		for _,unit in DUF_INIT_FRAMES do
			ColorPickerFrame.initfunc(unit, DUF_ELEMENT_SUBINDEX);
		end
	end
end

function DUF_CopyFrame(source)
	if (not source) then return; end
	if (source == DUF_FRAME_INDEX) then return; end
	local oldXPBar, oldHonorBar, oldHappiness, oldCombo, oldElite;
	if (DUF_FRAME_INDEX == "player" or DUF_FRAME_INDEX == "pet") then
		oldXPBar = {};
		DL_Copy_Table(DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].StatusBar[3], oldXPBar);
	end
	if (DUF_FRAME_INDEX == "player") then
		oldHonorBar = {};
		DL_Copy_Table(DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].StatusBar[6], oldHonorBar);
	end
	if (DUF_FRAME_INDEX == "pet") then
		oldHappiness = {};
		DL_Copy_Table(DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].HappinessIcon, oldHappiness);
	end
	if (DUF_FRAME_INDEX == "target") then
		oldCombo = {};
		DL_Copy_Table(DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].ComboPoints, oldCombo);
		oldElite = {};
		DL_Copy_Table(DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].EliteTexture, oldElite);
	end
	local oldx = {};
	local oldy = {};
	DL_Copy_Table(DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].xos, oldx);
	DL_Copy_Table(DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].yos, oldy);
	DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX] = {};
	DL_Copy_Table(DUF_Settings[DUF_INDEX][source], DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX]);
	if (DUF_FRAME_INDEX ~= "player" and DUF_FRAME_INDEX ~= "pet") then
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].StatusBar[3] = nil;
	else
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].StatusBar[3] = {};
		DL_Copy_Table(oldXPBar, DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].StatusBar[3]);
	end
	if (DUF_FRAME_INDEX ~= "player") then
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Buffs.durationheight = 6;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Buffs.durationcolor = {r=1, g=1, b=1};
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Buffs.durationfont = "DUF_Font1.ttf";
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Buffs.durationalpha = 1;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Buffs.durationx = 0;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Buffs.durationy = -5;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Debuffs.durationheight = 6;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Debuffs.durationcolor = {r=1, g=1, b=1};
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Debuffs.durationfont = "DUF_Font1.ttf";
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Debuffs.durationalpha = 1;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Debuffs.durationx = 0;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].Debuffs.durationy = -5;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].StatusBar[6] = nil;
	else
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].StatusBar[6] = {};
		DL_Copy_Table(oldHonorBar, DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].StatusBar[6]);
		DUF_Settings[DUF_INDEX].player.Buffs.durationheight = 6;
		DUF_Settings[DUF_INDEX].player.Buffs.durationcolor = {r=1, g=1, b=1};
		DUF_Settings[DUF_INDEX].player.Buffs.durationfont = "DUF_Font1.ttf";
		DUF_Settings[DUF_INDEX].player.Buffs.durationalpha = 1;
		DUF_Settings[DUF_INDEX].player.Buffs.durationx = 0;
		DUF_Settings[DUF_INDEX].player.Buffs.durationy = -5;
		DUF_Settings[DUF_INDEX].player.Debuffs.durationheight = 6;
		DUF_Settings[DUF_INDEX].player.Debuffs.durationcolor = {r=1, g=1, b=1};
		DUF_Settings[DUF_INDEX].player.Debuffs.durationfont = "DUF_Font1.ttf";
		DUF_Settings[DUF_INDEX].player.Debuffs.durationalpha = 1;
		DUF_Settings[DUF_INDEX].player.Debuffs.durationx = 0;
		DUF_Settings[DUF_INDEX].player.Debuffs.durationy = -5;
	end
	if (DUF_FRAME_INDEX ~= "pet") then
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].HappinessIcon = nil;
	else
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].HappinessIcon = {};
		DL_Copy_Table(oldHappiness, DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].HappinessIcon);
	end
	if (DUF_FRAME_INDEX ~= "target") then
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].ComboPoints = nil;
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].EliteTexture = nil;
	else
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].ComboPoints = {};
		DL_Copy_Table(oldCombo, DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].ComboPoints);
		DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].EliteTexture = {};
		DL_Copy_Table(oldElite, DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].EliteTexture);
	end
	DUF_Initialize_AllFrames();
	DUF_Init_BaseOptions();
end

function DUF_EditBox_Update()
	local value = this:GetText();
	if (not value) then value = ""; end
	if (this.number) then
		value = this:GetNumber();
		if (not value) then
			value = 0;
			this:SetText("0");
		end
	end
	this:ClearFocus();
	if (this.index == "FRAMELOC") then
		DUF_EditBox_UpdateFrameLoc(this.subindex, value)
	else
		DUF_Update_Setting(value, this.index, this.subindex);
		DUF_Run_Functions();
		if (DUF_FRAME_INDEX) then
			for i = 1,10 do
				if (DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].TextBox[i].label) then
					getglobal("DUF_Options_TextBox"..i):SetText("["..i.."] "..DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].TextBox[i].label);
				else
					getglobal("DUF_Options_TextBox"..i):SetText(DUF_TEXT["TextBox"..i]);
				end
			end
		end
	end
end

function DUF_EditBox_UpdateFrameLoc(locIndex, value)
	local index = tonumber(DUF_FrameOptions_FrameChooser_Setting:GetText())
	DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][locIndex][index] = value
	if (string.find(DUF_FRAME_INDEX, "party")) then
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX..index)
	else
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX)
	end
end

function DUF_Init_BaseOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_EditBox(DUF_ElementOptions_Base_XOffset, settings.xoffset);
	DL_Init_EditBox(DUF_ElementOptions_Base_YOffset, settings.yoffset);
	DL_Init_EditBox(DUF_ElementOptions_Base_FrameLevel, settings.framelevel);
	DL_Init_EditBox(DUF_ElementOptions_Base_BGTexture, settings.bgtexture);
	DL_Init_MenuControl(DUF_ElementOptions_Base_FrameStrata, settings.framestrata);
	DL_Init_EditBox(DUF_ElementOptions_Base_CustomTooltip, settings.customtooltip);
	DL_Init_CheckBox(DUF_ElementOptions_Base_DisableMouse, settings.disablemouse);
	DL_Init_CheckBox(DUF_ElementOptions_Base_UseCustomTooltip, settings.usecustomtooltip);
	DL_Init_CheckBox(DUF_ElementOptions_Base_DisableTooltip, settings.disabletooltip);
	DL_Init_CheckBox(DUF_ElementOptions_Base_Flash, settings.flashlowhealth);
	DL_Init_MenuControl(DUF_ElementOptions_Base_MainColorContext, settings.context);
	DL_Init_MenuControl(DUF_ElementOptions_Base_BackgroundColorContext, settings.bgcontext);
	DL_Init_MenuControl(DUF_ElementOptions_Base_BorderColorContext, settings.bordercontext);
	DL_Init_MenuControl(DUF_ElementOptions_Base_LeftClick, settings.leftclick);
	DL_Init_MenuControl(DUF_ElementOptions_Base_RightClick, settings.rightclick);
	DL_Init_MenuControl(DUF_ElementOptions_Base_MiddleClick, settings.middleclick);
	DL_Init_MenuControl(DUF_ElementOptions_Base_AttachFrame, settings.attach);
	DL_Init_MenuControl(DUF_ElementOptions_Base_AttachPoint, settings.attachpoint);
	DL_Init_MenuControl(DUF_ElementOptions_Base_AttachTo, settings.attachto);
	DL_Init_CheckBox(DUF_ElementOptions_Base_Hide, settings.hide);
	DL_Init_CheckBox(DUF_ElementOptions_Base_Mouseover, settings.mouseover);
	DL_Init_CheckBox(DUF_ElementOptions_Base_HideOnMouseover, settings.hidemouseover);
	DL_Init_CheckBox(DUF_ElementOptions_Base_UseMouseoverColor, settings.usemouseovercolor);
	DL_Init_ColorPicker(DUF_ElementOptions_Base_MouseoverColor, settings.mouseovercolor);
	DL_Init_MenuControl(DUF_ElementOptions_Base_MouseoverGroup, settings.mouseovergroup);
	DL_Init_Slider(DUF_ElementOptions_Base_Alpha, settings.alpha);
	DL_Init_CheckBox(DUF_ElementOptions_Base_HideBG, settings.hidebg);
	DL_Init_ColorPicker(DUF_ElementOptions_Base_BGColor, settings.bgcolor);
	DL_Init_Slider(DUF_ElementOptions_Base_BGAlpha, settings.bgalpha);
	DL_Init_Slider(DUF_ElementOptions_Base_BGPadding, settings.bgpadding);
	DL_Init_ColorPicker(DUF_ElementOptions_Base_BorderColor, settings.bordercolor);
	DL_Init_MenuControl(DUF_ElementOptions_Base_BorderStyle, settings.backgroundstyle);
	DL_Init_Slider(DUF_ElementOptions_Base_BorderAlpha, settings.borderalpha);
end

function DUF_Init_BuffOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_BuffOptions_Size, settings.size);
	DL_Init_Slider(DUF_BuffOptions_HSpacing, settings.hspacing);
	DL_Init_Slider(DUF_BuffOptions_VSpacing, settings.vspacing);
	DL_Init_Slider(DUF_BuffOptions_Shown, settings.shown);
	DL_Init_CheckBox(DUF_BuffOptions_TwoRows, settings.tworows);
	DL_Init_CheckBox(DUF_BuffOptions_DurationFormat, settings.altformat);
	DL_Init_CheckBox(DUF_BuffOptions_Vertical, settings.vertical);
	DL_Init_CheckBox(DUF_BuffOptions_ReverseFill, settings.reverse);
	if (DUF_FRAME_INDEX == "player") then
		DUF_BuffOptions_ShowDuration:Show();
		DUF_BuffOptions_DurationFont:Show();
		DUF_BuffOptions_DurationXOffset:Show();
		DUF_BuffOptions_DurationYOffset:Show();
		DUF_BuffOptions_DurationColor:Show();
		DUF_BuffOptions_DurationHeight:Show();
		DUF_BuffOptions_DurationAlpha:Show();
		DUF_BuffOptions_DurationFormat:Show();
		DL_Init_CheckBox(DUF_BuffOptions_ShowDuration, settings.showduration);
		DL_Init_CheckBox(DUF_BuffOptions_DurationFormat, settings.altformat);
		DL_Init_Slider(DUF_BuffOptions_DurationXOffset, settings.durationx);
		DL_Init_Slider(DUF_BuffOptions_DurationYOffset, settings.durationy);
		DL_Init_Slider(DUF_BuffOptions_DurationHeight, settings.durationheight);
		DL_Init_Slider(DUF_BuffOptions_DurationAlpha, settings.durationalpha);
		DL_Init_EditBox(DUF_BuffOptions_DurationFont, settings.durationfont);
		DL_Init_ColorPicker(DUF_BuffOptions_DurationColor, settings.durationcolor);
	else
		DUF_BuffOptions_ShowDuration:Hide();
		DUF_BuffOptions_DurationFont:Hide();
		DUF_BuffOptions_DurationXOffset:Hide();
		DUF_BuffOptions_DurationYOffset:Hide();
		DUF_BuffOptions_DurationColor:Hide();
		DUF_BuffOptions_DurationHeight:Hide();
		DUF_BuffOptions_DurationAlpha:Hide();
		DUF_BuffOptions_DurationFormat:Hide();
	end
end

function DUF_Init_ClassIconOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_ClassIconOptions_Size, settings.size);
	DL_Init_CheckBox(DUF_ClassIconOptions_UseRaceTexture, settings.userace);
end

function DUF_Init_ContextColors()
	for i = 1,6 do
		DL_Init_ColorPicker(getglobal("DUF_ColorContextOptions_Difficulty"..i), DUF_Settings[DUF_INDEX]["lvlcolor"..i]);
		DL_Init_ColorPicker(getglobal("DUF_ColorContextOptions_Reaction"..i), DUF_Settings[DUF_INDEX]["reactioncolor"..i]);
	end
	DL_Init_ColorPicker(DUF_ColorContextOptions_Health1, DUF_Settings[DUF_INDEX].healthcolor1);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Health2, DUF_Settings[DUF_INDEX].healthcolor2);
	DL_Init_EditBox(DUF_ColorContextOptions_HealthThreshold1, DUF_Settings[DUF_INDEX].healththreshold1);
	DL_Init_EditBox(DUF_ColorContextOptions_HealthThreshold2, DUF_Settings[DUF_INDEX].healththreshold2);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Mana1, DUF_Settings[DUF_INDEX].manacolor1);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Mana2, DUF_Settings[DUF_INDEX].manacolor2);
	DL_Init_EditBox(DUF_ColorContextOptions_ManaThreshold1, DUF_Settings[DUF_INDEX].manathreshold1);
	DL_Init_EditBox(DUF_ColorContextOptions_ManaThreshold2, DUF_Settings[DUF_INDEX].manathreshold2);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Druid, DUF_Settings[DUF_INDEX].classcolorDruid);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Hunter, DUF_Settings[DUF_INDEX].classcolorHunter);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Mage, DUF_Settings[DUF_INDEX].classcolorMage);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Paladin, DUF_Settings[DUF_INDEX].classcolorPaladin);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Priest, DUF_Settings[DUF_INDEX].classcolorPriest);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Rogue, DUF_Settings[DUF_INDEX].classcolorRogue);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Shaman, DUF_Settings[DUF_INDEX].classcolorShaman);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Warlock, DUF_Settings[DUF_INDEX].classcolorWarlock);
	DL_Init_ColorPicker(DUF_ColorContextOptions_Warrior, DUF_Settings[DUF_INDEX].classcolorWarrior);
	DL_Init_CheckBox(DUF_ColorContextOptions_UseFor0, DUF_Settings[DUF_INDEX].usefor0);
	DL_Init_CheckBox(DUF_ColorContextOptions_UseFor1, DUF_Settings[DUF_INDEX].usefor1);
	DL_Init_CheckBox(DUF_ColorContextOptions_UseFor2, DUF_Settings[DUF_INDEX].usefor2);
	DL_Init_CheckBox(DUF_ColorContextOptions_UseFor3, DUF_Settings[DUF_INDEX].usefor3);
end

function DUF_Init_ComboPointsOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_ComboPointsOptions_Size, settings.size);
	DL_Init_Slider(DUF_ComboPointsOptions_Spacing, settings.spacing);
	DL_Init_ColorPicker(DUF_ComboPointsOptions_Color, settings.color);
	DL_Init_CheckBox(DUF_ComboPointsOptions_Vertical, settings.vertical);
	DL_Init_EditBox(DUF_ComboPointsOptions_CustomTexture, settings.customtexture);
end

function DUF_Init_DebuffOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_DebuffOptions_Size, settings.size);
	DL_Init_Slider(DUF_DebuffOptions_HSpacing, settings.hspacing);
	DL_Init_Slider(DUF_DebuffOptions_VSpacing, settings.vspacing);
	DL_Init_Slider(DUF_DebuffOptions_Shown, settings.shown);
	DL_Init_CheckBox(DUF_DebuffOptions_TwoRows, settings.tworows);
	DL_Init_CheckBox(DUF_DebuffOptions_Vertical, settings.vertical);
	DL_Init_CheckBox(DUF_DebuffOptions_Flash, settings.flash);
	DL_Init_CheckBox(DUF_DebuffOptions_ReverseFill, settings.reverse);
	DL_Init_CheckBox(DUF_DebuffOptions_DurationFormat, settings.altformat);
	if (DUF_FRAME_INDEX == "player") then
		DUF_DebuffOptions_ShowDuration:Show();
		DUF_DebuffOptions_DurationFont:Show();
		DUF_DebuffOptions_DurationXOffset:Show();
		DUF_DebuffOptions_DurationYOffset:Show();
		DUF_DebuffOptions_DurationColor:Show();
		DUF_DebuffOptions_DurationHeight:Show();
		DUF_DebuffOptions_DurationAlpha:Show();
		DUF_DebuffOptions_DurationFormat:Show();
		DL_Init_CheckBox(DUF_DebuffOptions_ShowDuration, settings.showduration);
		DL_Init_CheckBox(DUF_DebuffOptions_DurationFormat, settings.altformat);
		DL_Init_Slider(DUF_DebuffOptions_DurationXOffset, settings.durationx);
		DL_Init_Slider(DUF_DebuffOptions_DurationYOffset, settings.durationy);
		DL_Init_Slider(DUF_DebuffOptions_DurationHeight, settings.durationheight);
		DL_Init_Slider(DUF_DebuffOptions_DurationAlpha, settings.durationalpha);
		DL_Init_EditBox(DUF_DebuffOptions_DurationFont, settings.durationfont);
		DL_Init_ColorPicker(DUF_DebuffOptions_DurationColor, settings.durationcolor);
	else
		DUF_DebuffOptions_ShowDuration:Hide();
		DUF_DebuffOptions_DurationFont:Hide();
		DUF_DebuffOptions_DurationXOffset:Hide();
		DUF_DebuffOptions_DurationYOffset:Hide();
		DUF_DebuffOptions_DurationColor:Hide();
		DUF_DebuffOptions_DurationHeight:Hide();
		DUF_DebuffOptions_DurationAlpha:Hide();
		DUF_DebuffOptions_DurationFormat:Hide();
	end
end

function DUF_Init_Element(unit)
	if (DUF_ELEMENT_INDEX == "Buffs") then
		DUF_Initialize_Buffs(unit);
	elseif (DUF_ELEMENT_INDEX == "ClassIcon") then
		DUF_Initialize_ClassIcon(unit);
	elseif (DUF_ELEMENT_INDEX == "ComboPoints") then
		DUF_Initialize_ComboPoints();
	elseif (DUF_ELEMENT_INDEX == "Debuffs") then
		DUF_Initialize_Debuffs(unit);
	elseif (DUF_ELEMENT_INDEX == "HappinessIcon") then
		DUF_Initialize_HappinessIcon();
	elseif (DUF_ELEMENT_INDEX == "LeaderIcon") then
		DUF_Initialize_LeaderIcon(unit);
	elseif (DUF_ELEMENT_INDEX == "LootIcon") then
		DUF_Initialize_LootIcon(unit);
	elseif (DUF_ELEMENT_INDEX == "Portrait") then
		DUF_Initialize_Portrait(unit);
	elseif (DUF_ELEMENT_INDEX == "PVPIcon") then
		DUF_Initialize_PVPIcon(unit);
	elseif (DUF_ELEMENT_INDEX == "RaceIcon") then
		DUF_Initialize_RaceIcon(unit);
	elseif (DUF_ELEMENT_INDEX == "RankIcon") then
		DUF_Initialize_RankIcon(unit);
	elseif (DUF_ELEMENT_INDEX == "StatusBar") then
		DUF_Initialize_StatusBar(unit, DUF_ELEMENT_SUBINDEX);
	elseif (DUF_ELEMENT_INDEX == "StatusIcon") then
		DUF_Initialize_StatusIcon(unit);
	elseif (DUF_ELEMENT_INDEX == "TextBox") then
		DUF_Initialize_TextBox(unit, DUF_ELEMENT_SUBINDEX);
	elseif (DUF_ELEMENT_INDEX == "EliteTexture") then
		DUF_Initialize_EliteTexture();
	end
end

function DUF_Init_EliteTextureOptions()
	local settings = DUF_Settings[DUF_INDEX].target.EliteTexture;
	DL_Init_Slider(DUF_EliteTextureOptions_Size, settings.size);
	DL_Init_CheckBox(DUF_EliteTextureOptions_FacesLeft, settings.faceleft);
	DL_Init_EditBox(DUF_EliteTextureOptions_CustomEliteTexture, settings.elitetexture);
	DL_Init_EditBox(DUF_EliteTextureOptions_CustomRareTexture, settings.raretexture);
end

function DUF_Init_FrameOptions()
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX];
	DL_Init_MenuControl(DUF_FrameOptions_MainColorContext, settings.context);
	DL_Init_MenuControl(DUF_FrameOptions_FrameChooser, 1);
	DL_Init_MenuControl(DUF_FrameOptions_BackgroundColorContext, settings.bgcontext);
	DL_Init_MenuControl(DUF_FrameOptions_BorderColorContext, settings.bordercontext);
	DL_Init_MenuControl(DUF_FrameOptions_LeftClick, settings.leftclick);
	DL_Init_MenuControl(DUF_FrameOptions_RightClick, settings.rightclick);
	DL_Init_MenuControl(DUF_FrameOptions_MiddleClick, settings.middleclick);
	DL_Init_CheckBox(DUF_FrameOptions_Hide, settings.hide);
	DL_Init_CheckBox(DUF_FrameOptions_DisableMouse, settings.disablemouse);
	DL_Init_CheckBox(DUF_FrameOptions_Flash, settings.flash);
	DL_Init_CheckBox(DUF_FrameOptions_ShowDefault, settings.showDefault);
	DL_Init_ColorPicker(DUF_FrameOptions_MouseoverColor, settings.mouseovercolor);
	DL_Init_CheckBox(DUF_FrameOptions_UseMouseoverColor, settings.usemouseovercolor);
	DL_Init_MenuControl(DUF_FrameOptions_MouseoverGroup, settings.mouseovergroup);
	DL_Init_Slider(DUF_FrameOptions_Height, settings.height);
	DL_Init_Slider(DUF_FrameOptions_Width, settings.width);
	DL_Init_Slider(DUF_FrameOptions_Scale, settings.scale);
	DL_Init_Slider(DUF_FrameOptions_Alpha, settings.alpha);
	DL_Init_CheckBox(DUF_FrameOptions_HideBG, settings.hidebg);
	DL_Init_ColorPicker(DUF_FrameOptions_BGColor, settings.bgcolor);
	DL_Init_Slider(DUF_FrameOptions_BGAlpha, settings.bgalpha);
	DL_Init_Slider(DUF_FrameOptions_BGPadding, settings.bgpadding);
	DL_Init_ColorPicker(DUF_FrameOptions_BorderColor, settings.bordercolor);
	DL_Init_MenuControl(DUF_FrameOptions_BorderStyle, settings.backgroundstyle);
	DL_Init_Slider(DUF_FrameOptions_BorderAlpha, settings.borderalpha);
	DL_Init_CheckBox(DUF_FrameOptions_DisableTooltip, settings.disabletooltip);
	DL_Init_CheckBox(DUF_FrameOptions_UseCustomTooltip, settings.usecustomtooltip);
	DL_Init_EditBox(DUF_FrameOptions_CustomTooltip, settings.customtooltip);
	DL_Init_EditBox(DUF_FrameOptions_XOffset, settings.xos[1]);
	DL_Init_EditBox(DUF_FrameOptions_YOffset, settings.yos[1]);
	DL_Init_CheckBox(DUF_FrameOptions_Connect, settings.connect);
	DL_Init_MenuControl(DUF_FrameOptions_ConnectMethod, settings.connectmethod);
	DL_Init_Slider(DUF_FrameOptions_Spacing, settings.spacing);
end

function DUF_Init_HealthBarOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_HealthBarOptions_Height, settings.height);
	DL_Init_Slider(DUF_HealthBarOptions_Width, settings.width);
	DL_Init_ColorPicker(DUF_HealthBarOptions_Color, settings.color);
	DL_Init_ColorPicker(DUF_HealthBarOptions_SecondaryColor, settings.color2);
	DL_Init_CheckBox(DUF_HealthBarOptions_Fill, settings.fill);
	DL_Init_CheckBox(DUF_HealthBarOptions_Fade, settings.fade);
	DL_Init_CheckBox(DUF_HealthBarOptions_ResizeMax, settings.resizemax);
	DL_Init_CheckBox(DUF_HealthBarOptions_InCombat, settings.incombat);
	DL_Init_CheckBox(DUF_HealthBarOptions_HealthUpdating, settings.healthupdating);
	DL_Init_CheckBox(DUF_HealthBarOptions_ManaUpdating, settings.manaupdating);
	DL_Init_EditBox(DUF_HealthBarOptions_CustomTexture, settings.customtexture);
	DL_Init_EditBox(DUF_HealthBarOptions_CustomTexture2, settings.customtexture2);
	DL_Init_MenuControl(DUF_HealthBarOptions_Direction, settings.direction);
end

function DUF_Init_IconOptions()
	local settings = DUF_Options_GetAllSettings();
	if (DUF_ELEMENT_INDEX == "RaceIcon" or DUF_ELEMENT_INDEX == "RankIcon") then
		DUF_IconOptions_TargetIcon:Show()
	else
		DUF_IconOptions_TargetIcon:Hide()
	end
	DL_Init_Slider(DUF_IconOptions_Size, settings.size);
	DL_Init_CheckBox(DUF_IconOptions_Circle, settings.circle);
	DL_Init_CheckBox(DUF_IconOptions_TargetIcon, settings.targetIcon);
end

function DUF_Init_ManaBarOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_ManaBarOptions_Height, settings.height);
	DL_Init_Slider(DUF_ManaBarOptions_Width, settings.width);
	DL_Init_ColorPicker(DUF_ManaBarOptions_ManaColor, settings.manacolor);
	DL_Init_ColorPicker(DUF_ManaBarOptions_RageColor, settings.ragecolor);
	DL_Init_ColorPicker(DUF_ManaBarOptions_FocusColor, settings.focuscolor);
	DL_Init_ColorPicker(DUF_ManaBarOptions_EnergyColor, settings.energycolor);
	DL_Init_ColorPicker(DUF_ManaBarOptions_SecondaryColor, settings.color2);
	DL_Init_CheckBox(DUF_ManaBarOptions_Fill, settings.fill);
	DL_Init_CheckBox(DUF_ManaBarOptions_Fade, settings.fade);
	DL_Init_CheckBox(DUF_ManaBarOptions_InCombat, settings.incombat);
	DL_Init_CheckBox(DUF_ManaBarOptions_HealthUpdating, settings.healthupdating);
	DL_Init_CheckBox(DUF_ManaBarOptions_ManaUpdating, settings.manaupdating);
	DL_Init_CheckBox(DUF_ManaBarOptions_HideIfNoMana, settings.hideifnomana);
	DL_Init_CheckBox(DUF_ManaBarOptions_ResizeMax, settings.resizemax);
	DL_Init_EditBox(DUF_ManaBarOptions_CustomTexture, settings.customtexture);
	DL_Init_EditBox(DUF_ManaBarOptions_CustomTexture2, settings.customtexture2);
	DL_Init_MenuControl(DUF_ManaBarOptions_Direction, settings.direction);
end

function DUF_Init_MiscOptions()
	DL_Init_CheckBox(DUF_MiscOptions_HidePartyInRaid, DUF_Settings[DUF_INDEX].hidepartyinraid);
	DL_Init_CheckBox(DUF_MiscOptions_HideTargetTarget, DUF_Settings[DUF_INDEX].hidetargettarget);
	DL_Init_CheckBox(DUF_MiscOptions_HideBuffFrame, DUF_Settings[DUF_INDEX].hidebuffframe);
	DL_Init_Slider(DUF_MiscOptions_UpdateSpeed, DUF_Settings[DUF_INDEX].updatespeedbase);
	DL_Init_EditBox(DUF_MiscOptions_LowHealthThreshold, DUF_Settings[DUF_INDEX].flashthreshold);
	DL_Init_MenuControl(DUF_MiscOptions_OptionsScale, DUF_Settings[DUF_INDEX].optionscale);
end

function DUF_Init_PortraitOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_PortraitOptions_Size, settings.size);
	DL_Init_CheckBox(DUF_PortraitOptions_UseClassTexture, settings.useclass);
	DL_Init_CheckBox(DUF_PortraitOptions_ShowBorder, settings.showborder);
	DL_Init_ColorPicker(DUF_PortraitOptions_BorderColor, settings.bordcolor);
end

function DUF_Init_TextBoxOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_TextBoxOptions_Height, settings.height);
	DL_Init_Slider(DUF_TextBoxOptions_Width, settings.width);
	DL_Init_EditBox(DUF_TextBoxOptions_Text, settings.text);
	DL_Init_EditBox(DUF_TextBoxOptions_Label, settings.label);
	DL_Init_EditBox(DUF_TextBoxOptions_MaxCharacters, settings.maxcharacters);
	DL_Init_MenuControl(DUF_TextBoxOptions_JustifyH, settings.justify);
	DL_Init_MenuControl(DUF_TextBoxOptions_JustifyV, settings.justifyV);
	DL_Init_MenuControl(DUF_TextBoxOptions_TextOutline, settings.outline);
	DL_Init_EditBox(DUF_TextBoxOptions_Font, settings.font);
	DL_Init_ColorPicker(DUF_TextBoxOptions_Color, settings.textcolor);
	DL_Init_Slider(DUF_TextBoxOptions_FontHeight, settings.textheight);
	DL_Init_CheckBox(DUF_TextBoxOptions_HideIfNoMana, settings.hideifnomana);
	DL_Init_CheckBox(DUF_TextBoxOptions_HideIfNoText, settings.hideifnotext);
	DL_Init_CheckBox(DUF_TextBoxOptions_InCombat, settings.incombat);
	DL_Init_CheckBox(DUF_TextBoxOptions_HealthUpdating, settings.healthupdating);
	DL_Init_CheckBox(DUF_TextBoxOptions_ManaUpdating, settings.manaupdating);
	DL_Init_CheckBox(DUF_TextBoxOptions_VerticalText, settings.verttext);
end

function DUF_Init_XPBarOptions()
	local settings = DUF_Options_GetAllSettings();
	DL_Init_Slider(DUF_XPBarOptions_Height, settings.height);
	DL_Init_Slider(DUF_XPBarOptions_Width, settings.width);
	DL_Init_ColorPicker(DUF_XPBarOptions_Color, settings.color);
	DL_Init_ColorPicker(DUF_XPBarOptions_SecondaryColor, settings.color2);
	DL_Init_EditBox(DUF_XPBarOptions_CustomTexture, settings.customtexture);
	DL_Init_EditBox(DUF_XPBarOptions_CustomTexture2, settings.customtexture2);
	DL_Init_MenuControl(DUF_XPBarOptions_Direction, settings.direction);
	DL_Init_CheckBox(DUF_XPBarOptions_Reputation, settings.trackRep);
	if (DUF_FRAME_INDEX == "player") then
		DUF_XPBarOptions_Reputation:Show()
	else
		DUF_XPBarOptions_Reputation:Hide()
	end
end

function DUF_Menu_OnClick()
	getglobal(DUF_DropMenu.controlbox):SetText(getglobal(this:GetName().."_Text"):GetText());
	DUF_DropMenu:Hide();
	if (DUF_DropMenu.index == "attach") then
		if (this.value and DUF_FRAME_DATA[DUF_FRAME_INDEX] and getglobal(DUF_FRAME_DATA[DUF_FRAME_INDEX].frame..this.value)) then
			local otherindex = getglobal(DUF_FRAME_DATA[DUF_FRAME_INDEX].frame..this.value).index;
			local othersubindex = getglobal(DUF_FRAME_DATA[DUF_FRAME_INDEX].frame..this.value).subindex;
			local otherattach;
			if (othersubindex) then
				otherattach = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][otherindex][othersubindex].attach;
			else
				otherattach = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][otherindex].attach;
			end
			otherattach = DUF_FRAME_DATA[DUF_FRAME_INDEX].frame..otherattach;
			local elemext = "_"..DUF_ELEMENT_INDEX;
			if (DUF_ELEMENT_SUBINDEX) then
				if (DUF_ELEMENT_INDEX == "StatusBar") then
					elemext = DUF_STATUSBARS[DUF_ELEMENT_SUBINDEX];
				elseif (DUF_ELEMENT_INDEX == "TextBox") then
					elemext = "_TextBox_"..DUF_ELEMENT_SUBINDEX;
				end
			end
			local element = DUF_FRAME_DATA[DUF_FRAME_INDEX].frame..elemext;
			if (element == otherattach ) then
				DL_Debug("That element is already attached to this element.  Cross-attaching the elements will crash WoW.  Attach option not applied.");
				return;
			end
		end
	end
	if (DUF_DropMenu.index) then
		DUF_Update_Setting(this.value, DUF_DropMenu.index);
	end
	DUF_Run_Functions(DUF_DropMenu.initFunc);
end

function DUF_Nudge_Down(button)
	local yoffset = DUF_Options_GetSetting("yoffset");
	if (button == "RightButton") then
		yoffset = yoffset - 10;
	elseif (this.moving) then
		yoffset = yoffset - 3;
	else
		yoffset = yoffset - 1;
	end
	DUF_ElementOptions_Base_YOffset:SetText(yoffset);
	DUF_Update_Setting(yoffset, "yoffset");
	DUF_Run_Functions();
end

function DUF_Nudge_Left(button)
	local xoffset = DUF_Options_GetSetting("xoffset");
	if (button == "RightButton") then
		xoffset = xoffset - 10;
	elseif (this.moving) then
		xoffset = xoffset - 3;
	else
		xoffset = xoffset - 1;
	end
	DUF_ElementOptions_Base_XOffset:SetText(xoffset);
	DUF_Update_Setting(xoffset, "xoffset");
	DUF_Run_Functions();
end

function DUF_Nudge_OnUpdate(elapsed)
	if (not this.timer) then
		this.timer = .05;
	end
	this.timer = this.timer - elapsed;
	if (this.timer < 0) then
		this.timer = .05;
		if (this.moving) then
			this.func();
		end
	end
end

function DUF_Nudge_Right(button)
	local xoffset = DUF_Options_GetSetting("xoffset");
	if (button == "RightButton") then
		xoffset = xoffset + 10;
	elseif (this.moving) then
		xoffset = xoffset + 3;
	else
		xoffset = xoffset + 1;
	end
	DUF_ElementOptions_Base_XOffset:SetText(xoffset);
	DUF_Update_Setting(xoffset, "xoffset");
	DUF_Run_Functions();
end

function DUF_Nudge_Up(button)
	local yoffset = DUF_Options_GetSetting("yoffset");
	if (button == "RightButton") then
		yoffset = yoffset + 10;
	elseif (this.moving) then
		yoffset = yoffset + 3;
	else
		yoffset = yoffset + 1;
	end
	DUF_ElementOptions_Base_YOffset:SetText(yoffset);
	DUF_Update_Setting(yoffset, "yoffset");
	DUF_Run_Functions();
end

function DUF_UnitFrame_Nudge_Up(button)
	local index = tonumber(DUF_FrameOptions_FrameChooser_Setting:GetText())
	local yoffset = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].yos[index]
	if (button == "RightButton") then
		yoffset = yoffset + 10;
	elseif (this.moving) then
		yoffset = yoffset + 3;
	else
		yoffset = yoffset + 1;
	end
	DUF_FrameOptions_YOffset:SetText(yoffset);
	DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].yos[index] = yoffset
	if (string.find(DUF_FRAME_INDEX, "party")) then
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX..index)
	else
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX)
	end
end

function DUF_UnitFrame_Nudge_Down(button)
	local index = tonumber(DUF_FrameOptions_FrameChooser_Setting:GetText())
	local yoffset = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].yos[index]
	if (button == "RightButton") then
		yoffset = yoffset - 10;
	elseif (this.moving) then
		yoffset = yoffset - 3;
	else
		yoffset = yoffset - 1;
	end
	DUF_FrameOptions_YOffset:SetText(yoffset);
	DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].yos[index] = yoffset
	if (string.find(DUF_FRAME_INDEX, "party")) then
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX..index)
	else
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX)
	end
end

function DUF_UnitFrame_Nudge_Left(button)
	local index = tonumber(DUF_FrameOptions_FrameChooser_Setting:GetText())
	local xoffset = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].xos[index]
	if (button == "RightButton") then
		xoffset = xoffset - 10;
	elseif (this.moving) then
		xoffset = xoffset - 3;
	else
		xoffset = xoffset - 1;
	end
	DUF_FrameOptions_XOffset:SetText(xoffset);
	DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].xos[index] = xoffset
	if (string.find(DUF_FRAME_INDEX, "party")) then
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX..index)
	else
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX)
	end
end

function DUF_UnitFrame_Nudge_Right(button)
	local index = tonumber(DUF_FrameOptions_FrameChooser_Setting:GetText())
	local xoffset = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].xos[index]
	if (button == "RightButton") then
		xoffset = xoffset + 10;
	elseif (this.moving) then
		xoffset = xoffset + 3;
	else
		xoffset = xoffset + 1;
	end
	DUF_FrameOptions_XOffset:SetText(xoffset);
	DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].xos[index] = xoffset
	if (string.find(DUF_FRAME_INDEX, "party")) then
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX..index)
	else
		DUF_Initialize_FrameLoc(DUF_FRAME_INDEX)
	end
end

function DUF_Options_UpdateFrameLoc()
	local index = tonumber(DUF_FrameOptions_FrameChooser_Setting:GetText())
	local yoffset = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].yos[index]
	local xoffset = DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].xos[index]
	DUF_FrameOptions_YOffset:SetText(yoffset)
	DUF_FrameOptions_XOffset:SetText(xoffset)
end

function DUF_Options_DeleteSettings(index)
	if (not index) then
		index = DUF_LOADINDEX;
	end
	if (index == "" or (not index)) then
		return;
	end
	if (index == DUF_INDEX) then
		DL_Error("You cannot delete the profile you're currently using.");
		return;
	end
	if (not DUF_Settings[index]) then
		DL_Feedback(DUF_TEXT.NoSettingsFound);
		return;
	end
	DUF_Settings[index] = nil;
	DUF_Update_SavedSettings();
	DUF_MiscOptions_LoadSettings_Setting:SetText("");
	DL_Feedback(DUF_TEXT.SettingsDeleted);
end

function DUF_Options_FrameLevelMinus()
	local level = DUF_Options_GetSetting("framelevel");
	level = level - 1;
	DUF_Update_Setting(level, "framelevel");
	DL_Init_EditBox(DUF_ElementOptions_Base_FrameLevel, level);
	DUF_Run_Functions(DUF_ElementOptions_Base_FrameLevel.initFunc);
end

function DUF_Options_FrameLevelPlus()
	local level = DUF_Options_GetSetting("framelevel");
	level = level + 1;
	DUF_Update_Setting(level, "framelevel");
	DL_Init_EditBox(DUF_ElementOptions_Base_FrameLevel, level);
	DUF_Run_Functions(DUF_ElementOptions_Base_FrameLevel.initFunc);
end

function DUF_Options_GetAllSettings()
	if (DUF_ELEMENT_SUBINDEX) then
		return DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][DUF_ELEMENT_INDEX][DUF_ELEMENT_SUBINDEX];
	elseif (DUF_ELEMENT_INDEX) then
		return DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][DUF_ELEMENT_INDEX];
	else
		return DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX];
	end
end

function DUF_Options_GetSetting(index)
	if (not DUF_FRAME_INDEX) then
		return DUF_Settings[DUF_INDEX][index];
	end
	if (DUF_ELEMENT_SUBINDEX) then
		return DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][DUF_ELEMENT_INDEX][DUF_ELEMENT_SUBINDEX][index];
	elseif (DUF_ELEMENT_INDEX) then
		return DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][DUF_ELEMENT_INDEX][index];
	else
		return DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][index];
	end
end

function DUF_Options_OnHide()
	DUF_OPTIONS_VISIBLE = nil;
	DUF_Initialize_AllFrames();
	DUF_Main_UpdatePartyMembers();
	DUF_TargetFrame:Hide();
	DUF_TargetOfTargetFrame:Hide();
	if (UnitName("target")) then
		if (not DUF_Settings[DUF_INDEX].target.hide) then
			DUF_TargetFrame:Show();
		end
		if (UnitName("targettarget") and (not DUF_Settings[DUF_INDEX].targettarget.hide)) then
			DUF_TargetOfTargetFrame:Show();
		end
	end
	DUF_PetFrame:Hide();
	if (UnitName("pet") and (not DUF_Settings[DUF_INDEX].pet.hide)) then
		DUF_PetFrame:Show();
	end
	if (DUF_Settings[DUF_INDEX].autolock) then
		if (DUF_FRAMES_UNLOCKED) then
			DUF_Toggle_FramesLock();
		end
		if (DUF_ELEMENTS_UNLOCKED) then
			DUF_Toggle_ElementsLock();
		end
	end
end

function DUF_Options_OnShow()
	if (not DUF_INITIALIZED) then return; end
	DUF_OPTIONS_VISIBLE = true;
	DUF_Initialize_AllFrames();
	for unit, value in DUF_FRAME_DATA do
		if (not DUF_Settings[DUF_INDEX][value.index].hide) then
			getglobal(value.frame):Show();
		end
	end
end

function DUF_Options_OnUpdate()
	if (not DUF_INITIALIZED) then return; end
	if (not this.scale) then
		this.scale = this:GetScale();
	end
	if (this.scale ~= this:GetScale()) then
		DUF_Options:SetScale(DUF_Settings[DUF_INDEX].optionscale);
		this.scale = this:GetScale();
	end
end

function DUF_Options_ResetIndices()
	if (DUF_OLD_ELEM_SUBINDEX) then
		DUF_ELEMENT_SUBINDEX = DUF_OLD_ELEM_SUBINDEX;
		DUF_OLD_ELEM_SUBINDEX = nil;
	end
	if (DUF_OLD_ELEM_INDEX) then
		DUF_ELEMENT_INDEX = DUF_OLD_ELEM_INDEX;
		DUF_OLD_ELEM_INDEX = nil;
	end
	if (DUF_OLD_FRAME_INDEX) then
		DUF_FRAME_INDEX = DUF_OLD_FRAME_INDEX;
		DUF_OLD_FRAME_INDEX = nil;
	end
end

function DUF_Options_SaveSettings(index)
	if (not index) then
		index = DUF_MiscOptions_SaveSettings:GetText();
	end
	DUF_MiscOptions_SaveSettings:ClearFocus();
	DUF_MiscOptions_SaveSettings:SetText("");
	if (index == "" or (not index)) then
		return;
	end
	if (DUF_Settings[index]) then
		DL_Error("You are attempting to create a new profile using the same name as an existing profile.  You must delete the existing profile first.");
		return;
	end
	DUF_Settings[index] = {};
	DL_Copy_Table(DUF_Settings[DUF_INDEX], DUF_Settings[index]);
	DUF_INDEX = index;
	DUF_Settings[DUF_PLAYER_INDEX] = index;
	DUF_Update_SavedSettings();
	DL_Feedback(DUF_TEXT.ProfileCreated);
end

function DUF_Options_SelectFrameOptions()
	DUF_Options_ResetIndices();
	DUF_MiscOptions:Hide();
	DUF_ColorContextOptions:Hide();
	DUF_ElementOptions:Hide();
	if (DUF_ELEMENT_SELECTED) then
		local button = getglobal(DUF_ELEMENT_SELECTED);
		button:SetTextColor(1, 1, 0);
		button:SetBackdropColor(0, 0, 0);
		button:SetBackdropBorderColor(.8, 0, 0);
	end
	DUF_ELEMENT_INDEX = nil;
	DUF_ELEMENT_SUBINDEX = nil;
	DUF_ELEMENT_SELECTED = "DUF_Options_FrameOptions";
	DUF_Options_FrameOptions:SetTextColor(1, 0, 0);
	DUF_Options_FrameOptions:SetBackdropColor(1, 1, 0);
	DUF_Options_FrameOptions:SetBackdropBorderColor(1, 1, 1);
end

function DUF_Options_SetLoadIndex()
	DUF_LOADINDEX = DUF_MiscOptions_LoadSettings_Setting:GetText();
end

function DUF_Options_SetOldIndices()
	if (not DUF_OLD_ELEM_INDEX) then
		DUF_OLD_ELEM_INDEX = DUF_ELEMENT_INDEX;
	end
	DUF_ELEMENT_INDEX = nil;
	if (not DUF_OLD_ELEM_SUBINDEX) then
		DUF_OLD_ELEM_SUBINDEX = DUF_ELEMENT_SUBINDEX;
	end
	DUF_ELEMENT_SUBINDEX = nil;
	if (not DUF_OLD_FRAME_INDEX) then
		DUF_OLD_FRAME_INDEX = DUF_FRAME_INDEX;
	end
	DUF_FRAME_INDEX = nil;
end

function DUF_Options_SetScale()
	DUF_Options:SetScale(DUF_Settings[DUF_INDEX].optionscale);
	DUF_Options.scale = DUF_Options:GetScale();
	DUF_Options:ClearAllPoints();
	DUF_Options:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
end

function DUF_OptionsSelect_OnClick()
	if (DUF_OPTIONS_SELECTED) then
		local button = getglobal(DUF_OPTIONS_SELECTED);
		button:SetTextColor(1, 1, 0);
		button:SetBackdropColor(0, 0, 0);
		button:SetBackdropBorderColor(.8, 0, 0);
	end
	DUF_OPTIONS_SELECTED = this:GetName();
	this:SetTextColor(1, 0, 0);
	this:SetBackdropColor(1, 1, 0);
	this:SetBackdropBorderColor(1, 1, 1);
end

function DUF_Run_Functions(initFunc)
	if (not DUF_INITIALIZED) then return; end
	if (not initFunc) then
		initFunc = this:GetParent().initFunc;
	end
	if (not initFunc) then
		initFunc = this.initFunc;
	end
	if (initFunc) then
		if (DUF_INIT_FRAMES) then
			for _,unit in DUF_INIT_FRAMES do
				initFunc(unit, DUF_ELEMENT_SUBINDEX);
			end
		else
			initFunc();
		end
	end
end

function DUF_SelectButton_OnLoad()
	this:SetTextColor(1, 1, 0);
	this:SetBackdropColor(0, 0, 0);
	this:SetBackdropBorderColor(.8, 0, 0);
end

function DUF_SelectElement_OnClick(index, subindex)
	DUF_Options_ResetIndices();
	DUF_MiscOptions:Hide();
	DUF_ColorContextOptions:Hide();
	if (DUF_ELEMENT_SELECTED) then
		local button = getglobal(DUF_ELEMENT_SELECTED);
		button:SetTextColor(1, 1, 0);
		button:SetBackdropColor(0, 0, 0);
		button:SetBackdropBorderColor(.8, 0, 0);
	end
	DUF_ELEMENT_SELECTED = this:GetName();
	this:SetTextColor(1, 0, 0);
	this:SetBackdropColor(1, 1, 0);
	this:SetBackdropBorderColor(1, 1, 1);
	DUF_ELEMENT_INDEX = index;
	DUF_ELEMENT_SUBINDEX = subindex;
	if (DUF_ELEMENT_INDEX) then
		DUF_ElementOptions:Show();
		DUF_FrameOptions:Hide();
		DUF_Init_BaseOptions();
		DUF_Show_SpecialOptions();
	else
		DUF_ElementOptions:Hide();
		DUF_FrameOptions:Show();
		DUF_Init_FrameOptions();
	end
end

function DUF_SelectFrame_OnClick(index, bttn)
	if (not bttn) then
		bttn = this
	end
	DUF_Options_ResetIndices();
	DUF_MiscOptions:Hide();
	DUF_ColorContextOptions:Hide();
	if (DUF_FRAME_SELECTED) then
		local button = getglobal(DUF_FRAME_SELECTED);
		button:SetTextColor(1, 1, 0);
		button:SetBackdropColor(0, 0, 0);
		button:SetBackdropBorderColor(.8, 0, 0);
	end
	DUF_FRAME_SELECTED = bttn:GetName();
	bttn:SetTextColor(1, 0, 0);
	bttn:SetBackdropColor(1, 1, 0);
	bttn:SetBackdropBorderColor(1, 1, 1);
	DUF_FRAME_INDEX = index;
	DUF_INIT_FRAMES = { index };
	DUF_Options_ComboPoints:Hide();
	DUF_Options_XPBar:Hide();
	DUF_Options_HappinessIcon:Hide();
	DUF_Options_HonorBar:Hide();
	DUF_Options_EliteTexture:Hide();
	DUF_MiscOptions:Hide();
	DUF_ColorContextOptions:Hide();
	if (index == "party") then
		DUF_INIT_FRAMES = { "party1", "party2", "party3", "party4" };
	elseif (index == "partypet") then
		DUF_INIT_FRAMES = { "partypet1", "partypet2", "partypet3", "partypet4" };
	elseif (index == "player") then
		DUF_Options_XPBar:Show();
		DUF_Options_HonorBar:Show();
	elseif (index == "pet") then
		DUF_Options_XPBar:Show();
		DUF_Options_HappinessIcon:Show();
	elseif (index == "target") then
		DUF_Options_ComboPoints:Show();
		DUF_Options_EliteTexture:Show();
	end
	if (index == "party" or index == "partypet") then
		DUF_FRAME_CHOICES = {
			{value = 1, text = 1},
			{value = 2, text = 2},
			{value = 3, text = 3},
			{value = 4, text = 4}
		}
	else
		DUF_FRAME_CHOICES = {
			{value = 1, text = 1}
		}
	end
	if (DUF_ELEMENT_INDEX == "StatusBar" and DUF_ELEMENT_SUBINDEX == 3 and DUF_FRAME_INDEX ~= "player" and DUF_FRAME_INDEX ~= "pet") then
		DUF_Options_SelectFrameOptions();
	elseif (DUF_ELEMENT_INDEX == "StatusBar" and DUF_ELEMENT_SUBINDEX == 6 and DUF_FRAME_INDEX ~= "player") then
		DUF_Options_SelectFrameOptions();
	elseif (DUF_ELEMENT_INDEX == "HappinessIcon" and DUF_FRAME_INDEX ~= "pet") then
		DUF_Options_SelectFrameOptions();
	elseif (DUF_ELEMENT_INDEX == "ComboPoints" and DUF_FRAME_INDEX ~= "target") then
		DUF_Options_SelectFrameOptions();
	elseif (DUF_ELEMENT_INDEX == "EliteTexture" and DUF_FRAME_INDEX ~= "target") then
		DUF_Options_SelectFrameOptions();
	end
	DUF_Show_SpecialOptions();
	if (DUF_ELEMENT_INDEX) then
		DUF_Init_BaseOptions();
	else
		DUF_Init_FrameOptions();
	end
	for i = 1,10 do
		getglobal("DUF_Options_TextBox"..i):SetText("["..i.."] "..DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX].TextBox[i].label);
	end
end

function DUF_SetCopyFrame()
	DUF_FrameOptions_CopyButton.index = this.value;
	DUF_FrameOptions_SafeCopyButton.index = this.value;
end

function DUF_Show_ContextColors()
	DUF_MiscOptions:Hide();
	DUF_ColorContextOptions:Show();
	DUF_ElementOptions:Hide();
	DUF_FrameOptions:Hide();
	DUF_Options_SetOldIndices();
end

function DUF_Show_MiscOptions()
	DUF_MiscOptions:Show();
	DUF_ColorContextOptions:Hide();
	DUF_ElementOptions:Hide();
	DUF_FrameOptions:Hide();
	DUF_Options_SetOldIndices();
end

function DUF_Show_SpecialOptions()
	if (DUF_SPECIAL_OPTIONS) then
		getglobal(DUF_SPECIAL_OPTIONS):Hide();
	end
	if (DUF_ELEMENT_INDEX == "StatusBar") then
		if (DUF_ELEMENT_SUBINDEX == 1 or DUF_ELEMENT_SUBINDEX == 4) then
			DUF_SPECIAL_OPTIONS = "DUF_HealthBarOptions";
			DUF_Init_HealthBarOptions();
		elseif (DUF_ELEMENT_SUBINDEX == 2 or DUF_ELEMENT_SUBINDEX == 5) then
			DUF_SPECIAL_OPTIONS = "DUF_ManaBarOptions";
			DUF_Init_ManaBarOptions();
		else
			DUF_SPECIAL_OPTIONS = "DUF_XPBarOptions";
			DUF_Init_XPBarOptions();
		end
	elseif (DUF_ELEMENT_INDEX == "StatusIcon" or DUF_ELEMENT_INDEX == "RankIcon" or DUF_ELEMENT_INDEX == "RaceIcon" or DUF_ELEMENT_INDEX == "PVPIcon" or DUF_ELEMENT_INDEX == "LootIcon" or DUF_ELEMENT_INDEX == "LeaderIcon" or DUF_ELEMENT_INDEX == "HappinessIcon") then
		DUF_SPECIAL_OPTIONS = "DUF_IconOptions";
		DUF_Init_IconOptions();
	elseif (DUF_ELEMENT_INDEX == "Portrait") then
		DUF_SPECIAL_OPTIONS = "DUF_PortraitOptions";
		DUF_Init_PortraitOptions();
	elseif (DUF_ELEMENT_INDEX == "ClassIcon") then
		DUF_SPECIAL_OPTIONS = "DUF_ClassIconOptions";
		DUF_Init_ClassIconOptions();
	elseif (DUF_ELEMENT_INDEX == "TextBox") then
		DUF_SPECIAL_OPTIONS = "DUF_TextBoxOptions";
		DUF_Init_TextBoxOptions();
	elseif (DUF_ELEMENT_INDEX == "ComboPoints") then
		DUF_SPECIAL_OPTIONS = "DUF_ComboPointsOptions";
		DUF_Init_ComboPointsOptions();
	elseif (DUF_ELEMENT_INDEX == "Buffs") then
		DUF_SPECIAL_OPTIONS = "DUF_BuffOptions";
		DUF_Init_BuffOptions();
	elseif (DUF_ELEMENT_INDEX == "Debuffs") then
		DUF_SPECIAL_OPTIONS = "DUF_DebuffOptions";
		DUF_Init_DebuffOptions();
	elseif (DUF_ELEMENT_INDEX == "EliteTexture") then
		DUF_SPECIAL_OPTIONS = "DUF_EliteTextureOptions";
		DUF_Init_EliteTextureOptions();
	elseif (not DUF_ELEMENT_INDEX) then
		DUF_SPECIAL_OPTIONS = "DUF_FrameOptions";
		DUF_FrameOptions:Show();
		DUF_Init_FrameOptions();
	end
	if (DUF_OPTIONS_SELECTED == "DUF_ElementOptions_SpecialSelect") then
		getglobal(DUF_SPECIAL_OPTIONS):Show();
	end
end

function DUF_Slider_Update()
	if (not DUF_INITIALIZED) then return; end
	local setting = DUF_Options_GetSetting(this.index);
	if (this.scale) then
		setting = setting * this.scale;
	end
	local min, max = this:GetMinMaxValues();
	if (setting and (setting < min or setting > max)) then
		return;
	end
	local value = this:GetValue();
	getglobal(this:GetName().."_Display"):SetText(value);
	if (this.scale) then
		value = value / this.scale;
	end
	DUF_Update_Setting(value, this.index, this.subindex);
	DUF_Run_Functions();
end

function DUF_Slider_UpdateFromEditBox()
	if (DUF_NOSLIDEREDIT) then return; end
	local value = this:GetNumber();
	if (not value) then value = 0; end
	local min, max = this:GetParent():GetMinMaxValues();
	if (this:GetParent().minlocked and value < min) then value = min; end
	if (this:GetParent().maxlocked and value > max) then value = max; end
	this:SetText(value);
	if (value >= min and value <= max) then
		this:GetParent():SetValue(value);
	end
	this:ClearFocus();
	if (this:GetParent().scale) then
		value = value / this:GetParent().scale;
	end
	DUF_Update_Setting(value, this:GetParent().index, this:GetParent().subindex);
	if (this:GetParent().initFunc) then
		DUF_Run_Functions(this:GetParent().initFunc);
	else
		DUF_Run_Functions(this:GetParent():GetParent().initFunc);
	end
end

function DUF_Update_SavedSettings()
	DUF_SAVED_SETTINGS = {};
	for setting in DUF_Settings do
		if ((not string.find(setting, "INITIALIZED")) and (not string.find(setting, " :: "))) then
			DUF_SAVED_SETTINGS[setting] = { text=setting, value=setting };
		end
	end
	DUF_MiscOptions_CurrentProfile:SetText(DUF_TEXT.CurrentProfile..":  "..DUF_INDEX);
end

function DUF_Update_Setting(value, index, subindex)
	if (not index) then
		return;
	end
	if (not DUF_FRAME_INDEX) then
		if (subindex) then
			DUF_Settings[DUF_INDEX][index][subindex] = value;
		else
			DUF_Settings[DUF_INDEX][index] = value;
		end
	else
		if (DUF_ELEMENT_SUBINDEX) then
			DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][DUF_ELEMENT_INDEX][DUF_ELEMENT_SUBINDEX][index] = value;
		elseif (DUF_ELEMENT_INDEX) then
			DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][DUF_ELEMENT_INDEX][index] = value;
		else
			DUF_Settings[DUF_INDEX][DUF_FRAME_INDEX][index] = value;
		end
	end
end
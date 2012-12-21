function BEBOptions_LoadDefaults()
	if ( not BEBINITIALIZED ) then
		BEBConfigFrame:Hide();
		return;
	end
	BEBSettings[BEB_INDEX] = nil
	BEB_DefaultSettings()
	BEB_SetupBars()
	BEB_UpdateBars()
	BEB_Feedback("BEB Defaults Loaded")
	BEBOptions_OnShow(BEBCurrentFrame)
end

function BEBOptions_SelectFrame()
	if ( not BEBINITIALIZED ) then
		this:GetParent():Hide();
		return;
	end
	local frames = {"BEBConfigGeneralFrame", "BEBConfigPlacementFrame", "BEBConfigColorsFrame"}
	for _,v in frames do
		getglobal(v):Hide()
	end
	BEBCurrentFrame = this.index
	getglobal("BEBConfig"..this.index.."Frame"):Show()
end

function BEBOptions_CheckButton_OnClick()
	if ( not BEBINITIALIZED ) then
		this:GetParent():Hide();
		return;
	end
	if (this == BEBEnabledButton) then
		BEBSettings[BEB_INDEX].Disabled = (not this:GetChecked());
		if (BEBSettings[BEB_INDEX].Disabled) then
			BEBOptions_DisableAddon()
		else
			BEBOptions_EnableAddon()
		end
	else
		if (this.notindex) then
			BEBSettings[BEB_INDEX][this.notindex] = (not this:GetChecked())
		else
			BEBSettings[BEB_INDEX][this.index] = (not(not this:GetChecked()))
		end
	end
	if (this == BEBFlashHighlightButton) then
		BEBRestedXpTickGlowTexture:SetAlpha(1);
		BEB_OnEvent("PLAYER_UPDATE_RESTING")
	elseif (this == BEBShowXpTextButton) then
		if (BEBSettings[BEB_INDEX].XpTextOnMouseOver) then
			BEB_Feedback(BEB_TEXT.optionstextwasmouseover)
			BEBSettings[BEB_INDEX].XpTextOnMouseOver = false
			BEBTextOnMouseoverButton:SetChecked(false);
		end
	elseif (this == BEBTextOnMouseoverButton) then
		if (BEBSettings[BEB_INDEX].XpTextHide) then
			BEB_Feedback(BEB_TEXT.optionstextwashidden)
			BEBSettings[BEB_INDEX].XpTextHide = false
			BEBShowXpTextButton:SetChecked(true);
		end
	end
	BEB_SetupBars()
	BEB_UpdateBars()
end

function BEBOptions_ColorPicker_OnClick()
	if (ColorPickerFrame:IsShown()) then
		BEB_ColorPicker_Cancelled(ColorPickerFrame.previousValues)
		ColorPickerFrame:Hide()
	else
		local Red, Green, Blue, Alpha
		Red, Green, Blue, Alpha = unpack(BEBSettings[BEB_INDEX][this.objindex][this.whenindex])
		ColorPickerFrame.previousValues = {Red, Green, Blue, Alpha};
		ColorPickerFrame.cancelFunc = BEB_ColorPicker_Cancelled;
		ColorPickerFrame.opacityFunc = BEB_ColorPicker_OpacityChanged;
		ColorPickerFrame.func = BEB_ColorPicker_ColorChanged;
		ColorPickerFrame.index = this:GetName().."Texture";
		ColorPickerFrame.objindex = this.objindex
		ColorPickerFrame.whenindex = this.whenindex
		ColorPickerFrame.hasOpacity = true;
		ColorPickerFrame.opacity = Alpha;
		ColorPickerFrame:SetColorRGB(Red, Green, Blue);
		ColorPickerFrame:ClearAllPoints();
		local x = BEBConfigFrame:GetCenter()
		if (x < UIParent:GetWidth() / 2) then
			ColorPickerFrame:SetPoint("LEFT", "BEBConfigFrame", "RIGHT", 0, 0);
		else
			ColorPickerFrame:SetPoint("RIGHT", "BEBConfigFrame", "LEFT", 0, 0);
		end
		ColorPickerFrame:Show();
	end
end

function BEB_ColorPicker_Cancelled(color)
	BEBSettings[BEB_INDEX][ColorPickerFrame.objindex][ColorPickerFrame.whenindex] = color
	BEBOptions_OnShow(BEBCurrentFrame)
end

function BEB_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = OpacitySliderFrame:GetValue()
	getglobal(ColorPickerFrame.index):SetVertexColor(r,g,b,a)
	if (not ColorPickerFrame:IsShown()) then
		BEBSettings[BEB_INDEX][ColorPickerFrame.objindex][ColorPickerFrame.whenindex] = {r,g,b,a}
		BEB_SetupBars()
		BEB_UpdateBars()
		BEB_OnEvent("PLAYER_UPDATE_RESTING")
		BEB_OnEvent("UPDATE_EXHAUSTION")
	end
end
function BEB_ColorPicker_OpacityChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = OpacitySliderFrame:GetValue()
	getglobal(ColorPickerFrame.index):SetVertexColor(r, g, b, a)
end

function BEBOptions_SliderOnChange()
	local value = this:GetValue()
	getglobal(this:GetName().."_EditBox"):SetText(value)
	BEBSettings[BEB_INDEX][this.objindex][this.whatindex][this.axisindex] = value
	BEB_SetupBars()
	BEB_UpdateBars()
	if ((this==BEBFontHeightSlider) and (BEBSettings[BEB_INDEX].XpTextOnMouseOver)) then
		BEBXpFontstring:Show()
		BEBTextTimeToHide = 2
	end
end
function BEBOptions_SliderEditBox_OnValueChange()
	local value = this:GetNumber()
	local slidervalue = this:GetParent():GetValue(value)
	if (value ~= slidervalue) then
		this:GetParent():SetValue(value)
	end
end

function BEBOptions_OnShow(frame)
	if ( not BEBINITIALIZED ) then
		if (BEBSettings[BEB_INDEX].Disabled) then
			BEBEnableFrame:Show()
		end
		BEBConfigFrame:Hide();
		return;
	end
	if (BEBSettings[BEB_INDEX].Disabled) then
		BEBEnableFrame:Show()
		BEBConfigFrame:Hide();
	end
	if (frame == "Options") then
		local selectors = {"BEBGeneralSelector", "BEBColorsSelector", "BEBPlacementSelector"}
		for _,v in selectors do
			getglobal(v):SetText(BEB_SELECTOR_LABELS[v])
		end
		local frames = {"BEBConfigGeneralFrame", "BEBConfigPlacementFrame", "BEBConfigColorsFrame"}
		for _,v in frames do
			getglobal(v):Hide()
		end
		getglobal("BEBConfig"..BEBCurrentFrame.."Frame"):Show()
	elseif (frame == "General") then
		local buttons = {"BEBEnabledButton", "BEBShowMarksButton", "BEBShowXpTicksButton", "BEBShowRestedXpTicksButton", "BEBShowBackgroundButton", "BEBShowXpTextButton", "BEBFlashHighlightButton", "BEBTextOnMouseoverButton", "BEBShowRestedBarButton", "BEBUnlockBarButton"}
		for _,v in buttons do
			local button = getglobal(v)
			if (button.notindex) then
				button:SetChecked(not BEBSettings[BEB_INDEX][button.notindex])
			else
				button:SetChecked(BEBSettings[BEB_INDEX][button.index])
			end
			getglobal(v.."Text"):SetText(BEB_CHECKBUTTONLABELS[v])
			getglobal(v.."Text"):SetWidth(105);
			getglobal(v.."Text"):SetJustifyH("LEFT");
		end
		BEB_TextStringFrame_Label:SetText(BEB_HEADINGS.BEB_TextStringFrame_Label)
		BEB_TextStringFrameEditBox:SetText(BEBSettings[BEB_INDEX].BarText.text.string)
		BEBGeneralSelector:LockHighlight()
		BEBColorsSelector:UnlockHighlight()
		BEBPlacementSelector:UnlockHighlight()
	elseif (frame == "Colors") then
		local headings = {"BEBXpBarHeading", "BEBRestedBarHeading", "BEBMarkerHeading", "BEBTickHeading", "BEBRestedTickHeading", "BEBBarTextHeading"}
		local buttons = {"BEBBackgroundColorButton", "BEBXpUnrestedColorButton", "BEBXpRestedColorButton", "BEBXpMaxRestedColorButton", "BEBRestedBarColorButton", "BEBRestedBarMaxColorButton", "BEBMarkerUnrestColorButton", "BEBMarkerRestColorButton", "BEBMarkerMaxrestColorButton", "BEBTickUnrestColorButton", "BEBTickRestColorButton", "BEBTickMaxrestColorButton", "BEBRestedTickRestColorButton", "BEBRestedTickMaxrestColorButton", "BEBBarTextUnrestColorButton", "BEBBarTextRestColorButton", "BEBBarTextMaxrestColorButton"}
		for _,v in buttons do
			local button = getglobal(v)
			getglobal(v.."Texture"):SetVertexColor(unpack(BEBSettings[BEB_INDEX][button.objindex][button.whenindex]))
			getglobal(v.."Text"):SetText(BEB_BUTTONLABELS[v])
		end
		for _,v in headings do
			local heading = getglobal(v)
			heading:SetText(BEB_HEADINGS[v])
			heading:SetHeight(20)
			heading:SetJustifyH("LEFT")
			heading:SetJustifyV("BOTTOM")
		end
		BEBColorsSelector:LockHighlight()
		BEBGeneralSelector:UnlockHighlight()
		BEBPlacementSelector:UnlockHighlight()
	elseif (frame == "Placement") then
		local headings = {"BEBMainSizeHeading", "BEBTickSizeHeading", "BEBMainPositionControlsTitle", "BEBTickPositionControlsTitle", "BEB_MainAttachPointButton_Label", "BEB_MainAttachToPointButton_Label", "BEB_MainAttachToFrame_Label"}
		local sliders = {"BEBMainHeightSlider", "BEBMainWidthSlider", "BEBTickHeightSlider", "BEBTickWidthSlider", "BEBFontHeightSlider"}
		for _,v in sliders do
			local slider = getglobal(v)
			slider:SetValue(BEBSettings[BEB_INDEX][slider.objindex][slider.whatindex][slider.axisindex])
			getglobal(v.."_Label"):SetText(BEB_TEXT[slider.label])
			getglobal(v.."_EditBox"):SetText(BEBSettings[BEB_INDEX][slider.objindex][slider.whatindex][slider.axisindex])
			getglobal(v.."_EditBox"):SetTextColor(1,0.82,0)
			getglobal(v.."Text"):Hide()
			local min, max = slider:GetMinMaxValues();
			getglobal(v.."Low"):SetText(min);
			getglobal(v.."High"):SetText(max);
		end
		for _,v in headings do
			local heading = getglobal(v)
			heading:SetText(BEB_HEADINGS[v])
		end
		BEBMainPositionControlsxEditBox:SetText(BEBSettings[BEB_INDEX].BEBMain.location.x)
		BEBMainPositionControlsyEditBox:SetText(BEBSettings[BEB_INDEX].BEBMain.location.y)
		BEBTickPositionControlsxEditBox:SetText(BEBSettings[BEB_INDEX].Tick.location.x)
		BEBTickPositionControlsyEditBox:SetText(BEBSettings[BEB_INDEX].Tick.location.y)
		BEBMainPositionControlsxEditBox:SetTextColor(1,0.82,0)
		BEBMainPositionControlsyEditBox:SetTextColor(1,0.82,0)
		BEBTickPositionControlsxEditBox:SetTextColor(1,0.82,0)
		BEBTickPositionControlsyEditBox:SetTextColor(1,0.82,0)
		BEB_MainAttachToFrameEditBox:SetTextColor(1,0.82,0)
		local attachpoint = BEBSettings[BEB_INDEX].BEBMain.location.point
		local attachtopoint = BEBSettings[BEB_INDEX].BEBMain.location.relpoint
		BEB_MainAttachPointButtonText:SetText(BEB_ATTACHPOINTS[attachpoint])
		BEB_MainAttachToPointButtonText:SetText(BEB_ATTACHPOINTS[attachtopoint])
		local attachtoframe = BEBSettings[BEB_INDEX].BEBMain.location.relto
		if (BEB_UIATTACHFRAMES[attachtoframe]) then
			BEB_MainAttachToFrameEditBox:SetText(BEB_UIATTACHFRAMES[attachtoframe])
		else
			BEB_MainAttachToFrameEditBox:SetText(attachtoframe)
		end
		BEBPlacementSelector:LockHighlight()
		BEBGeneralSelector:UnlockHighlight()
		BEBColorsSelector:UnlockHighlight()
	end
end

function BEBOptions_DisableAddon()
	if ( not BEBINITIALIZED ) then
		this:GetParent():Hide();
		return;
	end
	BEBMain:UnregisterEvent("PLAYER_LEVEL_UP")
	BEBMain:UnregisterEvent("PLAYER_UPDATE_RESTING")
	BEBMain:UnregisterEvent("PLAYER_XP_UPDATE")
	BEBMain:UnregisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
	BEBMain:UnregisterEvent("UPDATE_EXHAUSTION")
	BEBMain:Hide()
	BEBDisabled = true
	BEBSettings[BEB_INDEX].Disabled = true
	if (BEBConfigFrame:IsShown()) then
		BEBConfigFrame:Hide()
		BEBEnableFrame:Show()
	end
end
function BEBOptions_EnableAddon()
	BEBINITIALIZED = nil
	BEBSettings[BEB_INDEX].Disabled = false
	BEBDisabled = false
	BEB_Initialize()
end

function BEBOptions_OnMouseDown()
	BEBConfigFrame:StartMoving()
end

function BEBOptions_OnMouseUp()
	BEBConfigFrame:StopMovingOrSizing()
end

function BEBOptions_Nudge(arg1,button)
	local change
	if (arg1 == "RightButton") then
		change = 5
	else
		change = 1
	end
	local thing = getglobal(button)
	local axis
	local element = thing:GetParent().index
	if (thing.index == "0") then
		BEBSettings[BEB_INDEX][element].location.x = 0
		BEBSettings[BEB_INDEX][element].location.y = 0
	elseif (thing.index == "up") then
		BEBSettings[BEB_INDEX][element].location.y = BEBSettings[BEB_INDEX][element].location.y + change
	elseif (thing.index == "down") then
		BEBSettings[BEB_INDEX][element].location.y = BEBSettings[BEB_INDEX][element].location.y - change
	elseif (thing.index == "left") then
		BEBSettings[BEB_INDEX][element].location.x = BEBSettings[BEB_INDEX][element].location.x - change
	elseif (thing.index == "right") then
		BEBSettings[BEB_INDEX][element].location.x = BEBSettings[BEB_INDEX][element].location.x + change
	end
	getglobal(thing:GetParent():GetName().."xEditBox"):SetText(BEBSettings[BEB_INDEX][element].location.x)
	getglobal(thing:GetParent():GetName().."yEditBox"):SetText(BEBSettings[BEB_INDEX][element].location.y)
end

function BEBOptions_Placement_OnUpdate(elapsed)
	if (BEBNudging) then
		if (BEBNudgeTime <= 0) then
			BEBOptions_Nudge("MiddleButton",BEBNudging)
			BEBNudgeTime = 0.015
		else
			BEBNudgeTime = BEBNudgeTime - elapsed
		end
	end
end

function BEBOptions_PositionEditBox_OnValueChange()
	local axis = this.index
	local element = this:GetParent().index
	BEBSettings[BEB_INDEX][element].location[axis] = this:GetNumber()
	BEB_SetupBars()
	BEB_UpdateBars()
end

function BEBOptions_DDM_OnUpdate(elapsed)
	if (this.timer) then
		if (this.timer <= 0) then
			this:Hide()
		else
			this.timer = this.timer - elapsed
		end
	end
end

function BEBOptions_ShowMenu()
	if (BEB_DropDownMenu:IsVisible()) then
		BEB_DropDownMenu:Hide()
		return
	end
	if (this.how) then
		BEB_DropDownMenu.how = this.how
	end
	BEB_DropDownMenu.whatindex = this.whatindex
	BEB_DropDownMenu.typeindex = this.typeindex
	BEB_DropDownMenu.subindex = this.subindex
	BEB_DropDownMenu.controlbox = this.controlbox
	local count = 0;
	local widest = 0;
	for value, text in getglobal(this.table) do
		count = count + 1
		getglobal("BEB_DropDownMenu_Button"..count.."Text"):SetText(text)
		getglobal("BEB_DropDownMenu_Button"..count).value = value
		getglobal("BEB_DropDownMenu_Button"..count):Show()
		local width = getglobal("BEB_DropDownMenu_Button"..count.."Text"):GetStringWidth()
		widest = math.max(widest, width)
	end
	for i=1, BEB_DropDownMenu.count do
		if (i <= count) then
			getglobal("BEB_DropDownMenu_Button"..i):SetWidth(widest);
		else
			getglobal("BEB_DropDownMenu_Button"..i):Hide();			
		end
	end
	BEB_DropDownMenu:SetWidth(widest + 20);
	BEB_DropDownMenu:SetHeight(count * 15 + 20);
	BEB_DropDownMenu:ClearAllPoints();
	BEB_DropDownMenu:SetPoint("TOPLEFT", getglobal(this.controlbox), "BOTTOMLEFT", 0, 0);
	if (BEB_DropDownMenu:GetBottom() < UIParent:GetBottom()) then
		local yoffset = UIParent:GetBottom() - BEB_DropDownMenu:GetBottom();
		BEB_DropDownMenu:ClearAllPoints();
		BEB_DropDownMenu:SetPoint("TOPLEFT", getglobal(this.controlbox), "BOTTOMLEFT", 20, yoffset);
	end
	BEB_DropDownMenu:Show()
	BEB_DropDownMenu.timer = 5
end

function BEBOptions_MenuOptionOnClick()
	if (this:GetParent().how) then
		getglobal(this:GetParent().controlbox):Insert(this.value)
	else
		getglobal(this:GetParent().controlbox):SetText(getglobal(this:GetName().."Text"):GetText())
		BEBSettings[BEB_INDEX][this:GetParent().whatindex][this:GetParent().typeindex][this:GetParent().subindex] = this.value
	end
	BEB_SetupBars()
	BEB_DropDownMenu:Hide()
end

function BEBOption_ChangeAttachTo()
	if (BEB_IsFrame(this:GetText())) then
		BEBSettings[BEB_INDEX].BEBMain.location.relto = this:GetText()
		BEB_SetupBars()
	else
		BEB_Feedback(BEB_TEXT.frameisinvalid)
		this:SetText(this.prevvals)
	end
end

function BEBOption_ChangeText()
	for k,_ in BEBOverlayFrame.texttable.events do
		BEBOverlayFrame:UnregisterEvent(k)
	end
	BEBOverlayFrame.texttable = BEB_CompileString(this:GetText())
	BEB_StringEvent("PLAYER_LEVEL_UP")
	for k,_ in BEBOverlayFrame.texttable.events do
		BEBOverlayFrame:RegisterEvent(k)
	end
	BEBSettings[BEB_INDEX].BarText.text.string = this:GetText()
end
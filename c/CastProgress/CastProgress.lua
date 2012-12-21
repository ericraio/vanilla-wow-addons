-- Re-valued globals from default casting bar
-- Leave them global so the casting bar code will use them
CASTING_BAR_ALPHA_STEP = 0.01
CASTING_BAR_HOLD_TIME = 0

-- The addon
CastProgress = { version = 11100.03 }

-- Saved variables
CPVar = {}

function CastProgress:OnLoad()
	this:RegisterEvent("ADDON_LOADED")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")
	SLASH_CASTPROGRESS1 = "/castprogress"
	SlashCmdList["CASTPROGRESS"] = CastProgress.SlashCommands
end

function CastProgress.SlashCommands(msg)
	if (strlower(msg) == "home") then
		CastProgressTitleFrame:ClearAllPoints()
		CastProgressTitleFrame:SetPoint("TOP", "UIParent", "TOP", 0, -30)
		CastProgressProgressFrame:ClearAllPoints()
		CastProgressProgressFrame:SetPoint("TOP", "CastProgressTitleFrame", "BOTTOM", 0, 0)
		CastProgressBarFrame:ClearAllPoints()
		CastProgressBarFrame:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, 60)
		CastProgressBarFrame:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, 60)
	else
		CastProgress:ShowOptions()
	end
end

function CastProgress:Initialise()
	CastProgress.player = UnitName("player")
	CastProgress.this = this
	
	-- Default settings
	if not CPVar["version"] then
		CPVar["version"] = CastProgress.version
	end

	if not CPVar[CastProgress.player] then
		UIErrorsFrame:AddMessage(CastProgress.strings.NEW..CastProgress.player, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
		CPVar[CastProgress.player] = {}
		CPVar[CastProgress.player].opacity = 1
		CPVar[CastProgress.player].uiscale = 1
		CPVar[CastProgress.player].addonmenu = 1
	else
		CastProgress:CheckSavedVars()
	end
	
	-- Update to current version
	if (tonumber(CPVar["version"]) < CastProgress.version) then
		UIErrorsFrame:AddMessage(CastProgress.strings.UPDATE..string.format("%.2f|", CastProgress.version), 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
		if (CPVar["version"] < 1900.00) then
			CPVar[CastProgress.player].uiscale = 1
			CPVar[CastProgress.player].barScale = nil
			CPVar[CastProgress.player].progressScale = nil
			CPVar[CastProgress.player].titleScale = nil
		end
		if (CPVar["version"] < 11000.02) then
			CPVar[CastProgress.player].addonmenu = 1
		end
		CPVar["version"] = CastProgress.version
	end
	
	CastProgressProgressFrame:SetBackdropColor(0,0,0,0)
	CastProgressTitleFrame:SetBackdropColor(0,0,0,0)
	CastProgressTitleText:SetTextColor(1, 1, 1)
	CastProgress:InitOptions()
end

function CastProgress:DoCastingBar()
	-- Sod the default casting bar, we'll do our own.
	CastingBarFrame:UnregisterEvent("SPELLCAST_START")
	CastingBarFrame:UnregisterEvent("SPELLCAST_STOP")
	CastingBarFrame:UnregisterEvent("SPELLCAST_FAILED")
	CastingBarFrame:UnregisterEvent("SPELLCAST_INTERRUPTED")
	CastingBarFrame:UnregisterEvent("SPELLCAST_DELAYED")
	CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_START")
	CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_UPDATE")

	CastProgressBarBorder:SetBackdrop({
		bgFile = nil, 
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = true, 
		tileSize = 16, 
		edgeSize = 16, 
		insets = {3,3,3,3}
	})
end

function CastProgress:AnchorCastBar()
end

function CastProgress:OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		CastProgress:DoScale()
		CastProgress:DoCastingBar()
		CastProgress:DoUIScale()
		CastProgress:DoAnchors()

		CastProgressProgressFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		CastProgressProgressFrame:Hide()
		CastProgressTitleFrame:Hide()
		CastProgressTitleFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		CastProgressBarFrame:Hide()
		CastProgressBarFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		this:RegisterEvent("SPELLCAST_START")
		this:RegisterEvent("SPELLCAST_STOP")
		this:RegisterEvent("SPELLCAST_FAILED")
		this:RegisterEvent("SPELLCAST_INTERRUPTED")
		this:RegisterEvent("SPELLCAST_DELAYED")
		this:RegisterEvent("SPELLCAST_CHANNEL_START")
		this:RegisterEvent("SPELLCAST_CHANNEL_STOP")
		CastProgress.alphaFrame = CastProgressProgressFrame
		if CPVar[CastProgress.player].hideProgress then
			if not CPVar[CastProgress.player].hideTitle then
				CastProgress.alphaFrame = CastProgressTitleFrame
			elseif CPVar[CastProgress.player].showBar then
				CastProgress.alphaFrame = CastProgressBarFrame
			else
				CastProgress.alphaFrame = nil
			end
		end
		
	end
	
	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("SPELLCAST_START")
		this:UnregisterEvent("SPELLCAST_STOP")
		this:UnregisterEvent("SPELLCAST_FAILED")
		this:UnregisterEvent("SPELLCAST_INTERRUPTED")
		this:UnregisterEvent("SPELLCAST_DELAYED")
		this:UnregisterEvent("SPELLCAST_CHANNEL_START")
		this:UnregisterEvent("SPELLCAST_CHANNEL_UPDATE")
		this:UnregisterEvent("SPELLCAST_CHANNEL_STOP")
	end

	if (event == "ADDON_LOADED") and (arg1 == "CastProgress") then
		CastProgress:Initialise()
		return
	end

	-- Any events after here are for spellcasting events
	-- A bit of chicanery to invoke the default casting bar, if the user wants it shown still
	
	if (event == "SPELLCAST_START") then
		CastProgress.elapsedTime = 0
		CastProgress.progress = 0
		CastProgress.castTime = arg2
		CastProgressProgressFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		CastProgressTitleFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		CastProgressBarFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		CastProgressProgressText:SetTextColor(1, 1, 1)
		CastProgressTitleText:SetText(arg1)
		if not CPVar[CastProgress.player].hideProgress then
			CastProgressProgressFrame:Show()
		end
		if not CPVar[CastProgress.player].hideTitle then
			CastProgressTitleFrame:Show()
		end
		if CPVar[CastProgress.player].showBar then
			CastProgressBarFrame:Show()
			CastProgressBar:SetStatusBarColor(1.0, 0.7, 0.0)
			CastProgressBarSpark:Show()
			CastProgressBar:SetMinMaxValues(0, 1)
			CastProgressBar:SetValue(CastProgress.elapsedTime/CastProgress.castTime)
		end
		CastProgress.delay = 0
		CastProgress.casting = 1
		CastProgress.fadeOut = nil
		return
	end
	
	if (event == "SPELLCAST_CHANNEL_START") then
		CastProgress.elapsedTime = 0
		CastProgress.castTime = arg1
		CastProgressProgressFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		CastProgressTitleFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		CastProgressBarFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		CastProgressProgressText:SetTextColor(1, 1, 1)
		CastProgressTitleText:SetText(arg2)
		if not CPVar[CastProgress.player].hideProgress then
			CastProgressProgressFrame:Show()
		end
		if not CPVar[CastProgress.player].hideTitle then
			CastProgressTitleFrame:Show()
		end
		if CPVar[CastProgress.player].showBar then
			CastProgressBarFrame:Show()
			CastProgressBar:SetStatusBarColor(1.0, 0.7, 0.0)
			CastProgressBarSpark:Show()
			CastProgressBar:SetMinMaxValues(0, 1)
			CastProgressBar:SetValue(CastProgress.elapsedTime/CastProgress.castTime)
		end
		CastProgress.casting = 1
		CastProgress.channeling = 0
		CastProgress.fadeOut = nil
		CastProgress.interrupted = nil
		return
	end
	
	if (event == "SPELLCAST_FAILED") or (event == "SPELLCAST_INTERRUPTED") then
		CastProgressProgressText:SetTextColor(1, 0, 0)
		if (event == "SPELLCAST_FAILED") then
			CastProgressProgressText:SetText(FAILED)
		else
			CastProgressProgressText:SetText(INTERRUPTED)
		end
		if CPVar[CastProgress.player].showBar then
			CastProgressBar:SetStatusBarColor(1.0, 0.7, 0.0)
		end
		CastProgressBarSpark:Hide()
		CastProgress.casting = nil
		CastProgress.fadeOut = 1
		return
	end
	
	if (event == "SPELLCAST_DELAYED") then
		if CastProgress.castTime and (CastProgress.elapsedTime < CastProgress.castTime) then
			CastProgress.delay = CastProgress.delay + arg1
			CastProgress.elapsedTime = CastProgress.elapsedTime - arg1
			i = 1 - (CastProgress.delay/CastProgress.castTime)
			CastProgressProgressText:SetTextColor(1, i, i)
		end
		return
	end

	if (event == "SPELLCAST_CHANNEL_STOP") then
		if CastProgress.elapsedTime and CastProgress.castTime and (CastProgress.elapsedTime/CastProgress.castTime < 0.97) then
			CastProgressProgressText:SetTextColor(1, 0, 0)
			CastProgressBarSpark:Hide()
			CastProgressProgressText:SetText(INTERRUPTED)
			CastProgress.casting = nil
			CastProgress.fadeOut = 1
		else
			CastProgress.elapsedTime = CastProgress.castTime
			if CPVar[CastProgress.player].showBar then
				CastProgressBar:SetValue(1)
			end
		end
		return
	end
	
	if (event == "SPELLCAST_STOP") then
		return
	end
end

function CastProgress:OnUpdate(elapsed)
	if CastProgress.casting then
		CastProgress.elapsedTime = CastProgress.elapsedTime + (elapsed * 1000)
		if not CastProgress.castTime or (CastProgress.elapsedTime >= CastProgress.castTime) then
			CastProgress.casting = nil
			CastProgress.channeling = nil
			CastProgress.fadeOut = 1
			if CPVar[CastProgress.player].showBar then
				CastProgressBar:SetValue(1)
				CastProgressBar:SetStatusBarColor(0.0, 1.0, 0.0)
				CastProgressBarSpark:Hide()
			end
		end
		CastProgress:UpdateProgress()
	end
	
	if CastProgress.alphaFrame and CastProgress.fadeOut and not CastProgress.optionsShown then
		local alpha = CastProgress.alphaFrame:GetAlpha() - CASTING_BAR_ALPHA_STEP
		if (alpha > 0) then
			CastProgressProgressFrame:SetAlpha(alpha)
			CastProgressTitleFrame:SetAlpha(alpha)
			CastProgressBarFrame:SetAlpha(alpha)
		else
			CastProgress.fadeOut = nil
			CastProgressProgressFrame:Hide()
			CastProgressProgressFrame:SetAlpha(CPVar[CastProgress.player].opacity)
			CastProgressTitleFrame:Hide()
			CastProgressTitleFrame:SetAlpha(CPVar[CastProgress.player].opacity)
			CastProgressBarFrame:Hide()
			CastProgressBarFrame:SetAlpha(CPVar[CastProgress.player].opacity)
			CastProgressProgressText:SetText("")
			CastProgressTitleText:SetText("")
		end
	end
end

function CastProgress:Increment()
	if (CastProgress.castTime >= 8000) then
		return 1
	elseif (CastProgress.castTime >= 5000) then
		return 2
	elseif (CastProgress.castTime >= 3000) then
		return 3
	elseif (CastProgress.castTime >= 2000) then
		return 4
	end
	return 5
end

function CastProgress:UpdateProgress()
	local x

	if CPVar[CastProgress.player].showBar then
		CastProgressBar:SetValue(CastProgress.elapsedTime/CastProgress.castTime)
		CastProgressBarSpark:SetPoint("CENTER", CastProgressBar, "LEFT", 190*CastProgress.elapsedTime/CastProgress.castTime, 0);
	end
	
	if CPVar[CastProgress.player].castTime then
		x = (CastProgress.castTime - CastProgress.elapsedTime) / 1000
		if (x < 0) then
			x = 0
		end
		
		if (x ~= CastProgress.progress) then
			CastProgressProgressText:SetText(string.format("%.1f", x))
			if(x == 0) then
				CastProgressProgressText:SetTextColor(0, 1, 0)
			end
		end
	else
		x = floor(100*(CastProgress.elapsedTime/CastProgress.castTime))
		x = x - mod(x, CastProgress:Increment())
		if (x > 100) then
			x = 100
		end
			
		if (x ~= CastProgress.progress) then
			CastProgressProgressText:SetText(string.format("%d%%", x))
			if (x == 100) then
				CastProgressProgressText:SetTextColor(0, 1, 0)
			end
		end
	end
	CastProgress.progress = x
end

function CastProgress:DoScale()
	if CPVar[CastProgress.player].uiscale then
		local scale = 1.0
		CastProgressProgress:SetScale(scale)
		CastProgressProgressFrame:SetWidth(125)
		CastProgressProgressFrame:SetHeight(20)

		CastProgressTitle:SetScale(scale)
		CastProgressTitleFrame:SetWidth(200)
		CastProgressTitleFrame:SetHeight(20)

		if CPVar[CastProgress.player].showBar then
			CastProgressBar:SetScale(scale)
			CastProgressBarFrame:SetWidth(195)
			CastProgressBarFrame:SetHeight(13)
		end
	else

		CastProgressTitle:SetScale(CPVar[CastProgress.player].titleScale)
		CastProgressTitleFrame:SetWidth(200 * CPVar[CastProgress.player].titleScale)
		CastProgressTitleFrame:SetHeight(20 * CPVar[CastProgress.player].titleScale)

		CastProgressProgress:SetScale(CPVar[CastProgress.player].progressScale)
		CastProgressProgressFrame:SetWidth(125 * CPVar[CastProgress.player].progressScale)
		CastProgressProgressFrame:SetHeight(20 * CPVar[CastProgress.player].progressScale)

		if CPVar[CastProgress.player].showBar then
			CastProgressBar:SetScale(CPVar[CastProgress.player].barScale)
			CastProgressBarFrame:SetWidth(195 * CPVar[CastProgress.player].barScale)
			CastProgressBarFrame:SetHeight(13 * CPVar[CastProgress.player].barScale)
		end
	end
end

function CastProgress:DoAnchors()
	if CPVar[CastProgress.player]["CastProgressTitleFrame"] then
		local titleFrame = getglobal("CastProgressTitleFrame")
		titleFrame.sticky = CPVar[CastProgress.player]["CastProgressTitleFrame"]
		CastProgress:Anchor(titleFrame)
	end
	if CPVar[CastProgress.player]["CastProgressProgressFrame"] then
		local progressFrame = getglobal("CastProgressProgressFrame")
		progressFrame.sticky = CPVar[CastProgress.player]["CastProgressProgressFrame"]
		CastProgress:Anchor(progressFrame)
	end
	CastProgressTitleText:SetJustifyH(CPVar[CastProgress.player].titleJustify or "CENTER")
	CastProgressProgressText:SetJustifyH(CPVar[CastProgress.player].progressJustify or "CENTER")
end

function CastProgress:DoUIScale()
	if CPVar[CastProgress.player].uiscale then
		CPVar[CastProgress.player].titleScale = nil
		CPVar[CastProgress.player].progressScale = nil
		CPVar[CastProgress.player].barScale = nil
		OptionsFrame_DisableSlider(CastProgressTitleScaleSlider)
		CastProgressSameScaleCheckButton:Disable()
		CastProgressSameScaleCheckButtonText:SetTextColor(0.5, 0.5, 0.5)
	else
		if not CPVar[CastProgress.player].progressScale then
			CPVar[CastProgress.player].progressScale = 1.0
		end
		if not CPVar[CastProgress.player].titleScale then
			CPVar[CastProgress.player].titleScale = 1.0
		end
		if not CPVar[CastProgress.player].barScale then
			CPVar[CastProgress.player].barScale = 1.0
		end
		OptionsFrame_EnableSlider(CastProgressTitleScaleSlider)
		CastProgressSameScaleCheckButton:Enable()
		CastProgressSameScaleCheckButtonText:SetTextColor(1.0, 0.8, 0.0)
		CastProgressTitleScaleSlider:SetValue(CPVar[CastProgress.player].titleScale)
		CastProgressProgressScaleSlider:SetValue(CPVar[CastProgress.player].progressScale)
		CastProgressCastingBarScaleSlider:SetValue(CPVar[CastProgress.player].barScale)
	end

	if not CPVar[CastProgress.player].uiscale and not CPVar[CastProgress.player].sameScale then
		OptionsFrame_EnableSlider(CastProgressProgressScaleSlider)
	else
		OptionsFrame_DisableSlider(CastProgressProgressScaleSlider)
	end

	if CPVar[CastProgress.player].showBar and not CPVar[CastProgress.player].uiscale and not CPVar[CastProgress.player].sameScale then
		OptionsFrame_EnableSlider(CastProgressCastingBarScaleSlider)
	else
		OptionsFrame_DisableSlider(CastProgressCastingBarScaleSlider)
	end

	CastProgress:DoScale()
end

function CastProgress:UIScale()
	CPVar[CastProgress.player].uiscale = this:GetChecked()
	CastProgress:DoUIScale()
end 

function CastProgress:StickyFrames()
	CPVar[CastProgress.player].stickyFrames = this:GetChecked()
end 

function CastProgress:AddonMenu()
	CPVar[CastProgress.player].addonmenu = this:GetChecked()
	if not CPVar[CastProgress.player].addonmenu then
		DEFAULT_CHAT_FRAME:AddMessage(CastProgress.strings.ADDONMENU_DISABLE)
	end
end 

function CastProgress:CastTime()
	CPVar[CastProgress.player].castTime = this:GetChecked()
end 

function CastProgress:SameScale()
	CPVar[CastProgress.player].sameScale = this:GetChecked()
	CastProgress:DoUIScale()
end 

function CastProgress:CastingBar()
	CPVar[CastProgress.player].showBar = this:GetChecked()
	if CPVar[CastProgress.player].showBar then
		CastProgressBarFrame:Show()
		CastProgressBarSpark:SetPoint("CENTER", CastProgressBarFrame, "LEFT", 97, -2)
		CastProgressBarSpark:Show()
		CastProgressBarFrame:Show()
		CastProgressBarFrameDragTab:Show()
	else
		CPVar[CastProgress.player].showBar = nil
		CastProgressBarFrame:Hide()
	end
	CastProgress:DoCastingBar()
	CastProgress:DoUIScale()
end

function CastProgress:ShowTitle()
	CPVar[CastProgress.player].hideTitle = this:GetChecked()
	if CPVar[CastProgress.player].hideTitle then
		CastProgressTitleFrame:SetBackdropColor(0,0,0,0)
		CastProgressTitleFrame:Hide()
	else
		CastProgressTitleFrame:SetBackdropColor(0,0,0,1)
		CastProgressTitleFrame:Show()
	end
	CastProgress:DoUIScale()
end

function CastProgress:ShowProgress()
	CPVar[CastProgress.player].hideProgress = this:GetChecked()
	if CPVar[CastProgress.player].hideProgress then
		CastProgressProgressFrame:SetBackdropColor(0,0,0,0)
		CastProgressProgressFrame:Hide()
	else
		CastProgressProgressFrame:SetBackdropColor(0,0,0,1)
		CastProgressProgressFrame:Show()
	end
	CastProgress:DoUIScale()
end

function CastProgress:InitOptions()
	if CPVar[CastProgress.player].addonmenu then
		AddonMenu:AddMenuItem(CastProgress.strings.OPTIONS, CastProgress.ShowOptions, "Satrina Addons")
	end

	CastProgressOptionsCloseButton:SetText(CLOSE)
	CastProgressHomeButton:SetText("Home")
	CastProgressUIScaleCheckButtonText:SetText(CastProgress.strings.UISCALE)
	CastProgressAddonMenuCheckButtonText:SetText(CastProgress.strings.ADDONMENU)
	CastProgressCastTimeCheckButtonText:SetText(CastProgress.strings.CASTTIME)
	CastProgressProgressCheckButtonText:SetText(CastProgress.strings.PROGRESS)
	CastProgressTitleCheckButtonText:SetText(CastProgress.strings.TITLE)
	CastProgressSameScaleCheckButtonText:SetText(CastProgress.strings.SAMESCALE)
	CastProgressCastingBarCheckButtonText:SetText(CastProgress.strings.CASTBAR)
	CastProgressTitleDragTabLabel:SetText("Drag")
	CastProgressProgressDragTabLabel:SetText("Drag")
	CastProgressBarFrameDragTabLabel:SetText("Drag")
	CastProgressTitleJustifyDropDownLabel:SetText(CastProgress.strings.JUSTIFY)
	CastProgressProgressJustifyDropDownLabel:SetText(CastProgress.strings.PJUSTIFY)
	CastProgressStickyCheckButtonText:SetText(CastProgress.strings.STICKY)
	
	CastProgressTitleScaleSliderText:SetText(CastProgress.strings.TITLESCALE)
	CastProgressTitleScaleSliderLow:SetText("0.5")
	CastProgressTitleScaleSliderHigh:SetText("2.0")
	CastProgressTitleScaleSlider:SetMinMaxValues(0.5, 2.0)
	CastProgressTitleScaleSlider:SetValueStep(0.01)

	CastProgressProgressScaleSliderText:SetText(CastProgress.strings.PROGRESSSCALE)
	CastProgressProgressScaleSliderLow:SetText("0.5")
	CastProgressProgressScaleSliderHigh:SetText("2.0")
	CastProgressProgressScaleSlider:SetMinMaxValues(0.5, 2.0)
	CastProgressProgressScaleSlider:SetValueStep(0.01)
	
	CastProgressCastingBarScaleSliderText:SetText(CastProgress.strings.BARSCALE)
	CastProgressCastingBarScaleSliderLow:SetText("0.5")
	CastProgressCastingBarScaleSliderHigh:SetText("2.0")
	CastProgressCastingBarScaleSlider:SetMinMaxValues(0.5, 2.0)
	CastProgressCastingBarScaleSlider:SetValueStep(0.01)

	CastProgressOpacitySliderText:SetText(CastProgress.strings.OPACITY)
	CastProgressOpacitySliderLow:SetText("0.1")
	CastProgressOpacitySliderHigh:SetText("1.0")
	CastProgressOpacitySlider:SetMinMaxValues(0.1, 1.0)
	CastProgressOpacitySlider:SetValueStep(0.01)
	CastProgressOpacitySlider:SetValue(CPVar[CastProgress.player].opacity)
	OptionsFrame_EnableSlider(CastProgressOpacitySlider)

	CastProgressOptionsVersionString:SetText(string.format("%s%.2f|r", CastProgress.strings.VERSION, CastProgress.version))

	CastProgressUIScaleCheckButton:SetChecked(CPVar[CastProgress.player].uiscale)
	CastProgressAddonMenuCheckButton:SetChecked(CPVar[CastProgress.player].addonmenu)
	CastProgressSameScaleCheckButton:SetChecked(CPVar[CastProgress.player].samescale)
	CastProgressCastTimeCheckButton:SetChecked(CPVar[CastProgress.player].castTime)
	CastProgressCastingBarCheckButton:SetChecked(CPVar[CastProgress.player].showBar)
	CastProgressProgressCheckButton:SetChecked(CPVar[CastProgress.player].hideProgress)
	CastProgressTitleCheckButton:SetChecked(CPVar[CastProgress.player].hideTitle)
	CastProgressStickyCheckButton:SetChecked(CPVar[CastProgress.player].stickyFrames)
	
	if not CPVar[CastProgress.player].uiscale then
		CastProgressProgressScaleSlider:SetValue(CPVar[CastProgress.player].progressScale)
		CastProgressTitleScaleSlider:SetValue(CPVar[CastProgress.player].titleScale)
		CastProgressCastingBarScaleSlider:SetValue(CPVar[CastProgress.player].barScale)
	end

	CastProgressProgressFrame.tab = CastProgressProgressDragTabLabel
	CastProgressTitleFrame.tab = CastProgressTitleDragTabLabel
	UIDropDownMenu_Initialize(CastProgressTitleJustifyDropDown, CastProgress.InitTitleJustifyDropDown)
	UIDropDownMenu_Initialize(CastProgressProgressJustifyDropDown, CastProgress.InitProgressJustifyDropDown)
end

function CastProgress:ShowOptions()
	CastProgressOptions:Show()
	CastProgressTitleText:SetText(CastProgress.strings.VERSION..string.format("%.2f|r", CastProgress.version).."|r")
	CastProgressProgressText:SetText("[ | ]")
	CastProgress.optionsShown = 1
	CastProgress.optionsElapsed = 0
	if not CPVar[CastProgress.player].hideProgress then
		CastProgressProgressFrame:SetBackdropColor(0,0,0,1)
		CastProgressProgressFrame:Show()
	end
	if not CPVar[CastProgress.player].hideTitle then
		CastProgressTitleFrame:SetBackdropColor(0,0,0,1)
		CastProgressTitleFrame:Show()
	end
	CastProgressBarFrame.fadeOut = nil
	CastProgressTitleDragTab:Show()
	CastProgressProgressDragTab:Show()
	if CPVar[CastProgress.player].showBar then
		CastProgressBarFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		if CT_CastBarFrame then
			CT_LockMovables(1)
		end
		CastProgressBarFrame:Show()
		CastProgressBarSpark:SetPoint("CENTER", CastProgressBarFrame, "LEFT", 97, -2)
		CastProgressBarSpark:Show()
		CastProgressBarFrame:Show()
		CastProgressBarFrameDragTab:Show()
	end
end

function CastProgress:CloseOptions()
	CastProgressOptions:Hide()
	CastProgressTitleDragTab:Hide()
	CastProgressProgressDragTab:Hide()
	CastProgressBarFrameDragTab:Hide()
	CastProgress.optionsShown = nil
	CastProgressProgressFrame:SetBackdropColor(0,0,0,0)
	CastProgressTitleFrame:SetBackdropColor(0,0,0,0)
	CastProgress.fadeOut = 1
	CastProgressBarFrame.fadeOut = 1
	if CT_CastBarFrame then
		CT_LockMovables(nil)
	end
end

function CastProgress:OnOptionsUpdate(elapsed)
	if (CastProgress.optionsElapsed > 0.25) then
		CastProgress.optionsElapsed = 0

		-- Scaling
		if not CPVar[CastProgress.player].uiscale then
			if (CPVar[CastProgress.player].titleScale ~= CastProgressTitleScaleSlider:GetValue()) then
				CPVar[CastProgress.player].titleScale = CastProgressTitleScaleSlider:GetValue()
				if CPVar[CastProgress.player].sameScale then
					CPVar[CastProgress.player].progressScale = CastProgressTitleScaleSlider:GetValue()
					CPVar[CastProgress.player].barScale = CastProgressTitleScaleSlider:GetValue()
				end
				CastProgress:DoScale()
			end

			if not CPVar[CastProgress.player].sameScale and (CPVar[CastProgress.player].progressScale ~= CastProgressProgressScaleSlider:GetValue()) then
				CPVar[CastProgress.player].progressScale = CastProgressProgressScaleSlider:GetValue()
				CastProgress:DoScale()
			end

			if not CPVar[CastProgress.player].sameScale and (CPVar[CastProgress.player].barScale ~= CastProgressCastingBarScaleSlider:GetValue()) then
				CPVar[CastProgress.player].barScale = CastProgressCastingBarScaleSlider:GetValue()
				CastProgress:DoScale()
			end
		end
		
		-- Opacity
		if (CPVar[CastProgress.player].opacity ~= CastProgressOpacitySlider:GetValue()) then
			CPVar[CastProgress.player].opacity = CastProgressOpacitySlider:GetValue()
			CastProgressProgress:SetAlpha(CPVar[CastProgress.player].opacity)
			CastProgressTitleFrame:SetAlpha(CPVar[CastProgress.player].opacity)
			CastProgressBarFrame:SetAlpha(CPVar[CastProgress.player].opacity)
		end

		if CastProgress.moving and CPVar[CastProgress.player].stickyFrames then
			-- Snap frames together
			local rc = 1
			if (CastProgress.moving == CastProgressProgressFrame) and not CPVar[CastProgress.player].hideTitle then
				rc = CastProgress:CheckCollision(CastProgressProgressFrame, CastProgressTitleFrame)
			end
	
			if rc and (CastProgress.moving == CastProgressProgressFrame) and CPVar[CastProgress.player].showBar then
				rc = CastProgress:CheckCollision(CastProgressProgressFrame, CastProgressBarFrame)
			end
			
			if rc and (CastProgress.moving == CastProgressTitleFrame) and CPVar[CastProgress.player].showBar then
				CastProgress:CheckCollision(CastProgressTitleFrame, CastProgressBarFrame)
			end
		end
	
	else
		CastProgress.optionsElapsed = CastProgress.optionsElapsed + elapsed
	end
end

function CastProgress.InitTitleJustifyDropDown()
	for i,t in {"LEFT","CENTER","RIGHT"} do
		info = {}
		info.text = t
		info.value = t
		info.func = CastProgress.TitleJustifyClick
		if (t == CastProgressTitleText:GetJustifyH()) then
			info.checked = true
			CastProgressTitleJustifyDropDownText:SetText(t)
		end
		UIDropDownMenu_AddButton(info)
	end
end

function CastProgress.TitleJustifyClick()
	UIDropDownMenu_SetSelectedID(CastProgressTitleJustifyDropDown, this:GetID(), 1)
	CastProgressTitleText:SetJustifyH(this.value)
	CPVar[CastProgress.player].titleJustify = this.value
end

function CastProgress.InitProgressJustifyDropDown()
	for i,t in {"LEFT","CENTER","RIGHT"} do
		info = {}
		info.text = t
		info.value = t
		info.func = CastProgress.ProgressJustifyClick
		if (t == CastProgressProgressText:GetJustifyH()) then
			info.checked = true
			CastProgressProgressJustifyDropDownText:SetText(t)
		end
		UIDropDownMenu_AddButton(info)
	end
end

function CastProgress.ProgressJustifyClick()
	UIDropDownMenu_SetSelectedID(CastProgressProgressJustifyDropDown, this:GetID(), 1)
	CastProgressProgressText:SetJustifyH(this.value)
	CPVar[CastProgress.player].progressJustify = this.value
end

function CastProgress:CheckSavedVars()
	-- Clean up any lingering deprecated saved bits
	if CPVar[CastProgress.player].version then
		CPVar[CastProgress.player].version = nil
	end
	if CPVar[CastProgress.player].scale then
		CPVar[CastProgress.player].scale = nil
	end
	if CPVar[CastProgress.player].locked then
		CPVar[CastProgress.player].locked = nil
	end
end

-- Yeah, this could be done much more elegantly.  Sue me.
function CastProgress:CheckCollision(f1,f2)

	if not f1 or not f2 then
		return
	end
	
	scaleMult = f2:GetEffectiveScale()/f1:GetEffectiveScale()
	scaleMult = 1
	
	f1.bottom = f1:GetBottom() * scaleMult
	f1.top = f1:GetTop() * scaleMult
	f1.left = f1:GetLeft() * scaleMult
	f1.right = f1:GetRight() * scaleMult
	f1.middle = (f1.left + f1.right ) / 2 * scaleMult
	f1.vmiddle = (f1.top + f1.bottom) / 2 * scaleMult

	f2.bottom = f2:GetBottom()
	f2.top = f2:GetTop()
	f2.left = f2:GetLeft()
	f2.right = f2:GetRight()
	f2.middle = (f2.left + f2.right ) / 2
	f2.vmiddle = (f2.top + f2.bottom) / 2

	local stickyRange = 10
	
	if (f1.top <= f2.bottom + stickyRange) and (f1.top >= f2.bottom - stickyRange) then
		if (f1.middle <= f2.middle + stickyRange) and (f1.middle >= f2.middle - stickyRange) then
			f1.tab:SetTextColor(1,0,0)
			f1.sticky = {"TOP", f2:GetName(), "BOTTOM"}
		elseif (f1.left >= f2.left - stickyRange) and (f1.left <= f2.left + stickyRange) then
			f1.tab:SetTextColor(1,0,0)
			f1.sticky = {"TOPLEFT", f2:GetName(), "BOTTOMLEFT"}
		elseif (f1.right >= f2.right - stickyRange) and (f1.right <= f2.right + stickyRange) then
			f1.tab:SetTextColor(1,0,0)
			f1.sticky = {"TOPRIGHT", f2:GetName(), "BOTTOMRIGHT"}
		else
			f1.tab:SetTextColor(1,1,1)
			f1.sticky = nil
		end
	elseif (f1.bottom <= f2.top + stickyRange) and (f1.bottom >= f2.top - stickyRange) then
		if (f1.middle <= f2.middle + stickyRange) and (f1.middle >= f2.middle - stickyRange) then
			f1.tab:SetTextColor(1,0,1)
			f1.sticky = {"BOTTOM", f2:GetName(), "TOP"}
		elseif (f1.left >= f2.left - stickyRange) and (f1.left <= f2.left + stickyRange) then
			f1.tab:SetTextColor(1,0,1)
			f1.sticky = {"BOTTOMLEFT", f2:GetName(), "TOPLEFT"}
		elseif (f1.right >= f2.right - stickyRange) and (f1.right <= f2.right + stickyRange) then
			f1.tab:SetTextColor(1,0,1)
			f1.sticky = {"BOTTOMRIGHT", f2:GetName(), "TOPRIGHT"}
		else
			f1.tab:SetTextColor(1,1,1)
			f1.sticky = nil
		end
	elseif (f1.vmiddle >= f2.vmiddle - (stickyRange/2)) and (f1.vmiddle <= f2.vmiddle + stickyRange) then
		if (f1.right >= f2.right - stickyRange) and (f1.right <= f2.right + stickyRange) then
			f1.tab:SetTextColor(0,1,0)
			f1.sticky = {"RIGHT", f2:GetName(), "RIGHT"}
		elseif (f1.left >= f2.left - stickyRange) and (f1.left <= f2.left + stickyRange) then
			f1.tab:SetTextColor(0,1,0)
			f1.sticky = {"LEFT", f2:GetName(), "LEFT"}
		elseif (f1.right >= f2.left - stickyRange) and (f1.right <= f2.left + stickyRange) then
			f1.tab:SetTextColor(0,1,0)
			f1.sticky = {"RIGHT", f2:GetName(), "LEFT"}
		elseif (f1.left >= f2.right - stickyRange) and (f1.left <= f2.right + stickyRange) then
			f1.tab:SetTextColor(0,1,0)
			f1.sticky = {"LEFT", f2:GetName(), "RIGHT"}
		elseif (f1.middle <= f2.middle + stickyRange) and (f1.middle >= f2.middle - stickyRange) then
			f1.tab:SetTextColor(0,1,0)
			f1.sticky = {"CENTER", f2:GetName(), "CENTER"}
		else
			f1.tab:SetTextColor(1,1,1)
			f1.sticky = nil
			return 1
		end
	else
		f1.tab:SetTextColor(1,1,1)
		f1.sticky = nil
		return 1
	end
end

function CastProgress:Anchor(frame)
	if frame.sticky then
		-- Figure out if we need any offsets
		local x = 0
		local y = 0
		if (frame.sticky[2] == "CastProgressBarFrame") then
			x = (string.find(frame.sticky[1], "LEFT") and 4) or (string.find(frame.sticky[1], "RIGHT") and -4) or 0
		end

		if (frame.sticky[1] == frame.sticky[3]) then
			x = (string.find(frame.sticky[1], "LEFT") and 4) or (string.find(frame.sticky[1], "RIGHT") and -4) or 0
		end

		frame:ClearAllPoints()
		frame:SetPoint(frame.sticky[1], frame.sticky[2], frame.sticky[3], x, y)
	end
end

function CastProgress:MouseUp()
		local f = this:GetParent()
		f:StopMovingOrSizing()
		CastProgress:Anchor(f)
		CastProgress.moving = nil
		local name = f:GetName()
			if f.sticky then
			CPVar[CastProgress.player][name] = f.sticky
		else
			CPVar[CastProgress.player][name] = nil
		end
end
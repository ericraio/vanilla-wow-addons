--
-- Option handlers for Satrina Buff Frames
--
function SatrinaBuffFrame_InitOptions()
	if SBFVar[SATBUFF.player].addonmenu then
		AddonMenu:AddMenuItem(SBF_MENU, SatrinaBuffFrame_ShowOptions, "Satrina Addons")
	end

	SatrinaBuffFrameOptionsCloseButton:SetText(CLOSE)
	SatrinaBuffFrameHomeButton:SetText(SBF_HOME)
	SatrinaBuffFrame_SetTextSlider("Buff")
	SatrinaBuffFrame_SetTextSlider("Debuff")
	SatrinaBuffFrame_SetTextSlider("Enchant")
	SatrinaBuffFrame_SetSpacingSlider("Buff")
	SatrinaBuffFrame_SetSpacingSlider("Debuff")
	SatrinaBuffFrame_SetEnchantSpacingSlider()
	SatrinaBuffFrame_SetScaleSlider("Buff", SBF_BUFF_SCALE)
	SatrinaBuffFrame_SetScaleSlider("Debuff", SBF_DEBUFF_SCALE)
	SatrinaBuffFrame_SetScaleSlider("Enchant", SBF_ENCHANT_SCALE)
	SatrinaBuffFrame_SetOpacitySlider("Buff", SBF_BUFF_OPACITY)
	SatrinaBuffFrame_SetOpacitySlider("Debuff", SBF_DEBUFF_OPACITY)
	SatrinaBuffFrame_SetOpacitySlider("Enchant", SBF_ENCHANT_OPACITY)

	OptionsFrame_EnableSlider(SatrinaBuffCountSlider)
	if SBFVar[SATBUFF.player].buffHorizontal then
		SatrinaBuffCountSliderText:SetText(SBF_BUFFROWS)
	else
		SatrinaBuffCountSliderText:SetText(SBF_BUFFCOLUMNS)
	end
	SatrinaBuffCountSliderLow:SetText("1")
	SatrinaBuffCountSliderHigh:SetText("10")
	SatrinaBuffCountSlider:SetMinMaxValues(1, 10)
	SatrinaBuffCountSlider:SetValueStep(1)
	SatrinaBuffCountSlider:SetValue(SBFVar[SATBUFF.player].count["Buff"])

	OptionsFrame_EnableSlider(SatrinaDebuffCountSlider)
	if SBFVar[SATBUFF.player].debuffHorizontal then
		SatrinaDebuffCountSliderText:SetText(SBF_DEBUFFROWS)
	else
		SatrinaDebuffCountSliderText:SetText(SBF_DEBUFFCOLUMNS)
	end
	SatrinaDebuffCountSliderLow:SetText("1")
	SatrinaDebuffCountSliderHigh:SetText("10")
	SatrinaDebuffCountSlider:SetMinMaxValues(1, 10)
	SatrinaDebuffCountSlider:SetValueStep(1)
	SatrinaDebuffCountSlider:SetValue(SBFVar[SATBUFF.player].count["Debuff"])

	SatrinaBuffFrameOptionsVersionString:SetText(string.format("%s%.2f|r", SBF_VERSION, SatBuff_Version))
	SatrinaBuffFrameUIScaleCheckButton:SetChecked(SBFVar[SATBUFF.player].uiscale)
	SatrinaBuffHorizontalCheckButton:SetChecked(SBFVar[SATBUFF.player].buffHorizontal)
	SatrinaDebuffHorizontalCheckButton:SetChecked(SBFVar[SATBUFF.player].debuffHorizontal)
	SatrinaBuffTimerStyleButton:SetChecked(SBFVar[SATBUFF.player].blizzardTimers)
	SatrinaBuffReverseCheckButton:SetChecked(SBFVar[SATBUFF.player].reverseBuffs)
	SatrinaDebuffReverseCheckButton:SetChecked(SBFVar[SATBUFF.player].reverseDebuffs)
	SatrinaBuffFrameVerticalEnchantCheckButton:SetChecked(SBFVar[SATBUFF.player].verticalEnchants)
	SatrinaBuffFrameSixteenBuffsCheckButton:SetChecked(SBFVar[SATBUFF.player].sixteenBuffs)
	SatrinaDebuffBottomCheckButton:SetChecked(SBFVar[SATBUFF.player].bottomDebuffs)
	SatrinaBuffBottomCheckButton:SetChecked(SBFVar[SATBUFF.player].bottomBuffs)
	
	SatrinaBuffFrameUIScaleCheckButtonText:SetText(SBF_UISCALE)
	SatrinaBuffHorizontalCheckButtonText:SetText(SBF_BUFFHORIZONTAL)
	SatrinaDebuffHorizontalCheckButtonText:SetText(SBF_DEBUFFHORIZONTAL)
	SatrinaBuffReverseCheckButtonText:SetText(SBF_REVERSEBUFF)
	SatrinaDebuffReverseCheckButtonText:SetText(SBF_REVERSEDEBUFF)
	SatrinaBuffTimerStyleButtonText:SetText(SBF_BLIZZARDTIMERS)
	SatrinaBuffFrameSoundWarningDropDownLabel:SetText(SBF_WARNSOUND)
	SatrinaBuffFrameLongBuffDropDownLabel:SetText(SBF_MINTIME)
	SatrinaBuffFrameAddonMenuCheckButtonText:SetText(SBF_ADDONMENU)
	SatrinaBuffFrameSixteenBuffsCheckButtonText:SetText(SBF_SIXTEENBUFFS)
	SatrinaDebuffBottomCheckButtonText:SetText(SBF_BOTTOM)
	SatrinaBuffBottomCheckButtonText:SetText(SBF_BOTTOM)

	SatrinaBuffFrameAddonMenuCheckButton:SetChecked(SBFVar[SATBUFF.player].addonmenu)
	SatrinaBuffFrameTextWarningCheckButton:SetChecked(SBFVar[SATBUFF.player].textWarning)
	SatrinaBuffFrameSoundWarningCheckButton:SetChecked(SBFVar[SATBUFF.player].soundWarning)
	SatrinaBuffFrameLongBuffCheckButton:SetChecked(SBFVar[SATBUFF.player].longBuff)
	SatrinaBuffFrameTextWarningCheckButtonText:SetText(SBF_EXPIREWARN)
	SatrinaBuffFrameSoundWarningCheckButtonText:SetText(SBF_EXPIRESOUND)
	SatrinaBuffFrameLongBuffCheckButtonText:SetText(SBF_LONGBUFF)
	SatrinaBuffFrameVerticalEnchantCheckButtonText:SetText(SBF_VERTICALENCHANTS)
	
	SatrinaBuffFrameDragTabLabel:SetText("Buffs")
	SatrinaDebuffFrameDragTabLabel:SetText("Debuffs")
	SatrinaEnchantFrameDragTabLabel:SetText("Enchants")
	
	SATBUFF.sounds = {
		"Sound\\Spells\\AntiHoly.wav",
		"Sound\\interface\\iTellMessage.wav",
		"Sound\\interface\\AuctionWindowOpen.wav",
		"Sound\\interface\\FriendJoin.wav",
		"Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
	}

	UIDropDownMenu_Initialize(SatrinaBuffFrameLongBuffDropDown, SatrinaBuffFrame_LongBuffDropDown_Initialise)
	UIDropDownMenu_Initialize(SatrinaBuffFrameSoundWarningDropDown, SatrinaBuffFrame_SoundWarningDropDown_Initialise)
	SatrinaBuffFrame_DropDown(SBFVar[SATBUFF.player].soundWarning, SatrinaBuffFrameSoundWarningDropDown)
	SatrinaBuffFrame_DropDown(SBFVar[SATBUFF.player].longBuff, SatrinaBuffFrameLongBuffDropDown)
end

function SatrinaBuffFrame_SetScaleSlider(frame, title)
	slider = getglobal("Satrina"..frame.."ScaleSlider")
	OptionsFrame_EnableSlider(slider)
	getglobal(slider:GetName().."Text"):SetText(title)
	getglobal(slider:GetName().."Low"):SetText("0.5")
	getglobal(slider:GetName().."High"):SetText("2.0")
	slider:SetMinMaxValues(0.5, 2.0)
	slider:SetValueStep(0.05)
	slider:SetValue(SBFVar[SATBUFF.player].iconScale[frame])
end

function SatrinaBuffFrame_SetTextSlider(frame)
	slider = getglobal("Satrina"..frame.."TextSlider")
	OptionsFrame_EnableSlider(slider)
	getglobal(slider:GetName().."Text"):SetText(SBF_TEXT_SCALE)
	getglobal(slider:GetName().."Low"):SetText("0.5")
	getglobal(slider:GetName().."High"):SetText("2.0")
	slider:SetMinMaxValues(0.5, 2.0)
	slider:SetValueStep(0.05)
	slider:SetValue(SBFVar[SATBUFF.player].textScale[frame])
end

function SatrinaBuffFrame_SetSpacingSlider(frame)
	slider = getglobal("Satrina"..frame.."SpacingSlider")
	OptionsFrame_EnableSlider(slider)
	getglobal(slider:GetName().."Text"):SetText(SBF_SPACING)
	getglobal(slider:GetName().."Low"):SetText("-10")
	getglobal(slider:GetName().."High"):SetText("10")
	slider:SetMinMaxValues(-10, 10)
	slider:SetValueStep(1)
	slider:SetValue(SBFVar[SATBUFF.player].spacing[frame])
end

function SatrinaBuffFrame_SetEnchantSpacingSlider()
	OptionsFrame_EnableSlider(SatrinaEnchantSpacingSlider)
	SatrinaEnchantSpacingSliderText:SetText(SBF_SPACING)
	if SBFVar[SATBUFF.player].verticalEnchants then
		SatrinaEnchantSpacingSliderLow:SetText("-10")
		SatrinaEnchantSpacingSliderHigh:SetText("100")
		SatrinaEnchantSpacingSlider:SetMinMaxValues(-10, 100)
		if (SBFVar[SATBUFF.player].spacing["Enchant"] < -10) then
			SBFVar[SATBUFF.player].spacing["Enchant"] = -10
		end
	else
		SatrinaEnchantSpacingSliderLow:SetText("-100")
		SatrinaEnchantSpacingSliderHigh:SetText("10")
		SatrinaEnchantSpacingSlider:SetMinMaxValues(-100, 10)
		if (SBFVar[SATBUFF.player].spacing["Enchant"] > 10) then
			SBFVar[SATBUFF.player].spacing["Enchant"] = 10
		end
	end
	SatrinaEnchantSpacingSlider:SetValueStep(1)
	SatrinaEnchantSpacingSlider:SetValue(SBFVar[SATBUFF.player].spacing["Enchant"])
end

function SatrinaBuffFrame_SetOpacitySlider(frame, title)
	slider = getglobal("Satrina"..frame.."OpacitySlider")
	OptionsFrame_EnableSlider(slider)
	getglobal(slider:GetName().."Text"):SetText(title)
	getglobal(slider:GetName().."Low"):SetText("0.1")
	getglobal(slider:GetName().."High"):SetText("1.0")
	slider:SetMinMaxValues(0.1, 1.0)
	slider:SetValueStep(0.1)
	slider:SetValue(SBFVar[SATBUFF.player].opacity[frame])
end

function SatrinaBuffFrame_ShowOptions()
	SatrinaBuffFrameDragTab:Show()
	SatrinaDebuffFrameDragTab:Show()
	SatrinaEnchantFrameDragTab:Show()

	SATBUFF.showingOptions = 1
	SatrinaBuffFrameOptions:Show()
	SatrinaBuffFrame_OptionIcons()
end

function SatrinaBuffFrame_OptionIcons()
	buffCount = (SBFVar[SATBUFF.player].sixteenBuffs and 16) or 20
	for i=1,20do
		button = getglobal("SatrinaBuffButton"..i)
		if (i <= buffCount) then
			button.icon:SetTexture("Spells\\GENERICGLOW64")
			button:Show()
			button.durationText:Show()
			if SBFVar[SATBUFF.player].blizzardTimers then
				button.durationText:SetText(i.."m")
			else
				button.durationText:SetText(i..":00")
			end
			
			if (i < 17) then
				button = getglobal("SatrinaDebuffButton"..i)
				button.icon:SetTexture("Spells\\GENERICGLOW64")
				button:Show()
				button.durationText:Show()
				if SBFVar[SATBUFF.player].blizzardTimers then
					button.durationText:SetText(i.."m")
				else
					button.durationText:SetText(i..":00")
				end
			end
		else
			button:Hide()			
		end
	end

	SatrinaEnchant1.icon:SetTexture("Spells\\GenericGlow2_64_BLUE")
	SatrinaEnchant1:Show()
	if SBFVar[SATBUFF.player].blizzardTimers then
		SatrinaEnchant1.durationText:SetText("31m")
	else
		SatrinaEnchant1.durationText:SetText("31:00")
	end
	SatrinaEnchant2.icon:SetTexture("Spells\\GenericGlow2_64_BLUE")
	SatrinaEnchant2:Show()
	if SBFVar[SATBUFF.player].blizzardTimers then
		SatrinaEnchant2.durationText:SetText("32m")
	else
		SatrinaEnchant2.durationText:SetText("32:00")
	end
end

function SatrinaBuffFrame_CloseOptions()
	SatrinaBuffFrameOptions:Hide()
	for i=1,20 do
		SatrinaBuffFrame_BuffButton_Update(getglobal("SatrinaBuffButton"..i))
		if (i < 17) then
			SatrinaBuffFrame_BuffButton_Update(getglobal("SatrinaDebuffButton"..i))
		end
	end
	SATBUFF.showingOptions = nil
	SatrinaBuffFrameDragTab:Hide()
	SatrinaDebuffFrameDragTab:Hide()
	SatrinaEnchantFrameDragTab:Hide()
end

local SBF_optionsElapsed = 0
function SatrinaBuffFrame_OnOptionsUpdate(elapsed)
	if (SBF_optionsElapsed > 0.1) then
		SBF_optionsElapsed = 0

		-- Scaling
		if not SBFVar[SATBUFF.player].uiscale then
			if (SBFVar[SATBUFF.player].iconScale["Buff"] ~= SatrinaBuffScaleSlider:GetValue()) then
				SBFVar[SATBUFF.player].iconScale["Buff"] = SatrinaBuffScaleSlider:GetValue()
				SatrinaBuffFrame_ScaleBuffs()
			end

			if (SBFVar[SATBUFF.player].iconScale["Debuff"] ~= SatrinaDebuffScaleSlider:GetValue()) then
				SBFVar[SATBUFF.player].iconScale["Debuff"] = SatrinaDebuffScaleSlider:GetValue()
				SatrinaBuffFrame_ScaleBuffs()
			end
	
			if (SBFVar[SATBUFF.player].iconScale["Enchant"] ~= SatrinaEnchantScaleSlider:GetValue()) then
				SBFVar[SATBUFF.player].iconScale["Enchant"] = SatrinaEnchantScaleSlider:GetValue()
				SatrinaBuffFrame_ScaleBuffs()
			end
		end
		
		-- Text
		if (SBFVar[SATBUFF.player].textScale["Buff"] ~= SatrinaBuffTextSlider:GetValue()) then
			SBFVar[SATBUFF.player].textScale["Buff"] = SatrinaBuffTextSlider:GetValue()
			SatrinaBuffFrame_ScaleBuffs()
		end

		if (SBFVar[SATBUFF.player].textScale["Debuff"] ~= SatrinaDebuffTextSlider:GetValue()) then
			SBFVar[SATBUFF.player].textScale["Debuff"] = SatrinaDebuffTextSlider:GetValue()
			SatrinaBuffFrame_ScaleBuffs()
		end

		if (SBFVar[SATBUFF.player].textScale["Enchant"] ~= SatrinaEnchantTextSlider:GetValue()) then
			SBFVar[SATBUFF.player].textScale["Enchant"] = SatrinaEnchantTextSlider:GetValue()
			SatrinaBuffFrame_ScaleBuffs()
		end

		-- Opacity
		if (SBFVar[SATBUFF.player].opacity["Buff"] ~= SatrinaBuffOpacitySlider:GetValue()) then
			SBFVar[SATBUFF.player].opacity["Buff"] = SatrinaBuffOpacitySlider:GetValue()
			SatrinaBuffFrame:SetAlpha(SBFVar[SATBUFF.player].opacity["Buff"])
		end

		if (SBFVar[SATBUFF.player].opacity["Debuff"] ~= SatrinaDebuffOpacitySlider:GetValue()) then
			SBFVar[SATBUFF.player].opacity["Debuff"] = SatrinaDebuffOpacitySlider:GetValue()
			SatrinaDebuffFrame:SetAlpha(SBFVar[SATBUFF.player].opacity["Debuff"])
		end

		if (SBFVar[SATBUFF.player].opacity["Enchant"] ~= SatrinaEnchantOpacitySlider:GetValue()) then
			SBFVar[SATBUFF.player].opacity["Enchant"] = SatrinaEnchantOpacitySlider:GetValue()
			SatrinaEnchantFrame:SetAlpha(SBFVar[SATBUFF.player].opacity["Enchant"])
		end
		
		-- Spacing
		if (SBFVar[SATBUFF.player].spacing["Buff"] ~= SatrinaBuffSpacingSlider:GetValue()) then
			SBFVar[SATBUFF.player].spacing["Buff"] = SatrinaBuffSpacingSlider:GetValue()
			SatrinaBuffFrame_ArrangeIcons("SatrinaBuffFrame")
		end

		if (SBFVar[SATBUFF.player].spacing["Debuff"] ~= SatrinaDebuffSpacingSlider:GetValue()) then
			SBFVar[SATBUFF.player].spacing["Debuff"] = SatrinaDebuffSpacingSlider:GetValue()
			SatrinaBuffFrame_ArrangeIcons("SatrinaDebuffFrame")
		end

		if (SBFVar[SATBUFF.player].spacing["Enchant"] ~= SatrinaEnchantSpacingSlider:GetValue()) then
			SBFVar[SATBUFF.player].spacing["Enchant"] = SatrinaEnchantSpacingSlider:GetValue()
			SatrinaBuffFrame_ArrangeEnchantIcons()
		end

		-- Icon Counts
		if (SBFVar[SATBUFF.player].count["Buff"] ~= SatrinaBuffCountSlider:GetValue()) then
			SBFVar[SATBUFF.player].count["Buff"] = SatrinaBuffCountSlider:GetValue()
			SatrinaBuffFrame_ArrangeIcons("SatrinaBuffFrame")
		end

		if (SBFVar[SATBUFF.player].count["Debuff"] ~= SatrinaDebuffCountSlider:GetValue()) then
			SBFVar[SATBUFF.player].count["Debuff"] = SatrinaDebuffCountSlider:GetValue()
			SatrinaBuffFrame_ArrangeIcons("SatrinaDebuffFrame")
		end

	else
		SBF_optionsElapsed = SBF_optionsElapsed + elapsed
	end
end

function SatrinaBuffFrame_SixteenBuffs()
	SBFVar[SATBUFF.player].sixteenBuffs = this:GetChecked()
	SatrinaBuffFrame_OptionIcons()
	SatrinaBuffFrame_ArrangeEnchantIcons()
end 

function SatrinaBuffFrame_VerticalEnchants()
	SBFVar[SATBUFF.player].verticalEnchants = this:GetChecked()
	SatrinaBuffFrame_SetEnchantSpacingSlider()
	SatrinaBuffFrame_ArrangeEnchantIcons()
end 

function SatrinaBuffFrame_UIScale()
	SBFVar[SATBUFF.player].uiscale = this:GetChecked()
	SatrinaBuffFrame_DoUIScale()
end 

function SatrinaBuffFrame_BuffHorizontal()
	SBFVar[SATBUFF.player].buffHorizontal = this:GetChecked()
	if SBFVar[SATBUFF.player].buffHorizontal then
		SatrinaBuffCountSliderText:SetText(SBF_BUFFROWS)
	else
		SatrinaBuffCountSliderText:SetText(SBF_BUFFCOLUMNS)
	end
	SatrinaBuffFrame_ArrangeIcons("SatrinaBuffFrame")
end

function SatrinaBuffFrame_DebuffHorizontal()
	SBFVar[SATBUFF.player].debuffHorizontal = this:GetChecked()
	if SBFVar[SATBUFF.player].debuffHorizontal then
		SatrinaDebuffCountSliderText:SetText(SBF_DEBUFFROWS)
	else
		SatrinaDebuffCountSliderText:SetText(SBF_DEBUFFCOLUMNS)
	end
	SatrinaBuffFrame_ArrangeIcons("SatrinaDebuffFrame")
end

function SatrinaBuffFrame_TimerStyle()
	SBFVar[SATBUFF.player].blizzardTimers = this:GetChecked()
	SatrinaBuffFrame_OptionIcons()
end

function SatrinaBuffFrame_ReverseBuffs()
	SBFVar[SATBUFF.player].reverseBuffs = this:GetChecked()
	SatrinaBuffFrame_ArrangeIcons("SatrinaBuffFrame")
end

function SatrinaBuffFrame_ReverseDebuffs()
	SBFVar[SATBUFF.player].reverseDebuffs = this:GetChecked()
	SatrinaBuffFrame_ArrangeIcons("SatrinaDebuffFrame")
end

function SatrinaBuffFrame_BottomBuffs()
	SBFVar[SATBUFF.player].bottomBuffs = this:GetChecked()
	SatrinaBuffFrame_ArrangeIcons("SatrinaBuffFrame")
end

function SatrinaBuffFrame_BottomDebuffs()
	SBFVar[SATBUFF.player].bottomDebuffs = this:GetChecked()
	SatrinaBuffFrame_ArrangeIcons("SatrinaDebuffFrame")
end

function SatrinaBuffFrame_TextWarning()
	SBFVar[SATBUFF.player].textWarning = this:GetChecked()
end

function SatrinaBuffFrame_SoundWarning()
	SBFVar[SATBUFF.player].soundWarning = this:GetChecked()
	SatrinaBuffFrame_DropDown(SBFVar[SATBUFF.player].soundWarning, SatrinaBuffFrameSoundWarningDropDown)
end

function SatrinaBuffFrame_LongBuff()
	SBFVar[SATBUFF.player].longBuff = this:GetChecked()
	SatrinaBuffFrame_DropDown(SBFVar[SATBUFF.player].longBuff, SatrinaBuffFrameLongBuffDropDown)
end

function SatrinaBuffFrame_AddonMenu()
	SBFVar[SATBUFF.player].addonmenu = this:GetChecked()
	if not SBFVar[SATBUFF.player].addonmenu then
		DEFAULT_CHAT_FRAME:AddMessage(SBF_ADDONMENU_DISABLE)
	end
end 

function SatrinaBuffFrame_SoundWarningDropDown_Initialise()
	for i=1,5 do
		info = {}
		info.text = i
		info.value = i
		info.func = SatrinaBuffFrame_SoundWarningDropDown_OnClick
		if (SBFVar[SATBUFF.player].sound == i) then
			info.checked = true
			UIDropDownMenu_SetText(i, SatrinaBuffFrameSoundWarningDropDown)
		end
		UIDropDownMenu_AddButton(info)
	end
end

function SatrinaBuffFrame_SoundWarningDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(SatrinaBuffFrameSoundWarningDropDown, this:GetID(), 1)
	SBFVar[SATBUFF.player].sound = this:GetID()
	PlaySoundFile(SATBUFF.sounds[this:GetID()])
end

function SatrinaBuffFrame_LongBuffDropDown_Initialise()
	for i,t in {3,5,10,20,30} do
		info = {}
		info.text = t
		info.value = t
		info.func = SatrinaBuffFrame_LongBuffDropDown_OnClick
		if (SBFVar[SATBUFF.player].warnTime == t) then
			info.checked = true
			SatrinaBuffFrameLongBuffDropDownText:SetText(t)
		end
		UIDropDownMenu_AddButton(info)
	end
end

function SatrinaBuffFrame_LongBuffDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(SatrinaBuffFrameLongBuffDropDown, this:GetID(), 1)
	SBFVar[SATBUFF.player].warnTime = this.value
end

function SatrinaBuffFrame_DropDown(flag, frame)
	if flag then
		OptionsFrame_EnableDropDown(frame)
	else
		OptionsFrame_DisableDropDown(frame)
	end
end

function SatrinaBuffFrame_DoSavedVars()
	default = 1.0
	
	if not SBFVar[SATBUFF.player].iconScale then
		SBFVar[SATBUFF.player].iconScale = {}
		SBFVar[SATBUFF.player].iconScale["Buff"] = default
		SBFVar[SATBUFF.player].iconScale["Debuff"] = default
		SBFVar[SATBUFF.player].iconScale["Enchant"] = default
	end
	
	if not SBFVar[SATBUFF.player].textScale then
		SBFVar[SATBUFF.player].textScale = {}
		SBFVar[SATBUFF.player].textScale["Buff"] = default
		SBFVar[SATBUFF.player].textScale["Debuff"] = default
		SBFVar[SATBUFF.player].textScale["Enchant"] = default
	end

	if not SBFVar[SATBUFF.player].spacing then
		SBFVar[SATBUFF.player].spacing = {}
		SBFVar[SATBUFF.player].spacing["Buff"] = 0
		SBFVar[SATBUFF.player].spacing["Debuff"] = 0
		SBFVar[SATBUFF.player].spacing["Enchant"] = 0
	end

	if not SBFVar[SATBUFF.player].spacing["Enchant"] then
		SBFVar[SATBUFF.player].spacing["Enchant"] = 0
	end
			
	if not SBFVar[SATBUFF.player].opacity then
		SBFVar[SATBUFF.player].opacity = {}
		SBFVar[SATBUFF.player].opacity["Buff"] = 1.0
		SBFVar[SATBUFF.player].opacity["Debuff"] = 1.0
		SBFVar[SATBUFF.player].opacity["Enchant"] = 1.0
	end

	if not SBFVar[SATBUFF.player].count then
		SBFVar[SATBUFF.player].count = {}
		SBFVar[SATBUFF.player].count["Buff"] = 1
		SBFVar[SATBUFF.player].count["Debuff"] = 1
	end

	if not SBFVar[SATBUFF.player].warnTime then
		SBFVar[SATBUFF.player].warnTime = 10
	end
	
	if not SBFVar["spells"] then
		SBFVar["spells"] = {}
	end
	
	-- Copy to new format if old saved vars are there
	if SBFVar[SATBUFF.player].scales then
		SBFVar[SATBUFF.player].iconScale["Buff"] = SBFVar[SATBUFF.player].scales["Buff"]
		SBFVar[SATBUFF.player].iconScale["Debuff"] = SBFVar[SATBUFF.player].scales["Debuff"]
		SBFVar[SATBUFF.player].iconScale["Enchant"] = SBFVar[SATBUFF.player].scales["Enchant"]
		SBFVar[SATBUFF.player].scales = nil

		SBFVar[SATBUFF.player].textScale["Buff"] = SBFVar[SATBUFF.player].text["Buff"]
		SBFVar[SATBUFF.player].textScale["Debuff"] = SBFVar[SATBUFF.player].text["Debuff"]
		SBFVar[SATBUFF.player].textScale["Enchant"] = SBFVar[SATBUFF.player].text["Enchant"]
		SBFVar[SATBUFF.player].text = nil
	end
		
	SBFVar[SATBUFF.player].version = nil
end
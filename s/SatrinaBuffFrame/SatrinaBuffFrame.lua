SatBuff_Version = 11100.01

SBFVar = {}
SATBUFF = {}

function SatrinaBuffFrame_OnLoad()
	SLASH_SATBUFF1 = "/satbuff"
	SlashCmdList["SATBUFF"] = SatrinaBuffFrame_SlashCommands

	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")

	SATBUFF = {	player = UnitName("player") }
end

function SatrinaBuffFrame_SlashCommands(msg)
	if (strlower(msg) == "home") then
		SatrinaBuffFrame:ClearAllPoints()
		SatrinaDebuffFrame:ClearAllPoints()
		SatrinaEnchantFrame:ClearAllPoints()
		SatrinaEnchantFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -70, -200)
		SatrinaBuffFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -65, -240)
		SatrinaDebuffFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -110, -240)
	else
		SatrinaBuffFrame_ShowOptions()
	end
end

function SatrinaBuffFrame_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		SatrinaBuffFrame_Initialise()
	end

	if (event == "PLAYER_ENTERING_WORLD") then
		SatrinaBuffFrame_DoUIScale()
		SatrinaBuffFrame_DoOpacity()
	end
end

function SatrinaBuffFrame_Initialise()
	default = 1.0
	
	if not SBFVar["version"] then
		SBFVar["version"] = SatBuff_Version
	end
	
	if not SBFVar[SATBUFF.player] then
		UIErrorsFrame:AddMessage(SBF_NEWPLAYER..SATBUFF.player, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)

		SBFVar[SATBUFF.player] = {}
		SBFVar[SATBUFF.player].uiscale = 1
		SBFVar[SATBUFF.player].addonmenu = 1
	end

	if (SBFVar["version"] < SatBuff_Version) then
		UIErrorsFrame:AddMessage(string.format(SBF_UPDATE, SatBuff_Version), 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
		if (SBFVar["version"] < 11000.02) then
			SBFVar[SATBUFF.player].addonmenu = 1
		end
		SBFVar["version"] = SatBuff_Version
	end

	SatrinaBuffFrame_DoSavedVars()
	DebuffTypeColor["Curse"]	= { r = 1.00, g = 0.40, b = 1.00 };
	DebuffTypeColor["Disease"]	= { r = 1.00, g = 1.00, b = 0.25 };
	DebuffTypeColor["Poison"]	= { r = 0.00, g = 0.90, b = 0.00 };

	
	-- Update to current version
	if (tonumber(SBFVar["version"]) < tonumber(SatBuff_Version)) then
		UIErrorsFrame:AddMessage(SBF_UPDATE..CastProgress_Version, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
		SBFVar["version"] = SatBuff_Version
	end

	SatrinaBuffFrame_DisableDefaultBuffFrame()
	SatrinaBuffFrame_InitOptions()
end

function SatrinaBuffFrame_BuffButton_OnLoad()
	this:RegisterForClicks("RightButtonUp")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")
	this.durationText = getglobal(this:GetName().."DurationText")
	this.icon = getglobal(this:GetName().."Icon")
	this.count = getglobal(this:GetName().."Count")
	this.id = this:GetID()
	SatrinaBuffFrame_BuffButton_Update()
end

--
-- Functions that do things with buffs
--

function SatrinaBuffFrame_BuffButton_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		this:RegisterEvent("PLAYER_AURAS_CHANGED")
		return
	end

	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("PLAYER_AURAS_CHANGED")
		return
	end

	-- Auras changed
	if not SATBUFF.showingOptions then
		SatrinaBuffFrame_BuffButton_Update()
	end
end

function SatrinaBuffFrame_ParseBuffTooltip(buff)
	if SATBUFF.player then
		SBFTooltip:SetOwner(UIParent,"ANCHOR_NONE") 
		SBFTooltip:SetPlayerBuff(buff.index)
		local name = SBFTooltipTextLeft1:GetText()
		local t1 = SBFVar["spells"][name]
		local	t2 = math.ceil(GetPlayerBuffTimeLeft(buff.index) / 60)
		if not t1 or (t2 > t1) then
			if (t2 > 2.9) then
				SBFVar["spells"][name] = t2
			end
			t1 = t2
		end
		buff.name = name
		buff.warnExpire = (not SBFVar[SATBUFF.player].longBuff) or (t1 >= SBFVar[SATBUFF.player].warnTime) 
	end
end

function SatrinaBuffFrame_BuffButton_Update(button)
	if not button then
		button = this
	end
	local buffIndex, untilCancelled = GetPlayerBuff(button.id, button.buffFilter)

	if (buffIndex >= 0) and not ((buffIndex > 16) and SATBUFF.player and not SBFVar[SATBUFF.player].sixteenBuffs) then
		button.index = buffIndex
		button.untilCancelled = untilCancelled
		if (untilCancelled == 1) then
			button.durationText:Hide()
		else
			button.durationText:Show()
		end
		if (button.buffFilter == "HELPFUL") then
			SatrinaBuffFrame_ParseBuffTooltip(button)
		end
		if (button.buffFilter == "HARMFUL") then
			-- Set color of debuff border based on dispel class.
			local color
			button.debuffType = GetPlayerBuffDispelType(GetPlayerBuff(this:GetID(), HARMFUL))
			local debuffSlot = getglobal(button:GetName().."Border")
			if button.debuffType then
				color = DebuffTypeColor[button.debuffType]
			else
				color = DebuffTypeColor["none"]
			end
			if debuffSlot then
				debuffSlot:SetVertexColor(color.r, color.g, color.b)
			end

			local count = GetPlayerBuffApplications(buffIndex)
			if (count > 1) then
				button.count:SetText(count)
				button.count:Show()
			else
				button.count:Hide()
			end
		end
		button.icon:SetTexture(GetPlayerBuffTexture(buffIndex))

		if GameTooltip:IsOwned(button) then
			GameTooltip:SetPlayerBuff(buffIndex)
		end
		UpdateBuffTime(button)
		button.updateTime = 0
		button:Show()
	else
		button.buffIndex = nil
		button:Hide()
		return
	end
end

function SatrinaBuffFrame_BuffButton_OnUpdate(elapsed)
	if not SATBUFF.showingOptions then
		if (this.updateTime < 0.95) then
			this.updateTime = this.updateTime + elapsed
		else
			this.updateTime = 0
			UpdateBuffTime(this)
		end
	end
end

function SatrinaBuffFrame_OnEnchantUpdate(elapsed)
	if not SATBUFF.showingOptions then
		if (this.updateTime < 0.95) then
			this.updateTime = this.updateTime + elapsed
		else
			this.updateTime = 0
	
			local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
			if not hasMainHandEnchant and not hasOffHandEnchant then
				SatrinaEnchant1:Hide()
				SatrinaEnchant2:Hide()
				return
			end
		
			if hasMainHandEnchant then
				textureName = GetInventoryItemTexture("player", 16)
				SatrinaEnchant1Icon:SetTexture(textureName)
				SatrinaEnchant1:Show()
				SatrinaEnchant1DurationText:SetText(SatrinaBuffFrame_GetTimeString(mainHandExpiration/1000))
			else
				SatrinaEnchant1:Hide()
				return
			end
		
			if hasOffHandEnchant then
				textureName = GetInventoryItemTexture("player", 17)
				SatrinaEnchant2Icon:SetTexture(textureName)
				SatrinaEnchant2:Show()
				SatrinaEnchant2DurationText:SetText(SatrinaBuffFrame_GetTimeString(offHandExpiration/1000))
			else
				SatrinaEnchant2:Hide()
				return
			end
		end
	end
end

function UpdateBuffTime(buff)
	if not buff then
		buff = this
	end
	if (buff.untilCancelled == 0) or not buff.untilCancelled then
		timeLeft = GetPlayerBuffTimeLeft(buff.index)
		buff.durationText:SetText(SatrinaBuffFrame_GetTimeString(timeLeft))
		if (buff.buffFilter == "HELPFUL") then
			if (timeLeft <= 30) then
				buff.durationText:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
			else
				buff.warnedT = nil
				buff.warnedS = nil
				buff.durationText:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			end
			if SATBUFF.player and SBFVar[SATBUFF.player].textWarning and (floor(timeLeft) == 30) then
				if buff.warnExpire and not buff.warnedT then
					DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..buff.name..SBF_BUFFEXPIRE)
					buff.warnedT = 1
				end
			end
			if SATBUFF.player and SBFVar[SATBUFF.player].soundWarning and (floor(timeLeft) == 30) then
				if buff.warnExpire and not buff.warnedS then
					PlaySoundFile(SATBUFF.sounds[SBFVar[SATBUFF.player].sound])
					buff.warnedS = 1
				end
			end
		else
			if buff.debuffType then
				buff.durationText:SetVertexColor(DebuffTypeColor[buff.debuffType].r, DebuffTypeColor[buff.debuffType].g, DebuffTypeColor[buff.debuffType].b)
			else
				buff.durationText:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			end
		end
	end
end

function SatrinaBuffFrame_BuffButton_OnClick()
	if not SATBUFF.showingOptions then
		CancelPlayerBuff(this.index)
	else
		ChatFrame1:AddMessage("Click index "..this.index)
	end
end

--
-- Support Functions
--

function SatrinaBuffFrame_GetTimeString(timeLeft)
	if (timeLeft == 0) then
		return nil
	end

	local timeStr = ""
	local minutes = 0
	local seconds = 0
	
	minutes = floor(timeLeft/60)
	seconds = floor(timeLeft - (minutes * 60))
	if SBFVar[SATBUFF.player] and SBFVar[SATBUFF.player].blizzardTimers then
		timestr = SecondsToTimeAbbrev(timeLeft)
	else
		timestr = string.format("%02d:%02d", minutes, seconds)
	end
	return timestr
end

oldBuffFrame_Enchant_OnUpdate = BuffFrame_Enchant_OnUpdate
function BuffFrame_Enchant_OnUpdate()
end

function SatrinaBuffFrame_OnEnchantLoad()
	this.updateTime = 1
end

function SatrinaBuffFrame_DisableDefaultBuffFrame()
	-- Unregister default buff frame events
	for i=0,23 do
		button = getglobal("BuffButton"..i)
		button:RegisterForClicks()
		button:UnregisterEvent("PLAYER_AURAS_CHANGED")
		button:Hide()
	end

	for i=1,2 do
		button = getglobal("TempEnchant"..i)
		button:RegisterForClicks()
		button:UnregisterEvent("PLAYER_AURAS_CHANGED")
		button:Hide()
	end
end

--
-- Functions that do scaling
--

function SatrinaBuffFrame_ScaleBuffs()
	for i=1,20 do
		getglobal("SatrinaBuffButton"..i):SetScale(SBFVar[SATBUFF.player].iconScale["Buff"])
		getglobal("SatrinaBuffButton"..i.."Duration"):SetScale(SBFVar[SATBUFF.player].textScale["Buff"])
	end
	for i=1,16 do
		getglobal("SatrinaDebuffButton"..i):SetScale(SBFVar[SATBUFF.player].iconScale["Debuff"])
		getglobal("SatrinaDebuffButton"..i.."Duration"):SetScale(SBFVar[SATBUFF.player].textScale["Debuff"])
	end
	SatrinaEnchant1:SetScale(SBFVar[SATBUFF.player].iconScale["Enchant"])
	SatrinaEnchant1Duration:SetScale(SBFVar[SATBUFF.player].textScale["Enchant"])
	SatrinaEnchant2:SetScale(SBFVar[SATBUFF.player].iconScale["Enchant"])
	SatrinaEnchant2Duration:SetScale(SBFVar[SATBUFF.player].textScale["Enchant"])
	SatrinaBuffFrame_ScaleFrames()
end

function SatrinaBuffFrame_DoOpacity()
	SatrinaBuffFrame:SetAlpha(SBFVar[SATBUFF.player].opacity["Buff"])
	SatrinaDebuffFrame:SetAlpha(SBFVar[SATBUFF.player].opacity["Debuff"])
	SatrinaEnchantFrame:SetAlpha(SBFVar[SATBUFF.player].opacity["Enchant"])
end

function SatrinaBuffFrame_DoUIScale()
	if SBFVar[SATBUFF.player].uiscale then
		local scale = 1.0
		SBFVar[SATBUFF.player].iconScale["Buff"] = scale
		SBFVar[SATBUFF.player].iconScale["Debuff"] = scale
		SBFVar[SATBUFF.player].iconScale["Enchant"] = scale
		SBFVar[SATBUFF.player].textScale["Buff"] = scale
		SBFVar[SATBUFF.player].textScale["Debuff"] = scale
		SBFVar[SATBUFF.player].textScale["Enchant"] = scale

		OptionsFrame_DisableSlider(SatrinaBuffScaleSlider)
		OptionsFrame_DisableSlider(SatrinaDebuffScaleSlider)
		OptionsFrame_DisableSlider(SatrinaEnchantScaleSlider)
		OptionsFrame_DisableSlider(SatrinaBuffTextSlider)
		OptionsFrame_DisableSlider(SatrinaDebuffTextSlider)
		OptionsFrame_DisableSlider(SatrinaEnchantTextSlider)
	else
		SatrinaBuffScaleSlider:SetValue(SBFVar[SATBUFF.player].iconScale["Buff"])
		SatrinaDebuffScaleSlider:SetValue(SBFVar[SATBUFF.player].iconScale["Debuff"])
		SatrinaEnchantScaleSlider:SetValue(SBFVar[SATBUFF.player].iconScale["Enchant"])
		SatrinaBuffTextSlider:SetValue(SBFVar[SATBUFF.player].textScale["Buff"])
		SatrinaDebuffTextSlider:SetValue(SBFVar[SATBUFF.player].textScale["Debuff"])
		SatrinaEnchantTextSlider:SetValue(SBFVar[SATBUFF.player].textScale["Enchant"])
		OptionsFrame_EnableSlider(SatrinaBuffScaleSlider)
		OptionsFrame_EnableSlider(SatrinaDebuffScaleSlider)
		OptionsFrame_EnableSlider(SatrinaEnchantScaleSlider)
		OptionsFrame_EnableSlider(SatrinaBuffTextSlider)
		OptionsFrame_EnableSlider(SatrinaDebuffTextSlider)
		OptionsFrame_EnableSlider(SatrinaEnchantTextSlider)
	end
	SatrinaBuffFrame_ScaleBuffs()
	SatrinaBuffFrame_ArrangeIcons("SatrinaBuffFrame")
	SatrinaBuffFrame_ArrangeIcons("SatrinaDebuffFrame")
	SatrinaBuffFrame_ArrangeEnchantIcons()
end

function SatrinaBuffFrame_ArrangeEnchantIcons()
	SatrinaEnchant2:ClearAllPoints()
	if SBFVar[SATBUFF.player].verticalEnchants then
		SatrinaEnchant2:SetPoint("TOP", "SatrinaEnchant1", "BOTTOM", 0, -20 + SBFVar[SATBUFF.player].spacing["Enchant"])
	else
		SatrinaEnchant2:SetPoint("LEFT", "SatrinaEnchant1", "RIGHT", 20 + SBFVar[SATBUFF.player].spacing["Enchant"], 0)
	end
end

function SatrinaBuffFrame_ArrangeIcons(frame)
	local count = 1
	local isHeader = 1
	local currBuff = 1
	local buff

	local button, num, rows, reverse, spacing, bottom
	local headerAnchor, buffAnchor, lastbuff, rowCount
	
	if (frame == "SatrinaBuffFrame") then
		button = "SatrinaBuffButton"
		num = SBFVar[SATBUFF.player].count["Buff"]
		rows = SBFVar[SATBUFF.player].buffHorizontal
		reverse = SBFVar[SATBUFF.player].reverseBuffs
		bottom = SBFVar[SATBUFF.player].bottomBuffs
		spacing = SBFVar[SATBUFF.player].spacing["Buff"]
		n = (SBFVar[SATBUFF.player].sixteenBuffs and 16) or 20
	else
		button = "SatrinaDebuffButton"
		num = SBFVar[SATBUFF.player].count["Debuff"]
		rows = SBFVar[SATBUFF.player].debuffHorizontal
		reverse = SBFVar[SATBUFF.player].reverseDebuffs
		bottom = SBFVar[SATBUFF.player].bottomDebuffs
		spacing = SBFVar[SATBUFF.player].spacing["Debuff"]
		n = 16
	end
	rowCount = math.ceil(n/num)
	lastBuff = rowCount
	
	if reverse then
		if bottom then
			headerAnchor = "BOTTOMLEFT"
		else
			headerAnchor = "TOPLEFT"
		end
	else
		if bottom then
			headerAnchor = "BOTTOMRIGHT"
		else
			headerAnchor = "TOPRIGHT"
		end
	end

	if bottom then
		getglobal(frame.."DragTab"):ClearAllPoints()
		getglobal(frame.."DragTab"):SetPoint("TOP", frame, "BOTTOM", 0, -15)
	else
		getglobal(frame.."DragTab"):ClearAllPoints()
		getglobal(frame.."DragTab"):SetPoint("BOTTOM", frame, "TOP", 0, 0)
	end

	while (currBuff <= n) do
		buff = getglobal(button..currBuff)
		buff:ClearAllPoints()
		
		if isHeader then
			local headerSpacing = ((count - 1) * spacing) + ((count -1) * 40)
			if rows then
				if bottom then
					buff:SetPoint(headerAnchor, frame, headerAnchor, 0, headerSpacing)
				else
					buff:SetPoint(headerAnchor, frame, headerAnchor, 0, headerSpacing * -1)
				end
			else
				if reverse then
					buff:SetPoint(headerAnchor, frame, headerAnchor, headerSpacing * -1, 0)
				else
					buff:SetPoint(headerAnchor, frame, headerAnchor, headerSpacing, 0)
				end
			end
			isHeader = nil
		else
			if rows then
				if reverse then
					buff:SetPoint("RIGHT", getglobal(button..currBuff - 1), "LEFT", (-15 - spacing), 0)
				else
					buff:SetPoint("LEFT", getglobal(button..currBuff - 1), "RIGHT", (15 + spacing), 0)
				end
			else
				if bottom then
					buff:SetPoint("BOTTOM", getglobal(button..currBuff - 1), "TOP", 0, (15 + spacing))
				else
					buff:SetPoint("TOP", getglobal(button..currBuff - 1), "BOTTOM", 0, (-15 - spacing))
				end
			end
		end
		if (currBuff == lastBuff) then
			isHeader = 1
			lastBuff = lastBuff + rowCount
			count = count + 1
		end
		currBuff = currBuff + 1
	end
	SatrinaBuffFrame_ScaleFrames()
end

function SatrinaBuffFrame_ScaleFrames()
end

function SatrinaBuffFrame_OnEnter(buff)
	if not SATBUFF.showingOptions then
		local x = "RIGHT"
		if (this:GetLeft() < UIParent:GetRight()/2) then
			x = "LEFT"
		end
		GameTooltip:SetOwner(this, "ANCHOR_TOP"..x)
		if buff then
			GameTooltip:SetPlayerBuff(this.index, "HELPFUL")
		else
			GameTooltip:SetPlayerBuff(this.index, "HARMFUL")
		end
	end
end
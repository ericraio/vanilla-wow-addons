local ElkBuffBar = {}

function ElkBuffBar:Init()
	BuffFrame:Hide()
	TemporaryEnchantFrame:Hide()

	self.frame = ElkBuffBarFrame
	self.frame:ClearAllPoints()
	self.frame.owner = self
	self.frame:SetScript("OnEvent", function() this.owner:OnEvent() end)
	self.frame:RegisterEvent("ADDON_LOADED")

	self.tooltip = ElkBuffTooltip

	self.numBuffButtons = 0
	self.numBuffsShown = 0
	self.UpdateTime = 0
	self.FlashTime = 0
	self.FlashState = 0

	self.Layout = {}

	self.old_hasMainHandEnchant = nil
	self.old_mainHandName = ""
	self.old_mainHandExpiration = 0
	self.old_mainHandCharges = 0
	self.old_hasOffHandEnchant = nil
	self.old_offHandName = ""
	self.old_offHandExpiration = 0
	self.old_offHandCharges = 0

	self.compost = AceLibrary("Compost-2.0")

	if (IsAddOnLoaded("ItemDB_Money")) then
		EquipCompare_RegisterExclusion("^ElkBuffButton")
	end
end

function ElkBuffBar:OnEvent()
	if event == "ADDON_LOADED" and arg1 == "ElkBuffBar" then
		self.frame:UnregisterEvent("ADDON_LOADED")
		self:InitSettings()
		self.frame:RegisterEvent("PLAYER_AURAS_CHANGED")
		self.frame:SetScript("OnUpdate", function() this.owner:OnUpdate(arg1) end)
		self.frame:SetScript("OnLeave", function() this.owner:StopMoving() end)
		SLASH_ELKBUFFBAR1 = "/ebb"
		SLASH_ELKBUFFBAR2 = "/elkbuffbar"
		SlashCmdList["ELKBUFFBAR"] = function(msg) ElkBuffBarFrame.owner:SlashCommandHandler(msg) end
	elseif event == "PLAYER_AURAS_CHANGED" then
		self:UpdateBuffs()
	end
end

function ElkBuffBar:InitSettings()
		if not ElkBuffBarOptions then
			ElkBuffBarOptions = {
				["width"]	= 250,
				["height"]	= 20,
				["scale"]	= 1,
				["anchor"]	= "TOPRIGHT",
				["locked"]	= nil,
				["alpha"]	= 1,
				["icon"]	= "LEFT",
				["sort"]	= "DEFAULT",
				["timer"]	= "DEFAULT",
				["invert"]	= nil,
				["spacing"]	= 0,
				["group"]	= 5,
				["dbcolor"]	= true,
			}
		end
		if not ElkBuffBarOptions.width then ElkBuffBarOptions.width = 250 end
		if not ElkBuffBarOptions.height then ElkBuffBarOptions.height = 20 end
		if not ElkBuffBarOptions.scale then ElkBuffBarOptions.scale = 1 end
		if not ElkBuffBarOptions.anchor then ElkBuffBarOptions.anchor = "TOPRIGHT" end
		if not ElkBuffBarOptions.alpha then ElkBuffBarOptions.alpha = 1 end
		if not ElkBuffBarOptions.icon then ElkBuffBarOptions.icon = "LEFT" end
		if not ElkBuffBarOptions.sort then ElkBuffBarOptions.sort = "DEFAULT" end
		if not ElkBuffBarOptions.timer then ElkBuffBarOptions.timer = "DEFAULT" end
		if not ElkBuffBarOptions.spacing then ElkBuffBarOptions.spacing = 0 end
		if not ElkBuffBarOptions.group then ElkBuffBarOptions.group = 5 end
		if not ElkBuffBarOptions.dbcolor then ElkBuffBarOptions.dbcolor = true end
		if not ElkBuffBarOptions.x then ElkBuffBarOptions.x = floor(GetScreenWidth() * .5 / (GetCVar("uiscale") * ElkBuffBarOptions.scale)) end
		if not ElkBuffBarOptions.y then ElkBuffBarOptions.y = floor(GetScreenHeight() * .5 / (GetCVar("uiscale") * ElkBuffBarOptions.scale)) end
		self:UpdateLayout()
end

local function buffssort_bytimeleft(a, b)
	if (not a or not b) then
		return true
	end
	if a[5] == 1 then
		if b[5] == 1 then
			return a[2] < b[2]
		else
			return true
		end
	end
	if b[5] == 1 then
		return false
	end
	if a[3] > b[3] then
		return true
	end
	if a[3] < b[3] then
		return false
	end
	return a[2] < b[2]
end

local function buffssort_bytimemax(a, b)
	if (not a or not b) then
		return true
	end
	if a[5] == 1 then
		if b[5] == 1 then
			return a[2] < b[2]
		else
			return true
		end
	end
	if b[5] == 1 then
		return false
	end
	if a[4] > b[4] then
		return true
	end
	if a[4] < b[4] then
		return false
	end
	return a[2] < b[2]
end

local function isEmpty(ttbl)
	for _,_ in ttbl do
		return false
	end
	return true
end

function ElkBuffBar:UpdateBuffs()
	local maxtimes = self.compost:Acquire()
	local buffssort = self.compost:Acquire()
	for i = 1, self.numBuffsShown do
		local button = getglobal("ElkBuffButton"..i)
		if not maxtimes[button.name] or maxtimes[button.name] < button.maxtime then
			maxtimes[button.name] = button.maxtime
		end
	end
	local numBuffs = 0
	local buffIndex, untilCancelled
	local i = 0
	while true do
		buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL")
		if buffIndex < 0 then break end

		local timeleft = GetPlayerBuffTimeLeft(buffIndex)
		local timemax = timeleft
	
		local name = self:GetBuffName(buffIndex)
		if (name) then
			if maxtimes[name] and timemax < maxtimes[name] then
				timemax = maxtimes[name]
			end
		end

		table.insert(buffssort, self.compost:Acquire(buffIndex, name, timeleft, timemax, untilCancelled))
		i = i + 1
	end
	if ElkBuffBarOptions.sort == "TIMEMAX" then
		table.sort(buffssort, buffssort_bytimemax)
	elseif ElkBuffBarOptions.sort == "TIMELEFT" then
		table.sort(buffssort, buffssort_bytimeleft)
	end
	for it = 1, table.getn(buffssort) do
		numBuffs = numBuffs + 1
		self:SetBuffButtonBuff(numBuffs, buffssort[it][1], buffssort[it][2], buffssort[it][3], buffssort[it][4], buffssort[it][5])
	end
	buffssort = self.compost:Reclaim(buffssort, 1)
	buffssort = self.compost:Acquire()
	i = 0
	while true do
		buffIndex, untilCancelled = GetPlayerBuff(i, "HARMFUL")
		if buffIndex < 0 then break end
		local timeleft = GetPlayerBuffTimeLeft(buffIndex)
		local timemax = timeleft
	
		local name = self:GetBuffName(buffIndex)
		if (name) then
			if maxtimes[name] and timemax < maxtimes[name] then
				timemax = maxtimes[name]
			end
		end

		table.insert(buffssort, self.compost:Acquire(buffIndex, name, timeleft, timemax, untilCancelled))
		i = i + 1
	end
	if ElkBuffBarOptions.sort == "TIMEMAX" then
		table.sort(buffssort, buffssort_bytimemax)
	elseif ElkBuffBarOptions.sort == "TIMELEFT" then
		table.sort(buffssort, buffssort_bytimeleft)
	end
	for it = 1, table.getn(buffssort) do
		numBuffs = numBuffs + 1
		self:SetBuffButtonDebuff(numBuffs, buffssort[it][1], buffssort[it][2], buffssort[it][3], buffssort[it][4], buffssort[it][5])
	end
	buffssort = self.compost:Reclaim(buffssort, 1)
	buffssort = self.compost:Acquire()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
	if ( hasMainHandEnchant ) then
		local timeleft = mainHandExpiration / 1000
		local timemax = timeleft
	
		local id = GetInventorySlotInfo("MainHandSlot")
		local name = self:GetTempBuffName(id)
		if (name) then
			if maxtimes[name] and timemax < maxtimes[name] then
				timemax = maxtimes[name]
			end
		end
		table.insert(buffssort, self.compost:Acquire(id, name, timeleft, timemax, mainHandCharges))
	end
	if ( hasOffHandEnchant ) then
		local timeleft = offHandExpiration / 1000
		local timemax = timeleft

		local id = GetInventorySlotInfo("SecondaryHandSlot")
		local name = self:GetTempBuffName(id)
		if (name) then
			if maxtimes[name] and timemax < maxtimes[name] then
				timemax = maxtimes[name]
			end
		end
		oldn = table.getn(buffssort)
		table.insert(buffssort, self.compost:Acquire(id, name, timeleft, timemax, offHandCharges))
	end
	if ElkBuffBarOptions.sort == "TIMEMAX" then
		table.sort(buffssort, buffssort_bytimemax)
	elseif ElkBuffBarOptions.sort == "TIMELEFT" then
		table.sort(buffssort, buffssort_bytimeleft)
	end
	for it = 1, table.getn(buffssort) do
		numBuffs = numBuffs + 1
		self:SetBuffButtonWeapon(numBuffs, buffssort[it][1], buffssort[it][2], buffssort[it][3], buffssort[it][4], buffssort[it][5])
	end
	self:Cleanup(numBuffs)
	self.numBuffsShown = numBuffs
	self:UpdateButtonPositions()
	maxtimes = self.compost:Reclaim(maxtimes)
	buffssort = self.compost:Reclaim(buffssort, 1)
end

function ElkBuffBar:SetBuffButtonBuff(buttonid, id, buffname, timeleft, timemax, cancel)
	self:CreateButtons(buttonid)
	local button = getglobal("ElkBuffButton"..buttonid)
	local bar = getglobal("ElkBuffButton"..buttonid.."TimeBar")
	local icon = getglobal("ElkBuffButton"..buttonid.."Icon")
	local name = getglobal("ElkBuffButton"..buttonid.."DescribeText")
	local buffCount = getglobal("ElkBuffButton"..buttonid.."Count")
	local duration = getglobal("ElkBuffButton"..buttonid.."DurationText")
	local debuff = getglobal("ElkBuffButton"..buttonid.."DebuffBorder")
	local tench = getglobal("ElkBuffButton"..buttonid.."TEnchBorder")

	button:SetAlpha(self.frame:GetAlpha())
	button.type = "BUFF"
	button.id = id
	button.untilCancelled = cancel
	button:SetBackdropColor(0.3, 0.5, 1, 0.5)
	bar:SetStatusBarColor(0, 0.5, 1, 0.8)
	icon:SetTexture(GetPlayerBuffTexture(id))

	button.timeleft = timeleft
	button.maxtime = timemax
	bar:SetMinMaxValues(0, button.maxtime)

	button.name = buffname or "Buff "..id
	local count = GetPlayerBuffApplications(id)
	if ( count > 1 ) then
		name:SetText((buffname or "Buff "..id).." x"..count)
		buffCount:SetText(count)
		buffCount:Show()
	else
		name:SetText(buffname or "Buff "..id)
		buffCount:Hide()
	end
	debuff:Hide()
	tench:Hide()
	button:Show()
end

function ElkBuffBar:SetBuffButtonDebuff(buttonid, id, buffname, timeleft, timemax, cancel)
	self:CreateButtons(buttonid)
	local button = getglobal("ElkBuffButton"..buttonid)
	local bar = getglobal("ElkBuffButton"..buttonid.."TimeBar")
	local icon = getglobal("ElkBuffButton"..buttonid.."Icon")
	local name = getglobal("ElkBuffButton"..buttonid.."DescribeText")
	local buffCount = getglobal("ElkBuffButton"..buttonid.."Count")
	local duration = getglobal("ElkBuffButton"..buttonid.."DurationText")
	local debuff = getglobal("ElkBuffButton"..buttonid.."DebuffBorder")
	local tench = getglobal("ElkBuffButton"..buttonid.."TEnchBorder")

	button:SetAlpha(self.frame:GetAlpha())
	button.type = "DEBUFF"
	button.id = id
	button.untilCancelled = cancel
	button:SetBackdropColor(1, 0, 0, 0.5)
	icon:SetTexture(GetPlayerBuffTexture(id))

	button.timeleft = timeleft
	button.maxtime = timemax
	bar:SetMinMaxValues(0, button.maxtime)

	button.name = buffname or "Debuff "..id
	local count = GetPlayerBuffApplications(id)
	if ( count > 1 ) then
		name:SetText((buffname or "Debuff "..id).." x"..count)
		buffCount:SetText(count)
		buffCount:Show()
	else
		name:SetText(buffname or "Debuff "..id)
		buffCount:Hide()
	end
	local color
	local debuffType = GetPlayerBuffDispelType(id)
	if ( debuffType ) then
		color = DebuffTypeColor[debuffType]
	else
		color = DebuffTypeColor["none"]
	end
	debuff:SetVertexColor(color.r, color.g, color.b)
	if ElkBuffBarOptions.dbcolor then
		bar:SetStatusBarColor(color.r, color.g, color.b, 0.8)
	else
		bar:SetStatusBarColor(1, 0, 0, 0.8)
	end
	debuff:Show()
	tench:Hide()
	button:Show()
end

function ElkBuffBar:SetBuffButtonWeapon(buttonid, id, buffname, timeleft, timemax, count)
	self:CreateButtons(buttonid)
	local button = getglobal("ElkBuffButton"..buttonid)
	local bar = getglobal("ElkBuffButton"..buttonid.."TimeBar")
	local icon = getglobal("ElkBuffButton"..buttonid.."Icon")
	local name = getglobal("ElkBuffButton"..buttonid.."DescribeText")
	local buffCount = getglobal("ElkBuffButton"..buttonid.."Count")
	local duration = getglobal("ElkBuffButton"..buttonid.."DurationText")
	local debuff = getglobal("ElkBuffButton"..buttonid.."DebuffBorder")
	local tench = getglobal("ElkBuffButton"..buttonid.."TEnchBorder")

	button:SetAlpha(self.frame:GetAlpha())
	button.type = "WEAPON"
	button.id = id
	button.untilCancelled = 0
	button:SetBackdropColor(0.5, 0, 0.5, 0.5)
	bar:SetStatusBarColor(0.5, 0, 0.5, 0.8)
	icon:SetTexture(GetInventoryItemTexture("player", id))

	button.timeleft = timeleft
	button.maxtime = timemax
	bar:SetMinMaxValues(0, button.maxtime)
	button.name = buffname or "Weapon "..id

	if ( count > 1 ) then
		name:SetText((buffname or "Weapon "..id).." x"..count)
		buffCount:SetText(count)
		buffCount:Show()
	else
		name:SetText(buffname or "Weapon "..id)
		buffCount:Hide()
	end
	debuff:Hide()
	tench:Show()
	button:Show()
end

function ElkBuffBar:CreateButtons(numButtons)
	if numButtons > self.numBuffButtons then
		for i = self.numBuffButtons + 1, numButtons do
			local f = CreateFrame("Button", "ElkBuffButton"..i, self.frame, "ElkBuffBar_BuffButtonTemplate")
			self:UpdateButtonPosition(i)
			self:UpdateButtonHeight(i)
			self:UpdateButtonIcon(i)
			self:UpdateButtonTimer(i)
			f.owner = self
			f:SetScript("OnMouseDown", function() if arg1 == "LeftButton" then this.isMoving = true; this.owner:StartMoving() end end)
			f:SetScript("OnMouseUp", function() if arg1 == "LeftButton" then this.isMoving = false; this.owner:StopMoving() end end)
			f:SetScript("OnHide", function() if this.isMoving then this.owner:StopMoving() end end)
			f:RegisterForClicks("RightButtonUp")
			f:SetScript("OnClick", function() this.owner:ButtonOnClick() end)
			f:SetScript("OnEnter", function() this.owner:ButtonOnEnter() end)
			f:SetScript("OnLeave", function() this.owner:ButtonOnLeave() end)
			getglobal("ElkBuffButton"..i.."DescribeText"):SetTextColor(1, 1, 1)
			getglobal("ElkBuffButton"..i.."DurationText"):SetTextColor(1, 1, 1)
		end
		self.numBuffButtons = numButtons
	end
end

function ElkBuffBar:Cleanup(numBuffs)
	if numBuffs < self.numBuffButtons then
		for i = numBuffs + 1, self.numBuffButtons do
			local button = getglobal("ElkBuffButton"..i)
			button.id = nil
			button:Hide()
		end
	end
end

function ElkBuffBar:GetBuffName(id)
	self.tooltip:SetPlayerBuff(id)
	local toolTipText = getglobal("ElkBuffTooltipTextLeft1")
	if (toolTipText) then
		return toolTipText:GetText() or id
	end
	return id
end

function ElkBuffBar:GetTempBuffName(id)
	self.tooltip:SetInventoryItem("player", id)
	for i=1,self.tooltip:NumLines() do
		local toolTipText = getglobal("ElkBuffTooltipTextLeft" .. i)
		local _, _, buffname = string.find(toolTipText:GetText(), "^([^%(]+) %(%d+ [^%)]+%)")
		if buffname then
			return buffname
		end
	end
	local itemlink = GetInventoryItemLink("player", id);
	if (itemlink) then
		local _, _, name = string.find(itemlink, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r");
		return name or "Weapon "..id
	end
	return "Weapon "..id
end

function ElkBuffBar:OnUpdate(elapsed)
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
	local mainHandName = ""
	if hasMainHandEnchant then
		mainHandName = self:GetTempBuffName(GetInventorySlotInfo("MainHandSlot"))
	end
	local offHandName = ""
	if hasOffHandEnchant then
		offHandName = self:GetTempBuffName(GetInventorySlotInfo("SecondaryHandSlot"))
	end

	hasMainHandEnchant = hasMainHandEnchant or false
	mainHandName = mainHandName or ""
	mainHandExpiration = mainHandExpiration or 0
	mainHandCharges = mainHandCharges or 0
	hasOffHandEnchant = hasOffHandEnchant or false
	offHandName = offHandName or ""
	offHandExpiration = offHandExpiration or 0
	offHandCharges = offHandCharges or 0

	if hasMainHandEnchant ~= self.old_hasMainHandEnchant or mainHandName ~= self.old_mainHandName or mainHandExpiration > self.old_mainHandExpiration or mainHandCharges ~= self.old_mainHandCharges or hasOffHandEnchant ~= self.old_hasOffHandEnchant or offHandName ~= self.old_offHandName or offHandExpiration > self.old_offHandExpiration or offHandCharges ~= self.old_offHandCharges then
		self:UpdateBuffs()
	end
	self.old_hasMainHandEnchant = hasMainHandEnchant
	self.old_mainHandName = mainHandName
	self.old_mainHandExpiration = mainHandExpiration
	self.old_mainHandCharges = mainHandCharges
	self.old_hasOffHandEnchant = hasOffHandEnchant
	self.old_offHandName = offHandName
	self.old_offHandExpiration = offHandExpiration
	self.old_offHandCharges = offHandCharges

	if ( self.UpdateTime > 0 ) then
		self.UpdateTime = self.UpdateTime - elapsed
	else
		self.UpdateTime = self.UpdateTime + TOOLTIP_UPDATE_TIME
	end

	self.FlashTime = self.FlashTime - elapsed
	if ( self.FlashTime < 0 ) then
		local overtime = -self.FlashTime
		if ( self.FlashState == 0 ) then
			self.FlashState = 1
			self.FlashTime = BUFF_FLASH_TIME_ON
		else
			self.FlashState = 0
			self.FlashTime = BUFF_FLASH_TIME_OFF
		end
		if ( overtime < self.FlashTime ) then
			self.FlashTime = self.FlashTime - overtime
		end
	end

	if ( self.FlashState == 1 ) then
		self.BuffAlphaValue = (BUFF_FLASH_TIME_ON - self.FlashTime) / BUFF_FLASH_TIME_ON
	else
		self.BuffAlphaValue = self.FlashTime / BUFF_FLASH_TIME_ON
	end
	self.BuffAlphaValue = ((self.BuffAlphaValue * (1 - BUFF_MIN_ALPHA)) + BUFF_MIN_ALPHA) * self.frame:GetAlpha()

	local mustupdate = nil
	for i = 1, self.numBuffsShown do
		local button = getglobal("ElkBuffButton"..i)
		local duration = getglobal("ElkBuffButton"..i.."DurationText")
		local bar = getglobal("ElkBuffButton"..i.."TimeBar")
		if button.untilCancelled ~= 1 then
			local timeleft = 0
			if button.type == "BUFF" or button.type == "DEBUFF" then
				timeleft = GetPlayerBuffTimeLeft(button.id)
			elseif button.type == "WEAPON" then
				local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
				if button.id == GetInventorySlotInfo("MainHandSlot") then
					timeleft = mainHandExpiration / 1000
				end
				if button.id == GetInventorySlotInfo("SecondaryHandSlot") then
					timeleft = offHandExpiration / 1000
				end
			end
			if ( timeleft < BUFF_WARNING_TIME ) then
				button:SetAlpha(self.BuffAlphaValue)
			else
				button:SetAlpha(self.frame:GetAlpha())
			end
			if ElkBuffBarOptions.timer == "DEFAULT" then
				duration:SetText(SecondsToTimeAbbrev(timeleft))
				duration:Show()
			elseif ElkBuffBarOptions.timer == "FULL" then
				local seconds = timeleft
				local temptime
				local time = ""
				if seconds >= 3600 then
					tempTime = floor(seconds / 3600)
					time = time..tempTime..":"
					seconds = mod(seconds, 3600)
				end
				if seconds >= 60 then
					tempTime = floor(seconds / 60)
					if time ~= "" and tempTime < 10 then
						time = time.."0"..tempTime..":"
					else
						time = time..tempTime..":"
					end
					seconds = mod(seconds, 60)
				end
				if seconds >= 0 then
					tempTime = format("%d", seconds)
					if time ~= "" and seconds < 10 then
						time = time.."0"..tempTime
					else
						time = time..tempTime
					end
				end
				duration:SetText(time)
				duration:Show()
			else
				duration:Hide()
			end
			bar:SetValue(timeleft)
			bar:Show()
			if button.timeleft < timeleft then
				mustupdate = true
			end
			button.timeleft = timeleft
		else
			duration:Hide()
			bar:Hide()
		end
	end

	if mustupdate then
		self:UpdateBuffs()
	end

	if ( self.UpdateTime > 0 ) then
		return
	end
	if ( GameTooltip:IsOwned(this) ) then
		self:ButtonOnEnter()
	end
end

function ElkBuffBar:ButtonOnEnter()
	if this.type == "BUFF" or this.type == "DEBUFF" then
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT")
		GameTooltip:SetPlayerBuff(this.id)
	elseif this.type == "WEAPON" then
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT")
		GameTooltip:SetInventoryItem("player", this.id)
	end
end

function ElkBuffBar:ButtonOnLeave()
	GameTooltip:Hide()
end

function ElkBuffBar:ButtonOnClick()
	if this.type == "BUFF" or this.type == "DEBUFF" then
		CancelPlayerBuff(this.id)
	end
end

function ElkBuffBar:StartMoving()
	if not self.Layout.locked then
		self.frame:StartMoving()
	end
end

function ElkBuffBar:StopMoving()
	self.frame:StopMovingOrSizing()
	if ElkBuffBarOptions.anchor == "TOPLEFT" then
		ElkBuffBarOptions.x = floor(self.frame:GetLeft() + .5)
		ElkBuffBarOptions.y = floor(self.frame:GetTop() + .5)
	elseif ElkBuffBarOptions.anchor == "TOPRIGHT" then
		ElkBuffBarOptions.x = floor(self.frame:GetRight() + .5)
		ElkBuffBarOptions.y = floor(self.frame:GetTop() + .5)
	elseif ElkBuffBarOptions.anchor == "BOTTOMLEFT" then
		ElkBuffBarOptions.x = floor(self.frame:GetLeft() + .5)
		ElkBuffBarOptions.y = floor(self.frame:GetBottom() + .5)
	elseif ElkBuffBarOptions.anchor == "BOTTOMRIGHT" then
		ElkBuffBarOptions.x = floor(self.frame:GetRight() + .5)
		ElkBuffBarOptions.y = floor(self.frame:GetBottom() + .5)
	end
	self:UpdateLayout()
end

function ElkBuffBar:UpdateLayout()
	if not self.Layout.width or self.Layout.width ~= ElkBuffBarOptions.width then
		self.frame:SetWidth(ElkBuffBarOptions.width)
		self.Layout.width = ElkBuffBarOptions.width
	end
	if not self.Layout.height or self.Layout.height ~= ElkBuffBarOptions.height then
		for i = 1, self.numBuffButtons do
			self:UpdateButtonHeight(i)
		end
		self.Layout.height = ElkBuffBarOptions.height
	end
	if not self.Layout.scale or self.Layout.scale ~= ElkBuffBarOptions.scale then
		self.frame:SetScale(ElkBuffBarOptions.scale)
		if self.Layout.scale and ElkBuffBarOptions.x and ElkBuffBarOptions.y then
			ElkBuffBarOptions.x = floor(ElkBuffBarOptions.x * self.Layout.scale / ElkBuffBarOptions.scale)
			ElkBuffBarOptions.y = floor(ElkBuffBarOptions.y * self.Layout.scale / ElkBuffBarOptions.scale)
		end
		self.Layout.scale = ElkBuffBarOptions.scale
	end
	if ElkBuffBarOptions.x and ElkBuffBarOptions.y and ((not self.Layout.x or self.Layout.x ~= ElkBuffBarOptions.x) or (not self.Layout.y or self.Layout.y ~= ElkBuffBarOptions.y) or (not self.Layout.anchor or self.Layout.anchor ~= ElkBuffBarOptions.anchor)) then
		if self.Layout.anchor and self.Layout.anchor ~= ElkBuffBarOptions.anchor then
			local x, y
			if self.Layout.anchor == "TOPLEFT" then
				x = ElkBuffBarOptions.x
				y = ElkBuffBarOptions.y - self.frame:GetHeight()
			elseif self.Layout.anchor == "TOPRIGHT" then
				x = ElkBuffBarOptions.x - self.frame:GetWidth()
				y = ElkBuffBarOptions.y - self.frame:GetHeight()
			elseif self.Layout.anchor == "BOTTOMLEFT" then
				x = ElkBuffBarOptions.x
				y = ElkBuffBarOptions.y
			elseif self.Layout.anchor == "BOTTOMRIGHT" then
				x = ElkBuffBarOptions.x - self.frame:GetWidth()
				y = ElkBuffBarOptions.y
			end
			if ElkBuffBarOptions.anchor == "TOPLEFT" then
				ElkBuffBarOptions.x = floor(x + .5)
				ElkBuffBarOptions.y = floor(y + self.frame:GetHeight() + .5)
			elseif ElkBuffBarOptions.anchor == "TOPRIGHT" then
				ElkBuffBarOptions.x = floor(x + self.frame:GetWidth() + .5)
				ElkBuffBarOptions.y = floor(y + self.frame:GetHeight() + .5)
			elseif ElkBuffBarOptions.anchor == "BOTTOMLEFT" then
				ElkBuffBarOptions.x = floor(x + .5)
				ElkBuffBarOptions.y = floor(y + .5)
			elseif ElkBuffBarOptions.anchor == "BOTTOMRIGHT" then
				ElkBuffBarOptions.x = floor(x + self.frame:GetWidth() + .5)
				ElkBuffBarOptions.y = floor(y + .5)
			end
		end
		self.frame:ClearAllPoints()
		self.frame:SetPoint(ElkBuffBarOptions.anchor, UIParent, "BOTTOMLEFT", ElkBuffBarOptions.x, ElkBuffBarOptions.y)
		self.Layout.x = ElkBuffBarOptions.x
		self.Layout.y = ElkBuffBarOptions.y
		self.Layout.anchor = ElkBuffBarOptions.anchor
	end
	if (not self.Layout.locked and ElkBuffBarOptions.locked) or (self.Layout.locked and not ElkBuffBarOptions.locked) then
		self.Layout.locked = ElkBuffBarOptions.locked
	end
	if not self.Layout.alpha or self.Layout.alpha ~= ElkBuffBarOptions.alpha then
		self.frame:SetAlpha(ElkBuffBarOptions.alpha)
		self.Layout.alpha = ElkBuffBarOptions.alpha
	end
	if not self.Layout.icon or self.Layout.icon ~= ElkBuffBarOptions.icon then
		for i = 1, self.numBuffButtons do
			self:UpdateButtonIcon(i)
		end
		self.Layout.icon = ElkBuffBarOptions.icon
	end
	if not self.Layout.sort or self.Layout.sort ~= ElkBuffBarOptions.sort then
		self:UpdateBuffs()
		self.Layout.sort = ElkBuffBarOptions.sort
	end
	if not self.Layout.timer or self.Layout.timer ~= ElkBuffBarOptions.timer then
		for i = 1, self.numBuffButtons do
			self:UpdateButtonTimer(i)
		end
		self.Layout.timer = ElkBuffBarOptions.timer
	end
	if (not self.Layout.invert and ElkBuffBarOptions.invert) or (self.Layout.invert and not ElkBuffBarOptions.invert) then
		self:UpdateButtonPositions()
		self.Layout.invert = ElkBuffBarOptions.invert
	end
	if not self.Layout.spacing or self.Layout.spacing ~= ElkBuffBarOptions.spacing then
		self:UpdateButtonPositions()
		self.Layout.spacing = ElkBuffBarOptions.spacing
	end
	if not self.Layout.group or self.Layout.group ~= ElkBuffBarOptions.group then
		self:UpdateButtonPositions()
		self.Layout.group = ElkBuffBarOptions.group
	end
	if not self.Layout.dbcolor or self.Layout.dbcolor ~= ElkBuffBarOptions.dbcolor then
		self:UpdateBuffs()
		self.Layout.dbcolor = ElkBuffBarOptions.dbcolor
	end
end

function ElkBuffBar:UpdateButtonHeight(buttonid)
	local button = getglobal("ElkBuffButton"..buttonid)
	local icon = getglobal("ElkBuffButton"..buttonid.."Icon")
	button:SetHeight(ElkBuffBarOptions.height)
	icon:SetWidth(ElkBuffBarOptions.height)
	icon:SetHeight(ElkBuffBarOptions.height)
	self:UpdateButtonIcon(buttonid)
	self:UpdateButtonPositions(true)
end

function ElkBuffBar:UpdateButtonIcon(buttonid)
	local button = getglobal("ElkBuffButton"..buttonid)
	local icon = getglobal("ElkBuffButton"..buttonid.."Icon")
	local bar = getglobal("ElkBuffButton"..buttonid.."TimeBar")
	if ElkBuffBarOptions.icon == "LEFT" then
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", button, "TOPLEFT")
		icon:Show()
		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", button, "TOPLEFT", ElkBuffBarOptions.height, 0)
		bar:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT")
	elseif ElkBuffBarOptions.icon == "RIGHT" then
		icon:ClearAllPoints()
		icon:SetPoint("TOPRIGHT", button, "TOPRIGHT")
		icon:Show()
		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", button, "TOPLEFT")
		bar:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -ElkBuffBarOptions.height, 0)
	else
		icon:Hide()
		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", button, "TOPLEFT")
		bar:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT")
	end
end

function ElkBuffBar:UpdateButtonTimer(buttonid)
	local name = getglobal("ElkBuffButton"..buttonid.."DescribeText")
	local duration = getglobal("ElkBuffButton"..buttonid.."DurationText")
	if ElkBuffBarOptions.timer == "NONE" then
		name:SetPoint("RIGHT", -2, 0)
		duration:SetText("")
		duration:Hide()
	else
		name:SetPoint("RIGHT", -35, 0)
		duration:SetText("")
		duration:Show()
	end
end

function ElkBuffBar:UpdateButtonPosition(buttonid, space)
	local space = space or 0
	local button = getglobal("ElkBuffButton"..buttonid)
	button:ClearAllPoints()
	button:SetPoint("LEFT", self.frame, "LEFT")
	button:SetPoint("RIGHT", self.frame, "RIGHT")
	if buttonid > 1 then
		if (ElkBuffBarOptions.invert) then
			button:SetPoint("BOTTOM", getglobal("ElkBuffButton"..(buttonid-1)), "TOP", 0, space)
		else
			button:SetPoint("TOP", getglobal("ElkBuffButton"..(buttonid-1)), "BOTTOM", 0, -space)
		end
	else
		if (ElkBuffBarOptions.invert) then
			button:SetPoint("BOTTOM", self.frame, "BOTTOM")
		else
			button:SetPoint("TOP", self.frame, "TOP")
		end
	end
end

function ElkBuffBar:UpdateButtonPositions(onlyheight)
	if self.numBuffsShown > 0 then
		local groupspacer = 0
		local lasttype
		for i = 1, self.numBuffsShown do
			local button = getglobal("ElkBuffButton"..i)
			if lasttype and button.type ~= lasttype then
				if not onlyheight then
					self:UpdateButtonPosition(i, ElkBuffBarOptions.spacing + ElkBuffBarOptions.group)
				end
				groupspacer = groupspacer + 1
			elseif not onlyheight then
				self:UpdateButtonPosition(i, ElkBuffBarOptions.spacing)
			end
			lasttype = button.type
		end
		self.frame:SetHeight(self.numBuffsShown * ElkBuffBarOptions.height + (self.numBuffsShown - 1) * ElkBuffBarOptions.spacing + groupspacer * ElkBuffBarOptions.group)
	else
		self.frame:SetHeight(ElkBuffBarOptions.height)
	end
end

function ElkBuffBar:SlashCommandHandler(msg)
	local _, _, carg1, carg2 = string.find(msg, "^([^ ]+)$")
	if not carg1 then
		_, _, carg1, carg2 = string.find(msg, "^([^ ]+)[ ]+([^ ]+)")
	end
	if carg1 then
		carg1 = string.lower(carg1)
	end
-- print("|cffffff00[ElkBuffBar]|r msg is >|cffff0000"..(msg or "NIL").."|r<, carg1 is >|cffff0000"..(carg1 or "NIL").."|r<, carg2 is >|cffff0000"..(carg2 or "NIL").."|r<")
	if not carg1 then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r command line options:")
		DEFAULT_CHAT_FRAME:AddMessage(" - reset : resets all values to default")
		DEFAULT_CHAT_FRAME:AddMessage(" - resetpos : resets position and scale to default")
		DEFAULT_CHAT_FRAME:AddMessage(" - width [100+] : sets the button's width (is |cffff0000"..ElkBuffBarOptions.width.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - height [10+] : sets the button's height (is |cffff0000"..ElkBuffBarOptions.height.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - scale [0.0+] : sets the button's scale (is |cffff0000"..ElkBuffBarOptions.scale.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - anchor [TOPLEFT/-RIGHT/BOTTOMLEFT/-RIGHT] : sets anchor (is |cffff0000"..ElkBuffBarOptions.anchor.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - locked [TRUE/FALSE] : toggles locked state (is |cffff0000"..(ElkBuffBarOptions.locked and "TRUE" or "FALSE").."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - alpha [0.0-1.0] : sets the button's alpha value (is |cffff0000"..ElkBuffBarOptions.alpha.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - icon [LEFT/RIGHT/NONE] : sets the icon positions (is |cffff0000"..ElkBuffBarOptions.icon.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - sort [DEFAULT/TIMEMAX/TIMELEFT] : sets the sort style (is |cffff0000"..ElkBuffBarOptions.sort.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - timer [DEFAULT/NONE/FULL] : sets the timer style (is |cffff0000"..ElkBuffBarOptions.timer.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - invert [TRUE/FALSE] : toggles inverting of buffs (is |cffff0000"..(ElkBuffBarOptions.invert and "TRUE" or "FALSE").."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - spacing [0+] : set space between bars (is |cffff0000"..ElkBuffBarOptions.spacing.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - group [0+] : set additionsl space between the buff groups (is |cffff0000"..ElkBuffBarOptions.group.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage(" - dbcolor [TRUE/FALSE] : toggles type colored debuffs (is |cffff0000"..(ElkBuffBarOptions.dbcolor and "TRUE" or "FALSE").."|r)")
	elseif carg1 == "reset" then
		ElkBuffBarOptions = nil
		self:InitSettings()
	elseif carg1 == "resetpos" then
		ElkBuffBarOptions.scale = nil
		ElkBuffBarOptions.x = nil
		ElkBuffBarOptions.y = nil
		self:InitSettings()
	elseif carg1 == "width" then
		if carg2 then
			carg2 = floor(tonumber(carg2))
			if carg2 < 100 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r WIDTH must be >= 100")
			else
				ElkBuffBarOptions.width = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r WIDTH now set to |cffff0000"..ElkBuffBarOptions.width.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r WIDTH is |cffff0000"..ElkBuffBarOptions.width.."|r")
		end
	elseif carg1 == "height" then
		if carg2 then
			carg2 = floor(tonumber(carg2))
			if carg2 < 10 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r HEIGHT must be >= 10")
			else
				ElkBuffBarOptions.height = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r HEIGHT now set to |cffff0000"..ElkBuffBarOptions.height.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r HEIGHT is |cffff0000"..ElkBuffBarOptions.height.."|r")
		end
	elseif carg1 == "scale" then
		if carg2 then
			carg2 = tonumber(carg2)
			if carg2 <= 0 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SCALE must be > 0.0")
			else
				ElkBuffBarOptions.scale = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SCALE now set to |cffff0000"..ElkBuffBarOptions.scale.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SCALE is |cffff0000"..ElkBuffBarOptions.scale.."|r")
		end
	elseif carg1 == "anchor" then
		if carg2 then
			carg2 = string.upper(carg2)
			if carg2 ~= "TOPLEFT" and carg2 ~= "TOPRIGHT" and carg2 ~= "BOTTOMLEFT" and carg2 ~= "BOTTOMRIGHT" then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ANCHOR must be TOPLEFT, TOPRIGHT, BOTTOMLEFT or BOTTOMRIGHT")
			else
				ElkBuffBarOptions.anchor = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ANCHOR now set to |cffff0000"..ElkBuffBarOptions.anchor.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ANCHOR is |cffff0000"..ElkBuffBarOptions.anchor.."|r")
		end
	elseif carg1 == "locked" then
		if carg2 then
			carg2 = string.lower(carg2)
			if carg2 ~= "true" and carg2 ~= "false" then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r LOCKED must be TRUE or FALSE")
			else
				if carg2 == "true" then
					ElkBuffBarOptions.locked = true
				else
					ElkBuffBarOptions.locked = nil
				end
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r LOCKED now set to |cffff0000"..(ElkBuffBarOptions.locked and "TRUE" or "FALSE").."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r LOCKED is |cffff0000"..(ElkBuffBarOptions.locked and "TRUE" or "FALSE").."|r")
		end
	elseif carg1 == "alpha" then
		if carg2 then
			carg2 = tonumber(carg2)
			if carg2 < 0 or carg2 > 1 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ALPHA must be >= 0.0 and <= 1.0")
			else
				ElkBuffBarOptions.alpha = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ALPHA now set to |cffff0000"..ElkBuffBarOptions.alpha.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ALPHA is |cffff0000"..ElkBuffBarOptions.alpha.."|r")
		end
	elseif carg1 == "icon" then
		if carg2 then
			carg2 = string.upper(carg2)
			if carg2 ~= "LEFT" and carg2 ~= "RIGHT" and carg2 ~= "NONE" then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ICON must be LEFT, RIGHT or NONE")
			else
				ElkBuffBarOptions.icon = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ICON now set to |cffff0000"..ElkBuffBarOptions.icon.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r ICON is |cffff0000"..ElkBuffBarOptions.icon.."|r")
		end
	elseif carg1 == "sort" then
		if carg2 then
			carg2 = string.upper(carg2)
			if carg2 ~= "DEFAULT" and carg2 ~= "TIMEMAX" and carg2 ~= "TIMELEFT" then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SORT must be DEFAULT, TIMEMAX or TIMELEFT")
			else
				ElkBuffBarOptions.sort = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SORT now set to |cffff0000"..ElkBuffBarOptions.sort.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SORT is |cffff0000"..ElkBuffBarOptions.sort.."|r")
		end
	elseif carg1 == "timer" then
		if carg2 then
			carg2 = string.upper(carg2)
			if carg2 ~= "DEFAULT" and carg2 ~= "NONE" and carg2 ~= "FULL" then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r TIMER must be DEFAULT, NONE or FULL")
			else
				ElkBuffBarOptions.timer = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r TIMER now set to |cffff0000"..ElkBuffBarOptions.timer.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r TIMER is |cffff0000"..ElkBuffBarOptions.timer.."|r")
		end
	elseif carg1 == "invert" then
		if carg2 then
			carg2 = string.lower(carg2)
			if carg2 ~= "true" and carg2 ~= "false" then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r INVERT must be TRUE or FALSE")
			else
				if carg2 == "true" then
					ElkBuffBarOptions.invert = true
				else
					ElkBuffBarOptions.invert = nil
				end
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r INVERT now set to |cffff0000"..(ElkBuffBarOptions.invert and "TRUE" or "FALSE").."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r INVERT is |cffff0000"..(ElkBuffBarOptions.invert and "TRUE" or "FALSE").."|r")
		end
	elseif carg1 == "spacing" then
		if carg2 then
			carg2 = floor(tonumber(carg2))
			if carg2 < 0 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SPACING must be >= 0")
			else
				ElkBuffBarOptions.spacing = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SPACING now set to |cffff0000"..ElkBuffBarOptions.spacing.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r SPACING is |cffff0000"..ElkBuffBarOptions.spacing.."|r")
		end
	elseif carg1 == "group" then
		if carg2 then
			carg2 = floor(tonumber(carg2))
			if carg2 < 0 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r GROUP must be >= 0")
			else
				ElkBuffBarOptions.group = carg2
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r GROUP now set to |cffff0000"..ElkBuffBarOptions.group.."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r GROUP is |cffff0000"..ElkBuffBarOptions.group.."|r")
		end
	elseif carg1 == "dbcolor" then
		if carg2 then
			carg2 = string.lower(carg2)
			if carg2 ~= "true" and carg2 ~= "false" then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r DBCOLOR must be TRUE or FALSE")
			else
				if carg2 == "true" then
					ElkBuffBarOptions.dbcolor = true
				else
					ElkBuffBarOptions.dbcolor = nil
				end
				self:UpdateLayout()
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r DBCOLOR now set to |cffff0000"..(ElkBuffBarOptions.dbcolor and "TRUE" or "FALSE").."|r")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r DBCOLOR is |cffff0000"..(ElkBuffBarOptions.dbcolor and "TRUE" or "FALSE").."|r")
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[ElkBuffBar]|r "..carg1.." is no valid parameter.")
	end	
end

ElkBuffBar:Init()
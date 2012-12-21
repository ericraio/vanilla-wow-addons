DurabilityFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceHook-2.0", "AceConsole-2.0")

DurabilityFu:RegisterDB("DurabilityFuDB")
DurabilityFu:RegisterDefaults('profile', {
	showPopup = true,
	showMan = false,
	showAverage = false,
	showHealthy = true,
	popupX = 0,
	popupY = -200,
	autoRepairEquipment = false,
	autoRepairInventory = false,
})

DurabilityFu.version = "2.0." .. string.sub("$Revision: 9763 $", 12, -3)
DurabilityFu.date = string.sub("$Date: 2006-09-01 11:45:46 -1000 (Fri, 01 Sep 2006) $", 8, 17)
DurabilityFu.hasIcon = true
DurabilityFu.canHideText = true

local L = AceLibrary("AceLocale-2.0"):new("FuBar_DurabilityFu")

local Gratuity = AceLibrary("Gratuity-2.0")
local Tablet = AceLibrary("Tablet-2.0")
local Abacus = AceLibrary("Abacus-2.0")
local Crayon = AceLibrary("Crayon-2.0")

local TEXT_SERGEANT, TEXT_HONORED
if AceLibrary("AceDB-2.0").FACTION == FACTION_HORDE then
	TEXT_SERGEANT = PVP_RANK_7_0
else
	TEXT_SERGEANT = PVP_RANK_7_1
end
TEXT_HONORED = FACTION_STANDING_LABEL6

function DurabilityFu:IsShowingPopup()
	return self.db.profile.showPopup
end

function DurabilityFu:ToggleShowingPopup()
	self.db.profile.showPopup = not self.db.profile.showPopup
end

function DurabilityFu:IsAutoRepairingEquipment()
	return self.db.profile.autoRepairEquipment
end

function DurabilityFu:ToggleAutoRepairingEquipment()
	self.db.profile.autoRepairEquipment = not self.db.profile.autoRepairEquipment
end

function DurabilityFu:IsAutoRepairingInventory()
	return self.db.profile.autoRepairInventory
end

function DurabilityFu:ToggleAutoRepairingInventory()
	self.db.profile.autoRepairInventory = not self.db.profile.autoRepairInventory
end

function DurabilityFu:IsShowingMan()
	return self.db.profile.showMan
end

function DurabilityFu:ToggleShowingMan()
	self.db.profile.showMan = not self.db.profile.showMan
--[[	if self.db.profile.showMan and self.manX ~= nil and self.manY ~= nil then
		DurabilityFrame:ClearAllPoints()
		DurabilityFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", self.manX, self.manY)
	elseif DurabilityFrame:GetRight() ~= nil and DurabilityFrame:GetTop() ~= nil then
		self.manX = DurabilityFrame:GetRight() - GetScreenWidth()
		self.manY = DurabilityFrame:GetTop() - GetScreenHeight()
		DurabilityFrame:ClearAllPoints()
		DurabilityFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", self.manX + 3000, self.manY + 3000)
	end]]
	DurabilityFrame_SetAlerts()
end

function DurabilityFu:IsShowingAverage()
	return self.db.profile.showAverage
end

function DurabilityFu:ToggleShowingAverage()
	self.db.profile.showAverage = not self.db.profile.showAverage
	self:Update()
end

function DurabilityFu:IsShowingHealthyItems()
	return self.db.profile.showHealthy
end

function DurabilityFu:ToggleShowingHealthyItems()
	self.db.profile.showHealthy = not self.db.profile.showHealthy
	self:UpdateTooltip()
end

function DurabilityFu:OnEnable()
	self.repairIndex = 0
	self.repairMoney = 0
	self.itemStatus = {
		{ value = 0, max = 0, cost = 0, name = INVTYPE_HEAD, slot = "Head" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_SHOULDER, slot = "Shoulder" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_CHEST, slot = "Chest" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_WAIST, slot = "Waist" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_LEGS, slot = "Legs" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_FEET, slot = "Feet" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_WRIST, slot = "Wrist" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_HAND, slot = "Hands" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_WEAPONMAINHAND, slot = "MainHand" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_WEAPONOFFHAND, slot = "SecondaryHand" },
		{ value = 0, max = 0, cost = 0, name = INVTYPE_RANGED, slot = "Ranged" },
		{ value = 0, max = 0, cost = 0, name = INVENTORY_TOOLTIP },
	}
	
	self:RegisterEvent("PLAYER_UNGHOST", "OnBagUpdate")
	self:RegisterEvent("PLAYER_DEAD", "OnBagUpdate")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnBagUpdate")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS")
	self:RegisterEvent("MERCHANT_SHOW")
	self:RegisterEvent("MERCHANT_CLOSED")
	self:RegisterEvent("FACTION_UPDATE")
	
	self:Hook("DurabilityFrame_SetAlerts")
	DurabilityFrame_SetAlerts()
end

function DurabilityFu:OnDisable()
	StaticPopup_Hide("BOSSPANEL_DURABILITY_POPUP")
	if not self.db.profile.showMan then
		self:ToggleShowingMan()
		self.db.profile.showMan = false
	end
end

local options = {
	type = 'group',
	args = {
		popup = {
			type = 'toggle',
			name = L["Show repair popup at vendor"],
			desc = L["Toggle whether to show the popup at the merchant window"],
			get = "IsShowingPopup",
			set = "ToggleShowingPopup",
		},
		showMan = {
			type = 'toggle',
			name = L["Show the armored man"],
			desc = L["Toggle whether to show Blizzard's armored man"],
			get = "IsShowingMan",
			set = "ToggleShowingMan",
		},
		average = {
			type = 'toggle',
			name = L["Show average value"],
			desc = L["Toggle whether to show your average or minimum durability"],
			get = "IsShowingAverage",
			set = "ToggleShowingAverage",
		},
		healthy = {
			type = 'toggle',
			name = L["Show healthy items"],
			desc = L["Toggle whether to show items that are healthy (100% repaired)"],
			get = "IsShowingHealthyItems",
			set = "ToggleShowingHealthyItems",
		},
		autoRepair = {
			type = 'group',
			name = L["Auto repair"],
			desc = L["Auto repair"],
			args = {
				equipment = {
					type = 'toggle',
					name = L["Equipment"],
					desc = L["Equipment"],
					get = "IsAutoRepairingEquipment",
					set = "ToggleAutoRepairingEquipment",
				},
				inventory = {
					type = 'toggle',
					name = L["Inventory"],
					desc = L["Inventory"],
					get = "IsAutoRepairingInventory",
					set = "ToggleAutoRepairingInventory",
				},
			}
		},
	},
	handler = DurabilityFu,
}

DurabilityFu:RegisterChatCommand(L["AceConsole-Commands"], options)
DurabilityFu.OnMenuRequest = options

function DurabilityFu:PLAYER_ENTERING_WORLD()
	if not self.isHonored then
		for i = 1, GetNumFactions() do
			local _, _, standing = GetFactionInfo(i)
			if standing >= 6 then
				self.isHonored = true
				break
			end
		end
	end
	if not self.isSergeant then
		local _, rankNumber = GetPVPRankInfo(UnitPVPRank("player"))
		if rankNumber >= 3 then
			self.isSergeant = true
		end
	end
end

function DurabilityFu:FACTION_UPDATE()
	if GetNumFactions() > 0 and not self.isHonored then
		for i = 1, GetNumFactions() do
			local _, _, standing = GetFactionInfo(i)
			if standing >= 6 then
				self.isHonored = true
				break
			end
		end
		self:UnregisterEvent("FACTION_UPDATE")
	elseif self.isHonored then
		self:UnregisterEvent("FACTION_UPDATE")
	end
end

local lastUpdate
function DurabilityFu:UpdateBagData()
	if lastUpdate and GetTime() - lastUpdate < 1 then
		return
	end
	lastUpdate = GetTime()
	local minStatus = 1.0
	local minValue = 0
	local minMax = 0
	
	self.itemStatus[12].value = 0
	self.itemStatus[12].max = 0
	self.itemStatus[12].cost = 0
	
	for bag = 0, 4 do	
		for slot = 1, GetContainerNumSlots(bag) do
	
			local status, value, max, cost = self:GetStatus(slot, bag)
			if not self:IsShowingAverage() then
				if status ~= nil and status < minStatus then
					minStatus = status
					minValue = value
					minMax = max
					
					if (self.repairIndex == 0 or status < self:GetPercent(self.itemStatus[self.repairIndex].value, self.itemStatus[self.repairIndex].max)) and max ~= 0 then
						self.repairIndex = 12
					end
					
					self.itemStatus[12].value = value
					self.itemStatus[12].max = max
				end
			elseif cost ~= nil then
				self.itemStatus[12].value = self.itemStatus[12].value + value
				self.itemStatus[12].max = self.itemStatus[12].max + max
			end
			if cost ~= nil then
				self.itemStatus[12].cost = self.itemStatus[12].cost + cost
			end
		end
	end
	if self:IsShowingAverage() then
		local status = self:GetPercent(self.itemStatus[12].value, self.itemStatus[12].max)
		if (self.repairIndex == 0 or status < self:GetPercent(self.itemStatus[self.repairIndex].value, self.itemStatus[self.repairIndex].max)) and self.itemStatus[12].max ~= 0 then
			self.repairIndex = 12
		end
	end
end

function DurabilityFu:OnBagUpdate()
	self:UpdateBagData()
	self:UpdateText()
	self:UpdateTooltip()
end

local lastUpdate
function DurabilityFu:UpdateInventoryData(toCheck)
	if lastUpdate and GetTime() - lastUpdate < 1 then
		return
	end
	lastUpdate = GetTime()
	if toCheck == nil then
		toCheck = {}
		for i = 1, 11 do
			toCheck[i] = true
		end
	end
	
	local minStatus = 1.0
	local minValue = 0
	local minMax = 0
	local minIndex = 0
	
	for index,_ in toCheck do
		local status, value, max, cost = self:GetStatus(index)
		if status ~= nil and status < minStatus then
			minStatus = status
			minValue = value
			minMax = max
			minIndex = index
		end
		
		self.itemStatus[index].value = value or 0
		self.itemStatus[index].max = max or 0
		self.itemStatus[index].cost = cost or 0
	end

	self.repairIndex = minIndex
	
	if not self:IsShowingMan() then
		self.db.profile.showMan = true
		self:ToggleShowingMan()
	end
end

function DurabilityFu:UPDATE_INVENTORY_ALERTS()
	self:UpdateInventoryData(INVENTORY_ALERT_STATUS_SLOTS)
	self:UpdateText()
	self:UpdateTooltip()
end

function DurabilityFu:MERCHANT_SHOW()
	local dirty = false
	local stop = false
	if CanMerchantRepair() then
		if self:IsAutoRepairingEquipment() then
			local repairCost = GetRepairAllCost()
			local money = GetMoney()
			if money < repairCost then
				self:Print("Cannot auto-repair equipment. Your money: %s. Needed: %s", Abacus:FormatMoneyFull(money, true), Abacus:FormatMoneyFull(repairCost, true))
				stop = true
			elseif repairCost > 0 then
				RepairAllItems()
				self:Print("Auto-repaired equipment: %s", Abacus:FormatMoneyFull(repairCost))
				dirty = true
			else
				self:Print("No equipment to auto-repair")
			end
		end
		if not stop and self:IsAutoRepairingInventory() then
			local repairCost = self:CalculateInventoryCost()
			local money = GetMoney()
			if money < repairCost then
				self:Print("Cannot auto-repair inventory. Your money: %s. Needed: %s", Abacus:FormatMoneyFull(money, true), Abacus:FormatMoneyFull(repairCost, true))
			elseif repairCost > 0 then
				ShowRepairCursor()
				for bag = 0, 4 do
					for slot = 1, GetContainerNumSlots(bag) do
						local _,repairCost = Gratuity:SetBagItem(bag, slot)
						if repairCost ~= nil and repairCost > 0 then
							PickupContainerItem(bag, slot)
						end
					end
				end
				HideRepairCursor()
				self:Print("Auto-repaired inventory: %s", Abacus:FormatMoneyFull(repairCost))
				dirty = true
			else
				self:Print("No items in inventory to auto-repair")
			end
		end
	end
	self.merchantShown = true
	if self:IsShowingPopup() then
		local canRepair, repairCost = CanMerchantRepair(), GetRepairAllCost()
		if canRepair then
			repairCost = repairCost + self:CalculateInventoryCost()
			if repairCost > 0 then
				if dirty then
					self:ScheduleEvent(self.OpenPopup, 1, self)
				else
					self:OpenPopup()
				end
			end
		end
	end
	self:ScheduleRepeatingEvent(self.name, self.OnUpdate, 1, self)
	self.updateNum = nil
	self:Update()
end

function DurabilityFu:MERCHANT_CLOSED()
	self.merchantShown = false
	self:ClosePopup()
	self:ScheduleRepeatingEvent(self.name, self.OnUpdate, 1, self)
	self.updateNum = nil
	self:Update()
end

function DurabilityFu:CalculateInventoryCost()
	local result = 0
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local _,repairCost = Gratuity:SetBagItem(bag, slot)
			if repairCost ~= nil and repairCost > 0 then
				result = result + repairCost
			end
		end
	end
	
	return result
end

function DurabilityFu:GetPercent(quotient, denominator)
	if denominator ~= 0 then
		return quotient / denominator
	else
		return 1
	end
end

function DurabilityFu:GetStatus(index, bag)
	local value = 0
	local max = 0
	local cost = 0
	
	local hasItem, repairCost
	if bag ~= nil then
		_,repairCost = Gratuity:SetBagItem(bag, index)
		hasItem = GetContainerItemInfo(bag, index) ~= nil
	else
		local slotName = self.itemStatus[index].slot .. "Slot"
		
		local id = GetInventorySlotInfo(slotName)
		hasItem,_,repairCost = Gratuity:SetInventoryItem("player", id)
	end
	
	if hasItem then
		if repairCost ~= nil then
			cost = repairCost
		end
		
		local value, max = Gratuity:FindDeformat(DURABILITY_TEMPLATE, nil, nil, nil, true)
		if value then
			value = tonumber(value)
			max = tonumber(max)
			return self:GetPercent(value, max), value, max, cost
		end
	end
end

function DurabilityFu:OnDataUpdate()
	self:UpdateBagData()
	self:UpdateInventoryData()
end

function DurabilityFu:OnTextUpdate()
	local percent
	if not self:IsShowingAverage() then
		if self.repairIndex == 0 then
			percent = 1
		else
			percent = self:GetPercent(self.itemStatus[self.repairIndex].value, self.itemStatus[self.repairIndex].max)
		end
	else
		local value = 0
		local max = 0
		for i,item in self.itemStatus do
			if i ~= 12 then
				value = value + item.value
				max = max + item.max
			end
		end
		percent = self:GetPercent(value, max)
	end
	self:SetText(string.format("|cff%s%d%%|r", Crayon:GetThresholdHexColor(percent), percent * 100))
end

function DurabilityFu:OnTooltipUpdate()
	local cost = 0
	local cat = Tablet:AddCategory(
		'columns', 3,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0
	)
	for index, item in self.itemStatus do
		if item.max > 0 then
			cost = cost + item.cost
			local percent = self:GetPercent(item.value, item.max)
			if self:IsShowingHealthyItems() or percent < 1 then
				local r, g, b = Crayon:GetThresholdColor(percent)
				cat:AddLine(
					'text', item.name,
					'text2', string.format("%.0f%%", percent * 100),
					'text2R', r,
					'text2G', g,
					'text2B', b,
					'text3', Abacus:FormatMoneyShort(item.cost, true)
				)
			end
		end
	end
	local value = 0
	local max = 0
	for i,item in self.itemStatus do
		if i ~= 12 then
			value = value + item.value
			max = max + item.max
		end
	end
	cat = Tablet:AddCategory(
		'columns', 2,
		'text', L["Total"],
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	local r, g, b = Crayon:GetThresholdColor(value / max)
	cat:AddLine(
		'text', L["Percent"],
		'text2', string.format("%.0f%%", value / max * 100),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	cat:AddLine(
		'text', L["Repair cost"],
		'text2', Abacus:FormatMoneyFull(cost, true)
	)
	if not self.merchantShown then
		if self.isSergeant then
			if self.isHonored then
			cat:AddLine(
				'text', TEXT_HONORED .. " / " .. TEXT_SERGEANT,
				'text2', Abacus:FormatMoneyFull(cost * 0.9, true)
			)
			cat:AddLine(
				'text', TEXT_HONORED .. " & " .. TEXT_SERGEANT,
				'text2', Abacus:FormatMoneyFull(cost * 0.8, true)
			)
			else
			cat:AddLine(
				'text', TEXT_SERGEANT,
				'text2', Abacus:FormatMoneyFull(cost * 0.9, true)
			)
			end
		elseif self.isHonored then
			cat:AddLine(
				'text', TEXT_HONORED,
				'text2', Abacus:FormatMoneyFull(cost * 0.9, true)
			)
		end
	end
end

function DurabilityFu:PromptEquipment_OnClick()
	RepairAllItems()
	self:ClosePopup()
	self:Update()
end

function DurabilityFu:PromptInventory_OnClick()
	ShowRepairCursor()
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local _,repairCost = Gratuity:SetBagItem(bag, slot)
			if repairCost ~= nil and repairCost > 0 then
				PickupContainerItem(bag, slot)
			end
		end
	end
	HideRepairCursor()
	self:ClosePopup()
	self:Update()
	self:ScheduleRepeatingEvent(self.name, self.OnUpdate, 1, self)
end

function DurabilityFu:OnUpdate()
	if self.updateNum == nil then
		self.updateNum = 0
	end
	self:Update()
	self.updateNum = self.updateNum + 1
	if self.updateNum >= 5 then
		self:CancelScheduledEvent(self.name)
		self.updateNum = 0
	end
end

function DurabilityFu:PromptBoth_OnClick()
	RepairAllItems()
	self:PromptInventory_OnClick()
end

local popup
function DurabilityFu:ClosePopup()
	if popup then
		popup:Hide()
	end
end

local buttonSize = 32

function DurabilityFu:OpenPopup()
	local canRepair, repairCost = CanMerchantRepair(), GetRepairAllCost()
	if not canRepair then
		return
	end
	repairCost = repairCost + self:CalculateInventoryCost()
	if repairCost == 0 then
		return
	end
	if not popup then
		popup = CreateFrame("Frame", "DurabilityFuPrompt", UIParent)
		popup:SetFrameStrata("DIALOG")
		popup:EnableMouse(true)
		popup:SetMovable(true)
		popup:Hide()
		popup:SetWidth(256)
		popup:SetHeight(160)
		popup:SetPoint("TOP", UIParent, "TOP", self.db.profile.popupX, self.db.profile.popupY)
		
		local header = CreateFrame("Frame", popup:GetName() .. "Header", popup)
		header:SetWidth(192)
		header:SetHeight(32)
		header:SetPoint("TOP", popup, "TOP", 0, 6)
		local texture = header:CreateTexture(popup:GetName() .. "HeaderBar", "ARTWORK")
		texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		texture:SetWidth(384)
		texture:SetHeight(64)
		texture:SetPoint("TOP", header, "TOP", 0, 5)
		texture:Show()
		local text = header:CreateFontString(popup:GetName() .. "HeaderTitle", "ARTWORK")
		text:SetFontObject(GameFontNormal)
		text:SetPoint("CENTER", header, "CENTER", 0, 0)
		text:SetText(self:GetTitle() .. " " .. L["Repair"])
		header:EnableMouse(true)
		header:SetMovable(true)
		header:SetScript("OnMouseDown", function()
			popup:StartMoving()
		end)
		header:SetScript("OnMouseUp", function()
			popup:StopMovingOrSizing()
			self.db.profile.popupY = popup:GetTop() - GetScreenHeight()
			self.db.profile.popupX = popup:GetCenter() - GetScreenWidth() / 2
		end)
		
		local eqButton = CreateFrame("Button", popup:GetName() .. "EquipmentButton", popup)
		popup.eqButton = eqButton
		eqButton:SetWidth(buttonSize)
		eqButton:SetHeight(buttonSize)
		local texture = eqButton:CreateTexture()
		texture:SetWidth(buttonSize * 1.6458333)
		texture:SetHeight(buttonSize * 1.6458333)
		texture:SetPoint("CENTER", eqButton, "CENTER")
		texture:SetTexture("Interface\\Buttons\\UI-Quickslot2")
		eqButton:SetNormalTexture(texture)
		local texture = eqButton:CreateTexture(nil, "BACKGROUND")
		texture:SetTexture("Interface\\Icons\\INV_Chest_Leather_08")
		texture:SetAllPoints(eqButton)
		eqButton:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
		local texture = eqButton:CreateTexture()
		texture:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
		texture:SetAllPoints(eqButton)
		eqButton:SetHighlightTexture(texture)
		local texture = eqButton:CreateTexture()
		texture:SetTexture("Interface\\Icons\\INV_Chest_Leather_08")
		texture:SetDesaturated(true)
		texture:SetAllPoints(eqButton)
		eqButton:SetDisabledTexture(texture)
		eqButton:SetPoint("TOPRIGHT", popup, "TOPRIGHT", -18, -36)
		eqButton:SetScript("OnClick", function()
			self:PromptEquipment_OnClick()
		end)
		local texture = eqButton:CreateTexture(nil, "ARTWORK")
		texture:SetTexture(0, 0, 0, 0.5)
		texture:SetAllPoints(eqButton)
		local button_Enable = eqButton.Enable
		function eqButton:Enable()
			button_Enable(self)
			texture:Hide()
		end
		local button_Disable = eqButton.Disable
		function eqButton:Disable()
			button_Disable(self)
			texture:Show()
		end
		
		local invButton = CreateFrame("Button", popup:GetName() .. "InventoryButton", popup)
		popup.invButton = invButton
		invButton:SetWidth(buttonSize)
		invButton:SetHeight(buttonSize)
		local texture = invButton:CreateTexture()
		texture:SetWidth(buttonSize * 1.6458333)
		texture:SetHeight(buttonSize * 1.6458333)
		texture:SetPoint("CENTER", invButton, "CENTER")
		texture:SetTexture("Interface\\Buttons\\UI-Quickslot2")
		invButton:SetNormalTexture(texture)
		local texture = invButton:CreateTexture(nil, "BACKGROUND")
		texture:SetTexture("Interface\\Icons\\INV_Misc_Bag_10")
		texture:SetAllPoints(invButton)
		invButton:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
		local texture = invButton:CreateTexture()
		texture:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
		texture:SetAllPoints(invButton)
		invButton:SetHighlightTexture(texture)
		local texture = invButton:CreateTexture()
		texture:SetTexture("Interface\\Icons\\INV_Misc_Bag_10")
		texture:SetDesaturated(true)
		texture:SetAllPoints(invButton)
		invButton:SetDisabledTexture(texture)
		invButton:SetPoint("TOP", eqButton, "BOTTOM", 0, -8)
		invButton:SetScript("OnClick", function()
			self:PromptInventory_OnClick()
		end)
		local texture = invButton:CreateTexture(nil, "ARTWORK")
		texture:SetTexture(0, 0, 0, 0.5)
		texture:SetAllPoints(invButton)
		local button_Enable = invButton.Enable
		function invButton:Enable()
			button_Enable(self)
			texture:Hide()
		end
		local button_Disable = invButton.Disable
		function invButton:Disable()
			button_Disable(self)
			texture:Show()
		end
		
		local bothButton = CreateFrame("Button", popup:GetName() .. "BothButton", popup)
		popup.bothButton = bothButton
		bothButton:SetWidth(buttonSize)
		bothButton:SetHeight(buttonSize)
		local texture = bothButton:CreateTexture()
		texture:SetWidth(buttonSize * 1.6458333)
		texture:SetHeight(buttonSize * 1.6458333)
		texture:SetPoint("CENTER", bothButton, "CENTER")
		texture:SetTexture("Interface\\Buttons\\UI-Quickslot2")
		bothButton:SetNormalTexture(texture)
		local texture = bothButton:CreateTexture(nil, "BACKGROUND")
		texture:SetTexture("Interface\\Icons\\Trade_Blacksmithing")
		texture:SetAllPoints(bothButton)
		bothButton:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
		local texture = bothButton:CreateTexture()
		texture:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
		texture:SetAllPoints(bothButton)
		bothButton:SetHighlightTexture(texture)
		local texture = bothButton:CreateTexture()
		texture:SetTexture("Interface\\Icons\\Trade_Blacksmithing")
		texture:SetDesaturated(true)
		texture:SetAllPoints(bothButton)
		bothButton:SetDisabledTexture(texture)
		bothButton:SetPoint("TOP", invButton, "BOTTOM", 0, -8)
		bothButton:SetScript("OnClick", function()
			self:PromptBoth_OnClick()
		end)
		local texture = bothButton:CreateTexture(nil, "ARTWORK")
		texture:SetTexture(0, 0, 0, 0.5)
		texture:SetAllPoints(bothButton)
		local button_Enable = bothButton.Enable
		function bothButton:Enable()
			button_Enable(self)
			texture:Hide()
		end
		local button_Disable = bothButton.Disable
		function bothButton:Disable()
			button_Disable(self)
			texture:Show()
		end
		
		local closeButton = CreateFrame("Button", popup:GetName() .. "CloseButton", popup)
		popup.closeButton = closeButton
		closeButton:SetWidth(32)
		closeButton:SetHeight(32)
		closeButton:SetPoint("TOPRIGHT", popup, "TOPRIGHT", 0, 0)
		closeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		closeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		local texture = closeButton:CreateTexture()
		texture:SetTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		texture:SetBlendMode("ADD")
		closeButton:SetHighlightTexture(texture)
		closeButton:SetScript("OnClick", function()
			self:ClosePopup()
		end)
		closeButton:Show()
		
		local eqCost = CreateFrame("Frame", popup:GetName() .. "EquipmentCost", popup)
		popup.eqCost = eqCost
		eqCost:SetWidth(96)
		eqCost:SetHeight(13)
		eqCost:SetPoint("RIGHT", eqButton, "LEFT", -8, 0)
		local copper = CreateFrame("Frame", eqCost:GetName() .. "Copper", eqCost)
		copper:SetWidth(32)
		copper:SetHeight(13)
		copper:SetPoint("RIGHT", eqCost, "RIGHT")
		local texture = copper:CreateTexture(copper:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", copper, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0.5, 0.75, 0, 1)
		local copperText = copper:CreateFontString(copper:GetName() .. "Text", "ARTWORK")
		copperText:SetPoint("RIGHT", texture, "LEFT")
		copperText:SetHeight(13)
		copperText:SetFontObject(NumberFontNormal)
		copperText:SetText(0)
		copperText:SetJustifyH("RIGHT")
		
		local silver = CreateFrame("Frame", eqCost:GetName() .. "Silver", eqCost)
		silver:SetWidth(32)
		silver:SetHeight(13)
		silver:SetPoint("RIGHT", copper, "LEFT")
		local texture = silver:CreateTexture(silver:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", silver, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0.25, 0.5, 0, 1)
		local silverText = silver:CreateFontString(silver:GetName() .. "Text", "ARTWORK")
		silverText:SetPoint("RIGHT", texture, "LEFT")
		silverText:SetHeight(13)
		silverText:SetFontObject(NumberFontNormal)
		silverText:SetText(0)
		silverText:SetJustifyH("RIGHT")
		
		local gold = CreateFrame("Frame", eqCost:GetName() .. "Gold", eqCost)
		gold:SetWidth(32)
		gold:SetHeight(13)
		gold:SetPoint("RIGHT", silver, "LEFT")
		local texture = gold:CreateTexture(gold:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", gold, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0, 0.25, 0, 1)
		local goldText = gold:CreateFontString(gold:GetName() .. "Text", "ARTWORK")
		goldText:SetPoint("RIGHT", texture, "LEFT")
		goldText:SetHeight(13)
		goldText:SetFontObject(NumberFontNormal)
		goldText:SetText(0)
		goldText:SetJustifyH("RIGHT")
		function eqCost:SetValue(value)
			local g = floor(value / 10000)
			local s = mod(floor(value / 100), 100)
			local c = mod(value, 100)
			goldText:SetText(g)
			silverText:SetText(s)
			copperText:SetText(c)
			if g == 0 then
				gold:Hide()
				if s == 0 then
					silver:Hide()
				else
					silver:Show()
				end
			else
				gold:Show()
				silver:Show()
			end
		end
		
		local invCost = CreateFrame("Frame", popup:GetName() .. "InventoryCost", popup)
		popup.invCost = invCost
		invCost:SetWidth(96)
		invCost:SetHeight(13)
		invCost:SetPoint("RIGHT", invButton, "LEFT", -8, 0)
		local copper = CreateFrame("Frame", invCost:GetName() .. "Copper", invCost)
		copper:SetWidth(32)
		copper:SetHeight(13)
		copper:SetPoint("RIGHT", invCost, "RIGHT")
		local texture = copper:CreateTexture(copper:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", copper, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0.5, 0.75, 0, 1)
		local copperText = copper:CreateFontString(copper:GetName() .. "Text", "ARTWORK")
		copperText:SetPoint("RIGHT", texture, "LEFT")
		copperText:SetHeight(13)
		copperText:SetFontObject(NumberFontNormal)
		copperText:SetText(0)
		copperText:SetJustifyH("RIGHT")
		
		local silver = CreateFrame("Frame", invCost:GetName() .. "Silver", invCost)
		silver:SetWidth(32)
		silver:SetHeight(13)
		silver:SetPoint("RIGHT", copper, "LEFT")
		local texture = silver:CreateTexture(silver:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", silver, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0.25, 0.5, 0, 1)
		local silverText = silver:CreateFontString(silver:GetName() .. "Text", "ARTWORK")
		silverText:SetPoint("RIGHT", texture, "LEFT")
		silverText:SetHeight(13)
		silverText:SetFontObject(NumberFontNormal)
		silverText:SetText(0)
		silverText:SetJustifyH("RIGHT")
		
		local gold = CreateFrame("Frame", invCost:GetName() .. "Gold", invCost)
		gold:SetWidth(32)
		gold:SetHeight(13)
		gold:SetPoint("RIGHT", silver, "LEFT")
		local texture = gold:CreateTexture(gold:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", gold, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0, 0.25, 0, 1)
		local goldText = gold:CreateFontString(gold:GetName() .. "Text", "ARTWORK")
		goldText:SetPoint("RIGHT", texture, "LEFT")
		goldText:SetHeight(13)
		goldText:SetFontObject(NumberFontNormal)
		goldText:SetText(0)
		goldText:SetJustifyH("RIGHT")
		function invCost:SetValue(value)
			local g = floor(value / 10000)
			local s = mod(floor(value / 100), 100)
			local c = mod(value, 100)
			goldText:SetText(g)
			silverText:SetText(s)
			copperText:SetText(c)
			if g == 0 then
				gold:Hide()
				if s == 0 then
					silver:Hide()
				else
					silver:Show()
				end
			else
				gold:Show()
				silver:Show()
			end
		end
		
		local bothCost = CreateFrame("Frame", popup:GetName() .. "BothCost", popup)
		popup.bothCost = bothCost
		bothCost:SetWidth(96)
		bothCost:SetHeight(13)
		bothCost:SetPoint("RIGHT", bothButton, "LEFT", -8, 0)
		local copper = CreateFrame("Frame", bothCost:GetName() .. "Copper", bothCost)
		copper:SetWidth(32)
		copper:SetHeight(13)
		copper:SetPoint("RIGHT", bothCost, "RIGHT")
		local texture = copper:CreateTexture(copper:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", copper, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0.5, 0.75, 0, 1)
		local copperText = copper:CreateFontString(copper:GetName() .. "Text", "ARTWORK")
		copperText:SetPoint("RIGHT", texture, "LEFT")
		copperText:SetHeight(13)
		copperText:SetFontObject(NumberFontNormal)
		copperText:SetText(0)
		copperText:SetJustifyH("RIGHT")
		
		local silver = CreateFrame("Frame", bothCost:GetName() .. "Silver", bothCost)
		silver:SetWidth(32)
		silver:SetHeight(13)
		silver:SetPoint("RIGHT", copper, "LEFT")
		local texture = silver:CreateTexture(silver:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", silver, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0.25, 0.5, 0, 1)
		local silverText = silver:CreateFontString(silver:GetName() .. "Text", "ARTWORK")
		silverText:SetPoint("RIGHT", texture, "LEFT")
		silverText:SetHeight(13)
		silverText:SetFontObject(NumberFontNormal)
		silverText:SetText(0)
		silverText:SetJustifyH("RIGHT")
		
		local gold = CreateFrame("Frame", bothCost:GetName() .. "Gold", bothCost)
		gold:SetWidth(32)
		gold:SetHeight(13)
		gold:SetPoint("RIGHT", silver, "LEFT")
		local texture = gold:CreateTexture(gold:GetName() .. "Texture", "ARTWORK")
		texture:SetPoint("RIGHT", gold, "RIGHT")
		texture:SetWidth(13)
		texture:SetHeight(13)
		texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
		texture:SetTexCoord(0, 0.25, 0, 1)
		local goldText = gold:CreateFontString(gold:GetName() .. "Text", "ARTWORK")
		goldText:SetPoint("RIGHT", texture, "LEFT")
		goldText:SetHeight(13)
		goldText:SetFontObject(NumberFontNormal)
		goldText:SetText(0)
		goldText:SetJustifyH("RIGHT")
		function bothCost:SetValue(value)
			local g = floor(value / 10000)
			local s = mod(floor(value / 100), 100)
			local c = mod(value, 100)
			goldText:SetText(g)
			silverText:SetText(s)
			copperText:SetText(c)
			if g == 0 then
				gold:Hide()
				if s == 0 then
					silver:Hide()
				else
					silver:Show()
				end
			else
				gold:Show()
				silver:Show()
			end
		end
		
		local eqLabel = popup:CreateFontString(popup:GetName() .. "EquipmentLabel", "ARTWORK")
		eqLabel:SetPoint("RIGHT", eqCost, "LEFT", -8, 0)
		eqLabel:SetFontObject(GameFontNormal)
		eqLabel:SetText(L["Equipment"])
		
		local invLabel = popup:CreateFontString(popup:GetName() .. "InventoryLabel", "ARTWORK")
		invLabel:SetPoint("RIGHT", invCost, "LEFT", -8, 0)
		invLabel:SetFontObject(GameFontNormal)
		invLabel:SetText(L["Inventory"])
		
		local bothLabel = popup:CreateFontString(popup:GetName() .. "BothLabel", "ARTWORK")
		bothLabel:SetPoint("RIGHT", bothCost, "LEFT", -8, 0)
		bothLabel:SetFontObject(GameFontNormal)
		bothLabel:SetText(L["Total"])
		
		popup:SetBackdrop({
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			edgeSize = 16,
			tileSize = 32,
			insets = {
				left = 5,
				right = 5,
				top = 5,
				bottom = 5
			}
		})
	end
	
	popup:Show()
	
	local equipment = GetRepairAllCost()
	local inventory = self:CalculateInventoryCost()
	local both = equipment + inventory
	popup.bothButton:Disable()
	if equipment == 0 then
		popup.eqButton:Disable()
	else
		popup.eqButton:Enable()
		popup.bothButton:Enable()
	end
	if inventory == 0 then
		popup.invButton:Disable()
	else
		popup.invButton:Enable()
		popup.bothButton:Enable()
	end
	popup.eqCost:SetValue(equipment)
	popup.invCost:SetValue(inventory)
	popup.bothCost:SetValue(both)
end

function DurabilityFu:DurabilityFrame_SetAlerts()
	self.hooks.DurabilityFrame_SetAlerts.orig()
	if not self:IsShowingMan() then
		DurabilityFrame:Hide()
	end
end

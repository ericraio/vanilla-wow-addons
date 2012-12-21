local MYBAGS_MAXEQUIPSLOTS  = 19
local MYBAGS_SLOTCOLOR      = { 0.5, 0.5, 0.5 }
local MYEQUIPMENT_SLOT      = {}
local SLOTNAMES             = {"HEADSLOT","NECKSLOT","SHOULDERSLOT","BACKSLOT","CHESTSLOT","SHIRTSLOT","TABARDSLOT","WRISTSLOT","HANDSSLOT","WAISTSLOT","LEGSSLOT","FEETSLOT","FINGER0SLOT","FINGER1SLOT","TRINKET0SLOT","TRINKET1SLOT","MAINHANDSLOT","SECONDARYHANDSLOT","RANGEDSLOT","AMMOSLOT"}
local MYEQUIPMENT_DEFAULT_OPTIONS = {
	Columns    = 6,
	Graphics   = "default",
	Lock       = FALSE,
	NoEsc      = FALSE,
	Title      = TRUE,
	Cash       = TRUE,
	Buttons    = TRUE,
	Border     = TRUE,
	Cache      = nil,
	Player     = FALSE,
	Scale      = FALSE,
	Anchor     = "bottomright",
	BackColor  = {0.7,0,0,0},
	SlotColor  = nil,
}
MyEquipmentClass = MyBagsCoreClass:new({
	name           = MYEQUIPMENT_NAME,
	description    = MYEQUIPMENT_DESCRIPTION,
	db             = AceDbClass:new("MyEquipmentDB"),
	defaults       = MYEQUIPMENT_DEFAULT_OPTIONS,
	frameName      = "MyEquipmentFrame",
	cmd            = AceChatCmdClass:new(MYEQUIPMENT_COMMANDS, MYEQUIPMENT_CMD_OPTIONS),
	isEquipment		= TRUE,
	anchorPoint      = "BOTTOM",
	anchorParent     = "UIParent",
	anchorOffsetX    = -5,
	anchorOffsetY    = 100,
})
function MyEquipmentClass:Enable()
	MyBagsCoreClass.Enable(self)
	MyEquipmentFramePortrait:SetTexture("Interface\\Addons\\MyBags\\Skin\\MyEquipmentPortrait")
	for key,value in SLOTNAMES do -- Just in case Blizzard shuffles the slot name table around
		local slotId = GetInventorySlotInfo(value)
		MYEQUIPMENT_SLOT[slotId] = value
	end
end
function MyEquipmentClass:Disable()
end
function MyEquipmentClass:RegisterEvents()
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "LayoutFrameOnEvent")
	self:RegisterEvent("ITEM_LOCK_CHANGED",       "LayoutFrameOnEvent")
end
function MyEquipmentClass:BAG_UPDATE() -- no bags here, move along
end
function MyEquipmentClass:GetRelic(charID)
	if self.isLive then
		return UnitHasRelicSlot("player")
	elseif KC_Items and KC_Items.equipment then
		if not MYBAGS_KC_CHARS then return nil end
		local faction = MYBAGS_KC_CHARS[charID]["faction"]
		return KC_Items.equipment:HasRelic(faction,charID)
	elseif MyBagsCache then
		return MyBagsCache:GetRelic(charID)
	end
	return nil
end
function MyEquipmentClass:GetInfoFunc()
	if self.isLive then
		return self.GetEquipInfoLive
	elseif KC_Items and KC_Items.inventory then
		return self.GetEquipInfoKC
	elseif IsAddOnLoaded("MyBagsCache") then
		return self.GetInfoMyBagsCache
	end
	return self.GetInfoNone
end
function MyEquipmentClass:GetEquipInfoKC(slot)
	if not MYBAGS_KC_CHARS then return self.GetInfoNone end
	local texture, count, ID, locked, quality, readable = nil
	local charID = self.Player
	local faction = MYBAGS_KC_CHARS[charID]["faction"]
	ID,count = KC_Items.equipment:SlotInfo(faction, charID, slot)
	if ID == "" or ID == "nil" then ID = nil end
	if ID then
		local itype,isubtype
		_,_,quality,_,itype,isubtype,_,_,texture = GetItemInfo("item:"..ID)
		_,_,_,quality = GetItemQualityColor(quality or 0)
		quality = (strsub(quality,5)) -- here instead of return to keep nil if empty slot
	end
	count = ace.tonum(count)
	return texture, count, ID, nil, quality, nil, nil
end
function MyEquipmentClass:GetEquipInfoLive(itemIndex)
	local itemLink = GetInventoryItemLink("player",itemIndex)
	local myColor, myLink, myName = nil
	local texture, count, quality = nil
	if itemLink or itemIndex == 0 then
		texture = GetInventoryItemTexture("player",itemIndex)
		count = GetInventoryItemCount("player",itemIndex)
		if itemIndex ~= 0 then
			_, quality, _, ID = ace.GetItemInfoFromLink(itemLink)
		end
	end
	local hasRelic = UnitHasRelicSlot("player")
	local locked = IsInventoryItemLocked(itemIndex)
	return texture, count, ID, locked, quality, readable, nil
end
function MyEquipmentClass:MyEquipmentItemSlotButton_OnLoad()
	this:RegisterForDrag("LeftButton")
	getglobal(this:GetName().."NormalTexture"):SetTexture("Interface\\AddOns\\MyBags\\Skin\\Button")
end
function MyEquipmentClass:MyEquipmentItemSlotButton_OnEnter()
	local text
	self:TooltipSetOwner(this)
	if self.isLive then
		local hasItem, hasCooldown, repairCost = GameTooltip:SetInventoryItem("player", this:GetID())
		if not hasItem then
			text = TEXT(getglobal(MYEQUIPMENT_SLOT[ace.tonum(strsub(this:GetName(), 21))]))
			if this.hasRelic then text = TEXT(getglobal("RELICSLOT")) end
			GameTooltip:SetText(text)
		end
		if ( InRepairMode() and repairCost and (repairCost > 0) ) then
			GameTooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1)
			SetTooltipMoney(GameTooltip, repairCost)
			GameTooltip:Show()
		elseif hasItem and IsControlKeyDown() then
			ShowInspectCursor()
		else
			CursorUpdate()
		end
	else
		local _, count, ID, _, quality, _, name = self:GetInfo(this:GetID())
		if ID and ID ~= "" then
			local hyperlink = self:GetHyperlink(ID)
			if hyperlink then GameTooltip:SetHyperlink(hyperlink) end
			if IsControlKeyDown() and hyperlink then ShowInspectCursor() end
		else
			text = TEXT(getglobal(MYEQUIPMENT_SLOT[ace.tonum(strsub(this:GetName(), 21))]))
			if this.hasRelic then text = TEXT(getglobal("RELICSLOT")) end
			if name then -- it's a bleeding ammo slot
				text = name
				GameTooltip:SetText(text, ace.ColorConvertHexToDigit(quality))
				if count >= 1000 then
					GameTooltip:AddLine(count,1,1,1)
					GameTooltip:Show()
				end
			else
				GameTooltip:SetText(text)
			end
		end
	end
end
function MyEquipmentClass:MyEquipmentItemSlotButton_OnClick(button, ignoreModifiers)
	if self.isLive then
		if ( button == "LeftButton" ) then
			if ( IsControlKeyDown() and not ignoreModifiers ) then
				DressUpItemLink(GetInventoryItemLink("player", this:GetID()));
			elseif ( IsShiftKeyDown() and not ignoreModifiers ) then
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:Insert(GetInventoryItemLink("player", this:GetID()));
				end
			else
				PickupInventoryItem(this:GetID())
				PaperDollItemSlotButton_UpdateLock()
				self.watchLock = 1
			end
		elseif ( button == "RightButton" ) then
			UseInventoryItem(this:GetID());
		end
	else
		local _, _, ID = self:GetInfo(this:GetID())
		if ( button == "LeftButton" ) then
			if ( IsControlKeyDown() ) then
				DressUpItemLink("item:"..ID)
			elseif ( IsShiftKeyDown() ) then
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:Insert(MyBagsCoreClass:GetTextLink(ID))
				end
			end
		end
	end
end
function MyEquipmentClass:MyEquipmentItemSlotButton_OnDragStart()
	if self.isLive then
		PaperDollItemSlotButton_OnClick("LeftButton", 1)
	end
end

function MyEquipmentClass:MyEquipmentItemSlotButton_OnEvent(event)
	if self.isLive then
		PaperDollItemSlotButton_OnEvent(event)
	else
		if ( event == "CURSOR_UPDATE" ) then
			if ( CursorCanGoInSlot(this:GetID()) ) then
				this:LockHighlight()
			else
				this:UnlockHighlight()
			end
			return
		end
	end
end
function MyEquipmentClass:MyEquipmentItemSlotButton_OnUpdate(elapsed)
	if ( GameTooltip:IsOwned(this) ) and self.isLive then
			self:MyEquipmentItemSlotButton_OnEnter()()
	end
end
function MyEquipmentClass:LayoutEquipmentFrame(self)
	local itemBase = "MyEquipmentSlotsItem"
	local texture, count, _, locked, quality, ammo
	local slotColor = ((self.GetOpt("SlotColor")) or MYBAGS_SLOTCOLOR)
	local charID = self:GetCurrentPlayer()
	local hasRelic = self:GetRelic(charID)
	local hideAmmo = nil
	self.watchLock = nil
	-- KC Items does not currently save AmmoSlot details (no ID is returned by the blizzard code) so hide it
	if (not self.isLive) and KC_Items and KC_Items.equipment then hideAmmo = TRUE end
	if self.aioiOrder and (hasRelic or hideAmmo) then self.curCol = self.curCol + 1 end
	for key,value in SLOTNAMES do
		local slot = GetInventorySlotInfo(value)
		local itemButton = getglobal(itemBase .. slot)
		if value == "AMMOSLOT" and (hasRelic or hideAmmo) then itemButton:Hide() break end
		if self.curCol >= self.GetOpt("Columns") then
			self.curCol = 0
			self.curRow = self.curRow + 1
		end
		itemButton:Show()
		itemButton:ClearAllPoints()
		itemButton:SetPoint("TOPLEFT", self.frame:GetName(), "TOPLEFT", self:GetXY(self.curRow, self.curCol))
		self.curCol = self.curCol + 1
		texture, count, id, locked, quality = self:GetInfo(slot)
		if id and id ~= "" then itemButton.hasItem = 1 end
		if self.isLive then
			local start,duration, enable = GetInventoryItemCooldown("player", slot)
			local cooldown = getglobal(itemButton:GetName() .. "Cooldown")
			CooldownFrame_SetTimer(cooldown,start,duration,enable)
			if duration>0 and enable==0 then
				SetItemButtonTextureVertexColor(itemButton, 0.4,0.4,0.4)
			end
		end
		if value == "RANGEDSLOT" and hasRelic then itemButton.hasRelic = 1 end
		SetItemButtonTexture(itemButton, (texture or ""))
		SetItemButtonCount(itemButton, count)
		SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5)
		if locked and locked ~= "" then
			itemButton:LockHighlight()
			self.watchLock =1
		else itemButton:UnlockHighlight() end
		if quality and self.GetOpt("Border") then
			SetItemButtonNormalTextureVertexColor(itemButton, ace.ColorConvertHexToDigit(quality))
		else
			SetItemButtonNormalTextureVertexColor(itemButton, unpack(slotColor))
		end
	end
end

MyEquipment = MyEquipmentClass:new()
MyEquipment:RegisterForLoad()

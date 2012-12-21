local MYINVENTORY_DEFAULT_OPTIONS = {
	Columns    = 6,
	Replace    = TRUE,
	Bag        = "bar",
	Graphics   = "default",
	Count      = "free",
	HlItems    = TRUE,
	HlBags     = TRUE,
	Freeze     = FALSE,
	NoEsc      = FALSE,
	Lock       = FALSE,
	Title      = TRUE,
	Cash       = TRUE,
	Buttons    = TRUE,
	AIOI       = FALSE,
	Border     = TRUE,
	Cache      = nil,
	Player     = FALSE,
	Scale      = FALSE,
	Anchor     = "bottomright",
	BackColor  = {0.7,0,0,0},
	SlotColor    = nil,
	AmmoColor    = nil,
	EnchantColor = nil,
	EngColor     = nil,
	HerbColor    = nil,
	KeyRingColor = nil,
	Companion    = nil,
}

MyInventoryClass = MyBagsCoreClass:new({
	name           = MYINVENTORY_NAME,
	description    = MYINVENTORY_DESCRIPTION,
	db             = AceDbClass:new("MyInventoryDB"),
	defaults       = MYINVENTORY_DEFAULT_OPTIONS,
	frameName      = "MyInventoryFrame",
	cmd            = AceChatCmdClass:new(MYINVENTORY_COMMANDS, MYINVENTORY_CMD_OPTIONS),

	totalBags        = 5,
	firstBag         = 0,
	anchorPoint      = "BOTTOMRIGHT",
	anchorParent     = "UIParent",
	anchorOffsetX    = -5,
	anchorOffsetY    = 100,
})

function MyInventoryClass:RegisterEvents()
	MyBagsCoreClass.RegisterEvents(self)
end
function MyInventoryClass:UnregisterEvents()
	MyBagsCoreClass.UnregisterEvents(self)
end
function MyInventoryClass:HookFunctions()
	MyBagsCoreClass.HookFunctions(self)
	self:Hook("ToggleKeyRing")
	self:Hook("ToggleBackpack")
	self:Hook("OpenBackpack")
	self:Hook("CloseBackpack")
end

function MyInventoryClass:ToggleKeyRing()
	if not (self.GetOpt("Replace") and self:IncludeBag(KEYRING_CONTAINER)) then
		self.Hooks["ToggleKeyRing"].orig()
	else
		self:Toggle()
	end
end
function MyInventoryClass:ToggleBackpack()
	if not (self.GetOpt("Replace") and self:IncludeBag(0)) then
		self.Hooks["ToggleBackpack"].orig()
	else
		self:Toggle()
	end
end
function MyInventoryClass:OpenBackpack()
	if not (self.GetOpt("Replace") and self:IncludeBag(0)) then
		self.Hooks["OpenBackpack"].orig()
	else
		if MailFrame:IsVisible() then self.Companion = TRUE end
		if self.frame:IsVisible() then self.holdOpen = TRUE end
		self:Open()
	end
end
function MyInventoryClass:CloseBackpack()
	self:debug("CloseBackpack")
	if not (self.GetOpt("Replace") and self:IncludeBag(0)) then
		self.Hooks["CloseBackpack"].orig()
	elseif not self.Freeze then
		self:Close()
	elseif self.Freeze == "sticky" then
		if self.holdOpen then
			self.holdOpen = nil
		else
			self:Close()
		end
	end
end
function MyInventoryClass:CompanionOpen()
	self.Companion = TRUE
	self:OpenBackpack()
end
function MyInventoryClass:CompanionClose()
	if self.Companion then -- if not true it's a duplicate event
		self.Companion = nil
		self:CloseBackpack()
	end
end
function MyInventoryClass:BAG_UPDATE()
	local bag = arg1
	if self.isLive and (bag == -2 or (bag >= 0 and bag < 5)) then
		self:LayoutFrame()
	end
end

function MyInventoryClass:GetInfoFunc()
	if self.isLive then
		return self.GetInfoLive
	end
	if IsAddOnLoaded("KC_Items") and KC_Items.inventory then
		return self.GetInfoKC
	end
	if IsAddOnLoaded("MyBagsCache") then
		return self.GetInfoMyBagsCache
	end
	return self.GetInfoNone
end
function MyInventoryClass:GetInfoKC(bag, slot)
	if not MYBAGS_KC_CHARS then return self.GetInfoNone end
	local texture, count, ID, locked, quality, readable = nil
	charID = self.Player
	local faction = MYBAGS_KC_CHARS[charID]["faction"]
	local itype,isubtype = nil
	if slot then
		ID,count = KC_Items.inventory:SlotInfo(bag, slot, faction, charID)
	else
		ID,count = KC_Items.inventory:BagInfo(bag, faction, charID)
		if bag == 0 then
			texture = "Interface\\Buttons\\Button-Backpack-Up"
		end
	end
	if ID == "" or ID == "nil" then ID = nil end
	if ID then
		_,_,quality,_,itype,isubtype,_,_,texture = GetItemInfo("item:"..ID)
		_,_,_,quality = GetItemQualityColor(quality or 0)
		if not slot then readable = ace.IsSpecialtyBag(itype,isubtype) end
		quality = (strsub(quality,5)) -- here instead of return to keep nil if empty slot
	end
	count = ace.tonum(count)
	return texture, count, ID, locked, quality, readable, nil
end

function MyInventoryClass:BagIDToInvSlotID(bag)
	if bag == 0 then return nil end
	return ContainerIDToInventoryID(bag)
end
function MyInventoryClass:IsBagSlotUsable(slot)
	if (slot >= 0 and slot <= 4) or slot == KEYRING_CONTAINER then return true end
	return false
end

MyInventory = MyInventoryClass:new()
MyInventory:RegisterForLoad()

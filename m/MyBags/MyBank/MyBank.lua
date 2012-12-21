local MYBANK_DEFAULT_OPTIONS = {
	Columns  = 6,
	Replace  = TRUE,
	Bag      = "bar",
	Graphics = "default",
	Count    = "free",
	HlItems  = TRUE,
	HlBags   = TRUE,
	Freeze   = FALSE,
	Lock     = FALSE,
	NoEsc    = FALSE,
	Title    = TRUE,
	Cash     = TRUE,
	Buttons  = TRUE,
	AIOI     = FALSE,
	Border   = TRUE,
	Cache    = nil,
	Player   = FALSE,
	Scale    = FALSE,
	Anchor   = "bottomleft",
	BackColor  = {0.7,0,0,0},
	SlotColor    = nil,
	AmmoColor    = nil,
	EnchantColor = nil,
	EngColor     = nil,
	HerbColor    = nil,
}
MyBankClass = MyBagsCoreClass:new({
	name           = MYBANK_NAME,
	description    = MYBANK_DESCRIPTION,
	db             = AceDbClass:new("MyBankDB"),
	defaults       = MYBANK_DEFAULT_OPTIONS,
	frameName      = "MyBankFrame",
	cmd            = AceChatCmdClass:new(MYBANK_COMMANDS, MYBANK_CMD_OPTIONS),

	totalBags        = 6,
	firstBag         = 5,
	isBank			  = TRUE,
	atBank           = FALSE,

	saveBankFrame    = BankFrame,

	anchorPoint      = "BOTTOMLEFT",
	anchorParent     = "UIParent",
	anchorOffsetX    = 5,
	anchorOffsetY    = 100,
})

function MyBankClass:Enable()
	MyBagsCoreClass.Enable(self)
	MyBankFrameBank.maxIndex = 24
	MyBankFrameBank:SetID(BANK_CONTAINER)
	MyBankFrameBag0:SetID(5)
	MyBankFrameBag1:SetID(6)
	MyBankFrameBag2:SetID(7)
	MyBankFrameBag3:SetID(8)
	MyBankFrameBag4:SetID(9)
	MyBankFrameBag5:SetID(10)
	if self.GetOpt("Replace") then
		BankFrame:UnregisterEvent("BANKFRAME_OPENED")
		BankFrame:UnregisterEvent("BANKFRAME_CLOSED")
		setglobal("BankFrame", self.frame)
	end
	MyBankFramePortrait:SetTexture("Interface\\Addons\\MyBags\\Skin\\MyBankPortait");
	StaticPopupDialogs["PURCHASE_BANKBAG"] = {
		text = TEXT(CONFIRM_BUY_BANK_SLOT),
		button1 = TEXT(YES),
		button2 = TEXT(NO),
		OnAccept = function()
			if CT_oldPurchaseSlot then
				CT_oldPurchaseSlot()
			else
				PurchaseSlot()
			end;
		end,
		OnShow = function()
			MoneyFrame_Update(this:GetName().."MoneyFrame", GetBankSlotCost());
		end,
		showAlert = 1,
		hasMoneyFrame = 1,
		timeout = 0,
		hideOnEscape = 1,
	}
end

function MyBankClass:Disable()
	BankFrame = self.saveBankFrame
	BankFrame:RegisterEvent("BANKFRAME_OPENED")
	BankFrame:RegisterEvent("BANKFRAME_CLOSED")
end
function MyBankClass:RegisterEvents()
	MyBagsCoreClass.RegisterEvents(self)
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED",   "LayoutFrameOnEvent")
	self:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED","LayoutFrameOnEvent")
end

function MyBankClass:HookFunctions()
	MyBagsCoreClass.HookFunctions(self)
	self:Hook("OpenAllBags")
	self:Hook("CloseAllBags")
end
function MyBankClass:OpenAllBags(forceopen)
	self:debug("OpenAllBagsHook")
	if forceopen then OpenBackpack() else ToggleBackpack() end
	local action
	if (IsBagOpen(0) or MyInventory.frame:IsVisible()) then 
		action = "OpenBag" 
	else 
		action = "CloseBag" 
	end
	for i=1, 4, 1 do
		if not (MyInventory.GetOpt("Replace") and MyInventory:IncludeBag(i)) then
			self.Hooks[action].orig(i)
		end
	end
	for i=5, 10, 1 do
		if not MyBank.GetOpt("Replace") or not MyBank:IncludeBag(i) then
			self.Hooks[action].orig(i)
		end
	end
end
function MyBankClass:CloseAllBags()
	self:debug("CloseAllBagsHook")
	MyInventory:Close()
	CloseBackpack() -- just in case backpack is not contolled by MyInventory
	for i=1, 4, 1 do
		if not MyInventory.GetOpt("Replace") or not MyInventory:IncludeBag(i) then
			self.Hooks["CloseBag"].orig(i)
		end
	end
	for i=5, 10, 1 do
		if not MyBank.GetOpt("Replace") or not MyBank:IncludeBag(i) then
			self.Hooks["CloseBag"].orig(i)
		end
	end
end

function MyBankClass:BAG_UPDATE()
--	local time = GetTime()
	local bag = arg1
	if self.isLive and (bag == -1 or (bag >= 5 and bag <= 10)) then
		self:LayoutFrame()
	end
--	self:debug(event.." bag" .. (bag or "nil").." ".. GetTime()-time)
end
function MyBankClass:BANKFRAME_OPENED()
	self:debug("BANKFRAME_OPENED")
	MyBank.atBank = TRUE
	SetPortraitTexture(MyBankFramePortrait, "npc")
	if self.Freeze == "always" or (self.Freeze == "sticky" and self.frame:IsVisible()) then
		self.holdOpen = TRUE
	else
		self.holdOpen = nil
	end
	if self.GetOpt("Replace") then
		self:Open()
	else
		self:LayoutFrame()
	end
end
function MyBankClass:BANKFRAME_CLOSED()
	self:debug("BANKFRAME_CLOSED")
	MyBank.atBank = FALSE
	MyBankFramePortrait:SetTexture("Interface\\Addons\\MyBags\\Skin\\MyBankPortait") -- [sic]
	if self.GetOpt("Replace") and not self.holdOpen then
		if self.frame:IsVisible() then 
			self.frame:Hide()
		end -- calling self:close() would trigger the bank closing twice
	else
		self.holdOpen = nil
		if self.isLive then self:LayoutFrame() end
	end
end

function MyBankClass:GetInfoFunc()
	if self.isLive then
		return self.GetInfoLive
	end
	if IsAddOnLoaded("KC_Items") and KC_Items.bank then
		return self.GetInfoKC
	end
	if IsAddOnLoaded("MyBagsCache") then
		return self.GetInfoMyBagsCache
	end
	return self.GetInfoNone
end
function MyBankClass:GetInfoKC(bag, slot, charID)
	if not MYBAGS_KC_CHARS then return self.GetInfoNone end
	local texture, count, ID, locked, quality, readable = nil
	if not charID then charID = self:GetCurrentPlayer() end
	local faction = MYBAGS_KC_CHARS[charID]["faction"]
	if slot then
		ID,count = KC_Items.bank:SlotInfo(bag, slot, faction, charID)
	else
		ID,count = KC_Items.bank:BagInfo(bag, faction, charID)
	end
	if ID == "" or ID == "nil" then ID = nil end
	if ID then
		local itype,isubtype
		_,_,quality,_,itype,isubtype,_,_,texture = GetItemInfo("item:"..ID)
		_,_,_,quality = GetItemQualityColor(quality or 0)
		if not slot then readable = ace.IsSpecialtyBag(itype,isubtype) end
		quality = (strsub(quality,5)) -- here instead of return to keep nil if empty slot
	end
	count = ace.tonum(count)
	return texture, count, ID, locked, quality, readable, nil
end
function MyBankClass:SetReplace()
	MyBagsCoreClass.SetReplace(self)
	if self.GetOpt("Replace") then
		BankFrame:UnregisterEvent("BANKFRAME_OPENED")
		BankFrame:UnregisterEvent("BANKFRAME_CLOSED")
		setglobal("BankFrame", self.frame)
	else
		setglobal("BankFrame",  self.saveBankFrame)
		BankFrame:RegisterEvent("BANKFRAME_OPENED")
		BankFrame:RegisterEvent("BANKFRAME_CLOSED")
	end
end

MyBank = MyBankClass:new()
MyBank:RegisterForLoad()

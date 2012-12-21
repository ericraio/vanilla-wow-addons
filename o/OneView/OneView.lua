--$Id: OneView.lua 8341 2006-08-18 03:57:52Z kaelten $
OneView = OneCore:NewModule("OneView", "AceEvent-2.0", "AceHook-2.0", "AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0")
local L = AceLibrary("AceLocale-2.0"):new("OneView")

BINDING_HEADER_ONEVIEW = "OneView"

function OneView:OnInitialize()
    local baseArgs = OneCore:GetFreshOptionsTable(self)
	local customArgs = {
        ["0"] = {
            name = L"Backpack", type = 'toggle', order = 5,
            desc = L"Turns display of your backpack on and off.",
            get = function() return self.db.profile.show[0] end,
            set = function(v) 
                self.db.profile.show[0] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["1"] = {
            name = L"First Bag", type = 'toggle', order = 6,
            desc = L"Turns display of your first bag on and off.",
            get = function() return self.db.profile.show[1] end,
            set = function(v) 
                self.db.profile.show[1] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["2"] = {
            name = L"Second Bag", type = 'toggle', order = 7,
            desc = L"Turns display of your second bag on and off.",
            get = function() return self.db.profile.show[2] end,
            set = function(v) 
                self.db.profile.show[2] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["3"] = {
            name = L"Third Bag", type = 'toggle', order = 8,
            desc = L"Turns display of your third bag on and off.",
            get = function() return self.db.profile.show[3] end,
            set = function(v) 
                self.db.profile.show[3] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["4"] = {
            name = L"Fourth Bag", type = 'toggle', order = 9,
            desc = L"Turns display of your fourth bag on and off.",
            get = function() return self.db.profile.show[4] end,
            set = function(v) 
                self.db.profile.show[4] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["5"] = {
            name = L"First Bank Bag", type = 'toggle', order = 10,
            desc = L"Turns display of your first bag on and off.",
            get = function() return self.db.profile.show[5] end,
            set = function(v) 
                self.db.profile.show[5] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["6"] = {
            name = L"Second Bank Bag", type = 'toggle', order = 11,
            desc = L"Turns display of your second bag on and off.",
            get = function() return self.db.profile.show[6] end,
            set = function(v) 
                self.db.profile.show[6] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["7"] = {
            name = L"Third Bank Bag", type = 'toggle', order = 12,
            desc = L"Turns display of your third bag on and off.",
            get = function() return self.db.profile.show[7] end,
            set = function(v) 
                self.db.profile.show[7] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["8"] = {
            name = L"Fourth Bank Bag", type = 'toggle', order = 13,
            desc = L"Turns display of your fourth bag on and off.",
            get = function() return self.db.profile.show[8] end,
            set = function(v) 
                self.db.profile.show[8] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["9"] = {
            name = L"Fifth Bank Bag", type = 'toggle', order = 14,
            desc = L"Turns display of your fifth bag on and off.",
            get = function() return self.db.profile.show[9] end,
            set = function(v) 
                self.db.profile.show[9] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["10"] = {
            name = L"Sixth Bank Bag", type = 'toggle', order = 15,
            desc = L"Turns display of your sixth bag on and off.",
            get = function() return self.db.profile.show[10] end,
            set = function(v) 
                self.db.profile.show[10] = v 
                self:OrganizeFrame(true)
            end,
        },
    }
    
    OneCore:CopyTable(customArgs, baseArgs.args.show.args)
	
    
    baseArgs.args.remember = {
        cmdName = L"Remember", guiName = L"Remember Selection", type = 'toggle',
        desc = L"Toggles wether to remember which was the last character you selected.",
        get = function() return self.db.profile.remember end,
        set = function(v) 
            self.db.profile.remember = v 
            if v then
                self.db.account.faction = self.faction 
                self.db.account.characterId = self.charId 
            else
                self.db.account.faction = nil
                self.db.account.characterId = nil
            end
        end,
    }
    
    
	self:RegisterDB("OneViewDB")
	self:RegisterDefaults('profile', OneCore.defaults)
	self:RegisterChatCommand({"/ov", "/OneView"}, baseArgs, string.upper(self.title))
	self:RegisterChatCommand({"/ovs", "/ovshow"}, {type="execute", func= function() 
			if OneViewFrame:IsVisible() then
				OneViewFrame:Hide()
			else
				OneViewFrame:Show()
			end
		end})
	
    --self:SetDebugging(true)
	
    self.fBags = {-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    
	self.frame = OneViewFrame
	self.frame.bags = {}
	self.frame.handler = self

	self.storage = OneStorage
	
	self:TriggerEvent("OneView_Loaded")
	
	self:RegisterDewdrop(baseArgs)
end

function OneView:OnEnable()
	self.frame:SetClampedToScreen(true)
	self:BuildCharSelectOptions()
end

function OneView:BuildFrame()
	debugprofilestart()
	
	if not self.frame.bags[-1] then 
		self.frame.bags[-1] = CreateFrame("Frame", "OVBankBag", self.frame)
		self.frame.bags[-1]:SetID(-1)
		self.frame.bags[-1].size = 24
		for slot = 1, 24 do
			self.frame.bags[-1][slot] = CreateFrame("Button", self.frame.bags[-1]:GetName().."Item"..slot, self.frame.bags[-1], "OneViewItemButtonTemplate")
			self.frame.bags[-1][slot]:SetID(slot)
		end
	end
	
	
	for bag = 0, 10 do		
		local itemId, size, isAmmo, isSoul, isProf = self.storage:BagInfo(self.faction, self.charId, bag)
		for slot = 1, (tonumber(size) or 0) do
			if not self.frame.bags[bag] then 
				self.frame.bags[bag] = CreateFrame("Frame", tostring(self)..bag, self.frame)
				self.frame.bags[bag]:SetID(bag)
			end
			if not self.frame.bags[bag][slot] then
				self.frame.bags[bag][slot] = CreateFrame("Button", tostring(self)..bag.."Item"..slot, self.frame.bags[bag], "OneViewItemButtonTemplate")
				self.frame.bags[bag][slot]:SetID(slot)
			end
		end
		if self.frame.bags[bag] then
			local curBag = self.frame.bags[bag]
			curBag.itemId, curBag.size, curBag.isAmmo, curBag.isSoul, curBag.isProf = itemId, size or 0, isAmmo, isSoul, isProf
		end
	end
	self:Debug("%s ran in %s", "BuildFrame", debugprofilestop())
end


function OneView:OrganizeFrame(needs)
	debugprofilestart()
	
	local cols, curCol, curRow = self.db.profile.cols, 1, 1
	local lastslot
	self.bankSoulSlots, self.bankAmmoSlots, self.bankProfSlots, self.bankSlotCount, self.bankTotalCount = 0, 0, 0, 0, 0
	self.invSoulSlots, self.invAmmoSlots, self.invProfSlots, self.invSlotCount, self.invTotalCount = 0, 0, 0, 0, 0
	
	for bag = -1, 10 do 
		if self.frame.bags[bag] then
			for k2, v2 in ipairs(self.frame.bags[bag]) do 
				v2:Hide()
			end
		end
		local curBag = getglobal("OneViewFrameBag" .. bag)
		if curBag and not self.db.profile.show.bank and bag > 4 then
			curBag:Hide()
		elseif curBag and not self.db.profile.show.inventory and bag < 5 and bag > 0 then
			curBag:Hide()
		elseif curBag then
			curBag:Show()
		end
	end
	

	for k, bag in {-1, 5, 6, 7, 8, 9, 10} do
		local curBag = self.frame.bags[bag]
		if curBag and curBag.size and curBag.size > 0 then
			if curBag.isAmmo then
				self.bankAmmoSlots = self.bankAmmoSlots + curBag.size
			elseif curBag.isSoul then
				self.bankSoulSlots = self.bankSoulSlots + curBag.size
			elseif curBag.isProf then
				self.bankProfSlots = self.bankProfSlots + curBag.size
			else
				self.bankSlotCount = self.bankSlotCount + curBag.size
			end
			if self.db.profile.show.bank then
				if self:ShouldShow(bag, curBag.isAmmo, curBag.isSoul, curBag.isProf) then
					self.bankTotalCount = self.bankTotalCount + curBag.size
					for slot = 1, curBag.size do
						curBag[slot]:ClearAllPoints()
						curBag[slot]:SetPoint("TOPLEFT", self.frame:GetName(), "TOPLEFT", self.leftBorder + (self.colWidth * (curCol - 1)) , 0 - self.topBorder - (self.rowHeight * curRow))
						curBag[slot]:Show()				
						if curCol == 1 then lastslot = curBag[slot] end
						curCol = curCol + 1
						if curCol > cols then curCol, curRow = 1, curRow + 1 end
					end
				end
			else
				curRow = curRow + .1
			end
		end
	end
	
	OneViewFrameBankInfo1:ClearAllPoints()
	if self.db.profile.show.bagslots and lastslot then
		OneViewFrameBag5:ClearAllPoints()
		OneViewFrameBag5:SetPoint("TOPLEFT", lastslot, "BOTTOMLEFT", 0, -10)
		OneViewFrameBankInfo1:SetPoint("TOPLEFT", OneViewFrameBag5, "BOTTOMLEFT", 0, -10)
		for i = 5, 10 do
			getglobal("OneViewFrameBag" .. i):Show()
		end
	elseif lastslot then
		for i = 5, 10 do
			getglobal("OneViewFrameBag" .. i):Hide()
		end
		curRow = curRow - 1
		OneViewFrameBankInfo1:SetPoint("TOPLEFT", lastslot, "BOTTOMLEFT", 0, -10)
	else
		for i = 5, 10 do
			getglobal("OneViewFrameBag" .. i):Hide()
		end
		curRow = curRow - 1
		OneViewFrameBankInfo1:SetPoint("TOPLEFT", OneViewFrameBankButton, "BOTTOMLEFT", 5, -10)
	end

	lastslot = nil
	curCol = 1
	curRow = curRow + (self.db.profile.show.bank and 3.5 or 2)
	
	
	
	for bag = 0, 4 do
		local curBag = self.frame.bags[bag]
		if curBag and curBag.size and curBag.size > 0 then
			if curBag.isAmmo then
				self.invAmmoSlots = self.invAmmoSlots + curBag.size
			elseif curBag.isSoul then
				self.invSoulSlots = self.invSoulSlots + curBag.size
			elseif curBag.isProf then
				self.invProfSlots = self.invProfSlots + curBag.size
			else
				self.invSlotCount = self.invSlotCount + curBag.size
			end
			if self.db.profile.show.inventory then
				if self:ShouldShow(bag, curBag.isAmmo, curBag.isSoul, curBag.isProf) then
					self.invTotalCount = self.invTotalCount + curBag.size
					for slot = 1, curBag.size do
						curBag[slot]:ClearAllPoints()
						curBag[slot]:SetPoint("TOPLEFT", self.frame:GetName(), "TOPLEFT", self.leftBorder + (self.colWidth * (curCol - 1)) , 0 - self.topBorder - (self.rowHeight * curRow))
						curBag[slot]:Show()				
						if curCol == 1 then lastslot = curBag[slot] end
						curCol = curCol + 1
						if curCol > cols then curCol, curRow = 1, curRow + 1 end
					end
				end
				local invButton = getglobal(self.frame:GetName() .. "InventoryButton")
				invButton:ClearAllPoints()
				invButton:SetPoint("BOTTOMLEFT", self.frame.bags[0][1]:GetName(), "TOPLEFT", -5, 0)
			else
				local invButton = getglobal(self.frame:GetName() .. "InventoryButton")
				invButton:ClearAllPoints()
				invButton:SetPoint("BOTTOMLEFT", self.frame:GetName(), "BOTTOMLEFT", 3, 24)
			end
		end
	end
	
	OneViewFrameInventoryInfo1:ClearAllPoints()
	if self.db.profile.show.bagslots and lastslot then
		curRow = curRow + 1
		OneViewFrameBag1:ClearAllPoints()
		OneViewFrameBag1:SetPoint("TOPLEFT", lastslot, "BOTTOMLEFT", 0, -10)
		OneViewFrameInventoryInfo1:SetPoint("TOPLEFT", OneViewFrameBag1, "BOTTOMLEFT", 0, -5)
		for i = 1, 4 do
			getglobal("OneViewFrameBag" .. i):Show()
		end
	elseif lastslot then
		for i = 1, 4 do
			getglobal("OneViewFrameBag" .. i):Hide()
		end
		OneViewFrameInventoryInfo1:SetPoint("TOPLEFT", lastslot, "BOTTOMLEFT", 0, -5)
	else
		for i = 1, 4 do
			getglobal("OneViewFrameBag" .. i):Hide()
		end
		OneViewFrameInventoryInfo1:SetPoint("TOPLEFT", OneViewFrameInventoryButton, "BOTTOMLEFT", 5, -4)
	end

	
	self:Debug("CurrentRow: %s", curRow)
	
	if math.mod(self.invTotalCount, cols) ~= 0 then curRow = curRow + 1 end
	self.frame:SetHeight(curRow * self.rowHeight + self.bottomBorder + self.topBorder) 
	self.frame:SetWidth(cols * self.colWidth + self.leftBorder + self.rightBorder)
	
	self:Debug("%s ran in %s", "OrganizeFrame", debugprofilestop())
	
	OneViewFrameInventoryName:ClearAllPoints()
	OneViewFrameInventoryName:SetPoint("LEFT",  OneViewFrameInventoryButton, "RIGHT", 5, 1)
	
	OneViewFrameBankName:ClearAllPoints()
	OneViewFrameBankName:SetPoint("LEFT",  OneViewFrameBankButton, "RIGHT", 5, 1)
	
	OneViewFrameBankName:SetText(format(L"%s's Bank Bags", self.charId or ""))
	OneViewFrameInventoryName:SetText(format(L"%s's Bags", self.charId or ""))
	
end

function OneView:FillBags()
	for bag = -1, 10 do
		local curBag = self.frame.bags[bag]
		if curBag and curBag.size and curBag.size > 0 then
			for slot = 1, curBag.size do
				local itemId, qty = self.storage:SlotInfo(self.faction, self.charId, bag, slot)
				if itemId then
					local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(itemId)
					getglobal(curBag[slot]:GetName() .. "IconTexture"):SetTexture(itemTexture)
					getglobal(curBag[slot]:GetName() .. "IconTexture"):Show()
					if qty > 1 then
						getglobal(curBag[slot]:GetName() .. "Count"):SetText(qty)
						getglobal(curBag[slot]:GetName() .. "Count"):Show()
					else
						getglobal(curBag[slot]:GetName() .. "Count"):SetText("")
						getglobal(curBag[slot]:GetName() .. "Count"):Hide()
					end
					curBag[slot].itemId = itemId
					curBag[slot].itemQuality = itemQuality
					curBag[slot].qty = qty
				else
					getglobal(curBag[slot]:GetName() .. "IconTexture"):Hide()
					getglobal(curBag[slot]:GetName() .. "Count"):Hide()
					curBag[slot].itemId = nil
					curBag[slot].itemQuality = nil
					curBag[slot].qty = nil
				end
				self:SetBorderColor(curBag[slot])
			end
		end
		local bagSlot = getglobal("OneViewFrameBag" .. bag)
		if bagSlot then 
			local itemId = self.storage:BagInfo(self.faction, self.charId, bag)
			if itemId then 
				local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(itemId)
				getglobal(bagSlot:GetName() .. "IconTexture"):SetTexture(itemTexture)
				getglobal(bagSlot:GetName() .. "IconTexture"):Show()
				bagSlot.itemId = itemId
			else
				getglobal(bagSlot:GetName() .. "IconTexture"):Hide()
				bagSlot.itemId = nil
			end
		end
	end
	
	MoneyFrame_Update(self.frame:GetName().."MoneyFrame", self.storage:GetMoney(self.faction, self.charId) or 0)
	
	self:DoBankSlotCounts()
	self:DoInventorySlotCounts()
end

function OneView:SetBorderColor(slot)	    
    local color = {r = 1, g = 1, b = 1}
	
	local bag = slot:GetParent()
	local special = false
    
	if bag.isAmmo then 
		color = self.db.profile.colors.ammo
        special = true
	elseif bag.isSoul then
		color = self.db.profile.colors.soul
        special = true
	elseif bag.isProf then
		color = self.db.profile.colors.prof
        special = true
	elseif self.db.profile.colors.rarity and slot.itemQuality then
		color = ITEM_QUALITY_COLORS[slot.itemQuality]
		
        if slot.itemQuality > 1 then
            special = true 
        end
	end
    
    if special and self.db.profile.colors.glow then        
        slot:SetNormalTexture("Interface\\Buttons\\UI-ActionButton-Border")
        slot:GetNormalTexture():SetBlendMode("ADD")
        slot:GetNormalTexture():SetAlpha(.8)
        slot:GetNormalTexture():SetPoint("CENTER", slot:GetName(), "CENTER", 0, 1)
    elseif special then
        slot:SetNormalTexture("Interface\\AddOns\\OneBag\\BagSlot2")
        slot:GetNormalTexture():SetBlendMode("BLEND")
        slot:GetNormalTexture():SetPoint("CENTER", slot:GetName(), "CENTER", 0, 0)
    else
        slot:SetNormalTexture("Interface\\AddOns\\OneBag\\BagSlot")
        slot:GetNormalTexture():SetBlendMode("BLEND")
        slot:GetNormalTexture():SetPoint("CENTER", slot:GetName(), "CENTER", 0, 0)
    end
	slot:GetNormalTexture():SetVertexColor(color.r, color.g, color.b)
end

function OneView:DoBankSlotCounts()
	local usedSlots, usedAmmoSlots, usedSoulSlots, usedProfSlots, ammoQuantity = 0, 0, 0, 0, 0 
	
	for k, bag in {-1, 5, 6, 7, 8, 9, 10} do
		if self.frame.bags[bag] then
			local tmp, qty = 0, 0
			for slot = 1, self.frame.bags[bag].size do
				if(self.frame.bags[bag][slot].itemId) then 
					tmp = tmp + 1 
					qty = qty + self.frame.bags[bag][slot].qty
				end
			end
			
			if self.frame.bags[bag].isAmmo then
				usedAmmoSlots = usedAmmoSlots + tmp
				ammoQuantity = ammoQuantity + qty
			elseif self.frame.bags[bag].isSoul then
				usedSoulSlots = usedSoulSlots + tmp
			elseif self.frame.bags[bag].isProf then
				usedProfSlots = usedProfSlots + tmp
			else
				usedSlots = usedSlots + tmp
			end
		end
	end
	
	self:Debug("Normal used: %s, Soul used: %s, Prof used: %s, Ammo used %s, Ammo quantity %s.", usedSlots, usedSoulSlots, usedProfSlots, usedAmmoSlots, ammoQuantity)
	
	local info = 1
	local  name = self.frame:GetName() .. "BankInfo"	
	
	
	getglobal(name .. info):SetText(format(L"%s/%s Slots", usedSlots, self.bankSlotCount))
	info = info + 1
	
	for i = 2, 4 do 
		getglobal(name .. i):SetText("")
	end
    
    if self.db.profile.show.counts then
        if self.bankAmmoSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Ammo", ammoQuantity, self.bankAmmoSlots * 200))
            info = info + 1
        end
        if self.bankSoulSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Soul Shards", usedSoulSlots, self.bankSoulSlots))
            info = info + 1
        end
        if self.bankProfSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Profession Slots", usedProfSlots, self.bankProfSlots))
            info = info + 1
        end
    end
end

function OneView:DoInventorySlotCounts()
	local usedSlots, usedAmmoSlots, usedSoulSlots, usedProfSlots, ammoQuantity = 0, 0, 0, 0, 0 
	
	for bag = 0, 4 do
		if self.frame.bags[bag] then
			local tmp, qty = 0, 0
			for slot = 1, self.frame.bags[bag].size do
				if(self.frame.bags[bag][slot].itemId) then 
					tmp = tmp + 1 
					qty = qty + self.frame.bags[bag][slot].qty
				end
			end
			
			if self.frame.bags[bag].isAmmo then
				usedAmmoSlots = usedAmmoSlots + tmp
				ammoQuantity = ammoQuantity + qty
			elseif self.frame.bags[bag].isSoul then
				usedSoulSlots = usedSoulSlots + tmp
			elseif self.frame.bags[bag].isProf then
				usedProfSlots = usedProfSlots + tmp
			else
				usedSlots = usedSlots + tmp
			end
		end
	end
	
	self:Debug("Normal used: %s, Soul used: %s, Prof used: %s, Ammo used %s, Ammo quantity %s.", usedSlots, usedSoulSlots, usedProfSlots, usedAmmoSlots, ammoQuantity)
	
	local info = 1
	local  name = self.frame:GetName() .. "InventoryInfo"	
	
	
	getglobal(name .. info):SetText(format(L"%s/%s Slots", usedSlots, self.invSlotCount))
	info = info + 1
	
	for i = 2, 4 do 
		getglobal(name .. i):SetText("")
	end
	if self.db.profile.show.counts then
        if self.invAmmoSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Ammo", ammoQuantity, self.invAmmoSlots * 200))
            info = info + 1
        end
        if self.invSoulSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Soul Shards", usedSoulSlots, self.invSoulSlots))
            info = info + 1
        end
        if self.invProfSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Profession Slots", usedProfSlots, self.invProfSlots))
            info = info + 1
        end
    end
end

function OneView:BuildCharSelectOptions()
	local list = self.storage:GetCharListByServerId()
	
	local args	   = {
		type="group", 
		args = {},
	}
	
	for serverId, v in list do
		local _, _, server, faction = string.find(serverId, "(.+) . (.+)")
		while string.find(server, "(.+) (.+)")  do
            local _, _, p1, p2 = string.find(server, "(.+) (.+)")
            
            server = p1..p2         
        end
		
        print(server)
        
		args.args[server..faction] = {
			name = serverId, type = 'group',
			desc = L"Characters on "..serverId,
			args = {}
		}
		for k, v2 in v do
			local fact = faction
			local _, _, charName, charId = string.find(v2, "(.+) . (.+)")
			local func = function() self:LoadCharacter(fact, charId) end
			args.args[server..faction].args[charName] = {
				name = charName, type = 'execute',
				func = func, desc = charName,
			}
		end
	end
	
	self.dewdrop:Register(OneViewFrameCharSelectButton,
			'children', args,
			'point', function(parent)
				if parent:GetTop() < GetScreenHeight() / 2 then
					return "BOTTOMLEFT", "TOPLEFT"
				else
					return "TOPLEFT", "BOTTOMLEFT"
				end
			end,
			'dontHook', true
		)
	
end

function OneView:CharSelect()
	if self.dewdrop:IsOpen(getglobal(self.frame:GetName() .. "CharSelectButton")) then
		self.dewdrop:Close()
	else
		self.dewdrop:Open(getglobal(self.frame:GetName() .. "CharSelectButton"), OneViewFrameCharSelectButton)
	end
end

function OneView:LoadCharacter(faction, characterId)
	faction = faction or self.db.account.faction or AceLibrary("AceDB-2.0").FACTION
	characterId = characterId or self.db.account.characterId or AceLibrary("AceDB-2.0").CHAR_ID
	
    if self.db.profile.remember then
        self.db.account.faction = faction
        self.db.account.characterId = characterId
	end
    
	self.faction = faction
	self.charId = characterId
	
	self:BuildFrame()
	self:OrganizeFrame()
	self:FillBags()
end

function OneView:LinkItem(itemId)
	local name, link, quality = GetItemInfo(itemId)
	if ( ChatFrameEditBox:IsShown() ) then
		ChatFrameEditBox:Insert(format("%s|H%s|h[%s]|h|r", ITEM_QUALITY_COLORS[quality].hex, link, name))
	end	
end

function OneView:OnCustomShow() 
    if self.db.profile.point then
        local point = self.db.profile.point
        this:ClearAllPoints()
        this:SetPoint("TOPLEFT", point.parent, "BOTTOMLEFT", point.left, point.top)
    end
end
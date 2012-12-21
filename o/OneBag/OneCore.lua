--$Id: OneCore.lua 8409 2006-08-19 02:27:30Z kaelten $
OneCore = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceModuleCore-2.0", "AceHook-2.0")

local L = AceLibrary("AceLocale-2.0"):new("OneBag")

function OneCore:OnInitialize()
	self:Hook("BankFrame_OnEvent", function(event) 
		LoadAddOn("OneBank")
        local module = self:HasModule("OneBank") and self:GetModule("OneBank")
		if not module or not module:IsActive()  then
			self.hooks.BankFrame_OnEvent.orig(event)
		end
	end)
    
    self.defaults = {
		cols = 10,
		scale = 1,
		alpha = 1,
		colors = {
			mouseover 	= {r = 0, g = .7, b = 1},
			ammo 		= {r = 1, g = 1, b = 0},
			soul 		= {r = .5, g = .5, b = 1}, 
			prof 		= {r = 1, g = 0, b = 1},
            bground     = {r = 0, g = 0, b = 0, a = .45},
            glow        = false,
			rarity 		= true,
		},
		show = {
			['*'] = true
		},
		strata = 2,
        locked = false,
        clamped = true,
        bagBreak = false,
        vAlign = L"Top",
	}
    
    
    self.modulePrototype.colWidth  		= 39
    self.modulePrototype.rowHeight 		= 39
    self.modulePrototype.topBorder 		= 2
    self.modulePrototype.bottomBorder 	= 24
    self.modulePrototype.rightBorder    = 5
    self.modulePrototype.leftBorder     = 8 
    
    self.modulePrototype.stratas = {
        "LOW",
        "MEDIUM",
        "HIGH",
        "DIALOG",
        "FULLSCREEN",
        "FULLSCREEN_DIALOG",
        "TOOLTIP",
    }

end

function OneCore:GetFreshOptionsTable(module)
    local self = module
    return {
		type="group", 
		args = {
            frame = {
				name = L"Frame", type = 'group',
				desc = L"Frame Options", order = 2,
				args = {
                    cols = { 
                        name = L"Columns", type = "range", step = 1,
                        desc = L"Sets the number of columns to use", 
                        get  = function() return self.db.profile.cols end, 
                        set  = function(num) 
                            self.db.profile.cols = num
                            self:OrganizeFrame(true)
                        end, 
                        min  = 5, max  = 20,
                    },
                    scale = { 
                        name = L"Scale", type = "range", 
                        desc = L"Sets the scale of the frame", 
                        get  = function() return self.db.profile.scale end, 
                        set  = function(num) 
                            self.db.profile.scale = num
                            self.frame:SetScale(num)
                            if self.frame.bagFrame then
                                self.frame.bagFrame:SetScale(num)
                                local shownContainerID = IsBagOpen(KEYRING_CONTAINER)
                                if ( shownContainerID and not self.isBank) then
                                    local frame = getglobal("ContainerFrame"..shownContainerID)
                                    frame:SetScale(num)
                                end
                            end
                        end, 
                        min  = .2, max  = 2,
                        isPercent = true,
                    },
                    strata = { 
                        name = L"Strata", type = "range", 
                        desc = L"Sets the strata of the frame", 
                        get  = function() return self.db.profile.strata end, 
                        set  = function(num) 
                            self.db.profile.strata = num
                            self.frame:SetFrameStrata(self.stratas[num])
                            if self.frame.bagFrame then
                                self.frame.bagFrame:SetFrameStrata(self.stratas[num])
                            end
                            StackSplitFrame:SetFrameStrata(self.stratas[num+1])
                        end, 
                        min  = 1, max  = 5, step = 1,
                    },
                    bagbreak = { 
                        name = L"Bag Break", type = "toggle",
                        desc = L"Sets wether to start a new row at the beginning of a bag.", 
                        get  = function() return self.db.profile.bagBreak end, 
                        set  = function(value) 
                            self.db.profile.bagBreak = value
                            self:OrganizeFrame(true)
                        end, 
                    },
                    valign = { 
                        name = L"Vertical Alignment", type = "text",
                        desc = L"Sets wether to have the extra spaces on the top or bottom.", 
                        get  = function() return self.db.profile.vAlign end, 
                        set  = function(value) 
                            self.db.profile.vAlign = value
                            self:OrganizeFrame(true)
                        end,
                        validate = {L"Top", L"Bottom"}
                    },
                    alpha = { 
                        name = L"Alpha", type = "range", 
                        desc = L"Sets the alpha of the frame", 
                        get  = function() return self.db.profile.alpha end, 
                        set  = function(num) 
                            self.db.profile.alpha = num
                            self.frame:SetAlpha(num)
                            if self.frame.bagFrame then
                                self.frame.bagFrame:SetAlpha(num)
                            
                                local shownContainerID = IsBagOpen(KEYRING_CONTAINER)
                                if ( shownContainerID and not self.isBank) then
                                    local frame = getglobal("ContainerFrame"..shownContainerID)
                                    frame:SetAlpha(num)
                                end
                            end
                        end, 
                        min  = .05, max  = 1,
                        isPercent = true,
                    },
                    locked = {
                        name = L"Locked", 
                        type = 'toggle',
                        desc = L"Toggles the ability to move the frame",
                        get = function() return self.db.profile.locked end,
                        set = function(v) 
                            self.db.profile.locked = v 
                        end,
                    },
                    clamped = {
                        name = L"Clamped",
                        type = 'toggle',
                        desc = L"Toggles the ability to drag the frame off screen.",
                        get = function() return self.db.profile.clamped end,
                        set = function(v) 
                            self.db.profile.clamped = v 
                            self.frame:SetClampedToScreen(v)
                            if self.frame.bagFrame then
                                self.frame.bagFrame:SetClampedToScreen(v)
                            end
                        end,
                    }, 
                }
            },
			show = {
				name = L"Show", type = 'group', order = 3,
				desc = L"Various Display Options",
				args = {
                     counts = {
						name = L"Counts",
                        type = 'toggle', order = 1,
						desc = L"Toggles showing the counts for special bags.",
						get = function() return self.db.profile.show.counts end,
						set = function(v) 
							self.db.profile.show.counts = v 
                            if self.DoBankSlotCounts then
                                self:DoBankSlotCounts()
                                self:DoInventorySlotCounts()
                            else
                                self:DoSlotCounts()
                            end
						end,
					},
                    direction = {
						cmdName = L"Direction", guiName = L"Forward",
                        type = 'toggle', order = 2,
						desc = L"Toggles direction the bags are shown",
						get = function() return self.db.profile.show.direction end,
						set = function(v) 
							self.db.profile.show.direction = v 
							self:OrganizeFrame(true)
						end,
                        map = { [false] = L"|cffff0000Reverse|r", [true] = L"|cff00ff00Forward|r" }
					},
                    ammo = {
						name = L"Ammo Bag", type = 'toggle', order = 3,
						desc = L"Turns display of ammo bags on and off.",
						get = function() return self.db.profile.show.ammo end,
						set = function(v) 
							self.db.profile.show.ammo = v 
							self:OrganizeFrame(true)
						end,
					},
					soul = {
						name = L"Soul Bag", type = 'toggle', order = 4,
						desc = L"Turns display of soul bags on and off.",
						get = function() return self.db.profile.show.soul end,
						set = function(v) 
							self.db.profile.show.soul = v 
							self:OrganizeFrame(true)
						end,
					},
					prof = {
						name = L"Profession Bag", type = 'toggle', order = 4.5,
						desc = L"Turns display of profession bags on and off.",
						get = function() return self.db.profile.show.prof end,
						set = function(v) 
							self.db.profile.show.prof = v 
							self:OrganizeFrame(true)
						end,
					},
				}
			},
			colors = {
				name = L"Colors", type = 'group', order = 1,
				desc = L"Different color code settings.",
				args = {
					mouseover = {
						name = L"Mouseover Color", type = "color", order = 1,
						desc = L"Changes the highlight color for when you mouseover a bag slot.",
						get = function()
							local color = self.db.profile.colors.mouseover
							return color.r, color.g, color.b
						end,
						set = function(r, g, b) self.db.profile.colors.mouseover = {r = r, g = g, b = b} end,
					},
					ammo = {
						name = L"Ammo Bag Color", type = "color", order = 2,
						desc = L"Changes the highlight color for Ammo Bags.",
						get = function() 
							local color = self.db.profile.colors.ammo
							return color.r, color.g, color.b
						end, 
						set = function(r, g, b) 
							self.db.profile.colors.ammo = {r = r, g = g, b = b} 
							for k, bag in self.fBags do
                                if self.frame.bags[bag] then
                                    for k, v in ipairs(self.frame.bags[bag]) do 
                                        self:SetBorderColor(v)
                                    end
                                end
							end
						end,
					},
					soul = {
						name = L"Soul Bag Color", type = "color", order = 3,
						desc = L"Changes the highlight color for Soul Bags.",
						get = function()
							local color = self.db.profile.colors.soul
							return color.r, color.g, color.b
						end,
						set = function(r, g, b) 
							self.db.profile.colors.soul = {r = r, g = g, b = b} 
							for k, bag in self.fBags do
                                if self.frame.bags[bag] then
                                    for k, v in ipairs(self.frame.bags[bag]) do 
                                        self:SetBorderColor(v)
                                    end
                                end
							end
						end,
					},
					prof = {
						name = L"Profession Bag Color", type = "color", order = 4,
						desc = L"Changes the highlight color for Profession Bags.",
						get = function()
							local color = self.db.profile.colors.prof
							return color.r, color.g, color.b
						end,
						set = function(r, g, b) 
							self.db.profile.colors.prof = {r = r, g = g, b = b} 
							for k, bag in self.fBags do
                                if self.frame.bags[bag] then
                                    for k, v in ipairs(self.frame.bags[bag]) do 
                                        self:SetBorderColor(v)
                                    end
                                end
							end
						end,
					},
                    background = {
						name = L"Background Color", type = "color", order = 5,
						desc = L"Changes the background color for the frame.",
						get = function()
							local color = self.db.profile.colors.bground
							return color.r, color.g, color.b, color.a
						end,
						set = function(r, g, b, a) 
							self.db.profile.colors.bground = {r = r, g = g, b = b, a = a} 
							self.frame:SetBackdropColor(r, g, b, a)
                            if self.frame.bagFrame then
                                self.frame.bagFrame:SetBackdropColor(r, g, b, a)
                            end
						end,
                        hasAlpha = true,
					},
                    glow = {
						name = L"Highlight Glow", type = 'toggle', order = 6,
						desc = L"Turns hightlight glow on and off.",
						get = function() return self.db.profile.colors.glow end,
						set = function(v) 
							self.db.profile.colors.glow = v 
                            for k, bag in self.fBags do
								if self.frame.bags[bag] then
									for k, v in ipairs(self.frame.bags[bag]) do 
										self:SetBorderColor(v)
									end
								end
							end
						end,
                    },
					rarity = {
						name = L"Rarity Coloring", type = 'toggle', order = 7,
						desc = L"Turns rarity coloring on and off.",
						get = function() return self.db.profile.colors.rarity end,
						set = function(v) 
							self.db.profile.colors.rarity = v 
							for k, bag in self.fBags do
								if self.frame.bags[bag] then
									for k, v in ipairs(self.frame.bags[bag]) do 
										self:SetBorderColor(v)
									end
								end
							end
						end,
                    },
                    reset = {
                        name = L'Reset', type = 'group', order = -1,
                        desc = L"Reset the different colors.",
                        args = {
                            mouseover = {
                                name = L"Mouseover Color", type = "execute",
                                desc = L"Returns your mouseover color to the default.",
                                func = function() 
                                    self.db.profile.colors.mouseover = {r = 0, g = .7, b = 1}
                                end,
                                order = 1
                            },
                            ammo = {
                                name = L"Ammo Slot Color", type = "execute",
                                desc = L"Returns your ammo slot color to the default.",
                                func = function() 
                                    self.db.profile.colors.ammo = {r = 1, g = 1, b = 0}
                                    for k, bag in self.fBags do
                                        if self.frame.bags[bag] then
                                            for k, v in ipairs(self.frame.bags[bag]) do 
                                                self:SetBorderColor(v)
                                            end
                                        end
                                    end
                                end,
                                order = 2
                            },
                            soul = {
                                name = L"Soul Slot Color", type = "execute",
                                desc = L"Returns your soul slot color to the default.",
                                func = function() 
                                    self.db.profile.colors.soul = {r = .5, g = .5, b = 1}
                                    for k, bag in self.fBags do
                                        if self.frame.bags[bag] then
                                            for k, v in ipairs(self.frame.bags[bag]) do 
                                                self:SetBorderColor(v)
                                            end
                                        end
                                    end
                                end,
                                order = 3
                            },
                            prof = {
                                name = L"Profession Slot Color", type = "execute",
                                desc = L"Returns your profession slot color to the default.",
                                func = function() 
                                    self.db.profile.colors.prof = {r = 1, g = 0, b = 1}
                                    for k, bag in self.fBags do
                                        if self.frame.bags[bag] then
                                            for k, v in ipairs(self.frame.bags[bag]) do 
                                                self:SetBorderColor(v)
                                            end
                                        end
                                    end
                                end,
                                order = 4
                            },
                            background = {
                                name = L"Background", type = "execute",
                                desc = L"Returns your frame background to the default.",
                                func = function() 
                                    self.db.profile.colors.bground = {r = 0, g = 0, b = 0, a = .45}  
                                    self.frame:SetBackdropColor(0, 0, 0, .45)
                                    if self.frame.bagFrame then
                                        self.frame.bagFrame:SetBackdropColor(0, 0, 0, .45)
                                    end
                                end,
                                order = 5
                            }
                        }
					}
				}
			}
		}
	}   
end

function OneCore:LoadOptionalCommands(baseArgs, module)
    local self = module
    if IsAddOnLoaded("MrPlow") then
        baseArgs.args.plow = {
			name = L"Plow!", type = "execute",
			desc = L"Organizes your bags.",
			func = function() self:MrPlow() end,
            order = -5,
            notes = L"- Note: This option only appears if you have MrPlow installed"
		}
	end
end

function OneCore:CopyTable(from, into)
    if type(into) ~= "table" then into = {} end
    
	for key, val in from do
		if( type(val) == "table" ) then
			into[key] = self:CopyTable(val)
		else
			into[key] = val
		end
	end
	
	if (getn(from)) then
		table.setn(into, getn(from))		
	end

	return into
end

local module = OneCore.modulePrototype

function module:BuildFrame()
	debugprofilestart()    
	if self.isBank then
		if not self.frame.bags[BANK_CONTAINER] then 
			self.frame.bags[BANK_CONTAINER] = CreateFrame("Frame", "BBankFrame", self.frame)
			self.frame.bags[BANK_CONTAINER]:SetID(BANK_CONTAINER)
			self.frame.bags[BANK_CONTAINER].size = 24
			for slot = 1, 24 do
				self.frame.bags[BANK_CONTAINER][slot] = CreateFrame("Button", self.frame.bags[BANK_CONTAINER]:GetName().."Item"..slot, self.frame.bags[BANK_CONTAINER], "OneBankItemButtonTemplate")
				self.frame.bags[BANK_CONTAINER][slot]:SetID(slot)
			end
			self.needToOrganize = true
		end
	end
	
	for k, bag in self.fBags do		
		local size = GetContainerNumSlots(bag)
		for slot = 1, size do
			if not self.frame.bags[bag] then 
				self.frame.bags[bag] = CreateFrame("Frame", tostring(self)..bag, self.frame)
				self.frame.bags[bag]:SetID(bag)
			end
			if not self.frame.bags[bag][slot] then
				self.frame.bags[bag][slot] = CreateFrame("Button", tostring(self)..bag.."Item"..slot, self.frame.bags[bag], "OneBagItemButtonTemplate")
				self.frame.bags[bag][slot]:SetID(slot)
				self.needToOrganize = true
			end
		end
		if self.frame.bags[bag] then
			local curBag = self.frame.bags[bag]
			local isAmmo, isSoul, isProf = self:GetBagTypes(bag)
			if curBag.size ~= size or curBag.isAmmo ~= isAmmo or curBag.isSoul ~= isSoul or curBag.isProf ~= isProf then
				self.needToOrganize = true
			end
			curBag.size, curBag.isAmmo, curBag.isSoul, curBag.isProf = size, isAmmo, isSoul, isProf
		end
	end
	self:Debug(L"%s ran in %s", "BuildFrame", debugprofilestop())
end

function module:OrganizeFrame(needs)
	debugprofilestart()
	if not self.needToOrganize and not needs then return end
	self.needToOrganize = false
	
	local cols, curCol, curRow, justinc = self.db.profile.cols, 1, 1, false
	
	self.soulSlots, self.ammoSlots, self.profSlots, self.slotCount, self.totalCount = 0, 0, 0, 0, 0
	
	for k, bag in self.fBags do 
		if self.frame.bags[bag] then
			for k2, v2 in ipairs(self.frame.bags[bag]) do 
				v2:Hide()
			end
            self.totalCount = self.totalCount + (self.frame.bags[bag].size or 0)
        end
	end
	
    if self.db.profile.vAlign == L"Bottom" then
        curCol = math.mod(self.totalCount, cols) > 0 and cols - math.mod(self.totalCount, cols) + 1 or 1
        if self.db.profile.bagBreak then
            for k, bag in self.fBags do 
                if self.frame.bags[bag] and self.frame.bags[bag].size then curCol = curCol - 1 end
            end
            curCol = curCol + 1
        end
    end
    
    
	for k, bag in (self.db.profile.show.direction and self.fBags or self.rBags) do
		local curBag = self.frame.bags[bag]
        
		if curBag and curBag.size and curBag.size > 0 then
            if bag > 0 and math.mod(self.frame.bags[bag-1] and self.frame.bags[bag-1].size or 0, cols) ~= 0 and self.db.profile.bagBreak then 
                curCol = curCol + 1
                if curCol > cols then curCol, curRow, justinc = 1, curRow + 1, true  end
            end
			if curBag.isAmmo then
				self.ammoSlots = self.ammoSlots + curBag.size
			elseif curBag.isSoul then
				self.soulSlots = self.soulSlots + curBag.size
			elseif curBag.isProf then
				self.profSlots = self.profSlots + curBag.size
			else
				self.slotCount = self.slotCount + curBag.size
			end
			if self:ShouldShow(bag, curBag.isAmmo, curBag.isSoul, curBag.isProf) then
				for slot = 1, curBag.size do
                    justinc = false
					curBag[slot]:ClearAllPoints()
					curBag[slot]:SetPoint("TOPLEFT", self.frame:GetName(), "TOPLEFT", self.leftBorder + (self.colWidth * (curCol - 1)) , 0 - self.topBorder - (self.rowHeight * curRow))
					curBag[slot]:Show()				
					curCol = curCol + 1
					if curCol > cols then curCol, curRow, justinc = 1, curRow + 1, true  end
				end
			end
		end
	end
	self:Debug("CurrentRow: %s", curRow)
	
	if  not justinc then curRow = curRow + 1 end
	self.frame:SetHeight(curRow * self.rowHeight + self.bottomBorder + self.topBorder) 
	self.frame:SetWidth(cols * self.colWidth + self.leftBorder + self.rightBorder)
	
	self:Debug(L"%s ran in %s", "OrganizeFrame", debugprofilestop())
	
end

function module:SetBorderColor(slot)
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
	elseif self.db.profile.colors.rarity then
		local _, _, hex = strfind(GetContainerItemLink(bag:GetID(), slot:GetID()) or "", "(|cff%x%x%x%x%x%x)")
		
		for k, v in ipairs(ITEM_QUALITY_COLORS) do
			if hex == v.hex then 
                color = v 
                if k > 1 then
                    special = true 
                end
            end
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

function module:GetBagTypes(bag)
	if( bag <= 0 ) then return end
	
	local _, _, id = strfind(GetInventoryItemLink("player", ContainerIDToInventoryID(bag)) or "", "item:(%d+)");
	if id then 
		local _, _, _, _, itemType, subType = GetItemInfo(id);
		return (itemType == L"Quiver" or false), (subType == L"Soul Bag" or false), (( itemType == L"Container" and not (subType == L"Bag" or subType == L"Soul Bag")  ) or false)
	end
end

function module:HighlightBagSlots(bag)
	if not self.frame.bags[bag] then return end
	
	local color = self.db.profile.colors.mouseover 
	for k, v in ipairs(self.frame.bags[bag]) do 
    
        if self.db.profile.colors.glow then        
            v:SetNormalTexture("Interface\\Buttons\\UI-ActionButton-Border")
            v:GetNormalTexture():SetBlendMode("ADD")
            v:GetNormalTexture():SetAlpha(.8)
        else
            v:SetNormalTexture("Interface\\AddOns\\OneBag\\BagSlot2")
            v:GetNormalTexture():SetBlendMode("BLEND")
        end
		v:GetNormalTexture():SetVertexColor(color.r, color.g, color.b)
	end
end

function module:UnhighlightBagSlots(bag)
	if not self.frame.bags[bag] then return end
	for k, v in ipairs(self.frame.bags[bag]) do 
		self:SetBorderColor(v)
	end
end

function module:UpdateBag(bag)
	debugprofilestart()
	if not self.frame.bags[bag] then return end
	
	self:BuildFrame()
	self:OrganizeFrame()
	
	if not self.frame.bags[bag].colorLocked then
		for k, v in ipairs(self.frame.bags[bag]) do 
			self:SetBorderColor(v)
		end
	end
	
	if self.frame.bags[bag].size and self.frame.bags[bag].size > 0 then
		ContainerFrame_Update(self.frame.bags[bag])
	end
	
	self:DoSlotCounts()
	self:Debug(L"%s ran in %s", "UpdateBag", debugprofilestop())
end

function module:DoSlotCounts()
	local usedSlots, usedAmmoSlots, usedSoulSlots, usedProfSlots, ammoQuantity = 0, 0, 0, 0, 0 
	
	for k, bag in self.fBags do
		if self.frame.bags[bag] then
			local tmp, qty = 0, 0
			for slot = 1, GetContainerNumSlots(bag) do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if( texture) then 
					tmp = tmp + 1 
					qty = qty + itemCount
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
	
	self:Debug(L"Normal used: %s, Soul used: %s, Prof used: %s, Ammo used %s, Ammo quantity %s.", usedSlots, usedSoulSlots, usedProfSlots, usedAmmoSlots, ammoQuantity)
	
	local info = 1
	local  name = self.frame:GetName() .. "Info"	
	
	
	getglobal(name .. info):SetText(format(L"%s/%s Slots", usedSlots, self.slotCount))

    info = info + 1
    
    for i = 2, 4 do 
        getglobal(name .. i):SetText("")
    end
    
    if self.db.profile.show.counts then        
        if self.ammoSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Ammo", ammoQuantity, self.ammoSlots * 200))
            info = info + 1
        end
        if self.soulSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Soul Shards", usedSoulSlots, self.soulSlots))
            info = info + 1
        end
        if self.profSlots > 0 then
            getglobal(name .. info):SetText(format(L"%s/%s Profession Slots", usedProfSlots, self.profSlots))
            info = info + 1
        end
    end
end

function module:ShouldShow(bag, isAmmo, isSoul, isProf) 
	local show = true
	
	show = show and self.db.profile.show[bag] or false
	
	if isAmmo then
		show = show and self.db.profile.show.ammo or false
	elseif isSoul then
		show = show and self.db.profile.show.soul or false
	elseif isProf then
		show = show and self.db.profile.show.prof or false
	end
	return (show or self.frame.bags[bag].colorLocked )
end

function module:OpenMenu()	
	if self.dewdrop:IsOpen(getglobal(self.frame:GetName() .. "ConfigButton")) then
		self.dewdrop:Close()
	else
		self.dewdrop:Open(getglobal(self.frame:GetName() .. "ConfigButton"), self.frame)
	end
end

function module:MrPlow()
	MrPlow:Works(self.isBank and "bank" or nil)
end

function module:OnBaseShow()
    this:SetScale(self.db.profile.scale)
    this:SetAlpha(self.db.profile.alpha)
    this:SetFrameStrata(self.stratas[self.db.profile.strata])
    StackSplitFrame:SetFrameStrata(self.stratas[self.db.profile.strata+1])
    
    local color = self.db.profile.colors.bground
    this:SetBackdropColor(color.r, color.g, color.b, color.a)
    
	self.frame:SetClampedToScreen(self.db.profile.clamped or false)
end

function module:OnShow()
    self:OnBaseShow()
    self:OnCustomShow()
    PlaySound("igBackPackOpen")
    
    if self.frame.bagFrame and self.frame.bagFrame.wasShown then
        self.frame.bagFrame:Show()
        self.frame.bagFrame.wasShown  = false
    end
    
    self:BuildFrame()
    self:OrganizeFrame()
    for k, i in self.fBags do
        self:UpdateBag(i)     
    end
    
    if self.frame.bags[-1] and (not self.frame.bags[-1].colorLocked) then
        for k, v in ipairs(self.frame.bags[-1]) do 
            self:SetBorderColor(v)
        end
    end
    
    self:DoSlotCounts()
end

function module:OnCustomShow() end -- Meant to be overridden

function module:OnBaseHide()
    if self.dewdrop and self.dewdrop:IsOpen(getglobal(self.frame:GetName() .. "ConfigButton")) then
		self.dewdrop:Close()
	end
end

function module:OnHide()
    self:OnBaseHide()
    self:OnCustomHide()
    PlaySound("igBackPackClose")
    if self.frame.bagFrame and self.frame.bagFrame:IsVisible() then
        self.frame.bagFrame:Hide()
        self.frame.bagFrame.wasShown = true
    end
end

function module:OnCustomHide() end -- Meant to be overridden


function module:RegisterDewdrop(baseArgs)
    self.dewdrop = AceLibrary("Dewdrop-2.0")
	self.dewdrop:Register(self.frame,
			'children', baseArgs,
			'point', function(parent)
				if parent:GetTop() < GetScreenHeight() / 2 then
					return "BOTTOMRIGHT", "TOPRIGHT"
				else
					return "TOPRIGHT", "BOTTOMRIGHT"
				end
			end,
			'dontHook', true
		)
end
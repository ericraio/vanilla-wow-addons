BagFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceConsole-2.0")
BagFu:RegisterDB("BagFuDB")
BagFu:RegisterDefaults('profile', {
	showDepletion = false,
	includeProfession = true,
	includeAmmo = false,
})

BagFu.hasIcon = true
BagFu.cannotDetachTooltip = true
BagFu.defaultPosition = "RIGHT"

local L = AceLibrary("AceLocale-2.0"):new("BagFu")
function BagFu:OnInitialize()
	--self.dewdrop = AceLibrary("Dewdrop-2.0")
	self.crayon = AceLibrary("Crayon-2.0")
	self.tablet = AceLibrary("Tablet-2.0")

	self.options = {
		type = "group",
		args = {
			ammobags = {
				type = "toggle",
				name = L["AMMO_BAGS"],
				desc = L["MENU_INCLUDE_AMMO_BAGS"],
				get = function() return self.db.profile.includeAmmo end,
				set = function()
					self.db.profile.includeAmmo = not self.db.profile.includeAmmo
					self:Update()
				end,
				order = 110
			},
			professionbags = {
				type = "toggle",
				name = L["PROFESSION_BAGS"],
				desc = L["MENU_INCLUDE_PROFESSION_BAGS"],
				get = function() return self.db.profile.includeProfession end,
				set = function()
					self.db.profile.includeProfession = not self.db.profile.includeProfession
					self:Update()
				end,
				order = 120
			},
			depletion = {
				type = "toggle",
				name = L["BAG_DEPLETION"],
				desc = L["MENU_SHOW_DEPLETION_OF_BAGS"],
				get = function() return self.db.profile.showDepletion end,
				set = function()
					self.db.profile.showDepletion = not self.db.profile.showDepletion
					self:Update()
				end,
				order = 130
			}
		}
	}
	self.OnMenuRequest = self.options
	self:RegisterChatCommand({ "/bagfu" }, self.options)
end

function BagFu:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "OnPlayerLeavingWorld")
	self:RegisterEvent("BAG_UPDATE", "Update")
end


function BagFu:OnPlayerEnteringWorld()
	self:RegisterEvent("BAG_UPDATE", "Update")
end

function BagFu:OnPlayerLeavingWorld()
	self:UnregisterEvent("BAG_UPDATE")
end

function BagFu:UpdateText()
	local totalSlots = 0
	local takenSlots = 0
	for i = 0, 4 do
		local usable = TRUE
		if i >= 1 then
			local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
			if link ~= nil then
				local itemId = tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0)
				local _,_,_,_,_,subtype = GetItemInfo(itemId)
				if not self.db.profile.includeAmmo and (subtype == L["TEXT_SOUL_BAG"] or subtype == L["TEXT_AMMO_POUCH"] or subtype == L["TEXT_QUIVER"]) then
					usable = FALSE
				elseif not self.db.profile.includeProfession and (subtype == L["TEXT_ENCHANTING_BAG"] or subtype == L["TEXT_HERB_BAG"] or subtype == L["TEXT_ENGINEERING_BAG"]) then
					usable = FALSE
				end
			end
		end
		if usable then
			local size = GetContainerNumSlots(i)
			
			if size ~= nil and size > 0 then
				totalSlots = totalSlots + size
				for slot = 1, size do
					if GetContainerItemInfo(i, slot) then
						takenSlots = takenSlots + 1
					end
				end
			end
		end
	end
	
	local color = self.crayon:GetThresholdHexColor((totalSlots - takenSlots) / totalSlots)
	
	if self.db.profile.showDepletion then
		takenSlots = totalSlots - takenSlots
	end
	
	self:SetText(format("|cff%s%d/%d|r", color, takenSlots, totalSlots))
end

function BagFu:OnTooltipUpdate()
	self.tablet:SetHint(L["TEXT_HINT"])
end

function BagFu:OnClick()
	if not ContainerFrame1:IsShown() then
		for i = 1, 4 do
			if getglobal("ContainerFrame" .. (i + 1)):IsShown() then
				getglobal("ContainerFrame" .. (i + 1)):Hide()
			end
		end
		ToggleBackpack()
		if ContainerFrame1:IsShown() then
			for i = 1, 4 do
				local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
				if link ~= nil then
					local itemId = tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0)
					local _,_,_,_,_,subtype = GetItemInfo(itemId)
					local usable = TRUE
					if not self.db.profile.includeAmmo and (subtype == L["TEXT_SOUL_BAG"] or subtype == L["TEXT_AMMO_POUCH"] or subtype == L["TEXT_QUIVER"]) then
						usable = FALSE
					elseif not self.db.profile.includeProfession and (subtype == L["TEXT_ENCHANTING_BAG"] or subtype == L["TEXT_HERB_BAG"] or subtype == L["TEXT_ENGINEERING_BAG"]) then
						usable = FALSE
					end
					if usable then
						ToggleBag(i)
					end
				end
			end
		end
	else
		for i = 0, 4 do
			if getglobal("ContainerFrame" .. (i + 1)):IsShown() then
				getglobal("ContainerFrame" .. (i + 1)):Hide()
			end
		end
	end
end

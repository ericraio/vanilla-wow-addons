
local custom = SupplyAndDemand:GetModule("Misc")

local always = SupplyAndDemand:NewModule("Always")
always.metadataheader = "X-S&D-Always"
always.loadcondition = function() return true end


local inparty = SupplyAndDemand:NewModule("In Party")
inparty.metadataheader = "X-S&D-InParty"
inparty.loadcondition = function() return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 end
inparty.event = "PARTY_MEMBERS_CHANGED"


local inraid = SupplyAndDemand:NewModule("In Raid")
inraid.metadataheader = "X-S&D-InRaid"
inraid.loadcondition = function() return GetNumRaidMembers() > 0 end
inraid.event = "RAID_ROSTER_UPDATE"


local resting = SupplyAndDemand:NewModule("Resting")
resting.metadataheader = "X-S&D-Resting"
resting.loadcondition = function() return IsResting() end
resting.event = "PLAYER_UPDATE_RESTING"


local notresting = SupplyAndDemand:NewModule("Not Resting")
notresting.metadataheader = "X-S&D-NotResting"
notresting.loadcondition = function() return not IsResting() end
notresting.event = "PLAYER_UPDATE_RESTING"


local mail = SupplyAndDemand:NewModule("At Mailbox")
mail.metadataheader = "X-S&D-AtMail"
mail.loadcondition = function() return MailFrame:IsVisible() end
mail.event = "MAIL_SHOW"


local merchant = SupplyAndDemand:NewModule("At Merchant")
merchant.metadataheader = "X-S&D-AtMerchant"
merchant.loadcondition = function() return MerchantFrame:IsVisible() end
merchant.event = "MERCHANT_SHOW"

local crafting = SupplyAndDemand:NewModule("Crafting")
crafting.metadataheader = "X-S&D-Crafting"
crafting.loadcondition = function() return (CraftFrame and CraftFrame:IsVisible()) or (TradeSkillFrame and TradeSkillFrame:IsVisible()) end
crafting.event = {
    "MERCHANT_SHOW",
    "CRAFT_SHOW"
}

local pvp = SupplyAndDemand:NewModule("PvP Flagged")
pvp.metadataheader = "X-S&D-PvPFlagged"
pvp.loadcondition = function() return UnitIsPVP("player") end
pvp.event = "UNIT_FACTION"


local truefunc = function() return true end
local lclass, class = UnitClass("player")
local byclass = SupplyAndDemand:NewModule("By Class")
byclass.nomenu = true
byclass.nodb = true

function byclass:OnInitialize()
	for name,mod in pairs(self.lodmods) do
		local classes = GetAddOnMetadata(name, "X-S&D-Class")
		if classes and string.find(string.upper(classes), class) then
			custom:RegisterMod(name, lclass, nil, truefunc)
		end
	end
end

function byclass:OnEnable()
end

-- level, zone

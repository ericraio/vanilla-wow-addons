
local gratuity = AceLibrary("Gratuity-2.0")
local findstr = string.gsub(DURABILITY_TEMPLATE, "%%[^%s]+", "(.+)")
local abacus = AceLibrary("Abacus-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local crayon = AceLibrary("Crayon-2.0")

local items = {
	{name = INVTYPE_HEAD, slot = "Head"},
	{name = INVTYPE_SHOULDER, slot = "Shoulder"},
	{name = INVTYPE_CHEST, slot = "Chest"},
	{name = INVTYPE_WAIST, slot = "Waist"},
	{name = INVTYPE_LEGS, slot = "Legs"},
	{name = INVTYPE_FEET, slot = "Feet"},
	{name = INVTYPE_WRIST, slot = "Wrist"},
	{name = INVTYPE_HAND, slot = "Hands"},
	{name = INVTYPE_WEAPONMAINHAND, slot = "MainHand"},
	{name = INVTYPE_WEAPONOFFHAND, slot = "SecondaryHand"},
	{name = INVTYPE_RANGED, slot = "Ranged"},
}


FuBar_DuraTek = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceDB-2.0")
FuBar_DuraTek:RegisterDB("DuraTek")
FuBar_DuraTek.hasIcon = true
FuBar_DuraTek.cannotHideText = false


function FuBar_DuraTek:OnEnable()
	self:RegisterBucketEvent({
		"PLAYER_UNGHOST",
		"PLAYER_DEAD",
		"PLAYER_REGEN_ENABLED",
		"UPDATE_INVENTORY_ALERTS",
		"MERCHANT_SHOW",
		"MERCHANT_CLOSED",
	}, 1, "Update")
end


function FuBar_DuraTek:OnDataUpdate()
	local t1, t2, tcost = 0, 0, 0
	for i in ipairs(items) do
		local v1, v2, cost = self:UpdateItem(i)
		t1, t2, tcost = t1 + v1, t2 + v2, tcost + cost
	end

	self.perc, self.totalcost = (t2 == 0) and 1 or t1/t2, tcost
end


function FuBar_DuraTek:OnTextUpdate()
	self:SetText(string.format("|cff%s%d%%", crayon:GetThresholdHexColor(self.perc), self.perc * 100))
end


function FuBar_DuraTek:OnTooltipUpdate()
	local cat = tablet:AddCategory("columns", 3, "child_justify2", "RIGHT")
	for _,item in ipairs(items) do
		if item.hasItem and item.percent and item.percent > 0 then
			cat:AddLine("text", item.name, "text2", (item.cost > 0) and abacus:FormatMoneyCondensed(item.cost, true) or "",
				"text3", crayon:Colorize(crayon:GetThresholdHexColor(item.percent), string.format("%d%%", item.percent*100)))
		end
	end
	cat:AddLine()

	cat:AddLine("text", "Total", "text2", (self.totalcost > 0) and abacus:FormatMoneyFull(self.totalcost, true) or "",
		"text3", string.format("%d%%", self.perc * 100))
end


function FuBar_DuraTek:UpdateItem(index)
	local item = items[index]
	local id = GetInventorySlotInfo(item.slot .. "Slot")
	local hasItem, _, cost = gratuity:SetInventoryItem("player", id)

	local v1, v2
	if hasItem then _, _, v1, v2 = gratuity:Find(findstr) end
	v1, v2, cost = tonumber(v1) or 0, tonumber(v2) or 0, tonumber(cost) or 0
	item.percent, item.cost = (v2 == 0) and 1 or v1/v2, cost
	item.hasItem = hasItem
	return v1, v2, cost
end

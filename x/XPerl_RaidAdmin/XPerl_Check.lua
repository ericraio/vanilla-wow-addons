XPerl_CheckItems = {}
XPerl_ItemResults = {["type"] = "item"}
XPerl_ResistResults = {["type"] = "res", count = 0}
XPerl_DurResults = {["type"] = "dur", count = 0}
XPerl_RegResults = {["type"] = "reg", count = 0}
XPerl_PlayerList = {}
XPerl_MsgQueue = {}
SelectedPlayer = nil
XPerl_ActiveScan = nil
ActiveScanItem = nil
ActiveScanTotals = nil

local ITEMLISTSIZE		= 12
local PLAYERLISTSIZE		= 10

-- XPerl_CheckOnLoad
function XPerl_CheckOnLoad()
	this:RegisterEvent("CHAT_MSG_ADDON")
	this:RegisterEvent("RAID_ROSTER_UPDATE")

	XPerl_CheckListItemsScrollBar.offset = 0
	XPerl_CheckListPlayersScrollBar.offset = 0
end

if (not XPerl_GetClassColour) then
	XPerl_GetClassColour = function(class)
		if (class) then
			local color = RAID_CLASS_COLORS[class];		-- Now using the WoW class color table
			if (color) then
				return color
			end
		end
		return {r = 0.5, g = 0.5, b = 1}
	end
end

if (not XPerlColourTable) then
	local function MashXX(class)
		local c = RAID_CLASS_COLORS[class]
		XPerlColourTable[class] = string.format("|c00%02X%02X%02X", 255 * c.r, 255 * c.g, 255 * c.b)
	end
	XPerlColourTable = {}
	MashXX("HUNTER")
	MashXX("WARLOCK")
	MashXX("PRIEST")
	MashXX("PALADIN")
	MashXX("MAGE")
	MashXX("ROGUE")
	MashXX("DRUID")
	MashXX("SHAMAN")
	MashXX("WARRIOR")
end

if (not XPerl_ClassPos) then
	XPerl_ClassPos = function(class)
		if(class=="WARRIOR") then return 0,    0.25,    0,	0.25;	end
		if(class=="MAGE")    then return 0.25, 0.5,     0,	0.25;	end
		if(class=="ROGUE")   then return 0.5,  0.75,    0,	0.25;	end
		if(class=="DRUID")   then return 0.75, 1,       0,	0.25;	end
		if(class=="HUNTER")  then return 0,    0.25,    0.25,	0.5;	end
		if(class=="SHAMAN")  then return 0.25, 0.5,     0.25,	0.5;	end
		if(class=="PRIEST")  then return 0.5,  0.75,    0.25,	0.5;	end
		if(class=="WARLOCK") then return 0.75, 1,       0.25,	0.5;	end
		if(class=="PALADIN") then return 0,    0.25,    0.5,	0.75;	end
		return 0.25, 0.5, 0.5, 0.75	-- Returns empty next one, so blank
	end
end

-- CTRAItemMsg
local needUpdate
local function CTRAItemMsg(nick, item, count)

	local results = XPerl_ItemResults[item]

	if (not results) then
		ChatFrame7:AddMessage("Missing results for "..item)
	else
		results.last = GetTime()
		tinsert(results, {name = nick, ["count"] = tonumber(count)})
		needUpdate = true
	end
end

local function ProcessCTRAMessage(unitName, msg)
--ChatFrame7:AddMessage(unitName..": "..msg)
	if (strfind(msg, "^ITM ")) then
		local _, _, numItems, itemName, callPerson = strfind(msg, "^ITM ([-%d]+) (.+) ([^%s]+)$")

		if (callPerson == UnitName("player")) then		-- Maybe ignore this
			CTRAItemMsg(unitName, itemName, numItems)
		end

	elseif (strfind(msg, "^DUR ")) then
		local _, _, currDur, maxDur, brokenItems, callPerson = strfind(msg, "^DUR (%d+) (%d+) (%d+) ([^%s]+)$")

		if (currDur and maxDur and brokenItems) then
			currDur, maxDur, brokenItems = tonumber(currDur), tonumber(maxDur), tonumber(brokenItems)
			XPerl_DurResults[unitName] = {dur = floor((currDur/maxDur)*100+0.5), broken = brokenItems}
			if (callPerson == UnitName("player")) then
				XPerl_DurResults.count = XPerl_DurResults.count + 1
			end
			XPerl_DurResults.last = GetTime()
			needUpdate = true
		end

	elseif (strfind(msg, "^RST ")) then
		local _, _, plrName = strfind(msg, "^RST %-1 ([^%s]+)$");
		if (not plrName) then
			local _, _, FR, NR, FRR, SR, AR, callPerson = strfind(msg, "^RST (%d+) (%d+) (%d+) (%d+) (%d+) ([^%s]+)$")
			if (FR) then
				XPerl_ResistResults[unitName] = {fr = tonumber(FR), nr = tonumber(NR), frr = tonumber(FRR), sr = tonumber(SR), ar = tonumber(AR)}
				if (callPerson == UnitName("player")) then
					XPerl_ResistResults.count = XPerl_ResistResults.count + 1
				end
				XPerl_ResistResults.last = GetTime()
				needUpdate = true
			end
		end

	elseif (strfind(msg, "^REA ")) then
		local _, _, numItems, callPerson = strfind(msg, "^REA ([^%s]+) ([^%s]+)$");
		if (numItems) then
			XPerl_RegResults[unitName] = {count = tonumber(numItems)}
			if (callPerson == UnitName("player")) then
				XPerl_RegResults.count = XPerl_RegResults.count + 1
			end
			XPerl_RegResults.last = GetTime()
			needUpdate = true
		end
	end
end

-- XPerl_Check_Setup
function XPerl_Check_Setup()

	SlashCmdList["XPERLITEM"] = XPerl_ItemCheck
	SLASH_XPERLITEM1 = "/xpitem"
	SLASH_XPERLITEM2 = "/raitem"
	SLASH_XPERLITEM3 = "/radur"
	SLASH_XPERLITEM4 = "/raresist"
	SLASH_XPERLITEM5 = "/raresists"
	SLASH_XPERLITEM6 = "/rareg"

	SlashCmdList["RAITEM"] = nil
	SLASH_RAITEM1 = nil
	SlashCmdList["RADUR"] = nil
	SLASH_RADUR1 = nil
	SlashCmdList["RARST"] = nil
	SLASH_RARST1 = nil
	SlashCmdList["RAREG"] = nil
	SLASH_RAREG1 = nil

	if (oRA) then		-- oRA2
		oRA:UnRegisterShorthand("raitem")
		oRA:UnRegisterShorthand("rareg")
		oRA:UnRegisterShorthand("radur")
		oRA:UnRegisterShorthand("raresist")
	elseif (oRA_Core) then	-- oRA1
		oRA_Core:UnregisterShortHand("raitem")
		oRA_Core:UnregisterShortHand("rareg")
		oRA_Core:UnregisterShortHand("radur")
		oRA_Core:UnregisterShortHand("raresist")
	end

	if (not XPerl_Admin.ResistSort) then
		XPerl_Admin.ResistSort = "fr"
	end
	for k,v in ipairs(XPerl_CheckItems) do
		v.query = nil
	end

	XPerl_CheckTitleBarPin:SetButtonTex()
	XPerl_CheckTitleBarLockOpen:SetButtonTex()

	XPerl_CheckListPlayersTotals:SetHighlightTexture(nil)
	XPerl_CheckListPlayersTotals:SetScript("OnClick", nil)

	XPerl_Check_ItemsChanged()
	XPerl_Check_UpdatePlayerList()
end

-- XPerl_CheckOnEvent
function XPerl_CheckOnEvent()
	if (event == "RAID_ROSTER_UPDATE") then
		if (not UnitInRaid("player")) then
			XPerl_ItemResults = {["type"] = "item"}
			XPerl_ResistResults = {["type"] = "res", count = 0}
			XPerl_DurResults = {["type"] = "dur", count = 0}
			XPerl_RegResults = {["type"] = "reg", count = 0}
		end
		XPerl_Check_ValidateButtons()

	elseif (event == "CHAT_MSG_ADDON") then
		if (arg1 == "CTRA" and arg3 == "RAID") then
			needUpdate = nil
			XPerl_ParseCTRA(arg4, arg2, ProcessCTRAMessage)

			if (needUpdate) then
				XPerl_Check_UpdateItemList()
				XPerl_Check_MakePlayerList()
				XPerl_Check_ShowInfo()
			end
		end
	elseif (event == "UNIT_INVENTORY_CHANGED" or event == "UNIT_MODEL_CHANGED") then
		local n = UnitName(arg1)
		if (XPerl_ActiveScan and XPerl_ActiveScan[n]) then
			XPerl_ActiveScan[n].changed = true
			XPerl_ActiveScan[n].offline = nil
			XPerl_ActiveScan[n].wrongZone = nil
		end
	end
end

-- XPerl_CheckOnUpdate
-- Only active after a query, and only for 10 seconds
local function XPerl_CheckOnUpdate()

	-- TODO Total Progress indication

	if (getn(XPerl_MsgQueue) > 0) then
		local Time = GetTime()
		local send
		if (not XPerl_Check.lastMsgsent) then
			send = true
		elseif (Time > XPerl_Check.lastMsgsent + 1) then
			send = true
		end

		if (send) then
			XPerl_Check.lastMsgsent = Time

			local count = 0
			local msg = ""

			while (getn(XPerl_MsgQueue) > 0 and count < 4) do
				local sub = XPerl_MsgQueue[1]

				if (strlen(msg..sub) > 220) then
					SendAddonMessage("CTRA", msg, "RAID")
					break
				else
					count = count + 1
					tremove(XPerl_MsgQueue, 1)
					if (msg == "") then
						msg = sub
					else
						msg = msg.."#"..sub
					end
				end
			end

			if (msg ~= "") then
				SendAddonMessage("CTRA", msg, "RAID")
			end
		end

	elseif (ActiveScanItem) then
		XPerl_Check_ActiveScan()
	else
		if (XPerl_Check.queryStart and GetTime() > XPerl_Check.queryStart + 5) then
			XPerl_Check:SetScript("OnUpdate", nil)
			XPerl_Check.queryStart, XPerl_Check.lastMsgsent = nil, nil

			XPerl_Check_ValidateButtons()
		end
	end
end

-- GetVLinkName
local function GetVLinkName(v)
	local linkName
	if (strsub(v.link, 1, 1) == "|") then
		local _
		_, _, linkName = strfind(v.link, "%[(.+)%]")
	else
		linkName = v.link
	end
	return linkName
end

-- ClearSelectedItem
local function ClearSelectedItem()
	for k,v in ipairs(XPerl_CheckItems) do
		v.selected = nil
	end
end

-- TickItemByName
local function TickItemByName(itemName)
	for k,v in ipairs(XPerl_CheckItems) do
		local name = GetVLinkName(v)

		if (name == itemName) then
			if (not v.fixed) then
				v.ticked = true
			end
			v.selected = true
			break
		end
	end
end

-- GotItem
local function GotItem(link)
	local _,_, findItem = strfind(link, "item:(%d+):")
	for k,v in pairs(XPerl_CheckItems) do
		local _, _, item = strfind(v.link, "item:(%d+):")
		if (item == findItem) then
			return true
		end
	end
end

-- GotItem
local function GotItemName(itemName)
	for k,v in pairs(XPerl_CheckItems) do
		local _, _, linkName = strfind(v.link, "%[(.+)%]")
		if (linkName == itemName) then
			return true
		end
	end
end

-- InsertItemLink
local function InsertItemLink(itemLink)
	ClearSelectedItem()

	if (strsub(itemLink, 1, 1) == "|") then
		if (not GotItem(itemLink)) then
			tinsert(XPerl_CheckItems, {link = itemLink, ticked = true, selected = true})
		else
			local _, _, linkName = strfind(itemLink, "%[(.+)%]")
			TickItemByName(linkName)
		end
	else
		if (not GotItemName(itemLink)) then
			tinsert(XPerl_CheckItems, {link = itemLink, ticked = true, selected = true})
		else
			local _, _, linkName = strfind(itemLink, "%[(.+)%]")
			TickItemByName(linkName)
		end
	end
end

-- XPerl_Check_Expand()
function XPerl_Check_Expand(forced)
	XPerl_Check:SetWidth(500)
        XPerl_Check:SetHeight(241)		--213)
        XPerl_CheckList:Show()
        XPerl_CheckButton:Show()
	XPerl_Check.forcedOpen = forced
	XPerl_CheckTitleBarLockOpen:Show()
end

-- XPerl_ItemCheck
function XPerl_ItemCheck(itemName)

	local cmd = "/raitem"
	if (DEFAULT_CHAT_FRAME.editBox) then
		local command = DEFAULT_CHAT_FRAME.editBox:GetText()
		if (strlower(strsub(command, 1, 6)) == "/radur") then
			cmd = "/radur"
		elseif (strlower(strsub(command, 1, 9)) == "/raresist") then
			cmd = "/raresist"
		elseif (strlower(strsub(command, 1, 6)) == "/rareg") then
			cmd = "/rareg"
		end
	end

	XPerl_Check:Show()
	XPerl_Check_Expand(true)

	if (cmd == "/raitem") then
		if (not itemName or itemName == "") then
			return
		end

		if (strsub(itemName, 1, 1) == "|") then
			-- TODO search for item in inventory (and LootLink) and use the link
		end

		InsertItemLink(itemName)
	elseif (cmd == "/radur") then
		ClearSelectedItem()
		TickItemByName("dur")

	elseif (cmd == "/rareg") then
		ClearSelectedItem()
		TickItemByName("reg")

	elseif (cmd == "/raresist") then
		ClearSelectedItem()
		TickItemByName("res")
	end

	XPerl_Check_Query()
end

-- XPerl_PickupContainerItem
local oldPickup
local PickupBag, PickupSlot
local function XPerl_PickupContainerItem(bagID, slot)
	PickupBag, PickupSlot = bagID, slot
	return oldPickup(bagID, slot)
end

if (not oldPickup) then
	oldPickup = PickupContainerItem
	PickupContainerItem = XPerl_PickupContainerItem
end

-- sortItems
-- Fixed entries at top, followed by last current queried, followed by rest. Alphabetical within this.
local function sortItems(i1, i2)

	local itemName1 = GetVLinkName(i1)
	local itemName2 = GetVLinkName(i2)

	local t1, t2, f1, f2, q1, q2
	if (i1.fixed) then f1 = "0" else f1 = "1" end
	if (i2.fixed) then f2 = "0" else f2 = "1" end
	if (i1.ticked) then t1 = "0" else t1 = "1" end
	if (i2.ticked) then t2 = "0" else t2 = "1" end
	if (i1.query) then q1 = "0" else q1 = "1" end
	if (i2.query) then q2 = "0" else q2 = "1" end

	return f1..q1..t1..itemName1 < f2..q2..t2..itemName2
end

-- ItemsChanged
function XPerl_Check_ItemsChanged()

	-- Validate. Make sure we have our fixed entries
	local dur, reg, res
	for k,v in ipairs(XPerl_CheckItems) do
		if (v.link == "res") then
			res = true
		elseif (v.link == "dur") then
			dur = true
		elseif (v.link == "reg") then
			reg = true
		end
	end
	if (not dur) then
		tinsert(XPerl_CheckItems, {fixed = true, link = "dur"})
	end
	if (not res) then
		tinsert(XPerl_CheckItems, {fixed = true, link = "res"})
	end
	if (not reg) then
		tinsert(XPerl_CheckItems, {fixed = true, link = "reg"})
	end

	sort(XPerl_CheckItems, sortItems)

	XPerl_Check_UpdateItemList()
	XPerl_Check_ValidateButtons()
end

-- GetSelectedResults
local function GetSelectedItem()
	for k,v in ipairs(XPerl_CheckItems) do
		if (v.selected) then
			if (v.fixed) then
				if (v.link == "res") then
					return XPerl_ResistResults, "res"
				elseif (v.link == "dur") then
					return XPerl_DurResults, "dur"
				elseif (v.link == "reg") then
					return XPerl_RegResults, "reg"
				end
			else
				local linkName = GetVLinkName(v)
				if (linkName) then
					return XPerl_ItemResults[linkName], "item"
				end
				break
			end
		end
	end
end

-- GetSelectedItemLink
local function GetSelectedItemLink()
	local link
	for k,v in ipairs(XPerl_CheckItems) do
		if (v.selected) then
			return v.link
		end
	end
end

-- GetCursorItem
local function GetCursorItemLink()
	local id = this:GetID() + XPerl_CheckListItemsScrollBar.offset
	local item = XPerl_CheckItems[id]
	if (item and not item.fixed) then
		return item.link
	end
	return ""
end

-- SelectClickedTickItem
local function SelectClickedTickItem()

	local oldSelection
	for k,v in ipairs(XPerl_CheckItems) do
		if (v.selected) then
			oldSelection = v
			v.selected = nil
		end
	end

	local id
	if (this:GetFrameType() == "CheckButton") then
		id = this:GetParent():GetID()
	else
		id = this:GetID()
	end

	if (id and id > 0) then
		id = id + XPerl_CheckListItemsScrollBar.offset

		local item = XPerl_CheckItems[id]
		if (item) then
			item.selected = true
		end

		if (oldSelection ~= item) then
			XPerl_Check_StopActiveScan()
			XPerl_ActiveScan = nil
			ActiveScanTotals = nil
		end

		XPerl_Check_UpdateItemList()
		XPerl_Check_MakePlayerList()
		XPerl_Check_ShowInfo()
	end
end

-- XPerl_Check_TickAll
function XPerl_Check_TickAll(all)
	for k,v in ipairs(XPerl_CheckItems) do
		if (not v.fixed) then
			v.ticked = all
		end
	end
	XPerl_Check_ItemsChanged()
end

-- XPerl_Check_TickLastResults
function XPerl_Check_TickLastResults()
	for k,v in ipairs(XPerl_CheckItems) do
		if (not v.fixed) then
			v.ticked = nil

			local linkName = GetVLinkName(v)
			if (linkName) then
				if (XPerl_ItemResults[linkName]) then
					v.ticked = true
				end
			end
		end
	end

	XPerl_Check_ItemsChanged()
end

-- XPerl_Check_OnClickItem
function XPerl_Check_OnClickItem(button)

	if (button == "LeftButton") then
		if (IsShiftKeyDown()) then
			if (ChatFrameEditBox:IsVisible()) then
				ChatFrameEditBox:Insert(GetCursorItemLink())
			end
		elseif (IsControlKeyDown()) then
			DressUpItemLink(GetCursorItemLink())

		else
			if (CursorHasItem()) then
				ClearCursor()

				if (PickupBag and PickupSlot) then
					local itemLink = GetContainerItemLink(PickupBag, PickupSlot)

					if (itemLink) then
						InsertItemLink(itemLink)
						XPerl_Check_ItemsChanged()
					end
				end
			end

			XPerl_CheckListPlayersScrollBarScrollBar:SetValue(0)
			SetPortraitTexture(XPerl_CheckButtonPlayerPortrait, "raidx")
			SelectedPlayer = nil
			SelectClickedTickItem(true)
			XPerl_Check_ValidateButtons()
		end
	end
end

local reagentClasses = {
	PRIEST = true,
	MAGE = true,
	DRUID = true,
	WARLOCK = true,
	PALADIN = true,
	SHAMAN = true
}

-- GetOnlineMembers
local function GetOnlineMembers()
	local count = 0
	local reagentCount = 0
	for i = 1,GetNumRaidMembers() do
		if (UnitIsConnected("raid"..i)) then
			local _, class = UnitClass("raid"..i)

			if (reagentClasses[class]) then
				reagentCount = reagentCount + 1
			end

			if (XPerl_Roster) then
				local stats = XPerl_Roster[UnitName("raid"..i)]
				if (stats) then
					if (stats.version) then
						count = count + 1
					end
				end
			else
				count = count + 1
			end
		end
	end
	return count, reagentCount
end

-- SmoothColour
local function SmoothColour(percentage)
	local r, g
	if (percentage < 0.5) then
		g = 2*percentage
		r = 1
	else
		g = 1
		r = 2*(1 - percentage)
	end
	if (r < 0) then r = 0 elseif (r > 1) then r = 1 end
	if (g < 0) then g = 0 elseif (g > 1) then g = 1 end
	return r, g, 0
end

-- SmoothBarColor
local function SmoothGuageColor(bar, percentage)
	local r, g, b = SmoothColour(percentage)
	bar:SetVertexColor(r, g, b, 0.75)
end

-- XPerl_Check_UpdateItemList
function XPerl_Check_UpdateItemList()

	local onlineCount, reagentCount = GetOnlineMembers()
	local index = 1
	local i = 0
	for k,v in ipairs(XPerl_CheckItems) do
		if (index > ITEMLISTSIZE) then
			break
		end
		if (i >= XPerl_CheckListItemsScrollBar.offset) then
			local frame = getglobal("XPerl_CheckListItems"..index)
			local nameFrame = getglobal("XPerl_CheckListItems"..index.."Name")
			local countFrame = getglobal("XPerl_CheckListItems"..index.."Count")
			local iconFrame = getglobal("XPerl_CheckListItems"..index.."Icon")
			local gaugeFrame = getglobal("XPerl_CheckListItems"..index.."Gauge")
			local tickFrame = getglobal("XPerl_CheckListItems"..index.."Tick")

			frame:Show()
			if (v.selected) then
				frame:LockHighlight()
			else
				frame:UnlockHighlight()
			end

			if (v.fixed) then
				tickFrame:Hide()
				iconFrame:Hide()

				local div
				if (v.link == "res") then
					nameFrame:SetText(RESISTANCE_LABEL)
					countFrame:SetText(XPerl_ResistResults.count)
					div = XPerl_ResistResults.count / onlineCount

				elseif (v.link == "dur") then
					local dur,c = string.gsub(DURABILITY_TEMPLATE, " %%d / %%d", "")
					if (not dur or c ~= 1) then
						dur = "Durability"
					end
					nameFrame:SetText(dur)
					countFrame:SetText(XPerl_DurResults.count)
					div = XPerl_DurResults.count / onlineCount

				elseif (v.link == "reg") then
					local reg,c = string.gsub(SPELL_REAGENTS, ": ", "")
					if (not reg or c ~= 1) then
						reg = "Reagents"
					end
					nameFrame:SetText(reg)
					countFrame:SetText(XPerl_RegResults.count)
					div = XPerl_RegResults.count / reagentCount
				end
				nameFrame:SetTextColor(1, 1, 0.7)

				if (div > 0) then
					if (div > 1) then div = 1 end
					gaugeFrame:SetWidth((countFrame:GetLeft() - nameFrame:GetLeft()) * div)
					gaugeFrame:Show()
					SmoothGuageColor(gaugeFrame, div)
				else
					gaugeFrame:Hide()
				end
			else
				tickFrame:Show()
				tickFrame:SetChecked(v.ticked)

				nameFrame:SetText(v.link)

				local _,_, itemId = strfind(v.link, "item:(%d+):");
   				if (itemId) then
					local itemName, itemString, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemId)
					iconFrame:SetTexture(itemTexture)
					iconFrame:Show()
				else
					iconFrame:Hide()
				end

				local linkName = GetVLinkName(v)
				if (linkName) then
					local count = ""
					local result = XPerl_ItemResults[linkName]
					if (result) then
						count = getn(result)

						local div = count / onlineCount

						if (v.query and div > 0) then
							if (div > 1) then div = 1 end
							gaugeFrame:SetWidth((countFrame:GetLeft() - nameFrame:GetLeft()) * div)
							gaugeFrame:Show()
							SmoothGuageColor(gaugeFrame, div)
						else
							gaugeFrame:Hide()
						end
					else
						gaugeFrame:Hide()
					end
					countFrame:SetText(count)
				else
					gaugeFrame:Hide()
				end
			end

			index = index + 1
		end
		i = i + 1
	end

	for i = index,ITEMLISTSIZE do
			getglobal("XPerl_CheckListItems"..i):Hide()
	end

	if (FauxScrollFrame_Update(XPerl_CheckListItemsScrollBar, getn(XPerl_CheckItems), ITEMLISTSIZE, 1)) then
		XPerl_CheckListItemsScrollBar:Show()
	else
		XPerl_CheckListItemsScrollBar:Hide()
	end
end

-- SortPlayersByCount
local function SortPlayersByCount(p1, p2)
	local c1, c2
	if (p1.broken) then
		if (p1.connected and not p1.noCTRA) then	c1 = p1.broken + (1 - (p1.dur / 100))	else	c1 = -1	end
		if (p2.connected and not p2.noCTRA) then	c2 = p2.broken + (1 - (p2.dur / 100))	else	c2 = -1	end
	else
		if (p1.connected and not p1.noCTRA) then	c1 = p1.count	else	c1 = -1	end
		if (p2.connected and not p2.noCTRA) then	c2 = p2.count	else	c2 = -1	end
	end
	return c1 > c2
end

-- SortPlayersByName
local function SortPlayersByName(p1, p2)
	return p1.name < p2.name
end

-- SortPlayersByClass
local function SortPlayersByClass(p1, p2)
	return p1.class..p1.name < p2.class..p2.name
end

--local EquipedSortOrder = {untested = 0, notequipped = 1, equipped = 2, notinzone = 3, offline = 4}
local function ScanOrder(p)
	local s = XPerl_ActiveScan[p.name]
	if (s) then
		if (s.notequipped) then
			return 1
		elseif (s.equipped and s.changed) then
			return 2
		elseif (s.equipped) then
			return 3
		elseif (s.notinzone) then
			return 4
		elseif (s.offline) then
			return 5
		end
	end
	return 0
end

-- SortPlayersByDur
local function SortPlayersByDur(p1, p2)
	if (p1.dur) then
		local o1, o2 = 0,0
		if (not p1.connected or p1.noCTRA) then o1 = 1000 end
		if (not p2.connected or p2.noCTRA) then o2 = 1000 end
		return p1.dur + o1 < p2.dur + o2
	else
		if (XPerl_ActiveScan) then
			return ScanOrder(p1)..p1.class..p1.name < ScanOrder(p2)..p2.class..p2.name
		else
			return SortPlayersByCount(p1, p2)
		end
	end
end

-- SortPlayersByResist
local function SortPlayersByResist(p1, p2)
	local o1, o2 = 0,0
	if (not p1.connected or p1.noCTRA) then o1 = 1000 end
	if (not p2.connected or p2.noCTRA) then o2 = 1000 end
	return p1[XPerl_Admin.ResistSort] - o1 > p2[XPerl_Admin.ResistSort] - o2
end

-- XPerl_Check_MakePlayerList
function XPerl_Check_MakePlayerList()

	FauxScrollFrame_SetOffset(XPerl_CheckListPlayersScrollBar, 0)

	local function ShowResists(show)
		if (show) then
			XPerl_CheckListPlayersTitleFR:Show()
			XPerl_CheckListPlayersTitleFRR:Show()
			XPerl_CheckListPlayersTitleNR:Show()
			XPerl_CheckListPlayersTitleSR:Show()
			XPerl_CheckListPlayersTitleAR:Show()

			XPerl_CheckListPlayersTotalsFR:Show()
			XPerl_CheckListPlayersTotalsFRR:Show()
			XPerl_CheckListPlayersTotalsNR:Show()
			XPerl_CheckListPlayersTotalsSR:Show()
			XPerl_CheckListPlayersTotalsAR:Show()
		else
			XPerl_CheckListPlayersTitleFR:Hide()
			XPerl_CheckListPlayersTitleFRR:Hide()
			XPerl_CheckListPlayersTitleNR:Hide()
			XPerl_CheckListPlayersTitleSR:Hide()
			XPerl_CheckListPlayersTitleAR:Hide()

			XPerl_CheckListPlayersTotalsFR:Hide()
			XPerl_CheckListPlayersTotalsFRR:Hide()
			XPerl_CheckListPlayersTotalsNR:Hide()
			XPerl_CheckListPlayersTotalsSR:Hide()
			XPerl_CheckListPlayersTotalsAR:Hide()
		end
	end

	local function ShowCount(show)
		if (show) then
			XPerl_CheckListPlayersTitleCount:Show()
			XPerl_CheckListPlayersTotalsCount:Show()
		else
			XPerl_CheckListPlayersTitleCount:Hide()
			XPerl_CheckListPlayersTotalsCount:Hide()
		end
	end

	local function ShowDur(show)
		if (show) then
			XPerl_CheckListPlayersTitleDur:Show()
			XPerl_CheckListPlayersTotalsNR:Show()
		else
			XPerl_CheckListPlayersTitleDur:Hide()
			XPerl_CheckListPlayersTotalsNR:Hide()
		end
	end

	XPerl_PlayerList = {}

	local results, resType = GetSelectedItem()
	if (results and results.last) then
		XPerl_CheckListPlayersTitleClass:Show()
		XPerl_CheckListPlayersTitleName:Show()
		XPerl_CheckListPlayersTotalsName:Show()

		if (resType == "item" or resType == "reg") then
			XPerl_CheckListPlayersTotalsName:SetText(XPERL_CHECK_TOTALS)
			XPerl_CheckListPlayersTitleCount:SetText("#")

			ShowCount(true)
			ShowResists(false)
			ShowDur(XPerl_ActiveScan)

			if (XPerl_ActiveScan) then
				XPerl_CheckListPlayersTitleDur:SetText(XPERL_CHECK_EQUIPED)
			end

		elseif (resType == "dur") then
			XPerl_CheckListPlayersTotalsName:SetText(XPERL_CHECK_AVERAGE)

			ShowResists(false)
			ShowCount(true)
			ShowDur(true)

			XPerl_CheckListPlayersTitleCount:SetText(XPERL_CHECK_BROKEN)
			XPerl_CheckListPlayersTitleDur:SetText("%")

		elseif (resType == "res") then
			XPerl_CheckListPlayersTotalsName:SetText(XPERL_CHECK_AVERAGE)

			ShowCount(false)
			ShowDur(false)
			ShowResists(true)
		end

		for i = 1,GetNumRaidMembers() do
			local name = UnitName("raid"..i)
			local _, class = UnitClass("raid"..i)
			local count = 0
			local noCTRA

			if (XPerl_Roster) then
				local stats = XPerl_Roster[name]
				if (stats) then
					if (not stats.version) then
						noCTRA = true
					end
				end
			end

			if (resType == "item") then
				for k,v in ipairs(results) do
					if (v.name == name) then	-- type(v) == "table" and
						count = v.count
						if (count > 0) then
							noCTRA = nil
						end
						break
					end
				end

				tinsert(XPerl_PlayerList, {["name"] = name, unit = "raid"..i, ["count"] = count, ["class"] = class, connected = (UnitIsConnected("raid"..i) == 1), ["noCTRA"] = noCTRA})

			elseif (resType == "reg") then
				if (reagentClasses[class] or results[name]) then
					local p = results[name]
					local reg = 0
					if (p) then
						reg = p.count
						if (reg > 0) then
							noCTRA = nil
						end
					end

					tinsert(XPerl_PlayerList, {["name"] = name, unit = "raid"..i, ["count"] = reg, ["class"] = class, connected = (UnitIsConnected("raid"..i) == 1), ["noCTRA"] = noCTRA})
				end

			elseif (resType == "res") then
				local p = results[name]
				local fr, frr, nr, sr, ar = 0, 0, 0, 0, 0
				if (p) then
					fr, frr, nr, sr, ar = p.fr, p.frr, p.nr, p.sr, p.ar
					if (fr + frr + nr + sr + ar > 0) then
						noCTRA = nil
					end
				end

				tinsert(XPerl_PlayerList, {["name"] = name, unit = "raid"..i, ["fr"] = fr, ["frr"] = frr, ["nr"] = nr, ["sr"] = sr, ["ar"] = ar, ["class"] = class, connected = (UnitIsConnected("raid"..i) == 1), ["noCTRA"] = noCTRA})

			elseif (resType == "dur") then
				local p = results[name]
				local dur, broken = 0, 0
				if (p) then
					dur, broken = p.dur, p.broken
					if (dur + broken > 0) then
						noCTRA = nil
					end
				end

				tinsert(XPerl_PlayerList, {["name"] = name, unit = "raid"..i, ["dur"] = dur, ["broken"] = broken, ["class"] = class, connected = (UnitIsConnected("raid"..i) == 1), ["noCTRA"] = noCTRA})
			end
		end

		if (resType == "item" or resType == "reg") then
			sort(XPerl_PlayerList, SortPlayersByCount)
		elseif (resType == "dur") then
			sort(XPerl_PlayerList, SortPlayersByDur)
		elseif (resType == "res") then
			sort(XPerl_PlayerList, SortPlayersByResist)
		end
	else
		XPerl_CheckListPlayersTitleClass:Hide()
		XPerl_CheckListPlayersTitleName:Hide()
		XPerl_CheckListPlayersTotalsName:Hide()
		ShowCount(false)
		ShowDur(false)
		ShowResists(false)
	end

	XPerl_Check_UpdatePlayerList()
end

-- XPerl_Check_UpdatePlayerList
function XPerl_Check_UpdatePlayerList()

	local onlineCount, tFR, tFRR, tNR, tSR, tAR, tDur, tBroken, tCount = 0, 0, 0, 0, 0, 0, 0, 0, 0

	local results, resType = GetSelectedItem()
	local index = 1

	for i = 1,getn(XPerl_PlayerList) do
		--    + XPerl_CheckListPlayersScrollBar.offset, PLAYERLISTSIZE + XPerl_CheckListPlayersScrollBar.offset do
		local v = XPerl_PlayerList[i]
		if (not v) then
			break
		end

		if (v.fr) then
			tFR = tFR + v.fr
			tFRR = tFRR + v.frr
			tNR = tNR + v.nr
			tSR = tSR + v.sr
			tAR = tAR + v.ar
		elseif (v.dur) then
			tDur = tDur + v.dur
			tBroken = tBroken + v.broken
		else
			tCount = tCount + v.count
		end

		if (v.connected) then
			onlineCount = onlineCount + 1
		end

		if (i >= XPerl_CheckListPlayersScrollBar.offset + 1 and index <= PLAYERLISTSIZE) then
			local frame = getglobal("XPerl_CheckListPlayers"..index)
			local iconFrame = getglobal("XPerl_CheckListPlayers"..index.."Icon")
			local nameFrame = getglobal("XPerl_CheckListPlayers"..index.."Name")
			local countFrame = getglobal("XPerl_CheckListPlayers"..index.."Count")
			local resFrameFR = getglobal("XPerl_CheckListPlayers"..index.."FR")
			local resFrameFRR = getglobal("XPerl_CheckListPlayers"..index.."FRR")
			local resFrameNR = getglobal("XPerl_CheckListPlayers"..index.."NR")
			local resFrameSR = getglobal("XPerl_CheckListPlayers"..index.."SR")
			local resFrameAR = getglobal("XPerl_CheckListPlayers"..index.."AR")
			local resFrameEquiped = getglobal("XPerl_CheckListPlayers"..index.."Equiped")

			if (v.name == SelectedPlayer) then
				frame:LockHighlight()
			else
				frame:UnlockHighlight()
			end

			nameFrame:SetText(v.name)
			local color = XPerl_GetClassColour(v.class)
			nameFrame:SetTextColor(color.r, color.g, color.b)

			if (v.class) then
				local r, l, t, b = XPerl_ClassPos(v.class)
				iconFrame:SetTexCoord(r, l, t, b)
				iconFrame:Show()
			else
				iconFrame:Hide()
			end

			getglobal("XPerl_CheckListPlayers"..index):Show()

			local function ShowScanIcon()
				if (XPerl_ActiveScan) then
					local z = XPerl_ActiveScan[v.name]
					if (z) then
						resFrameEquiped:Show()
						if (z.equipped) then
							if (z.changed) then
								resFrameEquiped:SetTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
							else
								resFrameEquiped:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
							end
							resFrameEquiped:SetTexCoord(0, 1, 0, 1)
						elseif (z.offline) then
							resFrameEquiped:SetTexture("Interface\\CharacterFrame\\Disconnect-Icon")
							resFrameEquiped:SetTexCoord(0.2, 0.8, 0.2, 0.8)
						elseif (z.notequipped) then
							resFrameEquiped:SetTexture("Interface\\Addons\\XPerl_RaidAdmin\\Images\\XPerl_Check")
							if (z.changed) then
								resFrameEquiped:SetTexCoord(0.75, 0.875, 0.25, 0.5)
							else
								resFrameEquiped:SetTexCoord(0.625, 0.75, 0.25, 0.5)
							end
						elseif (z.notinzone) then
							resFrameEquiped:SetTexture("Interface\\GossipFrame\\TaxiGossipIcon")
							--resFrameEquiped:SetTexture("Interface\\WorldMap\\WorldMap-Icon")
							resFrameEquiped:SetTexCoord(0, 1, 0, 1)
						else
							resFrameEquiped:Hide()
						end
					else
						resFrameEquiped:Hide()
					end
				else
					resFrameEquiped:Hide()
				end
			end

			if (not v.connected or v.noCTRA) then
				if (not v.connected) then
					countFrame:SetText(XPERL_LOC_OFFLINE)
				else
					countFrame:SetText(XPERL_RAID_TOOLTIP_NOCTRA)
				end
				countFrame:SetTextColor(0.5, 0.5, 0.5)
				countFrame:Show()

				ShowScanIcon()

				resFrameFR:Hide()
				resFrameFRR:Hide()
				resFrameNR:Hide()
				resFrameSR:Hide()
				resFrameAR:Hide()
			else
				if (v.fr) then
					resFrameFR:SetText(v.fr)
					resFrameFRR:SetText(v.frr)
					resFrameNR:SetText(v.nr)
					resFrameNR:SetTextColor(0, 1, 0)
					resFrameSR:SetText(v.sr)
					resFrameAR:SetText(v.ar)

					resFrameFR:Show()
					resFrameFRR:Show()
					resFrameNR:Show()
					resFrameSR:Show()
					resFrameAR:Show()
					countFrame:Hide()
					resFrameEquiped:Hide()

				elseif (v.dur) then
					resFrameNR:SetText(v.dur)
					countFrame:SetText(v.broken)

					local r, g, b = SmoothColour(v.dur)
					resFrameNR:SetTextColor(r, g, b)

					countFrame:Show()
					resFrameNR:Show()

					if (v.broken > 0) then
						countFrame:SetTextColor(1, 0, 0)
					else
						countFrame:SetTextColor(0, 1, 0)
					end

					resFrameFR:Hide()
					resFrameFRR:Hide()
					resFrameSR:Hide()
					resFrameAR:Hide()
					resFrameEquiped:Hide()
				else
					countFrame:SetText(v.count)
					countFrame:Show()

					if (v.count == 0) then
						countFrame:SetTextColor(1, 0, 0)
					else
						countFrame:SetTextColor(0, 1, 0)
					end

					ShowScanIcon()

					resFrameFR:Hide()
					resFrameFRR:Hide()
					resFrameNR:Hide()
					resFrameSR:Hide()
					resFrameAR:Hide()
				end
			end

			index = index + 1
		end
	end

	for i = index,PLAYERLISTSIZE do
		getglobal("XPerl_CheckListPlayers"..i):Hide()
	end

	if (resType == "dur") then
		XPerl_CheckListPlayersTotalsNR:SetText(floor(tDur / onlineCount))
		XPerl_CheckListPlayersTotalsNR:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		XPerl_CheckListPlayersTotalsCount:SetText(tBroken)

		local r, g, b = SmoothColour((tDur / onlineCount) / 100)
		XPerl_CheckListPlayersTotalsNR:SetTextColor(r, g, b)

		if (tBroken > 0) then
			XPerl_CheckListPlayersTotalsCount:SetTextColor(1, 0, 0)
		else
			XPerl_CheckListPlayersTotalsCount:SetTextColor(0, 1, 0)
		end

	elseif (resType == "res") then
		XPerl_CheckListPlayersTotalsFR:SetText(floor(tFR / onlineCount))
		XPerl_CheckListPlayersTotalsNR:SetText(floor(tNR / onlineCount))
		XPerl_CheckListPlayersTotalsNR:SetTextColor(0, 1, 0)
		XPerl_CheckListPlayersTotalsFRR:SetText(floor(tFRR / onlineCount))
		XPerl_CheckListPlayersTotalsSR:SetText(floor(tSR / onlineCount))
		XPerl_CheckListPlayersTotalsAR:SetText(floor(tAR / onlineCount))
	else
		XPerl_CheckListPlayersTotalsCount:SetText(tCount)

		if (tCount == 0) then
			XPerl_CheckListPlayersTotalsNR:SetTextColor(1, 0, 0)
		else
			XPerl_CheckListPlayersTotalsNR:SetTextColor(0, 1, 0)
		end
	end

	if (FauxScrollFrame_Update(XPerl_CheckListPlayersScrollBar, getn(XPerl_PlayerList), PLAYERLISTSIZE, 1)) then
		XPerl_CheckListPlayersScrollBar:Show()
	else
		XPerl_CheckListPlayersScrollBar:Hide()
	end
end

-- XPerl_Check_ShowInfo
function XPerl_Check_ShowInfo()

	if (ActiveScanTotals) then
		if (ActiveScanTotals.missing > 0) then
			XPerl_CheckButtonInfo:SetText(string.format(XPERL_CHECK_SCAN_MISSING, ActiveScanTotals.missing))
		else
			XPerl_CheckButtonInfo:SetText("")
		end
	else
		local results = GetSelectedItem()

		local t
		if (results and results.last and results.last > 0) then
			t = SecondsToTime(GetTime() - results.last)
		else
			t = ""
		end
		if (t ~= "") then
			XPerl_CheckButtonInfo:SetText(string.format(XPERL_CHECK_LASTINFO, t))
		else
			XPerl_CheckButtonInfo:SetText("")
		end
	end
end

-- XPerl_Check_OnEnter
function XPerl_Check_OnEnter()

	local f, anc
	if (this:GetFrameType() == "CheckButton") then
		f = getglobal(this:GetParent():GetName().."Name")
		anc = this:GetParent()
	else
		f = getglobal(this:GetName().."Name")
		anc = this
	end
	if (f) then
		local link = f:GetText()
		if (link and strsub(link, 1, 1) == "|") then
			-- Have to strip excess information for the SetHyperlink call
			local _,_, itemId = strfind(link, "item:(%d+):");
   			if (itemId) then
				local newLink = string.format("item:%d:0:0:0", itemId)

				GameTooltip:SetOwner(anc, "ANCHOR_LEFT")
				GameTooltip:SetHyperlink(newLink)
				return
			end
		end
	end

	GameTooltip:SetOwner(XPerl_CheckListItems1, "ANCHOR_LEFT")
	GameTooltip:SetText(XPERL_CHECK_DROPITEMTIP1, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	GameTooltip:AddLine(XPERL_CHECK_DROPITEMTIP2, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
	GameTooltip:Show()
end

-- XPerl_CheckMouseWheel
function XPerl_CheckMouseWheel(name, dir)
	local frame = getglobal("XPerl_CheckList"..name.."ScrollBarScrollBar")
	if (dir > 0) then
	        frame:SetValue(frame:GetValue() - 5)
	else
	        frame:SetValue(frame:GetValue() + 5)
	end
end

-- XPerl_Check_OnClickStart
function XPerl_Check_OnClickTick()
	local id = this:GetParent():GetID() + XPerl_CheckListItemsScrollBar.offset
	if (XPerl_CheckItems[id]) then
		XPerl_CheckItems[id].ticked = this:GetChecked()
	end
	XPerl_Check_ValidateButtons()
end

-- XPerl_Check_DeleteSelectedItems
function XPerl_Check_DeleteSelectedItems()

	local newList = {}

	for k,v in ipairs(XPerl_CheckItems) do
		if (v.fixed or not v.ticked) then
			tinsert(newList, v)
		else
			local linkName = GetVLinkName(v)
			if (linkName) then
				XPerl_ItemResults[linkName] = nil
			end
		end
	end

	XPerl_CheckItems = newList

	XPerl_Check_ItemsChanged()
end

-- XPerl_Check_Query
function XPerl_Check_Query()

	local oldResults = XPerl_ItemResults
	XPerl_ItemResults = {["type"] = "item"}

	XPerl_CheckListItemsScrollBarScrollBar:SetValue(0)

	tinsert(XPerl_MsgQueue, "DURC")
	tinsert(XPerl_MsgQueue, "RSTC")
	tinsert(XPerl_MsgQueue, "REAC")
	XPerl_ResistResults.count = 0
	XPerl_DurResults.count = 0
	XPerl_RegResults.count = 0

	local msg
	for k,v in ipairs(XPerl_CheckItems) do
		if (v.ticked) then
			v.query = true
			v.ticked = nil

			if (not v.fixed) then
				local linkName = GetVLinkName(v)

				if (linkName) then
					XPerl_ItemResults[linkName] = {last = 0}
					oldResults[linkName] = nil
					tinsert(XPerl_MsgQueue, "ITMC "..linkName)
				end
			end
		else
			v.query = nil
		end
	end

	for k,v in pairs(oldResults) do
		if (type(v) == "table") then
			if (not v.fixed) then
				XPerl_ItemResults[k] = v
			end
		end
	end

	XPerl_Check.queryStart = GetTime()
	XPerl_Check.lastMsgsent = nil
	XPerl_Check:SetScript("OnUpdate", XPerl_CheckOnUpdate)

	XPerl_Check_ItemsChanged()		-- Re-sort and re-show list with ticked items at top
	XPerl_Check_ValidateButtons()
end

-- GetActiveScanItem
local function GetActiveScanItem()

	local item = GetSelectedItemLink()
	local itemId
	if (item and strsub(item, 1, 1) == "|") then
		local _
		_,_, itemId = strfind(item, "item:(%d+):")
		if (not itemId) then
			return
		end
	else
		return
	end

	local itemName, itemString, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemId)

	if (not itemEquipLoc or not itemType) then
		return
	end

	if (not (itemType == "Armor" or itemType == "Weapon")) then
		return
	end

	local slots = {	INVTYPE_HEAD = 1,
			INVTYPE_NECK = 2,
			INVTYPE_SHOULDER = 3,
			INVTYPE_BODY = 4,
			INVTYPE_CHEST = 5,
			INVTYPE_ROBE = 5,
			INVTYPE_WAIST = 6,
			INVTYPE_LEGS = 7,
			INVTYPE_FEET = 8,
			INVTYPE_WRIST = 9,
			INVTYPE_HAND = 10,
			INVTYPE_FINGER = {11, 12},
			INVTYPE_TRINKET = {13, 14},
			INVTYPE_CLOAK = 15,
			INVTYPE_2HWEAPON = 16,
			INVTYPE_WEAPONMAINHAND = 16,
			INVTYPE_WEAPON = {16, 17},
			INVTYPE_WEAPONOFFHAND = 17,
			INVTYPE_HOLDABLE = 17,
			INVTYPE_SHIELD = 17,
			INVTYPE_RANGED = 18,
			INVTYPE_RELIC = 18,
			INVTYPE_TABARD = 19}

	local slot = slots[itemEquipLoc]
	if (slot) then
		return tonumber(itemId), slot
	end
end

-- GetSelectedPlayer
local function GetSelectedPlayer()
	if (SelectedPlayer) then
		for k,v in pairs(XPerl_PlayerList) do
			if (v.name == SelectedPlayer) then
				return v
			end
		end
	end
end

-- XPerl_Check_ValidateButtons
function XPerl_Check_ValidateButtons()

	local fixedSelected, regSelected
	local anyTicked
	for k,v in ipairs(XPerl_CheckItems) do
		if (v.selected) then
			if (v.fixed) then
				fixedSelected = true
			end
			if (v.link == "reg") then
				regSelected = true
			end
		end
		if (not v.fixed and v.ticked) then
			anyTicked = true
		end
	end

	local results, resType = GetSelectedItem()

	if (anyTicked and not XPerl_Check.queryStart) then
		XPerl_CheckButtonDelete:Enable()
	else
		XPerl_CheckButtonDelete:Disable()
	end

	if (not XPerl_Check.queryStart and IsRaidOfficer()) then
		XPerl_CheckButtonQuery:Enable()
	else
		XPerl_CheckButtonQuery:Disable()
	end

	if (((results and results.last) or XPerl_ActiveScan) and UnitInRaid("player")) then
		XPerl_CheckButtonReport:Enable()
	else
		XPerl_CheckButtonReport:Disable()
	end

	if (results and results.last and not (fixedSelected and not regSelected) and UnitInRaid("player")) then
		XPerl_CheckButtonReportWith:Enable()
		XPerl_CheckButtonReportWithout:Enable()
	else
		XPerl_CheckButtonReportWith:Disable()
		XPerl_CheckButtonReportWithout:Disable()
	end

	if (ActiveScanItem) then
		local tex = XPerl_CheckButtonEquiped:GetNormalTexture()
		tex:SetTexCoord(0.75, 0.875, 0.5, 0.75)
		tex = XPerl_CheckButtonEquiped:GetPushedTexture()
		tex:SetTexCoord(0.875, 1, 0.5, 0.75)

                XPerl_CheckButtonEquiped.tooltipText = "XPERL_CHECK_SCANSTOP_DESC"
	else
		local tex = XPerl_CheckButtonEquiped:GetNormalTexture()
		tex:SetTexCoord(0.375, 0.5, 0.5, 0.75)
		tex = XPerl_CheckButtonEquiped:GetPushedTexture()
		tex:SetTexCoord(0.5, 0.625, 0.5, 0.75)

                XPerl_CheckButtonEquiped.tooltipText = "XPERL_CHECK_SCAN_DESC"
	end

	local myPlayer = GetSelectedPlayer()
	if (((results and results.last) or (XPerl_ActiveScan and XPerl_ActiveScan[SelectedPlayer])) and myPlayer and myPlayer.connected) then
		XPerl_CheckButtonPlayer:Enable()
	else
		XPerl_CheckButtonPlayer:Disable()
	end

	XPerl_CheckButtonEquiped:Hide()
	XPerl_CheckButtonEquiped:Show()

	if (results and not fixedSelected and GetActiveScanItem()) then
		XPerl_CheckButtonEquiped:Enable()
	else
		XPerl_CheckButtonEquiped:Disable()
	end
end

-- XPerl_Check_Players_Sort
function XPerl_Check_Players_Sort(sortType)
	if (sortType == "class") then
		sort(XPerl_PlayerList, SortPlayersByClass)
	elseif (sortType == "name") then
		sort(XPerl_PlayerList, SortPlayersByName)
	elseif (sortType == "count") then
		sort(XPerl_PlayerList, SortPlayersByCount)
	elseif (sortType == "dur") then
		sort(XPerl_PlayerList, SortPlayersByDur)
	elseif (strfind("frrsrnrar", sortType)) then
		XPerl_Admin.ResistSort = sortType
		sort(XPerl_PlayerList, SortPlayersByResist)
	end

	XPerl_Check_UpdatePlayerList()
end

-- XPerl_Check_Report
function XPerl_Check_Report(showNames)

	local function ReportOutput(msg)
		if (msg) then
			if (XPerlTest) then
				SendChatMessage("<X-Perl> "..msg, "WHISPER", nil, "Zek")
			else
				SendChatMessage("<X-Perl> "..msg, "RAID")
			end
		end
	end

	local link = GetSelectedItemLink()
	local msg
	if (link) then
		local myPlayer = GetSelectedPlayer()

		if (link == "res") then
			if (XPerl_ResistResults.last) then
				if (showNames == "player") then
					if (SelectedPlayer) then
						if (myPlayer.connected) then
							msg = string.format(XPERL_CHECK_REPORT_PRESISTS, SelectedPlayer, myPlayer.fr, myPlayer.nr, myPlayer.frr, myPlayer.sr, myPlayer.ar)
						end
					end
				else
					local fr, frr, nr, sr, ar, count = 0, 0, 0, 0, 0, 0

					for k,v in ipairs(XPerl_PlayerList) do
						if (v.connected) then
							count = count + 1

							fr = fr + v.fr
							frr = frr + v.frr
							nr = nr + v.nr
							sr = sr + v.sr
							ar = ar + v.ar
						end
					end

					fr = fr / count
					frr = frr / count
					nr = nr / count
					sr = sr / count
					ar = ar / count

					msg = string.format(XPERL_CHECK_REPORT_RESISTS, fr, nr, frr, sr, ar)
				end
				ReportOutput(msg)
			end

		elseif (link == "dur") then
			if (XPerl_DurResults.last) then
				if (showNames == "player") then
					if (SelectedPlayer) then
						if (myPlayer.connected) then
							msg = string.format(XPERL_CHECK_REPORT_PDURABILITY, SelectedPlayer, myPlayer.dur, myPlayer.broken)
						end
					end
				else
					local dur, broken, brokenPeople, count = 0, 0, 0, 0

					for k,v in ipairs(XPerl_PlayerList) do
						if (v.connected) then
							count = count + 1
							dur = dur + v.dur

							if (v.broken > 0) then
								brokenPeople = brokenPeople + 1
								broken = broken + v.broken
							end
						end
					end

					dur = dur / count

					msg = string.format(XPERL_CHECK_REPORT_DURABILITY, dur, brokenPeople, broken)
				end
				ReportOutput(msg)
			end
		else
			if (showNames == "player") then
				if (SelectedPlayer) then
					if (myPlayer.connected) then
						if (link == "reg") then
							if (XPerl_RegResults.last) then
								msg = string.format(XPERL_CHECK_REPORT_PITEM, SelectedPlayer, myPlayer.count, XPERL_REAGENTS[myPlayer.class])
							end
						else
							if (XPerl_ActiveScan and XPerl_ActiveScan[SelectedPlayer]) then
								if (XPerl_ActiveScan[SelectedPlayer].equipped) then
									msg = string.format(XPERL_CHECK_REPORT_PEQUIPED, SelectedPlayer, link)
								elseif (XPerl_ActiveScan[SelectedPlayer].notequipped) then
									msg = string.format(XPERL_CHECK_REPORT_PNOTEQUIPED, SelectedPlayer, link)
								end
							else
								msg = string.format(XPERL_CHECK_REPORT_PITEM, SelectedPlayer, myPlayer.count, link)
							end
						end
						ReportOutput(msg)
					end
				end
			else
				local equipable = ""
				if (strsub(link, 1, 1) == "|") then
					local _,_, itemId = strfind(link, "item:(%d+):")
					local itemName, itemString, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemId)
					if (itemEquipLoc and itemType) then
						if (itemType == "Armor" or itemType == "Weapon") then
							equipable = "_EQ"
						end
					end
				end

				local with = {}
				local without = {}
				local offline = {}
				local totalItems = 0

				for k,v in ipairs(XPerl_PlayerList) do
					if (ActiveScanTotals and ActiveScanTotals.missing == 0) then
						local scan = XPerl_ActiveScan[v.name]
						if (scan.equipped) then
							tinsert(with, v)
						elseif (scan.notequipped) then
							tinsert(without, v)
						elseif (scan.offline) then
							tinsert(offline, v)
						end
					else
						if (v.connected) then
							if (v.count > 0) then
								tinsert(with, v)
								totalItems = totalItems + v.count
							elseif (not v.noCTRA) then
								tinsert(without, v)
							end
						else
							tinsert(offline, v)
						end
					end
				end

				if (ActiveScanTotals and ActiveScanTotals.missing == 0 and ActiveScanTotals.wrongZone == 0 and ActiveScanTotals.notequipped == 0) then
					if (ActiveScanTotals.offline == 0) then
						ReportOutput(string.format(XPERL_CHECK_REPORT_ALLEQUIPED, link))
					else
						ReportOutput(string.format(XPERL_CHECK_REPORT_ALLEQUIPEDOFF, link, ActiveScanTotals.offline))
					end
				else
					if (showNames) then
						if (link == "reg") then
							link,c = string.gsub(SPELL_REAGENTS, ": ", "")
							if (not link or c ~= 1) then
								link = "Reagents"
							end
						end

						local showList
						local showTitle
						if (showNames == "with") then
							if (ActiveScanTotals and ActiveScanTotals.missing == 0) then
								showTitle = link..XPERL_CHECK_REPORT_EQUIPED
							else
								showTitle = link..getglobal("XPERL_CHECK_REPORT_WITH"..equipable)
							end
							if (getn(with) > 0) then
								showList = with
							end
						elseif (showNames == "without") then
							if (ActiveScanTotals and ActiveScanTotals.missing == 0) then
								showTitle = link..XPERL_CHECK_REPORT_NOTEQUIPED
							else
								showTitle = link..getglobal("XPERL_CHECK_REPORT_WITHOUT"..equipable)
							end
							if (getn(without) > 0) then
								showList = without
							end
						end

						if (showList) then
							msg = showTitle
							local msgLocal = showTitle
							local first = true

							for k,v in ipairs(showList) do
								local name = XPerlColourTable[v.class]..v.name.."|r"

								if (strlen(msg) + strlen(name) > 240) then
									ReportOutput(msg.."...")
									DEFAULT_CHAT_FRAME:AddMessage("<X-Perl> "..msgLocal)
									msg = "  ... "..v.name
									msgLocal = "  ... "..name
								else
									if (first) then
										msg = msg..v.name
										msgLocal = msgLocal..name
										first = nil
									else
										msg = msg..", "..v.name
										msgLocal = msgLocal..", "..name
									end
								end
							end

							if (msg) then
								ReportOutput(msg)
							end
							if (msgLocal) then
								DEFAULT_CHAT_FRAME:AddMessage("<X-Perl> "..msgLocal)
							end
						elseif (showTitle) then
							DEFAULT_CHAT_FRAME:AddMessage("<X-Perl> "..showTitle..NONE)
						end
					else
						msg = link.." "

						local function Out(txt, num)
							if (num > 0) then
								msg = msg..string.format(txt, num)
							end
						end

						if (ActiveScanTotals) then	-- and ActiveScanTotals.missing == 0) then
							Out(XPERL_CHECK_REPORT_EQUIPEDSHORT, ActiveScanTotals.equipped)
							Out(XPERL_CHECK_REPORT_NOTEQUIPEDSHORT, ActiveScanTotals.notequipped)
							Out(XPERL_CHECK_REPORT_OFFLINE, ActiveScanTotals.offline)
							Out(XPERL_CHECK_REPORT_NOTSCANNED, ActiveScanTotals.missing + ActiveScanTotals.wrongZone)
						else
							Out(XPERL_CHECK_REPORT_WITHSHORT, getn(with))
							Out(XPERL_CHECK_REPORT_WITHOUTSHORT, getn(without))
							Out(" : %d "..XPERL_LOC_OFFLINE, getn(offline))
						end

						if (link ~= "reg") then
							Out(XPERL_CHECK_REPORT_TOTAL, totalItems)
						end

						ReportOutput(msg)
					end
				end
			end
		end
	end
end

-- XPerl_Check_PlayerOnClick
function XPerl_Check_PlayerOnClick(button)

	local index = this:GetID() + XPerl_CheckListPlayersScrollBar.offset

	if (index < 1 or index > getn(XPerl_PlayerList)) then
		return
	end

	if (SelectedPlayer == XPerl_PlayerList[index].name) then
		SelectedPlayer = nil
	else
		SelectedPlayer = XPerl_PlayerList[index].name
	end

	XPerl_Check_UpdatePlayerList()

	if (button == "LeftButton") then
		TargetUnit(XPerl_PlayerList[index].unit)
	end

	SetPortraitTexture(XPerl_CheckButtonPlayerPortrait, XPerl_PlayerList[index].unit)

	XPerl_Check_ValidateButtons()

	--if (button == "RightButton") then
	--	ToggleDropDownMenu(1, nil, XPerl_CheckDropDown)
	--end
end

-- XPerl_Check_StopActiveScan
function XPerl_Check_StopActiveScan()
	XPerl_Check:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	XPerl_Check:UnregisterEvent("UNIT_MODEL_CHANGED")
	ActiveScanItem = nil
end

-- XPerl_Check_StartActiveScan
function XPerl_Check_StartActiveScan()

	if (ActiveScanItem) then
		XPerl_Check_StopActiveScan()
	else
		local itemId, itemSlot = GetActiveScanItem()
		if (itemId) then
			XPerl_ActiveScan = {}

			ActiveScanItem = {id = itemId, slot = itemSlot, missing = GetNumRaidMembers()}
			ActiveScanTotals = {missing = 0, equipped = 0, notequipped = 0, offline = 0, wrongZone = 0}

			XPerl_Check:SetScript("OnUpdate", XPerl_CheckOnUpdate)
			XPerl_Check:RegisterEvent("UNIT_INVENTORY_CHANGED")
			XPerl_Check:RegisterEvent("UNIT_MODEL_CHANGED")

			XPerl_CheckListPlayersTitleDur:SetText(XPERL_CHECK_EQUIPED)
			XPerl_CheckListPlayersTitleDur:Show()
		end
	end

	XPerl_Check_ValidateButtons()
end

-- XPerl_Check_ActiveScan
function XPerl_Check_ActiveScan()

	local function CheckSlot(unit, slot)
		local link = GetInventoryItemLink(unit, slot)
		local eq
		local name = UnitName(unit)

		if (link) then
			local _,_, itemId = strfind(link, "item:(%d+):")
			if (itemId) then
				itemId = tonumber(itemId)

				if (itemId == ActiveScanItem.id) then
					if (not XPerl_ActiveScan[name]) then
						XPerl_ActiveScan[name] = {}
					end

					XPerl_ActiveScan[name].notequipped = nil
					XPerl_ActiveScan[name].equipped = 1
					return true
				end
			end
		end

		if (not XPerl_ActiveScan[name]) then
			XPerl_ActiveScan[name] = {}
		end
		XPerl_ActiveScan[name].equipped = nil
		XPerl_ActiveScan[name].notequipped = 1
	end

	local myZone = GetRealZoneText()

	local any
	local update
	ActiveScanTotals = {missing = 0, equipped = 0, notequipped = 0, offline = 0, wrongZone = 0}
	for i = 1,GetNumRaidMembers() do
		local name, rank, subgroup, level, _, class, zone, online, isDead = GetRaidRosterInfo(i)
		local unit = "raid"..i
		local new
		local myScan = XPerl_ActiveScan[name]

		if (not myScan or myScan.changed) then
			if (myScan) then
				myScan.changed = nil
			end
			any = true
			if (CheckInteractDistance(unit, 1)) then		-- Checks to see if in inspect range
				local eq
				if (type(ActiveScanItem.slot) == "table") then
					for k,v in ActiveScanItem.slot do
						if (CheckSlot(unit, v)) then
							eq = true
							break
						end
					end
				else
					eq = CheckSlot(unit, ActiveScanItem.slot)
				end

				if (eq) then
					ActiveScanTotals.equipped = ActiveScanTotals.equipped + 1
				else
					ActiveScanTotals.notequipped = ActiveScanTotals.notequipped + 1
				end
				update = true

			elseif (not UnitIsConnected(unit)) then
				if (not XPerl_ActiveScan[name]) then
					XPerl_ActiveScan[name] = {}
				end

				XPerl_ActiveScan[name].offline = 1
				ActiveScanTotals.offline = ActiveScanTotals.offline + 1
				update = true

			elseif (zone ~= myZone) then
				if (not XPerl_ActiveScan[name]) then
					XPerl_ActiveScan[name] = {}
				end

				XPerl_ActiveScan[name].notinzone = 1
				ActiveScanTotals.wrongZone = ActiveScanTotals.wrongZone + 1
				update = true

			else
				ActiveScanTotals.missing = ActiveScanTotals.missing + 1
			end
		else
			ActiveScanTotals.missing	= ActiveScanTotals.missing	+ (myScan.missing	or 0)
			ActiveScanTotals.equipped	= ActiveScanTotals.equipped	+ (myScan.equipped	or 0)
			ActiveScanTotals.notequipped	= ActiveScanTotals.notequipped	+ (myScan.notequipped	or 0)
			ActiveScanTotals.offline	= ActiveScanTotals.offline	+ (myScan.offline	or 0)
			ActiveScanTotals.wrongZone	= ActiveScanTotals.wrongZone	+ (myScan.notinzone	or 0)
		end
	end

	XPerl_Check_ShowInfo()

	if (update) then
		sort(XPerl_PlayerList, SortPlayersByDur)		-- It's actually by equipped, that's sorted out in sort func
		XPerl_Check_UpdatePlayerList()
		XPerl_Check_ValidateButtons()
	end

	--if (not any) then
	--	ActiveScanItem = nil
	--	XPerl_Check_ValidateButtons()
	--end
end

--[[

-- XPerl_Check_PlayerDropDown_OnLoad
function XPerl_Check_PlayerDropDown_OnLoad()
	this.playerCheckDropDown = true;
	UIDropDownMenu_Initialize(this, XPerl_Check_PlayerDropDown_Initialize, "MENU");
	UIDropDownMenu_SetAnchor(0, 0, this, "TOPLEFT", this:GetName(), "CENTER")
end

-- XPerl_Check_PlayerDropDown_Initialize
function XPerl_Check_PlayerDropDown_Initialize()
	if ( not UIDROPDOWNMENU_OPEN_MENU or not getglobal(UIDROPDOWNMENU_OPEN_MENU).playerCheckDropDown ) then
		return;
	end

	--local selectedUnit = XPerl_PlayerList[SelectedPlayer]
	local info

	-- Show buffs or debuffs they are exclusive for now
	info = {}
	info.text = "Target"
	info.func = function()
		TargetUnit(selectedUnit)
	end
	UIDropDownMenu_AddButton(info)

	info = {}
	info.text = "Has Equiped Item"
	info.func = function()
		XPerl_CheckPlayerEquiped(selectedUnit)
	end;
	UIDropDownMenu_AddButton(info)
end

]]

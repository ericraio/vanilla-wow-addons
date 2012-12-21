XPerl_MainTanks = {}
MainTankCount = 0
local MainTanks = {}
local Events = {}
local XUnits = {}
local XOtherUnits = {}
local XFreeUnits = {}
local OtherTargetOwners = {}
local UpdateTime = 0
local FrameExpanded = false
local XOtherRows = 0
local XGaps = 0
local XTitle
local MainAssist = nil
local XFind = nil
local bigwigsSlowDown = 0

-- Dup colours used to show which tanks have the same target
local MTdupColours = {	{r = "0.8", g = "0.2", b = "0.2"},
			{r = "0.2", g = "0.2", b = "0.8"},
			{r = "0.8", g = "0.2", b = "0.8"},
			{r = "0.2", g = "0.8", b = "0.2"},
			{r = "0.2", g = "0.8", b = "0.8"}}

local MAX_UNITS = 50
local MAX_OTHER_ROWS = 10
local GAP_SPACING = 10
XPERL_UNIT_HEIGHT_MIN = 17
XPERL_UNIT_HEIGHT_MAX = 30
XPERL_UNIT_WIDTH_MIN = 50
XPERL_UNIT_WIDTH_MAX = 125

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

-- Although your own "target" is updated immediately, any reference to ourself via our raid id is updated via the server
-- So, to cure the slow response times, we check if anything is 'me'. Only direct targets are updated immedately,
-- so we don't bother with target's target onwards.
local function SpecialCaseUnit(unit)
	if (unit.unit and (unit.type == "MTT" or unit.type == "OT") and UnitIsUnit("player", unit.unit)) then
		return "target"
	else
		return unit.partyid
	end
end

----------------------------
------- DISPLAY ------------
----------------------------
local function UpdateUnit(unit,forcedUpdate)

	if (forcedUpdate) then
		local time = GetTime()
		if (unit.update and time < unit.update + 0.2) then
			-- Since we catch UNIT_HEALTH changes, we don't need to update always
			return
		end
	end

	unit.update = GetTime()

	local xunit = SpecialCaseUnit(unit)

	local name = UnitName(xunit)
	local text = getglobal(unit:GetName().."_Name")
	local bar = getglobal(unit:GetName().."_HealthBar")
	local percent = getglobal(unit:GetName().."_HealthBarText")
	local barBG = getglobal(unit:GetName().."_HealthBarBG")
	local combat = getglobal(unit:GetName().."_Combat")
	local warning = getglobal(unit:GetName().."_Warning")
	local raidIcon = getglobal(unit:GetName().."_RaidIcon")
	local percBar

	barBG:Show()

	if (name and name ~= UNKNOWNOBJECT) then
		-- Name
		text:SetText(name)
		text:SetPoint("BOTTOMRIGHT", unit, "TOPRIGHT", 0, -12)

		local remCount = 1
		while ((text:GetStringWidth() >= (unit:GetWidth() - 2)) and (string.len(name) > remCount)) do
			name = string.sub(name, 1, string.len(name) - remCount)..".."
			remCount = 3
			text:SetText(name)
		end

		if (UnitPlayerControlled(xunit)) then
			XPerl_ColourFriendlyUnit(text, xunit)
		else
			XPerl_SetUnitNameColor(xunit, text)
		end

		-- Health
		local healthMax = UnitHealthMax(xunit)
		local health = UnitHealth(xunit)
		percBar = health / healthMax
		local perc = percBar * 100

		bar:SetMinMaxValues(0, healthMax)
		bar:SetValue(health)

		if (UnitIsDead(xunit)) then
			percent:SetText(XPERL_LOC_DEAD)
		else
			percent:SetText(math.floor(perc + 0.5).."%")
		end
		if (XPerlConfigHelper.UnitHeight < 23) then
			percent:Hide()
		else
			percent:Show()
		end

		if (unit.type == "MTT" or unit.type == "OT") then
			if (BigWigsTargetMonitor) then
				if (bigwigsSlowDown == 0) then
					BigWigsTargetMonitor:TargetCheck(xunit)
				end
			end

			local index = GetRaidTargetIndex(xunit)
			if (index) then
				SetRaidTargetIconTexture(raidIcon, index)
				raidIcon:Show()
			else
				raidIcon:Hide()
			end
		else
			raidIcon:Hide()
		end
	else
		text:SetPoint("BOTTOMRIGHT", -2, 1)

		if (unit.type == "MTT") then
			name = UnitName(unit.unit)

			if (name) then
				XPerl_ColourFriendlyUnit(text, unit.unit)
				text:SetText(string.format(XPERL_XS_TARGET, name))
				barBG:Hide()
			end
		else
			text:SetText(XPERL_NO_TARGET)
			text:SetTextColor(0.5, 0.5, 0.5, 1)
		end
		bar:SetMinMaxValues(0, 1)
		bar:SetValue(0)
		percBar = 0
		percent:Hide()
		raidIcon:Hide()
	end

	if (UnitAffectingCombat(xunit)) then
		combat:Show()
	else
		combat:Hide()
	end

	if (UnitIsCharmed(xunit)) then
		warning:Show()
	else
		warning:Hide()
	end

	XPerl_SetSmoothBarColor (bar, percBar)
end

-- XPerl_RaidHelp_Show
function XPerl_RaidHelp_Show()
	XPerlConfigHelper.RaidHelper = 1
	XPerl_EnableDisable()
	return true
end

-- XPerl_OnClick
function XPerl_OnClick(button)
	local unitid = this.partyid

	if (UnitName(unitid) or (button == "RightButton" and this.unit)) then
		if (XPerl_OnClick_Handler) then
			if (not XPerl_OnClick_Handler(button, unitid)) then
				if (button == "RightButton" and this.unit) then
					XPerl_OnClick_Handler("LeftButton", this.unit)
				end
			end
		else
			if (button == "RightButton" and this.unit and not SpellIsTargetting()) then
				button = "LeftButton"
			end

			if (button == "LeftButton") then
				if (SpellIsTargeting()) then
					SpellTargetUnit(unitid)
					return true
				elseif (CursorHasItem()) then
      					if (UnitIsUnit("player", unitid)) then
        		 			AutoEquipCursorItem()
					else
						DropItemOnUnit(unitid)
					end
					return true
				else
					TargetUnit(unitid)
					return true
				end

			elseif (button == "RightButton") then
				if (SpellIsTargeting()) then
					SpellStopTargeting()
					return true
				elseif (CursorHasItem()) then
					ClearCursor()
					return true
				else
					TargetUnit(this.unit)
				end
			end
		end
	end
end

-- XPerl_OnEnter
function XPerl_OnEnter()

	local x = XPerl_Frame:GetCenter()
	local a1, a2 = "ANCHOR_LEFT", "ANCHOR_TOPLEFT"
	if ( x < (GetScreenWidth() / 2)) then
		a1, a2 = "ANCHOR_RIGHT", "ANCHOR_TOPRIGHT"
	end

        if (SpellIsTargeting()) then
                if (SpellCanTargetUnit(this.partyid)) then
                        SetCursor("CAST_CURSOR")
                else
                        SetCursor("CAST_ERROR_CURSOR")
                end
        end

	if (XPerlConfigHelper.Tooltips == 1) then
		if (this.partyid and UnitName(this.partyid)) then
			GameTooltip:SetOwner(this, a1)
			GameTooltip:SetUnit(this.partyid)

			if (this.unit and (this.type == "MTT" or this.type == "OT")) then
				local extra = 10
				if (TinyTipExtrasExists) then
					extra = 20
				end

				XPerl_BottomTip:SetOwner(GameTooltip, a2, 0, extra)
				XPerl_BottomTip:SetUnit(this.unit)
				XPerl_BottomTip:SetBackdropColor(0.1, 0.4, 0.1, 0.75)
			end
		else
			if (this.type == "MTT" or this.type == "OT") then
				GameTooltip:SetOwner(this, a1)
				GameTooltip:SetUnit(this.unit)
				GameTooltip:SetBackdropColor(0.1, 0.4, 0.1, 0.75)
			end
		end
	end
end

-- ListChanged1
local function ListChanged1(list1, list2)
	if (getn(list1) == getn(list2)) then
		for k,v in pairs(list1) do
			if (v == list2[k]) then
				return true
			end
		end
		return false
	end
	return true
end

-- XPerl_SetupFrameSimple
function XPerl_SetupFrameSimple(argFrame, alpha)
	argFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, alpha or 0.8)
	argFrame:SetBackdropColor(0, 0, 0, alpha or 0.8)
end

-- AllocateUnit
local AllocateUnitNum = 0
local LastUnitWarning
local function AllocateUnit(list, parent)

	local unit = XFreeUnits[1]
	if (unit) then
		tremove(XFreeUnits, 1)
		tinsert(list, unit)
		unit:SetParent(parent)
	else
		if (AllocateUnitNum < MAX_UNITS) then
			AllocateUnitNum = AllocateUnitNum + 1
			unit = CreateFrame("Button", "XPerl_Unit"..AllocateUnitNum, parent, "XPerl_UnitTemplate")

			if (unit) then
				XPerl_SetupFrameSimple(unit, XPerlConfigHelper.Background_Transparency)
				unit:SetAlpha(XPerlConfigHelper.Targets_Transparency)
				tinsert(list, unit)

				if (XPerl_RegisterHighlight) then
					XPerl_RegisterHighlight(unit, 3)
				else
					local tex = unit:GetHighlightTexture()
					tex:SetVertexColor(0.86, 0.82, 0.41)
				end
			else
				XPerl_Notice("Error creating frame called 'XPerl_Unit"..AllocateUnitNum.."' from template 'XPerl_UnitTemplate'")
			end
		else
			if (not LastUnitWarning or GetTime() > LastUnitWarning + 600) then
				LastUnitWarning = GetTime()
		   		XPerl_Notice("Maximum number of units reached ("..MAX_UNITS..")")
			end
		end
	end

	if (unit) then
		if (XPerl_GetBarTexture) then
			local tex = XPerl_GetBarTexture()
			getglobal(unit:GetName().."_HealthBarTex"):SetTexture(tex)

			if (XPerlConfig.BackgroundTextures == 1) then
				getglobal(unit:GetName().."_HealthBarBG"):SetTexture(tex)
			else
				getglobal(unit:GetName().."_HealthBarBG"):SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
			end
		end

		local t = getglobal(unit:GetName().."_HealthBarText");		t:Hide()
		t = getglobal(unit:GetName().."_Label");	t:SetText("");	t:Hide()
		t = getglobal(unit:GetName().."_Name");				t:Show()

		XPerl_SetupFrameSimple(unit, XPerlConfigHelper.Background_Transparency)

		unit:SetScale(1)
		unit:SetWidth(XPerlConfigHelper.UnitWidth)
		unit:SetHeight(XPerlConfigHelper.UnitHeight)

		local bar = getglobal(unit:GetName().."_HealthBar")
		bar:ClearAllPoints()
		if (XPerlConfigHelper.UnitHeight > 16) then
			bar:SetPoint("TOPLEFT", 3, -14)
			bar:SetPoint("BOTTOMRIGHT", -3, 2)
		else
			bar:SetPoint("TOPLEFT", 4, -4)
			bar:SetPoint("BOTTOMRIGHT", -4, 4)
		end

		unit:Show()
	end

	return unit
end

-- Remove units from list and place back into available unit pool
local function UnallocateUnits(list)

	while (getn(list) > 0) do
		local unit = list[1]

		unit:ClearAllPoints()
		unit:Hide()

		unit.partyid = nil
		unit.unit = nil
		unit.OtherTarget = nil
		unit.collapseable = nil
		unit.type = nil

		tremove(list, 1)
		tinsert(XFreeUnits, unit)
	end
end

-- XPerl_HelperBarTextures
if (XPerl_GetBarTexture) then
function XPerl_HelperBarTextures(tex)
	local function UnitTex(v, tex)
		local f = getglobal(v:GetName().."_HealthBarTex")
		f:SetTexture(tex)
		f = getglobal(v:GetName().."_HealthBarBG")
		if (XPerlConfig and XPerlConfig.BackgroundTextures == 1) then
			f:SetTexture(tex)
		else
			f:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end
	end

	XPerl_MyThreatTex:SetTexture(tex)
	XPerl_MyThreatBG:SetTexture(tex)

	for k,v in pairs(XUnits) do
		UnitTex(v, tex)
	end
	for k,v in pairs(XOtherUnits) do
		UnitTex(v, tex)
	end
	for k,v in pairs(XFreeUnits) do
		UnitTex(v, tex)
	end
end
end

-- XPerl_SetMainAssist
function XPerl_SetMainAssist(msg, ma, quiet)

	if (ma == "broadcast") then
		if (IsRaidOfficer()) then
			SendAddonMessage(XPERL_COMMS_PREFIX, "MA "..UnitName("player").." "..UnitName(MainAssist.unit), "RAID")
		else
			XPerl_Message("You must be promoted to set the Main Assist")
		end
	else
		if (not ma) then
			ma = 0
		end

		if (string.lower(ma) == "target") then
			ma = UnitName(ma)
		end

		if (ma) then
			for i,tank in pairs(MainTanks) do
				if (string.lower(UnitName("raid"..tank[1])) == string.lower(ma)) then
					ma = i
					break
				end
			end

			ma = tonumber(ma)

			if (MainTanks[ma]) then
				local maUnit = "raid"..MainTanks[ma][1]
				MainAssist = {unit = maUnit, name = UnitName(maUnit)}
				local _, class = UnitClass(maUnit)
				MainAssist.class = class
			else
				MainAssist = nil
			end
		else
			MainAssist = nil
		end

		if (MainAssist) then
			XPerlConfigHelper.LastMainAssist = MainAssist.name
		else
			XPerlConfigHelper.LastMainAssist = nil
		end

		if (not quiet) then
			if (MainAssist) then
				XPerl_Message("Main Assist set to "..XPerlColourTable[MainAssist.class]..MainAssist.name)
			else
				XPerl_Message("Main Assist |c00FF0000cleared!")
			end
		end
	end

	return true
end

-- RemoveDupMT
local function RemoveDupMT(name)
	for k, v in pairs(XPerl_MainTanks) do
		if (v[2] == name) then
			XPerl_MainTanks[k] = nil
			return true
		end
	end
end

-- GetRaidIDByName
local function GetRaidIDByName(name)
	for i = 1, GetNumRaidMembers() do
		if (UnitName("raid"..i) == name) then
			return i
		end
	end
end

-- GetUnitRank
local function GetUnitRank(name)
	local index = GetRaidIDByName(name)
	if (index) then
		local _, rank = GetRaidRosterInfo(index)
		return rank
	end
	return 0
end

-- ValidateTankList
-- Check the roster for any tanks that have left the raid
local function ValidateTankList()
	for index,entry in pairs(XPerl_MainTanks) do
		local found
		for i = 1,GetNumRaidMembers() do
			if (UnitName("raid"..i) == entry[2]) then
				found = true
				break
			end
		end

		if (not found) then
			XPerl_MainTanks[index] = nil
		end
	end
end

-- XPerl_MTRosterChanged()
function XPerl_MTRosterChanged()
	ValidateTankList()

	MainTankCount = 0
	for i in pairs(XPerl_MainTanks) do
		MainTankCount = MainTankCount + 1
	end

	if (MainTankCount == 0 or XPerlConfigHelper.UseCTRATargets == 0) then
		-- If no defined tanks, then make a list from the warriors in raid
		MainTanks = {}
		MainTankCount = 0

		for i = 1,GetNumRaidMembers() do
			local _, class = UnitClass("raid"..i)
			if (class == "WARRIOR") then
				tinsert(MainTanks, {i, UnitName("raid"..i)})
				MainTankCount = MainTankCount + 1
			end
		end
	else
		MainTankCount = 0
		for index,entry in pairs(XPerl_MainTanks) do
			local raidid = GetRaidIDByName(entry[2])
			if (raidid) then
				MainTankCount = MainTankCount + 1
				entry[1] = raidid
			end
		end

		MainTanks = XPerl_MainTanks
	end

	XPerl_MakeTankList()

	if (XPerlConfigHelper.LastMainAssist) then
		if (not MainAssist) then
			XPerl_SetMainAssist("", XPerlConfigHelper.LastMainAssist, true)
			if (not MainAssist) then
				XPerlConfigHelper.LastMainAssist = nil
			end
		end
	end
end

-- CT_RA_IsSendingWithVersion override
-- Override this so that we get the MT list if there's only us in the raid with a CTRA version registered
local old_CT_RA_IsSendingWithVersion
if (CT_RA_IsSendingWithVersion) then
	if (CT_RA_IsSendingWithVersion ~= XPerl_IsSendingWithVersion) then
		old_CT_RA_IsSendingWithVersion = CT_RA_IsSendingWithVersion
		CT_RA_IsSendingWithVersion = function(version)
			if (version == 1.08) then
				return 1
			end
			return old_CT_RA_IsSendingWithVersion(version)
		end
	end
end

-- ProcessCTRAMessage
local function ProcessCTRAMessage(unitName, msg)

	local mtListUpdate

	if (strsub(msg, 1, 4) == "SET ") then
		local rankSender = GetUnitRank(unitName)
		if (rankSender < 1) then
			return
		end

		local useless, useless, num, name = strfind(msg, "^SET (%d+) (.+)$")
		if (num and name) then
			num = tonumber(num)
			local mtID = 0
			for i = 1, GetNumRaidMembers() do
				if (UnitName("raid"..i) == name) then
					mtID = i
					break
				end
			end

			if (XPerl_MainTanks[num]) then
				if (XPerl_MainTanks[num][1] == mtID and XPerl_MainTanks[num][2] == name) then
					return			-- No Change
				end
			end

			RemoveDupMT(name)

			XPerl_MainTanks[tonumber(num)] = {mtID, name}

			mtListUpdate = true
		end

	elseif (strsub(msg, 1, 2) == "R ") then
		local rankSender = GetUnitRank(unitName)
		if (rankSender < 1) then
			return
		end

		local useless, useless, name = strfind(msg, "^R (.+)$")
		if (name) then
			mtListUpdate = RemoveDupMT(name)
		end
	end

	if (mtListUpdate) then
		XPerl_MTRosterChanged()
	end
end

-- XPerl_SplitCTRAMessage
function XPerl_SplitCTRAMessage(msg, char)
	local arr = { }
	while (strfind(msg, char) ) do
		local iStart, iEnd = strfind(msg, char)
		tinsert(arr, strsub(msg, 1, iStart-1))
		msg = strsub(msg, iEnd+1, strlen(msg))
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg)
	end
	return arr
end

-- XPerl_ParseCTRA
function XPerl_ParseCTRA(nick, msg, func)
	if (strfind(msg, "#")) then
		local arr = XPerl_SplitCTRAMessage(msg, "#")
		for i,subMsg in pairs(arr) do
			func(nick, subMsg)
		end
	else
		func(nick, msg)
	end
end

-- CHAT_MSG_ADDON
function Events:CHAT_MSG_ADDON()
	if (arg1 == XPERL_COMMS_PREFIX and arg3 == "RAID") then
		local msg = arg2
		local cmds = {}
		for x in string.gfind(msg, "[^ ]+") do
			tinsert(cmds, x)
		end

		if (cmds[1] == "MA") then
			local from = cmds[2]
			local newMA = cmds[3]
			local fromID, maID

			-- Pick up raid id for sender and new MA
			for i = 1,GetNumRaidMembers() do
				local name, rank, group, level, classLocal, class = GetRaidRosterInfo(i)

				if (name == from) then
					if (rank > 0) then	-- Make sure someone who is promoted sent the message
						fromID = "raid"..i
					else
						return
					end
				end
				if (name == newMA) then
					maID = "raid"..i
				end
			end

			if (fromID and maID) then
				if (not UnitIsUnit(fromID, "player")) then
					local _, fromClass = UnitClass(fromID)
					local __, maClass = UnitClass(maID)

					MainAssist = {unit = maID, name = UnitName(maID), class = maClass}
					XPerlConfigHelper.LastMainAssist = MainAssist.name
					XPerl_Message(XPerlColourTable[fromClass]..from.." has assigned the Main Assist to be "..XPerlColourTable[maClass]..MainAssist.name)
				end
			end
		end
	elseif (arg1 == "CTRA" and arg3 == "RAID") then
		XPerl_ParseCTRA(arg4, arg2, ProcessCTRAMessage)
	end
end

----------------------------
---------- EVENTS ----------
----------------------------

-- OnEvent
function XPerl_OnEvent()
	local Event = Events[event]
	if (Event) then
		Event()
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

local function IsDPSClass(unit)
	local _, class = UnitClass(unit)
	return (class == "ROGUE" or class == "WARRIOR" or class == "MAGE" or class == "WARLOCK" or class == "HUNTER")
end

local function IsMT1(unit)
	if (MainAssist and UnitName(MainAssist.unit) == MainAssist.name) then
		return UnitIsUnit(unit, MainAssist.unit)
	elseif (MainTanks[1]) then
		return UnitIsUnit(unit, "raid"..MainTanks[1][1])
	end
end

local function IsMT(unit)
	for k, tank in pairs(MainTanks) do
		if (UnitIsUnit(unit, "raid"..tank[1])) then
			return true
		end
	end
end

local function IsTanked(checkUnit)
	for k, tank in pairs(MainTanks) do
		if (UnitIsUnit("raid"..tank[1].."target", checkUnit)) then
			return true
		end
	end
end

-- ScanForTargets
local function ScanForTargets()

	if (XPerlConfigHelper.CollectOtherTargets == 0 or UnitIsCharmed("player")) then
		return {}
	end

	local NewList = {}

	local function FoundAlready(checkUnit)
		for j, owner in pairs(NewList) do
			if (UnitIsUnit(owner.."target", checkUnit.."target")) then
				return true
			end
		end
	end

	local function Check(unitid, doStats)
		if (UnitLevel(unitid.."target") ~= 1 and (UnitReaction("player", unitid.."target") or 5) <= 4 and not UnitIsDeadOrGhost(unitid.."target")) then
			if (not FoundAlready(unitid)) then
				if (not IsTanked(unitid.."target")) then
					tinsert(NewList, unitid)
				end
			end
		end
	end

	local doStats = XPerl_Stats:IsShown()

	if (doStats) then
		XPerl_Stats_List.NoTarget = {}
		XPerl_Stats_List.NotAssistingMT1 = {}
		XPerl_Stats_List.NotAssistingAnyMT = {}
		XPerl_Stats_List.HealersOnMT1 = {}
		XPerl_Stats_List.HealersOnOtherMTs = {}
		XPerl_Stats_List.HealersNotOnMTs = {}
	end

	for i = 1,GetNumRaidMembers() do
		local checkUnit = "raid"..i
		if (doStats) then
			if (UnitIsConnected(checkUnit) and UnitIsVisible(checkUnit) and not UnitIsDeadOrGhost(checkUnit)) then
				if (not UnitName(checkUnit.."target") and UnitName(checkUnit.."target") ~= UNKNOWNOBJECT) then
					-- No target, slacker
					tinsert(XPerl_Stats_List.NoTarget, checkUnit)
				else
					if (IsDPSClass(checkUnit)) then
						-- DPS statistics
						--if (UnitCanAttack(checkUnit, checkUnit.."target")) then
						if ((UnitReaction("player", checkUnit.."target") or 5) <= 4) then
							if (not IsMT(checkUnit)) then
								if (MainTanks[1] and not UnitIsUnit(checkUnit.."target", "raid"..MainTanks[1][1].."target")) then
									-- They're not assisting MT1
									tinsert(XPerl_Stats_List.NotAssistingMT1, checkUnit)
									tinsert(XPerl_Stats_List.NotAssistingAnyMT, checkUnit)

								elseif (not IsTanked(checkUnit.."target")) then
									-- They're not assisting any of the MTs
									tinsert(XPerl_Stats_List.NotAssistingAnyMT, checkUnit)
								end
							end
						else
							-- DPS targetting friendly, count it as useless
							tinsert(XPerl_Stats_List.NoTarget, checkUnit)
						end
					else
						-- Healer statistics
						if (IsMT1(checkUnit.."target")) then
							-- Healer targetting MT1
							tinsert(XPerl_Stats_List.HealersOnMT1, checkUnit)

						elseif (IsMT(checkUnit.."target")) then
							-- Healer targetting another MT
							tinsert(XPerl_Stats_List.HealersOnOtherMTs, checkUnit)

						else
							tinsert(XPerl_Stats_List.HealersNotOnMTs, checkUnit)
						end
					end
				end
			end
		end

		Check(checkUnit)
		Check("raidpet"..i)
	end

	if (doStats) then
		local function Colour(num, good)
			if (num > 10) then
				if (good) then
					return "|c0000FF00"..num.."|r"
				else
					return "|c00FF0000"..num.."|r"
				end
			elseif (num > 0) then
				return "|c00FFFF00"..num.."|r"
			else
				if (good) then
					return "|c00FF0000"..num.."|r"
				else
					return "|c0000FF00"..num.."|r"
				end
			end
		end

		local MT1 = "MT1"
		if (MainAssist and UnitName(MainAssist.unit) == MainAssist.name) then
			MT1 = "MA"
		end

		XPerl_Stats1:SetText(string.format(XPERL_STATS_NO_TARGET, Colour(getn(XPerl_Stats_List.NoTarget))))
		XPerl_Stats2:SetText(string.format(XPERL_STATS_NOT_ASSIST_MT1, Colour(getn(XPerl_Stats_List.NotAssistingMT1)), MT1))
		XPerl_Stats3:SetText(string.format(XPERL_STATS_NOT_ASSIST_ANY, Colour(getn(XPerl_Stats_List.NotAssistingAnyMT))))
		XPerl_Stats4:SetText(string.format(XPERL_STATS_HEALERS_MT1, Colour(getn(XPerl_Stats_List.HealersOnMT1), true), MT1))
		XPerl_Stats5:SetText(string.format(XPERL_STATS_HEALERS_ANY, Colour(getn(XPerl_Stats_List.HealersOnOtherMTs), true)))
		XPerl_Stats6:SetText(string.format(XPERL_STATS_HEALERS_NON_MT, Colour(getn(XPerl_Stats_List.HealersNotOnMTs))))

		if (XPerl_Stats_List.shownStats ~= 0) then
			XPerl_SetStatDetails()
		end
	end

	return NewList
end

-- XPerl_GetUnit
local function XPerl_GetUnit(unit)
	for i,search in pairs(XUnits) do
		if (search.unit == unit) then
			return search
		end
	end
end

-- ScanForMTDups
-- Check MTs all have unique targets
local function ScanForMTDups()
	local dup = 1
	local dups = {}

	for i,unit in pairs(XUnits) do
		XPerl_SetupFrameSimple(unit, XPerlConfigHelper.Background_Transparency)
	end

	for i,t1 in pairs(MainTanks) do
		local any = false

		if (UnitName("raid"..t1[1].."target") and UnitName("raid"..t1[1].."target") ~= UNKNOWNOBJECT and not UnitIsDeadOrGhost("raid"..t1[1])) then
			for j,t2 in pairs(MainTanks) do
				if (j > i and not dups["raid"..t2[1]]) then
					if (UnitIsUnit("raid"..t1[1].."target", "raid"..t2[1].."target")) then
						dups["raid"..t2[1]] = 1

						local unit1 = XPerl_GetUnit("raid"..t1[1])
						local unit2 = XPerl_GetUnit("raid"..t2[1])

						if (unit1) then
							unit1:SetBackdropBorderColor(MTdupColours[dup].r, MTdupColours[dup].g, MTdupColours[dup].b)
							unit1:SetBackdropColor(MTdupColours[dup].r, MTdupColours[dup].g, MTdupColours[dup].b)
						end
						if (unit2) then
							unit2:SetBackdropBorderColor(MTdupColours[dup].r, MTdupColours[dup].g, MTdupColours[dup].b)
							unit2:SetBackdropColor(MTdupColours[dup].r, MTdupColours[dup].g, MTdupColours[dup].b)
						end
						any = true
					end
				end
			end

			if (any and dup < 5) then
				dup = dup + 1
			end
		end
	end
end

-- OnUpdate
local function OnUpdate()
	UpdateTime = UpdateTime + arg1
	if (UpdateTime > 0.2) then
		UpdateTime = 0

		local doneArrow = false
		local maDone = false
		XPerl_MyTarget:ClearAllPoints()
		XPerl_MyTarget:Hide()
		XPerl_MainAssist:Hide()

		local arrowType = "MTT"
		local arrowExtra = ""
		if (XPerlConfigHelper.ShowMT == 1) then
			arrowType = "MT"
			arrowExtra = "target"
		end

		for i,unit in pairs(XUnits) do
			UpdateUnit(unit, true)

			local xunit = SpecialCaseUnit(unit)

			if (unit.type == arrowType and not doneArrow and UnitIsUnit("target", xunit..arrowExtra) and UnitExists("target")) then -- and not UnitIsPlayer(unit.partyid)) then
				doneArrow = true
				XPerl_MyTarget:SetParent(unit)
				XPerl_MyTarget:SetPoint("RIGHT", unit, "LEFT", 2 - (XPerlConfigHelper.MTLabels * 10), 0)
				XPerl_MyTarget:Show()
			end

			if (not maDone and MainAssist and UnitIsUnit(unit.unit, MainAssist.unit) and UnitName(MainAssist.unit) == MainAssist.name) then
				maDone = true
				XPerl_MainAssist:SetParent(getglobal(unit:GetName().."_HealthBar"))
				XPerl_MainAssist:ClearAllPoints()

				if (XPerlConfigHelper.MTLabels == 1) then
					XPerl_MainAssist:SetPoint("BOTTOMRIGHT", unit, "BOTTOMLEFT", 1, 3)
				else
					XPerl_MainAssist:SetPoint("BOTTOMRIGHT", -1, 1)
				end
				XPerl_MainAssist:Show()
			end
		end

		local NewList = ScanForTargets()

		if (ListChanged1(OtherTargetOwners, NewList)) then
			OtherTargetOwners = NewList
			XPerl_MakeOtherTargetList()
		else
			for i,unit in pairs(XOtherUnits) do
				UpdateUnit(unit, true)

				local xunit = SpecialCaseUnit(unit)

				if (unit.type == "OT" and unit:IsVisible() and not doneArrow and UnitIsUnit("target", xunit) and UnitExists("target") and not UnitIsPlayer(unit.partyid)) then
					doneArrow = true
					XPerl_MyTarget:SetParent(unit)
					XPerl_MyTarget:SetPoint("RIGHT", unit, "LEFT", 2 - (XPerlConfigHelper.MTLabels * XPerlConfigHelper.OtherTargetTargets * 10) * unit:GetScale(), 0)
					XPerl_MyTarget:Show()
				end
			end
		end

		ScanForMTDups()

		bigwigsSlowDown = bigwigsSlowDown + 1
		if (bigwigsSlowDown > 10) then
			bigwigsSlowDown = 0
		end

		--XPerl_Frame_Test:SetText(getn(XFreeUnits).." "..getn(XUnits).." "..getn(XOtherUnits))
	end

	if (FrameExpanded or XPerlConfigHelper.ExpandLock == 1) then
		local f = GetMouseFocus()
		if (f) then
			while (f:GetParent() and f:GetParent() ~= UIParent) do
				f = f:GetParent()
			end

			if (f ~= XPerl_Frame) then
				XPerl_CollapseOthers()
			end
		end
	end
end

-- VARIABLES_LOADED
function Events:VARIABLES_LOADED()
	this:UnregisterEvent(event)

	if (type(XPerl_MainTanks) ~= "table") then
		XPerl_MainTanks = {}
	end

	XPerl_Startup()
	XPerl_EnableDisable()
end

-- Registration
local function Registration()
	local list = {	"UNIT_HEALTH",
			"UNIT_MAXHEALTH",
			"PLAYER_TARGET_CHANGED",
			"CHAT_MSG_ADDON"}

	for i,a in pairs(list) do
		if (GetNumRaidMembers() > 0 and XPerlConfigHelper.RaidHelper == 1) then
			XPerl_Frame:RegisterEvent(a)
		else
			XPerl_Frame:UnregisterEvent(a)
		end
	end
end

-- XPerl_EnableDisable
function XPerl_EnableDisable()
	if (XPerlConfigHelper and XPerlConfigHelper.RaidHelper == 1 and GetNumRaidMembers() > 0) then
		XPerl_Frame:Show()
		XPerl_Frame:SetScript("OnUpdate", OnUpdate)

		if (CT_RAMenu_Options and CT_RA_UpdateVisibility) then
			XPerlConfigHelper.OldCTMTListHide = CT_RAMenu_Options["temp"]["HideMTs"]
			CT_RAMenu_Options["temp"]["HideMTs"] = true
			CT_RA_UpdateVisibility(1)
		end
	else
		XPerl_Frame:Hide()
		XPerl_Frame:SetScript("OnUpdate", nil)

		if (XPerlConfigHelper and XPerlConfigHelper.RaidHelper == 0 and CT_RAMenu_Options and CT_RA_UpdateVisibility) then
			if (XPerlConfigHelper.OldCTMTListHide ~= true) then
				XPerlConfigHelper.OldCTMTListHide = nil
				CT_RAMenu_Options["temp"]["HideMTs"] = false
				CT_RA_UpdateVisibility(1)
			end
		end
	end

	Registration()
	XPerl_MTRosterChanged()
end

-- RAID_ROSTER_UPDATE
function Events:RAID_ROSTER_UPDATE()
	if (GetNumRaidMembers() == 0) then
		MainTanks = {}
	end

	XPerl_EnableDisable()
end

-- UNIT_HEALTH
function Events:UNIT_HEALTH()
	-- scan for a unit we have
	for k,unit in pairs(XUnits) do
		if (UnitIsUnit(unit.partyid, arg1)) then
			UpdateUnit(unit)
		end
	end

	for k,unit in pairs(XOtherUnits) do
		if (UnitIsUnit(unit.partyid, arg1)) then
			UpdateUnit(unit)
		end
	end
end

Events.UNIT_MAXHEALTH = Events.UNIT_HEALTH

function Events:PLAYER_TARGET_CHANGED()
	for i,unit in pairs(XUnits) do
		if (UnitIsUnit(unit.partyid, "player")) then
			UpdateUnit(unit)
		end
	end
end

-- The number of 'Other' colums that can be shown
local function DisplayableColumns()
	local columnsTop = 1 + XPerlConfigHelper.ShowMT + XPerlConfigHelper.MTTargetTargets
	local columnsBottom = 1 + XPerlConfigHelper.OtherTargetTargets

	if (columnsTop == 1 and columnsBottom > 1) then
		if (XPerlConfigHelper.MTTargetTargets == 0) then
			if (XPerlConfigHelper.MTLabels == 1) then
				if (XPerlConfigHelper.OtherTargets_Scale > 0.52) then
					columnsTop = 2
				end
			else
				if (XPerlConfigHelper.OtherTargets_Scale > 0.49) then
					columnsTop = 2
				end
			end
		end
	end

	return columnsTop
end

-- XPerl_SetTitle
function XPerl_SetTitle()
	if (DisplayableColumns() > 1 and XPerlConfigHelper.UnitWidth >= 70) then
		if (XPerl_MainTanks == MainTanks) then
			XPerl_Frame_Title:SetText(XPERL_TITLE_MT_LONG)
		else
			XPerl_Frame_Title:SetText(XPERL_TITLE_WARRIOR_LONG)
		end
	else
		if (XPerl_MainTanks == MainTanks) then
			XPerl_Frame_Title:SetText(XPERL_TITLE_MT_SHORT)
		else
			XPerl_Frame_Title:SetText(XPERL_TITLE_WARRIOR_SHORT)
		end
	end
end

-- XPerl_MakeTankList
function XPerl_MakeTankList()

	if (not XPerlConfigHelper or XPerlConfigHelper.RaidHelper == 0 or GetNumRaidMembers() == 0) then
		XPerl_SetFrameSizes()
		return
	end

	XPerl_SetTitle()

	XPerl_MyTarget:Hide()
	XPerl_MainAssist:Hide()

	--MainTanks = NewTankList

	UnallocateUnits(XUnits)

	XGaps = 0

	local previousUnit
	local previousID = 0
	local first = true
	local foundMA = false
	local mainTanksDisplayed = 0
	for i,tank in pairs(MainTanks) do
		local unit = AllocateUnit(XUnits, XPerl_MTTargets)
		if (not unit) then
			break
		end
		unit.partyid = "raid"..tank[1].."target"
		unit.unit = "raid"..tank[1];			-- 1 == id, 2 == name
		unit.type = "MTT"

		mainTanksDisplayed = mainTanksDisplayed + 1

		local rowFrames = {}
		rowFrames[2] = unit

		-- Correct the Main Assist number in case people leave the raid
		if (MainAssist and UnitName("raid"..tank[1]) == MainAssist.name) then
			MainAssist.unit = "raid"..tank[1]
			foundMA = true
		end

		if (XPerlConfigHelper.ShowMT == 1) then
			local unitTank = AllocateUnit(XUnits, XPerl_MTTargets)
			if (unitTank) then
				unitTank.partyid = "raid"..tank[1]
				unitTank.unit = "raid"..tank[1]
				unitTank.type = "MT"

				rowFrames[1] = unitTank
			else
				break
			end
		end

		if (XPerlConfigHelper.MTTargetTargets == 1) then
			local unitTarget = AllocateUnit(XUnits, XPerl_MTTargets)
			if (unitTarget) then
				unitTarget.partyid = "raid"..tank[1].."targettarget"
				unitTarget.unit = "raid"..tank[1]
				unitTarget.type = "MTTT"

				rowFrames[3] = unitTarget
			else
				break
			end
		end

		local previousColumn
		for j,frame in pairs(rowFrames) do
			UpdateUnit(frame)

			if (not previousColumn) then
				if (first) then
					first = false
					frame:SetPoint("TOPLEFT", XPerl_MTTargets, "TOPLEFT", XPerlConfigHelper.MTLabels * 10, 0)
				else
					local gap = 0;		-- Maintain a gap if not sequential numbers
					if (i > previousID + 1) then
						XGaps = XGaps + 1
						gap = -GAP_SPACING
					end

					frame:SetPoint("TOPLEFT", previousUnit, "BOTTOMLEFT", 0, gap)
				end
			else
				frame:SetPoint("TOPLEFT", previousColumn, "TOPRIGHT", 0, 0)
			end

			if (not previousColumn) then
				local label = getglobal(frame:GetName().."_Label")
				label:SetText(i)
				label:SetTextColor(1, 1, 1)
				if (XPerlConfigHelper.MTLabels == 1) then
					label:Show()
				end

				previousUnit = frame
			end
			previousColumn = frame
		end

		if (mainTanksDisplayed >= XPerlConfigHelper.MaxMainTanks) then
			break
		end

		previousID = i
	end

	if (MainAssist and not foundMA) then
		-- Main assist left the raid
		XPerl_Message("Main Assist "..XPerlColourTable[MainAssist.class]..MainAssist.name.."|r not found in tank list - removed!")
		MainAssist = nil
	end

	if (previousUnit) then
		XPerl_Frame:Show()
	else
		XPerl_Frame:Hide()
	end

	XPerl_SetFrameSizes()
end

-- XPerl_MakeOtherTargetList
function XPerl_MakeOtherTargetList()

	UnallocateUnits(XOtherUnits)

	local mainWidth = XPerl_Frame:GetWidth()

	if (not IsTanked("target")) then
		XPerl_MyTarget:Hide()
	end

	XOtherRows = 0

	local previousUnit
	local rowStartUnit
	local rowSize = 0
	local firstRowSize
	for i,other in pairs(OtherTargetOwners) do
		if (XOtherRows >= MAX_OTHER_ROWS) then		-- Well, gotta stop somewhere...
			break
		end

		local unit = AllocateUnit(XOtherUnits, XPerl_OtherTargets)
		if (not unit) then
			break
		end

		unit:SetScale(XPerlConfigHelper.OtherTargets_Scale)
		local otherWidth = unit:GetWidth() * unit:GetScale()

		unit.partyid = other.."target"
		unit.type = "OT"

		if (i == 1) then
			rowStartUnit = unit
			rowSize = otherWidth
			unit:SetPoint("TOPLEFT", XPerl_OtherTargets, "TOPLEFT", XPerlConfigHelper.MTLabels * XPerlConfigHelper.OtherTargetTargets * 10, 0)
			XOtherRows = XOtherRows + 1
		else
			if (XPerlConfigHelper.OtherTargetTargets == 1) then
				unit:SetPoint("TOPLEFT", previousUnit, "BOTTOMLEFT", 0, 0)
				XOtherRows = XOtherRows + 1
			else
				if (rowSize + otherWidth > mainWidth - 6) then
					if (XOtherRows == MAX_OTHER_ROWS) then
						break
					end

					if (not firstRowSize) then
						firstRowSize = i - 1
					end

					unit:SetPoint("TOPLEFT", rowStartUnit, "BOTTOMLEFT", 0, 0)
					rowStartUnit = unit
					rowSize = otherWidth
					XOtherRows = XOtherRows + 1
				else
					rowSize = rowSize + otherWidth
					unit:SetPoint("TOPLEFT", previousUnit, "TOPRIGHT", 0, 0)
				end
			end
		end
		UpdateUnit(unit)

		if (XOtherRows > 1) then
			unit.collapseable = true
		end

		if (XOtherRows > 1 and not FrameExpanded and XPerlConfigHelper.ExpandLock == 0) then
			unit:Hide()
		end

		local label = getglobal(unit:GetName().."_Label")
		label:SetText(i)
		label:SetTextColor(0.8, 0.2, 0.2)
		if (XPerlConfigHelper.OtherTargetTargets == 1) then
			if (XPerlConfigHelper.MTLabels == 1) then
				label:Show()
			end

			local newUnit = AllocateUnit(XOtherUnits, XPerl_OtherTargets)
			if (not newUnit) then
				break
			end
			newUnit:SetScale(XPerlConfigHelper.OtherTargets_Scale)
			newUnit.partyid = unit.partyid.."target"
			newUnit:SetPoint("TOPLEFT", unit, "TOPRIGHT", 0, 0)
			newUnit.type = "OTT"

			UpdateUnit(newUnit)

			if (XOtherRows > 1) then
				newUnit.collapseable = true
			end
			if (i > 1 and not FrameExpanded and XPerlConfigHelper.ExpandLock == 0) then
				unit.collapseable = true
				newUnit:Hide()
			end

			unit.OtherTarget = newUnit
		end

		previousUnit = unit
	end

	XPerl_SetFrameSizes()

	if (not firstRowSize) then
		firstRowSize = 1
	end
	XPerl_ExpandArrowFrame_Stats:SetText(string.format(XPERL_FOOTER_MORE, getn(OtherTargetOwners) - firstRowSize))

	local key = GetBindingText(GetBindingKey("TARGETFIRSTOTHER"), "KEY_")
	if (key) then
		XPerl_OtherTargets_Key:SetText(string.format(XPERL_TO_TARGET, "|c0000FF40"..key.."|r"))
	else
		XPerl_OtherTargets_Key:SetText("")
	end
end

-- XPerl_SetFrameSizes
function XPerl_SetFrameSizes()

	local tanks = MainTankCount
	local unitHeight = 20
	local unitHeightOther = 20

	if (tanks > XPerlConfigHelper.MaxMainTanks) then
		tanks = XPerlConfigHelper.MaxMainTanks
	end

	if (XPerl_Unit1) then
		unitHeight = XPerl_Unit1:GetHeight()
		if (XOtherUnits[1]) then
			unitHeightOther = XOtherUnits[1]:GetHeight() * XOtherUnits[1]:GetScale()
		end
	end

	XPerl_MTTargets:SetHeight((unitHeight * tanks) + (XGaps * GAP_SPACING))

	local otherTargets = getn(OtherTargetOwners)
	local otherTargetsExtraHeight = 0

	if (otherTargets > 0) then
		otherTargetsExtraHeight = 10
		XPerl_OtherTargets:Show()
	else
		XPerl_OtherTargets:Hide()
	end

	if (XOtherRows < 2 or FrameExpanded or XPerlConfigHelper.ExpandLock == 1) then
		XPerl_ExpandArrowFrame:Hide()
	else
		if (otherTargets > 1) then
			otherTargets = 1
			otherTargetsExtraHeight = otherTargetsExtraHeight + 10
			XPerl_ExpandArrowFrame:Show()
		else
			XPerl_ExpandArrowFrame:Hide()
		end
	end

	local otherRows = XOtherRows
	if (otherRows > MAX_OTHER_ROWS) then
		otherRows = MAX_OTHER_ROWS
	end
	if (otherRows > 1 and not FrameExpanded and XPerlConfigHelper.ExpandLock == 0) then
		otherRows = 1
	end
	XPerl_Frame:SetHeight((unitHeight * tanks) + (XGaps * GAP_SPACING) + (unitHeightOther * otherRows) + 5 + XPerl_Frame_TitleBar:GetHeight() + otherTargetsExtraHeight)

	local ExtraWidth = (XPerlConfigHelper.MTLabels * 10);	-- 0 for off, 10 for on
	XLastColumCount = DisplayableColumns()
	XPerl_Frame:SetWidth(XLastColumCount * XPerlConfigHelper.UnitWidth + 6 + ExtraWidth)
end

-- XPerl_ExpandOthers
function XPerl_ExpandOthers()
	if (not FrameExpanded) then
		FrameExpanded = true
        	XPerl_SetFrameSizes()

		for i,unit in pairs(XOtherUnits) do
			unit:Show()
		end
	end
end

-- XPerl_CollapseOthers
function XPerl_CollapseOthers()
	if (FrameExpanded and XPerlConfigHelper.ExpandLock == 0) then
		FrameExpanded = false
        	XPerl_SetFrameSizes()

		for i,unit in pairs(XOtherUnits) do
			if (unit.collapseable) then
				unit:Hide()
			end
		end

		if (XOtherUnits[1] and XOtherUnits[1].OtherTarget) then
			XOtherUnits[1].OtherTarget:Show()
		end
	end
end

-- XPerl_Toggle_Stats
function XPerl_Toggle_Stats()
	if (XPerl_Stats:IsShown()) then
		XPerl_Stats:Hide()
		if (XPerl_Stats_List.shownStats ~= 0) then
			getglobal("XPerl_Stats"..XPerl_Stats_List.shownStats):UnlockHighlight()
			XPerl_Stats_List.shownStats = 0
		end
		XPerl_Stats_List:Hide()
	else
		XPerl_Stats1:SetText("")
		XPerl_Stats2:SetText("")
		XPerl_Stats3:SetText("")
		XPerl_Stats4:SetText("")
		XPerl_Stats5:SetText("")

		XPerl_Stats:Show()
	end
end

-- XPerl_TargetFirstOther
function XPerl_TargetFirstOther()
	if (XOtherUnits[1]) then
		TargetUnit(XOtherUnits[1].partyid)
	end
end

-- XPerl_SmartAssist
local XAssistSkipCount = 0
function XPerl_SmartAssist()

	local function ValidTarget(unit)
		local minor
		if (UnitIsVisible(unit)) then
			if (UnitExists(unit) and not UnitIsDeadOrGhost(unit)) then
				if (UnitReaction("player", unit) <= 4) then
					if (UnitHealth(unit) <= 10) then
						return "minor"
					else
						return "valid"
					end
				end
			end
		end
	end

	local function XFindUnit()
		if (XFind) then
			TargetByName(XFind)

			if (ValidTarget("target") and strlower(strsub(UnitName("target"),1,strlen(XFind))) == strlower(XFind)) then
				XPerl_Message("Using FIND found suitable target. ('|c00007F00/xp find|r' to clear).")
				return true
			else
				local r = UnitReaction("player", "target")
				if (r and r > 4) then
					ClearTarget()
				end
			end
		end
	end

	if (not UnitName("target")) then
		if (XFindUnit()) then
			return
		end
	end

	if (not UnitExists("target")) then
		XAssistSkipCount = 0
	end

	local minorUnit
	local valid
	local isMT = IsMT("player")
	local targetCount = 0

	local function Skip()
		targetCount = targetCount + 1
		if (targetCount > XAssistSkipCount) then
			XAssistSkipCount = XAssistSkipCount + 1
			return false
		end
		return true
	end

	if (not isMT and MainAssist and UnitName(MainAssist.unit) == MainAssist.name) then
		valid = ValidTarget(MainAssist.unit.."target")
		if (valid and valid == "valid") then
			if (not Skip()) then
				TargetUnit(MainAssist.unit.."target")
				return
			end
		end
	end

	-- First scan the list of Main Tanks and pick one of their targets if it's health is greater than 10%
	for i,id in pairs(MainTanks) do
		local unit = "raid"..id[1]

		valid = ValidTarget(unit.."target")

		if (valid) then
			if (valid == "minor") then
				minorUnit = unit
				if (not Skip()) then
					break
				end
			else
				if (not isMT) then
					if (not Skip()) then
						TargetUnit(unit.."target")
						return
					end
				end
			end
		end
	end

	-- If we're not an MT, then pick one of the MT targets and assist
	if (minorUnit and not isMT) then
		if (not Skip()) then
			TargetUnit(minorUnit.."target")
			return
		end
	else
		-- Otherwise, we're a tank so look for something un-tanked
		for i,unit in pairs(OtherTargetOwners) do
			local valid = ValidTarget(unit.."target")

			if (valid) then
				if (valid == "minor") then
					minorUnit = unit
					if (not Skip()) then
						break
					end
				else
					if (not Skip()) then
						TargetUnit(unit.."target")
						return
					end
				end
			end
		end
	end

	XAssistSkipCount = 0;		-- If we reached here, there was nothing else to find
	if (minorUnit) then
		TargetUnit(minorUnit.."target")
	else
		-- Nothing found so far, scan through party members in case we've pressed the button when not in a raid
		for i = 1,4 do
			local unit = "party"..i.."target"

			local valid = ValidTarget(unit)

			if (valid) then
				TargetUnit(unit.."target")
				break
			end
		end
	end

	XFindUnit()

	if (not UnitName("target")) then
		TargetNearestEnemy()
	end
end

-- XPerl_SetStatDetails
function XPerl_SetStatDetails(id, event)

	if (id and XPerl_Stats_List.shownStats ~= 0) then
		getglobal("XPerl_Stats"..XPerl_Stats_List.shownStats):UnlockHighlight()
	end

	if (id and XPerl_Stats_List.shownStats == id) then
		XPerl_Stats_List.shownStats = 0
		XPerl_Stats_List:Hide()
		return
	end

	if (not id) then
		id = XPerl_Stats_List.shownStats
	end

	local list
	if (id == 1) then	list = XPerl_Stats_List.NoTarget
	elseif (id == 2) then	list = XPerl_Stats_List.NotAssistingMT1
	elseif (id == 3) then	list = XPerl_Stats_List.NotAssistingAnyMT
	elseif (id == 4) then	list = XPerl_Stats_List.HealersOnMT1
	elseif (id == 5) then	list = XPerl_Stats_List.HealersOnOtherMTs
	elseif (id == 6) then	list = XPerl_Stats_List.HealersNotOnMTs
	end

	local text = ""
	for i,unit in pairs(list) do
		local _, class = UnitClass(unit)
		local name = UnitName(unit)
		text = text..XPerlColourTable[class]..name.." "
	end

	getglobal("XPerl_Stats"..id):LockHighlight()
	XPerl_Stats_ListText:SetText(text)

	XPerl_Stats_List.shownStats = id
	XPerl_Stats_List:Show()
end

-- XPerl_Toggle_UseCTRATargets
function XPerl_Toggle_UseCTRATargets()
	if (XPerlConfigHelper.UseCTRATargets == 1) then
		XPerlConfigHelper.UseCTRATargets = 0
	else
		XPerlConfigHelper.UseCTRATargets = 1
	end

	XPerl_MTRosterChanged()
	return true
end

-- XPerl_Toggle_OtherTargets
function XPerl_Toggle_OtherTargets(noChange)
	if (not noChange) then
		if (XPerlConfigHelper.OtherTargetTargets == 1) then
			XPerlConfigHelper.OtherTargetTargets = 0
		else
			XPerlConfigHelper.OtherTargetTargets = 1
		end
	end

	XPerl_MakeTankList()
	XPerl_MakeOtherTargetList()

	XPerl_Frame_ToggleTargets:SetButtonTex()
	return true
end

function XPerl_Toggle_MTTargets(noChange)
	if (not noChange) then
		if (XPerlConfigHelper.MTTargetTargets == 1) then
			XPerlConfigHelper.MTTargetTargets = 0
		else
			XPerlConfigHelper.MTTargetTargets = 1
		end
	end

	XPerl_MakeTankList()
	XPerl_MakeOtherTargetList()

	XPerl_Frame_ToggleMTTargets:SetButtonTex()
	return true
end

-- XPerl_Toggle_ExpandLock
function XPerl_Toggle_ExpandLock(noChange)

	if (not noChange) then
		if (XPerlConfigHelper.ExpandLock == 1) then
			XPerlConfigHelper.ExpandLock = 0
		else
			XPerlConfigHelper.ExpandLock = 1
		end
	end

	if (XPerlConfigHelper.ExpandLock == 1) then
		XPerl_ExpandOthers()
	else
		XPerl_CollapseOthers()
	end

	XPerl_Frame_ExpandLock:SetButtonTex()
end

-- XPerl_Toggle_ToggleLabels
function XPerl_Toggle_ToggleLabels(noChange)

	if (not noChange) then
		if (XPerlConfigHelper.MTLabels == 1) then
			XPerlConfigHelper.MTLabels = 0
		else
			XPerlConfigHelper.MTLabels = 1
		end
	end

	XPerl_MakeTankList()
	XPerl_MakeOtherTargetList()

	XPerl_Frame_ToggleLabels:SetButtonTex()

	return true
end

function XPerl_Toggle_ShowMT(noChange)
	if (not noChange) then
		if (XPerlConfigHelper.ShowMT == 1) then
			XPerlConfigHelper.ShowMT = 0
		else
			XPerlConfigHelper.ShowMT = 1
		end
	end

	XPerl_MakeTankList()
	XPerl_MakeOtherTargetList()

	XPerl_Frame_ToggleShowMT:SetButtonTex()

	return true
end

-- XPerl_Toggle_CollectOtherTargets
function XPerl_Toggle_CollectOtherTargets(noChange)

	if (not noChange) then
		if (XPerlConfigHelper.CollectOtherTargets == 1) then
			XPerlConfigHelper.CollectOtherTargets = 0
		else
			XPerlConfigHelper.CollectOtherTargets = 1
		end
	end

	XPerl_MakeOtherTargetList()

	return true
end

-- XPerl_SetFind
function XPerl_SetFind(msg)

	local name = ""
	local any
	for x in string.gfind(msg, "[^ ]+") do
		if (any) then
			if (name ~= "") then
				name = name.." "
			end
			name = name..x
		end
		any = true
	end

	XFind = name

	if (XFind == "") then
		XFind = nil
		XPerl_Message("Find |c00FF0000cleared!|r")
	else
		XPerl_Message("Find set to |c0000FF00"..name.."|r. ('|c00007F00/xp find|r' to clear).")
	end

	return true
end

-- SmoothBarColor
local function SmoothBarColor(bar, barBG)
	local barmin, barmax = bar:GetMinMaxValues()
	local percentage = (bar:GetValue()/(barmax-barmin))

	local r, g
	if (percentage < 0.5) then
		r = 2*percentage
		g = 1
	else
		r = 1
		g = 2*(1 - percentage)
	end

	if ((r>=0) and (g>=0) and (r<=1) and (g<=1)) then
		bar:SetStatusBarColor(r, g, 0)
		barBG:SetVertexColor(r, g, 0, 0.25)
	end
end

-- Redo some of this stuff. too much duplication and work on each frame
local function SetBarToTitle(bar)
	local offset = XPerl_Frame_Title:GetStringWidth() + 25
	bar:SetScale(0.75);		-- Scale it down for the font size
	bar:SetParent(XPerl_Frame_TitleBar)
	bar:Show()
	bar:ClearAllPoints()
	bar:SetPoint("TOPLEFT", XPerl_Frame_TitleBar, "TOPLEFT", offset / 0.75, -3)
	bar:SetPoint("BOTTOMRIGHT", XPerl_Frame_ToggleShowMT, "BOTTOMLEFT", -5, 2)
end

local function SetBarToFrame(bar)
	bar:SetScale(0.75)
	bar:SetParent(XPerl_Threat)
	bar:Show()
	bar:ClearAllPoints()
	bar:SetPoint("TOPLEFT", 3, -3)
	bar:SetPoint("BOTTOMRIGHT", -3, 3)
end

-- XPerl_UpdateThreat
local lastThreat = -1
local lastThreat100
function XPerl_UpdateThreat()

	local data, playerCount, threat100 = KLHTM_GetRaidData()
	if (threat100 > 0) then
		local userThreat = klhtm.table.raiddata[UnitName("player")] or 0

		if (userThreat == lastThreat and threat100 == lastThreat100) then
			return
		else
			lastThreat = userThreat
			lastThreat100 = threat100

			if (data[1].name == "Aggro Gain") then
				playerCount = playerCount - 1
			end

			if (playerCount > 1) then
				local titleSpace = (XPerl_Frame_ToggleShowMT:GetLeft() - XPerl_Frame_Title:GetLeft()) - (XPerl_Frame_Title:GetStringWidth() + 25)

				XPerl_MyThreatText:SetText(userThreat - threat100)		-- Show deficit threat value

				XPerl_MyThreat:SetMinMaxValues(0, threat100)
				XPerl_MyThreat:SetValue(userThreat)

				if (titleSpace >= 10) then
					SetBarToTitle(XPerl_MyThreat)
					XPerl_Threat:Hide()
					XPerl_Threat:SetHeight(2)
				else
					SetBarToFrame(XPerl_MyThreat)
					XPerl_Threat:Show()
					XPerl_Threat:SetHeight(12)
				end

				SmoothBarColor(XPerl_MyThreat, XPerl_MyThreatBG)
				return
			end
		end
	end

	if (lastThreat) then
		XPerl_Threat:Hide()
		XPerl_Threat:SetHeight(2)
		XPerl_MyThreat:Hide()
		lastThreat = nil
		lastThreat100 = nil
	end
end

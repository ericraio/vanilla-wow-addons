local XPerl_Raid_Events = {}
local RaidGroupCounts = {0,0,0,0,0,0,0,0,0}
local FrameArray = {}
local PulloutFrameArray = {}
local perlSetupDone = nil
local ResArray = {}
local MovingMember = nil
local RosterUpdate = nil
local RaidPositions = {}
local oldRaidFrameDropDown_Initialize

XPERL_RAIDGRP_PREFIX	= "XPerl_Raid_Grp"
XPERL_RAIDMEMBER_PREFIX = "XPerl_raid"

local CELL_MOTION_SPEED		= 0.8		-- Motion offset mulitplied by this per frame (TODO, make this time based)

-- Hold some raid roster information (AFK, DND etc.)
-- Is also stored between sessions to maintain timers and flags
XPerl_Roster = {}
local Last_Roster = {}

-- Uses some variables from FrameXML\RaidFrame.lua:
-- MAX_RAID_MEMBERS = 40
-- NUM_RAID_GROUPS = 8
-- MEMBERS_PER_RAID_GROUP = 5

-- This array will be built up on the fly whenever we pick up a localized class name that we don't already have.
-- The UnitClass function returns both english and localized versions, so it won't matter where the mod is run.
local ClassNames = {}

----------------------
-- Loading Function --
----------------------

-- XPerl_Raid_OnLoad
function XPerl_Raid_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("RAID_ROSTER_UPDATE")
	this:RegisterEvent("ADDON_LOADED")
	this.time = 0
	this.Array = {}
end

-- GetRaidGroup
local function GetRaidGroup(num, createIfAbsent)
	local frame = getglobal(XPERL_RAIDGRP_PREFIX..num)

	if (not frame and createIfAbsent) then
		frame = CreateFrame("Frame", XPERL_RAIDGRP_PREFIX..num, XPerl_Raid_Frame, "XPerl_Raid_TitleFrameTemplate")
		frame:SetScale(XPerlConfig.Scale_Raid)

		frame = getglobal(XPERL_RAIDGRP_PREFIX..num.."_NameFrame_NameBarText")
		frame:SetText("Group "..num)
	end

	return frame
end

-- Setup1RaidFrame
local function Setup1RaidFrame(frame)
	local frameStats = getglobal(frame:GetName().."_StatsFrame")
	local frameMana = getglobal(frame:GetName().."_StatsFrame_ManaBar")

	if (XPerlConfig.RaidMana == 1) then
		frameStats:SetHeight(30)
		frameMana:Show()
	else
		frameStats:SetHeight(25)
		frameMana:Hide()
	end
end

-- GetRaidUnit
local function GetRaidUnit(num, createIfAbsent)
	local frame = getglobal(XPERL_RAIDMEMBER_PREFIX..num)

	if (not frame and createIfAbsent) then
		frame = CreateFrame("Frame", XPERL_RAIDMEMBER_PREFIX..num, XPerl_Raid_Frame, "XPerl_Raid_FrameTemplate")

		frame:SetScale(XPerlConfig.Scale_Raid)
		Setup1RaidFrame(frame)
	end

	return frame
end

-- Non local by request
Perl_Raid_FindID = XPerl_Frame_FindID

local function Perl_Raid_FindNum(partyid)
	local _, _, num = strfind(partyid, "(%d+)")
	return tonumber(num)
end

local function Spacing()
	return XPerlConfig.RaidVerticalSpacing + ((-1 + XPerlConfig.RaidMana) * 5)
end

-- XPerl_Raid_Group_OnLoad
function XPerl_Raid_Group_OnLoad()
	local id = XPerl_Frame_FindID(this)
	this:SetID(id)

	local x, y
	if (XPerlConfig.RaidPositions) then
		local pos = XPerlConfig.RaidPositions[this:GetName()]

		if (pos and pos.left and pos.top) then
			x = pos.left
			y = pos.top
		end
	end

	if (not (x and y)) then
		y = 565
		x = (id - 1) * 77
	end

	this:ClearAllPoints()
	this:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)

	function this:SavePosition()
		XPerlConfig.RaidPositions[this:GetName()] = {top = this:GetTop(), left = this:GetLeft()}
	end
end

-- SaveAllPositions
local function SaveAllPositions()
	for i = 1,NUM_RAID_GROUPS do
		local frame = GetRaidGroup(i)
		if (frame) then
			XPerlConfig.RaidPositions[frame:GetName()] = {top = frame:GetTop(), left = frame:GetLeft()}
		end
	end
end

-- XPerl_Raid_Single_OnLoad
function XPerl_Raid_Single_OnLoad()
	if (strsub(this:GetName(), 1, 5) == "XPerl") then
		local id = XPerl_Frame_FindID(this)
		this:SetID(id)

		this.partyid = "raid"..this:GetID()

		FrameArray[this.partyid] = this
	else
		this:SetID(99)
	end

	this.showing = 0

	XPerl_RegisterHighlight(getglobal(this:GetName().."_CastClickOverlay"), 2)
	XPerl_RegisterPerlFrames(this, {"NameFrame", "StatsFrame"})

	this.FlashFrames = {getglobal(this:GetName().."_NameFrame"), getglobal(this:GetName().."_StatsFrame")}
end

local events = {"UNIT_FACTION", "UNIT_FLAGS", "UNIT_DYNAMIC_FLAGS", "UNIT_AURA",
		"UNIT_SPELLMISS", "CHAT_MSG_ADDON", "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER",
		"CHAT_MSG_PARTY"}

-- XPerl_Raid_RegisterSome
local function XPerl_Raid_RegisterSome()
	for i,event in pairs(events) do
		this:RegisterEvent(event)
	end
	XPerl_RegisterBasics()
	this:UnregisterEvent("UNIT_LEVEL")	-- Don't care about player level
end

-- XPerl_Raid_UnregisterSome
local function XPerl_Raid_UnregisterSome()
	for i,event in pairs(events) do
		this:UnregisterEvent(event)
	end
	XPerl_UnregisterBasics()
end

-- XPerl_Raid_UpdateName
local function XPerl_Raid_UpdateName(thisFrame)
	local name = UnitName(thisFrame.partyid)

	if (name or thisFrame.pet) then
		local frame = getglobal(thisFrame:GetName().."_NameFrame_NameBarText")
		local frameParent = getglobal(thisFrame:GetName().."_NameFrame")

		if (thisFrame.pet and name) then
			thisFrame.petname = name	-- Store it for when pet is absent
		end

		if (not name) then
			if (thisFrame.petname) then
				name = thisFrame.petname
			else
				name = UnitName(thisFrame.petOwner).."'s "..PET
			end
		end

                frame:SetText(name)

		local remCount = 1
		while ((frame:GetStringWidth() >= (frameParent:GetWidth() - 6)) and (string.len(name) > remCount)) do
			name = string.sub(name, 1, string.len(name) - remCount)..".."
			remCount = 3
			frame:SetText(name)
		end

		if (thisFrame.pet) then
			color = XPerlConfig.ColourReactionNone
			frame:SetTextColor(color.r, color.g, color.b)
		else
			XPerl_ColourFriendlyUnit(frame, thisFrame.partyid)
		end
	end
end

-- XPerl_Raid_CheckFlags
local function XPerl_Raid_CheckFlags(partyid)

	local unitName = UnitName(partyid)
	local resser

	for i,name in pairs(ResArray) do
		if (name == unitName) then
			resser = i
			break
		end
	end

	if (resser) then
		-- Verify they're dead..
		if (UnitIsDeadOrGhost(partyid)) then
			return {flag = resser.." ressing", bgcolor = {r = 0, g = 0.5, b = 1}}
		end

		ResArray[resser] = nil
	end

	local unitInfo = XPerl_Roster[unitName]
	if (unitInfo) then
		if (unitInfo.afk) then
			return {flag = "AFK"}

		elseif (unitInfo.dnd) then
			return {flag = "DND"}

		elseif (unitInfo.ressed) then
			if (UnitIsDead(partyid)) then
				if (unitInfo.ressed == 2) then
					return {flag = XPERL_LOC_SS_AVAILABLE, bgcolor = {r = 0, g = 1, b = 0.5}}
				else
					return {flag = XPERL_LOC_RESURRECTED, bgcolor = {r = 0, g = 0.5, b = 1}}
				end
			else
				unitInfo.ressed = nil
				XPerl_Raid_UpdateManaType(FrameArray[partyid], true)
			end
		end
	end
end

-- XPerl_Raid_UpdateManaType
function XPerl_Raid_UpdateManaType(thisFrame, skipFlags)
	local flags
	if (not skipFlags) then
		flags = XPerl_Raid_CheckFlags(thisFrame.partyid)
	end
	if (not flags) then
		if (XPerlConfig.RaidMana == 1) then
			local frame = getglobal(thisFrame:GetName().."_StatsFrame_ManaBar")
			local frameBG = getglobal(thisFrame:GetName().."_StatsFrame_ManaBarBG")
			XPerl_SetManaBarType(thisFrame.partyid, frame, frameBG)
		end
	end
end

-- XPerl_Raid_ShowFlags
local function XPerl_Raid_ShowFlags(thisFrame, flags)
	--thisFrame.flags = flags
	local f, color, bgcolor

	if (flags.bgcolor) then
		bgcolor = flags.bgcolor
	else
		bgcolor = {r = 0.5, g = 0.5, b = 0.5}
	end

	if (flags.color) then
		color = flags.color
	else
		color = {r = 1, g = 1, b = 1}
	end

	f = getglobal(thisFrame:GetName().."_StatsFrame_HealthBar"); if (f) then f:SetStatusBarColor(bgcolor.r, bgcolor.g, bgcolor.b); end
	f = getglobal(thisFrame:GetName().."_StatsFrame_HealthBarBG"); if (f) then f:SetVertexColor(bgcolor.r, bgcolor.g, bgcolor.b, 0.5); end
	f = getglobal(thisFrame:GetName().."_StatsFrame_ManaBar"); if (f) then f:SetStatusBarColor(bgcolor.r, bgcolor.g, bgcolor.b); end
	f = getglobal(thisFrame:GetName().."_StatsFrame_ManaBarBG"); if (f) then f:SetVertexColor(bgcolor.r, bgcolor.g, bgcolor.b, 0.5); end
	f = getglobal(thisFrame:GetName().."_StatsFrame_HealthBarText")
	if (f) then
		f:SetText(flags.flag)
		f:SetTextColor(color.r, color.g, color.b)
	end
end

-- XPerl_IsFeignDeath(unit)
function XPerl_IsFeignDeath(unit)
	for i = 1,20 do
		local buff = UnitBuff(unit, i)

		if (buff) then
			if (strfind(strlower(buff), "feigndeath")) then
				return true
			end
		else
			break
		end
	end
end

-- XPerl_Raid_UpdateHealth
local function XPerl_Raid_UpdateHealth(thisFrame)
	local partyid = thisFrame.partyid
	local health = UnitHealth(partyid)
	local healthmax = UnitHealthMax(partyid)
	local healthBar = getglobal(thisFrame:GetName().."_StatsFrame_HealthBar")
	local frameText = getglobal(thisFrame:GetName().."_StatsFrame_HealthBarText")

	healthBar:SetMinMaxValues(0, healthmax)
	if (XPerlConfig.InverseBars == 1) then
		healthBar:SetValue(healthmax - health)
	else
		healthBar:SetValue(health)
	end

	local name = UnitName(partyid)
	local myRoster = XPerl_Roster[name]
	local feigning
	if (name and UnitIsConnected(partyid)) then
		if (myRoster and myRoster.fd and health > 0) then
			-- Seems we don't always get the UNIT_AURA messages, so we'll check their health on updates.
			-- health > 0 means they can't be FD
			myRoster.fd = nil
		end

		local flags = XPerl_Raid_CheckFlags(partyid)
		if (flags) then
			XPerl_Raid_ShowFlags(thisFrame, flags)

			if (UnitIsDeadOrGhost(partyid)) then
				thisFrame.dead = true
				XPerl_Raid_UpdateName(thisFrame)
			end
			return

		elseif (UnitIsDead(partyid) or myRoster and myRoster.fd) then
			if (myRoster and myRoster.fd) then		--XPerl_IsFeignDeath(partyid)) then
				feigning = true

	        		healthBar:SetMinMaxValues(0, 1)
	        		healthBar:SetValue(0)
				frameText:SetText(XPERL_LOC_FEIGNDEATH)
				XPerl_SetSmoothBarColor(healthBar, 0)
			else
				thisFrame.dead = true
				XPerl_Raid_ShowFlags(thisFrame, {flag = XPERL_LOC_DEAD})
				XPerl_Raid_UpdateName(thisFrame)
			end

		elseif (UnitIsGhost(partyid)) then
			thisFrame.dead = true
			XPerl_Raid_ShowFlags(thisFrame, {flag = XPERL_LOC_GHOST})
			XPerl_Raid_UpdateName(thisFrame)

		else
			if (thisFrame.dead or (myRoster and (myRoster.fd or myRoster.ressed))) then
				XPerl_Raid_UpdateManaType(thisFrame, true)
			end
			thisFrame.dead = nil

			local percentHp = health / healthmax
			local phealthPct = string.format("%3.0f", percentHp * 100)

			if (XPerlConfig.HealerMode == 1) then
				frameText:SetText(-(healthmax - health))
			else
				frameText:SetText(phealthPct.."%")
			end

			XPerl_SetSmoothBarColor(healthBar, percentHp)

			if (myRoster) then
				myRoster.resCount = nil
				if (myRoster.ressed) then
					myRoster.ressed = nil
					XPerl_Raid_UpdateManaType(thisFrame, true)
				end
			end
		end
	else
		thisFrame.dead = nil
		XPerl_Raid_ShowFlags(thisFrame, {flag = XPERL_LOC_OFFLINE})

		if (name and myRoster and not myRoster.offline) then
			myRoster.offline = GetTime()
			myRoster.afk = nil
			myRoster.dnd = nil
		end
	end

	if (myRoster) then
		if (not feigning) then
			myRoster.fd = nil
		end
	end
end

-- XPerl_Raid_UpdateMana
local function XPerl_Raid_UpdateMana(thisFrame)
	local mana = UnitMana(thisFrame.partyid)
	local manamax = UnitManaMax(thisFrame.partyid)

	local manaBar = getglobal(thisFrame:GetName().."_StatsFrame_ManaBar")
	local manaBarText = getglobal(thisFrame:GetName().."_StatsFrame_ManaBarText")

	if (UnitPowerType(thisFrame.partyid) == 0 and not thisFrame.pet) then
		local pmanaPct = (mana * 100.0) / manamax
		manaBarText:SetText(string.format("%3.0f%%", pmanaPct))
	else
		manaBarText:SetText("")
	end

	manaBar:SetMinMaxValues(0, manamax)
	manaBar:SetValue(mana)
end

-- XPerl_Raid_CombatFlash
local function XPerl_Raid_CombatFlash(thisFrame, elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet (elapsed, thisFrame, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(thisFrame)
	end
end

-- UpdateUnitByName
local function UpdateUnitByName(name,flagsOnly)
	local id = XPerl_GetRaidPosition(name)
	if (id) then
		local frame = FrameArray["raid"..id]
		if (frame) then
			if (flagsOnly) then
				XPerl_Raid_UpdateHealth(frame)
			else
				XPerl_Raid_UpdateDisplay(frame)
			end
		end

		for k,v in pairs(PulloutFrameArray) do
			if (v.partyid == "raid"..id) then
				if (flagsOnly) then
					XPerl_Raid_UpdateHealth(frame)
				else
					XPerl_Raid_UpdateDisplay(frame)
				end
			end
		end
	end
end

-- Raid_Motion
local function Raid_Motion(cell)

	local motion = cell.motion

	motion.currentLeft = motion.currentLeft * CELL_MOTION_SPEED
	if (motion.currentLeft > -1 and motion.currentLeft < 1) then
		motion.currentLeft = 0
	end

	motion.currentTop = motion.currentTop * CELL_MOTION_SPEED
	if (motion.currentTop > -1 and motion.currentTop < 1) then
		motion.currentTop = 0
	end

	cell:ClearAllPoints()
	if (XPerlConfig.RaidUpward == 1) then
		cell:SetPoint("BOTTOMLEFT", motion.parent, "TOPLEFT", motion.currentLeft, motion.targetTop - motion.currentTop)
	else
		cell:SetPoint("TOPLEFT", motion.parent, "BOTTOMLEFT", motion.currentLeft, motion.targetTop + motion.currentTop)
	end

	if (motion.currentLeft == 0 and motion.currentTop == 0) then
		cell.motion = nil
	end
end

-------------------
-- Raid movement --
-------------------

-- XPerl_Raid_StartMovingMember
function XPerl_Raid_StartMovingMember()

	if (not MovingMember) then
		local frame = this:GetParent()

		if (frame:GetID() ~= 99) then
			HideDropDownMenu(1)
			MovingMember = frame
        		frame:StartMoving()
			frame:SetAlpha(XPerlConfig.Transparency / 2)
			XPerl_RaidTitles()
		end
	end
end

-- XPerl_Raid_CheckMovingMember
local function XPerl_Raid_CheckMovingMember()

	local x = MovingMember:GetLeft() + ((MovingMember:GetRight() - MovingMember:GetLeft()) / 2)
	local y = MovingMember:GetBottom() + ((MovingMember:GetTop() - MovingMember:GetBottom()) / 2)

	XPerl_Raid_Mover:ClearAllPoints()
	XPerl_Raid_Mover:Hide()
	XPerl_Raid_Mover:SetScale(XPerlConfig.Scale_Raid)

	for i,cell in pairs(FrameArray) do
		getglobal(cell:GetName().."_CastClickOverlay"):UnlockHighlight()
	end

	local name = UnitName(MovingMember.partyid)
	local spacing = Spacing()

	for i = 1,NUM_RAID_GROUPS do
		if (i ~= RaidPositions[name].group) then
			local frame = GetRaidGroup(i, true)

			if (frame) then
				local left = (frame:GetLeft() or 0)
				local right = (frame:GetRight() or 0)
				local top
				if (XPerlConfig.RaidUpward == 1) then
					top = frame:GetTop() or 0
				else
					top = frame:GetBottom() or 0
				end
				if (left) then
					local bottom
					if (XPerlConfig.RaidUpward == 1) then
						bottom = top + (MEMBERS_PER_RAID_GROUP * spacing)
						local t = top
						top = bottom
						bottom = t
					else
						bottom = top - (MEMBERS_PER_RAID_GROUP * spacing)
					end

					if (x >= left and x <= right and y >= bottom and y <= top) then
						if (XPerlConfig.RaidUpward == 1) then
							XPerl_Raid_Mover:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
							XPerl_Raid_Mover:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -(bottom - top))
						else
							XPerl_Raid_Mover:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0)
							XPerl_Raid_Mover:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, (bottom - top))
						end
						XPerl_Raid_Mover:Show()

						local size = (bottom - top) / 5
						local sub = math.floor((y - top - size) / size) + 2
						if (sub < 1) then
							sub = 1
						elseif (sub > 5) then
							sub = 5
						end

						if (XPerlConfig.RaidUpward == 1) then
							sub = 6 - sub
						end

						for j,cell in pairs(FrameArray) do
							local pos = RaidPositions[UnitName(cell.partyid)]

							if (pos and cell ~= MovingMember and pos.group == i and pos.row == sub) then
								getglobal(cell:GetName().."_CastClickOverlay"):LockHighlight()
								break
							end
						end
						return i, sub
					end
				end
			end
		end
	end
end

-- XPerl_Raid_StopMovingMember
function XPerl_Raid_StopMovingMember(commit)
	if (MovingMember) then
		local good
		MovingMember:StopMovingOrSizing()

		if (commit) then
			local group,subpos = XPerl_Raid_CheckMovingMember()

--ChatFrame7:AddMessage("group "..(group or "nil").."   row "..(subpos or "nil"))

			if (group) then
				local pos = RaidPositions[UnitName(MovingMember.partyid)]
				if (pos and group ~= pos.group) then
					local unit
					for i,cell in pairs(FrameArray) do
						local cellPos = RaidPositions[UnitName(cell.partyid)]
						if (cellPos and cellPos.group == group and cellPos.row == subpos) then
							unit = cell
							break
						end
					end

					local index = Perl_Raid_FindNum(MovingMember.partyid)

--ChatFrame7:AddMessage("  index "..(index or "nil"))

					if (unit) then
						local targetIndex = Perl_Raid_FindNum(unit.partyid)
--ChatFrame7:AddMessage("  targetIndex "..(targetIndex or "nil"))
						SwapRaidSubgroup(index, targetIndex)
					else
       						SetRaidSubgroup(index, group)
					end
					good = true
				else
--ChatFrame7:AddMessage("Cancelled, same as my current group")
				end
			else
--ChatFrame7:AddMessage("Cancelled, no group")
			end
		end

		for i,cell in pairs(FrameArray) do
			getglobal(cell:GetName().."_CastClickOverlay"):UnlockHighlight()
		end

		if (not good) then
			local pos = RaidPositions[UnitName(MovingMember.partyid)]
			if (pos) then
				local parentGroup = GetRaidGroup(pos.group)
				MovingMember:ClearAllPoints()
				if (XPerlConfig.RaidUpward == 1) then
					MovingMember:SetPoint("BOTTOMLEFT", parentGroup, "TOPLEFT", 0, -2 + ((pos.row - 1) * Spacing()))
				else
					MovingMember:SetPoint("TOPLEFT", parentGroup, "BOTTOMLEFT", 0, 2 - ((pos.row - 1) * Spacing()))
				end
			end
		end

		if (UnitIsConnected(MovingMember.partyid)) then
			MovingMember:SetAlpha(XPerlConfig.Transparency)
		else
			MovingMember:SetAlpha(XPerlConfig.Transparency / 2)
		end

		MovingMember = nil
		XPerl_RaidTitles()

		XPerl_Raid_Mover:Hide()
	end
end

-- XPerl_Raid_OnUpdate
-- 1.8.3 Converted OnUpdate to 1 single routine for all frames, instead of calling
-- potentially the same function 40 times Globally, this is more efficient on time
-- and memory usage. It does remove from the concept of object oriented updates
-- and such, but X-Perl is a rather intensive mod that is the focus of much of the
-- user interface, so I felt it was important to be over cautious.
function XPerl_Raid_OnUpdate()
	if (RosterUpdate) then
		RosterUpdate = nil

		XPerl_Raid_Position()
		if (GetNumRaidMembers() == 0) then
			ResArray = {}
			XPerl_Roster = {}
			RaidPositions = {}
		end
	end

	local updateTanker
	if (XPerlConfig.RaidHighlightTanker == 1) then
		if arg1 then this.time = this.time + arg1; end
		if this.time >= 0.2 then
			this.time = 0
			updateTanker = true
		end
	end

	for i,frame in pairs(FrameArray) do
		if (frame.showing == 1) then
			if (frame.PlayerFlash) then
				XPerl_Raid_CombatFlash(frame, arg1, false)		-- << Frame
			end

			if (frame.motion) then
				Raid_Motion(frame)
			end

			if (updateTanker) then
				local set
				if (UnitExists("target")) then
					if (UnitCanAttack("player", "target")) then
						if (UnitInRaid("targettarget")) then
							set = UnitIsUnit("targettarget", frame.partyid)
						end
					elseif (UnitCanAttack("player", "targettarget")) then
						if (UnitInRaid("targettargettarget")) then
							set = UnitIsUnit("targettargettarget", frame.partyid)
						end
					end
				end

				local highlightFrame = getglobal(frame:GetName().."_CastClickOverlay")
				if (XPerlConfig.HighlightSelection == 0) then
					if (set) then
						highlightFrame:SetHighlightTexture("Interface\\Addons\\XPerl\\Images\\XPerl_Highlight", "ADD")
						local tex = highlightFrame:GetHighlightTexture(); tex:SetTexCoord(0.25, 0.75, 0, 0.5)
						tex:SetVertexColor(0.86, 0.82, 0.41)
					else
						highlightFrame:SetHighlightTexture("")
					end
				else
					highlightFrame:SetHighlightTexture("Interface\\Addons\\XPerl\\Images\\XPerl_Highlight", "ADD")
					local tex = highlightFrame:GetHighlightTexture(); tex:SetTexCoord(0.25, 0.75, 0, 0.5)
					tex:SetVertexColor(0.86, 0.82, 0.41)
				end

				if (set) then
					highlightFrame:LockHighlight()
				else
					highlightFrame:UnlockHighlight()
				end
			end
		end
	end

	if (MovingMember) then
		XPerl_Raid_CheckMovingMember()
	end
end

-- GetBuffButton(thisFrame, buffnum, debuff, createIfAbsent)
-- debuff must be 1 or 0, as it's used in size calc
local function GetBuffButton(thisFrame, buffnum, createIfAbsent)

	local name = thisFrame:GetName().."_BuffFrame_Buff"..buffnum
	local button = getglobal(name)

	if (not button and createIfAbsent) then
		button = CreateFrame("Button", name, getglobal(thisFrame:GetName().."_BuffFrame"), "XPerl_BuffTemplate")
		button:SetID(buffnum)

		button:SetHeight(10)
		button:SetWidth(10)

		local icon = getglobal(name.."Icon")
		icon:SetTexCoord(0.078125, 0.921875, 0.078125, 0.921875)

		button:SetScript("OnEnter", XPerl_Raid_SetBuffTooltip)
		button:SetScript("OnLeave", XPerl_PlayerTipHide)
	end

	return button
end

-- GetShowCast
local function GetShowCast(thisFrame)
	local show,cureCast
	if (thisFrame:GetID() == 99) then
		-- Pullout frames all have ID 99
		local RaidPullout = thisFrame:GetParent()

		if (RaidPullout.showBuffs == 1) then
			show = "b"
		else
			show = "d"
		end
		if (RaidPullout.cureCast) then
			cureCast = 1
		else
			cureCast = 0
		end
	else
		if (XPerlConfig.RaidBuffs == 1) then
			show = "b"
		elseif (XPerlConfig.RaidDebuffs == 1) then
			show = "d"
		end
		cureCast = XPerlConfig.BuffsCastableCurable
	end

	return show,cureCast
end

-- UpdateBuffs
local function UpdateBuffs(thisFrame)
	local partyid = thisFrame.partyid
	local cursed, color = XPerl_CheckDebuffs(partyid, {getglobal(thisFrame:GetName().."_NameFrame"), getglobal(thisFrame:GetName().."_StatsFrame")})

	local frameText = getglobal(thisFrame:GetName().."_NameFrame_NameBarText")
	if (cursed) then
		frameText:SetTextColor(1,0,0)
	else
		XPerl_ColourFriendlyUnit(frameText, partyid)
	end

	local buffCount = 0
	local maxBuff = 8 - ((abs(1 - XPerlConfig.RaidMana) * 2) * XPerlConfig.RaidBuffsRight)

	local show, cureCast = GetShowCast(thisFrame)
	if (show) then
		for buffnum=1,maxBuff do
			local buff, count
			if (show == "b") then
				buff = XPerl_UnitBuff(partyid, buffnum, cureCast)
			else
				buff = XPerl_UnitDebuff(partyid, buffnum, cureCast)
			end
			local button = GetBuffButton(thisFrame, buffnum, buff)	-- 'buff' flags whether to create icon
			if (button) then
				local icon = getglobal(button:GetName().."Icon")

				if (buff) then
					buffCount = buffCount + 1

					icon:SetTexture(buff)
					button:Show()
				else
					button:Hide()
				end
			end
		end
		for buffnum=maxBuff+1,8 do
                        local button = getglobal(thisFrame:GetName().."_BuffFrame_Buff"..buffnum)
			if (button) then
				button:Hide()
			end
		end
	end

	--local myRoster = XPerl_Roster[UnitName(partyid)]
	--if (myRoster and XPerlConfig.RaidBuffs == 1 and buffCount == 0 and cureCast == 0) then
	--	if (UnitIsConnected(partyid)) then
	--		-- Already scanned raid buffs and there are none
	--		myRoster.Buffs = nil
	--	end
	--else
	--	CheckRosterBuffs(partyid)
	--end

	local buffFrame = getglobal(thisFrame:GetName().."_BuffFrame")
	local nameFrame = getglobal(thisFrame:GetName().."_NameFrame")
	local statsFrame = getglobal(thisFrame:GetName().."_StatsFrame")

	if (buffCount > 0) then
		buffFrame:ClearAllPoints()
		buffFrame:Show()
		local id = thisFrame:GetID()

		if (XPerlConfig.RaidBuffsRight == 1 or id == 99) then
			buffFrame:SetPoint("BOTTOMLEFT", thisFrame:GetName().."_StatsFrame", "BOTTOMRIGHT", -2, 2)

			if (XPerlConfig.RaidBuffsInside == 1 and id ~= 99) then
				if (buffCount > 5 + XPerlConfig.RaidMana) then
					nameFrame:SetWidth(60)
				elseif (buffCount > 2) then
					nameFrame:SetWidth(70)
				else
					nameFrame:SetWidth(80)
				end

				if (buffCount > 3 + XPerlConfig.RaidMana) then
					statsFrame:SetWidth(60)
				else
					statsFrame:SetWidth(70)
				end
			else
				nameFrame:SetWidth(80)
				statsFrame:SetWidth(80)
			end

			getglobal(thisFrame:GetName().."_BuffFrame_Buff1"):ClearAllPoints()
			getglobal(thisFrame:GetName().."_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", 0, 0)
			for i = 2,buffCount do
				if (i > buffCount) then break end

				local buffI = getglobal(thisFrame:GetName().."_BuffFrame_Buff"..i)
				buffI:ClearAllPoints()

				if (i == 4 + XPerlConfig.RaidMana) then
					if (XPerlConfig.RaidBuffsInside == 1 and id ~= 99) then
						buffI:SetPoint("BOTTOMLEFT", 0, 0)
						getglobal(thisFrame:GetName().."_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", buffI, "BOTTOMRIGHT", 0, 0)
					else
						buffI:SetPoint("BOTTOMLEFT", thisFrame:GetName().."_BuffFrame_Buff"..(i-(4 - abs(1 - XPerlConfig.RaidMana))), "BOTTOMRIGHT", 0, 0)
					end
				else
					buffI:SetPoint("BOTTOMLEFT", thisFrame:GetName().."_BuffFrame_Buff"..(i-1), "TOPLEFT", 0, 0)
				end
			end
		else
			nameFrame:SetWidth(80)
			statsFrame:SetWidth(80)

			buffFrame:SetPoint("TOPLEFT", thisFrame:GetName().."_StatsFrame", "BOTTOMLEFT", 0, 2)

			local prevBuff
			for i = 1,buffCount do
				local buff = getglobal(thisFrame:GetName().."_BuffFrame_Buff"..i)
				buff:ClearAllPoints()
				if (prevBuff) then
					buff:SetPoint("TOPLEFT", prevBuff, "TOPRIGHT", 0, 0)
				else
					buff:SetPoint("TOPLEFT", 0, 0)
				end
				prevBuff = buff
			end
		end
	else
		nameFrame:SetWidth(80)
		statsFrame:SetWidth(80)
		buffFrame:Hide()
	end

	local myRoster = XPerl_Roster[UnitName(partyid)]
	if (myRoster) then
		local _,class = UnitClass(partyid)
		if (class == "HUNTER") then
			if (XPerl_IsFeignDeath(partyid)) then
				if (not myRoster.fd) then
					myRoster.fd = GetTime()
					XPerl_Raid_UpdateHealth(thisFrame)
				end
			elseif (myRoster.fd) then
				myRoster.fd = nil
				XPerl_Raid_UpdateManaType(thisFrame, true)
			end
		end
	end
end

-- UpdateRosterBuffs
-- Scans a unit's buffs and sets up initial buff time remaining entries
local duplicateTextures = {
	["Interface\\Icons\\Spell_Nature_Regeneration"] = true,
	["Interface\\Icons\\Spell_Nature_LightningShield"] = true
};
local function UpdateRosterBuffs(thisFrame)

	local unit = thisFrame.partyid
	local myRoster = XPerl_Roster[unit]

	if (myRoster) then
		if (not myRoster.Buffs) then
			myRoster.Buffs = {}
		end

		local oldAuras = {}
		for k, v in pairs(myRoster.Buffs) do
			oldAuras[k] = 1
		end

		local num, buff = 0, UnitBuff(unit, 1);
		while (buff) do
			num = num + 1;
			if (not duplicateTextures[buff]) then
				for k, v in pairs(XPerl_CTBuffTextures) do
					if ("Interface\\Icons\\"..v[1] == buff) then
						buffName = k
						break
					end
				end
			else
				PerlBuffStatusTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
				PerlBuffStatusTooltipTextLeft1:SetText("")
				PerlBuffStatusTooltip:SetUnitBuff(unit, num)
				local tooltipName = PerlBuffStatusTooltipTextLeft1:GetText()
				if (strlen(tooltipName or "") > 0 and XPerl_CTBuffTextures[tooltipName]) then
					buffName = tooltipName
				end
			end

			if (buffName) then
				oldAuras[buffName] = nil
				if (not myRoster.Buffs[buffName]) then
					-- We store the fade time of raid member's buffs

					local duration = XPerl_CTBuffTextures[buffName][2]

					if (not duration) then
						duration = 5*60
					end

					myRoster.Buffs[buffName] = GetTime() + duration
				end
			end

			buff = UnitBuff(unit, num + 1)
		end

		for k, v in pairs(oldAuras) do
			myRoster.Buffs[k] = nil
		end
	end
end

-- XPerl_Raid_Update_Control
local function XPerl_Raid_Update_Control(thisFrame)
	if (UnitIsVisible(thisFrame.partyid) and UnitIsCharmed(thisFrame.partyid)) then
		getglobal(thisFrame:GetName().."_NameFrame_Warning"):Show()
	else
		getglobal(thisFrame:GetName().."_NameFrame_Warning"):Hide()
	end
end

-- XPerl_Raid_UpdateCombat
local function XPerl_Raid_UpdateCombat(thisFrame)
	local frame = getglobal(thisFrame:GetName().."_NameFrame_ActivityStatus")
	if (not (frame == nil)) then
	        if (UnitExists(thisFrame.partyid) and UnitAffectingCombat(thisFrame.partyid)) then
	                frame:Show()
		else
	                frame:Hide()
		end
	end
end

-------------------------
-- The Update Function --
-------------------------
function XPerl_Raid_UpdateDisplay(thisFrame)
	if (thisFrame.showing == 1) then
		if (UnitExists(thisFrame.partyid) or thisFrame.pet) then
			if (UnitIsConnected(thisFrame.partyid) and MovingMember ~= thisFrame) then
				thisFrame:SetAlpha(XPerlConfig.Transparency)
			else
				thisFrame:SetAlpha(XPerlConfig.Transparency/2)
				getglobal(thisFrame:GetName().."_StatsFrame_HealthBarText"):SetText("Offine")
			end

			local manaBarText = getglobal(thisFrame:GetName().."_StatsFrame_ManaBarText")
			local healthBarText = getglobal(thisFrame:GetName().."_StatsFrame_HealthBarText")
			if (XPerlConfig.ShowRaidPercents==0) then
				manaBarText:Hide()
				healthBarText:Hide()
			else
				manaBarText:Show()
				healthBarText:Show()
			end

			-- Health must be updated after mana, since ctra flag checks are done here.
			XPerl_Raid_UpdateManaType(thisFrame)
			XPerl_Raid_UpdateMana(thisFrame)
			XPerl_Raid_UpdateHealth(thisFrame)		-- <<< -- AFTER MANA -- <<< --
			XPerl_Raid_UpdateName(thisFrame)
			XPerl_Raid_UpdateCombat(thisFrame)
			XPerl_Raid_Update_Control(thisFrame)
			UpdateBuffs(thisFrame)
		else
			thisFrame:StopMovingOrSizing()
			thisFrame:Hide()
		end
	else
		thisFrame:StopMovingOrSizing()
		thisFrame:Hide()
	end
end

-------------------
-- Event Handler --
-------------------
function XPerl_Raid_OnEvent()
	local func = XPerl_Raid_Events[event]
	if (func) then
		func()
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

function XPerl_Raid_Events:ADDON_LOADED()
	if (arg1 == "Blizzard_RaidUI") then
		if (not oldRaidFrameDropDown_Initialize) then
			oldRaidFrameDropDown_Initialize = RaidFrameDropDown_Initialize
			RaidFrameDropDown_Initialize = XPerl_RaidFrameDropDown_Initialize
		end

		if (CT_RATab_newRaidFrameDropDown_Initialize) then
			if (not oldCT_RATab_newRaidFrameDropDown_Initialize) then
				oldCT_RATab_newRaidFrameDropDown_Initialize = CT_RATab_newRaidFrameDropDown_Initialize
				CT_RATab_newRaidFrameDropDown_Initialize = XPerl_CT_RATab_newRaidFrameDropDown_Initialize
				--RaidFrameDropDown_Initialize = XPerl_CTRaidFrameDropDown_Initialize
			end
		end

		XPerl_ReplaceBlizzardPullouts()
		this:UnregisterEvent("ADDON_LOADED")
	end
end

function XPerl_Raid_Events:VARIABLES_LOADED()
	this:UnregisterEvent("VARIABLES_LOADED")

	XPerl_Raid_RegisterSome()

	if (GetNumRaidMembers() == 0) then
		ResArray = {}
		XPerl_Roster = {}
		RaidPositions = {}
	else
		local myRoster = XPerl_Roster[UnitName("player")]
		if (myRoster) then
			myRoster.afk, myRoster.dnd, myRoster.dnd, myRoster.ressed, myRoster.resCount = nil, nil, nil, nil, nil
		end
	end

	XPerl_ScaleRaid(XPerlConfig.Scale_Raid)
	XPerl_RaidTitles()
end

-- PLAYER_ENTERING_WORLD
function XPerl_Raid_Events:PLAYER_ENTERING_WORLD()
	XPerl_Raid_RegisterSome()

	if (not XPerl_raid1 and GetNumRaidMembers() > 0) then
		XPerl_Raid_Position()
	end
end

-- PLAYER_LEAVING_WORLD
function XPerl_Raid_Events:PLAYER_LEAVING_WORLD()
	XPerl_Raid_UnregisterSome()
end

-- RAID_ROSTER_UPDATE
function XPerl_Raid_Events:RAID_ROSTER_UPDATE()
	if (MovingMember) then
		XPerl_Raid_StopMovingMember()
	end

	if (not XPerl_raid1 or XPerl_raid1.showing == 0) then
		-- If no raid yet, just setup anyway
		XPerl_Raid_Position()
		if (GetNumRaidMembers() == 0) then
			ResArray = {}
			XPerl_Roster = {}
			RaidPositions = {}
		end
		if (XPerl_SendModules) then
			XPerl_SendModules()			-- Let other X-Perl users know which version we're running
		end
	else
		-- Otherwise, we defer the roster update until the next frame for
		-- cases where we get more than 1 RAID_ROSTER_UPDATE per data packet
		RosterUpdate = true
	end
end

-- UNIT_FLAGS
function XPerl_Raid_Events:UNIT_FLAGS()
	local f = FrameArray[arg1]
	if (f) then
		XPerl_Raid_UpdateCombat(f)

		for name,f in pairs(PulloutFrameArray) do
			if (f.partyid == arg1 and f:IsShown()) then
				XPerl_Raid_UpdateCombat(f)
			end
		end
	end
end

XPerl_Raid_Events.UNIT_DYNAMIC_FLAGS = XPerl_Raid_Events.UNIT_FLAGS

-- UNIT_FACTION
function XPerl_Raid_Events:UNIT_FACTION()
	local f = FrameArray[arg1]
	if (f) then
		XPerl_Raid_Update_Control(f)
		XPerl_Raid_UpdateName(f)
	end

	for name,f in pairs(PulloutFrameArray) do
		if (f.partyid == arg1 and f:IsShown()) then
			XPerl_Raid_Update_Control(f)
			XPerl_Raid_UpdateName(f)
		end
	end
end

-- UNIT_COMBAT
function XPerl_Raid_Events:UNIT_COMBAT()
	local f = FrameArray[arg1]
	if (f) then
		if (arg2 == "HEAL") then
			XPerl_Raid_CombatFlash(f, 0, true, true)
		elseif (arg4 and arg4 > 0) then
			XPerl_Raid_CombatFlash(f, 0, true)
		end
	end
end

-- UNIT_HEALTH
function XPerl_Raid_Events:UNIT_HEALTH()
	local f = FrameArray[arg1]
	if (f) then
		XPerl_Raid_UpdateHealth(f)
		XPerl_Raid_UpdateCombat(f)
	end

	for name,f in pairs(PulloutFrameArray) do
		if (f.partyid == arg1 and f:IsShown()) then
			XPerl_Raid_UpdateHealth(f)
		end
	end
end
XPerl_Raid_Events.UNIT_MAXHEALTH = XPerl_Raid_Events.UNIT_HEALTH

function XPerl_Raid_Events:UNIT_DISPLAYPOWER()
	local f = FrameArray[arg1]
	if (f) then
		XPerl_Raid_UpdateManaType(f)
		XPerl_Raid_UpdateMana(f)
	end

	for name,f in pairs(PulloutFrameArray) do
		if (f.partyid == arg1 and f:IsShown()) then
			XPerl_Raid_UpdateManaType(f)
			XPerl_Raid_UpdateMana(f)
		end
	end
end

-- UNIT_MANA
function XPerl_Raid_Events:UNIT_MANA()
	if (XPerlConfig.RaidMana == 1) then
		local f = FrameArray[arg1]
		if (f) then
			XPerl_Raid_UpdateMana(f)
		end

		for name,f in pairs(PulloutFrameArray) do
			if (f.partyid == arg1 and f:IsShown()) then
				XPerl_Raid_UpdateMana(f)
			end
		end
	end
end
XPerl_Raid_Events.UNIT_MAXMANA   = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_RAGE      = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_MAXRAGE   = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_ENERGY    = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_MAXENERGY = XPerl_Raid_Events.UNIT_MANA

-- UNIT_NAME_UPDATE
function XPerl_Raid_Events:UNIT_NAME_UPDATE()
	local f = FrameArray[arg1]
	if (f) then
		XPerl_Raid_UpdateName(f)

		for name,f in pairs(PulloutFrameArray) do
			if (f.partyid == arg1 and f:IsShown()) then
				XPerl_Raid_UpdateName(f)
			end
		end
	end
end

-- UNIT_AURA
function XPerl_Raid_Events:UNIT_AURA()
	local f = FrameArray[arg1]
	if (f) then
		UpdateRosterBuffs(f)
		UpdateBuffs(f)

		for name,f in pairs(PulloutFrameArray) do
			if (f.partyid == arg1 and f:IsShown()) then
				UpdateBuffs(f)
			end
		end
	end
end

-- UNIT_PET
function XPerl_Raid_Events:UNIT_PET()
	if (strsub(arg1, 1, 4) == "raid") then
		for k,v in pairs(PulloutFrameArray) do
			if (v.petOwner == arg1) then
				XPerl_Raid_UpdateDisplay(v)
			end
		end
	end
end

-- SetRes
local function SetResStatus(resserName, resTargetName)

	--frame.beingRessed = true
	local resEnd

	if (resTargetName) then
		ResArray[resserName] = resTargetName
	else
		resEnd = true

		for i,name in pairs(ResArray) do
			if (i == resserName) then
				resTargetName = name
				break
			end
		end

		ResArray[resserName] = nil
	end

	if (resTargetName) then
		if (XPerl_Roster[resTargetName]) then
			if (resEnd) then
				if (not XPerl_Roster[resTargetName].resCount) then
					XPerl_Roster[resTargetName].resCount = 1
				else
					XPerl_Roster[resTargetName].resCount = XPerl_Roster[resTargetName].resCount + 1
				end
			end
			UpdateUnitByName(resTargetName)
		end
	end
end

-- Direct string matches can be done via table lookup
local QuickFuncs = {
	AFK	= function(m)	m.afk = GetTime(); m.dnd = nil; end,
	UNAFK	= function(m)	m.afk = nil; end,
	DND	= function(m)	m.dnd = GetTime(); m.afk = nil; end,
	UNDND	= function(m)	m.dnd = nil; end,
	RESNO	= function(m,n) SetResStatus(n) end,
	RESSED	= function(m)	m.ressed = 1; end,
	CANRES	= function(m)	m.ressed = 2; end,
	NORESSED= function(m)	m.ressed = nil; m.resCount = nil; end,
	SR	= XPerl_SendModules
}

-- ProcessCTRAMessage
local function ProcessCTRAMessage(unitName, msg)
	local myRoster = XPerl_Roster[unitName]

	if (not myRoster) then
		return
	end

	local update = true

	local func = QuickFuncs[msg]
	if (func) then
		func(myRoster, unitName)
	else
		if (strsub(msg, 1, 4) == "RES ") then
			SetResStatus(unitName, strsub(msg, 5))
			return

 		elseif (strsub(msg, 1, 3) == "RN ") then
			-- Buff durations
			local _, _, secsLeft, buffIndex, buffSub = strfind(msg, "^RN ([^%s]+) ([^%s]+) ([^%s]+)$")

			if (secsLeft and buffIndex and buffSub) then
				secsLeft = tonumber(secsLeft)
				buffIndex = tonumber(buffIndex)
				buffSub = tonumber(buffSub)

				local buff = XPerl_CTBuffArray[buffIndex]

				if (buff) then
					local buffName
					-- Shouldn't come with string and sub index > 0, but it does.. Will investigate when and why
					-- Druid Thorns... /shrug
					if (buffSub == 0 or type(buff.name) == "string") then
						buffName = buff.name
					else
						buffName = buff.name[buffSub]
					end

					if (buffName) then
						if (not myRoster.Buffs) then
							myRoster.Buffs = {}
						end
						myRoster.Buffs[buffName] = GetTime() + secsLeft
						--CheckRosterBuffs(unitName)
					end
				end
			end
			update = nil

		elseif (strsub(msg, 1, 3) == "CD ") then
			local _, _, num, cooldown = strfind(msg, "^CD (%d+) (%d+)$")
			if ( num == "1" ) then
				myRoster.Rebirth = GetTime() + tonumber(cooldown)*60
			elseif ( num == "2" ) then
				myRoster.Reincarnation = GetTime() + tonumber(cooldown)*60
			elseif ( num == "3" ) then
				myRoster.Soulstone = GetTime() + tonumber(cooldown)*60
			end
			update = nil

		elseif (strsub(msg, 1, 2) == "V ") then
			myRoster.version = strsub(msg, 3)
			update = nil
		else
			update = nil
		end
	end

	if (update) then
		UpdateUnitByName(unitName)
	end
end

-- ProcessoRAMessage
local function ProcessoRAMessage(unitName, msg)
	local myRoster = XPerl_Roster[unitName]

	if (not myRoster) then
		return
	end

	if (strsub(msg, 1, 5) == "oRAV ") then
		myRoster.oRAversion = strsub(msg, 6)
	end
end

-- XPerl_Raid_Events:CHAT_MSG_RAID
-- Check for AFK/DND flags in chat
function XPerl_Raid_Events:CHAT_MSG_RAID()
	local myRoster = XPerl_Roster[arg4]
	if (myRoster) then
		if (arg6 == "AFK") then
			if (not myRoster.afk) then
				myRoster.afk = GetTime()
				myRoster.dnd = nil
			end
		elseif (arg6 == "DND") then
			if (not myRoster.dnd) then
				myRoster.dnd = GetTime()
				myRoster.afk = nil
			end
		else
			myRoster.dnd, myRoster.afk = nil, nil
		end
	end
end
XPerl_Raid_Events.CHAT_MSG_RAID_LEADER = XPerl_Raid_Events.CHAT_MSG_RAID
XPerl_Raid_Events.CHAT_MSG_PARTY = XPerl_Raid_Events.CHAT_MSG_RAID

-- CHAT_MSG_ADDON
function XPerl_Raid_Events:CHAT_MSG_ADDON()
	XPerl_Raid_Events.CHAT_MSG_RAID()
	if (arg3 == "RAID") then
		if (arg1 == "CTRA") then
			XPerl_ParseCTRA(arg4, arg2, ProcessCTRAMessage)
		elseif (arg1 == "oRA") then
			XPerl_ParseCTRA(arg4, arg2, ProcessoRAMessage)
		end
	end
end

-- SetRaidRoster
local function SetRaidRoster()

	local NewRoster = {}
	Last_Roster = XPerl_Roster

	for i = 1,GetNumRaidMembers() do
		local name = UnitName("raid"..i)

		if (XPerl_Roster[name]) then
			NewRoster[name] = XPerl_Roster[name]
		else
			NewRoster[name] = {}
		end

		if (Last_Roster[name]) then
			if (RaidPositions[name]) then
				Last_Roster[name].lastPos = RaidPositions[name]
			else
				Last_Roster[name].lastPos = nil
			end
		end
	end

	RaidPositions = {}
	XPerl_Roster = NewRoster
end

--------------------
-- Raid Functions --
--------------------

-- MoveCell
local function MoveCell(cell, grp, wasShowing)

	local parentGroup = getglobal(XPERL_RAIDGRP_PREFIX..grp)
	local name = UnitName(cell.partyid)
	local noMotion = true

	if (wasShowing == 1) then
		if (cell.lastPos) then
			if (cell.lastPos.group ~= grp or cell.lastPos.row ~= RaidGroupCounts[grp] + 1) then
				noMotion = false
			end
		end

		local oldCell = Last_Roster[name]
		if (oldCell) then
			if (oldCell.lastPos) then
				if (oldCell.lastPos.group ~= grp or oldCell.lastPos.row ~= RaidGroupCounts[grp] + 1) then
					noMotion = false
				end
			end
		end
	end

	RaidPositions[name] = {group = grp, row = RaidGroupCounts[grp] + 1}

	local t
	if (XPerlConfig.RaidUpward == 1) then
		t = -2 + (RaidGroupCounts[grp] * Spacing())
	else
		t = 2 - (RaidGroupCounts[grp] * Spacing())
	end

	if (cell.motion or (not noMotion and cell.showing == 1 and cell:IsShown() and XPerlConfig.RaidMotion == 1)) then
		if (XPerlConfig.RaidUpward == 1) then
			cell.motion = {
				targetTop = t,
				parent = parentGroup,
				currentLeft = cell:GetLeft() - parentGroup:GetLeft(),
				currentTop = parentGroup:GetTop() - cell:GetBottom() + t
			}
		else
			cell.motion = {
				targetTop = t,
				parent = parentGroup,
				currentLeft = cell:GetLeft() - parentGroup:GetLeft(),
				currentTop = cell:GetTop() - parentGroup:GetBottom() - t
			}
		end
	else
		cell:ClearAllPoints()
		if (XPerlConfig.RaidUpward == 1) then
			cell:SetPoint("BOTTOMLEFT", parentGroup, "TOPLEFT", 0, t)
		else
			cell:SetPoint("TOPLEFT", parentGroup, "BOTTOMLEFT", 0, t)
		end
	end
end

-- XPerl_Raid_Classes
local function XPerl_Raid_Classes()
	local groups = {WARRIOR = 1, MAGE = 2, PRIEST = 3, WARLOCK = 4, DRUID = 5, ROGUE = 6, HUNTER = 7, PALADIN = 8, SHAMAN = 9}

	for num=1,MAX_RAID_MEMBERS do
		local localClass, class = UnitClass("raid"..num)
		if (class) then
			if (not ClassNames[class]) then
				ClassNames[class] = localClass
			end

			local frame = GetRaidUnit(num, true)

			local subgroup = groups[class]
			if (subgroup) then
				if (subgroup == 9) then		-- Burning Crusade - REMOVE THIS
					subgroup = 8
				end

				GetRaidGroup(subgroup, true)
				local wasShowing = frame.showing
				frame.showing = XPerlConfig["ShowGroup"..subgroup]
				MoveCell(frame, subgroup, wasShowing)
				RaidGroupCounts[subgroup] = RaidGroupCounts[subgroup] + 1
			end

		else
			local frame = GetRaidUnit(num)
			if (frame) then
		    		frame.showing = 0
			end
		end
	end

	for name,index in pairs(groups) do
		local frame = getglobal(XPERL_RAIDGRP_PREFIX..index.."_NameFrame_NameBarText")
		if (frame) then
			if (index == 8) then	-- Burning Crusade - REMOVE THIS
				if (UnitFactionGroup("player") == "Horde") then
					frame:SetText(ClassNames["SHAMAN"])
				else
					frame:SetText(ClassNames["PALADIN"])
				end
				break
			end

			frame:SetText(ClassNames[name])
		end
	end
end

-- XPerl_Raid_Groups
local function XPerl_Raid_Groups()
	for num=1,MAX_RAID_MEMBERS do
		local name, rank, subgroup= GetRaidRosterInfo(num)
		if (name and subgroup) then
			local frame = GetRaidUnit(num, true)

			if (frame) then
				GetRaidGroup(subgroup, true)
				local localClass, class = UnitClass("raid"..num)

				if (class and not ClassNames[class]) then
					ClassNames[class] = localClass
				end

				if (name and subgroup and subgroup >= 1 and subgroup <= NUM_RAID_GROUPS) then
					local wasShowing = frame.showing
					frame.showing = XPerlConfig["ShowGroup"..subgroup]
					MoveCell(frame, subgroup, wasShowing)
					RaidGroupCounts[subgroup] = RaidGroupCounts[subgroup] + 1
				else
				    	frame.showing = 0
				end
			end
		else
			local frame = GetRaidUnit(num)
			if (frame) then
				frame.showing = 0
			end
		end
	end

	for index = 1,NUM_RAID_GROUPS do
		local frame = getglobal(XPERL_RAIDGRP_PREFIX..index.."_NameFrame_NameBarText")
		if (frame) then
			frame:SetText(string.format(XPERL_RAID_GROUP, index))
		end
	end
end

-- XPerl_Raid_Position()
function XPerl_Raid_Position()
	SetRaidRoster()
	RaidGroupCounts = {0,0,0,0,0,0,0,0,0}

	if (XPerlConfig.SortRaidByClass==1) then
		XPerl_Raid_Classes()
	else
		XPerl_Raid_Groups()
	end

	if (GetNumRaidMembers() == 0 or XPerlConfig.ShowRaid == 0) then
		XPerl_Raid_Frame:Hide()
	else
		XPerl_Raid_Frame:Show()

		for num=1,MAX_RAID_MEMBERS do
			local frame = getglobal(XPERL_RAIDMEMBER_PREFIX..num)

			if (frame) then
				if (frame.showing == 1) then
					frame:Show()
					XPerl_Raid_UpdateDisplay(frame)
				else
					frame:Hide()
				end
			end
		end
	end

	XPerl_RaidTitles()

	Last_Roster = nil
	for i,unit in XPerl_Roster do
		unit.lastPos = nil
	end
end

--------------------
-- Click Handlers --
--------------------
function XPerl_CT_RATab_newRaidFrameDropDown_Initialize()
	XPerl_RaidFrameDropDown_Initialize(true)
end

function XPerl_RaidFrameDropDown_Initialize(ct)
	if (type(UIDROPDOWNMENU_MENU_VALUE) == "table" and UIDROPDOWNMENU_MENU_VALUE[1] == "Main Tanks") then
		local info = {}
		info.text = XPERL_RAID_DROPDOWN_MAINTANKS
		info.isTitle = 1
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		for i = 1,10 do
			info = {}
			if (XPerl_MainTanks[i] and XPerl_MainTanks[i][2] == UIDROPDOWNMENU_MENU_VALUE[2]) then
				info.text = string.format("|c00FFFF80"..XPERL_RAID_DROPDOWN_REMOVEMT.."|r", i)
				info.value = {UIDROPDOWNMENU_MENU_VALUE[1], UIDROPDOWNMENU_MENU_VALUE[2], i, 1}
			else
				info.text = string.format(XPERL_RAID_DROPDOWN_SETMT, i)
				info.value = {UIDROPDOWNMENU_MENU_VALUE[1], UIDROPDOWNMENU_MENU_VALUE[2], i}
			end
			info.func = XPerl_MainTankSet_OnClick
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		end
		return
	end

	oldRaidFrameDropDown_Initialize()

	if (IsRaidOfficer()) then
		if (DropDownList1.numButtons > 0) then
			-- We want our MT option above the Cancel option, so we trick the menu into thinking it's got 1 less button
			DropDownList1.numButtons = DropDownList1.numButtons - 1
		end

		info = {}
		info.text = XPERL_RAID_DROPDOWN_MAINTANKS
		info.value = {"Main Tanks", this.name}
		info.hasArrow = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)

		-- Re-add the cancel button after our MT option
		info = {}
		info.text = CANCEL
		info.value = "CANCEL"
		info.owner = "RAID"
		info.func = UnitPopup_OnClick
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)
	end

	if (ct and CT_RATab_AutoPromotions) then
		local info = {}
		info.text = "Auto-Promote"
		info.checked = CT_RATab_AutoPromotions[this.name]
		info.value = this.id
		info.func = CT_RATab_AutoPromote_OnClick
		UIDropDownMenu_AddButton(info)
	end
end

-- XPerl_MainTankSet_OnClick
function XPerl_MainTankSet_OnClick()
	if (this.value[1] == "Main Tanks") then
		if (this.value[4]) then
			SendAddonMessage("CTRA", "R "..this.value[2], "RAID")
		else
			SendAddonMessage("CTRA", "SET "..this.value[3].." "..this.value[2], "RAID")
		end
	end
	CloseMenus()
end

-- ShowPopup
local function ShowPopup(thisFrame)
	HideDropDownMenu(1)
	FriendsDropDown.initialize = RaidFrameDropDown_Initialize
	FriendsDropDown.displayMode = "MENU"

	this.unit = thisFrame.partyid
	this.name = UnitName(thisFrame.partyid)

	local _, _, id = strfind(thisFrame.partyid, "(%d+)")
	this.id = id

	ToggleDropDownMenu(1, nil, FriendsDropDown, thisFrame:GetName(), 0, 0)

	this.unit, this.name, this.id = nil, nil, nil
end

-- XPerl_Raid_OnClick
function XPerl_Raid_OnClick()
	local thisFrame = this:GetParent()
	local unitid = thisFrame.partyid

	if (not XPerl_OnClick_Handler(arg1, unitid)) then
		if (arg1 == "RightButton" and not thisFrame.pet) then
			ShowPopup(thisFrame)
		end
	end
end

-- XPerl_ScaleRaid
function XPerl_ScaleRaid(num)
	for frame=1,NUM_RAID_GROUPS do
		local f = GetRaidGroup(frame)
		if (f) then
			f:SetScale(num)
		end
	end
	for id,f in pairs(FrameArray) do
		f:SetScale(num)
	end
	for name,f in pairs(PulloutFrameArray) do
		f:SetScale(num)
	end
end

-- XPerl_RaidTitles
function XPerl_RaidTitles()
	for i = 1,NUM_RAID_GROUPS do
		local frame = GetRaidGroup(i)
		if (frame) then
			frame:SetAlpha(XPerlConfig.Transparency)
			if (MovingMember or XPerlLocked == 0 or (XPerlConfig.ShowRaidTitles == 1 and RaidGroupCounts[i] > 0 and XPerlConfig["ShowGroup"..i] == 1)) then
				frame:Show()
			else
				frame:Hide()
			end
		end
	end
end

-- XPerl_RaidShowAllTitles
function XPerl_RaidShowAllTitles()
	for i = 1,NUM_RAID_GROUPS do
		GetRaidGroup(i, true)
	end
	XPerl_RaidTitles()
end

-- Moving stuff
function XPerl_Raid_GetGap()
	if (XPerl_Raid_Grp1 and XPerl_Raid_Grp2) then
		return math.floor((math.floor((XPerl_Raid_Grp2:GetLeft() - XPerl_Raid_Grp1:GetRight() + 0.01) * 100) / 100) + 4)
	end

	return (0)
end

-- InterestingFrames
local function InterestingFrames()
	local interest = XPerl_Options.raidAlign
	local ret = {}

	if (interest == "all") then
		for i = 1,NUM_RAID_GROUPS do
			tinsert(ret, GetRaidGroup(i, true))
		end
	elseif (interest == "odd") then
		for i = 1,NUM_RAID_GROUPS,2 do
			tinsert(ret, GetRaidGroup(i, true))
		end
	elseif (interest == "even") then
		for i = 2,NUM_RAID_GROUPS,2 do
			tinsert(ret, GetRaidGroup(i, true))
		end
	elseif (interest == "first4") then
		for i = 1,4 do
			tinsert(ret, GetRaidGroup(i, true))
		end
	elseif (interest == "last4") then
		for i = 5,NUM_RAID_GROUPS do
			tinsert(ret, GetRaidGroup(i, true))
		end
	end
	return ret
end

-- XPerl_Raid_SetGap
function XPerl_Raid_SetGap(newGap)
	if (not XPerl_Raid_Grp1) then
		return
	end

	if (type(newGap) == "number") then
		local frames = InterestingFrames()

		local left = frames[1]:GetLeft()
		local framePrev

		for i,frame in pairs(frames) do
			if (framePrev and frame) then
				local right = framePrev:GetRight()
				local top = frame:GetTop()

				frame:ClearAllPoints()
				frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", right + newGap - 4, top)
			end

			framePrev = frame
		end

		SaveAllPositions()
	end
end

-- XPerl_Raid_AlignTop
function XPerl_Raid_AlignTop()
	if (not XPerl_Raid_Grp1) then
		return
	end

	local frames = InterestingFrames()

	local top = frames[1]:GetTop()

	for i,frame in pairs(frames) do
		local left = frame:GetLeft()

		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
	end

	SaveAllPositions()
end

-- XPerl_Raid_SetBuffTooltip
function XPerl_Raid_SetBuffTooltip ()
	local partyid = this:GetParent():GetParent().partyid
	GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT",30,0)

	local show, cureCast = GetShowCast(this:GetParent():GetParent())
	if (show == "b") then
		XPerl_TooltipSetUnitBuff(GameTooltip, partyid, this:GetID(), cureCast)
		XPerl_Raid_AddBuffDuration(partyid)
	elseif (show == "d") then
		XPerl_TooltipSetUnitDebuff(GameTooltip, partyid, this:GetID(), cureCast)
	end
end

------- XPerl_ToggleRaidBuffs -------
-- Raid Buff Key Binding function --
function XPerl_ToggleRaidBuffs(castable)

	if (castable) then
		if (XPerlConfig.BuffsCastableCurable == 1) then
			XPerlConfig.BuffsCastableCurable = 0
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_BUFFANY)
		else
			XPerlConfig.BuffsCastableCurable = 1
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_BUFFCURECAST)
		end
	else
		if (XPerlConfig.RaidBuffs == 1) then
			XPerlConfig.RaidBuffs = 0
			XPerlConfig.RaidDebuffs = 1
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_DEBUFFS)

		elseif (XPerlConfig.RaidDebuffs == 1) then
			XPerlConfig.RaidDebuffs = 0
			XPerlConfig.RaidBuffs = 0
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_NOBUFFS)

		else
			XPerlConfig.RaidBuffs = 1
			XPerlConfig.RaidDebuffs = 0
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_BUFFS)
		end
	end

	for i = 1,GetNumRaidMembers() do
		local frame = GetRaidUnit(i)
		if (frame) then
			XPerl_Raid_UpdateDisplay(frame)
		end
	end
end

-- GetCombatRezzerList()
local normalRezzers = {PRIEST = true, SHAMAN = true, PALADIN = true}
local function GetCombatRezzerList()

	local anyCombat = 0
	local anyAlive = 0
	for i = 1,GetNumRaidMembers() do
		local _, class = UnitClass("raid"..i)
		if (normalRezzers[class]) then
			if (UnitAffectingCombat("raid"..i)) then
				anyCombat = anyCombat + 1
			end
			if (not UnitIsDeadOrGhost("raid"..i) and UnitIsConnected("raid"..i)) then
				anyAlive = anyAlive + 1
			end
		end
	end

	-- We only need to know about battle rezzers if any normal rezzers are in combat
	if (anyCombat > 0) then
		local ret = {}
		local t = GetTime()

		for i = 1,GetNumRaidMembers() do
         		if (not UnitIsDeadOrGhost("raid"..i) and UnitIsVisible("raid"..i)) then
				local name, rank, subgroup, level, _, fileName, zone, online, isDead = GetRaidRosterInfo(i)

				local good
				if (not UnitAffectingCombat("raid"..i)) then
					if (fileName == "PRIEST" or fileName == "SHAMAN" or fileName == "PALADIN") then
						tinsert(ret, {["name"] = name, class = fileName, cd = 0})
					end
				else
					if (fileName == "DRUID") then
						local myRoster = XPerl_Roster[name]

						if (myRoster) then
							if (myRoster.Rebirth and myRoster.Rebirth - t <= 0) then
								myRoster.Rebirth = nil		-- Check for expired cooldown
							end
							if (myRoster.Rebirth) then
								if (myRoster.Rebirth - t < 120) then
									tinsert(ret, {["name"] = name, cd = myRoster.Rebirth - t})
								end
							else
								tinsert(ret, {["name"] = name, class = fileName, cd = 0})
							end
						end
					end
				end
			end
		end

		if (getn(ret) > 0) then
			sort(ret, function(a,b) return a.cd < b.cd end)

			local list = ""
			for k,v in pairs(ret) do
				local name = XPerlColourTable[v.class]..v.name.."|r"

				if (v.cd > 0) then
					name = name.." (in "..SecondsToTime(v.cd)..")"
				end

				if (list == "") then
					list = name
				else
					list = list..", "..name
				end
			end

			return list
		else
			return "|c00FF0000"..NONE.."|r"
		end
	end

	if (anyAlive == 0) then
		return "|c00FF0000"..NONE.."|r"
	elseif (anyCombat == 0) then
		return "|c00FFFFFF"..ALL.."|r"
	end
end

-- XPerl_RaidTipExtra
function XPerl_RaidTipExtra(unitid)

	if (UnitInRaid(unitid)) then
		local unitName = UnitName(unitid)
		local zone
		local name, rank, subgroup, level, class, fileName, zone, online, isDead

		for i = 1,GetNumRaidMembers() do
			name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
			if (name == unitName) then
				break
			end
			zone = ""
		end

		local stats = XPerl_Roster[unitName]
		if (stats) then
			local t = GetTime()

			if (stats.version) then
				if (stats.oRAversion) then
					GameTooltip:AddLine("CTRA "..stats.version.." (oRA "..stats.oRAversion..")", 1, 1, 1)
				else
					GameTooltip:AddLine("CTRA "..stats.version, 1, 1, 1)
				end
			else
				GameTooltip:AddLine(XPERL_RAID_TOOLTIP_NOCTRA, 0.7, 0.7, 0.7)
			end

			if (stats.offline and UnitIsConnected(unitid)) then
				stats.offline = nil
			end

			if (stats.offline) then
				GameTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_OFFLINE, SecondsToTime(t - stats.offline)))

			elseif (stats.afk) then
				GameTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_AFK, SecondsToTime(t - stats.afk)))

			elseif (stats.dnd) then
				GameTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_DND, SecondsToTime(t - stats.dnd)))

			elseif (stats.fd) then
				if (not UnitIsDead(unitid)) then
					stats.fd = nil
				else
					local x = stats.fd + 360 - t
					if (x > 0) then
						GameTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_DYING, SecondsToTime(x)))
					end
				end
			end

			if (stats.Rebirth) then
				if (stats.Rebirth - t > 0) then
					GameTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_REBIRTH, SecondsToTime(stats.Rebirth - t)))
				else
					stats.Rebirth = nil
				end

			elseif (stats.Reincarnation) then
				if (stats.Reincarnation - t > 0) then
					GameTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_ANKH, SecondsToTime(stats.Reincarnation - t)))
				else
					stats.Reincarnation = nil
				end

			elseif (stats.Soulstone) then
				if (stats.Soulstone - t > 0) then
					GameTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_SOULSTONE, SecondsToTime(stats.Soulstone - t)))
				else
					stats.Soulstone = nil
				end
			end

			if (UnitIsDeadOrGhost(unitid)) then
				if (stats.resCount) then
					GameTooltip:AddLine(XPERL_LOC_RESURRECTED.." x"..stats.resCount)
				end

				local Rezzers = GetCombatRezzerList()
				if (Rezzers) then
					GameTooltip:AddLine("Rezzers Available: "..Rezzers, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
				end
			end
		end

		GameTooltip:Show()
	end
end

-- GetNamesWithoutBuff
local function GetNamesWithoutBuff(tex, with)
	local matches = {
		{"Holy_WordFortitude", "Holy_PrayerOfFortitude"},
		{"Holy_MagicalSentry", "Holy_ArcaneIntellect"},
		{"Shadow_AntiShadow", "Holy_PrayerofShadowProtection"},
		{"Holy_DivineSpirit", "Holy_PrayerofSpirit"},
		{"Holy_FistOfJustice", "Holy_GreaterBlessingofKings"},
		{"Holy_SealOfWisdom", "Holy_GreaterBlessingofWisdom"},
		{"Magic_MageArmor", "Magic_GreaterBlessingofKings"},
		{"Holy_SealOfSalvation", "Holy_GreaterBlessingofSalvation"},
		{"Holy_PrayerOfHealing02", "Holy_GreaterBlessingofLight"},
		{"Nature_LightningShield", "Holy_GreaterBlessingofSanctuary"}
	}

	local count = 0
	local names
	local checkExpiring

	local _, class = UnitClass("player")
	if (IsRaidOfficer()) then
		checkExpiring = {all = 5}

	elseif (class == "PRIEST") then
		checkExpiring = {Spell_Holy_WordFortitude = 5, Spell_Holy_PrayerOfFortitude = 5,
				Spell_Holy_DivineSpirit = 2, Spell_Holy_PrayerofSpirit = 2,
				Spell_Shadow_AntiShadow = 2, Spell_Holy_PrayerofShadowProtection = 2}

	elseif (class == "DRUID") then
		checkExpiring = {Spell_Nature_Regeneration = 5, Spell_Nature_Thorns = 2}

	elseif (class == "MAGE") then
		checkExpiring = {Spell_Holy_MagicalSentry = 5, Spell_Holy_ArcaneIntellect = 5, Spell_Holy_FlashHeal = 2, Spell_Nature_AbolishMagic = 2}

	elseif (class == "PALADIN") then
		checkExpiring = {Spell_Holy_Excorcism = 2,
				Spell_Holy_FistOfJustice = 1, Spell_Holy_GreaterBlessingofKings = 1,
				Spell_Holy_SealOfWisdom = 1, Spell_Holy_GreaterBlessingofWisdom = 1,
				Spell_Magic_MageArmor = 1, Spell_Magic_GreaterBlessingofKings = 1,
				Spell_Holy_SealOfSalvation = 1, Spell_Holy_GreaterBlessingofSalvation = 1,
				Spell_Holy_PrayerOfHealing02 = 1, Spell_Holy_GreaterBlessingofLight = 1,
				Spell_Nature_LightningShield = 1, Spell_Holy_GreaterBlessingofSanctuary = 1}
	end

	for i = 1,GetNumRaidMembers() do
		local name = UnitName("raid"..i)
		local _, unitClass = UnitClass("raid"..i)
		if (name and UnitIsConnected("raid"..i) and not UnitIsDeadOrGhost("raid"..i)) then
			local hasBuff
			for num = 1,25 do
				local buffTexture = UnitBuff("raid"..i, num)
				if (not buffTexture) then
					break
				end

				if (buffTexture == tex) then
					hasBuff = true
					break
				else
					for dups,pair in pairs(matches) do
						if (tex == "Interface\\Icons\\Spell_"..pair[1] or tex == "Interface\\Icons\\Spell_"..pair[2]) then
							if (buffTexture == "Interface\\Icons\\Spell_"..pair[1] or buffTexture == "Interface\\Icons\\Spell_"..pair[2]) then
								hasBuff = true
							end
						end
					end
					if (hasBuff) then
						if (without and checkExpiring) then
							local found = checkExpiring.all

							if (not found) then
								found = checkExpiring[strsub(buffTexture, 23)]
							end

							if (found) then
								local myRoster = XPerl_Roster[name]
								if (myRoster and myRoster.Buffs) then
									local buffName
									for k,v in pairs(XPerl_CTBuffTextures) do
										if (v[1] == "Interface\\Icons\\"..buffTexture) then
											buffName = k
											break
										end
									end

									if (buffName) then
										if (myRoster.Buffs[buffName]) then
											local expire = myRoster.Buffs[buffName]
											if (expire > GetTime() + (found*60)) then
												GameTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_BUFFEXPIRING, XPerlColourTable[unitClass]..name.."|c", buffName, SecondsToTime(buff - GetTime())), 1, 0.2, 0)
											end
										end
									end
								end
							end
						end
						break
					end
				end
			end

			if ((with and hasBuff) or (not with and not hasBuff)) then
				count = count + 1
				local _, class = UnitClass("raid"..i)
				if (class) then
					names = (names or "")..XPerlColourTable[class]..name.." "
				else
					names = (names or "")..name.." "
				end
			end
		end
	end

	return names, count
end

-- XPerl_Raid_AddBuffDuration
function XPerl_Raid_AddBuffDuration(partyid, x)
	local XTooltip
	if (x) then
		XTooltip = x
	else
		XTooltip = GameTooltip
	end

	if (UnitInRaid("player") and XTooltip:IsOwned(this)) then
		if (partyid ~= "player") then
			local stats = XPerl_Roster[UnitName(partyid)]

			if (stats and stats.Buffs) then
				local buffName = getglobal("GameTooltipTextLeft1"):GetText()
				if (buffName) then
					local buff = stats.Buffs[buffName]
					if (buff) then
						if (buff > GetTime()) then
							XTooltip:AddLine(SecondsToTime(buff - GetTime())..XPERL_RAID_TOOLTIP_REMAINING, 1, 0.82, 0)
						end
					end
				end
			end
		end

		if (XPerlConfig.BuffTooltipHelper == 1 and partyid and UnitInRaid(partyid)) then
			local icon = getglobal(this:GetName().."Icon")
			if (icon) then
				local tex = icon:GetTexture()
				if (tex) then
					local names, count = GetNamesWithoutBuff(tex, IsAltKeyDown())
					if (names) then
						if (IsAltKeyDown()) then
							XTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_WITHBUFF, count), 0.3, 1, 0.2)
						else
							XTooltip:AddLine(string.format(XPERL_RAID_TOOLTIP_WITHOUTBUFF, count), 1, 0.3, 0.1)
						end
						XTooltip:AddLine(names, 0.8, 0.5, 0.4, 1)
					end
				end
			end
		end

		XTooltip:Show()
	end
end

-- XPerl_Raid_Set_Bits
function XPerl_Raid_Set_Bits()

	local msgs = {	"UNIT_DISPLAYPOWER",
			"UNIT_MANA", "UNIT_MAXMANA",
			"UNIT_ENERGY", "UNIT_MAXENERGY",
			"UNIT_RAGE", "UNIT_MAXRAGE"}

	for i,msg in pairs(msgs) do
		if (XPerlConfig.RaidMana == 1) then
			XPerl_Raid_Frame:RegisterEvent(msg)
		else
			XPerl_Raid_Frame:UnregisterEvent(msg)
		end
	end

	for i,frame in pairs(FrameArray) do
		Setup1RaidFrame(frame)
		if (frame.showing == 1) then
			XPerl_Raid_UpdateName(frame)
		end
	end

	for i,frame in pairs(PulloutFrameArray) do
		Setup1RaidFrame(frame)
		if (frame.showing == 1) then
			XPerl_Raid_UpdateName(frame)
		end
	end
end

-- Blizzard raid pullout replacements

local PetClasses = {HUNTER = true, WARLOCK = true}

function XPerl_ReplaceBlizzardPullouts()

-- RaidPullout_GenerateGroupFrame(groupID)
RaidPullout_GenerateGroupFrame = function(groupID)
	local pets = (IsControlKeyDown() == 1)

	-- construct the button listing
	if ( not groupID ) then
		groupID = this:GetParent():GetID()
	end

	-- Get a handle on a pullout frame
	local pullOutFrame = RaidPullout_GetFrame(groupID)
	if ( pullOutFrame ) then
		pullOutFrame.filterID = groupID
		pullOutFrame.showBuffs = nil

		-- Set pullout name
		local title = GROUP.." "..groupID
		if (pets) then
			title = title.." "..PET
		end
		getglobal(pullOutFrame:GetName().."Name"):SetText(title)

		-- TODO Title scale to 0.75, but we can't set scale of a fontstring
		if (RaidPullout_Update(pullOutFrame, pets)) then
			return pullOutFrame
		end
	end
end

RaidPullout_GenerateClassFrame = function(class, fileName)
	local pets = (IsControlKeyDown() == 1)

	-- construct the button listing
	if ( not class ) then
		class = this:GetParent().class;
	end

	if (pets and not PetClasses[fileName]) then  -- not AnyPets(fileName)) then
		return
	end

	-- Get a handle on a pullout frame
	local pullOutFrame = RaidPullout_GetFrame(fileName);
	if ( pullOutFrame ) then
		pullOutFrame.filterID = fileName;
		pullOutFrame.showBuffs = nil;

		-- Set pullout name
		if (pets) then
			class = class.." "..PET
		end
		getglobal(pullOutFrame:GetName().."Name"):SetText(class);

		-- TODO Title scale to 0.75, but we can't set scale of a fontstring
		if ( RaidPullout_Update(pullOutFrame, pets) ) then
			return pullOutFrame;
		end
	end
end

RaidPullout_GetFrame = function(groupID)
	-- Grab an available pullout frame
	local frame;
	for i=1, NUM_RAID_PULLOUT_FRAMES do
		frame = getglobal("RaidPullout"..i);
		-- if frame is visible see if its group id is already taken
		if ( frame:IsVisible() and filterID == frame.filterID ) then
			return nil;
		end
	end
	for i=1, NUM_RAID_PULLOUT_FRAMES do
		frame = getglobal("RaidPullout"..i);
		if ( not frame:IsVisible() ) then
			return frame;
		end
	end
	NUM_RAID_PULLOUT_FRAMES = NUM_RAID_PULLOUT_FRAMES + 1;
	frame = CreateFrame("Button", "RaidPullout"..NUM_RAID_PULLOUT_FRAMES, UIParent, "RaidPulloutFrameTemplate");
	frame.numPulloutButtons = 0;

	local f = getglobal("RaidPullout"..NUM_RAID_PULLOUT_FRAMES.."MenuBackdrop")
	f:Hide()

	return frame;
end

RaidPullout_Update = function(pullOutFrame, pets)
	if ( not pullOutFrame ) then
		pullOutFrame = this
	end

	if (pets ~= nil) then
		pullOutFrame.pets = pets
	end
	pets = pullOutFrame.pets

	local filterID = pullOutFrame.filterID
	local numPulloutEntries = 0
	if ( RAID_SUBGROUP_LISTS[filterID] ) then
		numPulloutEntries = getn(RAID_SUBGROUP_LISTS[filterID])
	end
	local pulloutList = RAID_SUBGROUP_LISTS[filterID]

	-- Hide the pullout if no entries
	if ( numPulloutEntries == 0 ) then
		pullOutFrame:Hide()
		return nil
	end

	-- Fill out the buttons
	local pulloutButton, pulloutButtonName, color, unit, pulloutHealthBar, pulloutManaBar, unitHPMin, unitHPMax
	local name, rank, subgroup, level, class, fileName, zone, online, isDead
	local debuff

	if (numPulloutEntries > pullOutFrame.numPulloutButtons) then
		local index = pullOutFrame.numPulloutButtons + 1
		local relative
		for i = index, numPulloutEntries do
			pulloutButton = CreateFrame("Frame", pullOutFrame:GetName().."Button"..i, pullOutFrame, "XPerl_Raid_FrameTemplate")
			PulloutFrameArray[pulloutButton:GetName()] = pulloutButton

			if (i == 1) then
				pulloutButton:SetPoint("TOP", pullOutFrame, "TOP", 0, 0)
			else
				relative = getglobal(pullOutFrame:GetName().."Button"..(i-1).."_StatsFrame")
				pulloutButton:SetPoint("TOP", relative, "BOTTOM", 0, 4)
			end
		end
		pullOutFrame.numPulloutButtons = numPulloutEntries;
	end

	local j = 1
	for i = 1,numPulloutEntries do
		pulloutButton = getglobal(pullOutFrame:GetName().."Button"..j)
		if (pulloutButton) then
			local _, ownerClass = UnitClass("raid"..pulloutList[i])
			if (not pets or PetClasses[ownerClass]) then
				pulloutButton.showing = 1
				pulloutButton:SetScale(XPerlConfig.Scale_Raid)
				Setup1RaidFrame(pulloutButton)

				pulloutButton.petname = nil
				if (pets) then
					XPerl_Raid_Frame:RegisterEvent("UNIT_PET")
					pulloutButton.partyid = "raidpet"..pulloutList[i]
					pulloutButton.petOwner = "raid"..pulloutList[i]
					pulloutButton.pet = true
				else
					pulloutButton.partyid = "raid"..pulloutList[i]
					pulloutButton.pet = nil
					pulloutButton.petOwner = nil
				end

				XPerl_Raid_UpdateDisplay(pulloutButton)
				pulloutButton:Show()
				j = j + 1
			end
		end
	end
	for i = j,pullOutFrame.numPulloutButtons do
		pulloutButton = getglobal(pullOutFrame:GetName().."Button"..i)
		if (pulloutButton) then
			pulloutButton.showing = 0
			pulloutButton:Hide()
		end
	end

	pullOutFrame:SetHeight(1)
	pullOutFrame:Show()
	return 1
end

RaidPulloutDropDown_Initialize = function()
	if ( not UIDROPDOWNMENU_OPEN_MENU or not getglobal(UIDROPDOWNMENU_OPEN_MENU).raidPulloutDropDown ) then
		return;
	end
	local currentPullout = getglobal(UIDROPDOWNMENU_OPEN_MENU):GetParent();
	local info;

	-- Show buffs or debuffs they are exclusive for now
	info = {};
	info.text = SHOW_BUFFS;
	info.func = function()
		currentPullout.showBuffs = 1;
		RaidPullout_Update(currentPullout);
	end;
	if ( currentPullout.showBuffs ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = SHOW_DEBUFFS;
	info.func = function()
		currentPullout.showBuffs = nil;
		RaidPullout_Update(currentPullout);
	end;
	if ( not currentPullout.showBuffs ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- Castable/Curable
	info = {};
	if (currentPullout.showBuffs) then
		info.text = SHOW_CASTABLE_BUFFS_TEXT
	else
		info.text = SHOW_DISPELLABLE_DEBUFFS_TEXT
	end
	info.func = function()
		currentPullout.cureCast = not currentPullout.cureCast
		RaidPullout_Update(currentPullout);
	end;
	if (currentPullout.cureCast) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- Pets
	info = {}
	if (currentPullout.pets) then
		info.text = "Show Owners"
	else
		info.text = "Show Pets"
	end
	info.func = function()
		currentPullout.pets = not currentPullout.pets
		RaidPullout_Update(currentPullout)

		local titleFrame = getglobal(currentPullout:GetName().."Name")
		local title = titleFrame:GetText()
		if (currentPullout.pets) then
			title = title.." "..PET
		else
			title = string.gsub(title, " "..PET, "")
		end
		titleFrame:SetText(title)
	end;
	if (currentPullout.pets) then
		info.checked = 1
	end
	UIDropDownMenu_AddButton(info)

	-- Close option
	info = {};
	info.text = CLOSE;
	info.func = function()
		currentPullout:Hide();
	end;
	UIDropDownMenu_AddButton(info);
end

end

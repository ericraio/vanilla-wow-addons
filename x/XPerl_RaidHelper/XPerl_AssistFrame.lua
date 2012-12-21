----------------------
-- Loading Function --
----------------------

local myClass

-- XPerl_SetFrameSides
function XPerl_SetFrameSides()
	if (XPerl_Assists_Frame.LastSetView and XPerl_Assists_Frame.LastSetView[1] == XPerlConfigHelper.AssistsFrame and XPerl_Assists_Frame.LastSetView[2] == XPerlConfigHelper.TargettingFrame) then
		-- Frames the same from last time
		return
	end

	if (XPerlConfigHelper.AssistsFrame == 1 or XPerlConfigHelper.TargettingFrame == 1) then
        	XPerl_Assists_Frame:Show()

		XPerl_Target_Targetting_ScrollFrame:ClearAllPoints()
		XPerl_Target_Assists_ScrollFrame:ClearAllPoints()

		if (XPerlConfigHelper.AssistsFrame == 1 and XPerlConfigHelper.TargettingFrame == 1) then
			XPerl_Target_Targetting_ScrollFrame:SetPoint("TOPLEFT", 4, -5)
			XPerl_Target_Targetting_ScrollFrame:SetPoint("BOTTOMRIGHT", XPerl_Assists_Frame, "BOTTOM", -1, 5)
			XPerl_Target_Targetting_ScrollFrame:Show()

			XPerl_Target_Assists_ScrollFrame:SetPoint("TOPLEFT", XPerl_Assists_Frame, "TOP", 0, -5)
			XPerl_Target_Assists_ScrollFrame:SetPoint("BOTTOMRIGHT", -4, 5)
			XPerl_Target_Assists_ScrollFrame:Show()

			XPerlScrollSeperator:Show()
			XPerlScrollSeperator:ClearAllPoints()
			XPerlScrollSeperator:SetPoint("TOPLEFT", XPerl_Target_Targetting_ScrollFrame, "TOPRIGHT", 0, 0)
			XPerlScrollSeperator:SetPoint("BOTTOMRIGHT", XPerl_Target_Assists_ScrollFrame, "BOTTOMLEFT", 0, 0)
		else
			XPerlScrollSeperator:Hide()

			if (XPerlConfigHelper.AssistsFrame == 1) then
				XPerl_Target_Assists_ScrollFrame:SetPoint("TOPLEFT", 4, -5)
				XPerl_Target_Assists_ScrollFrame:SetPoint("BOTTOMRIGHT", -4, 5)
				XPerl_Target_Assists_ScrollFrame:Show()
				XPerl_Target_Targetting_ScrollFrame:Hide()
			else
				XPerl_Target_Targetting_ScrollFrame:SetPoint("TOPLEFT", 4, -5)
				XPerl_Target_Targetting_ScrollFrame:SetPoint("BOTTOMRIGHT", -4, 5)
				XPerl_Target_Targetting_ScrollFrame:Show()
				XPerl_Target_Assists_ScrollFrame:Hide()
			end
		end
	else
        	XPerl_Assists_Frame:Hide()
	end

	XPerl_Assists_Frame.LastSetView = {XPerlConfigHelper.AssistsFrame, XPerlConfigHelper.TargettingFrame}
end

-- ToggleAssistsFrame()
function XPerl_ToggleAssistsFrame(param)
	if (param == "assists") then
		if (XPerlConfigHelper.AssistsFrame == 1) then
			XPerlConfigHelper.AssistsFrame = 0
		else
			XPerlConfigHelper.AssistsFrame = 1
		end
	else
		if (XPerlConfigHelper.TargettingFrame == 1) then
			XPerlConfigHelper.TargettingFrame = 0
		else
			XPerlConfigHelper.TargettingFrame = 1
		end
	end
end

-- XPerl_AssistsView_Close
function XPerl_AssistsView_Open()
	XPerlConfigHelper.AssistsFrame = 1
	XPerlConfigHelper.TargettingFrame = 1
	XPerl_SetFrameSides()
	return true
end

function XPerl_AssistsView_Close()
	XPerlConfigHelper.AssistsFrame = 0
	XPerlConfigHelper.TargettingFrame = 0
	XPerl_SetFrameSides()
end

-- SortByClass(t1, t2)
local function SortByClass(t1, t2)
	if (t1[2] == t2[2]) then
		return t1[1] < t2[1]
	else
		local t1c = t1[2]
		local t2c = t2[2]
		if (t1c == myClass) then
			t1c = "A"..t1c
		elseif (t1c ~= "") then
			t1c = "B"..t1c
		else
			t1c = "Z"
		end
		if (t2c == myClass) then
			t2c = "A"..t2c
		elseif (t2c ~= "") then
			t2c = "B"..t2c
		else
			t1c = "Z"
		end

		return t1c..t1[1] < t2c..t2[1]
	end
end

-- XPerl_MakeAssistsString
function XPerl_MakeAssistsString(List, title)
	local text = title

	if (List ~= nil) then
		local lastClass
		local any = false
		local nAssists = getn(List)
		if (nAssists > 0) then
			text = text.." "..nAssists
		end
		text = text.."\13"

		sort(List, SortByClass)

		for i,unit in pairs(List) do
			if (not any) then
				if (unit[2] == "") then
					text = text.."|c00FF0000"..unit[1]
				else
					text = text..XPerlColourTable[unit[2]]..unit[1]
				end
				lastClass, any = unit[2], true
			else
				if (lastClass) then
					if (unit[2] == "" or lastClass ~= unit[2]) then
						lastClass = unit[2]

						if (unit[2] == "") then
							text = text.."\r|c00FF0000"..unit[1]
						else
							text = text.."\r"..XPerlColourTable[unit[2]]..unit[1]
						end
					else
						text = text.." "..unit[1]
					end
				else
					text = text.." "..unit[1]

					lastClass = unit[2]
				end
			end
		end
	end

	return (text)
end

-- FillList
local function FillList(List, cFrame, title)
	local text = XPerl_MakeAssistsString(List, title)
	getglobal("XPerl_Target_Assists_ScrollChild_"..cFrame.."Text"):SetText(text)
end

-- XPerl_ShowAssists()
function XPerl_ShowAssists()
	if (XPerlConfigHelper.AssistsFrame == 1 or XPerlConfigHelper.TargettingFrame == 1) then
		if (XPerlConfigHelper.AssistsFrame == 1 and XPerl_Assists_Frame.assists ~= nil) then
			FillList(XPerl_Assists_Frame.assists, "Assists", XPERL_TOOLTIP_ASSISTING)
		end

		if (XPerlConfigHelper.TargettingFrame == 1 and XPerl_Assists_Frame.targetting ~= nil) then
			local title
			if (getn(XPerl_Assists_Frame.targetting) > 0 and XPerl_Assists_Frame.targetting[1][2] == "") then
				title = XPERL_TOOLTIP_ENEMYONME
			else
				if (XPerlConfigHelper.TargetCountersSelf == 0) then
					title = XPERL_TOOLTIP_ALLONME
				else
					title = XPERL_TOOLTIP_HEALERS
				end
			end

			FillList(XPerl_Assists_Frame.targetting, "Targetting", title)
		end
	end
end

-- XPerl_Assists_MouseDown
function XPerl_Assists_MouseDown(button,param)
	if (button == "LeftButton") then
		if (not XPerlConfigHelper or not XPerlConfigHelper.AssistPinned or (IsAltKeyDown() and IsControlKeyDown() and IsShiftKeyDown())) then
			if (param and (param == "TOPLEFT" or param == "BOTTOMLEFT" or param == "BOTTOMRIGHT")) then
				XPerl_Assists_Frame:StartSizing(param)
			else
				XPerl_Assists_Frame:StartMoving()
			end
		end

	elseif (button == "RightButton") then
		if (strfind (this:GetName(), "XPerl_Target_Assists_ScrollChild_Targetting")) then
			param = "targetFrame"
		end

		if (param and param == "targetFrame") then
			if (XPerlConfigHelper.TargetCountersSelf == 1) then
				XPerlConfigHelper.TargetCountersSelf = 0
			else
				XPerlConfigHelper.TargetCountersSelf = 1
			end
		end
	end
end

-- XPerl_Assists_MouseUp
function XPerl_Assists_MouseUp(button)
	XPerl_Assists_Frame:StopMovingOrSizing()
end

-- Events
function XPerl_Assists_OnEvent()
	if (event == "PLAYER_TARGET_CHANGED") then
		XPerl_UpdateAssists()
		XPerl_ShowAssists()
	end
end

-- XPerl_Assists_OnUpdate
local UpdateTime = 0
function XPerl_Assists_OnUpdate()

	UpdateTime = arg1 + UpdateTime
	if (UpdateTime >= 0.2) then
	        XPerl_UpdateAssists()
		XPerl_ShowAssists()
		UpdateTime = 0
	end
end

---------------------------------
-- Targetting counters         --
---------------------------------

local assists
local targetting

-- XPerl_FoundEnemyBefore
local function XPerl_FoundEnemyBefore(FoundEnemy, name)
	for previous in pairs(FoundEnemy) do
		if (UnitIsUnit(previous.."target", name.."target")) then
			return true
		end
	end
	return false
end

-- XPerl_AddEnemy
local function XPerl_AddEnemy(anyEnemy, FoundEnemy, name)
	if (UnitIsUnit("player", name.."targettarget")) then
		if (not XPerl_FoundEnemyBefore(FoundEnemy, name)) then
			FoundEnemy[name] = true
			tinsert(targetting, {UnitName(name.."target"), ""})
			return true
		end

	-- 1.8.3 Added check to see if mob is targetting our target, and add to that list
	elseif (UnitIsUnit("target", name.."targettarget")) then
		-- We can still use the FoundEnemy list, because it's not too important if
		-- we're targetting ourself and the mob doesn't show on both self and target lists
		if (not XPerl_FoundEnemyBefore(FoundEnemy, name)) then
			FoundEnemy[name] = true
			tinsert(assists, {UnitName(name.."target"), ""})
			return true
		end
	end

	return false
end

local HealerClasses = {PRIEST = true, SHAMAN = true, PALADIN = true, DRUID = true}

-- XPerl_UpdateAssists
function XPerl_UpdateAssists()

	if (XPerlConfigHelper.TargetCounters == 0) then
		if (XPerl_Target_AssistFrame) then XPerl_Target_AssistFrame:Hide(); end
		if (XPerl_Player_TargettingFrame) then XPerl_Player_TargettingFrame:Hide(); end
		return
	end

	local selfFlag = XPerlConfigHelper.TargetCountersSelf == 1
	local enemyFlag = XPerlConfigHelper.TargetCountersEnemy == 1
	local assistCount, targettingCount, anyEnemy = 0, 0, false
	local start,i,total,prefix,name,petname,raidMembers

	local FoundEnemy = {}
	raidMembers = 0

	if (UnitInRaid("player")) then
		start, prefix, total = 1, "raid", GetNumRaidMembers()
	else
		start, prefix, total = 0, "party", 4
	end

	assists, targetting = {}, {}
	XPerl_Assists_Frame.assists, XPerl_Assists_Frame.targetting = assists, targetting

	local targetname = UnitName("target")
	for i = start,total do
		if (i == 0) then
			name, petname = "player", "pet"
		else
			name, petname = prefix..i, prefix.."pet"..i
		end

		if (UnitExists(name) and not UnitIsDeadOrGhost(name)) then
			local class, engClass = UnitClass(name)
			raidMembers = raidMembers + 1

			local hasPet = UnitExists(petname)

			if (targetname) then
				if (UnitIsUnit("target", name.."target")) then
					assistCount = assistCount + 1
					tinsert (assists, {UnitName(name), engClass})
				end
				if (hasPet and UnitIsUnit("target", petname.."target")) then
					assistCount = assistCount + 1
					tinsert (assists, {string.format(XPERL_TOOLTIP_PET, UnitName(name)), "pet"})
				end
			end

			-- 0 for Anyone, 1 for Healers
			if (not selfFlag or HealerClasses[engClass]) then
				if (UnitIsUnit("player", name.."target")) then
					targettingCount = targettingCount + 1
					tinsert(targetting, {UnitName(name), engClass})
				end
			end

			-- Count enemy targetting us?
			if (enemyFlag) then
				if (not UnitIsFriend("player", name.."target")) then
					if (XPerl_AddEnemy(anyEnemy, FoundEnemy, name)) then
						anyEnemy = true
						targettingCount = targettingCount + 1
					end
					if (hasPet) then
						if (XPerl_AddEnemy(anyEnemy, FoundEnemy, petname)) then
							anyEnemy = true
							targettingCount = targettingCount + 1
						end
					end
				end
			end
		end
	end

	if (UnitExists("mouseover") and not UnitIsFriend("player", "mouseover")) then
		if (UnitIsUnit("mouseovertarget", "player")) then
			local foundBefore
			for previous in pairs(FoundEnemy) do
				if (UnitIsUnit(previous.."target", "mouseover")) then
					foundBefore = true
				end
			end

			if (not foundBefore) then
				tinsert(targetting, {UnitName("mouseover"), ""})
				anyEnemy = true
				targettingCount = targettingCount + 1
			end
		end
	end

	if (XPerl_Player_TargettingFrame) then
		local conf = XPerlConfig or XPerlConfigHelper
		conf = conf.BorderColour

		if (anyEnemy) then
			XPerl_Player_TargettingFrame:SetBackdropBorderColor(1, 0.2, 0.2, conf.a)
		else
			XPerl_Player_TargettingFrame:SetBackdropBorderColor(conf.r, conf.g, conf.b, conf.a)
		end

		if (targettingCount == 0) then
			XPerl_Player_TargettingFrame:SetTextColor(1,0.5,0.5)
		elseif (targettingCount > 5) then
			XPerl_Player_TargettingFrame:SetTextColor(0.5,1,0.5)
		else
			XPerl_Player_TargettingFrame:SetTextColor(0.5,0.5,1)
		end

		XPerl_Player_TargettingFrame:SetText(targettingCount)
		XPerl_Player_TargettingFrame:Show()
	end

	if (XPerl_Target_AssistFrame) then
		if (assistCount < 2) then
			XPerl_Target_AssistFrame:SetTextColor(1,0.5,0.5)
		elseif (assistCount > (raidMembers / 2)) then
			XPerl_Target_AssistFrame:SetTextColor(0.5,1,0.5)
		else
			XPerl_Target_AssistFrame:SetTextColor(0.5,0.5,1)
		end

		if (targetname) then
			XPerl_Target_AssistFrame:SetText(assistCount)
		end
		XPerl_Target_AssistFrame:Show()
	end
end

-- XPerl_StartAssists
function XPerl_StartAssists()
	local _
	_, myClass = UnitClass("player")

	if (not XPerlColourTable.pet) then
		XPerlColourTable.pet = "|c008080FF"
	end

	XPerl_SetFrameSides()
end

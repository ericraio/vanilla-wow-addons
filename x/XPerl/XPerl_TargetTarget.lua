----------------------
-- Loading Function --
----------------------

local XPerl_TargetHistory = {}

-- XPerl_TargetTarget_OnLoad
function XPerl_TargetTarget_OnLoad()
	this.unitid = "targettarget"
	if (this:GetName() == "XPerl_TargetTargetTarget") then
		this.unitid = "targettargettarget"
	else
		XPerl_TargetTarget_Frame = XPerl_TargetTarget
	end

	-- Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")

	this.time = 0
	this.targetname = ""
	this.targethp = 0
	this.targetmana = 0
	this.lastUpdate = 0

	this.SubFrame = function(this, a)
		return getglobal(this:GetName().."_"..a)
	end

	XPerl_InitFadeFrame(this)
	XPerl_RegisterHighlight(getglobal(this:GetName().."_CastClickOverlay"), 2)
	XPerl_RegisterPerlFrames(this, {"NameFrame", "StatsFrame", "LevelFrame"})
end

-- XPerl_TargetTarget_RegisterSome
local function XPerl_TargetTarget_RegisterSome()
	this:RegisterEvent("RAID_TARGET_UPDATE")

	if (this == XPerl_TargetTarget) then
		this:RegisterEvent("PLAYER_TARGET_CHANGED")
		this:RegisterEvent("UNIT_HEALTH");			-- So health updates are more regular
		this:RegisterEvent("UNIT_MAXHEALTH")
		this:RegisterEvent("UNIT_AURA")
		this:RegisterEvent("UNIT_FACTION")
	end
end

-- XPerl_TargetTarget_UnregisterSome
local function XPerl_TargetTarget_UnregisterSome()
	this:UnregisterEvent("RAID_TARGET_UPDATE")

	if (this == XPerl_TargetTarget) then
		this:UnregisterEvent("PLAYER_TARGET_CHANGED")
		this:UnregisterEvent("UNIT_HEALTH")
		this:UnregisterEvent("UNIT_MAXHEALTH")
		this:UnregisterEvent("UNIT_AURA")
		this:UnregisterEvent("UNIT_FACTION")
	end
end

-------------------------
-- The Update Function --
-------------------------
function XPerl_TargetTarget_UpdatePVP(ttFrame)
        local targetrankname, targetrank=GetPVPRankInfo(UnitPVPRank(ttFrame.unitid), ttFrame.unitid)
        if (targetrank and XPerlConfig.ShowTargetPVPRank==1 and UnitIsPlayer(ttFrame.unitid)) then
                ttFrame:SubFrame("NameFrame_PVPRankIcon"):Show()
		if (targetrank==0) then
                        ttFrame:SubFrame("NameFrame_PVPRankIcon"):Hide()
		else
			ttFrame:SubFrame("NameFrame_PVPRankIcon"):SetTexture(string.format("Interface\\PVPRankBadges\\PVPRank%02d", targetrank))
		end
	else
                ttFrame:SubFrame("NameFrame_PVPRankIcon"):Hide()
	end
        if (XPerlConfig.ShowTargetPVP == 1 and UnitIsPVP("targettarget")) then
		ttFrame:SubFrame("NameFrame_PVPStatus"):SetTexture("Interface\\TargetingFrame\\UI-PVP-"..(UnitFactionGroup("targettarget") or "FFA"))
                ttFrame:SubFrame("NameFrame_PVPStatus"):Show()
	else
                ttFrame:SubFrame("NameFrame_PVPStatus"):Hide()
	end
end

-- XPerl_TargetTarget_Buff_UpdateAll
local function XPerl_TargetTarget_Buff_UpdateAll(ttFrame)
	local show
	if (ttFrame == XPerl_TargetTarget) then
		show = XPerlConfig.TargetTargetBuffs
	else
		show = XPerlConfig.TargetTargetTargetBuffs
	end

	if (show == 1) then
		ttFrame:SubFrame("BuffFrame"):Show()
		XPerl_Targets_BuffUpdate(ttFrame.unitid, ttFrame:GetName().."_", ttFrame)
	else
		ttFrame:SubFrame("BuffFrame"):Hide()
	end
end

-- XPerl_TargetTarget_RaidIconUpdate
local function XPerl_TargetTarget_RaidIconUpdate(unitid, frameRaidIcon, frameNameFrame)
	XPerl_Update_RaidIcon(unitid, frameRaidIcon)

	frameRaidIcon:ClearAllPoints()
	if (XPerlConfig.AlternateRaidIcon == 1) then
		frameRaidIcon:SetHeight(16)
		frameRaidIcon:SetWidth(16)
		frameRaidIcon:SetPoint("CENTER", frameNameFrame, "TOPRIGHT", -5, -4)
	else
		frameRaidIcon:SetHeight(32)
		frameRaidIcon:SetWidth(32)
		frameRaidIcon:SetPoint("CENTER", frameNameFrame, "CENTER", 0, 0)
	end
end

-- XPerl_TargetTarget_UpdateDisplay
function XPerl_TargetTarget_UpdateDisplay(ttFrame,force)

	local show
	if (ttFrame == XPerl_TargetTarget) then
		show = XPerlConfig.ShowTargetTarget
	else
		show = XPerlConfig.ShowTargetTargetTarget
		if (show == 1 and XPerlConfig.ShowTargetTarget == 0) then
			show = 0
		end
	end

	if (UnitExists("target") and show == 1 and UnitIsConnected(ttFrame.unitid)) then		-- (UnitName("target")~=nil) and (show==1) and (UnitIsConnected(ttFrame.unitid))) then
		ttFrame.targetname = UnitName(ttFrame.unitid)
		if (ttFrame.targetname ~= nil) then
			local t = GetTime()
			if (not force and t < ttFrame.lastUpdate + 0.3) then
				return
			end
			ttFrame.lastUpdate = t

			XPerl_CancelFade(ttFrame)
			ttFrame:Show()

	                XPerl_TargetTarget_UpdatePVP(ttFrame)

			-- Save these 2, so we know whether to update the frame later
			ttFrame.targethp = UnitHealth(ttFrame.unitid)
			ttFrame.targetmana = UnitMana(ttFrame.unitid)

                        XPerl_SetUnitNameColor(ttFrame.unitid, ttFrame:SubFrame("NameFrame_NameBarText"))

                        if (XPerlConfig.ShowTargetTargetLevel == 1) then
				local TargetTargetlevel = UnitLevel(ttFrame.unitid)
	                        local color = GetDifficultyColor(TargetTargetlevel)

				if (TargetTargetLevel == -1) then
					if (UnitClassification(ttFrame.unitid) == "worldboss") then
						TargetTargetLevel = "Boss"
					end
				elseif (UnitIsPlusMob(ttFrame.unitid) or UnitClassification(ttFrame.unitid) == "elite") then
                                        TargetTargetlevel = TargetTargetlevel.."+"
                                        ttFrame:SubFrame("LevelFrame"):SetWidth(33)
                                else
                                        ttFrame:SubFrame("LevelFrame"):SetWidth(27)
                                end

				ttFrame:SubFrame("LevelFrameText"):SetText(TargetTargetlevel)

				if (TargetTargetLevel == "Boss") then
                                        ttFrame:SubFrame("LevelFrame"):SetWidth(ttFrame:SubFrame("LevelFrameText"):GetStringWidth() + 6)
					color = {r = 1, g = 0, b = 0}
				end

				if (XPerlConfig.ShowTargetTargetPercent == 1) then
					ttFrame:SubFrame("NameFrame"):SetWidth(163 - ttFrame:SubFrame("LevelFrame"):GetWidth())
				else
					ttFrame:SubFrame("NameFrame"):SetWidth(131 - ttFrame:SubFrame("LevelFrame"):GetWidth())
				end

        	                ttFrame:SubFrame("LevelFrameText"):SetTextColor(color.r, color.g, color.b)
                        end

			-- Set name - Must do after level as the NameFrame can change size just above here.
			local TargetTargetname = ttFrame.targetname
			ttFrame:SubFrame("NameFrame_NameBarText"):SetText(TargetTargetname)

			local remCount = 1
			while ((ttFrame:SubFrame("NameFrame_NameBarText"):GetStringWidth() >= (ttFrame:SubFrame("NameFrame"):GetWidth() - 8)) and (string.len(TargetTargetname) > remCount)) do
				TargetTargetname = string.sub(TargetTargetname, 1, string.len(TargetTargetname) - remCount)..".."
				remCount = 3
				ttFrame:SubFrame("NameFrame_NameBarText"):SetText(TargetTargetname)
			end

			-- Set health
			XPerl_Target_SetHealth(ttFrame.unitid, ttFrame:SubFrame("StatsFrame_HealthBar"), ttFrame:SubFrame("StatsFrame_HealthBarBG"), ttFrame:SubFrame("StatsFrame_HealthBarPercent"), ttFrame:SubFrame("StatsFrame_HealthBarText"), ttFrame:SubFrame("StatsFrame_ManaBarPercent"), XPerlConfig.ShowTargetTargetPercent)

			-- Set mana
			XPerl_Target_SetManaType(ttFrame.unitid, ttFrame:SubFrame("StatsFrame_ManaBar"), ttFrame:SubFrame("StatsFrame_ManaBarText"), ttFrame:SubFrame("StatsFrame_ManaBarBG"), ttFrame:SubFrame("StatsFrame"), ttFrame)
			XPerl_Target_SetMana(ttFrame.unitid, ttFrame:SubFrame("StatsFrame_ManaBar"), ttFrame:SubFrame("StatsFrame_HealthBarPercent"), ttFrame:SubFrame("StatsFrame_ManaBarPercent"), ttFrame:SubFrame("StatsFrame_ManaBarText"))

			if (XPerlConfig.ShowTargetTargetValues == 1) then
				ttFrame:SubFrame("StatsFrame_HealthBarText"):Show()
				ttFrame:SubFrame("StatsFrame_ManaBarText"):Show()
			else
				ttFrame:SubFrame("StatsFrame_HealthBarText"):Hide()
				ttFrame:SubFrame("StatsFrame_ManaBarText"):Hide()
			end

			XPerl_TargetTarget_RaidIconUpdate(ttFrame.unitid, ttFrame:SubFrame("NameFrame_RaidIcon"), ttFrame:SubFrame("NameFrame"))

			XPerl_Targets_BuffPositions(ttFrame.unitid, ttFrame:GetName().."_", ttFrame)
			XPerl_TargetTarget_Buff_UpdateAll(ttFrame)

			return
		else
			ttFrame.targetname = ""
		end
	else
		ttFrame.targetname = ""
	end

	XPerl_StartFade(ttFrame)
end

-- XPerl_TargetTarget_Update_Control
local function XPerl_TargetTarget_Update_Control(ttFrame)
        if (UnitIsVisible(ttFrame.unitid) and UnitIsCharmed(ttFrame.unitid)) then
		ttFrame:SubFrame("NameFrame_Warning"):Show()
	else
		ttFrame:SubFrame("NameFrame_Warning"):Hide()
	end
end

-- XPerl_TargetTarget_Update_Combat
local function XPerl_TargetTarget_Update_Combat(ttFrame)
        if (UnitAffectingCombat(ttFrame.unitid)) then
                ttFrame:SubFrame("NameFrame_ActivityStatus"):Show()
        else
                ttFrame:SubFrame("NameFrame_ActivityStatus"):Hide()
        end
end

-- XPerl_TargetTarget_AddHistory
local function XPerl_TargetTarget_AddHistory(newName, r, g, b)
	if (getn(XPerl_TargetHistory) == 0 or newName ~= XPerl_TargetHistory[1].name) then
		tinsert(XPerl_TargetHistory, 1, {["name"] = newName, ["r"] = r, ["g"] = g, ["b"] = b, ["time"] = GetTime()})

		while (getn(XPerl_TargetHistory) > 10) do
			tremove(XPerl_TargetHistory, 11)
		end
		XPerl_TargetTarget.FlashChangeStart = GetTime()
	end
end

-- Process_HistoryFlash
local function Process_HistoryFlash()
	if (not this.FlashChangeStart) then
		return
	end

	local timer = (GetTime() - this.FlashChangeStart)
	local r, g, b
	if (timer > 1) then
		this.FlashChangeStart = nil
		r = XPerlConfig.BorderColour.r
		g = XPerlConfig.BorderColour.g
		b = XPerlConfig.BorderColour.b
	else
		r = XPerlConfig.BorderColour.r + 0.5 - (timer / 2)
		g = XPerlConfig.BorderColour.g + 0.5 - (timer / 2)
		b = XPerlConfig.BorderColour.b + 0.5 - (timer / 2)

		if (r < 0) then r = 0; elseif (r > 1) then r = 1; end
		if (g < 0) then g = 0; elseif (g > 1) then g = 1; end
		if (b < 0) then b = 0; elseif (b > 1) then b = 1; end
	end

	this:SubFrame("NameFrame"):SetBackdropBorderColor(r, g, b, XPerlConfig.Transparency)
	this:SubFrame("StatsFrame"):SetBackdropBorderColor(r, g, b, XPerlConfig.Transparency)
	this:SubFrame("LevelFrame"):SetBackdropBorderColor(r, g, b, XPerlConfig.Transparency)

	if (this == XPerl_TargetTarget) then
		if (XPerl_TargetTarget_History1) then
			XPerl_TargetTarget_History1:SetBackdropBorderColor(r, g, b, XPerlConfig.Transparency)
		end
	end
end

-- XPerl_TargetTarget_OnUpdate
function XPerl_TargetTarget_OnUpdate(elapsed, ttFrame)
	--if (not ttFrame.unitid) then
	--	return
	--end

	local newName = UnitName(ttFrame.unitid)
	local newHP = UnitHealth(ttFrame.unitid)
	local newMana = UnitMana(ttFrame.unitid)

	if (not newName) then
		newName = ""
		newHP = 0
		newMana = 0
	end

	if (newName ~= ttFrame.targetname) then
		if (ttFrame == XPerl_TargetTarget) then
			if (not UnitIsUnit("player", "target")) then
				if (ttFrame.targetname ~= "") then
					if (newName ~= "") then
						local r, g, b = ttFrame:SubFrame("NameFrame_NameBarText"):GetTextColor()
						XPerl_TargetTarget_AddHistory(XPerl_TargetTarget.targetname, r, g, b)
					end
				end
			end
		end

		XPerl_TargetTarget_UpdateDisplay(ttFrame,true)

	elseif ((newHP ~= ttFrame.targethp) or (newMana ~= ttFrame.targetmana)) then
		XPerl_TargetTarget_UpdateDisplay(ttFrame)
	end

	if (XPerlConfig.TargetTargetHistory == 1) then
		if (ttFrame == XPerl_TargetTarget) then
			XPerl_TargetTarget_Update()
		end
	else
		Process_HistoryFlash()

		if (ttFrame == XPerl_TargetTarget) then
			XPerl_TargetTarget_HideHistory()
		end
	end

	ttFrame.time = elapsed + ttFrame.time
        if (ttFrame.time >= 0.3 and ttFrame.Fading == 0) then
		if (newName ~= "") then
			if (ttFrame:IsShown()) then
	                	XPerl_TargetTarget_Update_Combat(ttFrame)
				XPerl_TargetTarget_Update_Control(ttFrame)
	                	XPerl_TargetTarget_UpdatePVP(ttFrame)
				XPerl_TargetTarget_Buff_UpdateAll(ttFrame)
				XPerl_SetUnitNameColor(ttFrame.unitid, ttFrame:SubFrame("NameFrame_NameBarText"))
			end
		end

		ttFrame.time = 0
	end

	XPerl_ProcessFade(ttFrame)
end

-------------------
-- Event Handler --
-------------------
function XPerl_TargetTarget_OnEvent()

	if (event == "PLAYER_ENTERING_WORLD") then
		XPerl_TargetTarget_RegisterSome()
		XPerl_TargetTarget_ClearHistory()

	elseif (event == "PLAYER_LEAVING_WORLD") then
		XPerl_TargetTarget_UnregisterSome()
		XPerl_TargetTarget:Hide()
		if (XPerl_TargetTargetTarget) then
			XPerl_TargetTargetTarget:Hide()
		end
		return

	elseif (event == "RAID_TARGET_UPDATE") then
		XPerl_TargetTarget_RaidIconUpdate(XPerl_TargetTarget.unitid, XPerl_TargetTarget_NameFrame_RaidIcon, XPerl_TargetTarget_NameFrame)
		if (XPerl_TargetTargetTarget) then
			XPerl_TargetTarget_RaidIconUpdate(XPerl_TargetTargetTarget.unitid, XPerl_TargetTarget_NameFrame_RaidIcon, XPerl_TargetTarget_NameFrame)
		end

	elseif (event == "PLAYER_TARGET_CHANGED") then
		XPerl_TargetTarget_ClearHistory()
	end

	if (unit) then
		if (strfind(event, "UNIT_HEALTH UNIT_MAXHEALTH UNIT_AURA UNIT_FACTION")) then
			if (UnitIsUnit(unit, "targettarget")) then
				XPerl_TargetTarget_UpdateDisplay(XPerl_TargetTarget,true)
			elseif (XPerl_TargetTargetTarget and UnitIsUnit(unit, "targettargettarget")) then
				XPerl_TargetTarget_UpdateDisplay(XPerl_TargetTargetTarget,true)
			end
		end
	end
end

--------------------
-- Target history --
--------------------

function XPerl_TargetTarget_ClearHistory()
	XPerl_TargetHistory = {}
	XPerl_TargetTarget_Update()
end

-- XPerl_TargetTarget_Update
function XPerl_TargetTarget_Update()

	local alpha = XPerlConfig.Transparency
	local time = GetTime()

	Process_HistoryFlash()

	local offset = -3
	if (XPerlConfig.TargetTargetBuffs == 1) then
		if (UnitExists("targettarget")) then
			if (XPerl_UnitBuff("targettarget", 1)) then
				if (offset == -3) then
					offset = 0
				end
				offset = offset + 20
				if (UnitBuff("targettarget", 9)) then
					offset = offset + 20
				end
			end
			if (XPerl_UnitDebuff("targettarget", 1)) then
				if (offset == -3) then
					offset = 0
				end
				offset = offset + 24
			end
		end
	end

	if (XPerl_TargetTarget_History1) then
		XPerl_TargetTarget_History1:ClearAllPoints()
		XPerl_TargetTarget_History1:SetPoint("TOPLEFT", XPerl_TargetTarget_StatsFrame, "BOTTOMLEFT", 0, -offset)
	end

	for i = 1,10 do
		local frame = getglobal("XPerl_TargetTarget_History"..i)
		local value = XPerl_TargetHistory[i]

		if (value) then
			if (not frame) then
				frame = CreateFrame("Frame", "XPerl_TargetTarget_History"..i, UIParent, "XPerl_History_Template")
				frame:SetID(i)
				--XPerl_SetupFrame(frame)
				XPerl_RegisterPerlFrames(frame)
				frame:SetScale(XPerlConfig.Scale_TargetTargetFrame)
			end
			if (XPerlConfig.ShowTargetTargetPercent == 0) then
				frame:SetWidth(128)
			else
				frame:SetWidth(160)
			end

			local frameText = getglobal("XPerl_TargetTarget_History"..i.."_NameBarText")

			frameText:SetText(XPerl_TargetHistory[i].name)
			frameText:SetTextColor(XPerl_TargetHistory[i].r, XPerl_TargetHistory[i].g, XPerl_TargetHistory[i].b)
			frame:Show()

			local minAlpha = 0.2
			local fadeSeconds = 9
			if (XPerl_TargetHistory[i].time < time - (fadeSeconds + 1)) then
				frame:SetAlpha(minAlpha)
			elseif (XPerl_TargetHistory[i].time < time - fadeSeconds) then
				local fullRange = XPerlConfig.Transparency - minAlpha
				local fade = (time - XPerl_TargetHistory[i].time) - fadeSeconds
				local alphaItem = XPerlConfig.Transparency - (fullRange * fade)

				frame:SetAlpha(alphaItem)
			else
				frame:SetAlpha(XPerlConfig.Transparency)
			end

		elseif (frame) then
		    	frame:Hide()
		end
	end
end

-- XPerl_TargetTarget_ResetFade
function XPerl_TargetTarget_ResetFade()
	local time = GetTime()
	for i = 1,getn(XPerl_TargetHistory) do
		XPerl_TargetHistory[i].time = time
	end
end

-- XPerl_TargetTarget_History_OnEnter
function XPerl_TargetTarget_History_OnEnter()
	local id = this:GetID()
	if (id) then
		XPerl_TargetHistory[id].time = GetTime()
	end
end

-- XPerl_TargetTarget_History_OnMouseUp
function XPerl_TargetTarget_History_OnMouseUp()
	local id = this:GetID()

	if (id) then
		if (XPerl_TargetHistory[id].name) then
			TargetByName(XPerl_TargetHistory[id].name)
		end
	end
end

-- XPerl_TargetTarget_HideHistory
function XPerl_TargetTarget_HideHistory()
	for i = 1,10 do
		local f = getglobal("XPerl_TargetTarget_History"..i)
		if (f) then
			f:Hide()
		end
	end
end

-- XPerl_TargetTarget_Set_Bits
function XPerl_TargetTarget_Set_Bits()
	if (not XPerl_TargetTarget) then
		return
	end

	local function Set(frame)
		local statsFrame = getglobal(frame:GetName().."_StatsFrame")
		local statsFrameHealthBarPercent = getglobal(statsFrame:GetName().."_HealthBarPercent")
		local statsFrameManaBarPercent = getglobal(statsFrame:GetName().."_ManaBarPercent")
		local nameFrame = getglobal(frame:GetName().."_NameFrame")
		local levelFrame = getglobal(frame:GetName().."_LevelFrame")

		if (XPerlConfig.ShowTargetTargetLevel==0) then
			--nameFrame:SetWidth(160)
			levelFrame:Hide()
			levelFrame:SetWidth(3)
		else
			--nameFrame:SetWidth(136)
			levelFrame:Show()
			levelFrame:SetWidth(27)
		end

		if (XPerlConfig.ShowTargetTargetPercent == 0) then
			statsFrame:SetWidth(128)
			statsFrameHealthBarPercent:Hide()
			statsFrameManaBarPercent:Hide()

			if (XPerlConfig.ShowTargetTargetLevel == 1) then
				nameFrame:SetWidth(104)
			else
				nameFrame:SetWidth(128)
			end
		else
			statsFrame:SetWidth(160)
			statsFrameHealthBarPercent:Show()
			statsFrameManaBarPercent:Show()

			if (XPerlConfig.ShowTargetTargetLevel == 1) then
				nameFrame:SetWidth(136)
			else
				nameFrame:SetWidth(160)
			end
		end

		XPerlConfig.TargetBuffSize = tonumber(XPerlConfig.TargetBuffSize) or 20
		XPerl_SetBuffSize(frame:GetName().."_", XPerlConfig.TargetBuffSize, XPerlConfig.TargetBuffSize * 1.2)
	end

	if (XPerlConfig.ShowTargetTargetTarget == 1) then
		if (not XPerl_TargetTargetTarget) then
			CreateFrame("Frame", "XPerl_TargetTargetTarget", UIParent, "XPerl_TargetTarget_Template")

			XPerl_TargetTargetTarget:SetPoint("BOTTOMLEFT", XPerl_TargetTarget_StatsFrame, "BOTTOMRIGHT", 5, 0)
			XPerl_RestorePosition(XPerl_TargetTargetTarget)
		end
	end

	Set(XPerl_TargetTarget)
	if (XPerl_TargetTargetTarget) then
		Set(XPerl_TargetTargetTarget)
	end
end

-- XPerl_ScaleTargetTarget
function XPerl_ScaleTargetTarget(num)
	if (XPerl_TargetTarget) then
		XPerl_TargetTarget:SetScale(num)
		if (XPerl_TargetTargetTarget) then
			XPerl_TargetTargetTarget:SetScale(num)
		end
		for i = 1,10 do
			local f = getglobal("XPerl_TargetTarget_History"..i)
			if (f) then
				f:SetScale(num)
			end
		end
	end
end

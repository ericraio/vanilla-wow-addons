local XPerl_Target_Events = {}

----------------------
-- Loading Function --
----------------------

function XPerl_Target_OnLoad()
	CombatFeedback_Initialize(XPerl_TargetHitIndicator, 30)

	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")
	this:RegisterEvent("VARIABLES_LOADED")

	--this.PlayerFlash = 0
	this.lastTarget = ""
	this.lastDeathMsg = ""
	this.unitid = "target"
	this.perlBuffs = 0
	this.perlDebuffs = 0

	XPerl_InitFadeFrame(this)

	if (XPerl_Target_AssistFrame) then
		-- Since target module is loaded after raid helper, we have to attach this manually
		-- because the target frame did not exist when this frame was created
		XPerl_Target_AssistFrame:SetParent(XPerl_Target_CastClickOverlay)
		XPerl_Target_AssistFrame:ClearAllPoints()
		XPerl_Target_AssistFrame:SetPoint("TOPLEFT", XPerl_Target_PortraitFrame, "TOPRIGHT", -2, -20)
	end

	-- Set here to reduce amount of function calls made
	this:SetScript("OnEvent", XPerl_Target_OnEvent)
	this:SetScript("OnUpdate", XPerl_Target_OnUpdate)
	this:SetScript("OnShow", XPerl_Target_UpdatePortrait)

	XPerl_RegisterHighlight(XPerl_Target_CastClickOverlay, 3)
	XPerl_RegisterPerlFrames(XPerl_Target, {"NameFrame", "StatsFrame", "LevelFrame", "PortraitFrame", "TypeFramePlayer", "CreatureType", "BossFrame", "CPFrame"})

	this.FlashFrames = {XPerl_Target_PortraitFrame, XPerl_Target_NameFrame,
				XPerl_Target_LevelFrame, XPerl_Target_StatsFrame,
				XPerl_Target_BossFrame, XPerl_Target_TypeFramePlayer,
				XPerl_Target_CreatureType }
end

local events = {"UNIT_SPELLMISS", "UNIT_FACTION", "UNIT_DYNAMIC_FLAGS", "UNIT_FLAGS", "UNIT_CLASSIFICATION_CHANGED",
		"PLAYER_TARGET_CHANGED", "PLAYER_FLAGS_CHANGED", "PLAYER_COMBO_POINTS", "UNIT_MODEL_CHANGED",
		"PARTY_MEMBER_DISABLE", "PARTY_MEMBER_ENABLE", "UNIT_AURA", "RAID_TARGET_UPDATE", "PARTY_MEMBERS_CHANGED",
		"PARTY_LEADER_CHANGED", "PARTY_LOOT_METHOD_CHANGED", "CHAT_MSG_COMBAT_HOSTILE_DEATH"}

local function XPerl_Target_RegisterSome()
	for i,event in pairs(events) do
		this:RegisterEvent(event)
	end
	XPerl_RegisterBasics()
end
local function XPerl_Target_UnregisterSome()
	for i,event in pairs(events) do
		this:UnregisterEvent(event)
	end
	XPerl_UnregisterBasics()
end

--------------------
-- Buff Functions --
--------------------
local function GetBuffButton(thisFrame, buffnum, debuff, createIfAbsent)

	local buffType
	if (debuff == 1) then
		buffType = "DeBuff"
	else
		buffType = "Buff"
	end
	local name
	if (thisFrame == XPerl_Target) then
		name = "XPerl_Target_BuffFrame_"..buffType..buffnum
	else
		name = thisFrame:GetName().."_BuffFrame_"..buffType..buffnum
	end
	local button = getglobal(name)

	if (not button and createIfAbsent) then
		local parent
		if (thisFrame == XPerl_Target) then
			parent = XPerl_Target_BuffFrame
		else
			parent = getglobal(thisFrame:GetName().."_BuffFrame")
		end

		button = CreateFrame("Button", name, parent, "XPerl_"..buffType.."Template")
		button:SetID(buffnum)

		local size = XPerlConfig.TargetBuffSize * (1 + (0.2 * debuff))
		button:SetHeight(size)
		button:SetWidth(size)

		if (debuff == 1) then
			if (thisFrame == XPerl_Target) then
				button:SetScript("OnEnter", function() XPerl_Target_SetDeBuffTooltip("target") end)
			else
				button:SetScript("OnEnter", function() XPerl_Target_SetDeBuffTooltip("targettarget") end)
			end
		else
			if (thisFrame == XPerl_Target) then
				button:SetScript("OnEnter", function() XPerl_Target_SetBuffTooltip("target") end)
			else
				button:SetScript("OnEnter", function() XPerl_Target_SetBuffTooltip("targettarget") end)
			end
		end
		button:SetScript("OnLeave", XPerl_PlayerTipHide)

		button:ClearAllPoints()
		if (buffnum == 1) then
			button:SetPoint("TOPLEFT", 0, 0)
		else
			local prevButton = getglobal(thisFrame:GetName().."_BuffFrame_"..buffType..(buffnum - 1))
			button:SetPoint("TOPLEFT", prevButton, "TOPRIGHT", 1 + debuff, 0)
		end
	end

	return button
end

-- This gets complicated. When we're the target frame, we have to wrap to next line of buffs if there's no mana on the target, or if the mob type frame is shown
-- And if the mob type frame is shown, AND there's no mana, then we may have to use small width on 2 rows, depending on buff size.
-- displayWidth is our current row max
-- displayWidthExtra is the max size after any short rows
-- displayWidthStart remembers the short row size for 2nd pass
function XPerl_Targets_BuffPositions(unitTarget, argFramePrefix, ttFrame)
	local above = 0
	if (ttFrame == XPerl_Target) then
		above = XPerlConfig.TargetBuffsAbove == 1
	else
		above = XPerlConfig.TargetTargetBuffsAbove == 1
	end

	local buffFrame = getglobal(argFramePrefix.."BuffFrame")
	local nameFrame = getglobal(argFramePrefix.."NameFrame")
	local statsFrame = getglobal(argFramePrefix.."StatsFrame")
	if (above) then
		buffFrame:ClearAllPoints()
		buffFrame:SetPoint("BOTTOMLEFT", nameFrame, "TOPLEFT", 2, 0)
	else
		buffFrame:ClearAllPoints()
		buffFrame:SetPoint("TOPLEFT", statsFrame, "BOTTOMLEFT", 2, 0)
	end

	local unitBuff = XPerl_UnitBuff(unitTarget, 1, XPerlConfig.TargetCastableBuffs)
	local buff1 = GetBuffButton(ttFrame, 1, 0, true)
	unitBuff = XPerl_UnitDebuff(unitTarget, 1, XPerlConfig.TargetCastableBuffs)
	local debuff1 = GetBuffButton(ttFrame, 1, 1, true)

	local buffHeight, debuffHeight
	if (buff1) then
		buffHeight = math.floor(buff1:GetHeight() + 1.5)
	else
		buffHeight = 21
	end
	if (debuff1) then
		debuffHeight = math.floor(debuff1:GetHeight() + 2.5)
	else
		debuffHeight = 23
	end
	local displayWidth = math.floor(getglobal(argFramePrefix.."StatsFrame"):GetWidth() - 3.5)
	local displayWidthStart = displayWidth
	local displayWidthExtra = displayWidth
	local mana = UnitManaMax(unitTarget)
	local buffRows = 1
	local debuffRows = 1

	local pframe = getglobal(argFramePrefix.."PortraitFrame")
	if (pframe) then
		displayWidthExtra = displayWidthExtra + math.floor(pframe:GetWidth() - 3.5)
	end

	if (unitTarget == "target") then
		if (XPerlConfig.ShowTargetLevel == 1 or XPerlConfig.ShowTargetClassIcon == 1) then
			pframe = getglobal(argFramePrefix.."LevelFrame")
			if (pframe) then
				displayWidthExtra = displayWidthExtra + math.floor(pframe:GetWidth() - 3.5)
			end
		end

		if (above or not XPerl_Target_CreatureType:IsShown() or UnitFactionGroup("player") ~= UnitFactionGroup(unitTarget)) then
			displayWidth = displayWidthExtra
		end
	else
		displayWidthExtra = displayWidth
		displayWidthStart = displayWidth
	end

	local unitBuff = XPerl_UnitBuff(unitTarget, 1, XPerlConfig.TargetCastableBuffs)
	local buffPrev = buff1
	local buffRowStart = buffPrev
	local buffsWidth = buffHeight
	ttFrame.buffData = {{row = 1, buff = buffRowStart}}
	for i = 2,20 do
		unitBuff = XPerl_UnitBuff(unitTarget, i, XPerlConfig.TargetCastableBuffs)
		local buff = GetBuffButton(ttFrame, i, 0, unitBuff and (buffRows <= XPerlConfig.TargetBuffRows))

		if (buff) then
			buff:ClearAllPoints()
			if (buffsWidth + buffHeight > displayWidth) then
				if (above) then
					buff:SetPoint("BOTTOMLEFT", buffRowStart, "TOPLEFT", 0, -1)
				else
					buff:SetPoint("TOPLEFT", buffRowStart, "BOTTOMLEFT", 0, -1)
				end
				buffRowStart = buff

				if (buffRows > 1 or mana > 0 or buffHeight > 26 or not XPerl_Target_CreatureType:IsShown()) then
					displayWidth = displayWidthExtra
				end

				buffsWidth = 0
				buffRows = buffRows + 1
			else
				buff:SetPoint("TOPLEFT", buffPrev, "TOPRIGHT", 1, 0)
			end

			buffsWidth = buffsWidth + buffHeight
			buffPrev = buff
		end
		tinsert(ttFrame.buffData, {row = buffRows, buff = buffRowStart})
	end

	if (not above) then
		if ((UnitFactionGroup("player") == UnitFactionGroup(unitTarget))) then
			if (mana == 0) then
				if (buffRows > 1 or buffHeight > 25) then
					displayWidth = displayWidthExtra
				else
					displayWidth = displayWidthStart
				end
			else
				displayWidth = displayWidthExtra
			end
		else
			if (unitTarget == "target" and (mana == 0 or XPerl_Target_CreatureType:IsShown())) then
				displayWidth = displayWidthStart
			else
				displayWidth = displayWidthExtra
			end
		end
	end

	local unitDebuff = XPerl_UnitDebuff(unitTarget, 1, XPerlConfig.TargetCastableBuffs)
	buffPrev = debuff1
	buffRowStart = buffPrev
	buffsWidth = debuffHeight
	ttFrame.debuffData = {{row = 1, buff = buffRowStart}}
	for i = 2,16 do
		unitDebuff = XPerl_UnitDebuff(unitTarget, i, XPerlConfig.TargetCastableBuffs)
		local buff = GetBuffButton(ttFrame, i, 1, unitDebuff and (debuffRows <= XPerlConfig.TargetBuffRows))

		if (buff) then
			buff:ClearAllPoints()
			if (buffsWidth + debuffHeight > displayWidth) then
				if (above) then
					buff:SetPoint("BOTTOMLEFT", buffRowStart, "TOPLEFT", 0, 2)
				else
					buff:SetPoint("TOPLEFT", buffRowStart, "BOTTOMLEFT", 0, -2)
				end
				buffRowStart = buff

				if (debuffRows > 1 or mana > 0 or debuffHeight > 26 or not XPerl_Target_CreatureType:IsShown()) then
					displayWidth = displayWidthExtra
				end

				buffsWidth = 0
				debuffRows = debuffRows + 1
			else
				buff:SetPoint("TOPLEFT", buffPrev, "TOPRIGHT", 2, 0)
			end

			buffsWidth = buffsWidth + debuffHeight
			buffPrev = buff
		end
		tinsert(ttFrame.debuffData, {row = debuffRows, buff = buffRowStart})
	end
end

-- XPerl_Targets_BuffUpdate
function XPerl_Targets_BuffUpdate(unitTarget, argFramePrefix, ttFrame)
	if (this.Fading == 1) then
		return
	end

	if (ttFrame == XPerl_Target) then
		above = XPerlConfig.TargetBuffsAbove == 1
	else
		above = XPerlConfig.TargetTargetBuffsAbove == 1
	end

	if (UnitExists(unitTarget)) then
		this.perlBuffs = 0
		this.perlDebuffs = 0

		for buffnum=1,20 do
			local hide = false
			if (ttFrame.buffData and ttFrame.buffData[buffnum] and ttFrame.buffData[buffnum].row > XPerlConfig.TargetBuffRows) then
				hide = true
			else
				local buff, count = XPerl_UnitBuff(unitTarget, buffnum, XPerlConfig.TargetCastableBuffs)

				if (buff) then
					local button = GetBuffButton(ttFrame, buffnum, 0, true)
					local icon = getglobal(button:GetName().."Icon")

					this.perlBuffs = this.perlBuffs + 1
					local buffCount = getglobal(button:GetName().."Count")

					icon:SetTexture(buff)
					if (count > 1) then
						buffCount:SetText(count)
						buffCount:Show()
					else
						buffCount:Hide()
					end
					button:Show()
				else
					hide = true
				end
			end

			if (hide) then
				local button = getglobal(argFramePrefix.."BuffFrame_Buff"..buffnum)
				if (button) then
					button:Hide()
				end
			end
		end

		for buffnum=1,16 do
			local hide = false
			if (ttFrame.debuffData and ttFrame.debuffData[buffnum] and ttFrame.debuffData[buffnum].row > XPerlConfig.TargetBuffRows) then
				hide = true
			else
				local debuff, debuffApplications, debuffType = XPerl_UnitDebuff(unitTarget, buffnum, XPerlConfig.TargetCurableDebuffs)

				if (debuff) then
					local button = GetBuffButton(ttFrame, buffnum, 1, true)
					local icon = getglobal(button:GetName().."Icon")

					this.perlDebuffs = this.perlDebuffs + 1
					local debuffCount = getglobal(button:GetName().."Count")

					icon:SetTexture(debuff)
					if ( debuffApplications > 1 ) then
						debuffCount:SetText(debuffApplications)
						debuffCount:Show()
					else
						debuffCount:Hide()
					end

					local borderColor = DebuffTypeColor[(debuffType or "none")]
					local buffBorder = getglobal(button:GetName().."Border")
					buffBorder:SetVertexColor(borderColor.r, borderColor.g, borderColor.b)

					button:Show()
				else
					hide = true
				end
			end

			if (hide) then
				local button = getglobal(argFramePrefix.."BuffFrame_DeBuff"..buffnum)
				if (button) then
					button:Hide()
				end
			end
		end

		local buff1 = getglobal(argFramePrefix.."BuffFrame_Buff1")
		local debuff1 = getglobal(argFramePrefix.."BuffFrame_DeBuff1")
		if (buff1 or debuff1) then
			if (buff1) then buff1:ClearAllPoints() end
			if (debuff1) then debuff1:ClearAllPoints() end

			if ((UnitFactionGroup("player") == UnitFactionGroup(unitTarget))) then
				if (buff1) then
					if (above) then
						buff1:SetPoint("BOTTOMLEFT", 0, 0)
					else
						buff1:SetPoint("TOPLEFT", 0, 0)
					end
				end
				if (debuff1) then
					local mark = this.perlBuffs
					if (mark < 1) then
						mark = 1
					end
					if (above) then
						debuff1:SetPoint("BOTTOMLEFT", ttFrame.buffData[mark].buff, "TOPLEFT", 0, 2)
					else
						debuff1:SetPoint("TOPLEFT", ttFrame.buffData[mark].buff, "BOTTOMLEFT", 0, -2)
					end
				end
			else
				if (debuff1) then
					if (above) then
						debuff1:SetPoint("BOTTOMLEFT", 0, 0)
					else
						debuff1:SetPoint("TOPLEFT", 0, 0)
					end
				end
				if (buff1) then
					local mark = this.perlDebuffs
					if (mark < 1) then
						mark = 1
					end
					if (this.perlDebuffs > 0) then
						if (above) then
							buff1:SetPoint("BOTTOMLEFT", ttFrame.debuffData[mark].buff, "TOPLEFT", 0, 2)
						else
							buff1:SetPoint("TOPLEFT", ttFrame.debuffData[mark].buff, "BOTTOMLEFT", 0, -2)
						end
					end
				end
			end
		end
	end
end

-- XPerl_Target_SetBuffTooltip
function XPerl_Target_SetBuffTooltip (target)
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")

	if (target == "targettarget") then
		if (strfind(this:GetName(), "TargetTargetTarget")) then
			target = "targettargettarget"
		end
	end

	XPerl_TooltipSetUnitBuff(GameTooltip, target, this:GetID(), XPerlConfig.TargetCastableBuffs)
	XPerl_ToolTip_AddBuffDuration(target)
end

-- XPerl_Target_SetDeBuffTooltip
function XPerl_Target_SetDeBuffTooltip (target)
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")

	if (target == "targettarget") then
		if (strfind(this:GetName(), "TargetTargetTarget")) then
			target = "targettargettarget"
		end
	end

	XPerl_TooltipSetUnitDebuff(GameTooltip, target, this:GetID(), XPerlConfig.TargetCurableDebuffs)
end

---------------
-- Combo Points
---------------
local function XPerl_Target_UpdateCombo()
	local combopoints = GetComboPoints()
	if (XPerlConfig.UseCPMeter == 1) then
		XPerl_Target_CPFrame:Hide()
		XPerl_Target_CPMeter:SetMinMaxValues(0, 5)
		XPerl_Target_CPMeter:SetValue(combopoints)
		XPerl_Target_CPMeter:Show()
		if (combopoints == 5) then
			XPerl_Target_CPMeter:SetStatusBarColor(1, 0, 0, 0.7)
		elseif (combopoints == 4) then
			XPerl_Target_CPMeter:SetStatusBarColor(1, 0.5, 0, 0.7)
		elseif (combopoints == 3) then
			XPerl_Target_CPMeter:SetStatusBarColor(1, 1, 0, 0.6)
		elseif (combopoints == 2) then
			XPerl_Target_CPMeter:SetStatusBarColor(0.5, 1, 0, 0.4)
		elseif (combopoints == 1) then
			XPerl_Target_CPMeter:SetStatusBarColor(0, 1, 0, 0.4)
		else
			XPerl_Target_CPMeter:Hide()
		end
	elseif (XPerlConfig.BlizzardCPMeter == 0) then
		XPerl_Target_CPMeter:Hide()
		XPerl_Target_CPFrame:Show()
		XPerl_Target_CPFrameText:SetText(combopoints)
		if (combopoints == 5) then
			XPerl_Target_CPFrameText:SetTextColor(1, 0, 0)
		elseif (combopoints == 4) then
			XPerl_Target_CPFrameText:SetTextColor(1, 0.5, 0)
		elseif (combopoints == 3) then
			XPerl_Target_CPFrameText:SetTextColor(1, 1, 0)
		elseif (combopoints == 2) then
			XPerl_Target_CPFrameText:SetTextColor(0.5, 1, 0)
		elseif (combopoints == 1) then
			XPerl_Target_CPFrameText:SetTextColor(0, 1, 0)
		else
			XPerl_Target_CPFrame:Hide()
		end
	end
end

-- XPerl_UnitDebuffInformation
local function XPerl_UnitDebuffInformation(debuff)
	local i = 1

	while UnitDebuff("target", i) do
		XPerlBuffStatusTooltip:SetUnitDebuff("target", i )
		if (XPerlBuffStatusTooltipTextLeft1:GetText() == debuff) then
			_, debuffApplications = UnitDebuff("target", i)
			return debuffApplications
		end

		i = i + 1
	end

	return 0
end

---------------------
--Debuffs          --
---------------------
local function XPerl_Target_DebuffUpdate()
	if (this.Fading == 1) then
		return
	end

	if (GetComboPoints()==0) then
		local numDebuffs = 0
		local _, class = UnitClass("player")

		if (class == "WARRIOR") then
			numDebuffs = XPerl_UnitDebuffInformation(XPERL_SPELL_SUNDER)
		elseif (class == "PRIEST") then
			numDebuffs = XPerl_UnitDebuffInformation(XPERL_SPELL_SHADOWV)
		elseif (class == "MAGE") then
			numDebuffs = XPerl_UnitDebuffInformation(XPERL_SPELL_FIREV)

			if (numDebuffs == 0) then
				numDebuffs = XPerl_UnitDebuffInformation(XPERL_SPELL_WINTERCH)
			end
		end

		if (XPerlConfig.UseCPMeter == 1) then
			XPerl_Target_CPFrame:Hide()
			XPerl_Target_CPMeter:SetMinMaxValues(0, 5)
			XPerl_Target_CPMeter:SetValue(numDebuffs)
			XPerl_Target_CPMeter:Show()
			if (numDebuffs == 5) then
				XPerl_Target_CPMeter:SetStatusBarColor(1, 0, 0, 0.4)
			elseif (numDebuffs == 4) then
				XPerl_Target_CPMeter:SetStatusBarColor(1, 0.5, 0, 0.4)
			elseif (numDebuffs == 3) then
				XPerl_Target_CPMeter:SetStatusBarColor(1, 1, 0, 0.4)
			elseif (numDebuffs == 2) then
				XPerl_Target_CPMeter:SetStatusBarColor(0.5, 1, 0, 0.4)
			elseif (numDebuffs == 1) then
				XPerl_Target_CPMeter:SetStatusBarColor(0, 1, 0, 0.4)
			else
				XPerl_Target_CPMeter:Hide()
			end
		else
			XPerl_Target_CPMeter:Hide()
			XPerl_Target_CPFrame:Show()
			XPerl_Target_CPFrameText:SetText(numDebuffs)
			if (cnumDebuffs == 5) then
				XPerl_Target_CPFrameText:SetTextColor(1, 0, 0)
			elseif (numDebuffs == 4) then
				XPerl_Target_CPFrameText:SetTextColor(1, 0.5, 0)
			elseif (numDebuffs == 3) then
				XPerl_Target_CPFrameText:SetTextColor(1, 1, 0)
			elseif (numDebuffs == 2) then
				XPerl_Target_CPFrameText:SetTextColor(0.5, 1, 0)
			elseif (numDebuffs == 1) then
				XPerl_Target_CPFrameText:SetTextColor(0, 1, 0)
			else
				XPerl_Target_CPFrame:Hide()
			end
		end
	else
		XPerl_Target_UpdateCombo()
	end
end

-------------------------
-- The Update Functions--
-------------------------
local function XPerl_Target_UpdatePVP()
	local targetrankname, targetrank=GetPVPRankInfo(UnitPVPRank("target"), "target")
	if (targetrank and XPerlConfig.ShowTargetPVPRank==1 and UnitIsPlayer("target")) then
		XPerl_Target_NameFrame_PVPRankIcon:Show()
		if (targetrank==0) then
			XPerl_Target_NameFrame_PVPRankIcon:Hide()
		else
			XPerl_Target_NameFrame_PVPRankIcon:SetTexture(string.format("Interface\\PVPRankBadges\\PVPRank%02d", targetrank))
		end
	else
		XPerl_Target_NameFrame_PVPRankIcon:Hide()
	end
	if (XPerlConfig.ShowTargetPVP == 1 and UnitIsPVP("target")) then
		XPerl_Target_NameFrame_PVPStatus:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..(UnitFactionGroup("target") or "FFA"))
		XPerl_Target_NameFrame_PVPStatus:Show()
	else
		XPerl_Target_NameFrame_PVPStatus:Hide()
	end
	XPerl_SetUnitNameColor("target", XPerl_Target_NameFrame_NameBarText)

	if (XPerlConfig.TargetReactionHighlight == 1) then
		local c = XPerl_ReactionColour("target")
		XPerl_Target_NameFrame:SetBackdropColor(c.r, c.g, c.b)
	end
end

-- XPerl_Target_UpdateName
local function XPerl_Target_UpdateName()
	local targetname = UnitName("target")

	--if (strlen(targetname) > 20) then
	--	targetname = strsub(targetname, 1, 19).."..."
	--end

	XPerl_Target_NameFrame_NameBarText:SetText(targetname)

	local remCount = 1
	while ((XPerl_Target_NameFrame_NameBarText:GetStringWidth() >= (XPerl_Target_NameFrame:GetWidth() - 8)) and (string.len(targetname) > remCount)) do
		targetname = string.sub(targetname, 1, string.len(targetname) - remCount)..".."
		remCount = 3
		XPerl_Target_NameFrame_NameBarText:SetText(targetname)
	end

	XPerl_Target_UpdatePVP()

	--guildname, guildtitle, guildrank = GetGuildInfo("target")
end

-- XPerl_Target_UpdatePortrait
function XPerl_Target_UpdatePortrait()
	if (XPerlConfig.ShowTargetPortrait == 1) then
		if (UnitExists("target")) then
			if (UnitIsVisible("target") and XPerlConfig.ShowTargetPortrait3D == 1) then
				XPerl_Target_PortraitFrame_Portrait:Hide()
				XPerl_Target_PortraitFrame_Portrait3D:Show()
				XPerlSetPortrait3D(XPerl_Target_PortraitFrame_Portrait3D, "target")
			else
				XPerl_Target_PortraitFrame_Portrait3D.last3DTime = nil
				XPerl_Target_PortraitFrame_Portrait:Show()
				XPerl_Target_PortraitFrame_Portrait3D:Hide()
				SetPortraitTexture(XPerl_Target_PortraitFrame_Portrait, "target")
			end
		end
	end
end

-- XPerl_Target_UpdateLevel
local function XPerl_Target_UpdateLevel()
	local targetlevel = UnitLevel("target")
	XPerl_Target_LevelFrameText:SetText(targetlevel)
	-- Set Level
	if (XPerlConfig.ShowTargetLevel==1) then
		XPerl_Target_LevelFrame:Show()
		XPerl_Target_LevelFrame:SetWidth(27)
		if (targetlevel < 0) then
			XPerl_Target_LevelFrameText:SetTextColor(1, 0, 0)
			XPerl_Target_LevelFrame:Hide()
		else
			local color = GetDifficultyColor(targetlevel)
			XPerl_Target_LevelFrameText:SetTextColor(color.r, color.g, color.b)
		end
                if (XPerlConfig.ShowTargetElite==0 and (UnitClassification("target") == "elite" or UnitClassification("target") == "worldboss")) then --(UnitIsPlusMob("target"))) then
			XPerl_Target_LevelFrameText:SetText(targetlevel.."+")
			XPerl_Target_LevelFrame:SetWidth(33)
		end
	end
end

-- XPerl_Target_UpdateClassification
local function XPerl_Target_UpdateClassification()
	local targetclassification = UnitClassification("target")

	if (UnitIsCivilian("target")) then
		XPerl_Target_BossFrameText:SetText(XPERL_TYPE_CIVILIAN)
                XPerl_Target_BossFrameText:SetTextColor(1, 0, 0)
	        XPerl_Target_BossFrame:Show()

	elseif (targetclassification == "normal" and UnitPlayerControlled("target")) then
		if (not UnitIsPlayer("target")) then
			XPerl_Target_BossFrameText:SetText(XPERL_TYPE_PET)
	                XPerl_Target_BossFrameText:SetTextColor(1, 1, 1)
		        XPerl_Target_BossFrame:Show()
		else
	        	XPerl_Target_BossFrame:Hide()
		end

	elseif ((XPerlConfig.ShowTargetLevel==1 and XPerlConfig.ShowTargetElite==1) or targetclassification=="Rare+" or targetclassification=="Rare") then
		XPerl_Target_BossFrame:Show()
		if (targetclassification == "worldboss") then
			XPerl_Target_BossFrameText:SetText(XPERL_TYPE_BOSS)
	                XPerl_Target_BossFrameText:SetTextColor(1, 0.5, 0.5)

		elseif (targetclassification == "rareelite") then
			XPerl_Target_BossFrameText:SetText(XPERL_TYPE_RAREPLUS)
	                XPerl_Target_BossFrameText:SetTextColor(0.8, 0.8, 0.8)

		elseif (targetclassification == "elite") then
			XPerl_Target_BossFrameText:SetText(XPERL_TYPE_ELITE)
	                XPerl_Target_BossFrameText:SetTextColor(1, 1, 0.5)

		elseif (targetclassification == "rare") then
			XPerl_Target_BossFrameText:SetText(XPERL_TYPE_RARE)
	                XPerl_Target_BossFrameText:SetTextColor(0.8, 0.8, 0.8)

		else
			XPerl_Target_BossFrame:Hide()
		end
        else
                XPerl_Target_BossFrame:Hide()
	end

	XPerl_Target_BossFrame:SetWidth(XPerl_Target_BossFrameText:GetStringWidth() + 10)
end

-- XPerl_Target_UpdateType
local function XPerl_Target_UpdateType()
	local targettype = UnitCreatureType("target")

	if (targettype == XPERL_TYPE_NOT_SPECIFIED) then
		targettype = nil
	end

	if (XPerlConfig.ShowTargetMobType == 1) then
		XPerl_Target_CreatureType:Show()
	else
		XPerl_Target_CreatureType:Hide()
	end

	XPerl_Target_TypeFramePlayer:Hide()
	XPerl_Target_CreatureTypeText:SetText(targettype)

	if (UnitIsPlayer("target")) then
		local _, PlayerClass = UnitClass("target")
		if (XPerlConfig.ShowTargetClassIcon==1) then
			local r, l, t, b = XPerl_ClassPos(PlayerClass)
			XPerl_Target_TypeFramePlayer_ClassTexture:SetTexCoord(r, l, t, b)
			XPerl_Target_TypeFramePlayer:Show()
		end
		XPerl_Target_CreatureType:Hide()
	else
		if (targettype and targettype ~= "") then
			XPerl_Target_CreatureTypeText:SetTextColor(1, 1, 1)
			XPerl_Target_CreatureType:SetWidth(XPerl_Target_CreatureTypeText:GetStringWidth() + 10)
		else
			XPerl_Target_CreatureType:Hide()
		end
	end

	-- If it's too long, we anchor it to left side of portrait instead of right, to avoid it overlapping some buffs
	XPerl_Target_CreatureType:ClearAllPoints()
	if (XPerl_Target_CreatureType:GetWidth() > XPerl_Target_PortraitFrame:GetWidth()) then
		XPerl_Target_CreatureType:SetPoint("TOPLEFT", XPerl_Target_PortraitFrame, "BOTTOMLEFT", 0, 2)
	else
		XPerl_Target_CreatureType:SetPoint("TOPRIGHT", XPerl_Target_PortraitFrame, "BOTTOMRIGHT", 0, 2)
	end
end

-- XPerl_Target_UpdateManaType
local function XPerl_Target_UpdateManaType()
	if (this.Fading == 1) then
		return
	end

	XPerl_Target_SetManaType("target", XPerl_Target_StatsFrame_ManaBar, XPerl_Target_StatsFrame_ManaBarText, XPerl_Target_StatsFrame_ManaBarBG, XPerl_Target_StatsFrame, XPerl_Target)
end

-- XPerl_Target_SetManaType
function XPerl_Target_SetManaType(unit, frameManaBar, frameManaBarText, frameManaBarBG, frameStatsFrame, frameFrame)
	local targetmanamax = UnitManaMax(unit)

	if ((targetmanamax == 0) or (unit == "target" and XPerlConfig.ShowTargetMana==0) or (unit ~= "target" and XPerlConfig.ShowTargetTargetMana == 0)) then
		if (frameManaBar:IsShown()) then
			frameManaBar:Hide()
			frameStatsFrame:SetHeight(28)
			XPerl_StatsFrameSetup(frameStatsFrame)
		end
		return
	end

	XPerl_SetManaBarType(unit, frameManaBar, frameManaBarBG)

	local targetmana = UnitMana(unit)

	if (not frameManaBar:IsShown()) then
		frameManaBarText:Show()
		frameManaBar:Show()
		frameStatsFrame:SetHeight(40)
		XPerl_StatsFrameSetup(frameStatsFrame)
	end
end

-- XPerl_Target_UpdateMana
local function XPerl_Target_UpdateMana()
	if (this.Fading == 1) then
		return
	end

	XPerl_Target_SetMana("target", XPerl_Target_StatsFrame_ManaBar, XPerl_Target_StatsFrame_HealthBarPercent, XPerl_Target_StatsFrame_ManaBarPercent, XPerl_Target_StatsFrame_ManaBarText)
end

-- XPerl_Target_SetMana
function XPerl_Target_SetMana(unit, frameManabar, frameHealthBarPercent, frameManaBarPercent, frameManaBarText)
	local targetmana = UnitMana(unit)
	local targetmanamax = UnitManaMax(unit)
	if (frameHealthBarPercent:IsVisible()) then
		frameManaBarPercent:Show()
	end

	if (targetmanamax == 1 and targetmana > targetmanamax) then
		targetmanamax = targetmana
	end

	frameManabar:SetMinMaxValues(0, targetmanamax)
	frameManabar:SetValue(targetmana)

	frameManaBarPercent:SetText(string.format("%d",(100*(targetmana / targetmanamax))+0.5).."%")
	frameManaBarText:SetText(targetmana.."/"..targetmanamax)
end

-- XPerl_Target_UpdateHealth
local function XPerl_Target_UpdateHealth()
	if (this.Fading == 1) then
		return
	end

	XPerl_Target_SetHealth("target", XPerl_Target_StatsFrame_HealthBar, XPerl_Target_StatsFrame_HealthBarBG, XPerl_Target_StatsFrame_HealthBarPercent, XPerl_Target_StatsFrame_HealthBarText, XPerl_Target_StatsFrame_ManaBarPercent, XPerlConfig.ShowTargetPercent)

	if (XPerlConfig.ShowTargetValues == 1) then
		XPerl_Target_StatsFrame_HealthBarText:Show()
		XPerl_Target_StatsFrame_ManaBarText:Show()
	else
		XPerl_Target_StatsFrame_HealthBarText:Hide()
		XPerl_Target_StatsFrame_ManaBarText:Hide()
	end

	if (not UnitIsConnected("target")) then
		XPerl_Target_StatsFrame_HealthBarText:SetText(XPERL_LOC_OFFLINE)
		XPerl_Target:SetAlpha(XPerlConfig.Transparency / 2)
	else
		XPerl_Target:SetAlpha(XPerlConfig.Transparency)
	end
end

-- XPerl_Target_SetHealth
function XPerl_Target_SetHealth(unit, frameHealthBar, frameHealthBarBG, frameHealthBarPercent, frameHealthBarText, frameManaBarPercent, bPercent)
	local targethealth, targethealthmax = UnitHealth(unit), UnitHealthMax(unit)
	local healthPct = targethealth / targethealthmax

	frameHealthBar:SetMinMaxValues(0, targethealthmax)
	if (XPerlConfig.InverseBars == 1) then
		frameHealthBar:SetValue(targethealthmax - targethealth)
	else
		frameHealthBar:SetValue(targethealth)
	end

	XPerl_SetSmoothBarColor(frameHealthBar, healthPct)
	if (targethealthmax == 100) then
		frameHealthBarPercent:SetText(targethealth.."%")
	else
		frameHealthBarPercent:SetText(string.format("%d",(100*healthPct)+0.5).."%")
	end
	if (targethealthmax ~= 100) then
		if (XPerlConfig.HealerMode == 1) then
			if (XPerlConfig.HealerModeType == 1) then
				frameHealthBarText:SetText(string.format("%d/%d", targethealth - targethealthmax, targethealthmax))
			else
				frameHealthBarText:SetText(targethealth - targethealthmax)
			end
		else
			frameHealthBarText:SetText(targethealth.."/"..targethealthmax)
		end
	else
		-- Hide MobInfo-2 frame
		if MobHealthFrame then
			MobHealthFrame:Hide()
		end

		local current, max
		if (MobHealth3) then
			local found
			current, max, found = MobHealth3:GetUnitHealth(unit, targethealth, targethealthmax, UnitName(unit), UnitLevel(unit))

			if (not found) then
				current = nil
			end

		elseif (MobHealthDB) then
			local index
			if UnitIsPlayer(unit) then
				index = UnitName(unit)
			else
				index = UnitName(unit)..":"..UnitLevel(unit)
			end

			local table = MobHealthDB
			if (not (table and table[index])) then
				table = MobHealthPlayerDB
			end
			if (table and table[index]) then
				local s, e
				local pts
				local pct

				if ( type(table[index]) ~= "string" ) then
					frameHealthBarText:SetText(targethealth.."%")
				end
				s, e, pts, pct = strfind(table[index], "^(%d+)/(%d+)$")

				if ( pts and pct ) then
					pts = pts + 0
					pct = pct + 0
					if( pct ~= 0 ) then
						pointsPerPct = pts / pct
					else
						pointsPerPct = 0
					end
				end
				local currentPct = UnitHealth(unit)
				if ( pointsPerPct > 0 ) then
					current = (currentPct * pointsPerPct) + 0.5
					max = (100 * pointsPerPct) + 0.5
				end
			end
		end

		if (current) then
			if (XPerlConfig.HealerMode == 1) then
				if (XPerlConfig.HealerModeType == 1) then
					if (max > 100000) then
						frameHealthBarText:SetText(string.format("%d%s/%d%s", (current - max) / XPERL_LOC_LARGENUMDIV, XPERL_LOC_LARGENUMTAG, max / XPERL_LOC_LARGENUMDIV, XPERL_LOC_LARGENUMTAG))
					else
						frameHealthBarText:SetText(string.format("%d/%d", current - max, max))
					end
				else
					if (max > 100000) then
						frameHealthBarText:SetText(string.format("%d%s", (current - max) / XPERL_LOC_LARGENUMDIV, XPERL_LOC_LARGENUMTAG))
					else
						frameHealthBarText:SetText(string.format("%d", current - max))
					end
				end
			else
				if (max > 100000) then
					frameHealthBarText:SetText(string.format("%.1f%s/%.1f%s", current / XPERL_LOC_LARGENUMDIV, XPERL_LOC_LARGENUMTAG, max / XPERL_LOC_LARGENUMDIV, XPERL_LOC_LARGENUMTAG))
				else
					frameHealthBarText:SetText(string.format("%d/%d", current, max))
				end
			end
		else
			frameHealthBarText:SetText(targethealth.."%")
		end
	end

	if (bPercent == 1) then
		if (UnitIsGhost(unit)) then
			frameManaBarPercent:Hide()
			frameHealthBarPercent:SetText(XPERL_LOC_GHOST)
		elseif (UnitIsDead(unit)) then
			frameManaBarPercent:Hide()
			frameHealthBarPercent:SetText(XPERL_LOC_DEAD)
		elseif (UnitExists(unit) and not UnitIsConnected(unit)) then
			frameManaBarPercent:Hide()
			frameHealthBarPercent:SetText(XPERL_LOC_OFFLINE)
		end
	else
		if (UnitIsGhost(unit)) then
			frameHealthBarText:SetText(XPERL_LOC_GHOST)
		elseif (UnitIsDead(unit)) then
			frameHealthBarText:SetText(XPERL_LOC_DEAD)
		elseif (UnitExists(unit) and not UnitIsConnected(unit)) then
			frameHealthBarText:SetText(XPERL_LOC_OFFLINE)
		end
	end
end

-- XPerl_Target_Update_Control
local function XPerl_Target_Update_Control()
        if (UnitIsVisible("target") and UnitIsCharmed("target")) then
		XPerl_Target_NameFrame_Warning:Show()
	else
		XPerl_Target_NameFrame_Warning:Hide()
	end
end

-- XPerl_Target_Update_Combat
function XPerl_Target_Update_Combat()
        if (UnitAffectingCombat("target")) then
                XPerl_Target_NameFrame_ActivityStatus:Show()
        else
                XPerl_Target_NameFrame_ActivityStatus:Hide()
        end
end

-- XPerl_Target_CombatFlash
local function XPerl_Target_CombatFlash(elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet (elapsed, XPerl_Target, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(XPerl_Target)
	end
end

-- XPerl_Target_Udpate_Range
function XPerl_Target_Udpate_Range()
	if (XPerlConfig.Show30YardSymbol == 0 or CheckInteractDistance("target", 4) or not UnitIsConnected("target")) then
		XPerl_Target_NameFrame_RangeStatus:Hide()
	else
		XPerl_Target_NameFrame_RangeStatus:Show()
		XPerl_Target_NameFrame_RangeStatus:SetAlpha(1)
	end
end

-- XPerl_Target_UpdateLeader
local function XPerl_Target_UpdateLeader()
	local leader
	if (UnitIsUnit("target", "player")) then
		leader = IsPartyLeader()

	elseif (UnitInRaid("target")) then
		local find = UnitName("target")
		for i = 1,GetNumRaidMembers() do
			local name, rank = GetRaidRosterInfo(i)
			if (name == find) then
				leader = (rank == 2)
				break
			end
		end

	elseif (UnitInParty("target")) then
		local index = GetPartyLeaderIndex()
		if (index > 0) then
			leader = UnitIsUnit("target", "party"..index)
		end
	end

	if (leader) then
		XPerl_Target_NameFrame_LeaderIcon:Show()
	else
		XPerl_Target_NameFrame_LeaderIcon:Hide()
	end
end

-- XPerl_Target_UpdateMasterLooter
-- We can't determine who is master looter in raid if not in current party... :(
local function XPerl_Target_UpdateMasterLooter()
	local ml
	local method, index = GetLootMethod()

	if (method == "master" and index) then
		if (index == 0 and UnitIsUnit("player", "target")) then
			ml = true
		elseif (index >= 1 and index <= 4) then
			ml = UnitIsUnit("target", "party"..index)
		end
	end

	if (ml) then
		XPerl_Target_NameFrame_MasterIcon:Show()
	else
		XPerl_Target_NameFrame_MasterIcon:Hide()
	end
end

-- XPerl_Target_UpdateDisplay
function XPerl_Target_UpdateDisplay()
	if (UnitExists("target")) then
		this.lastTarget = UnitName("target")
		this.lastDeathMsg = ""
		XPerl_CancelFade(XPerl_Target)

		XPerl_Target:Show()
		XPerl_Target_UpdateName()
		XPerl_Target_UpdateLeader()
		XPerl_Target_UpdateMasterLooter()
		XPerl_Target_UpdateLevel()
		XPerl_Target_UpdateClassification()
		XPerl_Target_UpdateType()
		XPerl_Target_UpdatePVP()
		XPerl_Target_UpdateCombo()
		XPerl_Target_UpdateManaType()
		XPerl_Target_UpdateMana()
		XPerl_Target_UpdateHealth()
		XPerl_Target_Update_Control()
                XPerl_Target_Update_Combat()

		-- Work out where all our buffs can fit, we only do this for a fresh target
		XPerl_Targets_BuffPositions("target", "XPerl_Target_", XPerl_Target)
		XPerl_Targets_BuffUpdate("target", "XPerl_Target_", XPerl_Target)

		XPerl_Target_DebuffUpdate()
		XPerl_Target_Events:RAID_TARGET_UPDATE()

		if (not UnitIsConnected("target")) then
			XPerl_Target:SetAlpha(XPerlConfig.Transparency / 2)
		else
			XPerl_Target:SetAlpha(XPerlConfig.Transparency)
		end

		if (TargetFrame) then
			TargetFrame:Hide();  -- Hide default frame
		end

		if (XPerlConfig.BlizzardCPMeter~=1) then
			ComboFrame:Hide();  -- Hide Combo Points
		end
	else
		if (this.lastDeathMsg ~= nil and this.lastTarget ~= nil) then
			if (strfind (this.lastDeathMsg, this.lastTarget)) then
				XPerl_Target_UpdateCombo()
				this.lastDeathMsg = ""
				XPerl_Target_StatsFrame_HealthBar:SetMinMaxValues(0, 1)
				XPerl_Target_StatsFrame_HealthBar:SetValue(0)
				XPerl_Target_StatsFrame_ManaBar:SetMinMaxValues(0, 1)
				XPerl_Target_StatsFrame_ManaBar:SetValue(0)
				XPerl_SetSmoothBarColor (XPerl_Target_StatsFrame_HealthBar, 0)

				local oldhp = XPerl_Target_StatsFrame_HealthBarText:GetText()
				if (strfind(oldhp, "/")) then
					oldhp = string.gsub(oldhp, "%d+/(%d+)", "0/%1")
					XPerl_Target_StatsFrame_HealthBarText:SetText(oldhp)
				else
					XPerl_Target_StatsFrame_HealthBarText:SetText("0%")
				end

				local oldmana = XPerl_Target_StatsFrame_ManaBarText:GetText()
				if (strfind(oldmana, "/")) then
					oldmana = string.gsub(oldmana, "%d+/(%d+)", "0/%1")
					XPerl_Target_StatsFrame_ManaBarText:SetText(oldmana)
				else
					XPerl_Target_StatsFrame_ManaBarText:SetText("0%")
				end

				XPerl_Target_StatsFrame_HealthBarPercent:SetText(XPERL_LOC_DEAD)
			end
		end

		XPerl_StartFade(XPerl_Target)
		if (XPerl_Target_StatsFrame_HealthBarPercent:GetText() == XPERL_LOC_OFFLINE) then
			XPerl_Target.FadeTime = 0.5
		end
	end
end

--------------------
-- Click Handlers --
--------------------
function XPerl_Target_OnClick(button)
	-- If player clicks the target frame while it's fading away. no actual target, but we can get that back:
	if (not UnitName("target")) then
		TargetLastTarget()
	end

	if (XPerl_OnClick_Handler(button, "target")) then
		return
	end

	if (button == "RightButton") then
		HideDropDownMenu(1)
		ToggleDropDownMenu(1, nil, TargetFrameDropDown, "XPerl_Target_StatsFrame", 0, 0)
	end
end

-- XPerl_Target_OnUpdate
function XPerl_Target_OnUpdate()
	CombatFeedback_OnUpdate(arg1)

	if (this.Fading == 0) then
		XPerl_Target_Udpate_Range()
		if (this.PlayerFlash) then
			XPerl_Target_CombatFlash(arg1, false)
		end
	else
		XPerl_ProcessFade(XPerl_Target)
	end
end

-------------------
-- Event Handler --
-------------------
function XPerl_Target_OnEvent()
	local func = XPerl_Target_Events[event]
	if (func) then
		func()
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Target_Events:PLAYER_ENTERING_WORLD()
	XPerl_Target_RegisterSome()
end

-- VARIABLES_LOADED
function XPerl_Target_Events:VARIABLES_LOADED()
	XPerl_Target_RegisterSome()
end

-- PLAYER_LEAVING_WORLD
function XPerl_Target_Events:PLAYER_LEAVING_WORLD()
	XPerl_Target.Fading = 0
	XPerl_Target.lastTarget = 0
	XPerl_Target:Hide()
	XPerl_Target_UnregisterSome()
end

-- UNIT_COMBAT
function XPerl_Target_Events:UNIT_COMBAT()
	if (arg1 == "target") then
	        XPerl_Target_Update_Combat()

		if (XPerlConfig.CombatHitIndicator == 1 and XPerlConfig.ShowTargetPortrait == 1) then
			CombatFeedback_OnCombatEvent(arg2, arg3, arg4, arg5)
		end

		if (arg2 == "HEAL") then
			XPerl_Target_CombatFlash(0, true, true)
		elseif (arg4 and arg4 > 0) then
			XPerl_Target_CombatFlash(0, true)
		end
	end
end

-- UNIT_SPELLMISS
function XPerl_Target_Events:UNIT_SPELLMISS()
	if (arg1 == "target") then
		if (XPerlConfig.CombatHitIndicator == 1 and XPerlConfig.ShowTargetPortrait == 1) then
			CombatFeedback_OnSpellMissEvent(arg2)
		end
	end
end

-- PLAYER_TARGET_CHANGED
function XPerl_Target_Events:PLAYER_TARGET_CHANGED()
	XPerl_Target.PlayerFlash = 0
	XPerl_Target_CombatFlash(0, false)
	XPerl_Target_UpdateDisplay()
	XPerl_Target_UpdatePortrait()
	return
end

-- UNIT_HEALTH, UNIT_MAXHEALTH
function XPerl_Target_Events:UNIT_HEALTH()
	if (arg1 == "target") then
		XPerl_Target_UpdateHealth()
	end
end
XPerl_Target_Events.UNIT_MAXHEALTH = XPerl_Target_Events.UNIT_HEALTH

-- UNIT_DYNAMIC_FLAGS
function XPerl_Target_Events:UNIT_DYNAMIC_FLAGS()
	if (arg1 == "target") then
		XPerl_Target_UpdateName()
		XPerl_Target_Update_Control()
		XPerl_Target_Update_Combat()
	end
end

XPerl_Target_Events.UNIT_FLAGS = XPerl_Target_Events.UNIT_DYNAMIC_FLAGS

function XPerl_Target_Events:RAID_TARGET_UPDATE()
	XPerl_Update_RaidIcon("target", XPerl_Target_NameFrame_RaidIcon)

	XPerl_Target_NameFrame_RaidIcon:ClearAllPoints()
	if (XPerlConfig.AlternateRaidIcon == 1) then
		XPerl_Target_NameFrame_RaidIcon:SetHeight(16)
		XPerl_Target_NameFrame_RaidIcon:SetWidth(16)
		XPerl_Target_NameFrame_RaidIcon:SetPoint("CENTER", XPerl_Target_NameFrame, "TOPRIGHT", -5, -4)
	else
		XPerl_Target_NameFrame_RaidIcon:SetHeight(32)
		XPerl_Target_NameFrame_RaidIcon:SetWidth(32)
		XPerl_Target_NameFrame_RaidIcon:SetPoint("CENTER", XPerl_Target_NameFrame, "CENTER", 0, 0)
	end
end

-- UNIT_MANA, UNIT_MAXMANA, UNIT_RAGE, UNIT_MAXRAGE, UNIT_ENERGY
-- UNIT_MAXENERGY, UNIT_FOCUS, UNIT_MAXFOCUS
function XPerl_Target_Events:UNIT_MANA()
	if (arg1 == "target") then
		XPerl_Target_UpdateMana()
	end
end
XPerl_Target_Events.UNIT_MAXMANA		= XPerl_Target_Events.UNIT_MANA
XPerl_Target_Events.UNIT_RAGE		= XPerl_Target_Events.UNIT_MANA
XPerl_Target_Events.UNIT_MAXRAGE		= XPerl_Target_Events.UNIT_MANA
XPerl_Target_Events.UNIT_ENERGY		= XPerl_Target_Events.UNIT_MANA
XPerl_Target_Events.UNIT_MAXENERGY	= XPerl_Target_Events.UNIT_MANA
XPerl_Target_Events.UNIT_FOCUS		= XPerl_Target_Events.UNIT_MANA
XPerl_Target_Events.UNIT_MAXFOCUS	= XPerl_Target_Events.UNIT_MANA

-- UNIT_DISPLAYPOWER
function XPerl_Target_Events:UNIT_DISPLAYPOWER()
	if (arg1 == "target") then
		XPerl_Target_UpdateManaType()
		XPerl_Target_UpdateMana()
	end
end

-- UNIT_MODEL_CHANGED
function XPerl_Target_Events:UNIT_MODEL_CHANGED()
	if (arg1 == "target") then
		XPerl_Target_UpdatePortrait()
	end
end
--XPerl_Target_Events.UNIT_PORTRAIT_UPDATE = XPerl_Target_Events.UNIT_MODEL_CHANGED

-- UNIT_NAME_UPDATE
function XPerl_Target_Events:UNIT_NAME_UPDATE()
	if (arg1 == "target") then
		XPerl_Target_UpdateName()
	end
end

-- UNIT_LEVEL
function XPerl_Target_Events:UNIT_LEVEL()
	if (arg1 == "target") then
		XPerl_Target_UpdateLevel()
	end
end

-- UNIT_CLASSIFICATION_CHANGED
function XPerl_Target_Events:UNIT_CLASSIFICATION_CHANGED()
	if (arg1 == "target") then
		XPerl_Target_UpdateClassification()
	end
end

-- PLAYER_COMBO_POINTS
function XPerl_Target_Events:PLAYER_COMBO_POINTS()
	XPerl_Target_UpdateCombo()
end

-- UNIT_AURA
function XPerl_Target_Events:UNIT_AURA()
	if (arg1 == "target") then
		if (not XPerl_Target.perlBuffs or XPerl_UnitBuff("target", XPerl_Target.perlBuffs + 1, XPerlConfig.TargetCastableBuffs)) then
			XPerl_Targets_BuffPositions("target", "XPerl_Target_", XPerl_Target)
		elseif (XPerl_UnitDebuff("target", XPerl_Target.perlDebuffs + 1, XPerlConfig.TargetCastableBuffs)) then
			XPerl_Targets_BuffPositions("target", "XPerl_Target_", XPerl_Target)
		end

		XPerl_Targets_BuffUpdate("target", "XPerl_Target_", XPerl_Target)
		XPerl_Target_DebuffUpdate()
	end
end

-- UNIT_FACTION
function XPerl_Target_Events:UNIT_FACTION()
	if (arg1 == "target") then
		XPerl_Target_UpdatePVP()
		XPerl_Target_Update_Control()
		XPerl_Targets_BuffPositions("target", "XPerl_Target_", XPerl_Target)
	end
end

-- PLAYER_FLAGS_CHANGED
function XPerl_Target_Events:PLAYER_FLAGS_CHANGED()
	XPerl_Target_Update_Combat()
	XPerl_Target_UpdatePVP()
	XPerl_Target_UpdateHealth()

end

-- CHAT_MSG_COMBAT_HOSTILE_DEATH
function XPerl_Target_Events:CHAT_MSG_COMBAT_HOSTILE_DEATH()
	if (strfind(arg1, this.lastTarget)) then
		this.lastDeathMsg = arg1
	end
end

-- PARTY_MEMBER_ENABLE
function XPerl_Target_Events:PARTY_MEMBER_ENABLE()
	if (UnitInParty("target") or UnitInRaid("target")) then
		XPerl_Target_Update_Combat()
		XPerl_Target_UpdatePVP()
		XPerl_Target_UpdateHealth()
	end
end

XPerl_Target_Events.PARTY_MEMBER_DISABLE = XPerl_Target_Events.PARTY_MEMBER_ENABLE

-- PARTY_LOOT_METHOD_CHANGED
function XPerl_Target_Events:PARTY_LOOT_METHOD_CHANGED()
	XPerl_Target_UpdateLeader()
	XPerl_Target_UpdateMasterLooter()
end
XPerl_Target_Events.PARTY_MEMBERS_CHANGED = XPerl_Target_Events.PARTY_LOOT_METHOD_CHANGED
XPerl_Target_Events.PARTY_LEADER_CHANGED  = XPerl_Target_Events.PARTY_LOOT_METHOD_CHANGED

-- XPerl_Target_Set_Bits
function XPerl_Target_Set_Bits()
	if (XPerlConfig.ShowTargetPortrait==0) then
		XPerl_Target_PortraitFrame:Hide()
		XPerl_Target_PortraitFrame:SetWidth(2)
		XPerl_Target:SetWidth(160)
	else
		XPerl_Target_PortraitFrame:Show()
		XPerl_Target_PortraitFrame:SetWidth(60)
		XPerl_Target:SetWidth(220)

		XPerl_Target_UpdatePortrait()
	end

	if (XPerlConfig.ShowTargetPercent==0) then
		XPerl_Target_NameFrame:SetWidth(128)
		XPerl_Target_StatsFrame:SetWidth(128)
		XPerl_Target_StatsFrame_HealthBarPercent:Hide()
		XPerl_Target_StatsFrame_ManaBarPercent:Hide()
	else
		XPerl_Target_NameFrame:SetWidth(160)
		XPerl_Target_StatsFrame:SetWidth(160)
		XPerl_Target_StatsFrame_HealthBarPercent:Show()
		XPerl_Target_StatsFrame_ManaBarPercent:Show()
	end

	if (XPerlConfig.ShowTargetLevel==0) then
		XPerl_Target_LevelFrame:Hide()
	else
		XPerl_Target_LevelFrame:Show()
	end

	if (XPerlConfig.ShowTargetClassIcon==0) then
		XPerl_Target_TypeFramePlayer_ClassTexture:Hide()
	else
		XPerl_Target_TypeFramePlayer_ClassTexture:Show()
	end

	if (XPerlConfig.ShowTargetPVPRank == 0) then
		XPerl_Target_NameFrame_PVPRankIcon:Hide()
	else
		XPerl_Target_NameFrame_PVPRankIcon:Show()
	end

	XPerlConfig.TargetBuffSize = tonumber(XPerlConfig.TargetBuffSize) or 20
	XPerl_SetBuffSize("XPerl_Target_", XPerlConfig.TargetBuffSize, XPerlConfig.TargetBuffSize * 1.2)
end

-- Using the Blizzard Combo Point frame, but we move the buttons around a little
function XPerl_Target_Set_BlizzCPFrame()
	ComboFrame:ClearAllPoints()
	ComboPoint1:ClearAllPoints()
	ComboPoint2:ClearAllPoints()
	ComboPoint3:ClearAllPoints()
	ComboPoint4:ClearAllPoints()
	ComboPoint5:ClearAllPoints()

	if (XPerlConfig.BlizzardCPMeter == 1) then
		-- This setup will put the buttons along the top of the portrait frame

		ComboFrame:SetScale(XPerlConfig.Scale_TargetFrame)

		if (XPerlConfig.BlizzardCPPosition == "top") then
			ComboFrame:SetPoint("TOPLEFT", XPerl_Target_PortraitFrame, "TOPLEFT", -1, 4)
			ComboPoint1:SetPoint("TOPLEFT", 0, 0)
			ComboPoint2:SetPoint("LEFT", ComboPoint1, "RIGHT", 0, 1)
			ComboPoint3:SetPoint("LEFT", ComboPoint2, "RIGHT", 0, 1)
			ComboPoint4:SetPoint("LEFT", ComboPoint3, "RIGHT", 0, -1)
			ComboPoint5:SetPoint("LEFT", ComboPoint4, "RIGHT", 0, -4)

		elseif (XPerlConfig.BlizzardCPPosition == "bottom") then
			ComboFrame:SetPoint("BOTTOMLEFT", XPerl_Target_PortraitFrame, "BOTTOMLEFT", -1, -4)
			ComboPoint1:SetPoint("BOTTOMLEFT", 0, 0)
			ComboPoint2:SetPoint("LEFT", ComboPoint1, "RIGHT", 0, -1)
			ComboPoint3:SetPoint("LEFT", ComboPoint2, "RIGHT", 0, -1)
			ComboPoint4:SetPoint("LEFT", ComboPoint3, "RIGHT", 0, 1)
			ComboPoint5:SetPoint("LEFT", ComboPoint4, "RIGHT", 0, -1)

		elseif (XPerlConfig.BlizzardCPPosition == "left") then
			ComboFrame:SetPoint("BOTTOMLEFT", XPerl_Target_PortraitFrame, "BOTTOMLEFT", -1, 0)
			ComboPoint1:SetPoint("BOTTOMLEFT", 0, 0)
			ComboPoint2:SetPoint("BOTTOM", ComboPoint1, "TOP", -1, 0)
			ComboPoint3:SetPoint("BOTTOM", ComboPoint2, "TOP", -1, 0)
			ComboPoint4:SetPoint("BOTTOM", ComboPoint3, "TOP", 1, 0)
			ComboPoint5:SetPoint("BOTTOM", ComboPoint4, "TOP", 3, -5)

		elseif (XPerlConfig.BlizzardCPPosition == "right") then
			ComboFrame:SetPoint("BOTTOMRIGHT", XPerl_Target_PortraitFrame, "BOTTOMRIGHT", 2, 0)
			ComboPoint1:SetPoint("BOTTOMRIGHT", 0, 0)
			ComboPoint2:SetPoint("BOTTOM", ComboPoint1, "TOP", 1, 0)
			ComboPoint3:SetPoint("BOTTOM", ComboPoint2, "TOP", 1, 0)
			ComboPoint4:SetPoint("BOTTOM", ComboPoint3, "TOP", -1, 0)
			ComboPoint5:SetPoint("BOTTOM", ComboPoint4, "TOP", 0, -5)

		end

		ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
		ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
	else
		-- Not using blizzard's, and we'll put the buttons back where they were
--[[		No reason to do this, so commented

		ComboFrame:SetPoint("TOPRIGHT", TargetFrame, "TOPRIGHT", -44, -9)

		ComboPoint1:SetPoint("TOPRIGHT", 0, 0)
		ComboPoint2:SetPoint("TOP", ComboPoint1, "BOTTOM", 7, 4)
		ComboPoint3:SetPoint("TOP", ComboPoint2, "BOTTOM", 5, 2)
		ComboPoint4:SetPoint("TOP", ComboPoint3, "BOTTOM", 2, 1)
		ComboPoint5:SetPoint("TOP", ComboPoint4, "BOTTOM", 0, 1)

		ComboFrame:SetScale(1)
]]
		ComboFrame:Hide()

		ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
		ComboFrame:UnregisterEvent("PLAYER_COMBO_POINTS")
	end
end

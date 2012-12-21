local init_done

-- SetTex
local highlightPositions = {{0, 0.25, 0, 0.5}, {0.25, 0.75, 0, 0.5}, {0, 1, 0.5, 1}, {0.75, 1, 0, 0.5}}
local function SetTex(frame, num)
	if (XPerlConfig.HighlightSelection == 1) then
		frame:SetHighlightTexture("Interface\\Addons\\XPerl\\images\\XPerl_Highlight", "ADD")
		local p = highlightPositions[num]
		local tex = frame:GetHighlightTexture()
		tex:SetTexCoord(p[1], p[2], p[3], p[4])
		tex:SetVertexColor(0.86, 0.82, 0.41)
	else
		frame:SetHighlightTexture("")
	end
end

-- RegisterHighlight
local HighlightFrames = {}
function XPerl_RegisterHighlight(frame, ratio)
	HighlightFrames[frame] = ratio
	if (init_done) then
		SetTex(frame, ratio)
	end
end

-- XPerl_SetHighlights
function XPerl_SetHighlights()
	for k,v in pairs(HighlightFrames) do
		SetTex(k, v)
	end
end

-- SetupUnitFrame
local function SetupUnitFrame(argFrame)
	argFrame:SetBackdropBorderColor(XPerlConfig.BorderColour.r, XPerlConfig.BorderColour.g, XPerlConfig.BorderColour.b, XPerlConfig.BorderColour.a);	--, XPerlConfig.Transparency)
	argFrame:SetBackdropColor(XPerlConfig.BackColour.r, XPerlConfig.BackColour.g, XPerlConfig.BackColour.b, XPerlConfig.BackColour.a);			--XPerlConfig.Transparency)
end

-- SetupUnitFrameList
local function SetupUnitFrameList(frame, subList)
	if (type(subList) == "table") then
		frame:SetAlpha(XPerlConfig.Transparency)

		for k,v in pairs(subList) do
			local f = getglobal(frame:GetName().."_"..v)
			if (f) then
				SetupUnitFrame(f)
			end
		end
	else
		SetupUnitFrame(frame)
	end
end

-- XPerl_RegisterUnitFrame(frame)
local UnitFrames = {}
function XPerl_RegisterPerlFrames(frame, subList)
	if (not subList) then
		subList = true
	end
	UnitFrames[frame] = subList

	if (init_done) then
		SetupUnitFrameList(frame, subList)
	end
end

-- XPerl_SetupAllPerlFrames
function XPerl_SetupAllPerlFrames(frame)
	for k,v in pairs(UnitFrames) do
		SetupUnitFrameList(k, v)
	end
end

-- XPerl_SetAllFrames
function XPerl_SetAllFrames()
	XPerl_SetupAllPerlFrames()
	XPerl_SetHighlights()

	if (Perl_Player_Frame) then		Perl_Player_PVPRankIcon:SetAlpha(0.3)			end
	if (Perl_Target_Frame) then		Perl_Target_PVPRankIcon:SetAlpha(0.3)			end
	if (Perl_TargetTarget) then		Perl_TargetTarget_NameFrame_PVPRankIcon:SetAlpha(0.3)	end
	if (Perl_TargetTargetTarget) then	Perl_TargetTargetTarget_NameFrame_PVPRankIcon:SetAlpha(0.3)	end
end

-- Buff Tooltip Hook
local oldGameTooltipSetPlayerBuff

local function XPerl_GameTooltipSetPlayerBuff(self, id)
	oldGameTooltipSetPlayerBuff(self, id)
	XPerl_ToolTip_AddBuffDuration("player", self)
end

-- XPerl_Init()
function XPerl_Init()
	init_done = true
	if (GameTooltip.SetPlayerBuff ~= XPerl_GameTooltipSetPlayerBuff) then
		oldGameTooltipSetPlayerBuff = GameTooltip.SetPlayerBuff
		GameTooltip.SetPlayerBuff = XPerl_GameTooltipSetPlayerBuff
	end

	-- Check for eCastbar and disable old frame if used.
	if (eCastingBar_Saved and eCastingBar_Player and eCastingBar_Saved[eCastingBar_Player].Enabled == 1) then
		XPerlConfig.OldCastBar = 0
	elseif (BCastBar and BCastingBar and BCastBarDragButton) then
		XPerlConfig.OldCastBar = 0
	end

	if (XPerl_Player) then
		XPerl_Player:Show()
	end

	XPerl_OptionActions()
	XPerl_SlashOnLoad()

	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("PerlButton")
	if (name and enabled) then
		DisableAddOn("PerlButton")
		XPerl_Notice("Disabled 'PerlButton' addon. It is not compatible or needed with X-Perl")
		-- PerlButton was made for Nymbia's Perl UnitFrames. We have our own minimap button
	end

	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("CT_PartyBuffs")
	if (name and enabled) then
		XPerl_Notice("Disable 'CT_PartyBuffs' addon. It is not compatible with X-Perl, and creates display issues.")
	end
	if (CT_PartyBuffFrame1) then
		CT_PartyBuffFrame1:Hide()
		CT_PartyBuffFrame2:Hide()
		CT_PartyBuffFrame3:Hide()
		CT_PartyBuffFrame4:Hide()
		CT_PetBuffFrame:Hide()
	end

	if (EarthFeature_AddButton) then
		local button = {}
		button.name = XPerl_ProductName
		button.icon = XPerl_ModMenuIcon
		button.subtext = "By "..XPerl_Author
		button.tooltip = XPerl_LongDescription
		button.callback = XPerl_Toggle
		EarthFeature_AddButton (button)
	end

	if(CT_RegisterMod) then
		CT_RegisterMod(XPerl_ProductName.." "..XPerl_VersionNumber, "By "..XPerl_Author, 4, XPerl_ModMenuIcon, XPerl_LongDescription, "switch", "", XPerl_Toggle)
	end

	if (myAddOnsFrame) then
                myAddOnsList.XPerl_Description = {
                        name			= XPerl_Description,
                        description		= XPerl_LongDescription,
                        version			= XPerl_VersionNumber,
                        category		= MYADDONS_CATEGORY_OTHERS,
                        frame			= "XPerl_Globals",
                        optionsframe		= "XPerl_Options"
                        }
	end

	if (GroupHeal and GroupHeal.HealButtons) then
		-- Fix button placement on party frames for GroupHeal addon (worked for Nybmia,
		-- but we have our party targets in that old position
		for k, v in GroupHeal.HealButtons[1] do
			v:ClearAllPoints()
			v:SetPoint("TOPLEFT", getglobal(v:GetParent():GetName().."_StatsFrame"), "BOTTOMRIGHT", 0, 2)
		end
	end

	if (not strfind("Zek Hek Zeks Zekked Zekstuff Pooksie", UnitName("player")) or GetRealmName() ~= "Bloodhoof") then
		XPerl_ShowMessage = function() end
	end

	XPerl_Init = nil
end

-- XPerl_StatsFrame_Setup
function XPerl_StatsFrameSetup(StatsFrame, others, offset)

	if (not StatsFrame) then
		return
	end

        local healthBar = getglobal(StatsFrame:GetName().."_HealthBar")
        local healthBarText = getglobal(StatsFrame:GetName().."_HealthBarText")
        local healthBarPercent = getglobal(StatsFrame:GetName().."_HealthBarPercent")
        local manaBar = getglobal(StatsFrame:GetName().."_ManaBar")
        local manaBarPercent = getglobal(StatsFrame:GetName().."_ManaBarPercent")
	local otherBars = {}
	local secondaryBarsShown = 0
	local showPercent = 0
	if (healthBarPercent:IsShown() or manaBarPercent:IsShown()) then
		showPercent = 1
	end
        local percentSize = showPercent * 35;   -- 0 means 0, 1 means 32 offset (+3 for spacing after text), which is our size difference

	offset = (offset or 0)

	if (manaBar:IsShown()) then
		secondaryBarsShown = secondaryBarsShown + 1
	end

	local needTicker = 0
	if (XPerlConfig.EnergyTicker == 1 and StatsFrame == XPerl_Player_StatsFrame and UnitPowerType("player") == 3) then
		needTicker = 1
	end

	if (others) then
		for i,other in pairs(others) do
			local bar = getglobal(StatsFrame:GetName().."_"..other)
			if (bar) then
				tinsert(otherBars, bar)

				if (bar:IsShown()) then
					secondaryBarsShown = secondaryBarsShown + 1
				end
			else
				if (not bar) then XPerl_Notice("No frame found called '"..StatsFrame:GetName().."_"..other.."'"); end
			end
		end
	end

	if (XPerlConfig.FatHealthBars == 1) then
		if (StatsFrame == XPerl_Player_Pet_StatsFrame) then
			healthBarText:SetFontObject(GameFontNormalSmall)
		else
			healthBarText:SetFontObject(GameFontNormal)
		end

        	healthBar:ClearAllPoints()
        	healthBar:SetPoint("TOPLEFT", 5, -5)
        	healthBar:SetPoint("BOTTOMRIGHT", -(5 + percentSize), 5 + needTicker + (secondaryBarsShown * 10))

        	manaBar:ClearAllPoints()
        	manaBar:SetPoint("BOTTOMLEFT", 5, -5 + needTicker + (secondaryBarsShown * 10))
        	manaBar:SetPoint("TOPRIGHT", healthBar, "BOTTOMRIGHT", 0, 0)

		local lastBar = manaBar
		local tickerSpace = needTicker * 2
		for i,bar in pairs(otherBars) do
			if (bar:IsShown()) then
        	        	bar:ClearAllPoints()

        	        	bar:SetPoint("TOPLEFT", lastBar, "BOTTOMLEFT", 0, -tickerSpace)
        	        	bar:SetPoint("BOTTOMRIGHT", lastBar, "BOTTOMRIGHT", 0, -10 - tickerSpace)

				lastBar = bar
				tickerSpace = 0
			end
        	end
	else
		healthBarText:SetFontObject(GameFontNormalSmall)

        	healthBar:ClearAllPoints()
        	healthBar:SetPoint("TOPLEFT", 8, -9 + offset)
        	healthBar:SetPoint("BOTTOMRIGHT", StatsFrame, "TOPRIGHT", -(8 + percentSize), -19 + offset)

        	manaBar:ClearAllPoints()
        	manaBar:SetPoint("TOPLEFT", healthBar, "BOTTOMLEFT", 0, -2)
        	manaBar:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", 0, -12)

		local lastBar = manaBar
		for i,bar in pairs(otherBars) do
			if (bar:IsShown()) then
        	        	bar:ClearAllPoints()

        	        	bar:SetPoint("TOPLEFT", lastBar, "BOTTOMLEFT", 0, -2)
        	        	bar:SetPoint("BOTTOMRIGHT", lastBar, "BOTTOMRIGHT", 0, -12)

				lastBar = bar
			end
        	end
	end
end

-- XPerl_Setup_StatsFrames
function XPerl_Setup_StatsFrames()

	XPerl_StatsFrameSetup(XPerl_Player_StatsFrame, {"DruidBar", "XPBar"})
	XPerl_StatsFrameSetup(XPerl_Player_Pet_StatsFrame, {"XPBar"}, 2)

	XPerl_StatsFrameSetup(XPerl_Target_StatsFrame)
	XPerl_StatsFrameSetup(XPerl_TargetTarget_StatsFrame)
	XPerl_StatsFrameSetup(XPerl_TargetTargetTarget_StatsFrame)

	for i = 1,4 do
		XPerl_StatsFrameSetup(getglobal("XPerl_party"..i.."_StatsFrame"))
		XPerl_StatsFrameSetup(getglobal("XPerl_partypet"..i.."_StatsFrame"), nil, 2)
	end
end

-- XPerl_SetTransparency
local function XPerl_SetTransparency(num)
	local function Alpha(unit)
		if (UnitIsConnected(unit)) then
			return num
		else
			return num / 2
		end
	end

	local function SetAlpha(f, a)
		if (f) then
			f:SetAlpha(a)
		end
	end

	SetAlpha(XPerl_Player, num)
	SetAlpha(XPerl_Target, Alpha("target"))
	SetAlpha(XPerl_TargetTarget, num)
	SetAlpha(XPerl_TargetTargetTarget, num)
	SetAlpha(XPerl_party1, Alpha("party1"))
	SetAlpha(XPerl_party2, Alpha("party2"))
	SetAlpha(XPerl_party3, Alpha("party3"))
	SetAlpha(XPerl_party4, Alpha("party4"))
	SetAlpha(XPerl_partypet1, Alpha("party1"))
	SetAlpha(XPerl_partypet2, Alpha("party2"))
	SetAlpha(XPerl_partypet3, Alpha("party3"))
	SetAlpha(XPerl_partypet4, Alpha("party4"))
	SetAlpha(XPerl_Player_Pet, num)
	SetAlpha(XPerl_ArcaneBarFrame, num/2)
end

-- XPerl_SetTextTransparency
local function XPerl_SetTextTransparency(num)
	local function SetFrame(frame)
		local f = getglobal(frame)

		if (f) then
			f:SetTextColor(1,1,1,XPerlConfig.TextTransparency)
		end
	end

	local function SetSubFrames(frame)
		local subFrames = {"HealthBarText", "HealthBarPercent", "ManaBarText", "ManaBarPercent"}

		for j,f in pairs(subFrames) do
			local n = frame.."_StatsFrame_"..f
			SetFrame(n)
		end
	end

	local statFrames = {"XPerl_Player", "XPerl_Player_Pet", "XPerl_Target", "XPerl_TargetTarget", "XPerl_TargetTargetTarget",
				"XPerl_party1", "XPerl_party2", "XPerl_party3", "XPerl_party4",
				"XPerl_partypet1", "XPerl_partypet2", "XPerl_partypet3", "XPerl_partypet4"}

	for i,f in pairs(statFrames) do
		SetSubFrames(f)
	end

	if (XPerl_Player) then
		XPerl_Player_StatsFrame_DruidBarText:SetTextColor(1,1,1,XPerlConfig.TextTransparency)
		XPerl_Player_StatsFrame_DruidBarPercent:SetTextColor(1,1,1,XPerlConfig.TextTransparency)
		XPerl_Player_StatsFrame_XPBarText:SetTextColor(1,1,1,XPerlConfig.TextTransparency)
		XPerl_Player_StatsFrame_XPBarPercent:SetTextColor(1,1,1,XPerlConfig.TextTransparency)
	end
end

-- XPerl_GetBarTexture
function XPerl_GetBarTexture()
	if (XPerlConfig.BarTextures == 1) then
		return "Interface\\AddOns\\XPerl\\Images\\XPerl_StatusBar"
	elseif (XPerlConfig.BarTextures == 2) then
		return "Interface\\AddOns\\XPerl\\Images\\XPerl_StatusBar2"
	elseif (XPerlConfig.BarTextures == 3) then
		return "Interface\\AddOns\\XPerl\\Images\\XPerl_StatusBar3"
	else
		return "Interface\\TargetingFrame\\UI-StatusBar"
	end
end

-- Set1Bar
local function Set1Bar(bar, tex)
	local f = getglobal(bar:GetName().."Tex")
	if (f) then
		f:SetTexture(tex)
	end
	f = getglobal(bar:GetName().."BG")
	if (f) then
		if (XPerlConfig.BackgroundTextures == 1) then
			f:SetTexture(tex)
		else
			f:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end
	end
end

-- XPerl_RegisterBar
local XPerlBars = {}
function XPerl_RegisterBar(bar)
	tinsert(XPerlBars, bar)
	if (init_done) then
		local tex = XPerl_GetBarTexture()
		Set1Bar(bar, tex)
	end
end

-- XPerl_SetBarTextures
function XPerl_SetBarTextures()
	local tex = XPerl_GetBarTexture()
	for k,v in pairs(XPerlBars) do
		Set1Bar(v, tex)
	end
end

-- SetCastParty
local function SetCastParty()
	if (CastPartyMainFrame) then
		CastPartyMainFrame:Hide()
	elseif (CastPartyFrame0 and CastPartyFrame1 and CastPartyFrame2) then
		CastPartyFrame0:Hide()
		CastPartyFrame1:Hide()
		CastPartyFrame2:Hide()
	end
end

-- XPerl_OptionActions()
function XPerl_OptionActions()

	local function ValidAlpha(alpha)
		alpha = tonumber(alpha)
		if (alpha < 0 or alpha > 1) then
			alpha = 1
		end
		return alpha
	end

	local function ValidScale(scale)
		scale = tonumber(scale)
		if (scale < 0.5) then
			scale = 0.5
		elseif (scale > XPerlConfig.MaximumScale) then
			scale = XPerlConfig.MaximumScale
		end
		return scale
	end

	if (XPerl_Player) then
		XPerl_Player_Set_Bits()
	end
	if (XPerl_Player_Pet) then
		XPerl_Player_Pet_Set_Bits()
	end
	if (XPerl_Target) then
		XPerl_Target_Set_Bits()
		XPerl_Target_Set_BlizzCPFrame()
	end
	if (XPerl_TargetTarget) then
		XPerl_TargetTarget_Set_Bits()
	end
	if (XPerl_party1) then
		XPerl_Party_Set_Bits()
	end
	if (XPerl_partypet1) then
		XPerl_Party_Pet_Set_Name()
	end

	XPerlConfig.Transparency = ValidAlpha(XPerlConfig.Transparency)

	XPerlConfig.TextTransparency = ValidAlpha(XPerlConfig.TextTransparency)
	XPerl_SetTextTransparency(XPerlConfig.TextTransparency)

	XPerlConfig.Scale_PlayerFrame = ValidScale(XPerlConfig.Scale_PlayerFrame)
	if (XPerl_Player) then
		XPerl_Player:SetScale(XPerlConfig.Scale_PlayerFrame)
	end

	XPerlConfig.Scale_PetFrame = ValidScale(XPerlConfig.Scale_PetFrame)
	if (XPerl_Player_Pet) then
		XPerl_Player_Pet:SetScale(XPerlConfig.Scale_PetFrame)
	end

	XPerlConfig.Scale_PartyFrame = ValidScale(XPerlConfig.Scale_PartyFrame)
	if (XPerl_ScaleParty) then
		XPerl_ScaleParty(XPerlConfig.Scale_PartyFrame)
	end

	XPerlConfig.Scale_PartyPets = ValidScale(XPerlConfig.Scale_PartyPets)
	if (XPerl_ScalePartyPets) then
		XPerl_ScalePartyPets(XPerlConfig.Scale_PartyPets)
	end

	XPerlConfig.Scale_TargetFrame = ValidScale(XPerlConfig.Scale_TargetFrame)
	XPerlConfig.Scale_TargetTargetFrame = ValidScale(XPerlConfig.Scale_TargetTargetFrame)
	if (XPerl_Target) then
		XPerl_Target:SetScale(XPerlConfig.Scale_TargetFrame)
	end
	if (XPerl_ScaleTargetTarget) then
		XPerl_ScaleTargetTarget(XPerlConfig.Scale_TargetTargetFrame)
	end

	XPerlConfig.Scale_Raid = ValidScale(XPerlConfig.Scale_Raid)
	if (XPerl_ScaleRaid) then
		XPerl_ScaleRaid(XPerlConfig.Scale_Raid)
	end

	if (XPerl_ArcaneBarFrame) then
		XPerl_ArcaneBar_Set()
	end

	SetCastParty()
	XPerl_SetBarTextures()
	XPerl_Setup_StatsFrames()

	XPerl_SetAllFrames()
	XPerl_SetTransparency(XPerlConfig.Transparency)

	if (XPerl_Player) then				XPerl_Player_UpdateDisplay()		end
	if (XPerl_Player_Pet_UpdateDisplay) then	XPerl_Player_Pet_UpdateDisplay ()	end
	if (XPerl_Target) then				XPerl_Target_UpdateDisplay()		end
	if (XPerl_TargetTarget) then
		XPerl_TargetTarget_UpdateDisplay(XPerl_TargetTarget)
		if (XPerl_TargetTargetTarget) then
			XPerl_TargetTarget_UpdateDisplay(XPerl_TargetTargetTarget)
		end
	end

	if (XPerl_party1) then				XPerl_Party_UpdateDisplayAll()		end
	if (XPerl_partypet1) then			XPerl_Party_Pet_UpdateDisplayAll()	end

	if (XPerl_Raid_Position) then
		if (XPerl_raid1) then
			XPerl_Raid_Set_Bits()
			XPerl_Raid_Position()
			XPerl_RaidTitles()
		end
	end
end

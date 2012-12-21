-- Colour tables now taken from WoW values (Since 1.6.4) - Well, we want to be ready when there's Paladin and Shaman in same raid
-- and we can leave the colour choice up to Blizzard and it'll just all work.

-- We craeted our string based colour table from Blizzard's raid colour table in
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

-- XPerl_GetClassColour
function XPerl_GetClassColour(class)
	if (class) then
		local color = RAID_CLASS_COLORS[class];		-- Now using the WoW class color table
		if (color) then
			return color
		end
	end
	return {r = 0.5, g = 0.5, b = 1}
end

-- OtherClickHandlers
local function OtherClickHandlers(button, unitid)

	if (XPerlConfig.CastPartyRaidOnly == 0 or string.sub(unitid, 1, 4) == "raid") then
		if (CastParty_OnClickByUnit and CastPartyConfig) then		-- Cast Party
   			local function CastParty_BuildActionKey(button)
				local action_key = ""
				if IsAltKeyDown() then
					action_key = action_key .. 'Alt'
				end
				if IsControlKeyDown() then
					action_key = action_key .. 'Ctrl'
				end
				if IsShiftKeyDown() then
					action_key = action_key .. 'Shift'
				end
				if action_key == "" then
					action_key = "None"
				end
				return action_key
   			end

			local action_key = CastParty_BuildActionKey()
   			local action = CastPartyConfig.key_bindings[button][action_key]

			if (action ~= "CastParty_WoWDefaultClick" and action ~= "CastParty_PartyDropDown" and action ~= CASTPARTY_KEYBINDINGS_NONE) then
				CastParty_OnClickByUnit(button, unitid)
				return true
			end

		elseif (Genesis_MouseHeal) then					-- Genesis Clicks
			if (Genesis_MouseHeal(unitid, button)) then
				return true
			end

		elseif (JC_CatchKeyBinding) then				-- JustClick
			if (JC_CatchKeyBinding(button, unit)) then
				return true
			end

		elseif (CH_Config and CH_Config.PCUFEnabled and CH_UnitClicked) then	-- Click Heal
  			local mb = CH_BuildMouseButton(button)
  			actionType = CH_MouseSpells.Friend[mb]
			if (actionType ~= "MENU" and actionType ~= "TARGET" and actionType ~= "TOOLTIP") then
				CH_UnitClicked(unitid, button)
				return true
			end

		elseif (SmartHeal and SmartHeal.DefaultClick and SmartHeal.ClickHeal and SmartHeal.GetClickHealButton and SmartHeal.Loaded and SmartHeal.getConfig and SmartHeal:getConfig("enable") and SmartHeal:getConfig("enable", "clickmode")) then
			local KeyDownType = SmartHeal:GetClickHealButton()		-- Smart Heal
			if(KeyDownType and KeyDownType ~= "undetermined") then
				SmartHeal:ClickHeal(KeyDownType..button, unitid)
				return true
			end
		end
	end
end

-- XPerl_Frame_FindID
-- Compatibility function
-- Same function used as Perl_Party_FindID, Perl_Party_Pet_FindID, Perl_Raid_FindID
function XPerl_Frame_FindID(object)
	local _, _, num = strfind(object:GetName(), "(%d+)")
	return tonumber(num)
end

-- XPerl_OnClick_Handler
function XPerl_OnClick_Handler(button, unitid)

	-- 1.8.3 - Moved these tests before click handlers for consistancy
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
		end
	elseif (button == "RightButton") then
		if (SpellIsTargeting()) then
			SpellStopTargeting()
			return true
		end
	end

	if (type(Perl_Custom_ClickFunction) == "function") then
		if (Perl_Custom_ClickFunction(button, unitid)) then
			-- Perl_Custom_ClickFunction should return true if handled, then we do nothing more.
			-- no return and we'll continue with default X-Perl behaviour
			return true
		end
	end

	if (XPerlConfig.CastParty == 1) then
		local frame = getglobal(this:GetName().."_NameFrame")
		if (not frame or not MouseIsOver(frame)) then
			-- Name frame gives default behaviour

			if (OtherClickHandlers(button, unitid)) then
				return true
			end
		end
	end

	if (button == "LeftButton") then
		TargetUnit(unitid)
		return true
	end
end

---------------------------------
--Loading Function             --
---------------------------------

-- XPerl_DisallowClear
--function XPerl_DisallowClear()
--	return AceLibrary and AceLibrary:HasInstance("Jostle-2.0")
--end

-- XPerl_BlizzFramesDisable
function XPerl_BlizzFramesDisable()
	local XPerl_DummyFrame
	local XPerl_DummyFunc

	--if (XPerl_DisallowClear()) then
	--	XPerlConfig.ClearBlizzardFrames = 0
	--end

	if (XPerlConfig.ClearBlizzardFrames == 1) then
		XPerl_DummyFrame = CreateFrame("Frame")
		XPerl_DummyFunc = function() end
	end

	if (XPerl_Player) then
		-- Blizz Player Frame Events
		PlayerFrame:UnregisterAllEvents()
		PlayerFrameHealthBar:UnregisterAllEvents()
		PlayerFrameManaBar:UnregisterAllEvents()
		PlayerFrame:Hide()
		-- Make it so it won't be visible, even if shown by another mod
		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)

		if (XPerlConfig.ClearBlizzardFrames == 1) then
			PlayerFrame = XPerl_DummyFrame

			PlayerFrame_OnLoad = nil
			PlayerFrame_Update = nil
			PlayerFrame_UpdatePartyLeader = nil
			PlayerFrame_UpdatePvPStatus = nil
			PlayerFrame_OnEvent = nil
			PlayerFrame_OnUpdate = nil
			PlayerFrame_OnClick = nil
			PlayerFrame_OnReceiveDrag = nil
			PlayerFrame_UpdateStatus = nil
			PlayerFrame_UpdateGroupIndicator = nil
			PlayerFrameDropDown_OnLoad = nil
			PlayerFrame_UpdatePlaytime = nil
		end
	end

	if (XPerl_Player_Pet) then
		-- Blizz Pet Frame Events
		PetFrame:UnregisterAllEvents()
		PetFrame:Hide()
		PetFrame:ClearAllPoints()
		PetFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)

		if (XPerlConfig.ClearBlizzardFrames == 1) then
			PetFrame = XPerl_DummyFrame

			PetFrame_OnLoad = nil
			PetFrame_Update = nil
			PetFrame_OnEvent = nil
			PetFrame_OnUpdate = nil
			PetFrame_OnClick = nil
			PetFrame_SetHappiness = nil
			PetFrameDropDown_OnLoad = nil
		end
	end

	if (XPerl_Target) then
		-- Blizz Target Frame Events
		TargetFrame:UnregisterAllEvents()
		TargetFrameHealthBar:UnregisterAllEvents()
		TargetFrameManaBar:UnregisterAllEvents()
		TargetFrame:Hide()
		TargetofTargetFrame:UnregisterAllEvents()
		TargetofTargetFrame:Hide()
		TargetFrame:ClearAllPoints()
		TargetFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)
		TargetofTargetFrame:ClearAllPoints()
		TargetofTargetFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)

		if (XPerlConfig.ClearBlizzardFrames == 1) then
			TargetFrame = XPerl_DummyFrame
			TargetofTargetFrame = XPerl_DummyFrame

			TargetFrame_OnLoad = nil
			TargetFrame_Update = nil
			TargetFrame_OnEvent = nil
			TargetFrame_OnShow = nil
			TargetFrame_OnHide = nil
			TargetFrame_CheckLevel = nil
			TargetFrame_CheckFaction = nil
			TargetFrame_CheckClassification = nil
			TargetFrame_CheckDead = nil
			TargetFrame_CheckDishonorableKill = nil
			TargetFrame_OnClick = nil
			TargetFrame_OnUpdate = nil
			TargetDebuffButton_Update = nil
			TargetFrame_HealthUpdate = nil
			TargetHealthCheck = nil
			TargetFrameDropDown_OnLoad = nil
			TargetFrame_UpdateRaidTargetIcon = nil

			TargetofTarget_OnUpdate = nil
			TargetofTarget_Update = nil
			TargetofTarget_OnClick = nil
			TargetofTarget_CheckDead = nil
			TargetofTargetHealthCheck = nil
		end
	end

	if (XPerl_party1) then
		-- Blizz Party Events
		ShowPartyFrame = function() end
		HidePartyFrame = ShowPartyFrame
		for num = 1, 4 do
			local f = getglobal("PartyMemberFrame"..num)
			f:Hide()
			f:UnregisterAllEvents()
			getglobal("PartyMemberFrame"..num.."HealthBar"):UnregisterAllEvents()
			getglobal("PartyMemberFrame"..num.."ManaBar"):UnregisterAllEvents()

			f:ClearAllPoints()
			f:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)
		end

		if (XPerlConfig.ClearBlizzardFrames == 1) then
			for num = 1, 4 do
				setglobal("PartyMemberFrame"..num, XPerl_DummyFrame)
			end
			PartyMemberFrame_OnLoad = nil
			PartyMemberFrame_UpdateMember = nil
			PartyMemberFrame_UpdatePet = XPerl_DummyFunc		-- Called when you press OK on interface options
			PartyMemberFrame_UpdateMemberHealth = nil
			PartyMemberFrame_UpdateLeader = nil
			PartyMemberFrame_UpdatePvPStatus = nil
			PartyMemberFrame_OnEvent = nil
			PartyMemberFrame_OnUpdate = nil
			PartyMemberFrame_OnClick = nil
			PartyMemberPetFrame_OnClick = nil
			PartyMemberFrame_RefreshPetBuffs = nil
			PartyMemberBuffTooltip_Update = nil
			PartyMemberHealthCheck = nil
			PartyFrameDropDown_OnLoad = nil
			UpdatePartyMemberBackground = nil
			PartyMemberBackground_ToggleOpacity = nil
			PartyMemberBackground_SetOpacity = nil
			PartyMemberBackground_SaveOpacity = nil
		end
	end
	XPerl_BlizzFramesDisable = nil
end

---------------------------------
--Smooth Health Bar Color      --
---------------------------------
function XPerl_SetSmoothBarColor (bar, percentage)
	if (bar) then
		--local barmin, barmax = bar:GetMinMaxValues()
		--if (barmin == barmax) then
		--	return false
		--end
		--local percentage = bar:GetValue()/(barmax-barmin)

		local r, g, b
		if (XPerlConfig.ClassicHealthBar == 1) then
			if (percentage < 0.5) then
				r = 1
				g = 2*percentage
				b = 0
			else
				g = 1
				r = 2*(1 - percentage)
				b = 0
			end
		else
			r = XPerlConfig.ColourHealthEmpty.r + ((XPerlConfig.ColourHealthFull.r - XPerlConfig.ColourHealthEmpty.r) * percentage)
			g = XPerlConfig.ColourHealthEmpty.g + ((XPerlConfig.ColourHealthFull.g - XPerlConfig.ColourHealthEmpty.g) * percentage)
			b = XPerlConfig.ColourHealthEmpty.b + ((XPerlConfig.ColourHealthFull.b - XPerlConfig.ColourHealthEmpty.b) * percentage)
		end

		if (r >= 0 and g >= 0 and b >= 0 and r <= 1 and g <= 1 and b <= 1) then
			bar:SetStatusBarColor(r, g, b)

			local backBar = getglobal(bar:GetName().."BG")
			if (backBar) then
				backBar:SetVertexColor(r, g, b, 0.25)
			end
		end
	end
end

-- XPerl_SetHealthBar
function XPerl_SetHealthBar(bar, hp, max)
	bar:SetMinMaxValues(0, max)
	if (XPerlConfig.InverseBars == 1) then
		bar:SetValue(max - hp)
	else
		bar:SetValue(hp)
	end

	local percent = hp / max
	local healthPct = string.format("%3.0f", percent * 100)

	XPerl_SetSmoothBarColor(bar, percent)

	local barPct = getglobal(bar:GetName().."Percent")
	if (barPct) then
		barPct:SetText(healthPct.."%")
	end

	local barText = getglobal(bar:GetName().."Text")
	if (barText) then
		if (XPerlConfig.HealerMode == 1) then
			if (XPerlConfig.HealerModeType == 1) then
				barText:SetText(string.format("%d/%d", hp - max, max))
			else
				barText:SetText(hp - max)
			end
		else
			barText:SetText(hp.."/"..max)
		end
	end
end

---------------------------------
--Class Icon Location Functions--
---------------------------------
function XPerl_ClassPos (class)
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

-- XPerl_Toggle
function XPerl_Toggle()
	if (XPerlLocked == 1) then
		XPerl_UnlockFrames()
	else
		XPerl_LockFrames()
	end
end

-- XPerl_UnlockFrames
function XPerl_UnlockFrames()
	EnableAddOn("XPerl_Options")
	if (not IsAddOnLoaded("XPerl_Options")) then
		UIParentLoadAddOn("XPerl_Options")
	end

	XPerlLocked = 0
	if (XPerl_RaidShowAllTitles) then
		XPerl_RaidShowAllTitles()
	end

	if (XPerl_Options) then
		XPerl_Options:Show()
		XPerl_Options:SetAlpha(0)
		XPerl_Options.Fading = "in"
	end
end

-- XPerl_LockFrames
function XPerl_LockFrames()
	XPerlLocked = 1
	if (XPerl_Options) then
		XPerl_Options.Fading = "out"
	end

	if (XPerl_RaidTitles) then
		XPerl_RaidTitles()
	end
end

-- Minimap Icon
function XPerl_MinimapButton_OnClick()
	XPerl_Toggle()
end

-- XPerl_MinimapButton_Init
function XPerl_MinimapButton_Init()
	if(XPerlConfig.MinimapButtonShown == 1) then
		XPerl_MinimapButton_Frame:Show()
	else
		XPerl_MinimapButton_Frame:Hide()
	end
end

-- XPerl_MinimapButton_UpdatePosition
function XPerl_MinimapButton_UpdatePosition()
	XPerl_MinimapButton_Frame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(XPerlConfig.MinimapButtonPosition)),
		(78 * sin(XPerlConfig.MinimapButtonPosition)) - 55
	)
	XPerl_MinimapButton_Init()
end

-- XPerl_MinimapButton_Dragging
function XPerl_MinimapButton_Dragging()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	XPerl_MinimapButton_SetPosition(math.deg(math.atan2(ypos,xpos)))
end

-- XPerl_MinimapButton_SetPosition
function XPerl_MinimapButton_SetPosition(v)
	if (v < 0) then
		v = v + 360
	end

	XPerlConfig.MinimapButtonPosition = v
	XPerl_MinimapButton_UpdatePosition()
end

-- XPerl_MinimapButton_OnEnter
function XPerl_MinimapButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT")
	GameTooltip:SetText(XPerl_Version, 1, 1, 1)
	GameTooltip:AddLine(XPERL_MINIMAP_HELP1)
	GameTooltip:AddLine(XPERL_MINIMAP_HELP2)
	GameTooltip:Show()
end

-- XPerl_SetManaBarType
local ManaColours = {"ColourMana", "ColourRage", "ColourFocus", "ColourEnergy"}
function XPerl_SetManaBarType(argUnit, argFrame, argFrameBG)
	local power = UnitPowerType(argUnit)
	if (power) then
		local colour = XPerlConfig[ManaColours[power + 1]]

		argFrame:SetStatusBarColor(colour.r, colour.g, colour.b, 1)
		argFrameBG:SetVertexColor(colour.r, colour.g, colour.b, 0.25)
	end
end

-- XPerl_PlayerTip
function XPerl_PlayerTip(unitid)

        if (SpellIsTargeting()) then
                if (SpellCanTargetUnit(unitid)) then
                        SetCursor("CAST_CURSOR")
                else
                        SetCursor("CAST_ERROR_CURSOR")
                end
        end

	GameTooltip_SetDefaultAnchor(GameTooltip, this)
	GameTooltip:SetUnit(unitid)

	if (XPerl_RaidTipExtra) then
		XPerl_RaidTipExtra(unitid)
	end

	if (XPerlConfig.XPerlTooltipInfo == 1 and XPerl_GetUsage) then
		local xpUsage = XPerl_GetUsage(UnitName(unitid))
		if (xpUsage) then
			local xp, any = "|cFFD00000X-Perl|r "
			if (xpUsage.version) then
				xp = xp..xpUsage.version
				any = true
			end
			if (xpUsage.mods and IsShiftKeyDown()) then
				local modList = XPerl_DecodeModuleList(xpUsage.mods)
				if (modList) then
					xp = xp.." : |c00909090"..modList
				end
			end
			if (any) then
				GameTooltip:AddLine(xp, 1, 1, 1, 1)
				GameTooltip:Show()
			end
		end
	end
end

-- XPerl_PlayerTipHide
function XPerl_PlayerTipHide()
	if (XPerlConfig.FadingTooltip == 1) then
		GameTooltip:FadeOut()
	else
		GameTooltip:Hide()
	end
end

-- XPerl_ToolTip_AddBuffDuration
function XPerl_ToolTip_AddBuffDuration(partyid, x)
	if (XPerl_Raid_AddBuffDuration) then
		XPerl_Raid_AddBuffDuration(partyid, x)
	end
end

-- XPerl_ColourFriendlyUnit
function XPerl_ColourFriendlyUnit(frame, partyid)
	local color
	if (UnitCanAttack("player", partyid) and UnitIsEnemy("player", partyid)) then	-- For dueling
		color = XPerlConfig.ColourReactionEnemy
	else
		if (XPerlConfig.ClassColouredNames == 1) then
			local _, engClass = UnitClass(partyid)
			color = XPerl_GetClassColour(engClass)
		else
			if (UnitIsPVP(partyid)) then
				color = XPerlConfig.ColourReactionFriend
			else
				color = XPerlConfig.ColourReactionNone
			end
		end
	end

	frame:SetTextColor(color.r, color.g, color.b)
end

-- XPerl_ReactionColour
function XPerl_ReactionColour(argUnit)

        if (UnitPlayerControlled(argUnit) or not UnitIsVisible(argUnit)) then
                if (UnitFactionGroup("player") == UnitFactionGroup(argUnit)) then
                        if (UnitIsEnemy("player", argUnit)) then
				-- Dueling
				return XPerlConfig.ColourReactionEnemy

                        elseif (UnitIsPVP(argUnit)) then
				return XPerlConfig.ColourReactionFriend
			end
		else
                        if (UnitIsPVP(argUnit)) then
				if (UnitIsPVP("player")) then
					return XPerlConfig.ColourReactionEnemy
				else
					return XPerlConfig.ColourReactionNeutral
				end
			end
		end
	else
                if (UnitIsTapped(argUnit) and not UnitIsTappedByPlayer(argUnit)) then
                        color = XPerlConfig.ColourTapped
                else
			local reaction = UnitReaction(argUnit, "player")
			if (reaction) then
				if (reaction >= 5) then
					return XPerlConfig.ColourReactionFriend
				elseif (reaction <= 2) then
					return XPerlConfig.ColourReactionEnemy
				elseif (reaction == 3) then
					return XPerlConfig.ColourReactionUnfriendly
				else
					return XPerlConfig.ColourReactionNeutral
				end
			else
				if (UnitFactionGroup("player") == UnitFactionGroup(argUnit)) then
					return XPerlConfig.ColourReactionFriend
				elseif (UnitIsEnemy("player", argUnit)) then
					return XPerlConfig.ColourReactionEnemy
				else
					return XPerlConfig.ColourReactionNeutral
				end
			end
		end
	end

	return XPerlConfig.ColourReactionNone
end

-- XPerl_SetUnitNameColor
function XPerl_SetUnitNameColor(argUnit,argFrame)

        if (UnitPlayerControlled(argUnit) or not UnitIsVisible(argUnit)) then
		-- 1.8.3 - Changed to override pvp name colours
		if (XPerlConfig.ClassColouredNames == 1) then
			local _, class = UnitClass(argUnit)
			color = XPerl_GetClassColour(class)
		else
			color = XPerl_ReactionColour(argUnit)
		end
	else
                if (UnitIsTapped(argUnit) and not UnitIsTappedByPlayer(argUnit)) then
                        color = XPerlConfig.ColourTapped
                else
			color = XPerl_ReactionColour(argUnit)
		end
	end

	argFrame:SetTextColor(color.r, color.g, color.b, XPerlConfig.TextTransparency)
end

local BasicEvents = {"UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_ENERGY", "UNIT_MAXENERGY",
			"UNIT_MANA", "UNIT_MAXMANA", "UNIT_HEALTH", "UNIT_MAXHEALTH",
			"UNIT_LEVEL", "UNIT_COMBAT", "UNIT_DISPLAYPOWER", "UNIT_NAME_UPDATE"}

-- XPerl_RegisterBasics
function XPerl_RegisterBasics(argFrame)
	if (argFrame == nil) then
		argFrame = this
	end
	for i,event in pairs(BasicEvents) do
		argFrame:RegisterEvent(event)
	end
end

-- XPerl_UnregisterBasics
function XPerl_UnregisterBasics(argFrame)
	if (argFrame == nil) then
		argFrame = this
	end
	for i,event in pairs(BasicEvents) do
		argFrame:UnregisterEvent(event)
	end
end

-- PerlSetPortrait3D
function XPerlSetPortrait3D(argFrame, argUnit)
--[[	if (argUnit == "player") then
		-- If it's ourself, we can check if we're going to 'look' different, and update anyway
		-- Many updates requests are false though, and no real change is made

		local head, shoulders, chest
		head = GetInventoryItemTexture("player", 1)
		shoulders = GetInventoryItemTexture("player", 3)
		chest = GetInventoryItemTexture("player", 5)

		if (argFrame.lastHead ~= head or argFrame.lastShoulders ~= shoulders or argFrame.lastChest ~= chest) then
			argFrame.last3DTime = nil
		end

		argFrame.lastHead = head
		argFrame.lastShoulders = shoulders
		argFrame.lastChest = chest
	else
		-- If someone else, check their name and update if changed
		local name = UnitName(argUnit)
		if (argFrame.lastName ~= name) then
			argFrame.last3DTime = nil
		end
		argFrame.lastName = name
	end

	if (argFrame.last3DTime) then
		-- 1.8.5 change
		-- Don't update the portrait so often, at least 15 seconds must pass before each update now
		if (argFrame.last3DTime < GetTime() + 15) then
			argFrame:SetCamera(0)
			return
		end
	end
]]
	argFrame:ClearModel()
	argFrame:SetUnit(argUnit)
	argFrame:SetCamera(0)

--	argFrame.last3DTime = GetTime()
end

-- XPerl_CombatFlashSet
function XPerl_CombatFlashSet (elapsed, argFrame, argNew, argGreen)
	if (XPerlConfig.PerlCombatFlash == 0) then
		argFrame.PlayerFlash = nil
		return false
	end

	if (argFrame) then
		if (argNew) then
			argFrame.PlayerFlash = 1
			argFrame.PlayerFlashGreen = argGreen
		else
			if (argFrame.PlayerFlash and elapsed) then
				argFrame.PlayerFlash = argFrame.PlayerFlash - elapsed

				if (argFrame.PlayerFlash <= 0) then
					argFrame.PlayerFlash = 0
					argFrame.PlayerFlashTime = nil
					argFrame.PlayerFlashGreen = nil
				end
			else
				return false
			end
		end

		return true
	end
end

-- XPerl_CombatFlashSetFrames
function XPerl_CombatFlashSetFrames(argFrame)
	if (argFrame.PlayerFlash) then
		local baseColour
		if (argFrame.forcedColour) then
			baseColour = argFrame.forcedColour
		else
			baseColour = XPerlConfig.BorderColour
		end

		local r, g, b, a
		if (argFrame.PlayerFlash > 0) then
			local flashOffsetColour = argFrame.PlayerFlash / 2
			if (argFrame.PlayerFlashGreen) then
				r = baseColour.r - flashOffsetColour
				g = baseColour.g + flashOffsetColour
				b = baseColour.b - flashOffsetColour
			else
				r = baseColour.r + flashOffsetColour
				g = baseColour.g - flashOffsetColour
				b = baseColour.b - flashOffsetColour
			end

			if (r < 0) then r = 0; elseif (r > 1) then r = 1; end
			if (g < 0) then g = 0; elseif (g > 1) then g = 1; end
			if (b < 0) then b = 0; elseif (b > 1) then b = 1; end
		else
			r, g, b = baseColour.r, baseColour.g, baseColour.b
		end

		a = XPerlConfig.BorderColour.a
		for i, frame in pairs(argFrame.FlashFrames) do
			frame:SetBackdropBorderColor(r, g, b, a)
		end

		if (argFrame.PlayerFlash == 0) then
			argFrame.PlayerFlash = nil
		end
	end
end

local bgDef = {bgFile = "Interface\\Addons\\XPerl\\Images\\XPerl_FrameBack",
	       edgeFile = "",
	       tile = true, tileSize = 32, edgeSize = 16,
	       insets = { left = 5, right = 5, top = 5, bottom = 5 }
		}

-- XPerl_CheckDebuffs
function XPerl_CheckDebuffs(unit, frames)

	if (XPerlConfig.HighlightDebuffs == 0) then
		return
	end

	local show
	local Curses = {}
	local debuffCount = 0

	for i = 1, MAX_TARGET_DEBUFFS do
		local debuff, debuffStack, debuffType = UnitDebuff(unit, i)

		if (not debuff) then
			break
		end

		if (debuffType) then
			Curses[debuffType] = 1
		else
			Curses["none"] = 1
		end
		debuffCount = debuffCount + 1
	end

	if (debuffCount > 0) then
		if (Curses.Magic) then
			show = "Magic"
		elseif (Curses.Curse) then
			show = "Curse"
		elseif (Curses.Disease) then
			show = "Disease"
		elseif (Curses.Poison) then
			show = "Poison"
		end

		-- We also re-set the colours here so that we highlight best colour per class
		local _, class = UnitClass("player")
		if (class == "MAGE") then
			if (Curses["Curse"]) then
				show = "Curse"
			end

		elseif (class == "DRUID") then
			if (Curses["Curse"]) then
				show = "Curse"
			elseif (Curses["Poison"]) then
				show = "Poison"
			end

		elseif (class == "PRIEST" or class == "WARLOCK") then
			if (Curses["Magic"]) then
				show = "Magic"
			end

		elseif (class == "PALADIN") then
			if (Curses["Magic"]) then
				show = "Magic"
			elseif (Curses["Poison"]) then
				show = "Poison"
			elseif (Curses["Disease"]) then
				show = "Disease"
			end

		elseif (class == "SHAMAN") then
			if (Curses["Poison"]) then
				show = "Poison"
			elseif (Curses["Disease"]) then
				show = "Disease"
			end
		end
	end

	if (frames) then
		local colour, borderColour
		if (show) then
			colour = DebuffTypeColor[show]
			colour.a = 1

			if (XPerlConfig.HighlightDebuffsBorder == 1) then
				borderColour = colour
			else
				borderColour = XPerlConfig.BorderColour
			end
		else
			colour = XPerlConfig.BackColour
			borderColour = XPerlConfig.BorderColour
		end

		for i, f in frames do
			if (f:IsShown()) then
				if (show and XPerlConfig.HighlightDebuffsBorder == 1) then
					f:GetParent().forcedColour = borderColour
					bgDef.edgeFile = "Interface\\Addons\\XPerl\\Images\\XPerl_Curse"
					f:SetBackdrop(bgDef)
				else
					f:GetParent().forcedColour = nil
					bgDef.edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border"
					f:SetBackdrop(bgDef)
				end

				f:SetBackdropColor(colour.r, colour.g, colour.b, colour.a)
				f:SetBackdropBorderColor(borderColour.r, borderColour.g, borderColour.b, borderColour.a)
			end
		end
	end
end

-- XPerl_SavePosition(frame)
function XPerl_SavePosition(frame)
	if (not XPerlConfig.SavedPositions) then
		XPerlConfig.SavedPositions = {}
	end
	XPerlConfig.SavedPositions[frame:GetName()] = {top = frame:GetTop(), left = frame:GetLeft()}
end

-- XPerl_RestorePosition(frame)
function XPerl_RestorePosition(frame)
	if (XPerlConfig.SavedPositions) then
		local pos = XPerlConfig.SavedPositions[frame:GetName()]
		if (pos) then
			if (pos.left or pos.right) then
				frame:ClearAllPoints()
				frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", pos.left, pos.top)
			end
		end
	end
end

-- XPerl_GetRaidPosition
function XPerl_GetRaidPosition(findName)
	for i = 1,GetNumRaidMembers() do
		if (UnitName("raid"..i) == findName) then
			return i
		end
	end
end

-- XPerl_SetBuffSize
function XPerl_SetBuffSize(prefix, sizeBuff, sizeDebuff)
	for i = 1,20 do
		local buff = getglobal(prefix.."BuffFrame_Buff"..i)
		if (buff) then
			buff:SetHeight(sizeBuff)
			buff:SetWidth(sizeBuff)
		end

		local buff = getglobal(prefix.."BuffFrame_DeBuff"..i)
		if (buff) then
			buff:SetHeight(sizeDebuff)
			buff:SetWidth(sizeDebuff)
		end
	end
end

-- true indicates the buff is valid on anyone, otherwise a class string dictates we only count it if the player with the buff matches
local BuffExceptions = {
	--ALL = {Spell_Misc_Food = true},	-- Enable this for food
	PRIEST = {Spell_Nature_ResistNature = true, Spell_Nature_Rejuvenation = true},	-- Druid regens
	DRUID = {Spell_Holy_Renew = true},		-- Priest regens
	WARLOCK = {Spell_Shadow_SoulGem = true},	-- Soulstone Resurrection
	HUNTER = {Spell_Nature_RavenForm = "HUNTER", Ability_Mount_JungleTiger = "HUNTER", Ability_Mount_WhiteTiger = true, Ability_Mount_PinkTiger = "HUNTER", Ability_Hunter_AspectOfTheMonkey = "HUNTER", Spell_Nature_ProtectionformNature = true, Ability_Rogue_FeignDeath = "HUNTER", Ability_Hunter_RunningShot = "HUNTER", Ability_TrueShot = true, Ability_Hunter_BeastTraining = "WARRIOR"},
	ROGUE = {Ability_Stealth = "ROGUE", Spell_Shadow_ShadowWard = "ROGUE", Ability_Vanish = "ROGUE", Ability_Rogue_Sprint = "ROGUE"}
}

local DebuffExceptions = {
	ALL = {INV_Misc_Bandage_08 = true},		-- Recently Bandaged
	PRIEST = {Spell_Holy_AshesToAshes = true}	-- Weakened Soul
}

-- BuffException
--local showInfo
local function BuffException(unit, index, flag, func, exceptions)

	local buff, count, debuffType
	if (not flag or flag == 0 or flag == "0") then
		-- Not filtered, just return it
		buff, count, debuffType = func(unit, index)
		return buff, count, debuffType, index
	end

	buff, count, debuffType = func(unit, index, 1)
	if (buff) then
		-- We need the index of the buff unfiltered later for tooltips
		for i = 1,20 do
			local buff1, count1, debuffType1 = func(unit, index)
			if (buff == buff1 and count == count1) then
				index = i
				break
			end
		end

		return buff, count, debuffType, index
	end

	-- See how many filtered buffs WoW has returned by default
	local normalBuffFilterCount = 0
	for i = 1,20 do
		buff, count, debuffType = func(unit, i, 1)
		if (not buff) then
			normalBuffFilterCount = i - 1
			break
		end
	end

	-- Nothing found by default, so look for exceptions
	local _, class = UnitClass("player")
	local _, unitClass = UnitClass(unit)
	local foundValid = 0
	for i = 1,20 do
		buff, count, debuffType = func(unit, i)

		if (not buff) then
			break
		end

		if (strsub(buff, 1, 16) == "Interface\\Icons\\") then
			local test = strsub(buff, 17)
			local good

			if (exceptions[class]) then
				good = exceptions[class][test]
			elseif (exceptions.ALL) then
				good = exceptions.ALL[test]
			end

			-- Enable this for potions
			--if (not good) then
			--	if (exceptions == BuffExceptions and strsub(test, 1, 11) == "INV_Potion_") then
			--		good = true
			--	end
			--end

			if (good and type(good) == "string" and good ~= unitClass) then
				good = nil
			end

			if (good) then
				foundValid = foundValid + 1
				if (foundValid + normalBuffFilterCount == index) then
					--if (showInfo) then
					--	ChatFrame7:AddMessage("Found extra: "..buff..", requested index == "..index..", actual buff index == "..i)
					--end
					return buff, count, debuffType, i
				end
			end
		end
	end
end

-- XPerl_UnitBuff
function XPerl_UnitBuff(unit, index, flag)
	return BuffException(unit, index, flag, UnitBuff, BuffExceptions)
end

-- XPerl_UnitBuff
function XPerl_UnitDebuff(unit, index, flag)
	return BuffException(unit, index, flag, UnitDebuff, DebuffExceptions)
end

-- XPerl_TooltipSetUnitBuff
-- Retreives the index of the actual unfiltered buff, and uses this on unfiltered tooltip call
function XPerl_TooltipSetUnitBuff(tooltip, unit, ind, flag)
	--showInfo = true
	local buff, count, _, index = BuffException(unit, ind, flag, UnitBuff, BuffExceptions)
	--showInfo = nil
	tooltip:SetUnitBuff(unit, index)
end

-- XPerl_TooltipSetUnitDebuff
-- Retreives the index of the actual unfiltered debuff, and uses this on unfiltered tooltip call
function XPerl_TooltipSetUnitDebuff(tooltip, unit, ind, flag)
	local buff, count, debuffType, index = BuffException(unit, ind, flag, UnitDebuff, DebuffExceptions)
	tooltip:SetUnitDebuff(unit, index)
end

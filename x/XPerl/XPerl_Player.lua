local XPerl_Player_Events = {}

----------------------
-- Loading Function --
----------------------
function XPerl_Player_OnLoad()

	-- Events
	CombatFeedback_Initialize(XPerl_PlayerHitIndicator, 30)
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")
	this:RegisterEvent("VARIABLES_LOADED")

	XPerl_Player_StatsFrame_DruidBar:SetHeight(1)
	XPerl_Player_StatsFrame_DruidBar:Hide()

	--XPerl_Player.PlayerFlash = 0
	XPerl_Player.EnergyTime = 0
	XPerl_Player.EnergyLast = 0

	-- Set here to reduce amount of function calls made - I know it's not much, but we're talking about saving the Universe here!
	-- ... cough
	this:SetScript("OnUpdate", XPerl_Player_OnUpdate)
	this:SetScript("OnEvent", XPerl_Player_OnEvent)
	this:SetScript("OnShow", XPerl_Player_UpdatePortrait)

	this.time = 0

	XPerl_RegisterHighlight(XPerl_Player_CastClickOverlay, 3)
	XPerl_RegisterPerlFrames(XPerl_Player, {"NameFrame", "StatsFrame", "LevelFrame", "PortraitFrame", "GroupFrame"})

	this.FlashFrames = {XPerl_Player_PortraitFrame, XPerl_Player_NameFrame,
				XPerl_Player_LevelFrame, XPerl_Player_StatsFrame}
end

-------------------------
-- The Update Function --
-------------------------

local function XPerl_Player_CombatFlash(elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet (elapsed, XPerl_Player, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(XPerl_Player)
	end
end

function XPerl_Player_UpdatePortrait()
	if (XPerlConfig.ShowPlayerPortrait == 1) then
		if (XPerlConfig.ShowPlayerPortrait3D == 1) then
			XPerl_Player_PortraitFrame_Portrait:Hide()
			XPerl_Player_PortraitFrame_Portrait3D:Show()
			XPerlSetPortrait3D(XPerl_Player_PortraitFrame_Portrait3D, "player")
		else
			XPerl_Player_PortraitFrame_Portrait3D.last3DTime = nil
			XPerl_Player_PortraitFrame_Portrait:Show()
			XPerl_Player_PortraitFrame_Portrait3D:Hide()
			SetPortraitTexture(XPerl_Player_PortraitFrame_Portrait, "player")
		end
	end
end

-- XPerl_Player_UpdateManaType
local function XPerl_Player_UpdateManaType()
	XPerl_SetManaBarType("player", XPerl_Player_StatsFrame_ManaBar, XPerl_Player_StatsFrame_ManaBarBG)

	if (UnitPowerType("player") == 3) then
		XPerl_Player.EnergyEnabled = true
	else
		XPerl_Player.EnergyEnabled = nil
	end
	XPerl_Player_TickerShowHide()
end

-- XPerl_Player_UpdateLeader()
function XPerl_Player_UpdateLeader()
	if (IsPartyLeader()) then
		XPerl_Player_NameFrame_LeaderIcon:Show()
	else
		XPerl_Player_NameFrame_LeaderIcon:Hide()
	end

	if (XPerlConfig.ShowPartyNumber == 1 and UnitInRaid("player")) then
		for i = 1,GetNumRaidMembers() do
			local name, rank, subgroup = GetRaidRosterInfo(i)
			if (name == UnitName("player")) then
				XPerl_Player_GroupFrameGroup:SetText(string.format(XPERL_RAID_GROUP, subgroup))
				XPerl_Player_GroupFrame:Show()
				return
			end
		end
	end

	XPerl_Player_GroupFrame:Hide()
end

-- XPerl_Player_UpdateMasterLooter()
local function XPerl_Player_UpdateMasterLooter()
	local method, index = GetLootMethod()

	if (method == "master" and index == 0) then
		XPerl_Player_NameFrame_MasterIcon:Show()
	else
		XPerl_Player_NameFrame_MasterIcon:Hide()
	end
end

-- XPerl_Player_UpdateName()
local function XPerl_Player_UpdateName()
	XPerl_Player_NameFrame_NameBarText:SetText(UnitName("player"))
end

-- XPerl_Player_UpdateRep
local function XPerl_Player_UpdateRep()
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	local color

	if (name) then
		color = FACTION_BAR_COLORS[reaction]
	else
		name = "none watched"
		max = 1
		min = 0
		value = 0
		color = FACTION_BAR_COLORS[4]
	end

	value = value - min
	max = max - min
	min = 0

	XPerl_Player_StatsFrame_XPRestBar:SetMinMaxValues(0, 1)
	XPerl_Player_StatsFrame_XPRestBar:SetValue(0)

	XPerl_Player_StatsFrame_XPBar:SetMinMaxValues(min, max)
	XPerl_Player_StatsFrame_XPBar:SetValue(value)

	XPerl_Player_StatsFrame_XPBar:SetStatusBarColor(color.r, color.g, color.b, 1)
	XPerl_Player_StatsFrame_XPBarBG:SetVertexColor(color.r, color.g, color.b, 0.25)

	local perc = (value * 100) / max
	XPerl_Player_StatsFrame_XPBarPercent:SetText(string.format("%.1f%%", perc))
	XPerl_Player_StatsFrame_XPBarText:SetText(name)
end

-- XPerl_Player_UpdateXP
local function XPerl_Player_UpdateXP()
	if (UnitLevel("player") == MAX_PLAYER_LEVEL) then
		XPerl_Player_UpdateRep()
		return
	end

	local playerxp = UnitXP("player")
	local playerxpmax = UnitXPMax("player")
	local playerxprest = GetXPExhaustion() or 0
	XPerl_Player_StatsFrame_XPBar:SetMinMaxValues(0, playerxpmax)
	XPerl_Player_StatsFrame_XPRestBar:SetMinMaxValues(0, playerxpmax)
	XPerl_Player_StatsFrame_XPBar:SetValue(playerxp)
	local xptext

	if (playerxpmax > 10000) then
		xptext = string.format("%.0fK/%.0fK", playerxp / 1000, playerxpmax / 1000)
	else
		xptext = playerxp.."/"..playerxpmax
	end

	if (playerxprest > 0) then
		if (playerxpmax > 10000) then
			xptext = xptext .. string.format("(+%.0fK)", playerxprest / 1000)
		else
			xptext = xptext .. string.format("(+%d)", playerxprest)
		end

		color = {r = 0.3, g = 0.3, b = 1}
	else
		color = {r = 0.6, g = 0, b = 0.6}
	end

	XPerl_Player_StatsFrame_XPRestBar:SetValue(playerxp + playerxprest)
	XPerl_Player_StatsFrame_XPBar:SetStatusBarColor(color.r, color.g, color.b, 1)
	XPerl_Player_StatsFrame_XPRestBar:SetStatusBarColor(color.r, color.g, color.b, 0.5)
	XPerl_Player_StatsFrame_XPBarBG:SetVertexColor(color.r, color.g, color.b, 0.25)

	XPerl_Player_StatsFrame_XPBarText:SetText(xptext)

	local xppercenttext=((playerxp * 100.0) / playerxpmax)
	xppercenttext=string.format("%3.0f", xppercenttext)
	XPerl_Player_StatsFrame_XPBarPercent:SetText(xppercenttext.."%")
end

-- XPerl_Player_UpdateCombat
local function XPerl_Player_UpdateCombat()
	if (UnitAffectingCombat("player")) then
		XPerl_Player_NameFrame_NameBarText:SetTextColor(1,0,0)
		XPerl_Player_NameFrame_ActivityStatus:SetTexCoord(0.5, 1.0, 0.0, 0.5)
		XPerl_Player_NameFrame_ActivityStatus:Show()
	else
		if (UnitIsPVP("player")) then
			XPerl_Player_NameFrame_NameBarText:SetTextColor(0,1,0)
		else
			XPerl_ColourFriendlyUnit(XPerl_Player_NameFrame_NameBarText, "player")
		end

		if (IsResting()) then
			XPerl_Player_NameFrame_ActivityStatus:SetTexCoord(0, 0.5, 0.0, 0.5)
			XPerl_Player_NameFrame_ActivityStatus:Show()
		else
			XPerl_Player_NameFrame_ActivityStatus:Hide()
		end
	end

	--if (XPerl_Player_Pet) then
        --	XPerl_Player_Pet_UpdateCombat()
	--end
end

-- XPerl_Player_UpdatePVP
local function XPerl_Player_UpdatePVP()
	local playerrankname, playerrank=GetPVPRankInfo(UnitPVPRank("player"), "player")
	if (playerrank and XPerlConfig.ShowPlayerPVPRank==1) then
		XPerl_Player_NameFrame_PVPRankIcon:Show()
		if (playerrank==0) then
			XPerl_Player_NameFrame_PVPRankIcon:Hide()
		else
			XPerl_Player_NameFrame_PVPRankIcon:SetTexture(string.format("Interface\\PVPRankBadges\\PVPRank%02d", playerrank))
		end
	else
		XPerl_Player_NameFrame_PVPRankIcon:Hide()
	end

	if (XPerlConfig.ShowPlayerClassIcon == 1) then
		local _, PlayerClass = UnitClass("player")
		local r, l, t, b = XPerl_ClassPos(PlayerClass)
		XPerl_Player_ClassTexture:SetTexCoord(r, l, t, b)
	end

	-- PVP Status settings
	if (UnitAffectingCombat("player")) then
		XPerl_Player_NameFrame_NameBarText:SetTextColor(1,0,0)
	elseif (UnitIsPVP("player")) then
		XPerl_Player_NameFrame_NameBarText:SetTextColor(0,1,0);
		if (XPerlConfig.ShowPlayerPVP == 1) then
			XPerl_Player_NameFrame_PVPStatus:Show();
			XPerl_Player_NameFrame_PVPStatus:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..UnitFactionGroup("player"));
		else
			XPerl_Player_NameFrame_PVPStatus:Hide();
		end
	else
		XPerl_Player_NameFrame_PVPStatus:Hide()
		XPerl_ColourFriendlyUnit(XPerl_Player_NameFrame_NameBarText, "player")
	end
end

-- XPerl_Player_Feigning
local function XPerl_Player_Feigning ()
	for buffnum=1,16 do
		local buff = UnitBuff("player", buffnum)
		if (not buff) then
			return
		end
		if (strfind(strlower(buff), "feigndeath")) then
			return true
		end
	end
end

-- XPerl_Player_CheckDeadOrGhost
local function XPerl_Player_CheckDeadOrGhost()
	if (UnitIsDead("player")) then
		if (XPerl_Player_Feigning ()) then
			XPerl_Player_StatsFrame_HealthBarText:SetText(XPERL_LOC_FEIGNDEATH)
			XPerl_Player_StatsFrame_HealthBarText:Show()
			return false
		else
			XPerl_Player_StatsFrame_HealthBarText:SetText(XPERL_LOC_DEAD)
			XPerl_Player_StatsFrame_HealthBarText:Show()
			XPerl_Player_StatsFrame_ManaBarText:Hide()
			return true
		end

	elseif (UnitIsGhost("player")) then
		XPerl_Player_StatsFrame_HealthBarText:SetText(XPERL_LOC_GHOST)
		XPerl_Player_StatsFrame_HealthBarText:Show()
		XPerl_Player_StatsFrame_ManaBarText:Hide()
		return true
	end

	return false
end

-- XPerl_Player_DruidBarUpdate
local function XPerl_Player_DruidBarUpdate()
	XPerl_Player_StatsFrame_DruidBar:SetMinMaxValues(0,DruidBarKey.maxmana)
	XPerl_Player_StatsFrame_DruidBar:SetValue(DruidBarKey.keepthemana)
	manaPct = (DruidBarKey.keepthemana * 100.0) / DruidBarKey.maxmana
	manaPct =  string.format("%3.0f", manaPct)
	XPerl_Player_StatsFrame_DruidBarPercent:SetText(manaPct.."%")
	XPerl_Player_StatsFrame_DruidBarText:SetText(math.floor(DruidBarKey.keepthemana).."/"..DruidBarKey.maxmana)
	if (UnitPowerType("player")>0) then
		if XPerlConfig.ShowPlayerXPBar==1 then
			XPerl_Player_StatsFrame:SetHeight(60)
		else
			XPerl_Player_StatsFrame:SetHeight(50)
		end
		XPerl_Player_StatsFrame_DruidBarText:Show()
		XPerl_Player_StatsFrame_DruidBarPercent:Show()
		XPerl_Player_StatsFrame_DruidBar:Show()
		XPerl_Player_StatsFrame_DruidBar:SetHeight(10)
	else
		if XPerlConfig.ShowPlayerXPBar == 1 then
			XPerl_Player_StatsFrame:SetHeight(50)
		else
			XPerl_Player_StatsFrame:SetHeight(40)
		end
		XPerl_Player_StatsFrame_DruidBarPercent:Hide()
		XPerl_Player_StatsFrame_DruidBarText:Hide()
		XPerl_Player_StatsFrame_DruidBar:Hide()
		XPerl_Player_StatsFrame_DruidBar:SetHeight(1)
	end
	XPerl_StatsFrameSetup(XPerl_Player_StatsFrame, {"DruidBar", "XPBar"})
end

-- XPerl_Player_UpdateMana
local function XPerl_Player_UpdateMana()
	local playermana = UnitMana("player")
	local playermanamax = UnitManaMax("player")
	XPerl_Player_StatsFrame_ManaBar:SetMinMaxValues(0, playermanamax)
	XPerl_Player_StatsFrame_ManaBar:SetValue(playermana)
	manaPct = (playermana * 100.0) / playermanamax
	manaPct =  string.format("%3.0f", manaPct)

	XPerl_Player_StatsFrame_ManaBarText:SetText(playermana.."/"..playermanamax)
	if (UnitPowerType("player")>=1) then
		XPerl_Player_StatsFrame_ManaBarPercent:SetText(playermana)
	else
		XPerl_Player_StatsFrame_ManaBarPercent:SetText(manaPct.."%")
	end

	if (XPerlConfig.ShowPlayerValues == 1) then
		XPerl_Player_StatsFrame_ManaBarText:Show()
	else
		XPerl_Player_StatsFrame_ManaBarText:Hide()
	end

	if (DruidBarKey) then
		local _, engClass = UnitClass("player")
		if (engClass == "DRUID") then
			XPerl_Player_DruidBarUpdate()
		end
	end
end

-- XPerl_Player_UpdateHealth
local function XPerl_Player_UpdateHealth()
	local playerhealth = UnitHealth("player")
	local playerhealthmax = UnitHealthMax("player")

	XPerl_SetHealthBar(XPerl_Player_StatsFrame_HealthBar, playerhealth, playerhealthmax)

	XPerl_Player_CheckDeadOrGhost()
	PlayerStatus_OnUpdate(playerhealth, playerhealthmax)
end

-- XPerl_Player_UpdateLevel
local function XPerl_Player_UpdateLevel()
	XPerl_Player_LevelFrame_LevelBarText:SetText(UnitLevel("player"))
end

-- PlayerStatus_OnUpdate - replaces Blizzard code
function PlayerStatus_OnUpdate(val, max)
	if (XPerlConfig.FullScreenStatus == 1) then
		if (val and max) then
			local test = val / max

			if ( test <= 0.2 and not LowHealthFrame.flashing) then
				UIFrameFlash(LowHealthFrame, 0.5, 0.5, 100);
				LowHealthFrame.flashing = 1;
			elseif ( (test > 0.1 and LowHealthFrame.flashing) or UnitIsDead("player") ) then
				UIFrameFlash(LowHealthFrame, 1, 1, 0);
				LowHealthFrame.flashing = nil;
			end
		else
			if ( UIParent.isOutOfControl and not OutOfControlFrame.flashing and not UnitOnTaxi("player")) then
				UIFrameFlash(OutOfControlFrame, 0.5, 0.5, 100);
				OutOfControlFrame.flashing = 1;
			elseif ( not UIParent.isOutOfControl and OutOfControlFrame.flashing ) then
				UIFrameFlash(OutOfControlFrame, 0.5, 0.5, 0);
				OutOfControlFrame.flashing = nil;
			end
		end
	else
		if (LowHealthFrame.flashing) then
			UIFrameFlash(LowHealthFrame, 1, 1, 0);
			LowHealthFrame.flashing = nil;
		end
		if (OutOfControlFrame.flashing) then
			UIFrameFlash(OutOfControlFrame, 0.5, 0.5, 0);
			OutOfControlFrame.flashing = nil;
		end
	end
end

-- XPerl_Player_OnUpdate
function XPerl_Player_OnUpdate()
	CombatFeedback_OnUpdate(arg1)
	if (this.PlayerFlash) then
		XPerl_Player_CombatFlash(arg1, false)
	end
end

-- XPerl_Player_UpdateDisplay
function XPerl_Player_UpdateDisplay ()
	XPerl_Player_UpdateXP()
	XPerl_Player_UpdateManaType()
	XPerl_Player_UpdateLevel()
	XPerl_Player_UpdateName()
	XPerl_Player_UpdatePVP()
	XPerl_Player_UpdateCombat()
	XPerl_Player_UpdateLeader()
	XPerl_Player_UpdateMasterLooter()
	XPerl_Player_UpdateMana()
	XPerl_Player_UpdateHealth()
	XPerl_Player_Events:PLAYER_AURAS_CHANGED()
end

--------------------
-- Click Handlers --
--------------------
function XPerl_Player_OnClick(button)
	if (XPerl_OnClick_Handler(button, "player")) then
		return
	end

	if (button == "RightButton") then
		HideDropDownMenu(1)
		ToggleDropDownMenu(1, nil, PlayerFrameDropDown, "XPerl_Player_StatsFrame", 0, 0)
	end
end

-- EVENTS AND STUFF

local events = {"PARTY_MEMBERS_CHANGED", "PARTY_LEADER_CHANGED", "PARTY_LOOT_METHOD_CHANGED", "RAID_ROSTER_UPDATE",
		"UNIT_SPELLMISS", "PLAYER_UPDATE_RESTING", "UNIT_FACTION", "UNIT_MODEL_CHANGED", "PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED", "PLAYER_ENTER_COMBAT", "PLAYER_LEAVE_COMBAT", "PLAYER_LEVEL_UP", "PLAYER_DEAD",
		"UNIT_FLAGS", "PLAYER_XP_UPDATE", "UPDATE_FACTION", "PLAYER_AURAS_CHANGED",
		"UPDATE_SHAPESHIFT_FORMS", "PLAYER_CONTROL_LOST", "PLAYER_CONTROL_GAINED"}

local function XPerl_Player_RegisterSome()
	for i,event in pairs(events) do
		this:RegisterEvent(event)
	end
	XPerl_RegisterBasics()
end
local function XPerl_Player_UnregisterSome()
	for i,event in pairs(events) do
		this:UnregisterEvent(event)
	end
	XPerl_UnregisterBasics()
end

-------------------
-- Event Handler --
-------------------
function XPerl_Player_OnEvent()
	local func = XPerl_Player_Events[event]
	if (func) then
		func()
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Player_Events:PLAYER_ENTERING_WORLD()
	XPerl_Player_RegisterSome()
	XPerl_Player_UpdateDisplay()
end

-- PLAYER_LEAVING_WORLD
function XPerl_Player_Events:PLAYER_LEAVING_WORLD()
	XPerl_Player_UnregisterSome()
end

-- UNIT_COMBAT
function XPerl_Player_Events:UNIT_COMBAT()
	if (arg1 == "player") then
		if (XPerlConfig.CombatHitIndicator == 1 and XPerlConfig.ShowPlayerPortrait == 1) then
			CombatFeedback_OnCombatEvent(arg2, arg3, arg4, arg5)
		end

		if (arg2 == "HEAL") then
			XPerl_Player_CombatFlash(elapsed, true, true)
		elseif (arg4 and arg4 > 0) then
			XPerl_Player_CombatFlash(elapsed, true)
		end
	end
end

-- UNIT_SPELLMISS
function XPerl_Player_Events:UNIT_SPELLMISS()
	if (arg1 == "player") then
		if (XPerlConfig.CombatHitIndicator == 1 and XPerlConfig.ShowPlayerPortrait == 1) then
			CombatFeedback_OnSpellMissEvent(arg2)
		end
	end
end

-- UNIT_MODEL_CHANGED
function XPerl_Player_Events:UNIT_MODEL_CHANGED()
	if (arg1 == "player") then
		XPerl_Player_UpdatePortrait()
	end
end
--XPerl_Player_Events.UNIT_PORTRAIT_UPDATE = XPerl_Player_Events.UNIT_MODEL_CHANGED

-- VARIABLES_LOADED
function XPerl_Player_Events:VARIABLES_LOADED()
	XPerl_Player_UpdatePortrait()
	this:UnregisterEvent(event)
end

-- PARTY_LOOT_METHOD_CHANGED
function XPerl_Player_Events:PARTY_LOOT_METHOD_CHANGED()
	XPerl_Player_UpdateLeader()
	XPerl_Player_UpdateMasterLooter()
end
XPerl_Player_Events.PARTY_MEMBERS_CHANGED = XPerl_Player_Events.PARTY_LOOT_METHOD_CHANGED
XPerl_Player_Events.PARTY_LEADER_CHANGED  = XPerl_Player_Events.PARTY_LOOT_METHOD_CHANGED

function XPerl_Player_Events:RAID_ROSTER_UPDATE()
	XPerl_Player_UpdateLeader()
	XPerl_Player_UpdateMasterLooter()
end

-- UNIT_HEALTH, UNIT_MAXHEALTH
function XPerl_Player_Events:UNIT_HEALTH()
	if (arg1=="player") then
		XPerl_Player_UpdateHealth()
	end
end
XPerl_Player_Events.UNIT_MAXHEALTH = XPerl_Player_Events.UNIT_HEALTH
XPerl_Player_Events.PLAYER_DEAD    = XPerl_Player_Events.UNIT_HEALTH

-- UNIT_MANA, UNIT_MAXMANA, UNIT_RAGE, UNIT_MAXRAGE, UNIT_ENERGY
-- UNIT_MAXENERGY
function XPerl_Player_Events:UNIT_MANA()
	if (arg1=="player") then
		XPerl_Player_UpdateMana()
	end
end
XPerl_Player_Events.UNIT_MAXMANA		= XPerl_Player_Events.UNIT_MANA
XPerl_Player_Events.UNIT_RAGE		= XPerl_Player_Events.UNIT_MANA
XPerl_Player_Events.UNIT_MAXRAGE         = XPerl_Player_Events.UNIT_MANA

local function CheckStealth()
	local i = 0
	while (GetPlayerBuffTexture(i) ~= nil) do		-- check for rogue's stealth and druid's prowl
		if (GetPlayerBuffTexture(i) == "Interface\\Icons\\Ability_Stealth" or
          		GetPlayerBuffTexture(i) == "Interface\\Icons\\Ability_Ambush") then
			return true
		else
			i = i + 1
		end
	end
end

function XPerl_Player_Events:UNIT_ENERGY()
	if (arg1=="player") then
		XPerl_Player_UpdateMana()

		local e = UnitMana("player")
		local m = UnitManaMax("player")
		if (e == XPerl_Player.EnergyLast + 20) then
			XPerl_Player.EnergyTime = GetTime()
		end
		XPerl_Player.EnergyLast = e

		XPerl_Player_TickerShowHide()
	end
end
XPerl_Player_Events.UNIT_MAXENERGY       = XPerl_Player_Events.UNIT_ENERGY

-- UNIT_DISPLAYPOWER
function XPerl_Player_Events:UNIT_DISPLAYPOWER()
	XPerl_Player_UpdateManaType()
	XPerl_Player_UpdateMana()
end

-- UNIT_NAME_UPDATE
function XPerl_Player_Events:UNIT_NAME_UPDATE()
	if (arg1=="player") then
		XPerl_Player_UpdateName()
	end
end

-- UNIT_LEVEL
function XPerl_Player_Events:UNIT_LEVEL()
	if (arg1 == "player") then
		XPerl_Player_UpdateLevel()
		XPerl_Player_UpdateXP()
	end
end
XPerl_Player_Events.PLAYER_LEVEL_UP = XPerl_Player_Events.UNIT_LEVEL

-- PLAYER_XP_UPDATE
function XPerl_Player_Events:PLAYER_XP_UPDATE()
	XPerl_Player_UpdateXP()
end

function XPerl_Player_Events:UPDATE_FACTION()
	if (UnitLevel("player") == MAX_PLAYER_LEVEL) then
		XPerl_Player_UpdateRep()
	end
end

-- UNIT_FACTION
function XPerl_Player_Events:UNIT_FACTION()
	if (arg1 == "player") then
		XPerl_Player_UpdatePVP()
	end
end
XPerl_Player_Events.UNIT_FLAGS = XPerl_Player_Events.UNIT_FACTION

-- PLAYER_ENTER_COMBAT, PLAYER_LEAVE_COMBAT
function XPerl_Player_Events:PLAYER_ENTER_COMBAT()
	XPerl_Player_UpdateCombat()
end
XPerl_Player_Events.PLAYER_LEAVE_COMBAT = XPerl_Player_Events.PLAYER_ENTER_COMBAT

-- PLAYER_REGEN_ENABLED, PLAYER_REGEN_DISABLED
function XPerl_Player_Events:PLAYER_REGEN_ENABLED()
	XPerl_Player_UpdateCombat()
	--XPerl_Player_UpdateDisplay()
end
XPerl_Player_Events.PLAYER_REGEN_DISABLED = XPerl_Player_Events.PLAYER_REGEN_ENABLED
XPerl_Player_Events.PLAYER_UPDATE_RESTING = XPerl_Player_Events.PLAYER_REGEN_ENABLED

function XPerl_Player_Events:PLAYER_AURAS_CHANGED()
	XPerl_CheckDebuffs("player", {XPerl_Player_NameFrame, XPerl_Player_PortraitFrame, XPerl_Player_LevelFrame, XPerl_Player_StatsFrame})
	XPerl_Player_TickerShowHide()

	if (DruidBarKey) then
		-- For DruidBar addon, we update the mana bar on shapeshift
		local _, engClass = UnitClass("player")
		if (engClass == "DRUID") then
			XPerl_Player_UpdateMana()
		end
	end

	if (UIParent.isOutOfControl and not UnitOnTaxi("player")) then
		PlayerStatus_OnUpdate()
	end
end

-- PLAYER_CONTROL_LOST
function XPerl_Player_Events:PLAYER_CONTROL_LOST()
	if (not UnitOnTaxi("player")) then
		UIParent.isOutOfControl = 1
	end
end

-- PLAYER_CONTROL_GAINED
function XPerl_Player_Events:PLAYER_CONTROL_GAINED()
	UIParent.isOutOfControl = nil
	PlayerStatus_OnUpdate()
end

-- Moving stuff
function XPerl_Player_GetGap()
	if (XPerl_Target) then
		local playerLeft = XPerl_Player:GetRight() * XPerl_Player:GetEffectiveScale()
		local targetLeft = XPerl_Target:GetLeft() * XPerl_Target:GetEffectiveScale()

		local a = targetLeft - playerLeft

		a = a + 0.01
		a = a * 100
		a = math.floor (a)
		a = a / 100

		return (math.floor(a + 4))
	end

	return 0
end

function XPerl_Player_SetGap(newGap)
	if (not XPerl_Target) then
		return
	end

	if (type(newGap) == "number") then
		newGap = newGap - 4

		local top = XPerl_Target:GetTop()
		local left = ((XPerl_Player:GetRight() * XPerl_Player:GetEffectiveScale()) + newGap) / XPerl_Target:GetEffectiveScale()

		XPerl_Target:ClearAllPoints()
		XPerl_Target:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)

		XPerl_Target:SetUserPlaced(true)

		if (XPerl_TargetTarget) then
			top = XPerl_TargetTarget:GetTop()
			left = ((XPerl_Target:GetRight() * XPerl_Target:GetEffectiveScale()) + newGap) / XPerl_TargetTarget:GetEffectiveScale()

			-- Can't use the CastClickOverlay for GetRight() as wow doesn't update anchors until it renders the frame, anchors
			-- are always 1 frame behind. Usually you won't notice, but when moving frames in this manner, it was ugly.
			-- So, we adjust right a little.
			if (XPerl_Target_LevelFrame:IsShown()) then
				left = left + XPerl_Target_LevelFrame:GetWidth()
			end

			XPerl_TargetTarget:ClearAllPoints()
			XPerl_TargetTarget:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)

			if (XPerl_TargetTargetTarget) then
				top = XPerl_TargetTargetTarget:GetTop()
				left = (XPerl_TargetTarget:GetRight() * XPerl_TargetTarget:GetEffectiveScale()) + newGap
				if (XPerlConfig.ShowTargetTargetPercent == 0) then
					left = left - 20
				end
				left = left / XPerl_TargetTargetTarget:GetEffectiveScale()

				XPerl_TargetTargetTarget:ClearAllPoints()
				XPerl_TargetTargetTarget:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)

				XPerl_TargetTargetTarget:SetUserPlaced(true)
			end

			XPerl_TargetTarget:SetUserPlaced(true)
		end
	end
end

function XPerl_Player_AlignTop()
	if (not XPerl_Target) then
		return
	end

	local playerLeft = XPerl_Player:GetLeft()
	local targetLeft = XPerl_Target:GetLeft()
	local playerTop = XPerl_Player:GetTop()
	local top = playerTop * XPerl_Player:GetEffectiveScale()
	local newTop

	if (playerLeft == nil) then
		playerLeft = 5
	end
	if (targetLeft == nil) then
		targetLeft = 220
	end

	-- We set this for 1 reason, so that all the related frames scale in the same direction should the user do that...
	XPerl_Player:ClearAllPoints()
	XPerl_Player:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", playerLeft, playerTop)

	XPerl_Target:ClearAllPoints()
	newTop = top / XPerl_Target:GetEffectiveScale()
	XPerl_Target:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", targetLeft, newTop)

	XPerl_Target:StartMoving()
	XPerl_Target:StopMovingOrSizing()

	if (XPerl_TargetTarget) then
		local targettargetLeft = XPerl_TargetTarget:GetLeft()

		if (targettargetLeft == nil) then
			targettargetLeft = targetLeft + 200
		end

		XPerl_TargetTarget:ClearAllPoints()
		newTop = top / XPerl_TargetTarget:GetEffectiveScale()
		XPerl_TargetTarget:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", targettargetLeft, newTop)

		if (XPerl_TargetTargetTarget) then
			local targettargettargetLeft = XPerl_TargetTargetTarget:GetLeft()
			if (targettargettargetLeft == nil) then
				targettargettargetLeft = targettargetLeft + 200
			end

			XPerl_TargetTargetTarget:ClearAllPoints()
			newTop = top / XPerl_TargetTargetTarget:GetEffectiveScale()
			XPerl_TargetTargetTarget:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", targettargettargetLeft, newTop)

			XPerl_TargetTargetTarget:StartMoving()
			XPerl_TargetTargetTarget:StopMovingOrSizing()
		end

		XPerl_TargetTarget:StartMoving()
		XPerl_TargetTarget:StopMovingOrSizing()
	end
end


-- XPerl_Player_Energy_TickWatch
function XPerl_Player_Energy_OnUpdate()

	local time = GetTime()
	local temp = time - XPerl_Player.EnergyTime
	local remainder = mod (temp, 2)

	XPerl_Player_StatsFrame_EnergyTicker:SetValue(remainder)

	sparkPosition = XPerl_Player_StatsFrame_EnergyTicker:GetWidth() * (remainder / 2)

	XPerl_Player_StatsFrame_EnergyTicker_Spark:SetPoint("CENTER", XPerl_Player_StatsFrame_EnergyTicker, "LEFT", sparkPosition, 0)
end

-- XPerl_Player_TickerShowHide
function XPerl_Player_TickerShowHide()
       	local e = UnitMana("player")
       	local m = UnitManaMax("player")
       	if (XPerl_Player.EnergyEnabled and (e < m or UnitAffectingCombat("player") or CheckStealth()) and not UnitIsDeadOrGhost("player") and XPerlConfig.EnergyTicker == 1) then
       		XPerl_Player_StatsFrame_EnergyTicker:Show()
       	else
       		XPerl_Player_StatsFrame_EnergyTicker:Hide()
       	end
end

-- XPerl_Player_Set_Bits()
function XPerl_Player_Set_Bits()
	if (XPerlConfig.ShowPlayerPortrait==0) then
		XPerl_Player_PortraitFrame:Hide()
		XPerl_Player_PortraitFrame:SetWidth(3)
	else
		XPerl_Player_PortraitFrame:Show()
		XPerl_Player_PortraitFrame:SetWidth(60)
		XPerl_Player_UpdatePortrait()
	end

	if (XPerlConfig.ShowPlayerLevel==0) then
		XPerl_Player_LevelFrame:Hide()
	else
		XPerl_Player_LevelFrame:Show()
	end

	if (XPerlConfig.ShowPlayerPercent == 0) then
		XPerl_Player_NameFrame:SetWidth(128)
		XPerl_Player_StatsFrame:SetWidth(128)
		XPerl_Player_StatsFrame_HealthBarPercent:Hide()
		XPerl_Player_StatsFrame_ManaBarPercent:Hide()
		XPerl_Player_StatsFrame_XPBarPercent:Hide()
	else
		XPerl_Player_NameFrame:SetWidth(160)
		XPerl_Player_StatsFrame:SetWidth(160)
		XPerl_Player_StatsFrame_HealthBarPercent:Show()
		XPerl_Player_StatsFrame_ManaBarPercent:Show()
		XPerl_Player_StatsFrame_XPBarPercent:Show()
	end

	if (XPerlConfig.ShowPlayerValues == 0) then
		XPerl_Player_StatsFrame_HealthBarText:Hide()
		XPerl_Player_StatsFrame_ManaBarText:Hide()
		XPerl_Player_StatsFrame_XPBarText:Hide()
	else
		XPerl_Player_StatsFrame_HealthBarText:Show()
		XPerl_Player_StatsFrame_ManaBarText:Show()
		XPerl_Player_StatsFrame_XPBarText:Show()
	end

	if (XPerlConfig.ShowPlayerClassIcon == 0) then
		XPerl_Player_ClassTexture:Hide()
	else
		XPerl_Player_ClassTexture:Show()
	end

	if (XPerlConfig.ShowPlayerPVPRank==0) then
		XPerl_Player_NameFrame_PVPRankIcon:Hide()
	else
		XPerl_Player_NameFrame_PVPRankIcon:Show()
	end

	if (XPerlConfig.ShowPlayerXPBar==0) then
		XPerl_Player_StatsFrame_XPBar:Hide()
		XPerl_Player_StatsFrame_XPRestBar:Hide()
		XPerl_Player_StatsFrame:SetHeight(40)
	else
		XPerl_Player_StatsFrame_XPBar:Show()
		XPerl_Player_StatsFrame_XPRestBar:Show()
		XPerl_Player_StatsFrame:SetHeight(50)
	end
end

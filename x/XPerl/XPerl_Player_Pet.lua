local XPerl_Player_Pet_Events = {}

----------------------
-- Loading Function --
----------------------
function XPerl_Player_Pet_OnLoad()

	-- Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")

	this.time = 0
	XPerl_InitFadeFrame(this)

	-- Set here to reduce amount of function calls made
	this:SetScript("OnEvent", XPerl_Player_Pet_OnEvent)
	this:SetScript("OnUpdate", XPerl_Player_Pet_OnUpdate)
	this:SetScript("OnShow", XPerl_Player_Pet_UpdatePortrait)

	XPerl_RegisterHighlight(XPerl_Player_Pet_CastClickOverlay, 2)
	XPerl_RegisterPerlFrames(this, {"NameFrame", "StatsFrame", "PortraitFrame", "LevelFrame", "HappyFrame"})

	this.FlashFrames = {XPerl_Player_Pet_NameFrame, XPerl_Player_Pet_LevelFrame,
				XPerl_Player_Pet_StatsFrame, XPerl_Player_Pet_PortraitFrame}
end

-------------------
-- Event Handler --
-------------------
local function XPerl_Player_Pet_RegisterSome()
	this:RegisterEvent("UNIT_PET")
	this:RegisterEvent("UNIT_HAPPINESS")
	this:RegisterEvent("PET_STABLE_UPDATE")
	this:RegisterEvent("PET_STABLE_SHOW")
	this:RegisterEvent("PET_STABLE_CLOSED")
	this:RegisterEvent("PET_STABLE_UPDATE_PAPERDOLL")
end
local function XPerl_Player_Pet_RegisterForPet()
	this:RegisterEvent("UNIT_AURA")
	this:RegisterEvent("UNIT_FOCUS")
	this:RegisterEvent("UNIT_MAXFOCUS")
	this:RegisterEvent("PET_ATTACK_START")
	this:RegisterEvent("UNIT_FACTION")
	this:RegisterEvent("UNIT_FLAGS")
	this:RegisterEvent("UNIT_DYNAMIC_FLAGS")
	this:RegisterEvent("UNIT_PET_EXPERIENCE")
	this:RegisterEvent("UNIT_MODEL_CHANGED")
	XPerl_RegisterBasics()
end

local function XPerl_Player_Pet_UnregisterSome()
	this:UnregisterEvent("UNIT_PET")
	this:UnregisterEvent("UNIT_HAPPINESS")
	this:UnregisterEvent("PET_STABLE_UPDATE")
	this:UnregisterEvent("PET_STABLE_SHOW")
	this:UnregisterEvent("PET_STABLE_CLOSED")
	this:UnregisterEvent("PET_STABLE_UPDATE_PAPERDOLL")
end
local function XPerl_Player_Pet_UnregisterForPet()
	this:UnregisterEvent("UNIT_AURA")
	this:UnregisterEvent("UNIT_FOCUS")
	this:UnregisterEvent("UNIT_MAXFOCUS")
	this:UnregisterEvent("PET_ATTACK_START")
	this:UnregisterEvent("UNIT_FACTION")
	this:UnregisterEvent("UNIT_FLAGS")
	this:UnregisterEvent("UNIT_DYNAMIC_FLAGS")
	this:UnregisterEvent("UNIT_PET_EXPERIENCE")
	this:UnregisterEvent("UNIT_MODEL_CHANGED")
	XPerl_UnregisterBasics()
end

-------------------------
-- The Update Function --
-------------------------
local function XPerl_Player_Pet_CheckPet()
	if (UnitExists("pet")) then
		if (UnitIsVisible("pet")) then
			XPerl_CancelFade(XPerl_Player_Pet)

			XPerl_Player_Pet:Show()
			XPerl_Player_Pet_RegisterForPet()
			return true
		end
	end

	XPerl_Player_Pet_UnregisterForPet()

	XPerl_StartFade(XPerl_Player_Pet)
	return false
end

-- XPerl_Player_Pet_UpdateName
local function XPerl_Player_Pet_UpdateName()
	local petname = UnitName("pet")

	if (petname == UNKNOWNOBJECT) then
		XPerl_Player_Pet_NameFrame_NameBarText:SetText("")
	else
		XPerl_Player_Pet_NameFrame_NameBarText:SetText(petname)
	end

	if (UnitIsPVP("player")) then
	        XPerl_Player_Pet_NameFrame_NameBarText:SetTextColor(0, 1, 0, XPerlConfig.TextTransparency)
	else
	        XPerl_Player_Pet_NameFrame_NameBarText:SetTextColor(0.5, 0.5, 1, XPerlConfig.TextTransparency)
	end
end

-- XPerl_Player_Pet_UpdateLevel
local function XPerl_Player_Pet_UpdateLevel()
	local petlevel = UnitLevel("pet")
	local petxp, petxpmax = GetPetExperience()

	XPerl_Player_Pet_StatsFrame_XPBar:SetStatusBarColor(0.3, 0.3, 1, 1)
	XPerl_Player_Pet_StatsFrame_XPBarBG:SetVertexColor(0.3, 0.3, 1, 0.25)

	XPerl_Player_Pet_StatsFrame_XPBar:SetMinMaxValues(0, petxpmax)
	XPerl_Player_Pet_StatsFrame_XPBar:SetValue(petxp)

        XPerl_Player_Pet_LevelFrameText:SetText(petlevel)
end

-- XPerl_Player_Pet_UpdateHealth
local function XPerl_Player_Pet_UpdateHealth()
	local pethealth = UnitHealth("pet")
	local pethealthmax = UnitHealthMax("pet")

	XPerl_SetHealthBar(XPerl_Player_Pet_StatsFrame_HealthBar, pethealth, pethealthmax)

	if (UnitIsDead("pet")) then
		XPerl_Player_Pet_StatsFrame_HealthBarText:SetText(XPERL_LOC_DEAD)
		XPerl_Player_Pet_StatsFrame_ManaBarText:Hide()
	end
end

local function XPerl_Player_Pet_UpdateManaType()
	XPerl_SetManaBarType("pet", XPerl_Player_Pet_StatsFrame_ManaBar, XPerl_Player_Pet_StatsFrame_ManaBarBG)
end

-- XPerl_Player_Pet_UpdateMana()
local function XPerl_Player_Pet_UpdateMana()
	local petmana = UnitMana("pet")
	local petmanamax = UnitManaMax("pet")

	XPerl_Player_Pet_StatsFrame_ManaBar:SetMinMaxValues(0, petmanamax)
	XPerl_Player_Pet_StatsFrame_ManaBar:SetValue(petmana)

	XPerl_Player_Pet_StatsFrame_ManaBarText:SetText(petmana.."/"..petmanamax)

	if (XPerlConfig.ShowPlayerPetValues == 1) then
		XPerl_Player_Pet_StatsFrame_ManaBarText:Show()
	end
end

-- XPerl_Player_Pet_CombatFlash
local function XPerl_Player_Pet_CombatFlash(elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet (elapsed, XPerl_Player_Pet, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(XPerl_Player_Pet)
	end
end

-- XPerl_Player_Pet_UpdatePortrait()
function XPerl_Player_Pet_UpdatePortrait()
	if (XPerlConfig.ShowPlayerPetPortrait == 1) then
		if (XPerlConfig.ShowPlayerPetPortrait3D == 1) then
			XPerl_Player_Pet_PortraitFrame_Portrait:Hide()
			XPerl_Player_Pet_PortraitFrame_Portrait3D:Show()
			XPerlSetPortrait3D(XPerl_Player_Pet_PortraitFrame_Portrait3D, "pet")
		else
			XPerl_Player_Pet_PortraitFrame_Portrait3D.last3DTime = nil
			XPerl_Player_Pet_PortraitFrame_Portrait:Show()
			XPerl_Player_Pet_PortraitFrame_Portrait3D:Hide()
			SetPortraitTexture(XPerl_Player_Pet_PortraitFrame_Portrait, "pet")
		end
	end
end

-- XPerl_Player_Pet_OnUpdate
function XPerl_Player_Pet_OnUpdate()
	if (this.PlayerFlash) then
		XPerl_Player_Pet_CombatFlash(arg1, false)
	end

	XPerl_ProcessFade(XPerl_Player_Pet)
end

--------------------
-- Buff Functions --
--------------------
local function GetBuffButton(buffnum, debuff, createIfAbsent)

	local buffType
	if (debuff == 1) then
		buffType = "DeBuff"
	else
		buffType = "Buff"
	end
	local name = "XPerl_Player_Pet_BuffFrame_"..buffType..buffnum
	local button = getglobal(name)

	if (not button and createIfAbsent) then
		button = CreateFrame("Button", name, XPerl_Player_Pet_BuffFrame, "XPerl_"..buffType.."Template")
		button:SetID(buffnum)

		local size = XPerlConfig.PlayerPetBuffSize * (1 + (0.3 * debuff))
		button:SetHeight(size)
		button:SetWidth(size)

		if (debuff == 1) then
			button:SetScript("OnEnter", XPerl_Player_Pet_SetDeBuffTooltip)
		else
			button:SetScript("OnEnter", XPerl_Player_Pet_SetBuffTooltip)
		end
		button:SetScript("OnLeave", XPerl_PlayerTipHide)

		button:ClearAllPoints()
		if (buffnum == 1) then
			if (debuff == 1) then
				button:SetPoint("TOPLEFT", 0, -(XPerlConfig.PlayerPetBuffSize + 1))
			else
				button:SetPoint("TOPLEFT", 0, 0)
			end
		else
			local prevButton = getglobal("XPerl_Player_Pet_BuffFrame_"..buffType..(buffnum - 1))
			button:SetPoint("TOPLEFT", prevButton, "TOPRIGHT", 1 + debuff, 0)
		end
	end

	return button
end

local function XPerl_Player_Pet_Buff_UpdateAll ()
	if (UnitExists("pet")) then
		for buffnum=1,10 do
			local buff, buffApplications = UnitBuff("pet", buffnum)
			local button = GetBuffButton(buffnum, 0, buff)

			if (buff) then
				local icon = getglobal(button:GetName().."Icon")
				local count = getglobal(button:GetName().."Count")
				icon:SetTexture(buff)

				if ( buffApplications > 1 ) then
					count:SetText(buffApplications)
					count:Show()
				else
					count:Hide()
				end
				button:Show()

			elseif (button) then
				button:Hide()
			end
		end

		for buffnum=1,8 do
			local debuff, debuffApplications, debuffType = UnitDebuff("pet", buffnum)
			local button = GetBuffButton(buffnum, 1, debuff)
			if (debuff) then
				local icon = getglobal(button:GetName().."Icon")
				local count = getglobal(button:GetName().."Count")
				local border = getglobal(button:GetName().."Border")

				icon:SetTexture(debuff)

				if ( debuffApplications > 1 ) then
					count:SetText(debuffApplications)
					count:Show()
				else
					count:Hide()
				end

				local borderColor = DebuffTypeColor[(debuffType or "none")]
				border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b)
				button:Show()

			elseif (button) then
				button:Hide()
			end
		end

		XPerl_CheckDebuffs("pet", {XPerl_Player_Pet_NameFrame, XPerl_Player_Pet_PortraitFrame, XPerl_Player_Pet_LevelFrame, XPerl_Player_Pet_StatsFrame})
	end
end

function XPerl_Player_Pet_SetBuffTooltip ()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:SetUnitBuff("pet", this:GetID())
end

function XPerl_Player_Pet_SetDeBuffTooltip ()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:SetUnitDebuff("pet", this:GetID())
end

---------------
-- Happiness --
---------------

local function XPerl_Player_Pet_SetHappiness()
	local happiness, damagePercentage, loyaltyRate = GetPetHappiness()

	if (not happiness) then
		happiness = 3
	end

	if ( happiness == 1 ) then
		XPerl_Player_Pet_HappyFrame_PetHappinessTexture:SetTexCoord(0.375, 0.5625, 0, 0.359375)
	elseif ( happiness == 2 ) then
		XPerl_Player_Pet_HappyFrame_PetHappinessTexture:SetTexCoord(0.1875, 0.375, 0, 0.359375)
	elseif ( happiness == 3 ) then
		XPerl_Player_Pet_HappyFrame_PetHappinessTexture:SetTexCoord(0, 0.1875, 0, 0.359375)
	end
	if ( happiness ~= nil ) then
		XPerl_Player_Pet_HappyFrame_PetHappiness.tooltip = getglobal("PET_HAPPINESS"..happiness)
		XPerl_Player_Pet_HappyFrame_PetHappiness.tooltipDamage = format(PET_DAMAGE_PERCENTAGE, damagePercentage)
		if ( loyaltyRate < 0 ) then
			XPerl_Player_Pet_HappyFrame_PetHappiness.tooltipLoyalty = getglobal("LOSING_LOYALTY")
		elseif ( loyaltyRate > 0 ) then
			XPerl_Player_Pet_HappyFrame_PetHappiness.tooltipLoyalty = getglobal("GAINING_LOYALTY")
		else
			XPerl_Player_Pet_HappyFrame_PetHappiness.tooltipLoyalty = nil
		end
	end

	if (XPerlConfig.PetHappiness == 1 and (XPerlConfig.PetHappinessSad == 0 or happiness < 3)) then
		XPerl_Player_Pet_HappyFrame:Show()

		if (XPerlConfig.PetFlashWhenSad == 1 and happiness < 3) then
			if (not UIFrameIsFlashing(XPerl_Player_Pet_HappyFrame)) then
				UIFrameFlash(XPerl_Player_Pet_HappyFrame, 0.5, 0.5, 30, 1, 0, 1)
			end
		else
			if (UIFrameIsFlashing(XPerl_Player_Pet_HappyFrame)) then
				UIFrameFlashStop(XPerl_Player_Pet_HappyFrame)
                		UIFrameFlashUpdate(1)
			end
		end
	else
		if (UIFrameIsFlashing(XPerl_Player_Pet_HappyFrame)) then
			UIFrameFlashStop(XPerl_Player_Pet_HappyFrame)
                	UIFrameFlashUpdate(1)
		end
		XPerl_Player_Pet_HappyFrame:Hide()
	end
end

--------------------
-- Click Handlers --
--------------------
function XPerl_Player_Pet_OnClick(button)

	if (XPerl_OnClick_Handler(button, "pet")) then
		return
	end

	if (button == "RightButton") then
		HideDropDownMenu(1)
		ToggleDropDownMenu(1, nil, PetFrameDropDown, "XPerl_Player_Pet_StatsFrame", 0, 0)
	end
end

-- XPerl_Player_Pet_Update_Control
local function XPerl_Player_Pet_Update_Control()
        if (UnitIsCharmed("pet")) then
		XPerl_Player_Pet_NameFrame_Warning:Show()
	else
		XPerl_Player_Pet_NameFrame_Warning:Hide()
	end
end

-- XPerl_Player_Pet_UpdateCombat
local function XPerl_Player_Pet_UpdateCombat()
	if (UnitExists("pet")) then
                if (UnitAffectingCombat("pet")) then
                        XPerl_Player_Pet_NameFrame_ActivityStatus:Show()
                else
                        XPerl_Player_Pet_NameFrame_ActivityStatus:Hide()
                end
		XPerl_Player_Pet_Update_Control()
        end
end

function XPerl_Player_Pet_UpdateDisplay ()
	if (XPerl_Player_Pet_CheckPet()) then
		XPerl_CancelFade(XPerl_Player_Pet)

		XPerl_Player_Pet_UpdatePortrait()
		XPerl_Player_Pet_UpdateName()
		XPerl_Player_Pet_UpdateHealth()
		XPerl_Player_Pet_UpdateManaType()
		XPerl_Player_Pet_UpdateMana()
		XPerl_Player_Pet_UpdateLevel()
		XPerl_Player_Pet_SetHappiness()
		XPerl_Player_Pet_Buff_UpdateAll()

	        XPerl_Player_Pet_UpdateCombat()
	end
end

-------------------
-- Event Handler --
-------------------
function XPerl_Player_Pet_OnEvent()
	local func = XPerl_Player_Pet_Events[event]
	if (func) then
		func()
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Player_Pet_Events:PLAYER_ENTERING_WORLD()
	--XPerl_Player_Pet.PlayerFlash = 0
	XPerl_Player_Pet_RegisterSome()
end

-- PLAYER_LEAVING_WORLD
function XPerl_Player_Pet_Events:PLAYER_LEAVING_WORLD()
	XPerl_Player_Pet_UnregisterSome()
end

-- UNIT_AURA
function XPerl_Player_Pet_Events:UNIT_AURA()
	if (arg1 == "pet") then
		XPerl_Player_Pet_Buff_UpdateAll()
	end
end

-- UNIT_PET
function XPerl_Player_Pet_Events:UNIT_PET()
	XPerl_Player_Pet_UpdateDisplay()
end

XPerl_Player_Pet_Events.PET_STABLE_SHOW = XPerl_Player_Pet_Events.UNIT_PET

-- UNIT_NAME_UPDATE
function XPerl_Player_Pet_Events:UNIT_NAME_UPDATE()
	if (arg1 == "pet") then
		XPerl_Player_Pet_UpdateName()
	end
end

-- UNIT_MODEL_CHANGED
function XPerl_Player_Pet_Events:UNIT_MODEL_CHANGED()
	if (arg1 == "pet") then
		XPerl_Player_Pet_UpdatePortrait()
	end
end
--XPerl_Player_Pet_Events.UNIT_PORTRAIT_UPDATE = XPerl_Player_Pet_Events.UNIT_MODEL_CHANGED

-- UNIT_HEALTH, UNIT_MAXHEALTH
function XPerl_Player_Pet_Events:UNIT_HEALTH()
	if (arg1 == "pet") then
		XPerl_Player_Pet_UpdateHealth()
	end
end
XPerl_Player_Pet_Events.UNIT_MAXHEALTH = XPerl_Player_Pet_Events.UNIT_HEALTH

-- UNIT_RAGE
function XPerl_Player_Pet_Events:UNIT_RAGE()
	if (arg1 == "pet") then
		XPerl_Player_Pet_UpdateMana()
	end
end

XPerl_Player_Pet_Events.UNIT_MAXRAGE	= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_ENERGY	= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MAXENERGY	= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MANA	= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MAXMANA	= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_FOCUS	= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MAXFOCUS	= XPerl_Player_Pet_Events.UNIT_RAGE

-- UNIT_LEVEL
function XPerl_Player_Pet_Events:UNIT_LEVEL()
	if (arg1 == "pet") then
		XPerl_Player_Pet_UpdateLevel()
	end
end

XPerl_Player_Pet_Events.UNIT_PET_EXPERIENCE = XPerl_Player_Pet_Events.UNIT_LEVEL

-- UNIT_DISPLAYPOWER
function XPerl_Player_Pet_Events:UNIT_DISPLAYPOWER()
	if (arg1 == "pet") then
		XPerl_Player_Pet_UpdateManaType()
	end
end

-- UNIT_HAPPINESS
-- Happiness events come while you have a pet up, each 2 secs
function XPerl_Player_Pet_Events:UNIT_HAPPINESS()
	if (arg1 == "pet") then
		--XPerl_Player_Pet_UpdateDisplay();	-- Update all, fixes bug with stables in 1.11
		XPerl_Player_Pet_SetHappiness()
		XPerl_Player_Pet_UpdateCombat()
	end
end

-- PET_ATTACK_START
function XPerl_Player_Pet_Events:PET_ATTACK_START()
	XPerl_Player_Pet_UpdateCombat()
end

-- UNIT_COMBAT
function XPerl_Player_Pet_Events:UNIT_COMBAT()
	if (arg1 == "pet") then
		if (arg2 == "HEAL") then
			XPerl_Player_Pet_CombatFlash(0, true, true)
		elseif (arg4 and arg4 > 0) then
			XPerl_Player_Pet_CombatFlash(0, true)
		end
	end
end

-- UNIT_DYNAMIC_FLAGS
function XPerl_Player_Pet_Events:UNIT_FACTION()
	if (arg1 == "pet" or arg1 == "player") then
		XPerl_Player_Pet_UpdateName()
	        XPerl_Player_Pet_UpdateCombat()
	end
end

XPerl_Player_Pet_Events.UNIT_FLAGS = XPerl_Player_Pet_Events.UNIT_FACTION
XPerl_Player_Pet_Events.UNIT_DYNAMIC_FLAGS = XPerl_Player_Pet_Events.UNIT_FACTION

-- XPerl_Player_Pet_Set_Bits
function XPerl_Player_Pet_Set_Bits()
	if (XPerlConfig.ShowPlayerPetPortrait==0) then
		XPerl_Player_Pet_PortraitFrame:Hide()
		XPerl_Player_Pet_PortraitFrame:SetWidth(3)
	else
		XPerl_Player_Pet_PortraitFrame:Show()
		XPerl_Player_Pet_PortraitFrame:SetWidth(50)
		XPerl_Player_Pet_UpdatePortrait()
	end

	if (XPerlConfig.ShowPlayerPetName == 1) then
		XPerl_Player_Pet_NameFrame:Show()
		XPerl_Player_Pet_NameFrame:SetHeight(24)
	else
		XPerl_Player_Pet_NameFrame:Hide()
		XPerl_Player_Pet_NameFrame:SetHeight(2)
	end

	if (XPerlConfig.ShowPlayerPetName == 1 or XPerlConfig.ShowPlayerPetPortrait == 1) then
		XPerl_Player_Pet_HappyFrame:SetPoint("BOTTOMRIGHT", XPerl_Player_Pet_PortraitFrame, "BOTTOMLEFT", 2, 0)

		if (XPerlConfig.ShowPetLevel == 1) then
        		XPerl_Player_Pet_LevelFrame:SetPoint("TOPRIGHT", XPerl_Player_Pet_PortraitFrame, "TOPLEFT", 2, 0)
		end
	else
		XPerl_Player_Pet_HappyFrame:SetPoint("BOTTOMRIGHT", XPerl_Player_Pet_StatsFrame, "BOTTOMLEFT", 2, 0)

		if (XPerlConfig.ShowPetLevel == 1) then
        		XPerl_Player_Pet_LevelFrame:SetPoint("TOPRIGHT", XPerl_Player_Pet_HappyFrame, "TOPLEFT", 2, 0)
		end
	end

	if (XPerlConfig.ShowPetXP==0) then
		XPerl_Player_Pet_StatsFrame_XPBar:Hide()
		XPerl_Player_Pet_StatsFrame:SetHeight(34)
	else
		XPerl_Player_Pet_StatsFrame_XPBar:Show()
		XPerl_Player_Pet_StatsFrame:SetHeight(44)
	end

	if (XPerlConfig.ShowPetLevel == 0) then
        	XPerl_Player_Pet_LevelFrame:Hide()
	else
        	XPerl_Player_Pet_LevelFrame:Show()
	end

	if (XPerlConfig.ShowPetXP == 1 or XPerlConfig.ShowPlayerPetPortrait == 0 or XPerlConfig.ShowPlayerPetName == 0) then
		XPerl_Player_Pet_BuffFrame:SetPoint("TOPLEFT", XPerl_Player_Pet_StatsFrame, "BOTTOMLEFT", 2, 0)
	else
		XPerl_Player_Pet_BuffFrame:SetPoint("TOPLEFT", XPerl_Player_Pet_PortraitFrame, "BOTTOMLEFT", 2, 0)
	end

	if (XPerlConfig.ShowPlayerPetValues == 1) then
        	XPerl_Player_Pet_StatsFrame_HealthBarText:Show()
        	XPerl_Player_Pet_StatsFrame_ManaBarText:Show()
	else
        	XPerl_Player_Pet_StatsFrame_HealthBarText:Hide()
        	XPerl_Player_Pet_StatsFrame_ManaBarText:Hide()
	end

	XPerl_Player_Pet_CastClickOverlay:ClearAllPoints()
	if (XPerlConfig.ShowPlayerPetPortrait == 1 or XPerlConfig.ShowPlayerPetName == 1) then
		XPerl_Player_Pet_CastClickOverlay:SetPoint("BOTTOMLEFT", XPerl_Player_Pet_PortraitFrame)
	else
		XPerl_Player_Pet_CastClickOverlay:SetPoint("BOTTOMLEFT", XPerl_Player_Pet_StatsFrame)
	end
	XPerl_Player_Pet_CastClickOverlay:SetPoint("TOPRIGHT", XPerl_Player_Pet_NameFrame)

	XPerlConfig.PlayerPetBuffSize = tonumber(XPerlConfig.PlayerPetBuffSize) or 20
	XPerl_SetBuffSize("XPerl_Player_Pet_", XPerlConfig.PlayerPetBuffSize, XPerlConfig.PlayerPetBuffSize * 1.3)
end

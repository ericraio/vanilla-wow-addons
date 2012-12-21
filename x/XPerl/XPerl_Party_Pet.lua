local XPerl_Party_Pet_Events = {}
local PartyPetFrames = {}

-- XPerl_Party_Pet_RegisterForPet
local function XPerl_Party_Pet_RegisterForPet()
	local reg
	for i = 1,4 do
		if (UnitExists("partypet"..i)) then
			reg = true
		end
	end

	if (reg) then
		XPerl_Party_Pet_EventFrame:RegisterEvent("UNIT_FACTION")
		XPerl_Party_Pet_EventFrame:RegisterEvent("UNIT_AURA")
		XPerl_Party_Pet_EventFrame:RegisterEvent("PARTY_MEMBER_ENABLE")
		XPerl_Party_Pet_EventFrame:RegisterEvent("PARTY_MEMBER_DISABLE")
		XPerl_Party_Pet_EventFrame:RegisterEvent("UNIT_FLAGS")
		XPerl_Party_Pet_EventFrame:RegisterEvent("UNIT_DYNAMIC_FLAGS")
		XPerl_RegisterBasics(XPerl_Party_Pet_EventFrame)
		XPerl_Party_Pet_EventFrame:Show()		-- For OnUpdate
	end
end

-- XPerl_Party_Pet_UnregisterForPet
local function XPerl_Party_Pet_UnregisterForPet()
	local reg
	for i = 1,4 do
		if (UnitExists("partypet"..i)) then
			reg = true
		end
	end

	if (not reg) then
		XPerl_Party_Pet_EventFrame:UnregisterEvent("UNIT_FACTION")
		XPerl_Party_Pet_EventFrame:UnregisterEvent("UNIT_AURA")
		XPerl_Party_Pet_EventFrame:UnregisterEvent("PARTY_MEMBER_ENABLE")
		XPerl_Party_Pet_EventFrame:UnregisterEvent("PARTY_MEMBER_DISABLE")
		XPerl_Party_Pet_EventFrame:UnregisterEvent("UNIT_FLAGS")
		XPerl_Party_Pet_EventFrame:UnregisterEvent("UNIT_DYNAMIC_FLAGS")
		XPerl_UnregisterBasics(XPerl_Party_Pet_EventFrame)
	end
end

----------------------
-- Loading Function --
----------------------
function XPerl_Party_Pet_OnLoadEvents()
	this.time = 0
        XPerl_Party_Pet_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
        XPerl_Party_Pet_EventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")

	-- Set here to reduce amount of function calls made
	XPerl_Party_Pet_EventFrame:SetScript("OnEvent", XPerl_Party_Pet_OnEvent)
	XPerl_Party_Pet_EventFrame:SetScript("OnUpdate", XPerl_Party_Pet_OnUpdate)
end

-- XPerl_Party_Pet_OnLoad
function XPerl_Party_Pet_OnLoad()
	this.partyunit = "party"..this:GetID()
	this.petunit = "partypet"..this:GetID()

	PartyPetFrames[this.petunit] = this

	XPerl_InitFadeFrame(this)

	XPerl_RegisterHighlight(getglobal(this:GetName().."_CastClickOverlay"), 2)
	XPerl_RegisterPerlFrames(this, {"NameFrame", "StatsFrame"})

	this.FlashFrames = {getglobal(this:GetName().."_NameFrame"),
				getglobal(this:GetName().."_LevelFrame"),
				getglobal(this:GetName().."_StatsFrame") }
end

-------------------------
-- The Update Function --
-------------------------

-- XPerl_Party_Pet_CheckPet
-- returns true if full update required (frame shown)

function XPerl_Party_Pet_CheckPet(argFrame)
	if (XPerlConfig.ShowPartyPets == 1) then
		if (UnitExists(argFrame.partyunit) and UnitExists(argFrame.petunit) and UnitIsConnected(argFrame.petunit) and not UnitIsDead(argFrame.petunit)) then   -- and not UnitIsDeadOrGhost(argFrame.partyunit)
			if (not argFrame:IsShowing()) then
				if (XPerlConfig.ShowPartyRaid == 1 or not UnitInRaid("player")) then
					if (XPerlConfig.ShowPartyRaid == 1) then
						XPerl_Party_Pet_RegisterForPet()
						XPerl_CancelFade(argFrame)
						argFrame:Show()
						return true
					end
				end
			end
			return false
		end
	end

	if (argFrame:IsShowing()) then
		XPerl_Party_Pet_UnregisterForPet()
		XPerl_StartFade(argFrame)
	end

	return false
end

-- XPerl_Party_Pet_UpdateName
local function XPerl_Party_Pet_UpdateName(argFrame)
	if (argFrame.petunit == nil) then
		return
	end

	local Partypetname = UnitName(argFrame.petunit)

	if (Partypetname ~= nil) then
		-- Set name
		--if (strlen(Partypetname) > 40) then
		--	Partypetname = strsub(Partypetname, 1, 39).."..."
		--end
		if (XPerlConfig.ShowPartyPetNames == 1) then
			getglobal(argFrame:GetName().."_NameFrame"):Show()
		end
		getglobal(argFrame:GetName().."_NameFrameText"):SetText(Partypetname)

		if (UnitIsPVP(argFrame.partyunit)) then
			getglobal(argFrame:GetName().."_NameFrameText"):SetTextColor(0,1,0)
		else
			getglobal(argFrame:GetName().."_NameFrameText"):SetTextColor(0.5,0.5,1)
		end
	end
end

-- XPerl_Party_Pet_UpdateHealth
local function XPerl_Party_Pet_UpdateHealth(argFrame)
	local Partypethealth = UnitHealth(argFrame.petunit)
	local Partypethealthmax = UnitHealthMax(argFrame.petunit)

	local healthPct = Partypethealth / Partypethealthmax
	local phealthPct = string.format("%3.0f", healthPct * 100)

	getglobal(argFrame:GetName().."_StatsFrame_HealthBar"):SetMinMaxValues(0, Partypethealthmax)
	getglobal(argFrame:GetName().."_StatsFrame_HealthBar"):SetValue(Partypethealth)
	XPerl_SetSmoothBarColor(getglobal(argFrame:GetName().."_StatsFrame_HealthBar"), healthPct)

	if (UnitIsDead(argFrame.petunit)) then
		--getglobal(this:GetName().."_StatsFrame_HealthBar_HealthBarPercentText"):SetText(XPERL_LOC_DEAD)
		--getglobal(this:GetName().."_StatsFrame_HealthBar_HealthBarPercentText"):Hide()
		XPerl_StartFade(argFrame)
	else
		local t = getglobal(argFrame:GetName().."_StatsFrame_HealthBarText")
		if (XPerlConfig.HealerMode == 1) then
			if (XPerlConfig.HealerModeType == 1) then
				t:SetText(string.format("%d/%d", Partypethealth - Partypethealthmax, Partypethealthmax))
			else
				t:SetText(Partypethealth - Partypethealthmax)
			end
		else
			t:SetText(string.format("%d",(100*(Partypethealth / Partypethealthmax))+0.5).."%")
		end

		getglobal(argFrame:GetName().."_StatsFrame_HealthBarText"):Show()
	end
end

-- XPerl_Party_Pet_UpdateManaType
local function XPerl_Party_Pet_UpdateManaType(argFrame)
	local frameName = argFrame:GetName().."_StatsFrame_ManaBar"
	XPerl_SetManaBarType(argFrame.petunit, getglobal(frameName), getglobal(frameName.."BG"))
end

-- XPerl_Party_Pet_UpdateMana
local function XPerl_Party_Pet_UpdateMana(argFrame)
	local Partypetmana = UnitMana(argFrame.petunit)
	local Partypetmanamax = UnitManaMax(argFrame.petunit)

	getglobal(argFrame:GetName().."_StatsFrame_ManaBar"):SetMinMaxValues(0, Partypetmanamax)
	getglobal(argFrame:GetName().."_StatsFrame_ManaBar"):SetValue(Partypetmana)

	pmanaPct = (Partypetmana * 100.0) / Partypetmanamax
	pmanaPct =  string.format("%3.0f", pmanaPct)
	getglobal(argFrame:GetName().."_StatsFrame_ManaBarText"):Show()
	if (UnitPowerType(argFrame.petunit) >= 1) then
		getglobal(argFrame:GetName().."_StatsFrame_ManaBarText"):SetText(Partypetmana)
	else
		getglobal(argFrame:GetName().."_StatsFrame_ManaBarText"):SetText(string.format("%d",(100*(Partypetmana / Partypetmanamax))+0.5).."%")
	end
	if (XPerlConfig.ShowPartyPetPercent == 0) then
		getglobal(argFrame:GetName().."_StatsFrame_ManaBarText"):Hide()
	end
end

-- XPerl_Party_Pet_UpdateLevel
local function XPerl_Party_Pet_UpdateLevel(argFrame)
	local Partypetlevel = UnitLevel(argFrame.petunit)
	--local PartypetClassification = UnitClassification(this.petunit)
	local color = GetDifficultyColor(Partypetlevel)

	getglobal(argFrame:GetName().."_NameFrameLevelText"):SetTextColor(color.r,color.g,color.b)

	if (Partypetlevel == 0) then
		Partypetlevel = ""
	end
	getglobal(argFrame:GetName().."_NameFrameLevelText"):SetText(Partypetlevel)
end

--------------------
-- Buff Functions --
--------------------

-- GetBuffButton
local function GetBuffButton(thisFrame, buffnum, debuff, createIfAbsent)

	local buffType
	if (debuff == 1) then
		buffType = "DeBuff"
	else
		buffType = "Buff"
	end
	local name = thisFrame:GetName().."_BuffFrame_"..buffType..buffnum
	local button = getglobal(name)

	if (not button and createIfAbsent) then
		button = CreateFrame("Button", name, getglobal(thisFrame:GetName().."_BuffFrame"), "XPerl_"..buffType.."Template")
		button:SetID(buffnum)

		button:SetHeight(12)
		button:SetWidth(12)

		if (debuff == 1) then
			button:SetScript("OnEnter", XPerl_Party_Pet_SetDeBuffTooltip)
		else
			button:SetScript("OnEnter", XPerl_Party_Pet_SetBuffTooltip)
		end
		button:SetScript("OnLeave", XPerl_PlayerTipHide)

		button:ClearAllPoints()
		if (buffnum == 1) then
			if (debuff == 1) then
				button:SetPoint("TOPLEFT", 0, -14)
			else
				button:SetPoint("TOPLEFT", 0, 0)
			end
		else
			local prevButton = getglobal(thisFrame:GetName().."_BuffFrame_"..buffType..(buffnum - 1))
			button:SetPoint("TOPLEFT", prevButton, "TOPRIGHT", 1 + debuff, 0)
		end
	end

	return button
end

-- XPerl_Party_Pet_Buff_UpdateAll
function XPerl_Party_Pet_Buff_UpdateAll(argFrame)
	local buffFrame = getglobal(argFrame:GetName().."_BuffFrame")
	if (XPerlConfig.ShowPartyPetBuffs == 1) then
		if (UnitExists(argFrame.partyunit) and UnitExists(argFrame.petunit)) then
			buffFrame:Show()

			for buffnum=1,10 do
				local buff = XPerl_UnitBuff(argFrame.petunit, buffnum, XPerlConfig.PartyCastableBuffs)
				if (buff) then
					local button = GetBuffButton(argFrame, buffnum, 0, buff)
					local icon = getglobal(button:GetName().."Icon")
					icon:SetTexture(buff)
					button:Show()
				elseif (button) then
					local button = getglobal(argFrame:GetName().."_BuffFrame_Buff"..buffnum)
					if (button) then
				    		button:Hide()
					end
				end
			end
			for buffnum=1,8 do
				local buff = XPerl_UnitDebuff(argFrame.petunit, buffnum, XPerlConfig.PartyCurableDebuffs)
				if (buff) then
					local button = GetBuffButton(argFrame, buffnum, 1, buff)
					local icon = getglobal(button:GetName().."Icon")
					icon:SetTexture(buff)
					button:Show()
				elseif (button) then
					local button = getglobal(argFrame:GetName().."_BuffFrame_DeBuff"..buffnum)
					if (button) then
						button:Hide()
					end
				end
			end
		else
			buffFrame:Hide()
		end
	else
		buffFrame:Hide()
	end

	XPerl_CheckDebuffs(argFrame.petunit, {getglobal(argFrame:GetName().."_NameFrame"), getglobal(argFrame:GetName().."_StatsFrame")})
end

function XPerl_Party_Pet_SetBuffTooltip()
	local partyid = "partypet"..this:GetParent():GetParent():GetID()
	GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT",30,0)
	--GameTooltip:SetUnitBuff(partyid, this:GetID(), XPerlConfig.PartyCastableBuffs)
	XPerl_TooltipSetUnitBuff(GameTooltip, partyid, this:GetID(), XPerlConfig.PartyCastableBuffs)
end
function XPerl_Party_Pet_SetDeBuffTooltip()
	local partyid = "partypet"..this:GetParent():GetParent():GetID()
	GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT",30,0)
	--GameTooltip:SetUnitDebuff(partyid, this:GetID(), XPerlConfig.PartyCurableDebuffs)
	XPerl_TooltipSetUnitDebuff(GameTooltip, partyid, this:GetID(), XPerlConfig.PartyCurableDebuffs)
end

function XPerl_Party_Pet_UpdateDisplayAll()
	for i,frame in pairs(PartyPetFrames) do
		XPerl_Party_Pet_UpdateDisplay(frame)
	end
end

function XPerl_Party_Pet_UpdateDisplay(argFrame)
	if (XPerl_Party_Pet_CheckPet(argFrame)) then
		XPerl_Party_Pet_UpdateName(argFrame)
		XPerl_Party_Pet_UpdateHealth(argFrame)
		XPerl_Party_Pet_UpdateLevel(argFrame)
		XPerl_Party_Pet_UpdateManaType(argFrame)
		XPerl_Party_Pet_UpdateMana(argFrame)
		XPerl_Party_Pet_UpdateCombat(argFrame)
		XPerl_Party_Pet_Buff_UpdateAll(argFrame)
	end
end


--------------------
-- Click Handlers --
--------------------
Perl_Party_Pet_FindID = XPerl_Frame_FindID

-- XPerl_Party_Pet_OnClick
function XPerl_Party_Pet_OnClick(button)
	local unit = this:GetParent().petunit
	if (XPerl_OnClick_Handler(button, unit)) then
		return
	end
end

-- XPerl_Party_Pet_PlayerTip
function XPerl_Party_Pet_PlayerTip()
	local unit = this:GetParent().petunit
	if (UnitExists(unit)) then
		XPerl_PlayerTip(unit)
	end
end

-- XPerl_Party_Pet_Update_Control
local function XPerl_Party_Pet_Update_Control(argFrame)
        if (UnitIsVisible(argFrame.petunit) and UnitIsCharmed(argFrame.petunit)) then
		getglobal(argFrame:GetName().."_NameFrame_Warning"):Show()
	else
		getglobal(argFrame:GetName().."_NameFrame_Warning"):Hide()
	end
end

-- XPerl_Party_Pet_UpdateCombat
function XPerl_Party_Pet_UpdateCombat(argFrame)
	if (UnitExists(argFrame.partyunit) and UnitExists(argFrame.petunit)) then
                if (UnitAffectingCombat(argFrame.petunit)) then
                        getglobal(argFrame:GetName().."_NameFrameLevelText"):Hide()
                        getglobal(argFrame:GetName().."_NameFrame_ActivityStatus"):Show()
                else
                        getglobal(argFrame:GetName().."_NameFrame_ActivityStatus"):Hide()
                        getglobal(argFrame:GetName().."_NameFrameLevelText"):Show()
                end
		XPerl_Party_Pet_Update_Control(argFrame)
        end
end

-- XPerl_Party_Pet_CombatFlash
local function XPerl_Party_Pet_CombatFlash(f, elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet (elapsed, f, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(f)
	end
end

-- XPerl_Party_Pet_OnUpdate
function XPerl_Party_Pet_OnUpdate()
	local any
	for i,f in pairs(PartyPetFrames) do
		if (f:IsShown()) then
			any = true
			if (f.PlayerFlash) then
				XPerl_Party_Pet_CombatFlash(f, arg1, false)
			end
			XPerl_ProcessFade(f)
		end
	end

	if (not any) then
		XPerl_Party_Pet_EventFrame:Hide()		-- Stop processing OnUpdate
	end
end

-------------------
-- Event Handler --
-------------------
local function XPerl_Party_Pet_RegisterSome()
	XPerl_Party_Pet_EventFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	XPerl_Party_Pet_EventFrame:RegisterEvent("UNIT_PET")
end

local function XPerl_Party_Pet_UnregisterSome()
	XPerl_Party_Pet_EventFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	XPerl_Party_Pet_EventFrame:UnregisterEvent("UNIT_PET")
end

-- XPerl_Party_Pet_OnEvent
function XPerl_Party_Pet_OnEvent()
	local func = XPerl_Party_Pet_Events[event]
	if (func) then
		func()
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Party_Pet_Events:PLAYER_ENTERING_WORLD()
	XPerl_Party_Pet_RegisterSome()
	XPerl_Party_Pet_UpdateDisplayAll()
end

-- PLAYER_LEAVING_WORLD
function XPerl_Party_Pet_Events:PLAYER_LEAVING_WORLD()
	XPerl_Party_Pet_UnregisterSome()
end

-- PARTY_MEMBERS_CHANGED
function XPerl_Party_Pet_Events:PARTY_MEMBERS_CHANGED()
	XPerl_Party_Pet_UpdateDisplayAll()
end

-- UNIT_FLAGS
function XPerl_Party_Pet_Events:UNIT_FLAGS()
	local f = PartyPetFrames[arg1]
	if (f) then XPerl_Party_Pet_UpdateCombat(f) end
end

XPerl_Party_Pet_Events.UNIT_DYNAMIC_FLAGS = XPerl_Party_Pet_Events.PARTY_MEMBERS_CHANGED

-- UNIT_COMBAT
function XPerl_Party_Pet_Events:UNIT_COMBAT()
	local f = PartyPetFrames[arg1]
	if (f) then
		if (arg2 == "HEAL") then
			XPerl_Party_Pet_CombatFlash(f, 0, true, true)
		elseif (arg4 and arg4 > 0) then
			XPerl_Party_Pet_CombatFlash(f, 0, true)
		end
	end
end

-- UNIT_PET
function XPerl_Party_Pet_Events:UNIT_PET()
	local petid = strfind(arg1, "party(%d)")
	if (petid) then
		local f = PartyPetFrames["partypet"..petid]
		if (f) then
			XPerl_Party_Pet_UpdateDisplay(f)
		end
	end
end

-- PARTY_MEMBER_ENABLE
function XPerl_Party_Pet_Events:PARTY_MEMBER_ENABLE()
	local petid = strfind(arg1, "party(%d)")
	if (petid) then
		local f = PartyPetFrames["partypet"..petid]
		if (f) then XPerl_Party_Pet_UpdateDisplay(f) end
	end
end
XPerl_Party_Pet_Events.PARTY_MEMBER_DISABLE = XPerl_Party_Pet_Events.PARTY_MEMBER_ENABLE

-- UNIT_NAME_UPDATE
function XPerl_Party_Pet_Events:UNIT_NAME_UPDATE()
	local f = PartyPetFrames[arg1]
	if (f) then XPerl_Party_Pet_UpdateName(f) end
end

-- UNIT_FACTION
function XPerl_Party_Pet_Events:UNIT_FACTION()
	local f = PartyPetFrames[arg1]
	if (f) then
		XPerl_Party_Pet_UpdateName(f)
		XPerl_Party_Pet_UpdateCombat(f)
	end
end

-- UNIT_LEVEL
function XPerl_Party_Pet_Events:UNIT_LEVEL()
	local f = PartyPetFrames[arg1]
	if (f) then XPerl_Party_Pet_UpdateLevel(f) end
end

-- UNIT_HEALTH
function XPerl_Party_Pet_Events:UNIT_HEALTH()
	local f = PartyPetFrames[arg1]
	if (f) then XPerl_Party_Pet_UpdateHealth(f) end
end

-- UNIT_MAXHEALTH
function XPerl_Party_Pet_Events:UNIT_MAXHEALTH()
	local f = PartyPetFrames[arg1]
	if (f) then
		XPerl_Party_Pet_UpdateHealth(f)
		XPerl_Party_Pet_UpdateLevel(f)
	end
end

-- UNIT_AURA
function XPerl_Party_Pet_Events:UNIT_AURA()
	local f = PartyPetFrames[arg1]
	if (f) then XPerl_Party_Pet_Buff_UpdateAll(f) end
end

-- UNIT_DISPLAYPOWER
function XPerl_Party_Pet_Events:UNIT_DISPLAYPOWER()
	local f = PartyPetFrames[arg1]
	if (f) then XPerl_Party_Pet_UpdateManaType(f) end
end

-- UNIT_MANA
function XPerl_Party_Pet_Events:UNIT_MANA()
	local f = PartyPetFrames[arg1]
	if (f) then XPerl_Party_Pet_UpdateMana(f) end
end

XPerl_Party_Pet_Events.UNIT_MAXMANA	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_RAGE		= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_MAXRAGE	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_FOCUS	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_MAXFOCUS	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_ENERGY	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_MAXENERGY	= XPerl_Party_Pet_Events.UNIT_MANA

-- XPerl_Party_Pet_Set_Name
function XPerl_Party_Pet_Set_Name()
	for i,frame in pairs(PartyPetFrames) do
		local f = getglobal(frame:GetName().."_NameFrame")
		if (XPerlConfig.ShowPartyPetName == 1) then
			f:Show()
			f:SetHeight(24)
		else
			f:Hide()
			f:SetHeight(3)
		end

		XPerl_Party_Pet_Buff_UpdateAll(frame)
	end
end

-- XPerl_ScalePartyPets(num)
function XPerl_ScalePartyPets(num)
	XPerl_partypet4:SetScale(num)
	XPerl_partypet3:SetScale(num)
	XPerl_partypet2:SetScale(num)
	XPerl_partypet1:SetScale(num)
end

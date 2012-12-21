local XPerl_Party_Events = {}
local PartyFrames = {}

----------------------
-- Loading Function --
----------------------
function XPerl_Party_OnLoadEvents()
	this.time = 0
        this:RegisterEvent("PLAYER_ENTERING_WORLD")
        this:RegisterEvent("PLAYER_LEAVING_WORLD")

	-- Set here to reduce amount of function calls made
	this:SetScript("OnEvent", XPerl_Party_OnEvent)
	this:SetScript("OnUpdate", XPerl_Party_OnUpdate)
end

-- XPerl_Party_OnLoad
function XPerl_Party_OnLoad()

	this.feigning = 0
	this.partyid = "party"..this:GetID()

	PartyFrames[this.partyid] = this

	XPerl_InitFadeFrame(this)

	XPerl_RegisterHighlight(getglobal(this:GetName().."_CastClickOverlay"), 3)
	XPerl_RegisterHighlight(getglobal(this:GetName().."_TargetFrame"), 3)
	XPerl_RegisterPerlFrames(this, {"NameFrame", "StatsFrame", "PortraitFrame", "LevelFrame", "TargetFrame"})

	this.FlashFrames = {getglobal(this:GetName().."_NameFrame"),
  				getglobal(this:GetName().."_LevelFrame"),
  				getglobal(this:GetName().."_StatsFrame"),
  				getglobal(this:GetName().."_PortraitFrame")}
end

local PartyEvents = {	"PARTY_MEMBERS_CHANGED", "PARTY_LEADER_CHANGED", "PARTY_LOOT_METHOD_CHANGED",
			"UNIT_FACTION", "UNIT_DYNAMIC_FLAGS", "UNIT_FLAGS", "UNIT_AURA", "PARTY_MEMBER_ENABLE",
			"PARTY_MEMBER_DISABLE", "UNIT_MODEL_CHANGED"}

-- XPerl_Party_RegisterSome
local function XPerl_Party_RegisterSome()
	for i,name in pairs(PartyEvents) do
		XPerl_Party_EventFrame:RegisterEvent(name)
	end
	XPerl_RegisterBasics(XPerl_Party_EventFrame)
end

-- XPerl_Party_UnregisterSome
local function XPerl_Party_UnregisterSome()
	for i,name in pairs(PartyEvents) do
		XPerl_Party_EventFrame:UnregisterEvent(name)
	end
	XPerl_UnregisterBasics(XPerl_Party_EventFrame)
end

-- ShowHideValues
local function ShowHideValues(prefix)
	if (XPerlConfig.ShowPartyValues == 1) then
        	getglobal(prefix.."_StatsFrame_HealthBarText"):Show()
        	getglobal(prefix.."_StatsFrame_ManaBarText"):Show()
	else
        	getglobal(prefix.."_StatsFrame_HealthBarText"):Hide()
        	getglobal(prefix.."_StatsFrame_ManaBarText"):Hide()
	end
end

-- XPerl_Party_ShowPercentages
local function XPerl_Party_ShowPercentages(thisFrame)
	local thisid = thisFrame:GetName()
	if (XPerlConfig.ShowPartyPercent==1) then
		getglobal(thisid.."_StatsFrame"):SetWidth(136)
	end
	ShowHideValues(thisid)
end

-- XPerl_Party_HidePercentages
local function XPerl_Party_HidePercentages(thisFrame, argReason)
	local thisid = thisFrame:GetName()
	getglobal(thisid.."_StatsFrame"):SetWidth(106)

	if (argReason and type(argReason) == "string") then
                getglobal(thisid.."_StatsFrame_HealthBarText"):SetText(argReason)
               	getglobal(thisid.."_StatsFrame_HealthBarText"):Show()
                getglobal(thisid.."_StatsFrame_ManaBarText"):Hide()
	else
		ShowHideValues(thisid)
	end

        getglobal(thisid.."_StatsFrame_HealthBarPercent"):Hide()
        getglobal(thisid.."_StatsFrame_ManaBarPercent"):Hide()
end

-- XPerl_Party_UpdateHealth
local function XPerl_Party_UpdateHealth(thisFrame)
	local numID = thisFrame:GetID()
	local Partyhealth = UnitHealth(thisFrame.partyid)
	local Partyhealthmax = UnitHealthMax(thisFrame.partyid)
	local frameID = thisFrame:GetName().."_StatsFrame_"
	local healthBar = getglobal(frameID.."HealthBar")
	local healthBarPercent = getglobal(frameID.."HealthBarPercent")
	local hide = (XPerlConfig.ShowPartyPercent == 0)
	local percVis = healthBarPercent:IsShown()

	if (thisFrame.feigning == 1 and Partyhealth > 1) then
		thisFrame.feigning = 0
	end
	if  (thisFrame.feigning == 1) then
	        healthBar:SetMinMaxValues(0, 1)
	        healthBar:SetValue(0)
		XPerl_SetSmoothBarColor(healthBar, 1)
	else
		XPerl_SetHealthBar(healthBar, Partyhealth, Partyhealthmax)
	end

	local frameID = thisFrame:GetName().."_StatsFrame_"
	healthBarPercent:SetText(string.format("%d",(100*(Partyhealth / Partyhealthmax))+0.5).."%")
	healthBarPercent:Show()

	local petFrame = getglobal("XPerl_partypet"..numID)
	if (not UnitIsConnected(thisFrame.partyid)) then
		hide = XPERL_LOC_OFFLINE
		thisFrame:SetAlpha(XPerlConfig.Transparency/2)
		if (petFrame) then
			petFrame:SetAlpha(XPerlConfig.Transparency/2)
		end
	else
		thisFrame:SetAlpha(XPerlConfig.Transparency)
		if (petFrame) then
			petFrame:SetAlpha(XPerlConfig.Transparency)
		end

		if (thisFrame.feigning == 1) then
			hide = XPERL_LOC_FEIGNDEATH

		elseif (UnitIsDead(thisFrame.partyid)) then
			hide = XPERL_LOC_DEAD

		elseif (UnitIsGhost(thisFrame.partyid)) then
			hide = XPERL_LOC_GHOST

		elseif ((Partyhealth==1) and (Partyhealthmax==1)) then
			hide = XPERL_LOC_UPDATING
		end
	end

	if (hide) then
		XPerl_Party_HidePercentages(thisFrame, hide)
	else
		XPerl_Party_ShowPercentages(thisFrame)
	end

	if (percVis ~= getglobal(frameID.."HealthBarPercent"):IsShown()) then
		XPerl_StatsFrameSetup(getglobal(thisFrame:GetName().."_StatsFrame"))
	end
end

--------------------
-- Buff Functions --
--------------------

-- GetBuffButton(thisFrame, buffnum, debuff, createIfAbsent)
-- debuff must be 1 or 0, as it's used in size calc
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

		local size = XPerlConfig.PartyBuffSize * (1 + (0.4 * debuff))
		button:SetHeight(size)
		button:SetWidth(size)

		if (debuff == 1) then
			button:SetScript("OnEnter", XPerl_Party_SetDeBuffTooltip)
		else
			button:SetScript("OnEnter", XPerl_Party_SetBuffTooltip)
		end
		button:SetScript("OnLeave", XPerl_PlayerTipHide)

		button:ClearAllPoints()
		if (buffnum == 1) then
			if (debuff == 1) then
				button:SetPoint("LEFT", thisFrame:GetName().."_StatsFrame", "RIGHT", 0, 0)
			else
				button:SetPoint("TOPLEFT", getglobal(thisFrame:GetName().."_BuffFrame"), "TOPLEFT", 0, 0)
			end
		else
			local prevButton = getglobal(thisFrame:GetName().."_BuffFrame_"..buffType..(buffnum - 1))
			button:SetPoint("TOPLEFT", prevButton, "TOPRIGHT", 1 + debuff, 0)
		end
	end

	return button
end

-- XPerl_Party_SetDebuffLoc
local function XPerl_Party_SetDebuffLocation(thisFrame)
	local debuff1 = getglobal("XPerl_party"..thisFrame:GetID().."_BuffFrame_DeBuff1")
	if (debuff1) then
        	debuff1:ClearAllPoints()

		if (XPerlConfig.PartyDebuffsBelow == 0) then
			local petFrame = getglobal("XPerl_partypet"..thisFrame:GetID())
			if (petFrame and petFrame:IsVisible()) then
        	                debuff1:SetPoint("LEFT", "XPerl_partypet"..thisFrame:GetID().."_StatsFrame", "RIGHT", 0, 0)
			else
        	                debuff1:SetPoint("LEFT", "XPerl_party"..thisFrame:GetID().."_StatsFrame", "RIGHT", 0, 0)
			end
		else
			local buff1 = getglobal("XPerl_party"..thisFrame:GetID().."_BuffFrame_Buff1")
			if (not buff1) then
        	        	debuff1:SetPoint("TOPLEFT", ("XPerl_party"..thisFrame:GetID().."_BuffFrame_BuffFrame"), "TOPLEFT", 0, -20)
			else
        	        	debuff1:SetPoint("TOPLEFT", buff1, "BOTTOMLEFT", 0, -2)
			end
		end
	end
end

-- XPerl_Party_SetBuffLoc
function XPerl_Party_SetBuffLocation(thisFrame)
	local buff1 = getglobal(thisFrame:GetName().."_BuffFrame_Buff1")
	if (buff1) then
        	buff1:ClearAllPoints()
		local buffFrame = getglobal(thisFrame:GetName().."_BuffFrame")

		buff1:SetPoint("TOPLEFT", buffFrame, "TOPLEFT", 0, 0)
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

-- XPerl_Party_Buff_UpdateAll
local function XPerl_Party_Buff_UpdateAll(thisFrame)
	local partyid = thisFrame.partyid
	local thisid = thisFrame:GetName()

	if (XPerlConfig.PartyBuffs == 0 and XPerlConfig.PartyDebuffs == 0) then
		getglobal(thisid.."_BuffFrame"):Hide()
	else
		getglobal(thisid.."_BuffFrame"):Show()

		if (UnitExists(partyid)) then
			local needUpdateHealth = false

			if (XPerlConfig.PartyBuffs == 1) then
				for buffnum=1,16 do
					local buff, count = XPerl_UnitBuff(partyid, buffnum, XPerlConfig.PartyCastableBuffs)

					if (buff) then
						local button = GetBuffButton(thisFrame, buffnum, 0, true)

						local icon = getglobal(button:GetName().."Icon")
						icon:SetTexture(buff)

						if (strfind(strlower(buff), "feigndeath")) then
							if (thisFrame.feigning == 0) then
								thisFrame.feigning = 1
								needUpdateHealth = true
							end
						end
						local buffCount = getglobal(button:GetName().."Count")
						if (count > 1) then
							buffCount:SetText(count)
							buffCount:Show()
						else
							buffCount:Hide()
						end
						button:Show()
					else
						local button = getglobal(thisid.."_BuffFrame_Buff"..buffnum)
						if (button) then
							button:Hide()
						end
					end
				end

				XPerl_Party_SetBuffLocation(thisFrame)
			else
				for buffnum=1,16 do
					local button = getglobal(thisid.."_BuffFrame_Buff"..buffnum)
					if (button) then
						button:Hide()
					end
				end
			end

			if (XPerlConfig.PartyDebuffs == 1) then
				for buffnum=1,8 do
					local buff, count, debuffType = XPerl_UnitDebuff(partyid, buffnum, XPerlConfig.PartyCurableDebuffs)

					if (buff) then
						local button = GetBuffButton(thisFrame, buffnum, 1, buff)

						local icon = getglobal(button:GetName().."Icon")
						icon:SetTexture(buff)

						local buffCount = getglobal(button:GetName().."Count")
						if (count > 1) then
							buffCount:SetText(count)
							buffCount:Show()
						else
							buffCount:Hide()
						end

						local borderColor = DebuffTypeColor[(debuffType or "none")]
						local buffBorder = getglobal(button:GetName().."Border")
						buffBorder:SetVertexColor(borderColor.r, borderColor.g, borderColor.b)

						button:Show()
					else
						local button = getglobal(thisid.."_BuffFrame_DeBuff"..buffnum)
						if (button) then
							button:Hide()
						end
					end
				end

				XPerl_Party_SetDebuffLocation(thisFrame)
			else
				for buffnum=1,8 do
					local button = getglobal(thisid.."_BuffFrame_DeBuff"..buffnum)
					if (button) then
						button:Hide()
					end
				end
			end

			if (XPerlConfig.PartyBuffs == 0 or XPerlConfig.PartyCastableBuffs == 1) then
				local _, class = UnitClass(thisFrame.partyid)
				if (class == "HUNTER") then
					if (XPerl_IsFeignDeath(thisFrame.partyid)) then
						thisFrame.feigning = 1
						needUpdateHealth = true
					end
				end
			end

			if (needUpdateHealth) then
				XPerl_Party_UpdateHealth(thisFrame)
			end
		end
	end

	XPerl_CheckDebuffs(partyid, {getglobal(thisFrame:GetName().."_NameFrame"),getglobal(thisFrame:GetName().."_LevelFrame"),getglobal(thisFrame:GetName().."_PortraitFrame"),getglobal(thisFrame:GetName().."_StatsFrame")})
end

-- XPerl_Party_SetBuffTooltip
function XPerl_Party_SetBuffTooltip()
	local partyid = "party"..this:GetParent():GetParent():GetID()
	GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT",30,0)
	--GameTooltip:SetUnitBuff(partyid, this:GetID(), XPerlConfig.PartyCastableBuffs)
	XPerl_TooltipSetUnitBuff(GameTooltip, partyid, this:GetID(), XPerlConfig.PartyCastableBuffs)
	XPerl_ToolTip_AddBuffDuration(partyid)
end

-- XPerl_Party_SetDeBuffTooltip
function XPerl_Party_SetDeBuffTooltip()
	local partyid = "party"..this:GetParent():GetParent():GetID()
	GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT",30,0)
	--GameTooltip:SetUnitDebuff(partyid, this:GetID(), XPerlConfig.PartyCurableDebuffs)
	XPerl_TooltipSetUnitDebuff(GameTooltip, partyid, this:GetID(), XPerlConfig.PartyCurableDebuffs)
end

-------------------------
-- The Update Function --
-------------------------
local function XPerl_Party_CombatFlash(thisFrame, elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet (elapsed, thisFrame, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(thisFrame)
	end
end

-- XPerl_Party_UpdatePortrait
function XPerl_Party_UpdatePortrait(thisFrame)
	if (XPerlConfig.ShowPartyPortrait == 1) then
		local framePortrait = getglobal(thisFrame:GetName().."_PortraitFrame_Portrait")
		local framePortrait3D = getglobal(thisFrame:GetName().."_PortraitFrame_Portrait3D")

		if (XPerlConfig.ShowPartyPortrait3D == 1 and UnitIsVisible(thisFrame.partyid)) then
			framePortrait:Hide()
			framePortrait3D:Show()
			XPerlSetPortrait3D(framePortrait3D, thisFrame.partyid)
		else
			framePortrait3D.last3DTime = nil
			framePortrait:Show()
			framePortrait3D:Hide()
			SetPortraitTexture(framePortrait, thisFrame.partyid)
		end
	end
end

-- XPerl_Party_UpdateName
local function XPerl_Party_UpdateName(thisFrame)
	local thisid = thisFrame:GetName()
	local Partyname = UnitName(thisFrame.partyid)
	if (Partyname) then
		local nameFrame = getglobal(thisid.."_NameFrame")
		local textFrame = getglobal(thisid.."_NameFrameText")

		textFrame:SetFontObject(GameFontNormal)
                textFrame:SetText(Partyname)

		if (textFrame:GetStringWidth() > nameFrame:GetWidth() - 4) then
			textFrame:SetFontObject(GameFontNormalSmall)
		end

		XPerl_ColourFriendlyUnit(textFrame, thisFrame.partyid)
	end
end

-- XPerl_Party_UpdateLeader
local function XPerl_Party_UpdateLeader(thisFrame)
	--partyid = ("party"..this:GetID())
	local thisid = thisFrame:GetName()
	local id = thisFrame:GetID()
	local icon = getglobal(thisid.."_NameFrame_LeaderIcon")
	if (GetPartyLeaderIndex() == id ) then
		icon:Show()
	else
		icon:Hide()
	end
	icon = getglobal(thisid.."_NameFrame_MasterIcon")
	local lootMethod
	local lootMaster
	lootMethod, lootMaster = GetLootMethod()
	if ( id == lootMaster ) then
		icon:Show()
	else
		icon:Hide()
	end
end

-- XPerl_Party_Update_Control
local function XPerl_Party_Update_Control(thisFrame)
	if (UnitIsVisible(thisFrame.partyid) and UnitIsCharmed(thisFrame.partyid)) then
		--XPerl_Target_Warning:SetTexture("Interface\Minimap\Ping\ping6")
		--XPerl_Target_Warning:SetBlendMode("ADD")
		getglobal(thisFrame:GetName().."_NameFrame_Warning"):Show()
	else
		getglobal(thisFrame:GetName().."_NameFrame_Warning"):Hide()
	end
end

-- XPerl_Party_UpdatePVP
local function XPerl_Party_UpdatePVP(thisFrame)
	local f = getglobal(thisFrame:GetName().."_NameFrame_PVPStatus")
	if (XPerlConfig.ShowPartyPVP == 1 and UnitIsPVP(thisFrame.partyid)) then
		f:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..(UnitFactionGroup(thisFrame.partyid) or "FFA"))
	        f:Show()
	else
	        f:Hide()
	end
end

-- XPerl_Party_UpdateCombat
function XPerl_Party_UpdateCombat(thisFrame)
	XPerl_Party_UpdateCombat1(thisFrame.partyid, thisFrame:GetName())
	XPerl_Party_Update_Control(thisFrame)
end

-- XPerl_Party_UpdateCombat1
function XPerl_Party_UpdateCombat1(argID,argName)
	local frame = getglobal(argName.."_NameFrame_ActivityStatus")
	if (UnitAffectingCombat(argID)) then
	        frame:Show()
	else
	        frame:Hide()
	end
end

-- XPerl_Party_UpdateLevel
local function XPerl_Party_UpdateLevel(thisFrame)
	local Partylevel = UnitLevel(thisFrame.partyid)
	local color = GetDifficultyColor(Partylevel)
	getglobal(thisFrame:GetName().."_LevelFrame_LevelBarText"):SetTextColor(color.r,color.g,color.b)
	getglobal(thisFrame:GetName().."_LevelFrame_LevelBarText"):SetText(Partylevel)
end

-- XPerl_Party_UpdateClass
local function XPerl_Party_UpdateClass(thisFrame)
	if (UnitIsPlayer(thisFrame.partyid)) then
		local _, PlayerClass = UnitClass(thisFrame.partyid)
		local r, l, t, b = XPerl_ClassPos(PlayerClass)
		getglobal(thisFrame:GetName().."_LevelFrame_ClassTexture"):SetTexCoord(r, l, t, b)
	end

	if (XPerlConfig.ShowPartyClassIcon==1) then
	        getglobal(thisFrame:GetName().."_LevelFrame_ClassTexture"):Show()
	else
	        getglobal(thisFrame:GetName().."_LevelFrame_ClassTexture"):Hide()
	end
end

-- XPerl_Party_UpdateManaType
local function XPerl_Party_UpdateManaType(thisFrame)
	local frameName = thisFrame:GetName().."_StatsFrame_ManaBar"
	XPerl_SetManaBarType(thisFrame.partyid, getglobal(frameName), getglobal(frameName.."BG"))
end

-- XPerl_Party_UpdateMana
local function XPerl_Party_UpdateMana(thisFrame)
	--partyid = ("party"..this:GetID())
	local thisid = thisFrame:GetName()
	local Partymana = UnitMana(thisFrame.partyid)
	local Partymanamax = UnitManaMax(thisFrame.partyid)
	local frameManaBar = getglobal(thisid.."_StatsFrame_ManaBar")
	local frameManaBarText = getglobal(thisid.."_StatsFrame_ManaBarText")
	local frameManaBarPercent = getglobal(thisid.."_StatsFrame_ManaBarPercent")
	local frameHealthBarPercent = getglobal(thisid.."_StatsFrame_HealthBarPercent")

	if (Partymanamax == 1 and Partymana > Partymanamax) then
		Partymanamax = Partymana
	end

	frameManaBar:SetMinMaxValues(0, Partymanamax)
	frameManaBar:SetValue(Partymana)
	pmanaPct = (Partymana * 100.0) / Partymanamax
	pmanaPct =  string.format("%3.0f", pmanaPct)
	if (frameHealthBarPercent:IsVisible()) then
		frameManaBarPercent:Show()
	end
	if (UnitPowerType(thisFrame.partyid)>=1) then
	        frameManaBarPercent:SetText(Partymana)
	else
	        frameManaBarPercent:SetText(string.format("%d",(100*(Partymana / Partymanamax))+0.5).."%")
	end

	if (XPerlConfig.ShowPartyValues == 1) then
		frameManaBarText:Show()
	else
		frameManaBarText:Hide()
	end

	frameManaBarText:SetText(Partymana.."/"..Partymanamax)
	if (XPerlConfig.ShowPartyPercent==0) then
	        frameManaBarPercent:Hide()
	        frameHealthBarPercent:Hide()
	        getglobal(thisid.."_StatsFrame"):SetWidth(106)
	end
	local petFrame = getglobal("XPerl_partypet"..thisFrame:GetID())
	if (UnitIsConnected(thisFrame.partyid)) then
		thisFrame:SetAlpha(XPerlConfig.Transparency)
		if (petFrame) then
			petFrame:SetAlpha(XPerlConfig.Transparency)
		end
	else
		thisFrame:SetAlpha(XPerlConfig.Transparency/2)
		if (petFrame) then
	      		petFrame:SetAlpha(XPerlConfig.Transparency/2)
		end
	        getglobal(thisid.."_StatsFrame_HealthBarText"):SetText(XPERL_LOC_OFFLINE)
	end
end

-- XPerl_Party_UpdateRange
local function XPerl_Party_UpdateRange(thisFrame)
	local f = getglobal(thisFrame:GetName().."_NameFrame_RangeStatus")

	if (XPerlConfig.ShowParty30YardSymbol == 0 or CheckInteractDistance(thisFrame.partyid, 4) or not UnitIsConnected(thisFrame.partyid)) then
		f:Hide()
	else
		f:Show()
		f:SetAlpha(1)
	end
end

-- XPerl_Party_OnUpdate
function XPerl_Party_OnUpdate()
	local update
	this.time = arg1 + this.time
	if this.time >= 0.2 then
		update = true
		this.time = 0
	end
	local any

	for i,frame in pairs(PartyFrames) do
		if (frame:IsShown()) then
			if (frame.PlayerFlash) then
				XPerl_Party_CombatFlash(frame, arg1, false)
			end

			if (frame.Fading == 0) then
				if (update) then
					XPerl_Party_UpdateRange(frame)
					XPerl_Party_UpdateTarget(frame)
				end
			else
				XPerl_ProcessFade(frame)
			end
			any = true
		end
	end

	if (not any) then
		XPerl_Party_EventFrame:Hide()
	end
end

-- XPerl_Party_StartFade
local function XPerl_Party_StartFade(thisFrame)
	local framePet = getglobal("XPerl_partypet"..thisFrame:GetID())
	if (framePet and framePet:IsVisible()) then
		XPerl_StartFade(framePet)
	end
	XPerl_StartFade(thisFrame)

	if (UnitExists(thisFrame.partyid) and not UnitIsConnected(thisFrame.partyid)) then
		thisFrame.FadeTime = 0.5
		if (framePet and framePet:IsVisible()) then
			framePet.FadeTime = 0.5
		end
	end
end

-- XPerl_Party_UpdateDisplayAll
function XPerl_Party_UpdateDisplayAll()
	local any
	for i,frame in pairs(PartyFrames) do
		XPerl_Party_UpdateDisplay(frame)
		if (frame:IsShown()) then
			any = true
		end
	end

	if (any) then
		XPerl_Party_EventFrame:Show()
	else
		XPerl_Party_EventFrame:Hide()
	end
end

-- XPerl_Party_UpdateDisplay
function XPerl_Party_UpdateDisplay(thisFrame)
	if (thisFrame and thisFrame.partyid) then
		if (UnitExists(thisFrame.partyid)) then
			XPerl_CancelFade(thisFrame)

			XPerl_Party_UpdateName(thisFrame)
			XPerl_Party_UpdateLeader(thisFrame)
			XPerl_Party_UpdateClass(thisFrame)
			XPerl_Party_UpdateManaType(thisFrame)
			XPerl_Party_UpdateHealth(thisFrame)
			XPerl_Party_UpdateMana(thisFrame)
			XPerl_Party_UpdateLevel(thisFrame)
			XPerl_Party_Update_Control(thisFrame)
        	        XPerl_Party_UpdateCombat(thisFrame)
			XPerl_Party_UpdatePVP(thisFrame)
			XPerl_Party_UpdatePortrait(thisFrame)
			XPerl_Party_Buff_UpdateAll(thisFrame)

			if (XPerlConfig.ShowPartyRaid == 1 or not UnitInRaid("player")) then
				thisFrame:Show()
			else
				XPerl_Party_StartFade(thisFrame)
			end

		else
			XPerl_Party_StartFade(thisFrame)
		end
	end
end

--------------------
-- Click Handlers --
--------------------
-- Non local by request (GenesisClicks/Elsewhere)
Perl_Party_FindID = XPerl_Frame_FindID

function XPerl_Party_OnClick(button,argTarget)

	local unit = this:GetParent().partyid

	if (argTarget == 1) then
		unit = unit.."target"
	end

	if (XPerl_OnClick_Handler(button, unit)) then
		return
	end

	if (button == "RightButton") then
		if (argTarget == 0) then
			local id = this:GetParent():GetID()

			HideDropDownMenu(1)
			ToggleDropDownMenu(1, nil, getglobal("PartyMemberFrame"..id.."DropDown"), this:GetParent():GetName().."_StatsFrame", 0, 0)
		end
	end
end

-- XPerl_Party_PlayerTip
function XPerl_Party_PlayerTip(argTarget)
	local unitid = this:GetParent().partyid
	if (argTarget) then
		unitid = unitid.."target"
	end

	XPerl_PlayerTip(unitid)
end

-- XPerl_Party_UpdateTarget
function XPerl_Party_UpdateTarget(thisFrame)
	local frame = getglobal("XPerl_"..thisFrame.partyid.."_TargetFrame")
	local petFrame = getglobal("XPerl_partypet"..thisFrame:GetID())

	if (frame == nil) then
		return
	end
	if (frame.Fading == 1) then
		return
	end

	if (XPerlConfig.ShowPartyTarget == 1) then
		local frameText = getglobal("XPerl_"..thisFrame.partyid.."_TargetFrame_Target")
		if (UnitIsConnected(thisFrame.partyid) and UnitExists(thisFrame.partyid) and UnitIsVisible(thisFrame.partyid)) then
			local unit = thisFrame.partyid.."target"
			local targetname = UnitName(unit)

			if (targetname and targetname ~= UNKNOWNOBJECT) then
			-- if (UnitExists (unit)) then - Changed as a test, as u can often pick up unit name, and unit class, but not health etc.
				--local targetname = UnitName(unit)
				frameText:SetText(targetname)
				local width = frameText:GetStringWidth()

				if (width < 68) then
					frame:SetWidth(68)
				elseif (width > 112) then
					frame:SetWidth(120)

					local remCount = 1
					while ((frameText:GetStringWidth() >= 112) and (string.len(targetname) > remCount)) do
						targetname = string.sub(targetname, 1, string.len(targetname) - remCount)..".."
						remCount = 3
						frameText:SetText(targetname)
					end
				else
					frame:SetWidth(width + 8)
				end

				XPerl_SetUnitNameColor (unit, frameText)
				frame:Show()

				local frameAct = getglobal("XPerl_"..thisFrame.partyid.."_TargetFrame_TargetActivityStatus")
			        if (UnitAffectingCombat(unit)) then
			                frameAct:SetTexCoord(0.5, 1.0, 0.0, 0.5)
			                frameAct:Show()
				else
			                frameAct:Hide()
				end

				local framePVP = getglobal("XPerl_"..thisFrame.partyid.."_TargetFrame_TargetPVPStatus")
				if (XPerlConfig.ShowPartyPVP == 1 and UnitIsPVP(unit)) then
					framePVP:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..(UnitFactionGroup(unit) or "FFA"))
					framePVP:Show()
				else
					framePVP:Hide()
				end
			else
				frame:Hide()
			end
		else
			frame:Hide()
		end
	else
		frame:Hide()
	end

	if (petFrame) then
		petFrame:ClearAllPoints()
		if (frame:IsShown() and XPerlConfig.ShowPartyPetName == 1) then
			petFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", -2, 2)
		else
			if (XPerlConfig.ShowPartyPetName == 1) then
				petFrame:SetPoint("TOPLEFT", frame:GetParent():GetName().."_StatsFrame", "TOPRIGHT", -2, 21)
			else
				petFrame:SetPoint("TOPLEFT", frame:GetParent():GetName().."_StatsFrame", "TOPRIGHT", -2, 0)
			end
		end
	end
end

-------------------
-- Event Handler --
-------------------
function XPerl_Party_OnEvent()
	local func = XPerl_Party_Events[event]
	if (func) then
		func()
	else
XPerl_ShowMessage("EXTRA EVENT")
		--XPerl_Party_UpdateDisplay()
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Party_Events:PLAYER_ENTERING_WORLD()
	XPerl_Party_RegisterSome()
	XPerl_Party_UpdateDisplayAll()
end
XPerl_Party_Events.PARTY_MEMBERS_CHANGED		= XPerl_Party_Events.PLAYER_ENTERING_WORLD

-- PLAYER_LEAVING_WORLD()
function XPerl_Party_Events:PLAYER_LEAVING_WORLD()
	XPerl_Party_UnregisterSome()
end

-- PARTY_LEADER_CHANGED
function XPerl_Party_Events:PARTY_LEADER_CHANGED()
	for i,frame in pairs(PartyFrames) do
		XPerl_Party_UpdateLeader(frame)
	end
end

XPerl_Party_Events.PARTY_LOOT_METHOD_CHANGED	= XPerl_Party_Events.PARTY_LEADER_CHANGED

-- UNIT_COMBAT
function XPerl_Party_Events:UNIT_COMBAT()
	local f = PartyFrames[arg1]
	if (f) then
		XPerl_Party_UpdateCombat(f)

		if (arg2 == "HEAL") then
			XPerl_Party_CombatFlash(f, 0, true, true)
		elseif (arg4 and arg4 > 0) then
			XPerl_Party_CombatFlash(f, 0, true)
		end
	end
end

-- UNIT_HEALTH, UNIT_MAXHEALTH
function XPerl_Party_Events:UNIT_HEALTH()
	local f = PartyFrames[arg1]
	if (f) then
		XPerl_Party_UpdateHealth(f)
	end
end

-- UNIT_MAXHEALTH
function XPerl_Party_Events:UNIT_MAXHEALTH()
	local f = PartyFrames[arg1]
	if (f) then
		XPerl_Party_UpdateHealth(f)
		XPerl_Party_UpdateLevel(f)	-- Level not available until we've received maxhealth
		XPerl_Party_UpdateClass(f)
	end
end

XPerl_Party_Events.PARTY_MEMBER_ENABLE	= XPerl_Party_Events.UNIT_HEALTH
XPerl_Party_Events.PARTY_MEMBER_DISABLE	= XPerl_Party_Events.UNIT_HEALTH

-- UNIT_MODEL_CHANGED
function XPerl_Party_Events:UNIT_MODEL_CHANGED()
	local f = PartyFrames[arg1]
	if (f) then
		XPerl_Party_UpdatePortrait(f)
	end
end
--XPerl_Party_Events.UNIT_PORTRAIT_UPDATE = XPerl_Party_Events.UNIT_MODEL_CHANGED

-- UNIT_MANA
function XPerl_Party_Events:UNIT_MANA()
	local f = PartyFrames[arg1]
	if (f) then
		XPerl_Party_UpdateMana(f)
	end
end

XPerl_Party_Events.UNIT_MAXMANA		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_RAGE		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_MAXRAGE		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_ENERGY		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_MAXENERGY	= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_FOCUS		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_MAXFOCUS		= XPerl_Party_Events.UNIT_MANA

-- UNIT_DISPLAYPOWER
function XPerl_Party_Events:UNIT_DISPLAYPOWER()
	local f = PartyFrames[arg1]
	if (f) then
		XPerl_Party_UpdateManaType(f)
		XPerl_Party_UpdateMana(f)
	end
end

-- UNIT_NAME_UPDATE
function XPerl_Party_Events:UNIT_NAME_UPDATE()
	if (PartyFrames[arg1]) then
		XPerl_Party_UpdateName(PartyFrames[arg1])
	end
end

-- UNIT_LEVEL
function XPerl_Party_Events:UNIT_LEVEL()
	if (PartyFrames[arg1]) then
		XPerl_Party_UpdateLevel(PartyFrames[arg1])
	end
end

-- UNIT_AURA
function XPerl_Party_Events:UNIT_AURA()
	local f = PartyFrames[arg1]
	if (f) then
		XPerl_Party_Buff_UpdateAll(f)
	end
end

-- UNIT_FACTION
function XPerl_Party_Events:UNIT_FACTION()
	local f = PartyFrames[arg1]
	if (f) then
		XPerl_Party_UpdateName(f)
        	XPerl_Party_UpdateCombat(f)
		XPerl_Party_Update_Control(f)
		XPerl_Party_UpdatePVP(f)
	end
end

XPerl_Party_Events.UNIT_FLAGS = XPerl_Party_Events.UNIT_FACTION
XPerl_Party_Events.UNIT_DYNAMIC_FLAGS = XPerl_Party_Events.UNIT_FACTION

---- Moving stuff ----
-- XPerl_Party_GetGap
function XPerl_Party_GetGap()
	return math.floor(math.floor((XPerl_party1:GetBottom() - XPerl_party2:GetTop() + 0.01) * 100) / 100)
end

-- XPerl_Party_SetGap
function XPerl_Party_SetGap(newGap)
	if (type(newGap) ~= "number") then
		return
	end

	local top = XPerl_party1:GetTop()
	local height = XPerl_party1:GetHeight()

	if (type(newGap) == "number") then
		for i = 1,4 do
			local frame = getglobal("XPerl_party"..i)
			local left = frame:GetLeft()

			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)

			top = top - (newGap + height)

			frame:SetUserPlaced(true)
		end
	end
end

-- XPerl_Party_AlignLeft
function XPerl_Party_AlignLeft()
	local left = XPerl_party1:GetLeft()

	for i = 1,4 do
		local frame = getglobal("XPerl_party"..i)

		local top = frame:GetTop()

		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)

		frame:SetUserPlaced(true)
	end
end

-- XPerl_Party_Set_Bits
function XPerl_Party_Set_Bits()
	for num=1,4 do
		local levelFrame = getglobal("XPerl_party"..num.."_LevelFrame")
		local nameFrame = getglobal("XPerl_party"..num.."_NameFrame")
		local statsFrame = getglobal("XPerl_party"..num.."_StatsFrame")
		local portraitFrame = getglobal("XPerl_party"..num.."_PortraitFrame")
		local clickFrame = getglobal("XPerl_party"..num.."_CastClickOverlay")
		local classTexture = getglobal("XPerl_party"..num.."_LevelFrame_ClassTexture")
		local levelText = getglobal("XPerl_party"..num.."_LevelFrame_LevelBarText")

		portraitFrame:ClearAllPoints()
		nameFrame:ClearAllPoints()
		levelFrame:ClearAllPoints()
		statsFrame:ClearAllPoints()
		classTexture:ClearAllPoints()
		levelText:ClearAllPoints()
		clickFrame:ClearAllPoints()

		if (XPerlConfig.ShowPartyPortrait==0) then
			portraitFrame:Hide()

			levelFrame:SetWidth(30)
			levelFrame:SetHeight(41)

			nameFrame:SetPoint("TOPLEFT", getglobal("XPerl_party"..num), "TOPLEFT", 0, 0)
			levelFrame:SetPoint("TOPLEFT", nameFrame, "BOTTOMLEFT", 0, 3)
			statsFrame:SetPoint("TOPLEFT", levelFrame, "TOPRIGHT", -3, 0)

			levelText:SetPoint("BOTTOM", levelFrame, "BOTTOM", 0, 4)
			classTexture:SetPoint("TOPLEFT", levelFrame, "TOPLEFT", 5, -5)

			getglobal("XPerl_party"..num.."_BuffFrame"):SetPoint("TOPLEFT", statsFrame, "BOTTOMLEFT", 5, 0)

			clickFrame:SetPoint("TOPLEFT", nameFrame, "TOPLEFT", 0, 0)
			clickFrame:SetPoint("BOTTOMRIGHT", statsFrame, "BOTTOMRIGHT", 0, 0)
		else
			portraitFrame:Show()

			levelFrame:SetWidth(27)
			levelFrame:SetHeight(22)

			levelFrame:SetPoint("TOPLEFT", getglobal("XPerl_party"..num), "TOPLEFT", 0, 0)
			portraitFrame:SetPoint("TOPLEFT", levelFrame, "TOPRIGHT", -2, 0)
			nameFrame:SetPoint("TOPLEFT", portraitFrame, "TOPRIGHT", -3, 0)
			statsFrame:SetPoint("TOPLEFT", nameFrame, "BOTTOMLEFT", 0, 3)

			levelText:SetPoint("CENTER", 0, 0)
			classTexture:SetPoint("BOTTOMRIGHT", portraitFrame, "BOTTOMLEFT", 0, 3)

			getglobal("XPerl_party"..num.."_BuffFrame"):SetPoint("TOPLEFT", portraitFrame, "BOTTOMLEFT", 5, 0)

			clickFrame:SetPoint("TOPLEFT", levelFrame, "TOPLEFT", 0, 0)
			clickFrame:SetPoint("BOTTOMRIGHT", statsFrame, "BOTTOMRIGHT", 0, 0)
		end

		if (XPerlConfig.ShowPartyLevel==0) then
			getglobal("XPerl_party"..num.."_LevelFrame_LevelBarText"):Hide()
			if (XPerlConfig.ShowPartyLevel==1) then
				levelFrame:SetHeight(levelFrame:GetHeight()-10)
			end
		else
			getglobal("XPerl_party"..num.."_LevelFrame_LevelBarText"):Show()
			levelFrame:Show()

			if (XPerlConfig.ShowPartyLevel==0) then
				levelFrame:SetHeight(levelFrame:GetHeight()+10)
			end

			if (XPerlConfig.ShowPartyPortrait == 1) then
				levelFrame:SetWidth(27)
			else
				levelFrame:SetWidth(30)
			end
		end

		if (XPerlConfig.ShowPartyClassIcon==0) then
			classTexture:Hide()

			if (XPerlConfig.ShowPartyLevel == 0) then
				levelFrame:SetWidth(1)
				levelFrame:Hide()
			end
		else
			classTexture:Show()
			levelFrame:Show()

			if (XPerlConfig.ShowPartyPortrait == 1) then
				levelFrame:SetWidth(27)
			else
				levelFrame:SetWidth(30)
			end
		end

		local frameHealth = getglobal("XPerl_party"..num.."_StatsFrame_HealthBarPercent")
		local frameMana = getglobal("XPerl_party"..num.."_StatsFrame_ManaBarPercent")
		local width = (30 * XPerlConfig.ShowPartyPercent) + 106;	-- 136 enabled, 106 disabled

		statsFrame:SetWidth(width)
		if (XPerlConfig.ShowPartyPercent == 0) then
			frameHealth:Hide()
			frameMana:Hide()
		else
			frameHealth:Show()
			frameMana:Show()
		end

		local height = (XPerlConfig.ShowPartyNames * 22) + 2;		-- 24 when enabled, 2 when disabled
		local targetFrame = getglobal("XPerl_party"..num.."_TargetFrame")

		targetFrame:ClearAllPoints()
		nameFrame:SetHeight(height)

		if (XPerlConfig.ShowPartyNames==0) then
			nameFrame:Hide()
			targetFrame:SetPoint("TOPLEFT", statsFrame, "BOTTOMLEFT", 0, 2)
		else
			nameFrame:Show()
			targetFrame:SetPoint("BOTTOMLEFT", nameFrame, "BOTTOMRIGHT", -2, 2)
		end

		XPerlConfig.PartyBuffSize = tonumber(XPerlConfig.PartyBuffSize) or 20
		XPerl_SetBuffSize("XPerl_party"..num.."_", XPerlConfig.PartyBuffSize, XPerlConfig.PartyBuffSize * 1.4)
	end
end

-- XPerl_ScaleParty
function XPerl_ScaleParty(num)
	XPerl_party4:SetScale(num)
	XPerl_party3:SetScale(num)
	XPerl_party2:SetScale(num)
	XPerl_party1:SetScale(num)
end

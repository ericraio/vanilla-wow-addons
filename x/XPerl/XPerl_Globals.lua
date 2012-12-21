--[[
	Define all Global Variables here
]]

-- Global Variables that are not supposed to be on-the-fly user configurable.
XPerlLocked		= 1

function XPerl_ShowMessage(cMsg)
	local str = "|c00FF7F00"..event.."|r"
	str = str..", "..tostring(arg1)
	if (arg1) then
		if (strfind(arg1, "^raid") or strfind(arg1, "^party") or strfind(arg1, "^player") or strfind(arg1, "^pet") or strfind(arg1, "^target")) then
			str = str.."("..UnitName(arg1)..")"
		end
	end

	str = str..", "..tostring(arg2)
	str = str..", "..tostring(arg3)
	str = str..", "..tostring(arg4)
	str = str..", "..tostring(arg5)
	str = str..", "..tostring(arg6)
	str = str..", "..tostring(arg7)
	str = str..", "..tostring(arg8)
	str = str..", "..tostring(arg9)

	if (cMsg) then
		str = cMsg.." - "..str
	end

	ChatFrame7:AddMessage("|c00007F7F"..this:GetName().."|r - "..str)
end

function XPerl_Notice(str)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(XPerl_ProductName.." - |c00B03030"..str)
	end
end

function XPerl_SetMyGlobal()
	if (XPerlConfigSavePerCharacter) then
		if (not XPerlConfig_Global) then
			XPerlConfig_Global = {}
		end

		if (not XPerlConfig_Global[GetRealmName()]) then
			XPerlConfig_Global[GetRealmName()] = {}
		end

		XPerlConfig_Global[GetRealmName()][UnitName("player")] = XPerlConfig
	else
		if (XPerlConfig_Global[GetRealmName()][UnitName("player")]) then
			XPerlConfig = XPerlConfig_Global[GetRealmName()][UnitName("player")]
		end
	end
end

local function DefaultVar(name, value)
	if (XPerlConfig[name] == nil or (type(value) ~= type(XPerlConfig[name]))) then
		XPerlConfig[name] = value
	end
end

function XPerl_DefaultBarColours(reset)
	if (reset) then
		XPerlConfig.ClassicHealthBar = nil
		XPerlConfig.ColourHealthEmpty = nil
		XPerlConfig.ColourHealthFull = nil
		XPerlConfig.ColourMana = nil
		XPerlConfig.ColourEnergy = nil
		XPerlConfig.ColourRage = nil
		XPerlConfig.ColourFocus = nil
	end

	DefaultVar("ClassicHealthBar",		1)
	DefaultVar("ColourHealthEmpty",		{r = 1, g = 0, b = 0})
	DefaultVar("ColourHealthFull",		{r = 0, g = 1, b = 0})
	DefaultVar("ColourMana",		{r = 0, g = 0, b = 1})
	DefaultVar("ColourEnergy",		{r = 1, g = 1, b = 0})
	DefaultVar("ColourRage",		{r = 1, g = 0, b = 0})
	DefaultVar("ColourFocus",		{r = 1, g = 0.5, b = 0.25})
end

function XPerl_DefaultReactionColours(reset)
	if (reset) then
		XPerlConfig.ColourReactionEnemy = nil
		XPerlConfig.ColourReactionNeutral = nil
		XPerlConfig.ColourReactionUnfriendly = nil
		XPerlConfig.ColourReactionFriend = nil
		XPerlConfig.ColourReactionNone = nil
	        XPerlConfig.ColourTapped = nil
	end

	DefaultVar("ColourReactionEnemy",	{r = 1, g = 0, b = 0})
	DefaultVar("ColourReactionNeutral",	{r = 1, g = 1, b = 0})
	DefaultVar("ColourReactionUnfriendly",	{r = 1, g = 0.5, b = 0})
	DefaultVar("ColourReactionFriend",	{r = 0, g = 1, b = 0})
	DefaultVar("ColourReactionNone",	{r = 0.5, g = 0.5, b = 1})
        DefaultVar("ColourTapped",		{r = 0.5, g = 0.5, b = 0.5})
end

function XPerl_Defaults()

	DefaultVar("BarTextures",		1)
	DefaultVar("BackgroundTextures",	0)		-- 1.8.6
	DefaultVar("Transparency",		0.8)
	DefaultVar("TextTransparency",		1)
	DefaultVar("BackColour",		{r = 0, g = 0, b = 0, a = 1})
	DefaultVar("BorderColour",		{r = 0.5, g = 0.5, b = 0.5, a = 1})
	if (not XPerlConfig.BackColour.a) then
		XPerlConfig.BackColour.a = 1
	end
	if (not XPerlConfig.BorderColour.a) then
		XPerlConfig.BorderColour.a = 1
	end

	DefaultVar("ArcaneBar",			1)
	DefaultVar("OldCastBar",		1)
	DefaultVar("CastTime",			1)
	DefaultVar("ClassColouredNames",	1)
	DefaultVar("HighlightSelection",	1)
	DefaultVar("MinimapButtonPosition",	186)
	DefaultVar("MinimapButtonShown",	1)
	DefaultVar("PerlCombatFlash",		1)
	DefaultVar("PerlFadeFrames",		1)
	DefaultVar("CombatHitIndicator",	1)
	DefaultVar("HighlightDebuffs",		1)
	DefaultVar("HighlightDebuffsBorder",	1)
	DefaultVar("BuffTooltipHelper",		1)
	DefaultVar("FadingTooltip",		1)		-- 1.8.3
	DefaultVar("HealerMode",		0)
	DefaultVar("HealerModeType",		1)		-- 1.8.3
	DefaultVar("FatHealthBars",		1)
	DefaultVar("MaximumScale",		1.5)
	DefaultVar("ClearBlizzardFrames",	0)		-- 1.8.3
	DefaultVar("OptionsColour",		{r = 0.7, g = 0.2, b = 0.2})	-- 1.8.3
	DefaultVar("InverseBars",		0)		-- 1.8.6
	DefaultVar("XPerlTooltipInfo",		0)		-- 1.8.6

	XPerl_DefaultBarColours()
	XPerl_DefaultReactionColours()

	-- Player options
	DefaultVar("ShowPlayerPortrait",	1)
	DefaultVar("ShowPlayerPortrait3D",	1)
	DefaultVar("ShowPlayerLevel",		1)
	DefaultVar("ShowPlayerClassIcon",	1)
	DefaultVar("ShowPlayerXPBar",		0)
	DefaultVar("ShowPlayerPVPRank",		1)
	DefaultVar("ShowPlayerPVP",		1)		-- 1.8.3
	DefaultVar("ShowPlayerValues",		1)
	DefaultVar("ShowPlayerPercent",		1)
	DefaultVar("Scale_PlayerFrame",		0.8)
	DefaultVar("ShowPartyNumber",		1)
	DefaultVar("EnergyTicker",		1)
	DefaultVar("FullScreenStatus",		0)		-- 1.8.4

	-- Player Pet
	DefaultVar("ShowPlayerPetPortrait",	1)
	DefaultVar("ShowPlayerPetPortrait3D",	1)		-- 1.8.3
	DefaultVar("PetHappiness",		1)
	DefaultVar("PetHappinessSad",		1)		-- Only show happiness when not happy
	DefaultVar("PetFlashWhenSad",		1)
	DefaultVar("ShowPetLevel",		1)
	DefaultVar("Scale_PetFrame",		0.8)
	DefaultVar("ShowPetXP",			1)
	DefaultVar("ShowPlayerPetName",		1)
	DefaultVar("PlayerPetBuffSize",		20)
	DefaultVar("ShowPlayerPetValues",	1)

	-- Target
	DefaultVar("ShowTargetPortrait",	1)
	DefaultVar("ShowTargetPortrait3D",	1)		-- 1.8.3
	DefaultVar("ShowTargetClassIcon",	1)
	DefaultVar("ShowTargetMobType",		1)
	DefaultVar("ShowTargetLevel",		1)
	DefaultVar("ShowTargetElite",		1)
	DefaultVar("ShowTargetMana",		1)
	DefaultVar("ShowTargetPercent",		1)
	DefaultVar("ShowTargetValues",		1)
	DefaultVar("UseCPMeter",		1)
	DefaultVar("BlizzardCPMeter",		0)
	DefaultVar("BlizzardCPPosition",	"top")
	DefaultVar("ShowTargetPVPRank",		1)
	DefaultVar("ShowTargetPVP",		1)		-- 1.8.3
	DefaultVar("Show30YardSymbol",		1)
	DefaultVar("Scale_TargetFrame",		0.8)
	DefaultVar("AlternateRaidIcon",		1)
	DefaultVar("TargetBuffSize",		22)
	DefaultVar("TargetBuffRows",		3)
	DefaultVar("TargetBuffsAbove",		0)
	DefaultVar("TargetReactionHighlight",	0)		-- 1.8.6

	-- Target's Target
	DefaultVar("ShowTargetTarget",		1)
	DefaultVar("TargetTargetHistory",	0)
	DefaultVar("ShowTargetTargetTarget",	1)
	DefaultVar("TargetTargetBuffs",		1)
	DefaultVar("TargetCastableBuffs",	0)
	DefaultVar("TargetCurableDebuffs",	0)
	DefaultVar("TargetTargetTargetBuffs",	1)
	DefaultVar("Scale_TargetTargetFrame",	0.8)
	DefaultVar("ShowTargetTargetPercent",	1)
	DefaultVar("ShowTargetTargetValues",	1)
	DefaultVar("ShowTargetTargetLevel",	1)
	DefaultVar("ShowTargetTargetMana",	1)
	DefaultVar("TargetTargetBuffsAbove",	0)

	-- Cast Party
	DefaultVar("CastParty",			1)
	DefaultVar("CastPartyRaidOnly",		0)		-- Cast Party works on raid frame only?

	-- Party
	DefaultVar("ShowPartyPortrait",		1)
	DefaultVar("ShowPartyPortrait3D",	1)		-- 1.8.3
	DefaultVar("ShowPartyTarget",		1)
	DefaultVar("ShowPartyLevel",		1)
	DefaultVar("ShowPartyNames",		1)
	DefaultVar("ShowPartyValues",		1)
	DefaultVar("ShowPartyPercent",		1)
	DefaultVar("ShowPartyClassIcon",	1)
	DefaultVar("ShowPartyPVP",		1)		-- 1.8.3
	DefaultVar("ShowPartyRaid",		1)
	DefaultVar("PartyBuffs",		1)
	DefaultVar("PartyDebuffs",		1)
	DefaultVar("PartyCastableBuffs",	0)
	DefaultVar("PartyCurableDebuffs",	0)
	DefaultVar("Scale_PartyFrame",		0.8)
	DefaultVar("PartyDebuffsBelow",		0)
	DefaultVar("ShowPartyPets",		1)
	DefaultVar("Scale_PartyPets",		XPerlConfig.Scale_PartyFrame)
	DefaultVar("ShowPartyPetName",		1)
	DefaultVar("ShowPartyPetBuffs",		1)		-- 1.8.3
	DefaultVar("ShowParty30YardSymbol",	1)
	DefaultVar("PartyBuffSize",		20)

	-- Raid
	DefaultVar("SortRaidByClass",		0)
	DefaultVar("ShowRaid",			1)
	DefaultVar("ShowGroup1",		1)
	DefaultVar("ShowGroup2",		1)
	DefaultVar("ShowGroup3",		1)
	DefaultVar("ShowGroup4",		1)
	DefaultVar("ShowGroup5",		1)
	DefaultVar("ShowGroup6",		1)
	DefaultVar("ShowGroup7",		1)
	DefaultVar("ShowGroup8",		1)
	DefaultVar("ShowGroup9",		0)
	DefaultVar("ShowGroup1",		1)
	DefaultVar("ShowRaidTitles",		1)
	DefaultVar("ShowRaidPercents",		1)
	DefaultVar("Scale_Raid",		0.8)
	DefaultVar("RaidVerticalSpacing",	42)
	DefaultVar("RaidPositions",		{})
	DefaultVar("RaidBuffs",			1)
	DefaultVar("RaidDebuffs",		0)
	DefaultVar("BuffsCastableCurable",	0)
	DefaultVar("RaidBuffsRight",		1)
	DefaultVar("RaidBuffsInside",		1)
	DefaultVar("RaidMotion",		1)
	DefaultVar("RaidMana",			1)		-- 1.8.3
	DefaultVar("RaidUpward",		0)		-- 1.8.3
end

-- XPerl_ResetDefaults
function XPerl_ResetDefaults()

	local rp = XPerlConfig.RaidPositions

	XPerlConfig = {}
	XPerl_Defaults()

	if (XPerlConfigSavePerCharacter) then
		XPerlConfig_Global[GetRealmName()][UnitName("player")] = XPerlConfig
	end

	XPerlConfig.RaidPositions = rp

	XPerl_OptionActions()

	if (XPerl_Options and XPerl_Options:IsShown()) then
		XPerl_Options:Hide()
		XPerl_Options:Show()
	end
end

-- XPerl_Globals_OnEvent
function XPerl_Globals_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		-- Between sessions variable saving.
		this:UnregisterEvent(event)

		if (XPerlConfigSavePerCharacter) then
			local realm = GetRealmName()
			local name = UnitName("player")

			if (not XPerlConfig_Global) then
				XPerlConfig_Global = {}
			end

			if (not XPerlConfig_Global[realm]) then
				XPerlConfig_Global[realm] = {}
			end

			if (not XPerlConfig_Global[realm][name]) then
				XPerlConfig_Global[realm][name] = {}

				if (XPerlConfig and XPerlConfig.BarTextures) then
					XPerlConfig_Global[realm][name] = XPerlConfig
				end
			else
				XPerlConfig = XPerlConfig_Global[realm][name]
			end

			if (not XPerlConfig) then
				XPerlConfig = XPerlConfig_Global[realm][name]
			end
		else
			if (not XPerlConfig) then
				XPerlConfig = {}
			end
		end

		-- Tell DHUD to hide Blizzard default Player and Target frames
		if (DHUD_Config) then
			local bChanged = false
			if (XPerl_Player) then
				DHUD_Config["bplayer"] = 0
				bChanged = true
			end
			if (XPerl_Target) then
				DHUD_Config["btarget"] = 0
				bChanged = true
			end

			--if (DHUD_Config["bplayer"] == 1 or DHUD_Config["btarget"] == 1) then
			--	XPerl_BlizzFramesDisable()
			--end
		end

		XPerl_BlizzFramesDisable()

		-- Variable checking only occurs for new install and version number change
		if ((not XPerlConfig.ConfigVersion) or (XPerlConfig.ConfigVersion ~= XPerl_VersionNumber)) then
			XPerlConfig.ConfigVersion = XPerl_VersionNumber;	-- Set ConfigVersion to current

			XPerl_Defaults()
		end

		XPerl_Init()

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (Perl_Globals_OnEvent or Perl_InitFadeFrame) then
			DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000".."ERROR! X-Perl not installed correctly!")
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00".."ERROR!   Previous version of X-Perl must be removed entirely. Please delete all Perl* folders in AddOns")
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00".."ERROR!   X-Perl folders, frames and globals were renamed for version 1.8.6 due to numerous conflicts with other versions of Perl and addons expecting Nymbia's Perl, so X-Perl now resides in newly named folders")
		end
	end
end

-- XPerl_InitFadeFrame
function XPerl_InitFadeFrame(argFrame)
	argFrame.Fading = 0
	argFrame.FadeTime = 0
	argFrame.IsShowing = function () return (argFrame:IsVisible() and argFrame.Fading == 0); end
end

-- XPerl_CancelFade
function XPerl_CancelFade(argFrame)
	if (argFrame.Fading == 1) then
		argFrame.Fading = 0
		argFrame:SetAlpha(XPerlConfig.Transparency)
	end
end

-- XPerl_StartFade(argFrame)
function XPerl_StartFade(argFrame)
	argFrame:StopMovingOrSizing()

	if (XPerlConfig.PerlFadeFrames == 1) then
		if (argFrame:IsVisible() and argFrame.Fading == 0) then
			argFrame.Fading = 1
			argFrame.FadeTime = 0
		end
	else
		argFrame:Hide()
	end
end

-- XPerl_ProcessFade(argFrame)
function XPerl_ProcessFade(argFrame)
	if (argFrame.Fading == 1) then
		argFrame.FadeTime = argFrame.FadeTime + arg1

		if (argFrame.FadeTime >= 1) then
			argFrame:StopMovingOrSizing()
			argFrame:Hide()
			XPerl_CancelFade(argFrame)
		else
			local newAlpha = XPerlConfig.Transparency * (1 - argFrame.FadeTime)
			argFrame:SetAlpha(newAlpha)
		end
	end
end

-- XPerl_Update_RaidIcon
function XPerl_Update_RaidIcon(unit, frame)
	local index = GetRaidTargetIndex(unit)
	if ( index ) then
		SetRaidTargetIconTexture(frame, index)
		frame:Show()
	else
		frame:Hide()
	end
end

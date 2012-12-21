HonorFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0", "AceHook-2.0")

HonorFu.version = "2.0." .. string.sub("$Revision: 8990 $", 12, -3)
HonorFu.date = string.sub("$Date: 2006-08-24 19:18:28 -1000 (Thu, 24 Aug 2006) $", 8, 17)
HonorFu.hasIcon = true

HonorFu:RegisterDB("HonorFu2DB")

HonorFu:RegisterDefaults('profile', {
	autoRelease = true,
	showBGMap = true,
	showHonor = true,
	showBGScore = true,
	showCooldown = false,
	showKillsDeaths = false,
	printReputationGain = true,
	printHonorGain = true,
	showEnemyTooltipLine = true,
})

local Glory = AceLibrary("Glory-2.0")
local Tablet = AceLibrary("Tablet-2.0")
local babbleClass = AceLibrary("Babble-Class-2.0")
local Z = AceLibrary("Babble-Zone-2.0")
local Crayon = AceLibrary("Crayon-2.0")
local Abacus = AceLibrary("Abacus-2.0")
local L = AceLibrary("AceLocale-2.0"):new("FuBar_HonorFu")

local _G = getfenv(0)

function HonorFu:IsShowingHonor()
	return self.db.profile.showHonor
end

function HonorFu:ToggleShowingHonor()
	self.db.profile.showHonor = not self.db.profile.showHonor
	self:UpdateText()
end

function HonorFu:IsShowingBGScore()
	return self.db.profile.showBGScore
end

function HonorFu:ToggleShowingBGScore()
	self.db.profile.showBGScore = not self.db.profile.showBGScore
	self:UpdateText()
end

function HonorFu:IsShowingCooldown()
	return self.db.profile.showCooldown
end

function HonorFu:ToggleShowingCooldown()
	self.db.profile.showCooldown = not self.db.profile.showCooldown
	self:UpdateText()
end

function HonorFu:IsShowingKillsDeaths()
	return self.db.profile.showKillsDeaths
end

function HonorFu:ToggleShowingKillsDeaths()
	self.db.profile.showKillsDeaths = not self.db.profile.showKillsDeaths
	self:UpdateText()
end

function HonorFu:IsShowingEnemyTooltipLine()
	return self.db.profile.showEnemyTooltipLine
end

function HonorFu:ToggleShowingEnemyTooltipLine()
	self.db.profile.showEnemyTooltipLine = not self.db.profile.showEnemyTooltipLine
end

function HonorFu:IsPrintingReputationGains()
	return self.db.profile.printReputationGain
end

function HonorFu:TogglePrintingReputationGains()
	self.db.profile.printReputationGain = not self.db.profile.printReputationGain
end

function HonorFu:IsPrintingHonorGains()
	return self.db.profile.printHonorGain
end

function HonorFu:TogglePrintingHonorGains()
	self.db.profile.printHonorGain = not self.db.profile.printHonorGain
end

function HonorFu:IsAutoReleasing()
	return self.db.profile.autoRelease
end

function HonorFu:ToggleAutoReleasing()
	self.db.profile.autoRelease = not self.db.profile.autoRelease
end

function HonorFu:IsShowingBGMap()
	return self.db.profile.showBGMap
end

function HonorFu:ToggleShowingBGMap()
	self.db.profile.showBGMap = not self.db.profile.showBGMap
	if self.db.profile.showBGMap and Glory:IsInBattlegrounds() and BattlefieldMinimap then
		BattlefieldMinimap:Show()
	end
end

function HonorFu:OnInitialize()
--	self:HookIntoPlugin(ExperienceFu, "SWITCHTEXT_TITLE")
end

function HonorFu:OnEnable()
	self:RegisterEvent("Glory_UpdatePermanentPvP", "Update")
	self:RegisterEvent("Glory_UpdatePvPCooldown", "Update")
	self:RegisterEvent("Glory_Death", "Update")
	-- Auto-release
	self:RegisterEvent("PLAYER_DEAD")
	-- Show tooltip info
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	-- Open minimap
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	-- Reputation change
	self:RegisterEvent("Glory_FactionGain")
	self:RegisterEvent("Glory_BGWin", "Update")
	self:RegisterEvent("Glory_BGLoss", "Update")
	self:RegisterEvent("Glory_GainHK")
	self:RegisterEvent("Glory_GainBonusHonor")
	self:RegisterEvent("Glory_GainBonusHonor")
	self:RegisterEvent("Glory_HostileFlagCarrierUpdate", "UpdateTooltip")
	self:RegisterEvent("Glory_NewDay", "Update")
	self:RegisterEvent("Glory_UpdatePvPCooldown")
	
	self:Hook("WorldStateScoreFrame_Update")
	self:Hook("WorldStateScoreFrame_Resize")
	if SCT and SCT.BlizzardCombatTextEvent then
		self:Hook(SCT, "BlizzardCombatTextEvent")
	end
	
	if Glory:GetPvPCooldown() > 0 then
		self:ScheduleRepeatingEvent(self.name .. "PvP", self.UpdateDisplay, 1, self)
	end
	
	self:PLAYER_ENTERING_WORLD()
end

local options = {
	type = 'group',
	args = {
		tarFlag = {
			type = 'execute',
			name = L"Target hostile flagholder",
			desc = L"Target the current opposing flagholder. (also /tflag or /tarflag)",
			func = 'TargetHostileFlagCarrier',
			handler = Glory,
		},
		honor = {
			type = 'toggle',
			name = L"Show honor",
			desc = L"Show honor",
			get = "IsShowingHonor",
			set = "ToggleShowingHonor",
		},
		bgScore = {
			type = 'toggle',
			name = L"Show battlegrounds score",
			desc = L"Show battlegrounds score",
			get = "IsShowingBGScore",
			set = "ToggleShowingBGScore",
		},
		kills = {
			type = 'toggle',
			name = L"Show kills and deaths",
			desc = L"Show kills and deaths",
			get = "IsShowingKillsDeaths",
			set = "ToggleShowingKillsDeaths",
		},
		cooldown = {
			type = 'toggle',
			name = L"Show PvP cooldown",
			desc = L"Show PvP cooldown",
			get = "IsShowingCooldown",
			set = "ToggleShowingCooldown",
		},
		autoRelease = {
			type = 'toggle',
			name = L"Auto-release when dead",
			desc = L"Toggle whether to automatically release when dead in battlegrounds",
			get = "IsAutoReleasing",
			set = "ToggleAutoReleasing",
		},
		bgMap = {
			type = 'toggle',
			name = L"Auto-open minimap for battlegrounds",
			desc = L"Toggle whether to automatically open the battlegrounds minimap",
			get = "IsShowingBGMap",
			set = "ToggleShowingBGMap",
		},
		printRep = {
			type = 'toggle',
			name = L"Print out PvP reputation gains",
			desc = L"Print out PvP reputation gains",
			get = "IsPrintingReputationGains",
			set = "TogglePrintingReputationGains",
		},
		printHonor = {
			type = 'toggle',
			name = L"Print out honor gains",
			desc = L"Print out honor gains",
			get = "IsPrintingHonorGains",
			set = "TogglePrintingHonorGains",
		},
		tooltip = {
			type = 'toggle',
			name = L"Add info to enemy tooltip",
			desc = L"Add info to enemy tooltip",
			get = "IsShowingEnemyTooltipLine",
			set = "ToggleShowingEnemyTooltipLine",
		},
		resetBG = {
			type = 'execute',
			name = L"Reset battlegrounds scores",
			desc = L"Reset the battlegrounds scores to 0-0",
			func = "ResetBGScores",
			handler = Glory,
		}
	}
}
HonorFu.OnMenuRequest = options
HonorFu:RegisterChatCommand({ "/honorfu", "/honfu" }, options)

function HonorFu:Glory_FactionGain(faction, amount)
	if self:IsPrintingReputationGains() then
		self:Print(L"Gained %d reputation with %s", amount, faction)
	end
end

function HonorFu:BlizzardCombatTextEvent(SCT, a1,a2,a3,a4,a5,a6,a7,a8,a9)
	if arg1 ~= "HONOR_GAINED" then
		return self.hooks[SCT].BlizzardCombatTextEvent.orig(SCT, a1,a2,a3,a4,a5,a6,a7,a8,a9)
	end
end

function HonorFu:Glory_GainHK(rank, name, honor, kills)
	if self:IsPrintingHonorGains() then
		self:Print(L"Kill: %s %s. %d honor gained. Killed %d times today", rank, name, honor, kills)
	end
	if SCT and SCT.Display_Event and honor > 0 then
		SCT:Display_Event("SHOWHONOR", string.format("+%d %s", honor, HONOR))
	end
	self:Update()
end

function HonorFu:Glory_GainBonusHonor(bonus)
	if self:IsPrintingHonorGains() then
		self:Print(L"Gained %d bonus honor", bonus)
	end
	if SCT and SCT.Display_Event then
		SCT:Display_Event("SHOWHONOR", string.format("+%d %s",bonus, HONOR))
	end
	self:Update()
end

function HonorFu:PLAYER_DEAD()
	if Glory:IsInBattlegrounds() and not HasSoulstone() and self:IsAutoReleasing() then
		RepopMe()
	end
end

function HonorFu:WorldStateScoreFrame_Resize()
	self.hooks.WorldStateScoreFrame_Resize.orig()
	
	if self.scoreColumn ~= nil then
		local numColumns = GetNumBattlefieldStats() + 1
		if WorldStateScoreScrollFrame:IsVisible() then
			width = WORLDSTATESCOREFRAME_BASE_WIDTH + 37 + numColumns * WORLDSTATESCOREFRAME_COLUMN_SPACING
		else
			width = WORLDSTATESCOREFRAME_BASE_WIDTH + numColumns * WORLDSTATESCOREFRAME_COLUMN_SPACING
		end
		WorldStateScoreFrame:SetWidth(width)
		WorldStateScoreFrameTopBackground:SetWidth(WorldStateScoreFrame:GetWidth() - 129)
		WorldStateScoreFrameTopBackground:SetTexCoord(0, WorldStateScoreFrameTopBackground:GetWidth()/256, 0, 1.0)
		WorldStateScoreFrame.scrollBarButtonWidth = WorldStateScoreFrame:GetWidth() - 175
		WorldStateScoreFrame.buttonWidth = WorldStateScoreFrame:GetWidth() - 137
		WorldStateScoreScrollFrame:SetWidth(WorldStateScoreFrame.scrollBarButtonWidth)
	end
end

function HonorFu:WorldStateScoreFrame_Update()
	self.hooks.WorldStateScoreFrame_Update.orig()

	local i = GetNumBattlefieldStats() + 1
	if i <= MAX_NUM_STAT_COLUMNS then
		self.scoreColumn = i
		local columnButton = _G["WorldStateScoreColumn"..i]
		local columnButtonText = _G["WorldStateScoreColumn"..i.."Text"]
		columnButtonText:SetText(L"Killed Today")
		columnButton.icon = ""
		columnButton.tooltip = L"Number of kills today.\nIf more than 10 kills, then no more honor from this player."
		
		local columnTextButton = _G["WorldStateScoreButton1Column"..i.."Text"]
		columnTextButton:SetPoint("CENTER", "WorldStateScoreColumn"..i, "CENTER", -1, -33)
		
		WorldStateScoreFrameHonorGained:ClearAllPoints()
		WorldStateScoreFrameHonorGained:SetPoint("CENTER", "WorldStateScoreColumn"..i, "CENTER", 88, 0)
		
		_G["WorldStateScoreColumn"..i]:Show()
	else
		self.scoreColumn = nil
	end
	
	local numScores = GetNumBattlefieldScores()
	
	for i = 1, MAX_WORLDSTATE_SCORE_BUTTONS do
		local index = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame) + i
		if index > numScores then
			break
		end
		local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class = GetBattlefieldScore(index)
		local button = _G["WorldStateScoreButton" .. i .. "NameButtonName"]
		_G["WorldStateScoreButton" .. i .. "NameButtonName"]:SetTextColor(babbleClass:GetColor(class))
		if self.scoreColumn ~= nil then
			local col = _G["WorldStateScoreButton" .. i .. "Column" .. self.scoreColumn .. "Text"]
			if UnitFactionGroup("player") == "Alliance" then
				if faction == 0 then
					col:SetText(Glory:GetTodayHKs(name))
					col:Show()
				else
					col:SetText("")
					col:Hide()
				end
			else
				if faction == 1 then
					col:SetText(Glory:GetTodayHKs(name))
					col:Show()
				else
					col:SetText("")
					col:Hide()
				end
			end
		end
	end
	
end

function HonorFu:UPDATE_MOUSEOVER_UNIT()
	if self:IsShowingEnemyTooltipLine() and UnitExists("mouseover") and UnitFactionGroup("mouseover") ~= UnitFactionGroup("player") and GetDifficultyColor(UnitLevel("mouseover")) ~= QuestDifficultyColor["trivial"] and UnitIsPlayer("mouseover") then
		local hks = Glory:GetTodayHKs(UnitName("mouseover"))
		if GameTooltip:IsVisible() and GameTooltipTextLeft1:GetText() ~= nil then
			GameTooltip:AddLine(string.format(L"%d Kills - |cff%s%.0f%% %s|r", hks, Crayon:GetThresholdHexColor((10 - hks) / 10), math.max((10 - hks) * 10, 0), HONOR_CONTRIBUTION_POINTS))
			GameTooltip:Show()
		end
	end
end


function HonorFu:PLAYER_ENTERING_WORLD()
	if Glory:IsInBattlegrounds() and self:IsShowingBGMap() then
		BattlefieldMinimap_LoadUI()
		if BattlefieldMinimap and not BattlefieldMinimap:IsVisible() then
			BattlefieldMinimap:Show()
		end
	end
end

function HonorFu:OnClick()
	Glory:TargetHostileFlagCarrier()
end

local tmp = {}
function HonorFu:OnTextUpdate()
	local _, rankNumber = GetPVPRankInfo(UnitPVPRank("player"))
	if rankNumber > 0 then
		self:SetIcon(string.format("%s%02d", "Interface\\PvPRankBadges\\PvPRank", rankNumber))
	else
		self:SetIcon(string.format("%s%s", "Interface\\PvPRankBadges\\PvPRank", UnitFactionGroup("player")))
	end
	if self:IsShowingHonor() then
		table.insert(tmp, "|cffffffff" .. Glory:GetTodayHonor() .. "|r " .. HONOR_CONTRIBUTION_POINTS)
	end
	if self:IsShowingBGScore() then
		if table.getn(tmp) > 0 then
			table.insert(tmp, "||")
		end
		local wins = Glory:GetBattlegroundsWins()
		local losses = Glory:GetBattlegroundsLosses()
		local percent = 0.5
		if wins + losses ~= 0 then
			local percent = wins / (wins + losses)
			table.insert(tmp, string.format("|cff%s%d-%d (%.0f%%)|r", Crayon:GetThresholdHexColor(percent), wins, losses, percent * 100))
		else
			table.insert(tmp, "|cffffffff0-0|r")
		end
	end
	if self:IsShowingKillsDeaths() then
		if table.getn(tmp) > 0 then
			table.insert(tmp, "||")
		end
		local kills = Glory:GetTodayHKs()
		local deaths = Glory:GetTodayDeaths()
		if kills + deaths ~= 0 then
			local percent = kills / (kills + deaths)
			table.insert(tmp, string.format("|cff%s%d-%d (%.0f%%)|r", Crayon:GetThresholdHexColor(percent), kills, deaths, percent * 100))
		else
			table.insert(tmp, "|cffffffff0-0|r")
		end
	end
	if self:IsShowingCooldown() then
		if table.getn(tmp) > 0 then
			table.insert(tmp, "||")
		end
		if Glory:IsInBattlegrounds() or Glory:IsPermanentPvP() then
			table.insert(tmp, Crayon:Red(L"On"))
		else
			local cooldown = Glory:GetPvPCooldown()
			if cooldown > 0 then
				table.insert(tmp, Crayon:Yellow(Abacus:FormatDurationFull(cooldown)))
			else
				table.insert(tmp, Crayon:Green(L"Off"))
			end
		end
	end
	self:SetText(table.concat(tmp, " "))
	for k,v in pairs(tmp) do
		tmp[k] = nil
	end
	table.setn(tmp, 0)
end

function HonorFu:OnTooltipUpdate()
	local cat = Tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	local kills = Glory:GetTodayHKs()
	local deaths = Glory:GetTodayDeaths()
	if kills + deaths ~= 0 then
		local percent = kills / (kills + deaths)
		local r, g, b = Crayon:GetThresholdColor(percent)
		cat:AddLine(
			'text', L"Kills-Deaths:",
			'text2', string.format("%d-%d (%.0f%%)", kills, deaths, percent * 100),
			'text2R', r,
			'text2G', g,
			'text2B', b
		)
	else
		cat:AddLine(
			'text', L"Kills-Deaths:",
			'text2', "0-0"
		)
	end
	
	cat:AddLine(
		'text', L"Today's HK honor:",
		'text2', Glory:GetTodayHKHonor()
	)
	
	cat:AddLine(
		'text', L"Today's bonus honor:",
		'text2', Glory:GetTodayBonusHonor()
	)
	
	cat:AddLine(
		'text', L"Today's total honor:",
		'text2', Glory:GetTodayHonor()
	)
	
	local text
	if Glory:IsInBattlegrounds() then
		text = BATTLEFIELDS
	elseif Glory:IsPermanentPvP() then
		text = L"Flagged"
	else
		local t = Glory:GetPvPCooldown()
		if t > 0 then
			text = Abacus:FormatDurationFull(t)
		else
			text = NONE
		end
	end
	cat:AddLine(
		'text', L"PvP Cooldown:",
		'text2', text
	)
	
	cat = Tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("player"))
	rankName = rankName or NONE
	cat:AddLine(
		'text', RANK .. ":",
		'text2', string.format("%s (%d)", rankName, rankNumber)
	)
	
	cat:AddLine(
		'text', L"Progress:",
		'text2', string.format("%.0f%%", GetPVPRankProgress() * 100)
	)
	
	local _,_,yesterdayHonor = GetPVPYesterdayStats()
	cat:AddLine(
		'text', L"Yesterday's honor:",
		'text2', yesterdayHonor
	)
	
	local _, weekHonor = GetPVPThisWeekStats()
	cat:AddLine(
		'text', L"This week's honor:",
		'text2', weekHonor
	)
	
	local _,_,lastWeekHonor,_ = GetPVPLastWeekStats()
	cat:AddLine(
		'text', L"Last week's honor:",
		'text2', lastWeekHonor
	)
	
	if UnitLevel("player") >= 10 then
		cat:AddLine(
			'text', L"Rating limit:",
			'text2', Glory:GetRatingLimit()
		)
		
		cat:AddLine(
			'text', L"Rank limit:",
			'text2', string.format("%s (%d)", Glory:GetRankLimitInfo())
		)
	end
	
	cat = Tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	local wins = Glory:GetBattlegroundsWins()
	local losses = Glory:GetBattlegroundsLosses()
	if wins + losses == 0 then
		cat:AddLine(
			'text', L"Battlegrounds score:",
			'text2', "0-0"
		)
	else
		local percent = wins / (wins + losses)
		local r, g, b = Crayon:GetThresholdColor(percent)
		cat:AddLine(
			'text', L"Battlegrounds score:",
			'text2', string.format("%d-%d (%.0f%%)", wins, losses, percent * 100),
			'text2R', r,
			'text2G', g,
			'text2B', b
		)
	end
	
	if UnitLevel("player") >= 10 then
		wins = Glory:GetWarsongGulchWins()
		losses = Glory:GetWarsongGulchLosses()
		if wins + losses == 0 then
			cat:AddLine(
				'text', string.format(L"%s score", Z"Warsong Gulch") .. ":",
				'text2', "0-0"
			)
		else
			local percent = wins / (wins + losses)
			local r, g, b = Crayon:GetThresholdColor(percent)
			cat:AddLine(
				'text', string.format(L"%s score", Z"Warsong Gulch") .. ":",
				'text2', string.format("%d-%d (%.0f%%)", wins, losses, percent * 100),
				'text2R', r,
				'text2G', g,
				'text2B', b
			)
		end
	end
	
	if UnitLevel("player") >= 20 then
		wins = Glory:GetArathiBasinWins()
		losses = Glory:GetArathiBasinLosses()
		if wins + losses == 0 then
			cat:AddLine(
				'text', string.format(L"%s score", Z"Arathi Basin") .. ":",
				'text2', "0-0"
			)
		else
			local percent = wins / (wins + losses)
			local r, g, b = Crayon:GetThresholdColor(percent)
			cat:AddLine(
				'text', string.format(L"%s score", Z"Arathi Basin") .. ":",
				'text2', string.format("%d-%d (%.0f%%)", wins, losses, percent * 100),
				'text2R', r,
				'text2G', g,
				'text2B', b
			)
		end
	end
	
	if UnitLevel("player") >= 51 then
		wins = Glory:GetAlteracValleyWins()
		losses = Glory:GetAlteracValleyLosses()
		if wins + losses == 0 then
			cat:AddLine(
				'text', string.format(L"%s score", Z"Alterac Valley") .. ":",
				'text2', "0-0"
			)
		else
			local percent = wins / (wins + losses)
			local r, g, b = Crayon:GetThresholdColor(percent)
			cat:AddLine(
				'text', string.format(L"%s score", Z"Alterac Valley") .. ":",
				'text2', string.format("%d-%d (%.0f%%)", wins, losses, percent * 100),
				'text2R', r,
				'text2G', g,
				'text2B', b
			)
		end
	end
	
	local sMonth, sDay, eMonth, eDay, current = Glory:GetCurrentOrNextWarsongWeekend()
	local text
	if sMonth ~= eMonth then
		text = string.format("%s %d - %s %d", sMonth, sDay, eMonth, eDay)
	else
		text = string.format("%s %d - %d", sMonth, sDay, eDay)
	end
	cat:AddLine(
		'text', string.format(L"%s weekend", Z"Warsong Gulch"),
		'text2', text,
		'text2R', current and 0 or 1,
		'text2G', 1,
		'text2B', current and 0 or 1
	)
	
	local sMonth, sDay, eMonth, eDay, current = Glory:GetCurrentOrNextArathiWeekend()
	local text
	if sMonth ~= eMonth then
		text = string.format("%s %d - %s %d", sMonth, sDay, eMonth, eDay)
	else
		text = string.format("%s %d - %d", sMonth, sDay, eDay)
	end
	cat:AddLine(
		'text', string.format(L"%s weekend", Z"Arathi Basin"),
		'text2', text,
		'text2R', current and 0 or 1,
		'text2G', 1,
		'text2B', current and 0 or 1
	)
	
	local sMonth, sDay, eMonth, eDay, current = Glory:GetCurrentOrNextAlteracWeekend()
	local text
	if sMonth ~= eMonth then
		text = string.format("%s %d - %s %d", sMonth, sDay, eMonth, eDay)
	else
		text = string.format("%s %d - %d", sMonth, sDay, eDay)
	end
	cat:AddLine(
		'text', string.format(L"%s weekend", Z"Alterac Valley"),
		'text2', text,
		'text2R', current and 0 or 1,
		'text2G', 1,
		'text2B', current and 0 or 1
	)
	
	if Glory:IsInWarsongGulch() then
		Tablet:SetHint(string.format(L"Click to target flag carrier (%s)", Glory:GetHostileFlagCarrier() or NONE))
	end
end

function HonorFu:Glory_UpdatePvPCooldown(cooldown)
	if cooldown > 0 then
		self:ScheduleRepeatingEvent(self.name .. "PvP", self.UpdateDisplay, 1, self)
--		if self.hookedPlugin ~= nil and not self:IsCurrentPluginHookSwitch() then
--			self:SwitchPluginHook()
--		end
	else
		self:CancelScheduledEvent(self.name .. "PvP")
--		if self.hookedPlugin ~= nil and self:IsCurrentPluginHookSwitch() then
--			self:SwitchPluginHook()
--		end
	end
end

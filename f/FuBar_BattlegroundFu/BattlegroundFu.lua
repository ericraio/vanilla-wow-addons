local abacus = AbacusLib:GetInstance('1.0')
local babbleZone = BabbleLib:GetInstance('Zone 1.1')
local compost = CompostLib:GetInstance('compost-1')
local crayon = CrayonLib:GetInstance('1.0')
local dewdrop = DewdropLib:GetInstance('1.0')
local glory = GloryLib:GetInstance('1.0')
local metro = Metrognome:GetInstance('1')
local tablet = TabletLib:GetInstance('1.0')

local bfNum, bfAlpha

BattlegroundFu = FuBarPlugin:GetInstance("1.2"):new({
	name                =   BattlegroundFuLocals.NAME,
	description         =   BattlegroundFuLocals.DESCRIPTION,
	version             =   "1.1.5",
	releaseDate         =   "05-27-2006",
	aceCompatible       =   103,
	author              =   "Mynithrosil of Feathermoon",
	email               =   "hyperactiveChipmunk@gmail.com",
	website             =   "http://hyperactiveChipmunk.wowinterface.com",
	category            =   "others",
	db                  =   AceDatabase:new("BattlegroundFuDB"),
	defaults            =   {
		hideMinimapButton               =   false,
		invertQueueProgress             =   false,
		clickShowsScoreboard            =   false,
		showTeamSizes                   =   true,
		showTeamScores                  =   true,
		showNumBases                    =   true,
		showResourceTTV                 =   true,
		showBattlefieldObjectiveStatus   =   true,
		showUncontestedObjectives       =   true,
		showCTFFlagCarriers             =   true,
		showBattlefieldPlayerStatistics  =   true,
		showBattlefieldQueues            =   true,
		hideQueueText                   =   {},
	},
	cmd                 =   AceChatCmd:new(BattlegroundFuLocals.COMMANDS, BattlegroundFuLocals.CMD_OPTIONS),
	hasIcon             =   true,
	clickableTooltip    =   true,
	loc                 =   BattlegroundFuLocals,
	updateTime          =   1,
	FACTION_ICON_PATH   =   "Interface\\GroupFrame\\UI-Group-PVP-",
})
--User Options Methods=========================================================
function BattlegroundFu:IsHidingMinimapButton()
	return self.data.hideMinimapButton
end

function BattlegroundFu:ToggleHidingMinimapButton(loud)
	self.data.hideMinimapButton = not self.data.hideMinimapButton
	if loud then
		self.cmd:status(self.loc.ARGUMENT_HIDEMINIMAPBUTTON, self.data.hideMinimapButton and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	if self.data.hideMinimapButton then
		MiniMapBattlefieldFrame:Hide()
	else
		MiniMapBattlefieldFrame:Show()
	end
	return self.data.hideMinimapButton
end

function BattlegroundFu:IsInvertQueueProgress()
	return self.data.invertQueueProgress
end

function BattlegroundFu:ToggleInvertQueueProgress(loud)
	self.data.invertQueueProgress = not self.data.invertQueueProgress
	if loud then
		self.cmd:status(self.loc.ARGUMENT_INVERTQUEUEPROGRESS, self.data.invertQueueProgress and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateDisplay()
	return self.data.invertQueueProgress
end

function BattlegroundFu:IsClickShowsScoreboard()
	return self.data.clickShowsScoreboard
end

function BattlegroundFu:ToggleClickShowsScoreboard(loud)
	self.data.clickShowsScoreboard = not self.data.clickShowsScoreboard
	if loud then
		self.cmd:status(self.loc.ARGUMENT_CLICKSHOWSSCOREBOARD, self.data.clickShowsScoreboard and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateDisplay()
end

function BattlegroundFu:IsShowingTeamSizes()
	return self.data.showTeamSizes
end

function BattlegroundFu:ToggleShowingTeamSizes(loud)
	self.data.showTeamSizes = not self.data.showTeamSizes
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWTEAMSIZES, self.data.showTeamSizes and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showTeamSizes
end

function BattlegroundFu:IsShowingTeamScores()
	return self.data.showTeamScores
end

function BattlegroundFu:ToggleShowingTeamScores(loud)
	self.data.showTeamScores = not self.data.showTeamScores
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWTEAMSCORES, self.data.showTeamScores and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showTeamScores
end

function BattlegroundFu:IsShowingNumBases()
	return self.data.showNumBases
end

function BattlegroundFu:ToggleShowingNumBases(loud)
	self.data.showNumBases = not self.data.showNumBases
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWNUMBASES, self.data.showNumBases and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showNumBases
end

function BattlegroundFu:IsShowingResourceTTV()
	return self.data.showResourceTTV
end

function BattlegroundFu:ToggleShowingResourceTTV(loud)
	self.data.showResourceTTV = not self.data.showResourceTTV
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWRESOURCETTV, self.data.showResourceTTV and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showResourceTTV
end

function BattlegroundFu:IsShowingBattlefieldPlayerStatistics()
	return self.data.showBattlefieldPlayerStatistics
end

function BattlegroundFu:ToggleShowingBattlefieldPlayerStatistics(loud)
	self.data.showBattlefieldPlayerStatistics = not self.data.showBattlefieldPlayerStatistics
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWBATTLEFIELDSTATS, self.data.showBattlefieldPlayerStatistics and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showBattlefieldPlayerStatistics
end

function BattlegroundFu:IsShowingBattlefieldObjectiveStatus()
	return self.data.showBattlefieldObjectiveStatus
end

function BattlegroundFu:ToggleShowingBattlefieldObjectiveStatus(loud)
	self.data.showBattlefieldObjectiveStatus = not self.data.showBattlefieldObjectiveStatus
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWOBJECTIVESTATUS, self.data.showBattlefieldObjectiveStatus and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showBattlefieldObjectiveStatus
end

function BattlegroundFu:IsShowingUncontestedObjectives()
	return self.data.showUncontestedObjectives
end

function BattlegroundFu:ToggleShowingUncontestedObjectives(loud)
	self.data.showUncontestedObjectives = not self.data.showUncontestedObjectives
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWUNCONTESTED, self.data.showUncontestedObjectives and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showUncontestedObjectives
end

function BattlegroundFu:IsShowingCTFFlagCarriers()
	return self.data.showCTFFlagCarriers
end

function BattlegroundFu:ToggleShowingCTFFlagCarriers(loud)
	self.data.showCTFFlagCarriers = not self.data.showCTFFlagCarriers
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWCTFFLAGCARRIERS, self.data.showCTFFlagCarriers and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showCTFFlagCarriers
end

function BattlegroundFu:IsShowingBattlefieldQueues()
	return self.data.showBattlefieldQueues
end

function BattlegroundFu:ToggleShowingBattlefieldQueues(loud)
	self.data.showBattlefieldQueues = not self.data.showBattlefieldQueues
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SHOWBATTLEFIELDQUEUES, self.data.showBattlefieldQueues and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:UpdateTooltip()
	return self.data.showBattlefieldQueues
end    

function BattlegroundFu:IsHidingQueueText(q)
	return self.data.hideQueueText[q]
end

function BattlegroundFu:ToggleHidingQueueText(q)
	self.data.hideQueueText[q] = not self.data.hideQueueText[q]
	self:UpdateText()
	return self.data.hideQueueText[q]
end
--End User Options Methods=====================================================
--FuBar Standard Methods=======================================================
function BattlegroundFu:Initialize()
	local defaults = {}
	for index,value in defaults do
		if self.data[index] == nil then
			self.data[index] = value
		end
	end
	self.j = 1
	self.numActiveBattlefields = {}
end

function BattlegroundFu:Enable()
	self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS", "OnUpdateBattlefieldStatus")
	self:RegisterEvent("UPDATE_WORLD_STATES", "UpdateTooltip")

	self.playerFaction = UnitFactionGroup("player")

	metro:Register(self.name, self.Update, 1, self)
	metro:Start(self.name)
--		metro:Register("BatFu_numActiveBattlefields", self.UpdateNumActiveBattlefields, 1, self)
end

function BattlegroundFu:Disable()
	glory:UnregisterAll(self)
	metro:Unregister(self.name)
--		metro:Unregister("BatFu_numActiveBattlefields")
end

function BattlegroundFu:Report()
	local report = compost:Acquire(
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_HIDEMINIMAPBUTTON,
			'val', self:IsHidingMinimapButton() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_INVERTQUEUEPROGRESS,
			'val', self:IsInvertQueueProgress() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_CLICKSHOWSSCOREBOARD,
			'val', self:IsClickShowsScoreboard() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWTEAMSIZES,
			'val', self:IsShowingTeamSizes() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWTEAMSCORES,
			'val', self:IsShowingTeamScores() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWNUMBASES,
			'val', self:IsShowingNumBases() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWRESOURCETTV,
			'val', self:IsShowingResourceTTV() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWBATTLEFIELDSTATS,
			'val', self:IsShowingBattlefieldPlayerStatistics() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWOBJECTIVESTATUS,
			'val', self:IsShowingBattlefieldObjectiveStatus() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWUNCONTESTED,
			'val', self:IsShowingUncontestedObjectives() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWCTFFLAGCARRIERS,
			'val', self:IsShowingCTFFlagCarriers() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		),
		compost:AcquireHash(
			'text', self.loc.ARGUMENT_SHOWBATTLEFIELDQUEUES,
			'val', self:IsShowingBattlefieldQueues() and 1 or 0,
			'map', FuBarLocals.MAP_ONOFF
		)
	)
	self.cmd:report(report)
	compost:Reclaim(report, 1)
end
------MenuSettings=============================================================
function BattlegroundFu:MenuSettings(level, value, inTooltip)
	if level == 1 then
    self:MenuSettings_BattlefieldDropDown() --Rewrite of the Battlefield Minimap Button Dropdown; see below
		dewdrop:AddLine()
		if not inTooltip then
			dewdrop:AddLine(
				'text', self.loc.MENU_HIDE_MINIMAP_BUTTON,
				'arg1', self,
				'func', "ToggleHidingMinimapButton",
				'checked', self:IsHidingMinimapButton()
			)
			dewdrop:AddLine(	
				'text', self.loc.MENU_INVERT_QUEUE_PROGRESS_TIMERS,
				'arg1', self,
				'func', "ToggleInvertQueueProgress",
				'checked', self:IsInvertQueueProgress()
			)
			dewdrop:AddLine(
				'text', self.loc.MENU_CLICK_SHOWS_SCOREBOARD,
				'arg1', self,
				'func', "ToggleClickShowsScoreboard",
				'checked', self:IsClickShowsScoreboard()
			)
			dewdrop:AddLine()
			dewdrop:AddLine(
				'text', self.loc.MENU_TOOLTIP_DISPLAY,
				'hasArrow', true,
				'value', "ttdisplay"
			)
		else
			self:MenuSettings_TooltipDisplay()
		end
	elseif level == 2 and not inTooltip then
		if value == "ttdisplay" then
			self:MenuSettings_TooltipDisplay()
		end
	end
end
----------MenuSettings Component Methods=======================================
function BattlegroundFu:MenuSettings_BattlefieldDropDown()
	local status, mapName
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local i = i
		local mapName = mapName
		status, mapName = GetBattlefieldStatus(i)
		if status == "queued" or status == "confirm" then
			dewdrop:AddLine()
			dewdrop:AddLine(
				'text', mapName,
				'textR', 1,
				'textG', 0.843,
				'textB', 0,
				'arg1', self,
				'arg2', mapName,
				'func', "ToggleHidingQueueText",
				'checked', not self:IsHidingQueueText(mapName)
			)
			if status == "queued" then
				dewdrop:AddLine(
					'text', CHANGE_INSTANCE,
					'func',	function ()
						ShowBattlefieldList(i)
					end
				)
			elseif status == "confirm" then
				dewdrop:AddLine(
					'text', ENTER_BATTLE,
					'func', function ()
						AcceptBattlefieldPort(i, 1)
					end
				)
			end
			dewdrop:AddLine(
				'text', LEAVE_QUEUE,
				'func', function ()
					AcceptBattlefieldPort(i)
					if not IsShiftKeyDown() then
						dewdrop:Close(1)
					end
				end
			)
		end
	end
end

function BattlegroundFu:MenuSettings_TooltipDisplay()
	dewdrop:AddLine(
		'text', self.loc.MENU_TEAM_SIZES,
		'arg1', self,
		'func', "ToggleShowingTeamSizes",
		'checked', self:IsShowingTeamSizes()
	)

	dewdrop:AddLine(
		'text', self.loc.MENU_TEAM_SCORES,
		'arg1', self,
		'func', "ToggleShowingTeamScores",
		'checked', self:IsShowingTeamScores()
	)
	dewdrop:AddLine(
		'text', self.loc.MENU_NUM_BASES_HELD,
		'arg1', self,
		'func', "ToggleShowingNumBases",
		'checked', self:IsShowingNumBases()
	)
	dewdrop:AddLine(
		'text', self.loc.MENU_RESOURCE_TTV,
		'arg1', self,
		'func', "ToggleShowingResourceTTV",
		'checked', self:IsShowingResourceTTV()
	)
	dewdrop:AddLine(
		'text', self.loc.MENU_BATTLEFIELD_STATS,
		'arg1', self,
		'func', "ToggleShowingBattlefieldPlayerStatistics",
		'checked', self:IsShowingBattlefieldPlayerStatistics()
	)
	dewdrop:AddLine(
		'text', self.loc.MENU_OBJECTIVE_STATUS,
		'arg1', self,
		'func', "ToggleShowingBattlefieldObjectiveStatus",
		'checked', self:IsShowingBattlefieldObjectiveStatus()
	)
	dewdrop:AddLine(
		'text', self.loc.MENU_SHOW_UNCONTESTED,
		'arg1', self,
		'func', "ToggleShowingUncontestedObjectives",
		'checked', self:IsShowingUncontestedObjectives(),
		'disabled', not self:IsShowingBattlefieldObjectiveStatus()
	)
	dewdrop:AddLine(
		'text', self.loc.MENU_CTF_FLAG_CARRIERS,
		'arg1', self,
		'func', "ToggleShowingCTFFlagCarriers",
		'checked', self:IsShowingCTFFlagCarriers()
	)
	dewdrop:AddLine(
		'text', self.loc.MENU_BATTLEFIELD_QUEUES,
		'arg1', self,
		'func', "ToggleShowingBattlefieldQueues",
		'checked', self:IsShowingBattlefieldQueues()
	)
end                
----------End MenuSettings Component Methods===================================
------End MenuSettings=========================================================
function BattlegroundFu:OnClick()
	if glory:IsInBattlegrounds() and self:IsClickShowsScoreboard() then
		if WorldStateScoreFrame:IsVisible() then
			HideUIPanel(WorldStateScoreFrame)
		else
			ShowUIPanel(WorldStateScoreFrame)
		end
	elseif GetBattlefieldStatus(self.j) == "active" then
		ShowUIPanel(WorldStateScoreFrame)
		self.j = self.j + 1
	elseif GetBattlefieldStatus(self.j) == "queued" or GetBattlefieldStatus(self.j) == "confirm" then
		HideUIPanel(WorldStateScoreFrame)
		ShowBattlefieldList(self.j)
		self.j = self.j + 1
	else
		HideUIPanel(WorldStateScoreFrame)
		HideUIPanel(BattlefieldFrame)
		self.j = 1
	end
end
------UpdateData===============================================================	
function BattlegroundFu:UpdateData()
	if glory:IsInBattlegrounds() then
		RequestBattlefieldScoreData()
	end
end
------End UpdateData===========================================================
------UpdateText===============================================================
function BattlegroundFu:UpdateText()
	self:SetIcon(self.FACTION_ICON_PATH .. self.playerFaction)
	if glory:IsInBattlegrounds() then
		self:UpdateText_BattlefieldPlayerStatistics()
	else
		self:UpdateText_QueuedBattlefields()
	end
end
----------UpdateText Component Methods=========================================
function BattlegroundFu:UpdateText_BattlefieldPlayerStatistics()
	local red, green, white = crayon.COLOR_HEX_RED, crayon.COLOR_HEX_GREEN, crayon.COLOR_HEX_WHITE
	if glory:GetStanding() then
		self:SetText(format("#: |cff%s%s|r KB: |cff%s%s|r K: |cff%s%s|r D: |cff%s%s|r H: |cff%s%s|r", white, glory:GetStanding(), green, glory:GetKillingBlows(), green, glory:GetHonorableKills(), red, glory:GetDeaths(), white, glory:GetBonusHonor()))
	end
end

function BattlegroundFu:UpdateText_QueuedBattlefields()
	local status, mapName, progress, usingDefaultText, bgTimeQueued, bgEstimatedTime, timeColor
	local queueText = self.loc.TEXT_NO_QUEUES
	local numQueues = 0
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		status, mapName = GetBattlefieldStatus(i)
		if status == "queued" then
			numQueues = numQueues + 1
			if not self:IsHidingQueueText(mapName) then
				bgTimeQueued = GetBattlefieldTimeWaited(i)/1000
				bgEstimatedTime = GetBattlefieldEstimatedWaitTime(i)/1000
				timeColor = crayon:GetThresholdHexColor(1-bgTimeQueued/bgEstimatedTime, -0.25, -0.1, 0.1, 0.5, 0.9)
				if self:IsInvertQueueProgress() then
					progress = format("|cff%s%s|r/%s", timeColor, abacus:FormatDurationFull(bgEstimatedTime - bgTimeQueued, nil, 1), abacus:FormatDurationFull(bgEstimatedTime, nil, 1))
				else
					progress = format("|cff%s%s|r/%s", timeColor, abacus:FormatDurationFull(bgTimeQueued, nil, 1), abacus:FormatDurationFull(bgEstimatedTime, nil, 1))
				end
				if usingDefaultText or queueText == self.loc.TEXT_NO_QUEUES then
					queueText = glory:GetBGAcronym(mapName) .. ": " .. progress
				else
					queueText = queueText .. " || " ..  glory:GetBGAcronym(mapName) .. ": " .. progress
				end
				usingDefaultText = nil
			end
			if usingDefaultText or queueText == self.loc.TEXT_NO_QUEUES then
				queueText = format("%d %s", numQueues, self.loc.TEXT_QUEUES)
				usingDefaultText = true
			end
		end
	end
	self:SetText(queueText)
end
----------End UpdateText Component Methods=====================================
------End UpdateText===========================================================

------UpdateTooltip============================================================
function BattlegroundFu:UpdateTooltip()
	if glory:IsInBattlegrounds() and self:IsClickShowsScoreboard() then
		tablet:SetHint(self.loc.TEXT_HINT_CLICKSHOWSSCOREBOARD)
	else
		tablet:SetHint(self.loc.TEXT_HINT_NORMAL)
	end

	local status, mapName, instanceID
	
	if glory:IsInBattlegrounds() then
		tablet:AddCategory():AddLine('text', glory:GetActiveBattlefieldUniqueID(), 'textR', 1, 'textG', 1, 'textB', 1)
		if self:IsShowingTeamSizes() then
			self:UpdateTooltip_BattlefieldMatchInfo(self.loc.TEXT_PLAYERS, glory:GetNumAlliancePlayers(), glory:GetNumHordePlayers())
		end
		if self:IsShowingTeamScores() and GetWorldStateUIInfo(1) then
			self:UpdateTooltip_BattlefieldMatchInfo(self.loc.TEXT_SCORE, glory:GetAllianceScoreString(), glory:GetHordeScoreString())
		end
		if self:IsShowingNumBases() and GetWorldStateUIInfo(1) and string.find(GetWorldStateUIInfo(1), self.loc.TEXT_BASES) then
			self:UpdateTooltip_BattlefieldMatchInfo(self.loc.TEXT_BASES, glory:GetNumAllianceBases(), glory:GetNumHordeBases())
		end
		if self:IsShowingResourceTTV() and GetWorldStateUIInfo(1) and string.find(GetWorldStateUIInfo(1), self.loc.TEXT_RESOURCES) then
			self:UpdateTooltip_BattlefieldMatchInfo(self.loc.TEXT_TTV, abacus:FormatDurationCondensed(glory:GetAllianceTTV()), abacus:FormatDurationCondensed(glory:GetHordeTTV()))
		end
		if self:IsShowingBattlefieldPlayerStatistics() then
			self:UpdateTooltip_BattlefieldPlayerStatistics()
		end
		if GetNumMapLandmarks() > 0 and self:IsShowingBattlefieldObjectiveStatus() then
			self:UpdateTooltip_BattlefieldObjectiveTimers()
		end
		if self:IsShowingCTFFlagCarriers() and glory:GetActiveBattlefieldZone() == babbleZone:GetLocalized("WARSONG_GULCH") then
			self:UpdateTooltip_CTFFlagCarriers()
		end
	end

	if self:IsShowingBattlefieldQueues() then
		for i=1, MAX_BATTLEFIELD_QUEUES do
			status = GetBattlefieldStatus(i)
			if status == "queued" or status == "confirm" then
				self:UpdateTooltip_BGQueues()
				break
			end
		end
	end
end
----------UpdateTooltip ComponeMethods=========================================
function BattlegroundFu:UpdateTooltip_BattlefieldMatchInfo(label, textA, textH)
	local aR, aG, aB = glory:GetFactionColor(FACTION_ALLIANCE)
	local hR, hG, hB = glory:GetFactionColor(FACTION_HORDE)
	local cat = tablet:AddCategory(
		'hideBlankLine', true,
--			'text', glory:GetActiveBattlefieldUniqueID(),
		'columns', 3,
		'child_textR', aR,
		'child_textG', aG,
		'child_textB', aB,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1,
		'child_text3R', hR,
		'child_text3G', hG,
		'child_text3B', hB
	)

	cat:AddLine(
		'text', textA,
		'text2', label,
		'text3', textH
	)
end

function BattlegroundFu:UpdateTooltip_BattlefieldPlayerStatistics()
	local cat = tablet:AddCategory(
		'columns', 2,
		'text', self.loc.TEXT_PLAYER_STATS,
		'child_textR', 1,
		'child_textG', 0.843,
		'child_textB', 0
	)

	cat:AddLine(
		'text', self.loc.TEXT_STANDING,
		'text2', glory:GetStanding(),
		'text2R', 1,
		'text2G', 1,
		'text2B', 1
	)
	cat:AddLine(
		'text', self.loc.TEXT_KILLING_BLOWS,
		'text2', glory:GetKillingBlows(),
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	)
	cat:AddLine(
		'text', self.loc.TEXT_KILLS,
		'text2', glory:GetHonorableKills(),
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	)
	cat:AddLine(
		'text', self.loc.TEXT_DEATHS,
		'text2', glory:GetDeaths(),
		'text2R', 1,
		'text2G', 0,
		'text2B', 0
	)
	cat:AddLine(
		'text', self.loc.TEXT_BONUS_HONOR,
		'text2', glory:GetBonusHonor(),
		'text2R', 1,
		'text2G', 1,
		'text2B', 1
	)
end

function BattlegroundFu:UpdateTooltip_BattlefieldObjectiveTimers()
	local node, status, lR, lG, lB, rR, rG, rB
if glory.battlefieldObjectiveStatus and next(glory.battlefieldObjectiveStatus) then
		local cat = tablet:AddCategory(
			'columns', 2,
			'text', self.loc.TEXT_BASE,
			'text2', self.loc.TEXT_STATUS
		)
		for _, poi in glory:IterateSortedObjectiveNodes() do
			lR, lG, lB = glory:GetFactionColor(glory:GetDefender(poi))
			rR, rG, rB = glory:GetFactionColor(glory:GetDefender(poi))
			node = glory:GetName(poi)
			if glory:IsInConflict(poi) then
				rR, rG, rB = glory:GetFactionColor(glory:GetAttacker(poi))
				if glory:GetTimeAttacked(poi) then
					status = abacus:FormatDurationCondensed(glory:GetTimeToCapture(poi))
				else        --when joining a battlefield where the node is already under attack
					status = self.loc.TEXT_BGOBJECTIVE_INCONFLICT
				end
			elseif glory:IsDestroyed(poi) then
				status = self.loc.TEXT_BGOBJECTIVE_DESTROYED
			else
				status = glory:GetDefender(poi)
			end
			if self:IsShowingUncontestedObjectives() or glory:IsInConflict(poi) then
				cat:AddLine(
					'text', node,
					'text2', status,
					'textR', lR,
					'textG', lG,
					'textB', lB,
					'text2R', rR,
					'text2G', rG,
					'text2B', rB
				)
			end
		end
	end
end

function BattlegroundFu:UpdateTooltip_CTFFlagCarriers()
	local aR, aG, aB = glory:GetFactionColor(FACTION_ALLIANCE)
	local hR, hG, hB = glory:GetFactionColor(FACTION_HORDE)
	local rR, rG, rB, carrier
	local cat = tablet:AddCategory(
		'columns', 2,
		'text', self.loc.TEXT_FLAG,
		'text2', self.loc.TEXT_CARRIER
	)
	carrier = glory:GetHordeFlagCarrier()
	if carrier then
		rR, rG, rB = glory:GetFactionColor(FACTION_HORDE)
	else
		rR, rG, rB = glory:GetFactionColor(FACTION_ALLIANCE)
	end
	cat:AddLine(
		'text', FACTION_ALLIANCE,
		'text2', carrier or self.loc.TEXT_NA,
		'textR', aR,
		'textG', aG,
		'textB', aB,
		'text2R', rR,
		'text2G', rG,
		'text2B', rB,
		'func', function()
			glory:TargetHordeFlagCarrier()
		end
	)
	
	carrier = glory:GetAllianceFlagCarrier()
	if carrier then
		rR, rG, rB = glory:GetFactionColor(FACTION_ALLIANCE)
	else
		rR, rG, rB = glory:GetFactionColor(FACTION_HORDE)
	end
	cat:AddLine(
		'text', FACTION_HORDE,
		'text2', carrier or self.loc.TEXT_NA,
		'textR', hR,
		'textG', hG,
		'textB', hB,
		'text2R', rR,
		'text2G', rG,
		'text2B', rB,
		'func', function()
			glory:TargetAllianceFlagCarrier()
		end
	)
end

function BattlegroundFu:UpdateTooltip_BGQueues()
	local status, mapName, progress, bgTimeQueued, bgEstimatedTime, timeR, timeG, timeB, bgPortExpiration
	local cat = tablet:AddCategory(
		'columns', 2,
		'text', self.loc.TEXT_BGQUEUES,
		'text2', self:IsInvertQueueProgress() and self.loc.TEXT_INVERT_QUEUE_PROGRESS or self.loc.TEXT_QUEUE_PROGRESS,
		'child_textG', 0.843,
		'child_teøt1B', 0
	)
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local i = i
		status, mapName = GetBattlefieldStatus(i)
		if self.numActiveBattlefields[i] then
			mapName = format("(%d) %s", self.numActiveBattlefields[i], mapName)
		end
		if status == "queued" then
			bgTimeQueued = GetBattlefieldTimeWaited(i)/1000
			bgEstimatedTime = GetBattlefieldEstimatedWaitTime(i)/1000
			timeR, timeG, timeB = crayon:GetThresholdColor(1-bgTimeQueued/bgEstimatedTime, -0.25, -0.1, 0.1, 0.5, 0.9)
			if self:IsInvertQueueProgress() then
				progress = abacus:FormatDurationCondensed(bgEstimatedTime - bgTimeQueued) .. "|r|cffffd700/" .. abacus:FormatDurationCondensed(bgEstimatedTime)
			else
				progress = abacus:FormatDurationCondensed(bgTimeQueued) .. "|r|cffffd700/" .. abacus:FormatDurationCondensed(bgEstimatedTime)
			end
			cat:AddLine(
				'text', mapName,
				'text2', progress,
				'text2R', timeR,
				'text2G', timeG,
				'text2B', timeB,
				'func', function ()
					if not BattlefieldFrame:IsVisible() or self.ttOpenBattlefieldFrame ~= i then
						ShowBattlefieldList(i)
						self.ttOpenBattlefieldFrame = i
					else
						HideUIPanel(BattlefieldFrame)
					end
				end
			)
		end
		if status == "confirm" then
			bgPortExpiration = GetBattlefieldPortExpiration(i)/1000
			timeR, timeG, timeB = crayon:GetThresholdColor(bgPortExpiration/120)
			progress = self.loc.TEXT_CONFIRM .. ": " .. abacus:FormatDurationCondensed(bgPortExpiration)
			cat:AddLine(
				'text', mapName,
				'text2', progress,
				'text2R', timeR,
				'text2G', timeG,
				'text2B', timeB,
				'func', function ()
					if not BattlefieldFrame:IsVisible() or self.ttOpenBattlefieldFrame ~= i then
						ShowBattlefieldList(i)
						self.ttOpenBattlefieldFrame = i
					else
						HideUIPanel(BattlefieldFrame)
					end
				end
			)
		end
	end
end
----------End UpdateTooltip Component Methods==================================
------End UpdateTooltip========================================================
--End FuBar Standard Methods===================================================

--Game Events==================================================================
function BattlegroundFu:OnUpdateBattlefieldStatus()
	if self:IsHidingMinimapButton() and MiniMapBattlefieldFrame:IsVisible() then
		MiniMapBattlefieldFrame:Hide()
	end
	self:UpdateDisplay()
	if BattlefieldFrame:GetAlpha() ~= 1 and BattlefieldFrame:GetAlpha() ~= 0 then
		bfAlpha = BattlefieldFrame:GetAlpha()
	end
--		metro:Start("BatFu_numActiveBattlefields")
end

--[[	function BattlegroundFu:UpdateNumActiveBattlefields()
	if BattlefieldFrame:IsVisible() and BattlefieldFrame:GetAlpha() > 0 then return end
	bfNum = bfNum or 1
	if bfNum <= MAX_BATTLEFIELD_QUEUES + 1 then
		if bfNum ~= 1 then
			self.numActiveBattlefields[bfNum - 1] = GetNumBattlefields()
		end
		BattlefieldFrame:SetAlpha(0)
		ShowBattlefieldList(bfNum)
		bfNum = bfNum + 1
	else
		HideUIPanel(BattlefieldFrame)
		BattlefieldFrame:SetAlpha(bfAlpha or 1)
		metro:Stop("BatFu_numActiveBattlefields")
		bfNum = 1
	end
end]]--
--End Game Events==============================================================

BattlegroundFu:RegisterForLoad()

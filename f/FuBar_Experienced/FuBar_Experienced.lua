local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')
local metro = Metrognome:GetInstance('1')

FuBar_Experienced =  FuBarPlugin:GetInstance("1.2"):new({
	name				= FuBar_ExperiencedLocals.NAME,
	description		= FuBar_ExperiencedLocals.DESCRIPTION,
	version			= "0.3.0",
	releaseDate		= "05-18-2006",
	aceCompatible	= 103,
	author				= "Tain",
	email				= "tain.dev@gmail.com",
	website			= "http://tain.wowinterface.com/",
	category			= "others",
	db					= AceDatabase:new("FuBar_ExperiencedDB"),
	defaults			= {
					levelExp = TRUE,
					levelExpPercent = TRUE,
					restedExp = TRUE
	},
	cmd					= AceChatCmd:new(FuBar_ExperiencedLocals.CHATCMD, FuBar_ExperiencedLocals.CHATOPT),
	locals				= FuBar_ExperiencedLocals,

	-- Methods
	GetVar = function(self,var)
		return self.data[var] and TRUE
	end,
	
	ToggleShowLevelExp = function(self, silent)
		self.data.levelExp = not self.data.levelExp
		if silent ~= TRUE then
			self.cmd:status(self.locals.MENU_SHOW_LEVEL_XP, self:GetVar("levelExp"), FuBarUtils.MAP_ONOFF)
		end
		self:Update()
		return self.data.levelExp
	end,

	ToggleShowToLevelExp = function(self, silent)
		self.data.toLevelExp = not self.data.toLevelExp
		if silent ~= TRUE then
			self.cmd:status(self.locals.MENU_SHOW_TOLEVEL_XP, self:GetVar("toLevelExp"), FuBarUtils.MAP_ONOFF)
		end
		self:Update()
		return self.data.toLevelExp
	end,

	ToggleShowLevelExpPercent = function(self, silent)
		self.data.levelExpPercent = not self.data.levelExpPercent
		if silent ~= TRUE then
			self.cmd:status(self.locals.MENU_SHOW_LEVEL_XP_PERCENT, self:GetVar("levelExpPercent"), FuBarUtils.MAP_ONOFF)
		end
		self:Update()
		return self.data.showExpPercent
	end,

	ToggleShowRestedExp = function(self, silent)
		self.data.restedExp = not self.data.restedExp
		if silent ~= TRUE then
			self.cmd:status(self.locals.MENU_SHOW_RESTED_XP, self:GetVar("restedExp"), FuBarUtils.MAP_ONOFF)
		end
		self:Update()
		return self.data.restedExp
	end,
	
	ToggleShowRestedExpPercent = function(self, silent)
		self.data.restedExpPercent = not self.data.restedExpPercent
		if silent ~= TRUE then
			self.cmd:status(self.locals.MENU_SHOW_RESTED_XP_PERCENT, self:GetVar("restedExpPercent"), FuBarUtils.MAP_ONOFF)
		end
		self:Update()
		return self.data.restedExpPercent
	end,

	ToggleShowAverageExp = function(self, silent)
		self.data.averageExp = not self.data.averageExp
		if silent ~= TRUE then
			self.cmd:status(self.locals.MENU_SHOW_AVERAGE_XP_GAIN, self:GetVar("averageExp"), FuBarUtils.MAP_ONOFF)
		end
		self:Update()
		return self.data.averageExp
	end,
	
	ToggleShowByLevel = function(self, silent)
		self.data.byLevel = not self.data.byLevel
		if silent ~= TRUE then
			self.cmd:status(self.locals.MENU_SHOW_AVERAGE_XP_GAIN_BY_LEVEL, self:GetVar("byLevel"), FuBarUtils.MAP_ONOFF)
		end
		self:Update()
		return self.data.byLevel
	end,
	
	Initialize = function(self)
		self.initialXP = UnitXP("player")
	end,
	
	Enable = function(self)
		self.timeSinceLastUpdate = 0
		self:RegisterEvent("PLAYER_XP_UPDATE", "OnPlayerXpUpdate")
		self:RegisterEvent("PLAYER_LEVEL_UP", "OnPlayerLevelUp")
		self:RegisterEvent("TIME_PLAYED_MSG", "OnTimePlayedMsg")
--		RequestTimePlayed()
		metro:Register(self.name, self.Update, 2, self)
		metro:Start(self.name)
	end,
	
	Disable = function(self)
	end,
	
	Report = function(self)
		self.cmd:report({
			{
				text=self.locals.MENU_SHOW_LEVEL_XP,
				val=self:GetVar("levelExp"), 
				map=FuBarLocals.MAP_ONOFF
			},
			{
				text=self.locals.MENU_SHOW_TOLEVEL_XP,
				val=self:GetVar("toLevelExp"), 
				map=FuBarLocals.MAP_ONOFF
			},
			{
				text=self.locals.MENU_SHOW_LEVEL_XP_PERCENT,
				val=self:GetVar("levelExpPercent"), 
				map=FuBarLocals.MAP_ONOFF
			},
			{
				text=self.locals.MENU_SHOW_RESTED_XP,
				val=self:GetVar("restedExp"), 
				map=FuBarLocals.MAP_ONOFF
			},
			{
				text=self.locals.MENU_SHOW_RESTED_XP_PERCENT,
				val=self:GetVar("restedExpPercent"), 
				map=FuBarLocals.MAP_ONOFF
			},
		})
	end,
	
	MenuSettings = function(self, level, value)
	
		dewdrop:AddLine(
			'text', self.locals.MENU_SHOW_LEVEL_XP,
			'arg1', self,
			'func', function()
				self:ToggleShowLevelExp(TRUE)
			end,
			'checked', self:GetVar("levelExp")
		)
	
		dewdrop:AddLine(
			'text', self.locals.MENU_SHOW_TOLEVEL_XP,
			'arg1', self,
			'func', function()
					self:ToggleShowToLevelExp(TRUE)
				end,
			'checked', self:GetVar("toLevelExp")
		)
	
		dewdrop:AddLine(
			'text', self.locals.MENU_SHOW_LEVEL_XP_PERCENT,
			'arg1', self,
			'func', function()
					self:ToggleShowLevelExpPercent(TRUE)
				end,
			'checked', self:GetVar("levelExpPercent")
		)
	
		dewdrop:AddLine(
			'text', self.locals.MENU_SHOW_RESTED_XP,
			'arg1', self,
			'func', function()
					self:ToggleShowRestedExp(TRUE)
				end,
			'checked', self:GetVar("restedExp")
		)

		dewdrop:AddLine(
			'text', self.locals.MENU_SHOW_RESTED_XP_PERCENT,
			'arg1', self,
			'func', function()
					self:ToggleShowRestedExpPercent(TRUE)
				end,
			'checked', self:GetVar("restedExpPercent")
		)

	end,
	
	OnUpdate = function(self, difference)
		self.timeSinceLastUpdate = self.timeSinceLastUpdate + difference
		if self.timeSinceLastUpdate >= 1 then
			self.timeSinceLastUpdate = 0
			self:Update()
		end
	end,
	
	UpdateText = function(self)
		local totalXP = UnitXPMax("player")
		local currentXP = UnitXP("player")
		local toLevelXP = totalXP - currentXP
		local sessionXP = self.sessionXP
		local xps

		local restedXP
		if self.data.toLevelExp then
			xps = "XPLvl: |cffffffff%d|r"
			xps = string.format(xps, toLevelXP)
		elseif self.data.levelExp then
			xps  = "XP/T: |cffffffff%d|r/|cffffffff%d|r"
			xps = string.format(xps, currentXP, totalXP)
		else
			xps  = "XP: |cffffffff%d|r"
			xps = string.format(xps, currentXP)
		end
			if self.data.levelExpPercent then
			local xpp = " (|cffffffff%.1f%%|r)"
			if self.data.toLevelExp then
				xpp = string.format(xpp, toLevelXP / totalXP * 100)					
			else
				xpp = string.format(xpp, currentXP / totalXP * 100)
			end
			xps = xps..xpp
		end
		
		if self.data.restedExp then
			restedXP = GetXPExhaustion()
			restedXP = restedXP or 0
			if self.data.restedExpPercent then
				restedXP = format("R: |cffffffff%.1f%%|r", floor((restedXP*100)/totalXP))
			else
				restedXP = format("R: |cffffffff%d|r", restedXP)
			end
		else
			restedXP = nil
		end
		xps = xps..((restedXP and " "..restedXP) or "")

		xps = xps or ""
		self:SetText(xps)
	end,

	UpdateTooltip = function(self)
		local totalXP = UnitXPMax("player")
		local currentXP = UnitXP("player")
		local restedXP = GetXPExhaustion()
		local toLevelXP = totalXP - currentXP
		
		local cat = tablet:AddCategory(
			'columns', 2,
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0,
			'child_text2R', 1,
			'child_text2G', 1,
			'child_text2B', 1
		)

		cat:AddLine(
			'text', self.locals.TEXT_LEVEL .. ":",
			'text2', UnitLevel("player")
		)
	
		cat:AddLine(
			'text', self.locals.TEXT_TOTAL_LEVEL_XP .. ":",
			'text2', totalXP
		)
			
		cat:AddLine(
			'text', self.locals.TEXT_XP_GAINED .. ":",
			'text2', format("%d (%.1f%%)", currentXP, currentXP / totalXP * 100)
		)

		cat:AddLine(
			'text', self.locals.TEXT_XP_REMAINING .. ":",
			'text2', format("%d (%.1f%%)", toLevelXP, toLevelXP / totalXP * 100)
		)
		
		cat:AddLine(
			'text', self.locals.TEXT_RESTED_XP .. ":",
			'text2', restedXP
		)
	end,
})
FuBar_Experienced:RegisterForLoad()
local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')
local metro = Metrognome:GetInstance('1')
local crayon = CrayonLib:GetInstance("1.0")

DamageMetersFu = FuBarPlugin:GetInstance("1.2"):new({
	name          = DamageMetersFuLocals.NAME,
	description   = DamageMetersFuLocals.DESCRIPTION,
	version       = "1.2.1",
	releaseDate   = "05-27-2006",
	aceCompatible = 103,
	fuCompatible  = 102,
	author        = "Blindchuck <Ropetown>",
	email         = "c@chuckg.org",
	website       = "http://chuckg.wowinterface.com",
	category      = "combat", -- Set this to the appropriate category.
	db            = AceDatabase:new("DamageMetersFuDB"),
	
	defaults      = {
		short_display = false,
		color_display = false,
		use_dm_colors = false,
		shownValues = {},
		shownRanks = {},
		shownLeaders = {}
	},
	
	cmd           = AceChatCmd:new(DamageMetersFuLocals.COMMANDS, DamageMetersFuLocals.CMD_OPTIONS),
	loc           = DamageMetersFuLocals,
	hasIcon       = "Interface\\AddOns\\FuBaR_DamageMetersFu\\DamageMeters.blp",
	cannotDetachTooltip = TRUE
})

function DamageMetersFu:IsQuantityShown(var, quantity)
	-- Check to see if there is currently a quantity type being shown for this type.
	if ( self.data["shown"..var][quantity]) then
		return true
	else
		return false
	end
end

function DamageMetersFu:ToggleQuantity(var, quantity)
	if ( self.data["shown" .. var][quantity] ~= nil ) then
		self.data["shown" .. var][quantity] = not self.data["shown" .. var][quantity]
	else
		self.data["shown" .. var][quantity] = true
	end
	
	-- We always need to update if the user has selected a new variable to show so the appropriate variables are displayed.
	self:Update()
end

function DamageMetersFu:ToggleOption(var, doUpdate)
	if self.data[var] then
		self.data[var] = not self.data[var]
	else
		self.data[var] = true
	end
	
	if doUpdate then
		self:Update()
	end
end

function DamageMetersFu:Initialize()
	-- Check if DM is loaded and setup our variable we use for checking.
	self.DMEnabled = self:IsDamageMetersLoaded();
end

function DamageMetersFu:Enable()
	-- put something that would be run every time this is enabled. Happens at the very start as well, after Initialize.
	if ( self.DMEnabled ) then
		if ( not self.rankTable ) then
			-- Setup our rankTable references for differing versions of DM; namely 4.2.1 vs 4.3.x
			if ( DamageMeters_VERSION == 4500 ) then
				self.rankTable = DamageMeters_rankTables[DMT_ACTIVE]
			else 
				self.rankTable = "DamageMeters_rankTable"
				self.rankTableGlobal = true
			end
		end
		
		metro:Register(self.name, self.OnUpdate, 1, self)
		metro:Start(self.name)
	end
end

function DamageMetersFu:Disable()
	-- you do not need to unregister the event here, all events/hooks are unregistered on disable implicitly.
	if ( self.DMEnabled ) then
		metro:Unregister(self.name)
	end
end

function DamageMetersFu:OnUpdate() 
	self:Update()	
end

function DamageMetersFu:OnClick()
	if (self.DMEnabled) then
		DamageMeters_ToggleShow()
	end
end

function DamageMetersFu:MenuSettings(level, value)
	if ( self.DMEnabled ) then
		if ( level == 1 ) then
			-- Display None
			dewdrop:AddLine(
				'text', self.loc.MENU_DISPLAY_NONE,
				'func', function() 
							self.data.shownValues = {}
							self.data.shownRanks = {}
							self.data.shownLeaders = {}
						end
			)
			
			-- Value 
			dewdrop:AddLine(
				'text', self.loc.MENU_VALUE,
				'hasArrow', true, 
				'value',  self.loc.MENU_VALUE
			)
	
			-- Rank
			dewdrop:AddLine(
				'text', self.loc.MENU_RANK, 
				'hasArrow', true, 
				'value', self.loc.MENU_RANK
			)
			
			-- Leader 
			dewdrop:AddLine(
				'text', self.loc.MENU_LEADER,
				'hasArrow',  true, 
				'value', self.loc.MENU_LEADER
			)		
			
			dewdrop:AddLine();
			
			-- The other stuff; reset position, pause parsing, and clear current.
			dewdrop:AddLine(
				'text', self.loc.MENU_RESET_POSITION,
				'arg1', self,
				'func', "DMResetPos"
			)
			
			dewdrop:AddLine(
				'text', self.loc.MENU_PAUSE,
				'arg1', self,
				'func', "DMTogglePause",
				'checked', self:DMGetPauseState()
			)
			
			dewdrop:AddLine(
				'text', self.loc.MENU_CLEAR,
				'arg1', self,
				'func', "DMClear"
			)
			
			dewdrop:AddLine()
			
			-- Basic Settings
			dewdrop:AddLine(
				'text', self.loc.MENU_SHORT_DISPLAY,
				'func', function()
							self:ToggleOption("short_display", true)
						end,
				'checked', self.data.short_display
			)
			
			dewdrop:AddLine(
				'text', self.loc.MENU_COLOR_DISPLAY,
				'func', function()
							self:ToggleOption("color_display", true)
						end,
				'checked', self.data.color_display
			)
			
			dewdrop:AddLine(
				'text', self.loc.MENU_USE_DM_COLORS,
				'func', function()
							self:ToggleOption("use_dm_colors", true)
						end,
				'checked', self.data.use_dm_colors
			)
			
		elseif ( level == 2 ) then
			-- value = text from the arrow pointing here.
			-- now our quantity types, they're the same through all menu types so we don't bother checking the value.
			
			for i,e in self.loc.DAMAGEMETERS_QUANT do
				dewdrop:AddLine(
					'text',	crayon:Colorize(self:GetQuantityColorCode(i), e.name),
					'arg1', self,
					'func', "ToggleQuantity",
					'arg2',	value,
					'arg3', i,
					'checked', self:IsQuantityShown(value, i)
				)
			end
		end
	end
end

function DamageMetersFu:UpdateText()
	if ( not self.DMEnabled ) then 
		-- DM not installed message
		self:SetText(crayon:Red(self.loc.DAMAGEMETERS_MISSING))
	else
		local text = ""
		
		-- run through selected values
		for i,e in self.data.shownValues do
			if ( self.data.shownValues[i] ) then
				text = text .. " " .. self:GetValueText(i)
			end
		end
		
		-- run through the selected ranks
		local playerRanks = ( self.rankTableGlobal and getglobal(self.rankTable) or self.rankTable )[UnitName("Player")]
		for i,e in self.data.shownRanks do
			if ( self.data.shownRanks[i] ) then
				if ( playerRanks ~= nil ) then
					text = text .. " " .. self:GetRankText(i, playerRanks[i])
				else
					text = text .. " " .. self:GetRankText(i, nil)
				end
			end
			
			
		end
		
		-- run through the selected leader boards
		for i,e in self.data.shownLeaders do
			if ( self.data.shownLeaders[i] ) then
				text = text .. " " .. self:GetLeaderText(i)
			end
		end
		
		-- user hasn't selected anything to display or we're in a paused state.
		if ( text == "" or  self:DMGetPauseState() ) then
			text = crayon:White(self.loc.TEXT)
		end
		
		-- set the text
		self:SetText(text);
	end
end

function DamageMetersFu:GetValueText(quantity)
	-- short display
	if ( self.data.short_display ) then
		-- color the whole string or color just the descriptor.
		if ( self.data.color_display ) then 
			return crayon:Colorize(self:GetQuantityColorCode(quantity), self.loc.DAMAGEMETERS_QUANT[quantity].abbr) .. crayon:White("=" .. DamageMeters_GetQuantityValueString(quantity, UnitName("Player")))
		else
			return crayon:Yellow(self.loc.DAMAGEMETERS_QUANT[quantity].abbr) .. crayon:White("=" .. DamageMeters_GetQuantityValueString(quantity, UnitName("Player")))
		end
	else
		if ( self.data.color_display ) then 
			return crayon:Colorize(self:GetQuantityColorCode(quantity), self.loc.DAMAGEMETERS_QUANT[quantity].name) .. crayon:White("=" .. DamageMeters_GetQuantityValueString(quantity, UnitName("Player")))
		else
			return crayon:Yellow(self.loc.DAMAGEMETERS_QUANT[quantity].name) .. crayon:White("=" .. DamageMeters_GetQuantityValueString(quantity, UnitName("Player")))
		end
	end
end

function DamageMetersFu:GetRankText(quantity, rank)
	if ( rank == nil or rank == "") then
		rank = "-"
	end
	
	-- short display
	if ( self.data.short_display ) then
		-- color the whole string or color just the descriptor.
		if ( self.data.color_display ) then 
			return crayon:Colorize(self:GetQuantityColorCode(quantity), self.loc.DAMAGEMETERS_QUANT[quantity].abbr .. "#") .. crayon:White("=" .. rank)
		else
			return crayon:Yellow(self.loc.DAMAGEMETERS_QUANT[quantity].abbr .. "#") .. crayon:White("=" .. rank)
		end
	else
		if ( self.data.color_display ) then 
			return crayon:Colorize(self:GetQuantityColorCode(quantity), self.loc.DAMAGEMETERS_QUANT[quantity].name .. "#") .. crayon:White("=" .. rank)
		else
			return crayon:Yellow(self.loc.DAMAGEMETERS_QUANT[quantity].name .. "#") .. crayon:White("=" .. rank)
		end
	end
end

function DamageMetersFu:GetLeaderText(quantity)
	-- short display
	if ( self.data.short_display ) then
		-- color the whole string or color just the descriptor.
		if ( self.data.color_display ) then 
			return crayon:Colorize(self:GetQuantityColorCode(quantity), self.loc.DAMAGEMETERS_QUANT[quantity].abbr .. "L") .. crayon:White("=" .. self:GetLeaderName(quantity))
		else
			return crayon:Yellow(self.loc.DAMAGEMETERS_QUANT[quantity].abbr .. "L") .. crayon:White("=" .. self:GetLeaderName(quantity))
		end
	else
		if ( self.data.color_display ) then 
			return crayon:Colorize(self:GetQuantityColorCode(quantity), self.loc.DAMAGEMETERS_QUANT[quantity].name .. "L") .. crayon:White("=" .. self:GetLeaderName(quantity))
		else
			return crayon:Yellow(self.loc.DAMAGEMETERS_QUANT[quantity].name .. "L") .. crayon:White("=" .. self:GetLeaderName(quantity))
		end
	end
end

function DamageMetersFu:GetLeaderName(quantity)
	if ( self.DMEnabled ) then
		for player, struct in ( self.rankTableGlobal and getglobal(self.rankTable) or self.rankTable ) do
			if (struct[quantity] == 1) then
				return player;
			end
		end
		
		return "-"
	end
end

-- Retrieve color codes from DM or builtin
function DamageMetersFu:GetQuantityColorCode(quantity) 
	-- Damage Meters default codes, + cff
	if ( self.data.use_dm_colors ) then
		return string.format("%02X%02X%02X",
			DamageMeters_quantityColor[quantity][1]*255,
			DamageMeters_quantityColor[quantity][2]*255,
			DamageMeters_quantityColor[quantity][3]*255)
	else
		return self.loc.DAMAGEMETERS_QUANT[quantity].color
	end
end

function DamageMetersFu:UpdateTooltip()
	-- DM is loaded, so click to show/hide the window. Otherwise, learn to install the right mods newbert.
	if (self.DMEnabled) then 
		tablet:SetHint(self.loc.HINT)
	else
		tablet:SetHint(self.loc.DAMAGEMETERS_MISSING_DESC)
	end
end

--
-- Utility Functions
--

function DamageMetersFu:PrintD(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg,0.50,0.50,1.00);
end

function DamageMetersFu:IsDamageMetersLoaded()
	local _, _, _, enabled, _, _, _ = GetAddOnInfo("DamageMeters")

	if (enabled == 1) then			-- We know Fubar is running, so check DamageMeters
		self:PrintD("DamageMeters: FuBaR Plugin Available")		-- for the plugin
		return true							-- return 1
	else							-- otherwise Fubar is running but DamageMeters is not
		self:PrintD("DamageMeters: DamageMetersNot Loaded.")		-- so let us know
		return false							-- and return 
	end
end

-- 
-- Access to damage meters functions/data.
--

-- Reset frame position
function DamageMetersFu:DMResetPos()
	if (self.DMEnabled) then
		DamageMeters_ResetPos()
	end
end

-- Pause parsing
function DamageMetersFu:DMTogglePause()
	if (self.DMEnabled) then
		DamageMeters_TogglePause()
	end
end

-- Retrieve the status of the pause state.
function DamageMetersFu:DMGetPauseState()
	if ( DamageMeters_pauseState == 1 ) then
		return true
	else 
		return false
	end
end

-- Clear current data
function DamageMetersFu:DMClear()
	if (self.DMEnabled) then
		DamageMeters_Clear()
	end
end

DamageMetersFu:RegisterForLoad()
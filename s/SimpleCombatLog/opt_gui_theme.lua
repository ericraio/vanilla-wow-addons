if not SimpleCombatLog then return end

local dewdrop = AceLibrary("Dewdrop-2.0")

local L = SimpleCombatLog.loc.theme

function SimpleCombatLog:SaveTheme(id, themeName)
	if not self.settings[id] -- No settings.
	or self.settings[id].theme then -- It is already a theme, noneed to save.
		return 
	end 
	
	local theme = self.settings[id]
	theme.theme = themeName
	
	self.themes[themeName] = theme
	self.themeDB[themeName] = theme
	
	self.settingDB[id] = themeName
		
end

function SimpleCombatLog:DeleteTheme(id, themeName)
	if not self.themes[themeName] then return end
	
	for id, setting in pairs(self.settingDB) do
		if setting == themeName then
			self:Print(string.format(L["Delete Theme Failed"], themeName, id) )
			return false
		end
	end
	
	self.themes[themeName] = nil
	self.themeDB[themeName] = nil

end

local function ThemeMenuSettings(self, id, level, value)
	if level == 1 then
	
		dewdrop:AddLine()
		
		dewdrop:AddLine(
			'text', L["Load Theme"],
			'tooltipTitle', L["Load Theme"],
			'tooltipText', L.tooltip_LoadTheme,
			'hasArrow', true,
			'notCheckable', true,
			'value', 'LoadTheme'
		)

		
		if self.settings[id] and not self:GetValue(id, 'theme') then
			dewdrop:AddLine(
				'text', L["Save Theme"],
			'tooltipTitle', L["Save Theme"],
			'tooltipText', L.tooltip_SaveTheme,
				'hasArrow', true,
				'notCheckable', true,
				'value', 'SaveTheme'
			)
		end
		
		dewdrop:AddLine(
			'text', L["Delete Theme"],
			'tooltipTitle', L["Delete Theme"],
			'tooltipText', L.tooltip_DeleteTheme,
			'hasArrow', true,
			'notCheckable', true,
			'value', 'DeleteTheme'
		)
	elseif level == 2 then
		if value == 'LoadTheme' then
			for themeName in pairs(self.themes) do
				local themeName = themeName
				local themeTable = themeTable
				local title
				if self.themeDB[themeName] then
					title = self:Colorize(themeName, self.defaultColors.dirty)
				else
					title = themeName
				end
					
				dewdrop:AddLine(
					'text', title,
					'func', function() self:SetTheme(id, themeName) end,
					'checked', (self:GetValue(id, 'theme') == themeName )
				)
			end			
		
		elseif value == 'SaveTheme' then
			for themeName, themeTable in pairs(self.themes) do
				local themeName = themeName
				local themeTable = themeTable
				dewdrop:AddLine(
					'text', themeName,
					'func', function() self:SaveTheme(id, themeName) end
				)
			end	
			dewdrop:AddLine(
				'text', L["Save As"],
				'hasArrow', true,
				'hasEditBox', true,
				'editBoxFunc', function(text) self:SaveTheme(id, text) end
			)
		
		elseif value == 'DeleteTheme' then
			for themeName, themeTable in pairs(self.themes) do
				local themeName = themeName
				local themeTable = themeTable
				dewdrop:AddLine(
					'text', themeName,
					'func', function() self:DeleteTheme(id, themeName) end
				)
			end
		end
	
	end
end

SimpleCombatLog.ThemeMenuSettings = ThemeMenuSettings

if not SimpleCombatLog then return end

local L = SimpleCombatLog.loc.gui

SimpleCombatLog.menuFunc = {}

local dewdrop = AceLibrary("Dewdrop-2.0")

function SimpleCombatLog:SetValue(id, field, value)
	if value == false then value = nil end
	if not self.settings[id] then
		self.settings[id] = {}
		self.settingDB[id] = self.settings[id]
	else
		if self.settings[id].theme then
			self.settings[id] = SimpleCombatLog.CopyTable({}, self.settings[id])
			self.settings[id].theme = nil
			self.settingDB[id] = self.settings[id]
		end
	end
	self.settings[id][field] = value
end

function SimpleCombatLog:ClearSettings(id, noRefresh)
	if not self.settings[id] then return end
	
	local colors = self.settings[id].colors
	local formats = self.settings[id].formats
	
	self.settings[id] = nil
	
	if colors or formats then
		self.settings[id] = {
			colors = colors,
			formats = formats,
		}
	end

	self.settingDB[id] = self.settings[id]
	
	if not noRefresh then
		self:RefreshSettings()
	end
	
end

function SimpleCombatLog:ShowSettingMenu(id)

	local tabFrame
	if type(id) == 'number' then
		tabFrame = getglobal("ChatFrame" .. id .. "Tab")	
	else
		tabFrame = getglobal(id)
	end
	
	if not tabFrame then return end

	if not dewdrop:IsRegistered(tabFrame) then
		dewdrop:Register(tabFrame, 
			'children', function(level, value) self:MenuSettings(id, level, value) end, 
			'dontHook', true
		)
	end


	dewdrop:Open(tabFrame)
end
	
function SimpleCombatLog:MenuSettings(id, level, value)

	if level == 1 then
		dewdrop:AddLine(
			'text', string.format( L.menuTitle, id),
			'isTitle', true,
			'notCheckable', true
		)
	end
	
	for i, func in pairs(self.menuFunc) do
		func(self, id, level, value)
	end

	if level == 1 then
		dewdrop:AddLine(
			'text', L.suppress,
			'tooltipTitle', L.suppress,
			'tooltipText', L.tooltip_suppress,
			'func', function() 
				self:SetValue(id, 'suppress', not self:GetValue(id, 'suppress') ) 
				self:RefreshSettings()
			end,
			'checked', self:GetValue(id, 'suppress')
		)
		dewdrop:AddLine(
			'text', L.colorSkill,
			'tooltipTitle', L.colorSkill,
			'tooltipText', L.tooltip_colorSkill,
			'func', function() 
				self:SetValue(id, 'colorspell', not self:GetValue(id, 'colorspell') ) 
				self:RefreshSettings()
			end,
			'checked', self:GetValue(id, 'colorspell')
		)
		dewdrop:AddLine(
			'text', L.colorEvent,
			'tooltipTitle', L.colorEvent,
			'tooltipText', L.tooltip_colorEvent,
			'func', function()
				self:SetValue(id, 'colorEvent', not self:GetValue(id, 'colorEvent') )
				self:RefreshSettings()
			end,
			'checked', self:GetValue(id, 'colorEvent')
		)
		dewdrop:AddLine(
			'text', L.greaterResize,
			'tooltipTitle', L.greaterResize,
			'tooltipText', L.tooltip_greaterResize,
			'func', function() 
				self:SetValue(id, 'resize', not self:GetValue(id, 'resize') ) 
				self:RefreshSettings()
			end,
			'checked', self:GetValue(id, 'resize')
		)
		dewdrop:AddLine()
		
		dewdrop:AddLine(
			'text', L.clearSettings,
			'tooltipTitle', L.clearSettings,
			'tooltipText', L.tooltip_clearSettings,
			'notCheckable', true,
			'func', function() self:ClearSettings(id) end
		)
				

	end

	if self.ThemeMenuSettings then
		self:ThemeMenuSettings(id, level, value)
	end

end



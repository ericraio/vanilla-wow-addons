if not SimpleCombatLog then return end

local dewdrop = AceLibrary("Dewdrop-2.0")

local L = SimpleCombatLog.loc.filter

local sourceOrVictimArray = { 'source', 'victim' }
local isSourceArray = { true, false }

-- Available type filters.
SimpleCombatLog.typeFilters = {
	'hit', 'heal', 'miss', 'cast', 'gain', 'drain', 'leech', 'dispel', 
	'buff', 'debuff', 'fade', 'interrupt', 'death', 'environment', 'extraattack', 'enchant', 
}

-- Available name filters.
SimpleCombatLog.nameFilters = {
	'player', 'pet', 'party', 'raid', 'target', 'targettarget', 'other',
}

function SimpleCombatLog:SetFilter(id, filterType, nameFilter, isSource, value)
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

	
	if not self.settings[id].filters then
		self.settings[id].filters = {}
	end
	
	if not self.settings[id].filters[filterType] then
		self.settings[id].filters[filterType] = {}
	end
	
	local source
	if isSource then source = 1 else source = 2 end
	local flag = self.filterFlags[source][nameFilter]
	
	self.settings[id].filters[filterType][flag] = value
end


function SimpleCombatLog:SetAllTypeFilters(id, nameFilter, isSource, value)
	for i, type in pairs(self.typeFilters) do
		self:SetFilter(id, type, nameFilter, isSource, value)
	end
end

function SimpleCombatLog:IsAllTypeFiltersChecked(id, nameFilter, isSource)
	
	for i, typeFilter in pairs(self.typeFilters) do
		if not self:GetFilter(id, typeFilter, nameFilter, isSource) then
			return false
		end
	end
	return true
	
end

local function UpdateFilterTable(self, id, level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["Filters"],
			'hasArrow', true,
			'value', 'filter',
			'notCheckable', true
		)
	elseif level == 2 and value == 'filter' then
		
		self.currMenuType = 'filter'
		
		dewdrop:AddLine(
			'text', L["Type Filters"],
			'isTitle', true,
			'notCheckable', true
		)
		
		dewdrop:AddLine(
			'text', L["AllFilter"],
			'hasArrow', true,
			'value', 'AllFilter',
			'tooltipTitle', L["AllFilter"],
			'tooltipText', L.typeTooltip["AllFilter"],
			'notCheckable', true
		)
					
		for i, v in pairs(self.typeFilters) do
			dewdrop:AddLine(
				'text', L[v],
				'hasArrow', true,
				'tooltipTitle', L[v],
				'tooltipText', L.typeTooltip[v],
				'value', v,
				'notCheckable', true
			)
		end	
	elseif level == 3 and self.currMenuType == 'filter' then
	
		if value == 'AllFilter' then
			dewdrop:AddLine(
				'text', string.format(L["Name Menu Title"], L["AllFilter"]),
				'isTitle', true,
				'notCheckable', true
			)
			for i, isSource in pairs(isSourceArray) do
				local isSource = isSource
				local sourceOrVictim = sourceOrVictimArray[i]
				dewdrop:AddLine(
					'text', L[sourceOrVictim],
					'isTitle', true
				)
				for i, nameFilter in pairs(self.nameFilters) do
					local nameFilter = nameFilter
					local state	= nil -- 0: none, 1: partial, 2: all
					for j, type in pairs(self.typeFilters) do
						local checked = self:GetFilter(id, type, nameFilter, isSource)
						if not state then 
							if checked then 
								state = 2
							else
								state = 0
							end
						elseif state == 0 and checked then
							state = 1
						elseif state == 2 and not checked then
							state = 1
						end
					end
					local checked, checkIcon, func
					if state == 0 then
						checked = false
						checkIcon = nil					
						func = function() self:SetAllTypeFilters(id, nameFilter, isSource, true) end
					elseif state == 1 then
						checked = true
						checkIcon = "Interface\\Buttons\\UI-CheckBox-Check-Disabled"
						func = function() self:SetAllTypeFilters(id, nameFilter, isSource, true) end
					else
						checked = true
						checkIcon = nil
						func = function() self:SetAllTypeFilters(id, nameFilter, isSource, nil) end
					end
					dewdrop:AddLine(
						'text', L[nameFilter],
						'checked', checked,
						'checkIcon', checkIcon,
						'func', func
					)
				end
			end
		else

			local typeFilter = value
			dewdrop:AddLine(
				'text', string.format(L["Name Menu Title"], L[typeFilter]),
				'isTitle', true,
				'notCheckable', true
			)
			
			for i, isSource in pairs(isSourceArray) do
				local isSource = isSource
				local sourceOrVictim = sourceOrVictimArray[i]
				dewdrop:AddLine(
					'text', L[sourceOrVictim],
					'isTitle', true
				)
				for i, nameFilter in pairs(self.nameFilters) do
					local nameFilter = nameFilter
					dewdrop:AddLine(
						'text', L[nameFilter],
						'func', function() self:SetFilter(id, typeFilter, nameFilter, isSource, not self:GetFilter(id, typeFilter, nameFilter, isSource) )end,
						'checked', self:GetFilter(id, typeFilter, nameFilter, isSource)
					)				
				end			
			end

		end
	end
end


if SimpleCombatLog.menuFunc then
	SimpleCombatLog.menuFunc[1] = UpdateFilterTable
end


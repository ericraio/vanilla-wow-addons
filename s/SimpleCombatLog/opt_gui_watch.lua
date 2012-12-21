if not SimpleCombatLog then return end

local dewdrop = AceLibrary("Dewdrop-2.0")

local L = SimpleCombatLog.loc.watch

local watchTypes = { "source", "victim", "skill" }

function SimpleCombatLog:AddWatch(id, watchType, keyword)
	if keyword == "%t" then keyword = UnitName('target') end

	if not keyword or keyword == "" then return end	
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

	
	if not self.settings[id].watchList then
		self.settings[id].watchList = {}
	end
	
	if not self.settings[id].watchList[watchType] then
		self.settings[id].watchList[watchType] = {}
	end
	
	self.settings[id].watchList[watchType][keyword] = true
end

function SimpleCombatLog:SetWatch(id, watchType, oldKeyword, newKeyword)
	if newKeyword == "%t" then newKeyword = UnitName('target') end
	if not newKeyword then return end
	if newKeyword ~= "" then
		self.settings[id].watchList[watchType][newKeyword] = true
	end
	self.settings[id].watchList[watchType][oldKeyword] = nil
end

local function UpdateWatchOptionsTable(self, id, level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["Watches"],
				'tooltipTitle', L["Watches"],
				'tooltipText', L.tooltip_Watches,
			'notCheckable', true,
			'hasArrow', true,
			'value', 'watch'
		)
	elseif level == 2 and value == 'watch' then
	
		for i, watchType in pairs(watchTypes) do
			local watchType = watchType
			dewdrop:AddLine(
				'text', L.title[watchType],
				'isTitle', true,
				'notCheckable', true
			)
			watchList = self:GetWatchList(id, watchType)
			if watchList then
				for keyword in pairs(watchList) do
					local keyword = keyword
					dewdrop:AddLine(
						'text', keyword,
						'hasArrow', true,
						'notCheckable', true,
						'hasEditBox', true,
						'editBoxText', keyword,
						'editBoxFunc', function(text) self:SetWatch(id, watchType, keyword, text) end
					)
				end
			end
			dewdrop:AddLine(
				'text', L.add[watchType],
				'tooltipTitle', L.add[watchType],
				'tooltipText', L.tooltip[watchType],
				'hasArrow', true,
				'notCheckable', true,
				'hasEditBox', true,
				'editBoxFunc', function(text) self:AddWatch(id, watchType, text) end
			)
		end
	end
end

if SimpleCombatLog.menuFunc then
	SimpleCombatLog.menuFunc[5] = UpdateWatchOptionsTable
end

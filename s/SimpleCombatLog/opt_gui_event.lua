if not SimpleCombatLog then return end

local dewdrop = AceLibrary("Dewdrop-2.0")

local L = SimpleCombatLog.loc.event


function SimpleCombatLog:SetEvent(id, event, flag)
	if flag == false then flag = nil end
	
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

	
	if not self.settings[id].events then
		self.settings[id].events = {}
	end
	
	self.settings[id].events[event] = flag
	
end


local function LoadMenuChatTypeGroups(self, id, title, chatTypeGroups)
	dewdrop:AddLine(
		'text', title,
		'isTitle', true		
	)
	
	for i, v in pairs(chatTypeGroups) do
		local eventName = ChatTypeGroup[v][1]
		local eventDesc = getglobal(eventName)
		dewdrop:AddLine(
			'text', eventDesc,
			'func', function(id, event) 
				self:SetEvent(id, event, not self:GetEvent(id, event) )
				self:RefreshSettings()
			end,
			'arg1', id,
			'arg2', eventName,
			'checked', self:GetEvent(id, eventName)
		)
	end		
end


local function UpdateEventOptionsTable(self, id, level, value)
	if level == 1 then
			
		dewdrop:AddLine(
			'text', L["Events"],
			'tooltipTitle', L["Events"],
			'tooltipText', L.tooltip_Events,
			'hasArrow', true,
			'value', 'event',
			'notCheckable', true
		)		

		
	elseif level == 2 and value == 'event' then
	
		self.currMenuType = 'event'
		
		dewdrop:AddLine(
			'text', L["Events"],
			'isTitle', true,
			'notCheckable', true
		)				
		-- I decided not to bother messing with the event groups, just use Blizzard's groupings.
		dewdrop:AddLine(
			'text', COMBAT_MESSAGES,
			'notCheckable', true,
			'hasArrow', true,
			'value', COMBAT_MESSAGES
		)		
		dewdrop:AddLine(
			'text', SPELL_MESSAGES,
			'notCheckable', true,
			'hasArrow', true,
			'value', SPELL_MESSAGES
		)		
		dewdrop:AddLine(
			'text', SPELL_OTHER_MESSAGES,
			'notCheckable', true,
			'hasArrow', true,
			'value', SPELL_OTHER_MESSAGES
		)		
		dewdrop:AddLine(
			'text', PERIODIC_MESSAGES,
			'notCheckable', true,
			'hasArrow', true,
			'value', PERIODIC_MESSAGES
		)		
	
	elseif level == 3 and self.currMenuType == 'event' then
		if value == COMBAT_MESSAGES then
			LoadMenuChatTypeGroups(self, id, COMBAT_MESSAGES, CombatLogMenuChatTypeGroups)
		elseif value == SPELL_MESSAGES then
			LoadMenuChatTypeGroups(self, id, SPELL_MESSAGES, SpellLogMenuChatTypeGroups)
		elseif value == SPELL_OTHER_MESSAGES then
			LoadMenuChatTypeGroups(self, id, SPELL_OTHER_MESSAGES, SpellLogOtherMenuChatTypeGroups)
		elseif value == PERIODIC_MESSAGES then
			LoadMenuChatTypeGroups(self, id, PERIODIC_MESSAGES, PeriodicLogMenuChatTypeGroups)
		end
	
	end

end


if SimpleCombatLog.menuFunc then
	SimpleCombatLog.menuFunc[2] = UpdateEventOptionsTable
end

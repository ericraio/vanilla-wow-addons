local metro = AceLibrary("Metrognome-2.0")
local tablet = AceLibrary("Tablet-2.0")

CombatTimeFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0")

function CombatTimeFu:OnInitialize()
		self.combatStart = 0
		self.combatEnd = 0
		self.inCombat = false
		
		self.name = "CombatTimeFu"
end

function CombatTimeFu:OnEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnPlayerRegenDisabled")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerRegenEnabled");
end

function CombatTimeFu:OnDisable()
	self:UnRegisterEvent("PLAYER_REGEN_DISABLED")
	self:UnRegisterEvent("PLAYER_REGEN_ENABLED")
	self:UnRegisterEvent("PLAYER_ENTERING_WORLD");
end

-- Out of combat
function CombatTimeFu:OnPlayerRegenEnabled()
	self.combatEnd = GetTime()
	self.inCombat = false
	self:Update()

	-- Disable updating, don't need it while idle
	metro:Unregister(self.name)
end

	-- In combat
function CombatTimeFu:OnPlayerRegenDisabled()
	self.combatStart = GetTime()
	self.combatEnd = 0
	self.inCombat = true

	-- Start updating while in combat
	metro:Register(self.name, self.Update, 0.1, self)
	metro:Start(self.name)
end

function CombatTimeFu:GetCurrentCombatTime()
	local sec = 0
	if self.inCombat then
		sec = GetTime()-self.combatStart
	else
		sec = self.combatEnd-self.combatStart
	end
	if(sec < 0) then 
		sec = 0
	end
	local s = math.floor(sec)
	local frac = (sec - s)*100
	local m = math.floor(sec/60)
	sec = math.mod(sec, 60)
	return string.format("%d:%02d:%02d", m, sec, frac)
end

function CombatTimeFu:OnTextUpdate()
	if self.inCombat == true then
		self:SetText("Combat: |cffff0000".. self:GetCurrentCombatTime() .."|r")
	else
		if self.combatEnd == 0 then
			self:SetText("Combat: |cff00ff00No|r")
		else
			self:SetText("Combat: |cff00ff00".. self:GetCurrentCombatTime() .."|r")
		end
	end
end

function CombatTimeFu:OnTooltipUpdate()
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
		'text', "Combat status",
		'text2', self.inCombat and "|cffff0000In combat|r" or "|cff00ff00Not in combat|r"
	)
	cat:AddLine(
		'text', "Combat time",
		'text2', self.combatStart > 0 and self:GetCurrentCombatTime() or "None"
	)
end
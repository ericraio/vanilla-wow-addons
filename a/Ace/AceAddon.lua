
-- Class creation
AceAddon = AceModule:new()
-- Compatibility reference, deprecated use
AceAddonClass = AceAddon


--[[--------------------------------------------------------------------------
  Register For Load With AceState
-----------------------------------------------------------------------------]]

function AceAddon:RegisterForLoad()
	ace:RegisterForLoad(self)
end


--[[--------------------------------------------------------------------------
  Addon Enabling/Disabling
-----------------------------------------------------------------------------]]

function AceAddon:EnableAddon()
	if( (not self.disabled) or (not self.Enable) ) then return end

	self.disabled = FALSE
	if( self.db ) then self.db:set(self.profilePath, "disabled") end
	self:Enable()
	self:TriggerEvent(strupper(self.name).."_ENABLED")
	return TRUE
end
-- Temporary map to support older addon use
AceAddon.CmdEnable = AceAddon.EnableAddon

function AceAddon:DisableAddon(nomsg)
	if( self.disabled or (not self.Enable) ) then return end

	self.disabled = TRUE
	if( self.db ) then self.db:set(self.profilePath, "disabled", TRUE) end
	if( self.Disable ) then self:Disable() end
	self:UnregisterAllEvents()
	self:UnhookAll()
	self:UnhookAllScripts()
	self:TriggerEvent(strupper(self.name).."_DISABLED")
	return TRUE
end
-- Temporary map to support older addon use
AceAddon.CmdDisable = AceAddon.DisableAddon

function AceAddon:ToggleStandBy()
	if( self.disabled ) then
		self:EnableAddon()
	else
		self:DisableAddon()
	end
	self.cmd:result(ACE_MAP_STANDBY[self.disabled or 0])
end

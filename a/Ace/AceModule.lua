
-- Class creation
AceModule = AceCore:new()
-- Compatibility reference, deprecated use
AceModuleClass = AceModule


--[[--------------------------------------------------------------------------
  Event Handling
-----------------------------------------------------------------------------]]

function AceModule:RegisterEvent(event, method)
	ace.event:RegisterEvent(self, event, method)
end

function AceModule:UnregisterEvent(event)
	ace.event:UnregisterEvent(self, event)
end

function AceModule:UnregisterAllEvents()
	ace.event:UnregisterAllEvents(self)
end

function AceModule:TriggerEvent(...)
	ace.event:TriggerEvent(unpack(arg))
end


--[[--------------------------------------------------------------------------
   Function Hooking  & Script Hooking
-----------------------------------------------------------------------------]]

ace.hook:Embed(AceModule)
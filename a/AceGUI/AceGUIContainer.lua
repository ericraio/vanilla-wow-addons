
--[[--------------------------------------------------------------------------------
  Definition
-----------------------------------------------------------------------------------]]

AceGUIContainer = AceGUIElement:new()

function AceGUIContainer:Initialize(def, handler)
	self.handler = handler
	self._def = def
	self:BuildElements()
	return self
end

function AceGUIContainer:GetName()
	return self._def.name or ""
end

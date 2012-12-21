
-- Class creation
AceEvent = AceCore:new({registry={},frame=AceEventFrame})

-- This method is for generating custom events. They have to processed separately or
-- the event variables may clash with those of the real events.
function AceEvent:TriggerEvent(event, ...)
	if( self.registry[event] ) then
		for obj, method in self.registry[event] do
			if( obj[method] ) then obj[method](obj, unpack(arg)) end
		end
	end
end

function AceEvent:EventHandler()
	if( event and self.registry[event] ) then
		for obj, method in self.registry[event] do
			if( obj[method] ) then obj[method](obj) end
		end
	end
end

function AceEvent:RegisterEvent(obj, event, method)
	if( not self.registry[event] ) then
		self.registry[event] = {}
		self.frame:RegisterEvent(event)
	end

	self.registry[event][obj] = (method or event)
end

function AceEvent:UnregisterEvent(obj, event)
	if( self.registry[event] and self.registry[event][obj] ) then
		self.registry[event][obj] = nil
	end
end

function AceEvent:UnregisterAllEvents(obj)
	for event in self.registry do
		self:UnregisterEvent(obj, event)
	end
end

ace.event = AceEvent

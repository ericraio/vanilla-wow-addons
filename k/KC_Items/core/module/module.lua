local locals = KC_ITEMS_LOCALS

KC_ItemsModule = AceModule:new();

-- Module DB Closures. These use the addon's (KC_Items's) profilePath to ensure
-- that the proper profile will always get used.

function KC_ItemsModule:GetOpt(path, var)
	if (not var) then var = path; path = nil; end

	if (self.db) then
		local profilePath = path and {self.app.profilePath, path} or self.app.profilePath		
		return self.db:get(profilePath, var)
	else
		return self.app:GetOpt(path, var)		
	end
end

function KC_ItemsModule:SetOpt(path, var, val)
	if (not var) then val = var; var = path; path = nil; end

	if (self.db) then
		local profilePath = path and {self.app.profilePath, path} or self.app.profilePath		
		return self.db:set(profilePath, var, val)
	else
		return self.app:SetOpt(path, var, val)		
	end
end

function KC_ItemsModule:TogOpt(path, var)
	if (not var) then val = var; var = path; path = nil; end

	if (self.db) then
		local profilePath = path and {self.app.profilePath, path} or self.app.profilePath		
		return self.db:toggle(profilePath, var)
	else
		return self.app:TogOpt(path, var)		
	end
end

function KC_ItemsModule:ClearOpt(path, var)
	if (not var) then var = path; path = nil; end

	if (self.db) then
		local profilePath = path and {self.app.profilePath, path} or self.app.profilePath		
		return self.db:set(profilePath, var)
	else
		return self.app:ClearOpt(path, var)		
	end
end


-- Command Reporting Closures

function KC_ItemsModule:Msg(...)
	self.app:Msg(unpack(arg))
end

function KC_ItemsModule:Result(text, val, map)
	self.app:Result(text, val, map)
end

function KC_ItemsModule:TogMsg(var, text)
	local val = self:TogOpt(var)
	self.app:Result(text, val, locals.maps.onOff)
	return val
end

function KC_ItemsModule:Error(...)
	self.app:Error(unpack(arg))
end


-- Enabling/Disabling

function KC_ItemsModule:Register()
	self.disabled = TRUE
	self:RegisterEvent("KC_ITEMS_LOADED")
	self:RegisterEvent("KC_ITEMS_ENABLED")
end

function KC_ItemsModule:KC_ITEMS_LOADED()
	self:debug("KC_Items Loaded")
	if( self.db ) then self.db:Initialize() end
end

function KC_ItemsModule:KC_ITEMS_ENABLED()
	self:CheckEnable()
	self:RegisterEvent("KC_ITEMS_DISABLED")
	self:debug("KC_Items Enabled")
end

function KC_ItemsModule:KC_ITEMS_DISABLED()
	self:Disable()
	self:debug("KC_Items Disabled")
end

function KC_ItemsModule:KC_ITEMS_MODULE_ENABLED()
	if( self.disabled and self:CheckDependencies() ) then self:CheckEnable() end
end

function KC_ItemsModule:KC_ITEMS_MODULE_DISABLED()
	if( self.disabled ) then return end
	if( not self:CheckDependencies() ) then self:Disable() end
end

function KC_ItemsModule:CheckDependencies()
	if( not self.dependencies ) then return TRUE end

	local _, dep
	for _, dep in self.dependencies do
		if( (not self.app.modules[dep]) or
			(not self.app:ModEnabled(self.app.modules[dep]))
		) then
			return
		end
	end

	return TRUE
end

function KC_ItemsModule:CheckEnable(force)
	if( (not self.app.disabled) and (self.app:ModEnabled(self) or force) and
		self:CheckDependencies()
	) then
		self:Enable()
		self.disabled = FALSE
		self:TriggerEvent("KC_ITEMS_MODULE_ENABLED")
		self:RegisterEvent("KC_ITEMS_DISABLED")
		self:RegisterEvent("KC_ITEMS_MODULE_DISABLED")
		return TRUE
	end
end


-- Should be overridden
function KC_ItemsModule:Enable() end

function KC_ItemsModule:Disable()
	self:UnregisterAllEvents()
	self:UnhookAll()
	self.disabled = TRUE
	self:TriggerEvent("KC_ITEMS_MODULE_DISABLED")
	self:RegisterEvent("KC_ITEMS_ENABLED")
	self:RegisterEvent("KC_ITEMS_MODULE_ENABLED")
end


-- Common Module Command Handlers

function KC_ItemsModule:Toggle()
	if( self.app:ModEnabled(self) ) then
		self.app:SetModState(self, FALSE)
		self:Disable()
		self:Result(self.name, nil, locals.maps.enabled)
	elseif( self:CheckEnable(TRUE)) then
		self.app:SetModState(self, TRUE)
		self:Result(self.name, TRUE, locals.maps.enabled)
	else
		self:Msg(format(locals.err.modEnable, self.name))
		self:Msg(format(locals.err.needs, self.name, table.concat(self.dependencies, ", ")))
	end
end
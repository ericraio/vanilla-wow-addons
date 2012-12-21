--[[---------------------------------------------------------------------------------
  AceHook Library by Cladhaire (cladhaire@gmail.com)
  
  This first section is the standard embedded library stub declaration.  This code
  manages the versioning between different instances of the AceHooks library.
  
  See http://www.iriel.org/wow/addondev/embedlibrary1.html for more information
----------------------------------------------------------------------------------]]

local protFuncs = {
	CameraOrSelectOrMoveStart = true, 	CameraOrSelectOrMoveStop = true,
	TurnOrActionStart = true,			TurnOrActionStop = true,
	PitchUpStart = true,				PitchUpStop = true,
	PitchDownStart = true,				PitchDownStop = true,
	MoveBackwardStart = true,			MoveBackwardStop = true,
	MoveForwardStart = true,			MoveForwardStop = true,
	Jump = true,						StrafeLeftStart = true,
	StrafeLeftStop = true,				StrafeRightStart = true,
	StrafeRightStop = true,				ToggleMouseMove = true,
	ToggleRun = true,					TurnLeftStart = true,
	TurnLeftStop = true,				TurnRightStart = true,
	TurnRightStop = true,
}

--[[---------------------------------------------------------------------------------
  AceHooks Library implementation.
 -----------------------------------------------------------------------------------]]

local MAJOR_VERSION = "1.4"
local MINOR_VERSION = 2006042401
local AceHook = {}

-- This is a compatability change for AceHook 1.3 upgrade
if AceHookLib and not AceHookLib.NewVersion then
	function AceHookLib:NewVersion(version, minor)
		local versionData = self.versions[version]
		if not versionData or versionData.minor < minor then return true end
	end
end

-- Only declare this class if necessary
if not AceHookLib or AceHookLib:NewVersion(MAJOR_VERSION, MINOR_VERSION) then
	
	function AceHook:GetLibraryVersion()
		return MAJOR_VERSION, MINOR_VERSION
	end
	
	function AceHook:LibActivate(stub, oldLib, oldList)
		local maj, min = self:GetLibraryVersion()
	
		if oldLib then 
			for i,namespace in pairs(oldLib.embedList or {}) do
				self:Embed(namespace)
			end
		end
		
		-- Return nil to force the instance copy.
		return nil
	end
	
	function AceHook:HookDebug(msg)
		local maj,min = MAJOR_VERSION, MINOR_VERSION
		if DEFAULT_CHAT_FRAME then
			DEFAULT_CHAT_FRAME:AddMessage("[|cffffff00AceHook "..maj.."|r] " .. tostring(msg))
		else
			print("[AceHook "..maj.."] " .. tostring(msg))
		end
	end
	
	--[[----------------------------------------------------------------------
		AceHook:Hook
			self:Hook("functionName", ["handlerName" | handler])
			self:Hook(ObjectName, "Method", ["Handler" | handler])
	-------------------------------------------------------------------------]]		
	function AceHook:Hook(arg1, arg2, arg3)
		if not self.Hooks then self.Hooks = {} end
		if type(arg1)== "string" then
			if protFuncs[arg1] then
				local name = self.name
				
				if not name then
					local g = getfenv(0)
					
					for k,v in pairs(g) do
						if v == self then
							name = k
							break
						end
					end
				end
				
				if name then 
					error(tostring(name) .. " tried to hook " .. arg1 .. ", which is a Blizzard protected function.",3)
				else
					self:HookDebug("An Addon tried to hook " .. arg1 .. ", which is a Blizzard protected function.")
				end
			else
				self:HookFunc(arg1, arg2)
			end
		else
			self:HookMeth(arg1, arg2, arg3)
		end
	end
	
	function AceHook:HookScript(arg1, arg2, arg3)
		if not self.Hooks then self.Hooks = {} end
		
		self:HookMeth(arg1, arg2, arg3, true)
	end
	
	--[[----------------------------------------------------------------------
		AceHook:IsHooked()
			self:Hook("functionName")
			self:Hook(ObjectName, "Method")
			
			Returns whether or not the given function is hooked in the current	
			namespace.  A hooked, but inactive function is considered NOT
			hooked in this context.
	-------------------------------------------------------------------------]]		
	function AceHook:IsHooked(obj, method)
		if method and obj then
			if self.Hooks and self.Hooks[obj] and self.Hooks[obj][method] and self.Hooks[obj][method].active then
				return true
			end
		else
			if self.Hooks and self.Hooks[obj] and self.Hooks[obj].active then 
				return true
			end
		end
		
		return false
	end
	
	--[[----------------------------------------------------------------------
		AceHook:Unhook
			self:Unhook("functionName")
			self:Unhook(ObjectName, "Method")
	-------------------------------------------------------------------------]]		
	function AceHook:Unhook(arg1, arg2)
		if type(arg1) == "string" then
			self:UnhookFunc(arg1)
		else
			self:UnhookMeth(arg1, arg2)
		end
	end			
	
	--[[----------------------------------------------------------------------
		AceHook:UnhookAll - Unhooks all active hooks from the calling source
	-------------------------------------------------------------------------]]		
	function AceHook:UnhookAll(script)
		if not self.Hooks then return end
		for key, value in pairs(self.Hooks) do
			if type(key) == "table" then
				for method in pairs(value) do
					if (self.Hooks[key][method].script == script) then
						self:Unhook(key, method)						
					end
				end
			else
				self:Unhook(key)
			end
		end
	end
	
	function AceHook:UnhookAllScripts()
		self:UnhookAll(true)
	end
		
	--[[----------------------------------------------------------------------
		AceHook:Print - Utility function for HookReport, for embedding
		AceHook:HookReport - Lists registered hooks from this source
	-------------------------------------------------------------------------]]		
	
	function AceHook:HookReport()
		self:HookDebug("This is a list of all active hooks for this object:")
		if not self.Hooks then self:HookDebug("No registered hooks.") return end
	
		for key, value in pairs(self.Hooks) do
			if type(key) == "table" then
				for method in pairs(value) do
					self:HookDebug("key: "..tostring(key).." method: "..tostring(method)..((self.Hooks[key][method].active and "|cff00ff00 Active" or "|cffffff00 Inactive")))
				end
			else
				self:HookDebug("key: " .. tostring(key) .. " value: " .. tostring(value) .. ((self.Hooks[key].active and "|cff00ff00 Active" or "|cffffff00 Inactive")))
			end
		end
	end
	
	--[[----------------------------------------------------------------------
		AceHook:CallHook("functionName" [, arg1, arg2, arg3, ...])
		AceHook:CallHook(ObjectName, "Method" [, arg1, arg2, arg3, ...])
	
		DEPRECATED: This function has been deprecated and replaced by a direct
		call from the self.Hooks table.  This avoids function calls and decreases
		the overhead from a CallHook.  The new wrapper functions limit any
		CallHook to 20 arguments.  The new forms are as follows:
		
		self.Hooks.functionName.orig(arg1, arg2, arg3)
		self.Hooks[ObjectName].MethodName.orig(ObjectName, arg1, arg2, arg3)
	-------------------------------------------------------------------------]]		
	
	function AceHook:CallHook(obj,meth,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		if type(obj) == "string" then
			-- Function Call
			if not self.Hooks or not self.Hooks[obj] then
				self:HookDebug( "Attempt to CallHook when no hook exists for " .. obj)
				return
			else
				local func = obj
				return self.Hooks[func].orig(meth,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
			end
		else
			if not self.Hooks[obj] or not self.Hooks[obj][meth] then
				self:HookDebug( "Attempt to CallHook when no hook exists for " .. tostring(meth))
				return
			else
				return self.Hooks[obj][meth].orig(obj,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
			end
		end
	end
	
	--[[----------------------------------------------------------------------
		AceHook:HookFunc - internal method.
		o You can only hook each function once from each source. 
		o If there is an inactive hook for this func/handler pair, we reactivate it
		o If there is an inactive hook for another handler, we error out.
		o Looks for handler as a method of the calling class, error if not available
		o If handler is a function, it just uses it directly through the wrapper
	-------------------------------------------------------------------------]]		
	function AceHook:HookFunc(func, handler)
		local f = getglobal(func)
		
		if not f or type(f) ~= "function" then 
			self:HookDebug("Attempt to hook a non-existant function '"..func.."'.",3)
			return
		end
		
		if not handler then handler = func end
	
		if self.Hooks[func] then
			-- We have an active hook from this source.  Don't multi-hook
			if self.Hooks[func].active then
				self:HookDebug( func .. " already has an active hook from this source.")
				return
			end
			-- The hook is inactive, so reactivate it
			if self.Hooks[func].handler == handler then 
				self.Hooks[func].active = true
				return
			else 
				error( "There is a stale hook for " .. func .. " can't hook or reactivate.",3)
			end
		end	
		
		local methodHandler
	
		if type(handler) == "string" then
			if self[handler] then
				methodHandler = true
			else
				error( "Could not find the the handler " ..handler.." when hooking function " .. func,3)
			end
		elseif type(handler) ~= "function" then
			error( "Could not find the handler you supplied when hooking " .. func,3)
		end
	
		self.Hooks[func] = {}
		self.Hooks[func].orig = f
		self.Hooks[func].active = true
		self.Hooks[func].handler = handler
		self.Hooks[func].func = self:_getFunctionHook(func, handler, methodHandler)
		setglobal(func, self.Hooks[func].func)
	end
	
	--[[----------------------------------------------------------------------
		AceHook:UnhookFunc - internal method
		o If you attempt to unhook a function that has never been hooked, or to unhook in a 
		  system that has never had a hook before, the system will error with a stack trace
		o If we own the global function, then put the original back in its place and remove
		  all references to the Hooks[func] structure.
		o If we don't own the global function (we've been hooked) we deactivate the hook, 
		  forcing the handler to passthrough.
	-------------------------------------------------------------------------]]		
	function AceHook:UnhookFunc(func)
		if not self.Hooks or not self.Hooks[func] then 
			self:HookDebug("Tried to unhook '" ..func .. "' which is not currently hooked.")
			return
		end
		if self.Hooks[func].active then
			-- See if we own the global function
			if getglobal(func) == self.Hooks[func].func then
				setglobal(func, self.Hooks[func].orig)
				self.Hooks[func] = nil
				-- Magically all-done
			else
				self.Hooks[func].active = nil
			end
		end
	end
	
	--[[----------------------------------------------------------------------
		AceHook:_getFunctionHook- internal method
	-------------------------------------------------------------------------]]		
	
	function AceHook:_getFunctionHook(func, handler, methodHandler)
		if methodHandler then
			-- The handler is a method, need to self it
			return 
				function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					if self.Hooks[func].active then 
						return self[handler](self, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					else
						return self.Hooks[func].orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					end
				end
		else
			-- The handler is a function, just call it
			return 
				function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					if self.Hooks[func].active then 
						return handler(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					else
						return self.Hooks[func].orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					end
				end	
		end
	end
	
	--[[----------------------------------------------------------------------
		AceHook:HookMeth - Takes an optional fourth argument
		o script - Signifies whether this is a script hook or not
	-------------------------------------------------------------------------]]		
	
	function AceHook:HookMeth(obj, method, handler, script)
		if not handler then handler = method end
		if (not obj or type(obj) ~= "table") then
			error("The object you supplied could not be found, or isn't a table.", 3)
		end
		
		if self.Hooks[obj] and self.Hooks[obj][method] then
			-- We have an active hook from this source.  Don't multi-hook
			if self.Hooks[obj][method].active then
				self:HookDebug( method .. " already has an active hook from this source.")
				return
			end
			-- The hook is inactive, so reactivate it.
			if self.Hooks[obj][method].handler == handler then
				self.Hooks[obj][method].active = true
				return
			else
				error( "There is a stale hook for " .. method .. " can't hook or reactivate.",3)
			end
		end
		-- We're clear to try the hook, let's make some checks first
		local methodHandler
		if type(handler) == "string" then
			if self[handler] then
				methodHandler = true
			else
				error( "Could not find the handler ("..handler..") you supplied when hooking method " .. method,3)
			end
		elseif type(handler) ~= "function" then
			error( "Could not find the handler you supplied when hooking method " .. method,3)
		end
		-- Handler has been found, so now try to find the method we're trying to hook	
		local orig, setscript
		-- Script
		if script then
			if not obj.GetScript then
				error("The object you supplied does not have a GetScript method.", 3)
			end
			if not obj:HasScript(method) then
				error("The object you supplied doesn't allows the " .. method .. " method.", 3)
			end
			-- Sometimes there is not a original function for a script.
			orig = obj:GetScript(method) or function () end
		-- Method
		else
			orig = obj[method] 
		end
		if not orig then
			error("Could not find the method or script ("..method..") you are trying to hook.",3)
		end
		if not self.Hooks[obj] then self.Hooks[obj] = {} end
		self.Hooks[obj][method] = {}	
		self.Hooks[obj][method].orig = orig
		self.Hooks[obj][method].active = true
		self.Hooks[obj][method].handler = handler
		self.Hooks[obj][method].script = script
		self.Hooks[obj][method].func = self:_getMethodHook(obj, method, handler, methodHandler)
		if script then
			obj:SetScript(method, self.Hooks[obj][method].func)
		else
			obj[method] = self.Hooks[obj][method].func
		end
	end	
	
	--[[----------------------------------------------------------------------
		AceHook:UnhookMeth - Internal method
		o If you attempt to unhook a method that has never been hooked, or to unhook in a 
		  system that has never had a hook before, the system will error with a stack trace
		o If we own the global method, then put the original back in its place and remove
		  all references to the Hooks[obj][method] structure.
		o If we don't own the global method (we've been hooked) we deactivate the hook, 
		  forcing the handler to passthrough.
	-------------------------------------------------------------------------]]		
	function AceHook:UnhookMeth(obj, method)
		if not self.Hooks or not self.Hooks[obj] or not self.Hooks[obj][method] then 
			self:HookDebug("Attempt to unhook a method ("..method..") that is not currently hooked.")
			return
		end
		if self.Hooks[obj][method].active then
			-- If this is a script
			if self.Hooks[obj][method].script then
				if obj:GetScript(method) == self.Hooks[obj][method].func then
					-- We own the global function.  Kill it.
					obj:SetScript(method, self.Hooks[obj][method].orig)
					self.Hooks[obj][method] = nil
					return
				else
					self.Hooks[obj][method].active = nil
				end
			else
				if obj[method] == self.Hooks[obj][method].func then
					-- We own the global function.  Kill it.
					obj[method] = self.Hooks[obj][method].orig
					self.Hooks[obj][method] = nil
					return
				else
					self.Hooks[obj][method].active = nil
				end
			end
		end	
		if not next(self.Hooks[obj]) then
			-- Spank the table
			self.Hooks[obj] = nil
		end
	end
	
	--[[----------------------------------------------------------------------
		AceHook:_getMethodHook - Internal Method
	-------------------------------------------------------------------------]]		
	function AceHook:_getMethodHook(obj, method, handler, methodHook)
		if methodHook then
			-- The handler is a method, need to self it
			return 
				function(o,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					if self.Hooks[obj][method].active then 
						return self[handler](self, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					elseif self.Hooks[obj][method].orig then
						return self.Hooks[obj][method].orig(obj, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					end
				end
		else
			-- The handler is a function, just call it
			return 
				function(o,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					if self.Hooks[obj][method].active then 
						return handler(o,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					elseif self.Hooks[obj][method].orig then
						return self.Hooks[obj][method].orig(obj,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
					end
				end	
		end
	end
		
	--[[----------------------------------------------------------------------
		AceHook:Embed - Called to embed the vital methods into another object
	-------------------------------------------------------------------------]]		
	function AceHook:Embed(object)		
		object.Hook 			= self.Hook
		object.Unhook 			= self.Unhook
		object.UnhookAll 		= self.UnhookAll
		object.CallHook 		= self.CallHook
		object.HookFunc 		= self.HookFunc
		object.HookMeth 		= self.HookMeth
		object.UnhookFunc		= self.UnhookFunc
		object.UnhookMeth 		= self.UnhookMeth
		object._getFunctionHook = self._getFunctionHook
		object._getMethodHook	= self._getMethodHook
		object.HookReport		= self.HookReport
		object.IsHooked			= self.IsHooked
		
		object.HookScript 		= self.HookScript
		object.UnhookScript		= self.Unhook
		object.UnhookAllScripts = self.UnhookAllScripts
		object.CallScript		= self.CallHook
		
		if object.debug then 
			object.HookDebug	= object.debug
		else
			object.HookDebug	= self.HookDebug
		end
	end
end -- End conditional declaration

--[[---------------------------------------------------------------------------------
  This is the stub declaration for non-Ace environments  
----------------------------------------------------------------------------------]]

if not AceLibStub then
	AceLibStub = {}
	
	-- Instance replacement method.  Handles "upgrading" to a new version
	function AceLibStub:ReplaceInstance(old,new)
		for k,v in pairs(old) do old[k]=nil end
		for k,v in pairs(new) do old[k]=v end
	end
	
	-- Returns a new stub.  This allows multiple libraries to use the same stub
	function AceLibStub:NewStub(name)
		local newStub = {}
		self:ReplaceInstance(newStub, self)
		newStub.versions = {}
		newStub.libName = name
		return newStub
	end
	
	-- Returns true if the supplied version would be an upgrade to the current version
	-- This allows for bypass code in library declaration.
	
	function AceLibStub:NewVersion(version, minor)
		local versionData = self.versions[version]
		if not versionData or versionData.minor < minor then return true end
	end
	
	-- Handles referencing methods in the calling namespace itself, to accomplish
	-- inheritance instead of composition.  This will not be used in every library
	-- but its important to track what namespaces have used :Embed() since
	-- :ReplaceInstance() won't update those references.
	
	function AceLibStub:Embed(namespace, version)
		local lib = self:GetInstance(version)
		if not lib.Embed then return end
		
		lib:Embed(namespace)
		
		if not lib.embedList then
			lib.embedList = setmetatable({}, {__mode="v"})
		end
	
		table.insert(lib.embedList, namespace)
		lib = nil
	end
	
	-- Returns the most recent version of the given major library
	function AceLibStub:GetInstance(version)
		if not version then 
			error("You must specify a version when requesting a library instance" ,2)
		end
		
		local versionData = self.versions[version] 
		if not versionData then
			error("Cannot find " .. self.libName .. " instance with version '" .. version .. "'",2)
			return
		end
		return versionData.instance
	end
	
	-- Registers a new version of a given library.  Takes the library object.
	function AceLibStub:Register(newInstance)
		if not newInstance.GetLibraryVersion then return end
		local version,minor = newInstance:GetLibraryVersion()
		local versionData = self.versions[version]
		if not versionData then
			-- This is new
			versionData = { instance=newInstance, minor=minor, old={}}
			self.versions[version] = versionData
			newInstance:LibActivate(self)
			return newInstance
		end
		if minor <= versionData.minor then
			-- This one is already obsolete
			if newInstance.LibDiscard then
				newInstance:LibDiscard()
			end
			return versionData.instance
		end
		
		-- This is an update
		local oldInstance = versionData.instance
		local oldList = versionData.old
		versionData.instance = newInstance
		versionData.minor = minor
		local skipCopy = newInstance:LibActivate(self, oldInstance, oldList)
		table.insert(oldList, oldInstance)
		if not skipCopy then
			for i,old in ipairs(oldList) do
				self:ReplaceInstance(old, newInstance)
			end
		end
		return newInstance
	end
end

--[[---------------------------------------------------------------------------------
  Stub and Library registration
----------------------------------------------------------------------------------]]

-- Bind a stub in the global namespace if it doesn't already exist
if not AceHookLib then
	AceHookLib = AceLibStub:NewStub("AceHook")
end

-- Register this library version with the global stub
AceHookLib:Register(AceHook)
AceHook = nil
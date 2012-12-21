--[[---------------------------------------------------------------------------------
  AceHook Library - Embeddable (standalone) or for use through Ace
------------------------------------------------------------------------------------]]

local VERSION = 1.0

if not AceHook or AceHook.VERSION < VERSION then
	-- We need to load this version of the library

	if AceCore then
		if AceHook then
			ace:print("|cffff0000[AceHook] REPLACING THE SUPPLIED ACEHOOK WITH AN EMBEDDED VERSION ("..VERSION..").");
		end
		
		AceHook = AceCore:new()
	else
		AceHook = {}
	end

--[[----------------------------------------------------------------------
	AceHook:Hook
		self:Hook("functionName", ["handlerName" | handler])
		self:Hook(ObjectName, "Method", ["Handler" | handler])
-------------------------------------------------------------------------]]		
	function AceHook:Hook(arg1, arg2, arg3)
		if not self.Hooks then self.Hooks = {} end
		if type(arg1) == "string" then
			self:HookFunc(arg1, arg2)
		else
			self:HookMeth(arg1, arg2, arg3)
		end
	end

	function AceHook:HookScript(arg1, arg2, arg3)
		if not self.Hooks then self.Hooks = {} end
		
		self:HookMeth(arg1, arg2, arg3, true)
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
	function AceHook:Print(message)
		if AceCore then 
			ace:print(message)
		else
			DEFAULT_CHAT_FRAME:AddMessage(message)
		end
	end

	function AceHook:HookReport()
		AceHook:Print("|cffffff00 AceHook: HookReport()")
		if not self.Hooks then AceHook:Print("No registered hooks.") return end
	
		for key, value in pairs(self.Hooks) do
			if type(key) == "table" then
				for method in pairs(value) do
					AceHook:Print("AceHook: key: "..tostring(key).." method: "..tostring(method)..((self.Hooks[key][method].active and "|cff00ff00 Active" or "|cffffff00 Inactive")))
				end
			else
				AceHook:Print("AceHook: key: " .. tostring(key) .. " value: " .. tostring(value) .. ((self.Hooks[key].active and "|cff00ff00 Active" or "|cffffff00 Inactive")))
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
				if self.debug then self.debug( "Attempt to CallHook when no hook exists for " .. obj); return; end
			else
				local func = obj
				return self.Hooks[func].orig(meth,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
			end
		else
			if not self.Hooks[obj] or not self.Hooks[obj][meth] then
				if self.debug then self.debug( "Attempt to CallHook when no hook exists for " .. tostring(meth)); return; end
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
		if not handler then handler = func end
		if self.Hooks[func] then
			-- We have an active hook from this source.  Don't multi-hook
			if self.Hooks[func].active then
				if self.debug then self:debug( func .. " already has an active hook from this source.") end
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
		self.Hooks[func].orig = getglobal(func)
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
			if self.debug then self:debug("Attempt to unhook a function that is not currently hooked.") end
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
		if self.Hooks[obj] and self.Hooks[obj][method] then
			-- We have an active hook from this source.  Don't multi-hook
			if self.Hooks[obj][method].active then
				if self.debug then self:debug( method .. " already has an active hook from this source.") end
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
			if (not obj) then
				error("The object you supplied could not be found.", 3)
			end
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
			if self.debug then self:debug( "Attempt to unhook a method ("..method..") that is not currently hooked.") end
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
		
		object.HookScript 		= self.HookScript
		object.UnhookScript		= self.Unhook
		object.UnhookAllScripts = self.UnhookAllScripts
		object.CallScript		= self.CallHook
	end

	if AceCore then ace.hook = AceHook end

end
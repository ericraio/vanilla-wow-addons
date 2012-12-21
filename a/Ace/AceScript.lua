
-- Class creation
AceScript = AceCore:new({registry={}})

function AceScript:Hook(app, target, handler, method)
	if( not self.registry[target] ) then self.registry[target] = {} end
	if( not self.registry[target][handler] ) then
		self.registry[target][handler] =
			{hooks={},stack={},orig=target:GetScript(handler),nocall=0}
	end

	-- Don't multi-hook
	if( self.registry[target][handler].hooks[app] ) then return end

	target:SetScript(handler,
		function(...)
			if( getn(arg) ) then
				app[method or handler](app, unpack(arg))
			else
				app[method or handler](app)
			end
		end
	)
	self.registry[target][handler].hooks[app] = TRUE
	tinsert(self.registry[target][handler].stack,
		{app=app, meth=method or handler, nocall=nocall}
	)
end

function AceScript:Unhook(app, target, handler)
	if( (not self.registry[target]) or (not self.registry[target][handler]) ) then return end

	local i = ace.TableFindByKeyValue(self.registry[target][handler].stack, "app", app)

	if( not i ) then return end

	local def = self.registry[target][handler]

	if( i == getn(def.stack) ) then
		if( i > 1 ) then
			local app  = def.stack[i-1].app
			local meth = def.stack[i-1].meth
			target:SetScript(handler,
				function(...)
					if( getn(arg) ) then
						app[method or handler](app, unpack(arg))
					else
						app[method or handler](app)
					end
				end
			)
			if( def.stack[i].nocall ) then def.nocall = def.nocall - 1 end
			tremove(def.stack, i)
			def.hooks[app] = nil
		else
			-- If the stack is less than 1, that means it is being emptied out, so
			-- reinstate it and clear it from the hook list.
			target:SetScript(handler, def.orig)
			def.nocall = 0
			self.registry[target][handler] = nil
		end
	else
		tremove(def.stack, i)
		def.hooks[app] = nil
	end
end

function AceScript:UnhookAll(app)
	for target in self.registry do
		for handler in self.registry[target] do
			self:Unhook(app, target, handler)
		end
	end
end

function AceScript:Call(app, target, handler, ...)
	if( (not self.registry[target]) or (not self.registry[target][handler]) ) then
		error("There is no script to call for "..handler..".", 2)
	end

	local def = self.registry[target][handler]
	local i   = ace.TableFindByKeyValue(def.stack, "app", app)

	if( ace.tonum(i) > 1 ) then
		return def.stack[i-1].app[def.stack[i-1].meth](def.stack[i-1].app, unpack(arg))
	elseif( def.nocall > 0 ) then
		return
	elseif( def.orig ) then
		return def.orig(unpack(arg))
	end
end


ace.script = AceScript

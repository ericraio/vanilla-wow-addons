local locals = KC_ITEMS_LOCALS

local DEFAULT_OPTIONS = {
}

KC_Items = AceAddon:new({
    name          = locals.name,
    version       = ".94.5." .. string.sub("$Revision: 2011 $", 12, -3),
    releaseDate   = string.sub("$Date: 2006-05-20 20:53:39 +0200 (lø, 20 maj 2006) $", 8, 17),
    aceCompatible = "103",
    author        = "Kaelten",
    email         = "kaelten@gmail.com",
    website       = "http://www.wowace.com or http://kaelcycle.wowinterface.com",
    category      = "Inventory",
    --optionsFrame  = "AddonNameOptionsFrame",
    db            = AceDatabase:new("KC_ItemsDB"),
    defaults      = DEFAULT_OPTIONS,
    cmd           = AceChatCmd:new(locals.chat.commands, locals.chat.options),
	optPath		 = {"core", "options"},
})


function KC_Items:Register(module)
	if( not self.modules ) then self.modules = {} end
	self.modules[module.type] = module
	self[module.type] = module
	module.app = self
	if (self.common and self.common ~= module) then module.common = self.common end
	module:Register()
	if( module.cmdOptions ) then
		module.cmdOptions.handler = module
		tinsert(module.cmdOptions.args or {}, 1, locals.chat.toggle)
		tinsert(self.cmd.options, module.cmdOptions)
	end
end

-- Need at least an empty Enable so Ace will provide enable/disable features.
function KC_Items:Enable()
	local stats = self.db:get("stats")
	if (not stats or type(stats) == "table") then
		self.db:set("stats", "0,0,0,0,0,0")
	end
	if (self.common.frame and self:GetOpt(self.optPath, "showstatsframe")) then
		self.common.frame:Show()
	end
end

-- Data Access Closures

function KC_Items:GetOpt(path, var)
	if (not var) then var = path; path = nil; end
	local profilePath = path and {self.profilePath, path} or self.profilePath;
	
	return self.db:get(profilePath, var)
end

function KC_Items:SetOpt(path, var, val)
	if (not val) then val = var; var = path; path = nil; end
	local profilePath = path and {self.profilePath, path} or self.profilePath;

	return self.db:set(profilePath, var, val)
end

function KC_Items:TogOpt(path, var)
	if (not var) then var = path; path = nil; end
	local profilePath = path and {self.profilePath, path} or self.profilePath;

	return self.db:toggle(profilePath, var)
end

function KC_Items:ClearOpt(path, var)
	if (not var) then var = path; path = nil; end
	local profilePath = path and {self.profilePath, path} or self.profilePath;
	
	return self.db:set(profilePath, var)
end

function KC_Items:SetModState(mod, state)
	self.db:set({self.profilePath, "modules"}, mod.type, ace.toggle(state))
end

function KC_Items:ModEnabled(mod)
	return ace.toggle(self.db:get({self.profilePath, "modules"}, mod.type))
end


-- Command Reporting Closures

function KC_Items:Msg(...)
	self.cmd:result(locals.msg.color, unpack(arg))
end

function KC_Items:Result(text, val, map)
	if( map ) then val = map[val or 0] or val end
	self.cmd:result(locals.msg.color, text, " ", locals.msg.nowSetTo, " ",
					format(locals.msg.display, val or ACE_CMD_REPORT_NO_VAL)
				   )
end

function KC_Items:TogMsg(var, text)
	local val = self:TogOpt(var)
	self:Result(text, val, locals.maps.onOff)
	return val
end

function KC_Items:Error(...)
	local text = "";
	for i=1,getn(arg) do
		text = text .. arg[i]
	end
	error(locals.msg.color .. text, 2)
end


-- Command Handlers

function KC_Items:Report()
	-- Display KCI core Options.
	-- self.cmd:report()

	-- Display status of modules
	if( self.modules ) then
		local rpt, mod, _ = {}
		for _, mod in self.modules do
			tinsert(rpt, {text=mod.name, val=ace.toggle(mod.disabled), map=locals.maps.enabled})
		end
		self.cmd:report(locals.rpt.header, rpt)
	else
		self:Msg(locals.rpt.noModules)
	end
end


KC_Items:RegisterForLoad()

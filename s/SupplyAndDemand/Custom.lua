
------------------------------
--      Are you local?      --
------------------------------

local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")

local events, opts = {}, {}


local custom = SupplyAndDemand:NewModule("Misc")


function custom:GetDefaults()
	for name,mod in pairs(self.lodmods) do
		local desc = GetAddOnMetadata(name, "X-S&D-CustomDesc")
		if desc then
			local event = GetAddOnMetadata(name, "X-S&D-CustomEvent")
			local condition = GetAddOnMetadata(name, "X-S&D-CustomCondition")
			self:RegisterMod(name, desc, event, condition)
		end
	end

	return opts
end


function custom:RegisterMod(name, desc, event, condition)
	assert(name, "No addon name passed")
	assert(desc, "No loadset description passed")
	assert(event or condition, "No event or condition function passed for "..name)

	local mod = self.lodmods[name]
	mod.hashandler = true
	mod.customdesc = desc

	if event then
		mod.customevent = event
		events[event] = events[event] or {}
		events[event][name] = true
	end

	if type(condition) == "string" then
		local func, errorMessage = loadstring(condition, "S&DCustomCond_"..name)
		if errorMessage then error(errorMessage) end
		mod.customcondition = func
	elseif type(condition) == "function" then
		mod.customcondition = condition
	end

	opts[name] = true
end


function custom:OnEnable()
	for name,mod in pairs(self.lodmods) do
		if self.db.profile[name] and not IsAddOnLoaded(name) and mod.customcondition and mod.customcondition() then
			mod.loadedby = mod.customdesc
			LoadAddOn(name)
		end
		if mod.loadedby and mod.customevent then events[mod.customevent][name] = nil end
	end

	for event,val in pairs(events) do
		if next(val) then self:RegisterEvent(event, "EventHandler") end
	end
end


function custom:EventHandler()
	if events[event] then
		for name in pairs(events[event]) do
			local mod = self.lodmods[name]
			if self.db.profile[name] and not IsAddOnLoaded(name) and (not mod.customcondition or mod.customcondition()) then
				mod.loadedby = mod.customdesc
				LoadAddOn(name)
			end
			if mod.loadedby then events[event][name] = nil end
		end
		if not next(events[event]) then
			self:UnregisterEvent(event)
			events[event] = nil
		end
	end
end


function custom:MenuValid()
	for name,mod in pairs(self.lodmods) do
		if mod.customdesc then return true end
	end
end


function custom:OnMenuRequest(level, v1, intip, v2, v3, v4)
	if level == 2 then
		for _,mod in pairs(self.sortmods) do
			local v = self.lodmods[mod]
			if v.customdesc then
				dewdrop:AddLine("text", v.title.." |cffff8080("..v.customdesc..")", "value", mod, "checked", self.db.profile[mod],
					"func", self.Toggle, "arg1", self, "arg2", mod)
			end
		end
	end
end


function custom:Toggle(mod)
	self.db.profile[mod] = not self.db.profile[mod]
end


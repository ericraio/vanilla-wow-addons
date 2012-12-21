
------------------------------
--      Are you local?      --
------------------------------

local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")

local lodmods, sortmods = {}, {}
local reasons, getreason = {}


-------------------------------------
--      Namespace Declaration      --
-------------------------------------

SupplyAndDemand = AceLibrary("AceAddon-2.0"):new("AceModuleCore-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceDebug-2.0", "FuBarPlugin-2.0", "AceHook-2.1")
SupplyAndDemand:SetModuleMixins("AceDebug-2.0", "AceEvent-2.0")
SupplyAndDemand.debugFrame = ChatFrame5
SupplyAndDemand.hasNoText = true
SupplyAndDemand.clickableTooltip  = true
SupplyAndDemand.hasIcon  = "Interface\\Icons\\Spell_Frost_FrostWard"
SupplyAndDemand.independentProfile = true
SupplyAndDemand:RegisterDB("SupplyAndDemandDB", "SupplyAndDemandDBPerChar")
SupplyAndDemand:RegisterDefaults("profile", {})
SupplyAndDemand:RegisterChatCommand({"/SupplyAndDemand", "/snd"}, {type = "group", handler = SupplyAndDemand, args = {
	["chat"] = {
		type = "toggle",
		name = "Echo to chat",
		desc = "Echo your quest messages to the party channel.",
		get = function() return SupplyAndDemand.db.profile.chat end,
		set = function(v) SupplyAndDemand.db.profile.chat = v end,
	},
}})


--------------------------------
--      Module Prototype      --
--------------------------------

SupplyAndDemand.modulePrototype.core = SupplyAndDemand
SupplyAndDemand.modulePrototype.lodmods = lodmods
SupplyAndDemand.modulePrototype.sortmods = sortmods

function SupplyAndDemand.modulePrototype:GetDefaults()
	local opts = {}
	for name,mod in pairs(lodmods) do
		local mdata = GetAddOnMetadata(name, self.metadataheader)
		if mdata then
			mod.hashandler = true
			if (not self.metadatacondition) or self.metadatacondition(mdata) then
				mod[self.metadataheader] = true
				opts[name] = true
			end
		end
	end

	return opts
end


function SupplyAndDemand.modulePrototype:OnEnable()
	local self = self
	if not self.tripped and self.loadcondition() then self:Trigger()
	elseif not self.tripped and self.event then
		if (type(self.event) == "table") then
			for _, event in pairs(self.event) do
				self:RegisterEvent(event, "EventHandler")
			end
		else
			self:RegisterEvent(self.event, "EventHandler")
		end
	end
end


function SupplyAndDemand.modulePrototype:EventHandler()
	if self.loadcondition() then self:Trigger() end
end


function SupplyAndDemand.modulePrototype:MenuValid()
	if self.nomenu then return end
	if not self.restricttometadata then return true end

	for name,mod in pairs(lodmods) do
		if mod[self.metadataheader] then return true end
	end
end


function SupplyAndDemand.modulePrototype:OnMenuRequest(level, v1, intip, v2, v3, v4)
	if level == 2 then
		for _,mod in pairs(sortmods) do
			local v = lodmods[mod]
			if v.hashandler and (not self.restricttometadata) or v[self.metadataheader] then
				dewdrop:AddLine("text", v.title, "value", mod, "checked", self.db.profile[mod],
					"func", self.Toggle, "arg1", self, "arg2", mod)
			end
		end
	end
end


function SupplyAndDemand.modulePrototype:Trigger()
	self.tripped = true
	self:UnregisterAllEvents()

	for name,mod in pairs(lodmods) do
		if mod.hashandler and self.db.profile[name] and not IsAddOnLoaded(name) then
			mod.loadedby = self:ToString()
			LoadAddOn(name)
		end
	end
end


function SupplyAndDemand.modulePrototype:Toggle(mod)
	self.db.profile[mod] = not self.db.profile[mod]
	if self.tripped and self.db.profile[mod] and not IsAddOnLoaded(mod) then
		lodmods[mod].loadedby = self:ToString()
		LoadAddOn(mod)
	end
end


------------------------------
--      Initialization      --
------------------------------

function SupplyAndDemand:OnInitialize()
	self.version = (self.version or GetAddOnMetadata("SupplyAndDemand", "Version") or "2.0").. " |cffff8888r".. tonumber(string.sub("$Revision: 9516 $", 12, -3)).. "|r"
	for i=1,GetNumAddOns() do self:UpdateAddOn(i) end
	table.sort(sortmods, function(a,b) return lodmods[a].title < lodmods[b].title end)

	for name,mod in pairs(lodmods) do
		if GetAddOnMetadata(name, "X-S&D-Placeholder") then mod.hashandler = true end
	end

	for name,module in self:IterateModules() do
		if not module.nodb then
			self:RegisterDefaults(name, "profile", module:GetDefaults())
			module.db = self:AcquireDBNamespace(name)
		end
	end
end


function SupplyAndDemand:OnEnable()
	self:SecureHook("EnableAddOn")
	self:SecureHook("DisableAddOn")
end


------------------------------
--      Hooked Methods      --
------------------------------

function SupplyAndDemand:EnableAddOn(addon)
	self:UpdateAddOn(addon)
	self:Update()
end


function SupplyAndDemand:DisableAddOn(addon)
	self:UpdateAddOn(addon)
	self:Update()
end


-----------------------------
--      FuBar Methods      --
-----------------------------

function SupplyAndDemand:OnTooltipUpdate()
	local cat = tablet:AddCategory("columns", 2)
	for _,mod in pairs(sortmods) do
		local v = lodmods[mod]
		if v.hashandler then
			if IsAddOnLoaded(mod) then
				cat:AddLine("text", v.title, "text2", "|cff00ff00".. (v.loadedby or "Loaded"))
			elseif v.enabled and v.loadable then
				cat:AddLine("text", v.title, "text2", "Enabled", "func", LoadAddOn, "arg1", mod)
			elseif not v.enabled then
				cat:AddLine("text", v.title, "text2", "|cff808080Disabled", "func", EnableAddOn, "arg1", mod)
			else
				cat:AddLine("text", v.title, "text2", "|cffff0000"..(getreason(v.reason) or v.reason), "func", DisableAddOn, "arg1", mod)
			end
		end
	end
end


function SupplyAndDemand:OnMenuRequest(level, v1, intip, v2, v3, v4)
	if level == 1 then
		for name,module in self:IterateModules() do
			if module:MenuValid() then
				dewdrop:AddLine("text", name, "value", module, "hasArrow", true, "checked", module.tripped)
			end
		end
		dewdrop:AddLine()
	elseif level == 2 then v1:OnMenuRequest(level, v1, intip, v2, v3, v4) end
end


------------------------------
--      Helper Methods      --
------------------------------

function SupplyAndDemand:UpdateAddOn(i)
	if not IsAddOnLoadOnDemand(i) then return end
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
	if not lodmods[name] then
		lodmods[name] = {}
		table.insert(sortmods, name)
	end
	lodmods[name].title = title
	lodmods[name].enabled = enabled
	lodmods[name].loadable = loadable
	lodmods[name].reason = reason
end


getreason = function(r)
	if not reasons[r] then reasons[r] = TEXT(getglobal("ADDON_"..r)) end
	return reasons[r]
end

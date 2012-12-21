
-- Class Setup
AceData = AceDatabase:new("AceDB")

-- Need a constructor to override the AceDB one.
function AceData:new()
	return ace:new(self)
end

function AceData:Initialize()
	if( self.initialized ) then return end

	self.optionsPath	 = {"options"}
	self.profileBasePath = {"profiles"}
	self.profileMapPath  = {"profileMap"}
	self.profilePath	 = {}
	self.profileLoadPath = {self.profilePath, "_loadOnStart"}

	return AceDbClass.Initialize(self)
end


--[[---------------------------------------------------------------------------------
  Ace Settings
------------------------------------------------------------------------------------]]

function AceData:GetOpt(var)
	return self:get(self.optionsPath, var)
end

function AceData:SetOpt(var, val)
	return self:set(self.optionsPath, var, val)
end


--[[---------------------------------------------------------------------------------
  Profile Management
------------------------------------------------------------------------------------]]

function AceData:GetProfile(name)
	return self:get(self.profileBasePath, name)
end

function AceData:GetAddonProfile(profile, addon, profName)
	return self:get({self.profileBasePath, profile}, addon.name, profName)
end

function AceData:SetAddonProfile(profile, addon, profName)
	if( (not addon) or (not addon.db) ) then return end

	self:set({self.profileBasePath, profile}, addon.name, profName)
	if( profName and (not addon.db:get(self.profileBasePath, profile)) ) then
		local defaults = self:GetAddonDefaults(addon)
		if( defaults ) then
			addon.db:set(self.profileBasePath, profile, defaults)
		end
	end
end

function AceData:GetLoadOnStart(addon)
	if( not addon ) then
		-- Return the entire list.
		return self:get(self.profilePath, "_loadOnStart")
	else
		return self:get(self.profileLoadPath, strlower(addon))
	end
end

function AceData:SetLoadOnStart(addon, val)
	self:set(self.profileLoadPath, strlower(addon), val)
end

function AceData:SetCurrentProfile()
	local profile = self:get(self.profileMapPath, ace.char.id)
	if( (not profile) or (not self:GetProfile(profile)) ) then
		profile = ACE_PROFILE_DEFAULT
	end

	self:SetProfile(profile)
end

function AceData:SetProfile(name)
	self.profileName	= name
	self.profilePath[1]	= self.profileBasePath
	self.profilePath[2]	= name
end

function AceData:LoadProfile(name)
	self:SetProfile(name)
	self:set(self.profileMapPath, ace.char.id, name)
	for _, addon in ace.registry:get() do
		if( addon.db and addon.db.initialized ) then
			self:LoadAddonProfile(addon)
		end
	end

	-- Load any on demand addons in this profile.
	local addons = self:GetLoadOnStart(addon)
	if( addons ) then
		for addon in addons do
			LoadAddOn(addon)
		end
	end

	ace.event:TriggerEvent("ACE_PROFILE_LOADED")
end

function AceData:LoadAddonProfile(addon)
	if( not addon.profilePath ) then addon.profilePath = {} end
	addon.profilePath[1] = self.profileBasePath
	addon.profilePath[2] = self:SelectAddonProfile(self.profileName, addon)
	if( addon.initialized and addon.db ) then
		if( addon.db:get(addon.profilePath, "disabled") ) then
			addon:DisableAddon()
		else
			addon:EnableAddon()
		end
	end
end

function AceData:SelectAddonProfile(name, addon)
	if( not addon.db ) then return end

	local profile = self:get({self.profileBasePath, name}, addon.name) or ACE_PROFILE_DEFAULT

	if( not addon.db:get(self.profileBasePath, profile) ) then
		local defaults = self:GetAddonDefaults(addon)
		if( defaults ) then
			addon.db:set(self.profileBasePath, profile, defaults)
		end
	end

	return profile
end

function AceData:GetAddonDefaults(addon)
	if( addon.db and addon.db:get(self.profileBasePath, ACE_PROFILE_DEFAULT) ) then
		return ace.CopyTable({}, addon.db:get(self.profileBasePath, ACE_PROFILE_DEFAULT))
	elseif( addon.defaults ) then
		return ace.CopyTable({}, addon.defaults)
	end
end

function AceData:SaveProfile(name, profile)
	self:set(self.profileBasePath, name, {desc=profile.desc})
	if( not profile.addons ) then return end
	for _, addon in ace.registry:get() do
		if( addon.db and profile.addons[addon.name] ) then
			addon.db:set(self.profileBasePath, name, profile.addons[addon.name])
		end
	end
end

function AceData:DeleteProfile(name)
	self:set(self.profileBasePath, name)
	for _, addon in ace.registry:get() do
		if( addon.db ) then
			addon.db:set(self.profileBasePath, name)
		end
	end
end

function AceData:NewProfile(incDefaults)
	local profile = {}
	if( not incDefault ) then return profile end

	profile.addons = {}
	for _, addon in ace.registry:get() do
		if( addon.db and incDefaults ) then
			profile.addons[addon.name] = self:GetAddonDefaults(addon)
		end
	end
	return profile
end

ace.db = AceData

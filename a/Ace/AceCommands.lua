
-- Class Setup
AceCommands = AceChatCmd:new(ACE_COMMANDS, ACE_CMD_OPTIONS)


--[[--------------------------------------------------------------------------
  Ace Information
-----------------------------------------------------------------------------]]

function AceCommands:DisplayInfo()
	local mem = gcinfo()

	self:report(ACE_INFO_HEADER, {
		{text=ACE_INFO_PROFILE_LOADED, val=ace.db.profileName},
		{text=ACE_TEXT_MEM_USAGE, val=format("%.3f", mem/1024)},
		{text=ACE_TEXT_TOTAL_ADDONS, val=GetNumAddOns()},
		{text=ACE_TEXT_TOTAL_LOADED, val=ace.addons.numLoaded, indent=1},
		{text=ACE_TEXT_ACE_ADDONS_LOADED, val=ace.addons.numAceAddons, indent=1},
		{text=ACE_TEXT_ACE_REGISTERED, val=ace.addons.numAceApps, indent=2},
		{text=ACE_TEXT_OTHERS_LOADED, val=ace.addons.numLoaded-ace.addons.numAceAddons, indent=1},
		{text=ACE_TEXT_NOT_LOADED, val=GetNumAddOns()-ace.addons.numLoaded, indent=1}
	})
end


--[[--------------------------------------------------------------------------
  Enable/Disable Addons
-----------------------------------------------------------------------------]]

function AceCommands:EnableAddon(addon)
	if( strlower(addon) == ACE_TEXT_ALL ) then
		EnableAllAddOns()
		self:msg(ACE_CMD_ADDON_ENABLED_ALL)
	elseif( ace.addons.list[strlower(addon)] ) then
		EnableAddOn(addon)
		self:msg(ACE_CMD_ADDON_ENABLED, addon)
	else
		self:msg(ACE_CMD_ADDON_NOTFOUND, addon)
	end
end

function AceCommands:DisableAddon(addon)
	if( strlower(addon) == ACE_TEXT_ALL ) then
		DisableAllAddOns()
		EnableAddOn("ace") -- Ace should be disabled separately
		self:msg(ACE_CMD_ADDON_DISABLED_ALL)
	elseif( ace.addons.list[strlower(addon)] ) then
		DisableAddOn(addon)
		self:msg(ACE_CMD_ADDON_DISABLED, ace.addons.list[strlower(addon)].name)
	else
		self:msg(ACE_CMD_ADDON_NOTFOUND, addon)
	end
end


--[[--------------------------------------------------------------------------
  Addon Lists
-----------------------------------------------------------------------------]]

function AceCommands:ListAddons(opt)
	ace:print(format(ACE_CMD_RESULT, ACE_CMD_OPT_LIST_ADDONS, ""))
	if( (opt or "") == "" ) then
		for _, addon in ace.sort(ace.GetTableKeys(ace.addons.list)) do
			self:DisplayAddon(ace.addons.list[addon], addon == "ace")
		end
	else
		local _, addon = ace.TableFindKeyCaseless(ace.addons.list, opt)
		if( addon ) then
			self:DisplayAddon(addon, strlower(opt) == "ace", TRUE)
		else
			ace:print(format(ACE_CMD_ADDON_NOTFOUND, opt))
		end
	end
end

function AceCommands:DisplayAddon(addon, isAce, showNotLoaded)
	if( isAce ) then
		self:DisplayAceAddon(addon, Ace)
	elseif( addon.apps and addon.ace ) then
		if( getn(addon.apps) > 1 ) then
			ace:print(" - "..addon.title)
			for _, app in addon.apps do
				self:DisplayAceAddon(addon, app, "      "..app.name)
			end
		else
			self:DisplayAceAddon(addon, addon.apps[1])
		end
	elseif( addon.loaded or showNotLoaded ) then
		ace:print(" - ", addon.title)
	end
end

function AceCommands:DisplayAceAddon(addon, app, prefix)
	ace:print(prefix or " - "..addon.title,
			  ((app.cmd and app.cmd.commands)
				and " "..format(ACE_ADDON_CHAT_COMMAND, app.cmd.commands[1])
				or  "") or "",
			  (app.disabled and " "..ACE_ADDON_STANDBY) or "",
			  app.aceMismatch and " "..ACE_VERSION_MISMATCH
			 )
end

function AceCommands:ListAddonsAce()
	ace:print(format(ACE_CMD_RESULT, ACE_CMD_OPT_LIST_ADDONS, ""))
	for _, addon in ace.sort(ace.GetTableKeys(ace.addons.list)) do
		if( ace.addons.list[addon].ace or (addon == "ace") ) then
			self:DisplayAddon(ace.addons.list[addon], addon == "ace")
		end
	end
end

function AceCommands:ListAddonsOther()
	ace:print(format(ACE_CMD_RESULT, ACE_CMD_OPT_LIST_ADDONS, ""))
	for _, addon in ace.sort(ace.GetTableKeys(ace.addons.list)) do
		if( (not ace.addons.list[addon].ace) and (addon ~= "ace") ) then
			self:DisplayAddon(ace.addons.list[addon])
		end
	end
end

function AceCommands:ListAddonsLoadable()
	ace:print(format(ACE_CMD_RESULT, ACE_CMD_OPT_LIST_ADDONS, ""))
	for i = 1, GetNumAddOns() do
		local name, _, _, _, loadable = GetAddOnInfo(i)
		if( loadable and (not IsAddOnLoaded(i)) ) then
			ace:print(" - ", name)
		end
	end
end


--[[--------------------------------------------------------------------------
  Addon Loading
-----------------------------------------------------------------------------]]

function AceCommands:LoadAddon(addon)
	if( IsAddOnLoaded(addon) ) then
		self:result(format(ACE_CMD_OPT_LOAD_IS_LOADED, addon))
		return
	end

	local loaded, reason = LoadAddOn(addon)
	if( loaded ) then
		self:result(format(ACE_CMD_OPT_LOAD_LOADED, GetAddOnInfo(addon)))
	else
		self:result(format(ACE_CMD_OPT_LOAD_ERROR, addon, strlower(reason)))
	end
end

function AceCommands:LoadAddonAuto(addon)
	ace.db:SetLoadOnStart(addon, TRUE)
	self:LoadAddon(addon)
end

function AceCommands:LoadAddonOff(addon)
	if( ace.db:GetLoadOnStart(addon) ) then
		ace.db:SetLoadOnStart(addon, FALSE)
		self:result(format(ACE_CMD_OPT_AUTO_OFF_MSG, addon))
	end
end


--[[--------------------------------------------------------------------------
  Configurations
-----------------------------------------------------------------------------]]

function AceCommands:ChangeLoadMsgAddon()
	ace.db:SetOpt("loadMsg", "addon")
	self:status(ACE_TEXT_LOADMSG, "addon", ACE_MAP_LOADMSG)
end

function AceCommands:ChangeLoadMsgNone()
	ace.db:SetOpt("loadMsg", "none")
	self:status(ACE_TEXT_LOADMSG, "none", ACE_MAP_LOADMSG)
end

function AceCommands:ChangeLoadMsgSum()
	ace.db:SetOpt("loadMsg")
	self:status(ACE_TEXT_LOADMSG, 0, ACE_MAP_LOADMSG)
end


--[[--------------------------------------------------------------------------
  Profile Options
-----------------------------------------------------------------------------]]

function AceCommands:ProfileInfo()
	local profile = ace.db:GetProfile(ace.db.profileName)


end

function AceCommands:SetProfile(profile, key, msg)
	if( (key or "") ~= "" ) then
		if( strlower(key) == ACE_CMD_PROFILE_ALL ) then
			for _, addon in ace.registry:get() do
				if( addon.db and (not ace.db:GetAddonProfile(profile, addon, profile)) ) then
					ace.db:SetAddonProfile(profile, addon, profile)
				end
			end
			self:result(format(ACE_CMD_PROFILE_ALL_ADDED, profile))
			msg = nil
		else
			local _, addon = ace.TableFindKeyCaseless(ace.registry:get(), key)
			if( not addon ) then
				self:result(format(ACE_CMD_ADDON_NOTFOUND, key))
				return
			end
			if( not addon.db ) then
				self:result(format(ACE_CMD_PROFILE_NO_PROFILE, addon.name))
				return
			end
			ace.db:SetAddonProfile(profile, addon, profile)
			self:result(format(ACE_CMD_PROFILE_ADDON_ADDED, addon.name, profile))
			msg = nil
		end
	end

	-- Load the profile last so that any individual addons added to it will be set to
	-- the correct path.
	self:LoadProfile(profile, msg)
end

function AceCommands:LoadProfile(profile, msg)
	if( ace.db:GetProfile(profile) ) then
		ace.db:LoadProfile(profile)
	else
		ace.db:SaveProfile(profile, ace.db:NewProfile())
		ace.db:LoadProfile(profile)
	end
	if( msg ) then self:result(msg) end
end

function AceCommands:UseProfileChar(opt)
	local _, _, addon, import = strfind(opt, "(%S*)%s?(.*)")
	self:SetProfile(ace.char.id, addon, format(ACE_PROFILE_LOADED_CHAR, ace.char.id))
end

function AceCommands:UseProfileClass(addon)
	self:SetProfile(ace.char.class, addon,
					format(ACE_PROFILE_LOADED_CLASS, ace.char.class, ace.char.id)
				   )
end

function AceCommands:UseProfileDefault()
	ace.db:LoadProfile(ACE_PROFILE_DEFAULT)
	self:result(format(ACE_PROFILE_LOADED_DEFAULT, ace.char.id))
end


ace.cmd = AceCommands
ace.cmd.app = ace



ace.registry = AceDatabase:new()

-- Class creation
AceState = AceCore:new({_initIndex=1,_appList={}})


--[[--------------------------------------------------------------------------------
  State and Addon Initialization
-----------------------------------------------------------------------------------]]

function AceState:BuildAddonList()
	-- Build a table of addon information for later reference
	for i = 1, GetNumAddOns() do
		local name, title, _, enabled, loadable = GetAddOnInfo(i)
		local isLoaded = IsAddOnLoaded(i)
		local def  = {
			title	 = title or name,
			loadable = TRUE
		}
		ace.addons.list[strlower(name)] = def
	end
end

function AceState:SetGameState()
	-- I've seen at least one occurance where GetCVar("realmName") returned an extra
	-- space on the end (e.g., "Archimonde "). So trim everything just to be safe.
	local realmName = ace.trim(GetCVar("realmName"))
	local charName  = ace.trim(UnitName("player"))

	ace.char = {
		realm	= realmName,
		name	= charName,
		id		= charName.." "..ACE_TEXT_OF.." "..realmName,
		class	= ace.trim(UnitClass("player")),
		race	= ace.trim(UnitRace("player")),
		sex		= ace.trim(UnitSex("player")), -- 1 means female
		faction = ace.trim(UnitFactionGroup("player"))
	}

	ace.db:Initialize()
	ace.db:SetCurrentProfile()
	ace.cmd:Register()
end

function AceState:LoadOnDemandAddons()
	local addons = ace.db:GetLoadOnStart()
	if( addons ) then
		for addon in addons do
			LoadAddOn(addon)
		end
	end
end

function AceState:Finish()
	if( (not self.varsLoaded) or (not self.playerEnter) ) then return end

	self:SetGameState()

	AceStateFrame:Show()
	for i = self._initIndex, getn(self._appList) do
		self._initIndex = self._initIndex + 1
		ace:InitializeApp(self._appList[i])
		if( ace.db:GetOpt("loadMsg") == "addon" ) then
			self:DisplayLoadMsg(self._appList[i])
		end
	end
	AceStateFrame:Hide()

	ace.initialized = TRUE

	self:LoadOnDemandAddons()

	if( ace.db:GetOpt("loadMsg") ~= "none" ) then self:DisplayLoadMsgSummary() end

	-- Remove any existing Ace translations.
	for _, lang in ace.langs do
		setglobal("Ace_Locals_"..lang, nil)
	end

	-- Get rid of AceState entirely.
	ace.event:UnregisterAllEvents(AceState)
	AceState = nil

	-- Register ADDON_LOADED on the ace object so addons can be loaded later on demand.
	ace.event:RegisterEvent(ace, "ADDON_LOADED", "LoadAddon")
	ace.event:TriggerEvent("ACE_ADDONS_LOADED")
end

function AceState:DisplayLoadMsgSummary(addon)
	ace:print(format(ACE_LOAD_MSG_SUMMARY,
					 ace.addons.numAceApps,
					 ace.db.profileName
					)
			 )
end

function AceState:DisplayLoadMsg(app)
	ace:print(app.disabled and ACE_ADDON_STANDBY.." " or "",
			  format(ACE_ADDON_LOADED, app.name, app.version, app.author),
			  ((app.cmd and app.cmd.commands)
				and " "..format(ACE_ADDON_CHAT_COMMAND, app.cmd.commands[1])
				or  ""
			  ),
			  app.aceMismatch and " "..ACE_VERSION_MISMATCH
			 )
end


--[[--------------------------------------------------------------------------------
  Events
-----------------------------------------------------------------------------------]]

function AceState:ADDON_LOADED()
	for _, app in ace._load do
		tinsert(self._appList, app)
	end
	ace:LoadAddon()
end

function AceState:VARIABLES_LOADED()
	self.varsLoaded = TRUE
	self:Finish()
end

function AceState:PLAYER_ENTERING_WORLD()
	self.playerEnter = TRUE
	self:Finish()
end


AceState:BuildAddonList()
ace.event:RegisterEvent(AceState, "VARIABLES_LOADED")
ace.event:RegisterEvent(AceState, "PLAYER_ENTERING_WORLD")
ace.event:RegisterEvent(AceState, "ADDON_LOADED")

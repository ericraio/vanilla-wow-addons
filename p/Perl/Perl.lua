-- SavedVariables: XPerlConfig, XPerlConfig_Global, XPerlConfigSavePerCharacter

local varsLoaded

local function Msg(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000X-Perl|r: "..msg)
end

local function CopyConfig()

	if (not varsLoaded) then
		Msg("Variables not loaded yet. Try again")
		return
	end

	if (Perl_Config) then
		if (not XPerlConfig) then
			XPerlConfig = {}
		end
		for k,v in (Perl_Config) do
			XPerlConfig[k] = v
		end
		if (Perl_Config.RaidPositions) then
			XPerlConfig.RaidPositions = {}
			for k,v in pairs(Perl_Config.RaidPositions) do
				if (strsub(k, 1, 4) == "Perl") then
					XPerlConfig.RaidPositions["X"..k] = v
				end
			end
		end

		if (not XPerlConfig_Global) then
			XPerlConfig_Global = {}
		end
		XPerlConfigSavePerCharacter = Perl_Config_SavePerCharacter
		if (Perl_Global_Config) then
			for realm,realmData in pairs(Perl_Config_Global) do
				if (not XPerlConfig_Global[realm]) then
					XPerlConfig_Global[realm] = {}
				end
				for char,charData in pairs(realmData) do
					if (not XPerlConfig_Global[realm][char]) then
						XPerlConfig_Global[realm][char] = {}
					end

					for k,v in pairs(charData) do
						XPerlConfig_Global[realm][char][k] = v
					end

					if (charData.RaidPositions) then
						XPerlConfig_Global[realm][char].RaidPositions = {}
						for k,v in pairs(charData.RaidPositions) do
							if (strsub(k, 1, 4) == "Perl") then
								XPerlConfig_Global[realm][char].RaidPositions["X"..k] = v
							end
						end
					end
				end
			end
			if (XPerlConfigSavePerCharacter and XPerl_SetMyGlobal) then
				XPerl_SetMyGlobal()
			end
		end

		XPerl_Defaults()

		XPerlConfig.Copied = nil
		Perl_Config.Copied = (Perl_Config.Copied or 0) + 1

		XPerl_OptionActions()

		Msg("Configuration copied from old X-Perl installation. You may now remove the 'Perl' addon folder")
	else
		Msg("There is no old X-Perl configuration to copy")
	end

	SlashCmdList["PERLCOPYCONFIG"] = nil
	SLASH_PERLCOPYCONFIG1 = nil

	DisableAddOn("Perl")
end

local function PerlOnEvent()
	this:UnregisterAllEvents()

	varsLoaded = true

	Msg("Use the command |c0000FF00/xperlcopy|r to copy your configuration. |c00A06060This will replace ALL current X-Perl settings with the settings saved under the old folder names|r")

	if (Perl_Config and Perl_Config.Copied) then
		Msg(string.format("|c00FF0000Note that configuration has been copied %d time(s) before", Perl_Config.Copied))
	end

	SlashCmdList["PERLCOPYCONFIG"] = CopyConfig
	SLASH_PERLCOPYCONFIG1 = "/xperlcopy"
end

do
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("Perl")
	if (name and enabled) then
		local Frame = CreateFrame("Frame", "Perl_Config_Copy")
		if (Frame) then
			Frame:SetScript("OnEvent", PerlOnEvent)
			Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
		end
	end
end

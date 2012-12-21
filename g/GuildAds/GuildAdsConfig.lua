function GuildAdsConfigFrame_OnShow()

	local realmName = GetCVar("realmName");

	local playerName = UnitName("player");



	if (GuildAds.Config.PublishMyAds) then

		GuildAds_PublishMyAdsCheckButton:SetChecked(1);

	else

		GuildAds_PublishMyAdsCheckButton:SetChecked(0);

	end

	if (GuildAds.Config.ShowOfflinePlayer) then

		GuildAds_ShowOfflinePlayerCheckButton:SetChecked(1);

	else

		GuildAds_ShowOfflinePlayerCheckButton:SetChecked(0);

	end

	if (GuildAds.Config.ShowMyAds) then

		GuildAds_ShowMyAdsCheckButton:SetChecked(1);

	else

		GuildAds_ShowMyAdsCheckButton:SetChecked(0);

	end

	

	if (GuildAds.Config.Mine[realmName] == nil) then

		GuildAds.Config.Mine[realmName] = {};

	end

	

	if (GuildAdsConfig_GetProfileValue("ShowNewAsk")) then

		GuildAds_ChatShowNewAskCheckButton:SetChecked(1);

	else

		GuildAds_ChatShowNewAskCheckButton:SetChecked(0);

	end

	

	if (GuildAdsConfig_GetProfileValue("ShowNewHave")) then

		GuildAds_ChatShowNewHaveCheckButton:SetChecked(1);

	else

		GuildAds_ChatShowNewHaveCheckButton:SetChecked(0);

	end

	

	local channelName = nil;

	if (GuildAds.Config.Mine[realmName][playerName]) then

		if (GuildAds.Config.Mine[realmName][playerName].ChannelName) then

			channelName=GuildAds.Config.Mine[realmName][playerName].ChannelName;

		end

	end

	if (channelName) then

		GuildAds_ChatUseThisCheckButton:SetChecked(1);

		GuildAds_ChannelEditBox:Show();

		GuildAds_ChannelPasswordEditBox:Show();

		GuildAds_ChannelEditBox:SetText(channelName);

		password = GuildAds.Config.Mine[realmName][playerName].ChannelPassword;

		if (password == nil) then

			password = "";

		end

		GuildAds_ChannelPasswordEditBox:SetText(password);

	else

		GuildAds_ChatUseThisCheckButton:SetChecked(0);

		GuildAds_ChannelEditBox:Hide();

		GuildAds_ChannelPasswordEditBox:Hide();

	end



	local channelCommand, channelAlias = GuildAdsConfig_GetChannelAlias();

	GuildAds_ChannelAliasEditBox:SetText(channelAlias);

	GuildAds_ChannelCommandEditBox:SetText(channelCommand);

	

	GuildAds_MinimapArcSlider:SetValue(GuildAds.Config.MinimapArcOffset);

	GuildAds_MinimapRadiusSlider:SetValue(GuildAds.Config.MinimapRadiusOffset);

end



function GuildAdsConfigFrame_OnHide()

	if ( GuildAds_ChatUseThisCheckButton:GetChecked() ) then

		local name = GuildAds_ChannelEditBox:GetText();

		local password = GuildAds_ChannelPasswordEditBox:GetText();

		if (name == "") then

			name = nil;

			password = nil;

		else

			if (password == "") then

				password = nil;

			end

		end

		GuildAdsConfig_SetChannel(name, password);

	else

		GuildAdsConfig_SetChannel(nil, nil);

	end

	

	local channelCommand = GuildAds_ChannelCommandEditBox:GetText();

	local channelAlias = GuildAds_ChannelAliasEditBox:GetText();

	GuildAdsConfig_SetChannelAlias(channelCommand, channelAlias);

	

end



function GuildAdsConfig_GetProfileValue(key, defaultValue)

	local realmName = GetCVar("realmName");

	local playerName = UnitName("player");

	if (GuildAds.Config.Mine[realmName]) then

		if (GuildAds.Config.Mine[realmName][playerName]) then

			if (GuildAds.Config.Mine[realmName][playerName][key]) then

				return GuildAds.Config.Mine[realmName][playerName][key];

			end

		end

	end

	return defaultValue;

end



function GuildAdsConfig_SetProfileValue(key, value)

	local realmName = GetCVar("realmName");

	local playerName = UnitName("player");

	if (not GuildAds.Config.Mine[realmName]) then

		GuildAds.Config.Mine[realmName] = { };

	end

	if (not GuildAds.Config.Mine[realmName][playerName]) then

		GuildAds.Config.Mine[realmName][playerName] = { };

	end

	GuildAds.Config.Mine[realmName][playerName][key] = value;

end



function GuildAdsConfig_SetUseThisChannel(state)

	if (state) then

		GuildAds_ChatUseThisCheckButton:SetChecked(1);

		GuildAds_ChannelEditBox:Show();

		GuildAds_ChannelPasswordEditBox:Show();

	else

		GuildAds_ChatUseThisCheckButton:SetChecked(0);

		GuildAds_ChannelEditBox:Hide();

		GuildAds_ChannelPasswordEditBox:Hide();

	end

end



function  GuildAdsConfig_GetChannelName()

	local realmName = GetCVar("realmName");

	local playerName = UnitName("player");

	if (GuildAds.Config.Mine[realmName]) then

		if (GuildAds.Config.Mine[realmName][playerName]) then

			if (GuildAds.Config.Mine[realmName][playerName].ChannelName) then

				return GuildAds.Config.Mine[realmName][playerName].ChannelName;

			end

		end

	end

	

	local go_guildName, go_GuildRankName, go_guildRankIndex = GetGuildInfo("player");

	if (go_guildName) then

		name = "GuildAds";

		for word in string.gfind(go_guildName,"[^ ]+") do

			name = name..word;

		end

		if (strlen(name) > 31) then

			name = string.sub(name, 0, 31);

		end

		return name;

	else

		return "GuildAds"..UnitName("player");

	end

end



function GuildAdsConfig_GetChannelPassword()

	local realmName = GetCVar("realmName");

	local playerName = UnitName("player");

	if (GuildAds.Config.Mine[realmName]) then

		if (GuildAds.Config.Mine[realmName][playerName]) then

			return GuildAds.Config.Mine[realmName][playerName].ChannelPassword;

		end

	end

	return nil;

end



function GuildAdsConfig_SetChannel(name, password)

	local realmName = GetCVar("realmName");

	local playerName = UnitName("player");

	local reinit = false;

	

	if (GuildAds.Config.Mine[realmName] == nil) then

		GuildAds.Config.Mine[realmName] = {};

	end

	

	if (name ~= nil) then

		if (password~=nil and string.len(password) == 0) then

			password = nil;

		end

		

		local  current = GuildAds.Config.Mine[realmName][playerName];

		if not(current and current.ChannelName == name and current.ChannelPassword == password) then

			if (GuildAds.Config.Mine[realmName][playerName] == nil) then

				GuildAds.Config.Mine[realmName][playerName] = { };

			end

			if (GuildAds.Config.Mine[realmName][playerName].ChannelName ~= name) or (GuildAds.Config.Mine[realmName][playerName].ChannelPassword ~= password) then

				GuildAds.Config.Mine[realmName][playerName].ChannelName = name;

				GuildAds.Config.Mine[realmName][playerName].ChannelPassword = password;

				reinit = true;

			end

		end

	else

		if (GuildAds.Config.Mine[realmName][playerName]) then

			if (GuildAds.Config.Mine[realmName][playerName].ChannelName) or (GuildAds.Config.Mine[realmName][playerName].ChannelPassword) then

				GuildAds.Config.Mine[realmName][playerName].ChannelName = nil;

				GuildAds.Config.Mine[realmName][playerName].ChannelPassword = nil;

				reinit = true;

			end

		end

	end

	

	if (reinit) then

		GuildAds_Reinit();

	end

end



function GuildAdsConfig_GetChannelAlias()

	local realmName = GetCVar("realmName");

	local playerName = UnitName("player");



	if (GuildAds.Config.Mine[realmName]) then

		if (GuildAds.Config.Mine[realmName][playerName]) then

			local current = GuildAds.Config.Mine[realmName][playerName];

			if (current.ChannelCommand and current.ChannelAlias) then

				return current.ChannelCommand, current.ChannelAlias;

			end

		end

	end

	

	return "ga", "GuildAds";

end



function GuildAdsConfig_SetChannelAlias(command, alias)

	local realmName = GetCVar("realmName");

	local playerName = UnitName("player");

	local reinit = false;

	

	if (GuildAds.Config.Mine[realmName] == nil) then

		GuildAds.Config.Mine[realmName] = {};

	end

	

	if (GuildAds.Config.Mine[realmName][playerName] == nil) then

		GuildAds.Config.Mine[realmName][playerName] = {};

	end

	

	local current = GuildAds.Config.Mine[realmName][playerName];

	if (current.ChannelCommand~=command or current.ChannelAlias~=alias) then

		current.ChannelCommand = command;

		current.ChannelAlias = alias;

		reinit = true;

	end

	

	if (reinit) then

		SimpleComm_InitAlias(current.ChannelCommand, current.ChannelAlias);

	end

end



function GuildAdsConfig_Toggle()

	if (GuildAdsConfigFrame:IsVisible()) then

		GuildAdsConfigFrame:Hide()

	else

		GuildAdsConfigFrame:Show();

	end

end
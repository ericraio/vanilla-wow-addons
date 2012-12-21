-- Version 0.31
-- 12.05.2005
-- For updates visit http://www.curse-gaming.com/mod.php?addid=1103


TITAN_FRIENDSX_ID = "FriendsX"

NumFriendsOnline = 0;
NumGuildsOnline = 0;
NumFriends = 0;
NumGuilds = 0;


function TitanPanelFriendsXButton_OnLoad()
	this.registry = { 
		id = TITAN_FRIENDSX_ID,
		menuText = FRIENDSX_MENU_TEXT, 
		buttonTextFunction = "TitanPanelFriendsXButton_GetButtonText", 
		tooltipTitle = FRIENDSX_TOOLTIP,
		tooltipTextFunction = "TitanPanelFriendsXButton_GetTooltipText", 
		
		savedVariables = {
			ShowLabelText = 1,
			FriendsCount = 1,
			FriendsShowOnline = 1,
			FriendsMarkArea = 1,
			GuildCount = 1,
			GuildShowOnline = 1,
			GuildMarkArea = 1,
			
		}
	};
		this:RegisterEvent("FRIENDLIST_SHOW");
		this:RegisterEvent("FRIENDLIST_UPDATE");
		this:RegisterEvent("GUILD_ROSTER_SHOW");
		this:RegisterEvent("GUILD_ROSTER_UPDATE");
		--this:RegisterEvent("VARIABLES_LOADED");
		--this:RegisterEvent("PLAYER_GUILD_UPDATE");


end


function TitanPanelFriendsXButton_OnEnter()

	--Sea.IO.print("FriendsXButton_OnEnter Event");
	ShowFriends();

end

function TitanPanelFriendsXButton_OnEvent(event)
	
	--TitanPanelButton_UpdateTooltip();
	--if (event == "VARIABLES_LOADED") then
	--	GuildRoster();
	--	Sea.IO.print("VARIABLES_LOADED Event");
	--	ShowFriends();
	--else
	--	Sea.IO.print(event);
		TitanPanelButton_UpdateButton(TITAN_FRIENDSX_ID);
	--end
end


function TitanPanelFriendsXButton_GetButtonText(id)
	local id = TitanUtils_GetButton(id, true);
	NumFriends = GetNumFriends();
	NumFriendsOnline = 0;
	NumGuilds = GetNumGuildMembers();
	NumGuildsOnline = 0;
	local FriendInSameArea = 0;
	local GuildInSameArea = 0;
	local buttonRichText = "";

	local friend_name, friend_level, friend_class, friend_area, friend_connected
	local guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_group, guild_note, guild_officernote, guild_online
	local friendIndex
	local guildIndex
	local CharName = "";

	CharName = UnitName("player");

		-- get a count of the number of online friends
		for friendIndex=1, NumFriends do
			friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
			if (CharName ~= friend_name) then
				if ( friend_connected ) then
					NumFriendsOnline = NumFriendsOnline + 1;
				end
				if (friend_area == GetZoneText()) then
					FriendInSameArea = FriendInSameArea + 1;
				end
			end 
		end

	-- get a count of the number of online guild members
	for guildIndex=1, NumGuilds do
		guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_group, guild_note, guild_officernote, guild_online = GetGuildRosterInfo(guildIndex);
		if (CharName ~= guild_name) then
			if ( guild_online ) then
				NumGuildsOnline = NumGuildsOnline + 1;
				if (guild_zone == GetZoneText()) then
					GuildInSameArea = GuildInSameArea + 1;
				end
			end
		end
	end


	-- Create Button Text depending on options

	if ((TitanGetVar(TITAN_FRIENDSX_ID, "FriendsCount")) and (TitanGetVar(TITAN_FRIENDSX_ID, "GuildCount"))) then
		--Sea.IO.print("Beide Counts an");
		buttonRichText = format(FRIENDSX_BUTTON_TEXT, TitanUtils_GetGreenText(NumFriendsOnline+NumGuildsOnline), TitanUtils_GetHighlightText(NumFriends+NumGuilds), TitanUtils_GetRedText(GuildInSameArea + FriendInSameArea));
	elseif ((TitanGetVar(TITAN_FRIENDSX_ID, "FriendsCount")) and (TitanGetVar(TITAN_FRIENDSX_ID, "GuildCount") == nil)) then
		buttonRichText = format(FRIENDSX_BUTTON_TEXT, TitanUtils_GetGreenText(NumFriendsOnline), TitanUtils_GetHighlightText(NumFriends), TitanUtils_GetRedText(FriendInSameArea));
		--Sea.IO.print("Nur Friend Count an");
	elseif ((TitanGetVar(TITAN_FRIENDSX_ID, "FriendsCount") == nil) and (TitanGetVar(TITAN_FRIENDSX_ID, "GuildCount"))) then
		--Sea.IO.print("nur gild count an");
		buttonRichText = format(FRIENDSX_BUTTON_TEXT, TitanUtils_GetGreenText(NumGuildsOnline), TitanUtils_GetHighlightText(NumGuilds), TitanUtils_GetRedText(GuildInSameArea));
	else
		buttonRichText = format(FRIENDSX_BUTTON_TEXT, TitanUtils_GetGreenText("-"), TitanUtils_GetHighlightText("-"), TitanUtils_GetRedText("-"));
	end
	return FRIENDSX_BUTTON_LABEL, buttonRichText;

end


function TitanPanelFriendsXButton_GetTooltipText()
	--local NumFriends = GetNumFriends();
	--local NumGuilds = GetNumGuildMembers();
	local tooltipRichText = "";


	local friend_name, friend_level, friend_class, friend_area, friend_connected;
	local friendIndex;
	local guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_group, guild_note, guild_officernote, guild_online;
	local guildIndex;
	local CharName = "";

	CharName = UnitName("player");

	if (TitanGetVar(TITAN_FRIENDSX_ID, "FriendsShowOnline")) then

		if (NumFriendsOnline > 0) then
			tooltipRichText = tooltipRichText.."\n"..TitanUtils_GetGreenText(FRIENDSX_FRIENDS).."\n";
			for friendIndex=1, NumFriends do
				friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
				if (CharName ~= friend_name) then
					if (friend_connected) then
						if ((friend_area == GetZoneText()) and (TitanGetVar(TITAN_FRIENDSX_ID, "FriendsMarkArea"))) then
							tooltipRichText = tooltipRichText..TitanUtils_GetRedText(friend_name)..TitanUtils_GetHighlightText(" - "..friend_area.." ["..friend_level.." "..friend_class.."]").."\n";
						else
							tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(friend_name)..TitanUtils_GetHighlightText(" - "..friend_area.." ["..friend_level.." "..friend_class.."]").."\n";
						end
					end
				end
			end
		end
	end

	if (TitanGetVar(TITAN_FRIENDSX_ID, "GuildShowOnline")) then
	
		if (NumGuildsOnline > 0) then
			tooltipRichText = tooltipRichText.."\n"..TitanUtils_GetGreenText(FRIENDSX_GUILD).."\n";
			for guildIndex=1, NumGuilds do
				guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_group, guild_note, guild_officernote, guild_online = GetGuildRosterInfo(guildIndex);
				if (CharName ~= guild_name) then
					if ( (guild_online)) then
						if ((guild_zone == GetZoneText()) and (TitanGetVar(TITAN_FRIENDSX_ID, "GuildMarkArea"))) then
							tooltipRichText = tooltipRichText..TitanUtils_GetRedText(guild_name)..TitanUtils_GetHighlightText(" - "..guild_zone.." ["..guild_level.." "..guild_class.."]").."\n";				
						else
							tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(guild_name)..TitanUtils_GetHighlightText(" - "..guild_zone.." ["..guild_level.." "..guild_class.."]").."\n";				
						end
					end
				end
			end
		end
	end
	if (tooltipRichtext == TITAN_FRIENDSX_ID) then
		tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(FRIENDSX_NOBODY_ONLINE_TOOLTIP);
	else
		-- remove the last \n
		tooltipRichText = string.sub(tooltipRichText, 1, string.len(tooltipRichText)-1);
	end

	return tooltipRichText;
end


function Whisper()
	-- yes its the same like kragus´ one :) nice job!
	if ( not ChatFrameEditBox:IsVisible() ) then
		ChatFrame_OpenChat("/w "..this.value.." ");
	else
		ChatFrameEditBox:SetText("/w "..this.value.." ");
	end
end


function invite()
	InviteByName(this.value);		
end


function TitanPanelRightClickMenu_PrepareFriendsXMenu()


	if (IsShiftKeyDown() ) then
		-- Creater Wisper menu

		local guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_group, guild_note, guild_officernote, guild_online
		local friend_name, friend_level, friend_class, friend_area, friend_connected;
		local Index = 0;
		local CharName = "";

		CharName = UnitName("player");		

		info = {};
		info.text = TitanUtils_GetNormalText("Whisper");
		info.notClickable = 1;
		UIDropDownMenu_AddButton(info);



		info = {};
		info.text = TitanUtils_GetGreenText(FRIENDSX_FRIENDS);
		info.notClickable = 1;
		UIDropDownMenu_AddButton(info);

		-- get online friends
		for Index=1, NumFriends do
			friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(Index);
			if ( friend_connected and CharName ~= friend_name) then
				info = {};
				info.text = friend_name;
				info.func = Whisper;
				info.value = friend_name;
				UIDropDownMenu_AddButton(info);
			end
		end

		info = {};
		info.text = TitanUtils_GetGreenText(FRIENDSX_GUILD);
		info.notClickable = 1
		UIDropDownMenu_AddButton(info);

		-- get online guild people
		for Index=1, NumGuilds do
			guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_group, guild_note, guild_officernote, guild_online = GetGuildRosterInfo(Index);
			if ( guild_online and CharName ~= guild_name) then
				info = {};
				info.text = guild_name;
				info.func = Whisper;
				info.value = guild_name;
				UIDropDownMenu_AddButton(info);
			end
		end


	elseif (IsControlKeyDown() ) then

		-- Create invite menu

		local guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_group, guild_note, guild_officernote, guild_online
		local friend_name, friend_level, friend_class, friend_area, friend_connected;
		local Index = 0;
		local CharName = "";

		CharName = UnitName("player");		


		info = {};
		info.text = TitanUtils_GetNormalText("Invite");
		info.notClickable = 1;
		UIDropDownMenu_AddButton(info);


		info = {};
		info.text = TitanUtils_GetGreenText(FRIENDSX_FRIENDS);
		info.notClickable = 1;
		UIDropDownMenu_AddButton(info);

		-- get online friends
		for Index=1, NumFriends do
			friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(Index);
			if ( friend_connected and CharName ~= friend_name) then
				info = {};
				info.text = friend_name;
				info.func = invite;
				info.value = friend_name;
				UIDropDownMenu_AddButton(info);
			end
		end

		info = {};
		info.text = TitanUtils_GetGreenText(FRIENDSX_GUILD);
		info.notClickable = 1
		UIDropDownMenu_AddButton(info);

		-- get online guild people
		for Index=1, NumGuilds do
			guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_group, guild_note, guild_officernote, guild_online = GetGuildRosterInfo(Index);
			if ( guild_online and CharName ~= guild_name) then
				info = {};
				info.text = guild_name;
				info.func = invite;
				info.value = guild_name_name;
				UIDropDownMenu_AddButton(info);
			end
		end


	else

		local id = "FriendsX";
		local info;
		TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);

		-- FRIEND OPTIONS
		info = {};
		info.text = TitanUtils_GetGreenText(FRIENDSX_FRIENDS_OPTIONS);
		info.notClickable = 1
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = FRIENDSX_FRIENDS_OPTIONS_COUNT;
		info.func = function()
			TitanToggleVar(TITAN_FRIENDSX_ID, "FriendsCount");
			--TitanPanelSettings.FriendsCount = TitanUtils_Toggle(TitanPanelSettings.FriendsCount);
			TitanPanelButton_UpdateButton(TITAN_FRIENDSX_ID);
		end
		info.keepShownOnClick = 1;
		info.checked = 	TitanGetVar(TITAN_FRIENDSX_ID, "FriendsCount");
		UIDropDownMenu_AddButton(info);
	
		info = {};
		info.text = FRIENDSX_FRIENDS_OPTIONS_SHOW_ONLINE_TOOLTIP;
		info.func = function()
			TitanToggleVar(TITAN_FRIENDSX_ID, "FriendsShowOnline");
		end
		info.keepShownOnClick = 1;
		info.checked = 	TitanGetVar(TITAN_FRIENDSX_ID, "FriendsShowOnline");
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = FRIENDSX_FRIENDS_OPTIONS_MARK_AREA;
		info.func = function()
			TitanToggleVar(TITAN_FRIENDSX_ID, "FriendsMarkArea");
		end
		info.keepShownOnClick = 1;
		info.checked = 	TitanGetVar(TITAN_FRIENDSX_ID, "FriendsMarkArea");
		UIDropDownMenu_AddButton(info);


		-- GUILD OPTIONS
		info = {};
		info.text = TitanUtils_GetGreenText(FRIENDSX_GUILD_OPTIONS);
		info.notClickable = 1;
		UIDropDownMenu_AddButton(info);


		info = {};
		info.text = FRIENDSX_GUILD_OPTIONS_COUNT;
		info.func = function()
			TitanToggleVar(TITAN_FRIENDSX_ID, "GuildCount");
			TitanPanelButton_UpdateButton(TITAN_FRIENDSX_ID);
		end
		info.keepShownOnClick = 1;
		info.checked = 	TitanGetVar(TITAN_FRIENDSX_ID, "GuildCount");
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = FRIENDSX_GUILD_OPTIONS_SHOW_ONLINE_TOOLTIP;
		info.func = function()
			TitanToggleVar(TITAN_FRIENDSX_ID, "GuildShowOnline");
		end
		info.keepShownOnClick = 1;
		info.checked = 	TitanGetVar(TITAN_FRIENDSX_ID, "GuildShowOnline");
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = FRIENDSX_GUILD_OPTIONS_MARK_AREA;
		info.func = function()
			TitanToggleVar(TITAN_FRIENDSX_ID, "GuildMarkArea");
		end
		info.keepShownOnClick = 1;
		info.checked = 	TitanGetVar(TITAN_FRIENDSX_ID, "GuildMarkArea");
		UIDropDownMenu_AddButton(info);

		TitanPanelRightClickMenu_AddSpacer();	

		TitanPanelRightClickMenu_AddToggleLabelText(TITAN_FRIENDSX_ID);	
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);

	end

end
tinsert(UISpecialFrames, "CT_RA_SlashCmdFrame");
function CT_RASlashCmd_DisplayDialog()
	table.sort(CT_RA_SlashCmds, function(t1, t2)
		return t1[2] < t2[2]
	end);
	-- Initialize dialog
	local totalHeight = 0;
	for i = 1, 30, 1 do
		local obj = getglobal("CT_RA_SlashCmdFrameScrollFrameCmdsCmd" .. i);
		if ( CT_RA_SlashCmds[i] ) then
			obj.slashCommand = CT_RA_SlashCmds[i][2];
			obj:Show();
			getglobal(obj:GetName() .. "Text"):SetText(CT_RA_SlashCmds[i][2]);
			getglobal(obj:GetName() .. "Description"):SetText(CT_RA_SlashCmds[i][3]);
			if ( strlen(CT_RA_SlashCmds[i][4]) > 0 ) then
				getglobal(obj:GetName() .. "Available"):SetText("Shortcuts Available: |c00FFFFFF" .. CT_RA_SlashCmds[i][4] .. "|r");
				obj:SetHeight(CT_RA_SlashCmds[i][1]+33);
			else
				getglobal(obj:GetName() .. "Available"):SetText("");
				obj:SetHeight(CT_RA_SlashCmds[i][1]+25);
			end
			getglobal(obj:GetName() .. "Description"):SetHeight(CT_RA_SlashCmds[i][1]);
			totalHeight = totalHeight + CT_RA_SlashCmds[i][1];
		else
			obj:Hide();
		end
		if ( i > 1 ) then
			obj:SetPoint("TOPLEFT", "CT_RA_SlashCmdFrameScrollFrameCmdsCmd" .. (i-1), "BOTTOMLEFT");
		end
	end
	CT_RA_SlashCmdFrameScrollFrameCmds:SetHeight(totalHeight);
	ShowUIPanel(CT_RA_SlashCmdFrame);
	CT_RA_SlashCmdFrameScrollFrame:UpdateScrollChildRect();
	
	local minVal, maxVal = CT_RA_SlashCmdFrameScrollFrameScrollBar:GetMinMaxValues();
	if ( maxVal == 0 ) then
		CT_RA_SlashCmdFrameScrollFrameScrollBar:Hide();
	else
		CT_RA_SlashCmdFrameScrollFrameScrollBar:Show();
	end
end

CT_RA_SlashCmds = { };

function CT_RA_RegisterSlashCmd(title, description, height, identifier, func, ...)
	SlashCmdList[identifier] = func;
	local otherCmds = "";
	for i = 1, arg.n, 1 do
		setglobal("SLASH_" .. identifier .. i, arg[i]);
		if ( i > 1 ) then
			if ( strlen(otherCmds) > 0 ) then
				otherCmds = otherCmds .. ", ";
			end
			otherCmds = otherCmds .. arg[i];
		end
	end
	local num = 0;
	while ( string.find(description, "|b.-|eb") ) do
		description = string.gsub(description, "^(.*)|b(.-)|eb(.*)$", "%1|c00FFD100%2|r%3");
		num = num + 1;
		if ( num > 10 ) then
			break;
		end
	end
	tinsert(CT_RA_SlashCmds, { height, title, description, otherCmds });
end


-- Functions used by slash commands
function CT_RA_CheckReady()
	if ( CT_RA_Level >= 1 ) then
		SendChatMessage("<CTRaid> " .. UnitName("player") .. " has performed a ready check.", "RAID");
		CT_RA_AddMessage("CHECKREADY");
		local numValid = 0;
		for i = 1, GetNumRaidMembers(), 1 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( name ~= UnitName("player") and CT_RA_Stats[name] and CT_RA_Stats[name]["Reporting"] and online and CT_RA_Stats[name]["Version"] and CT_RA_Stats[name]["Version"] >= 1.097 ) then
				numValid = numValid + 1;
				CT_RA_Stats[name]["notready"] = 1;
			end
		end
		if ( numValid == 1 ) then
			CT_RA_Print("<CTRaid> Ready status is being checked for |c00FFFFFF" .. numValid .. "|r raid member.", 1, 1, 0);
		else
			CT_RA_Print("<CTRaid> Ready status is being checked for |c00FFFFFF" .. numValid .. "|r raid members.", 1, 1, 0);
		end
		CT_RA_UpdateFrame.readyTimer = 30;
		CT_RA_UpdateRaidGroup();
	else
		CT_RA_Print("<CTRaid> You need to be promoted or leader to do that!", 1, 1, 0);
	end
end

function CT_RA_CheckRly()
	if ( CT_RA_Level >= 1 ) then
--~ 		SendChatMessage("<CTRaid> " .. UnitName("player") .. " asks the raid: O RLY?", "RAID");
		CT_RA_AddMessage("CHECKRLY");
		local numValid = 0;
		for i = 1, GetNumRaidMembers(), 1 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( name ~= UnitName("player") and CT_RA_Stats[name] and CT_RA_Stats[name]["Reporting"] and online and CT_RA_Stats[name]["Version"] and CT_RA_Stats[name]["Version"] >= 1.097 ) then
				numValid = numValid + 1;
				CT_RA_Stats[name]["rly"] = 1;
			end
		end
		if ( numValid == 1 ) then
			CT_RA_Print("<CTRaid> O RLY status is being checked for |c00FFFFFF" .. numValid .. "|r raid member.", 1, 1, 0);
		else
			CT_RA_Print("<CTRaid> O RLY status is being checked for |c00FFFFFF" .. numValid .. "|r raid members.", 1, 1, 0);
		end
		CT_RA_UpdateFrame.rlyTimer = 30;
		CT_RA_UpdateRaidGroup();
	else
		CT_RA_Print("<CTRaid> You need to be promoted or leader to do that!", 1, 1, 0);
	end
end

function CT_RA_Invite(msg)
	if ( not GetGuildInfo("player") ) then
		CT_RA_Print("<CTRaid> You need to be in a guild to mass invite.");
		return;
	end
	if ( ( not CT_RA_Level or CT_RA_Level == 0 ) and GetNumRaidMembers() > 0 ) then
		CT_RA_Print("<CTRaid> You must be promoted or raid leader to mass invite.", 1, 1, 0);
		return;
	end
	local inZone = "";
	if ( CT_RA_ZoneInvite ) then
		inZone = " in " .. GetRealZoneText();
	end
	local useless, useless, min, max = string.find(msg, "^(%d+)-(%d+)$");
	min = tonumber(min);
	max = tonumber(max);
	if ( min and max ) then
		if ( min > max ) then
			local temp = min;
			min = max;
			max = temp;
		end
		if ( min < 1 ) then min = 1; end
		if ( max > 60 ) then max = 60; end
		if ( min == max ) then
			SendChatMessage("Raid invites are coming in 10 seconds for players level " .. min .. inZone .. ", leave your groups.", "GUILD");
		else
			SendChatMessage("Raid invites are coming in 10 seconds for players level " .. min .. " to " .. max .. inZone .. ", leave your groups.", "GUILD");
		end
		GuildRoster();
		CT_RA_MinLevel = min;
		CT_RA_MaxLevel = max;
		CT_RA_UpdateFrame.startinviting = 10;
	else
		useless, useless, min = string.find(msg, "^(%d+)$");
		min = tonumber(min);
		if ( min ) then
			if ( min < 1 ) then min = 1; end
			if ( min > 60 ) then min = 60; end
			GuildRoster();
			SendChatMessage("Raid invites are coming in 10 seconds for players level " .. min .. inZone .. ", leave your groups.", "GUILD");
			CT_RA_MinLevel = min;
			CT_RA_MaxLevel = min;
			CT_RA_UpdateFrame.startinviting = 10;
		else
			if ( CT_RA_ZoneInvite ) then
				CT_RA_Print("<CTRaid> Syntax Error. Usage: |c00FFFFFF/razinvite level|r or |c00FFFFFF/razinvite minlevel-maxlevel|r.", 1, 0.5, 0);
				CT_RA_Print("<CTRaid> This command mass invites everybody in the guild in the current zone within the selected level range (or only selected level if maxlevel is omitted).", 1, 0.5, 0);
			else
				CT_RA_Print("<CTRaid> Syntax Error. Usage: |c00FFFFFF/rainvite level|r or |c00FFFFFF/rainvite minlevel-maxlevel|r.", 1, 0.5, 0);
				CT_RA_Print("<CTRaid> This command mass invites everybody in the guild within the selected level range (or only selected level if maxlevel is omitted).", 1, 0.5, 0);
			end
		end
	end
end

-- Slash commands
	-- /raslash
CT_RA_RegisterSlashCmd("/rahelp", "Shows this dialog.", 15, "RAHELP", CT_RASlashCmd_DisplayDialog, "/rahelp");

	-- /rares
CT_RA_RegisterSlashCmd("/rares", "Usable via |b/rares [show/hide]|eb, this shows or hides the resurrection monitor.", 15, "RARES", function(msg)
	if ( msg == "show" ) then
		if ( GetNumRaidMembers() > 0 ) then
			CT_RA_ResFrame:Show();
		end
		CT_RAMenu_Options["temp"]["ShowMonitor"] = 1;
	elseif ( msg == "hide" ) then
		CT_RA_ResFrame:Hide();
		CT_RAMenu_Options["temp"]["ShowMonitor"] = nil;
	else
		CT_RA_Print("<CTRaid> Usage: |c00FFFFFF/rares [show/hide]|r - Shows/hides the Resurrection Monitor.", 1, 0.5, 0);
	end
end, "/rares");

	-- /rs
CT_RA_RegisterSlashCmd("/rs", "Usable via |b/rs [text]|eb, this sends a message to all CTRA users in the raid, which appears in the center of the screen (|brequires leader or promoted status|eb).", 30, "RS", function(msg)
	if ( CT_RA_Level >= 1 ) then
		if ( CT_RAMenu_Options["temp"]["SendRARS"] ) then
			SendChatMessage(msg, "RAID");
		end
		CT_RA_AddMessage("MS " .. msg);
	else
		CT_RA_Print("<CTRaid> You must be promoted or leader to do that!", 1, 1, 0);
	end
end, "/rs");

	-- /rabroadcast
CT_RA_RegisterSlashCmd("/rabroadcast", "Broadcasts the current channel to the raid (|brequires leader or promoted status|eb).", 15, "RABROADCAST", function()
	if ( not CT_RA_Channel ) then
		CT_RA_Print("<CTRaid> No channel set, cannot broadcast the channel!", 1, 0.5, 0);
	else
		if ( CT_RA_Level >= 1 ) then
			CT_RA_Print("<CTRaid> Channel \"|c00FFFFFF" .. CT_RA_Channel .. "|r\" has been broadcasted to the raid.", 1, 0.5, 0);
			SendChatMessage("<CTMod> This is an automatic message sent by CT_RaidAssist. Channel changed to: " .. CT_RA_Channel, "RAID");
		else
			CT_RA_Print("<CTRaid> You must be promoted or leader to do that!", 1, 0.5, 0);
		end
	end
end, "/rabroadcast", "/rabc");

	-- /raupdate
CT_RA_RegisterSlashCmd("/raupdate", "Updates raid stats (|brequires leader or promoted status|eb).", 15, "RAUPDATE", function()
	if ( CT_RA_Level >= 1 ) then
		CT_RA_AddMessage("SR");
		CT_RA_Print("<CTRaid> Stats have been updated for the raid group.", 1, 0.5, 0);
	else
		CT_RA_Print("<CTRaid> You must be promoted or leader to do that!", 1, 0.5, 0);
	end
end, "/raupdate", "/raupd");

	-- /rajoin
CT_RA_RegisterSlashCmd("/rajoin", "Usable via |b/rajoin|eb or |b/rajoin [channel]|eb, this joins the CTRA channel, or changes the CTRA channel to the channel specified.", 30, "RAJOIN", function(msg)
	if ( msg == "" ) then
		if ( not CT_RA_Channel ) then
			CT_RA_Print("<CTRaid> No RaidAssist channel set. Use /rajoin |c00FFFFFF[channel]|r to set channel to |c00FFFFFF[channel]|r.", 1, 0.5, 0);
		elseif ( GetChannelName(CT_RA_Channel) == 0 ) then
			CT_RA_Join(CT_RA_Channel);
			CT_RA_Print("<CTRaid> Joined channel \"|c00FFFFFF" .. CT_RA_Channel .. "|r\".", 1, 0.5, 0);
		else
			CT_RA_Print("<CTRaid> The current RaidAssist channel is: |c00FFFFFF" .. CT_RA_Channel .. "|r.", 1, 0.5, 0);
		end
	else
		if ( CT_RA_Channel ) then
			LeaveChannelByName(CT_RA_Channel);
		end
		CT_RA_UpdateFrame.joinchan = 1;
		CT_RA_UpdateFrame.newchan = msg;
		CT_RA_Print("<CTRaid> Joined channel \"|c00FFFFFF" .. msg .. "|r\".", 1, 0.5, 0);
	end
end, "/rajoin");

	-- /rakeyword
CT_RA_RegisterSlashCmd("/rakeyword", "Automatically invites people whispering you the set keyword.", 15, "RAKEYWORD", function(msg)
	if ( msg == "off" ) then
		CT_RAMenu_Options["temp"]["KeyWord"] = nil;
		CT_RA_Print("<CTRaid> Keyword Inviting has been turned off.", 1, 0.5, 0);
	else
		CT_RAMenu_Options["temp"]["KeyWord"] = msg;
		CT_RA_Print("<CTRaid> Invite Keyword has been set to '|c00FFFFFF" .. msg .. "|r'. Use |c00FFFFFF/rakeyword off|r to turn Keyword Inviting off.", 1, 0.5, 0);
	end
end, "/rakeyword", "/rakw");

	-- /radisband
CT_RA_RegisterSlashCmd("/radisband", "Disbands the raid (|brequires leader or promoted status|eb)", 15, "RADISBAND", function(msg)
	if ( CT_RA_Level and CT_RA_Level >= 1 ) then
		CT_RA_Print("<CTRaid> Disbanding raid...", 1, 0.5, 0);
		SendChatMessage("<CTRaid> Disbanding raid on request by " .. UnitName("player") .. ".", "RAID");
		for i = 1, GetNumRaidMembers(), 1 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( online and rank <= CT_RA_Level and name ~= UnitName("player") ) then
				UninviteByName(name);
			end
		end
		CT_RA_AddMessage("DB");
		LeaveParty();
	else
		CT_RA_Print("<CTRaid> You need to be raid leader or promoted to do that!", 1, 0.5, 0);
	end
end, "/radisband");

	-- /rashow
CT_RA_RegisterSlashCmd("/rashow", "Usable via |b/rashow|eb or |b/rashow all|eb, this shows groups hidden, or all groups.", 15, "RASHOW", function(msg)
	if ( msg == "all" ) then
		CT_RAMenu_Options["temp"]["ShowGroups"] = { 1, 1, 1, 1, 1, 1, 1, 1 };
		CT_RACheckAllGroups:SetChecked(1);
		for i = 1, 8, 1 do
			getglobal("CT_RAOptionsGroupCB" .. i):SetChecked(1);
		end
	else
		if ( not CT_RAMenu_Options["temp"]["HiddenGroups"] ) then return; end
		CT_RAMenu_Options["temp"]["ShowGroups"] = CT_RAMenu_Options["temp"]["HiddenGroups"];
		CT_RAMenu_Options["temp"]["HiddenGroups"] = nil;
		local num = 0;
		for k, v in CT_RAMenu_Options["temp"]["ShowGroups"] do
			num = num + 1;
			getglobal("CT_RAOptionsGroupCB" .. k):SetChecked(1);
		end
		if ( num > 0 ) then
			CT_RACheckAllGroups:SetChecked(1);
		else
			CT_RACheckAllGroups:SetChecked(nil);
		end
	end
	CT_RA_UpdateRaidGroup();
end, "/rashow");

	-- /rahide
CT_RA_RegisterSlashCmd("/rahide", "Hides all shown groups.", 15, "RAHIDE", function()
	CT_RAMenu_Options["temp"]["HiddenGroups"] = CT_RAMenu_Options["temp"]["ShowGroups"];
	CT_RAMenu_Options["temp"]["ShowGroups"] = { };
	CT_RACheckAllGroups:SetChecked(nil);
	for i = 1, 8, 1 do
		getglobal("CT_RAOptionsGroupCB" .. i):SetChecked(nil);
	end
	CT_RA_UpdateRaidGroup();
end, "/rahide");

	-- /raoptions
CT_RA_RegisterSlashCmd("/raoptions", "Shows the options dialog.", 20, "RAOPTIONS", function(msg)
	CT_RAMenuFrame:Show();
end, "/raoptions");

	-- /raready
CT_RA_RegisterSlashCmd("/raready", "Performs a ready check, asking all CTRA users if they are ready (|brequires promoted or leader status|eb).", 30, "RAREADY", CT_RA_CheckReady, "/raready", "/rar");

	-- /rarly
CT_RA_RegisterSlashCmd("/rarly", "Performs a rly check, asking all CTRA users if they are rly (|brequires promoted or leader status|eb).", 30, "RARLY", CT_RA_CheckRly, "/rarly", "/rly");

	-- /rainvite
CT_RA_RegisterSlashCmd("/rainvite", "Usable via |b/rainvite minlevel-maxlevel|eb or |b/rainvite level|eb this will invite all guild members within the chosen level range.", 30, "RAINVITE", function(msg)
	CT_RA_ZoneInvite = nil;
	CT_RA_Invite(msg);
end, "/rainvite", "/rainv");

	-- /razinvite
CT_RA_RegisterSlashCmd("/razinvite", "Usable via |b/rainvite minlevel-maxlevel|eb or |b/rainvite level|eb this will invite all guild members within the chosen level range in your own zone.", 30, "RAZINVITE", function(msg)
	CT_RA_ZoneInvite = 1;
	CT_RA_Invite(msg);
end, "/razinvite", "/razinv");

	-- /radur
CT_RA_RegisterSlashCmd("/radur", "Performs a durability check, which shows every CTRA member's durability percent (|brequires promoted or leader status|eb).", 30, "RADUR", function()
	if ( CT_RA_Level >= 1 ) then
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 4,
			[3] = { "a", "a" },
			[4] = { "a", "a" }
		};
		CT_RA_DurabilityFrame.type = "RADUR";
		CT_RA_DurabilityFrame.arg = nil;
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameValueTab:SetText("Durability Percent");
		CT_RA_DurabilityFrameValueTab:Show();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
		end
		CT_RA_DurabilityFrameTitle:SetText("Durability Check");
		CT_RA_AddMessage("DURC");
	else
		CT_RA_Print("<CTRaid> You need to be promoted or leader to do that!", 1, 0.5, 0);
	end
end, "/radur");

	-- /rareg
CT_RA_RegisterSlashCmd("/rareg", "Performs a reagent check, which shows every CTRA member's reagent count (|brequires promoted or leader status|eb).", 30, "RAREG", function()
	if ( CT_RA_Level >= 1 ) then
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 3,
			[3] = { "a", "a" },
			[4] = { "a", "a" }
		};
		CT_RA_DurabilityFrame.type = "RAREG";
		CT_RA_DurabilityFrame.arg = nil;
		CT_RA_DurabilityFrameValueTab:SetText("Reagent Count");
		CT_RA_DurabilityFrameValueTab:Show();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
		end
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameTitle:SetText("Reagent Check");
		CT_RA_AddMessage("REAC");
	else
		CT_RA_Print("<CTRaid> You need to be promoted or leader to do that!", 1, 0.5, 0);
	end
end, "/rareg");


	-- /raitem
CT_RA_RegisterSlashCmd("/raitem", " Usable via |b/raitem ItemName|eb or |b/raitem [Item Link]|eb; allowing for you to type in or shift+click a link to see everyone in raid who has the item listed.  (Very useful to do |b/raitem Aqual Quintessence|eb to see who came to MC prepared).", 45, "RAITEM", function(itemName)
	if ( CT_RA_Level >= 1 ) then
		if ( not itemName ) then
			CT_RA_Print("<CTRaid> Usage: |c00FFFFFF/raitem Item Name|r  NOTE: You can also use item links.", 1, 0.5, 0);
			return;
		end
		local _, _, linkName = string.find(itemName, "%[(.+)%]");
		if ( linkName ) then
			itemName = linkName;
		end
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 4,
			[3] = { "a", "a" },
			[4] = { "a", "a" }
		};
		CT_RA_DurabilityFrame.type = "RAITEM";
		CT_RA_DurabilityFrame.arg = itemName;
		CT_RA_DurabilityFrameValueTab:SetText("Item Count");
		CT_RA_DurabilityFrameValueTab:Show();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
		end
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameTitle:SetText("Item Check");
		CT_RA_AddMessage("ITMC " .. itemName);
	else
		CT_RA_Print("<CTRaid> You need to be promoted or leader to do that!", 1, 0.5, 0);
	end
end, "/raitem");

	-- /raversion
CT_RA_RegisterSlashCmd("/raversion", " Performs a version check, which shows every member's CTRA version.", 15, "RAVERSION", function()
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 4,
			[3] = { "a", "b" },
			[4] = { "a", "b" }
		};
		CT_RA_DurabilityFrame.type = "RAVERSION";
		CT_RA_DurabilityFrameValueTab:SetText("Version");
		CT_RA_DurabilityFrameValueTab:Show();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
		end
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameTitle:SetText("Version Check");
		for i = 1, GetNumRaidMembers(), 1 do
			local name = UnitName("raid" .. i);
			if ( CT_RA_Stats[name] and CT_RA_Stats[name]["Version"] ) then
				local name, rank, subgroup, level, class, fileName = GetRaidRosterInfo(i);
				CT_RADurability_Add(name, CT_RA_Stats[name]["Version"], fileName, CT_RA_Stats[name]["Version"]);
			end
		end
end, "/raversion", "/raver");

	-- /raresist (Thanks Sudo!)
CT_RA_RegisterSlashCmd("/raresist", "Performs a resistance check, which shows every CTRA member's resistances (|brequires promoted or leader status|eb).", 30, "RARST", function(msg)
	if ( CT_RA_Level >= 1 ) then
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 3,
			[3] = { "a", "a" },
			[4] = { "b", "b" },
			[5] = { "b", "b" },
			[6] = { "b", "b" },
			[7] = { "b", "b" },
			[8] = { "b", "b" },
		};
		
		CT_RA_DurabilityFrame.type = "RARST";
		CT_RA_DurabilityFrameValueTab:Hide();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Show();
		end
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameTitle:SetText("Resist Check");
		CT_RA_AddMessage("RSTC");
	else
		CT_RA_Print("<CTRaid> You need to be promoted or leader to do that!", 1, 0.5, 0);
	end
end, "/raresist", "/raresists");

	-- /razone
CT_RA_RegisterSlashCmd("/razone", "Performs a zone check, which shows every CTRA member outside of your zone.", 30, "RAZONE", function(msg)
	CT_RADurability_Shown = { };
	CT_RADurability_Sorting = {
		["curr"] = 3,
		[3] = { "a", "a" },
		[4] = { "a", "a" }
	};
	CT_RA_DurabilityFrame.type = "RAZONE";
	CT_RA_DurabilityFrameValueTab:Show();
	for i = 1, 5, 1 do
		getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
	end
	CT_RADurability_Update();
	ShowUIPanel(CT_RA_DurabilityFrame);
	CT_RA_DurabilityFrameTitle:SetText("Zone Check");
	CT_RA_DurabilityFrameValueTab:SetText("Zone Name");
	
	local name, rank, subgroup, level, class, fileName, zone;
	for i = 1, GetNumRaidMembers(), 1 do
		name, rank, subgroup, level, class, fileName, zone = GetRaidRosterInfo(i);
		if ( name ~= UnitName("player") and zone and zone ~= "" and zone ~= "Offline" and zone ~= GetRealZoneText() ) then
			CT_RADurability_Add(name, zone, fileName);
		end
	end
end, "/razone");
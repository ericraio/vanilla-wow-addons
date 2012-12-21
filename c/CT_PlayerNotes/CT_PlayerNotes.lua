CT_PlayerNotes = { };
CT_IgnoreNotes = { };
CT_GuildNotes = { };

function CT_Notes_Save(frame)
	-- Choose which table to use
	local table;
	if ( frame.type == "ignore" ) then
		table = CT_IgnoreNotes;
	elseif ( frame.type == "guild" ) then
		table = CT_GuildNotes;
	else
		table = CT_PlayerNotes;
	end
	
	local button = getglobal("CT_" .. strupper(strsub(frame.type, 1, 1)) .. strsub(frame.type, 2)  .. "NotesButton" .. frame.id);
	local eb = getglobal(frame:GetName() .. "NoteEB");
	if ( strlen(eb:GetText()) > 0 ) then
		table[frame.name] = eb:GetText();
		getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
	else
		table[frame.name] = nil;
		getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
	end
	button.note = eb:GetText();
	eb:SetText("");
	frame:Hide();
end

CT_oldFriendsList_Update = FriendsList_Update;

function CT_newFriendsList_Update()
	CT_oldFriendsList_Update();
	local friendOffset = FauxScrollFrame_GetOffset(FriendsFrameFriendsScrollFrame);
	local friendIndex;
	for i=1, FRIENDS_TO_DISPLAY, 1 do
		friendIndex = friendOffset + i;
		name = GetFriendInfo(friendIndex);
		local btn = getglobal("CT_FriendNotesButton" .. i);
		if ( CT_PlayerNotes[name] ) then
			btn.note = CT_PlayerNotes[name];
			getglobal(btn:GetName() .. "NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
		else
			getglobal(btn:GetName() .. "NormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
			btn.note = "";
		end
		btn.type = "friend";
		btn.name = name;
	end
end

FriendsList_Update = CT_newFriendsList_Update;

CT_oldIgnoreList_Update = IgnoreList_Update;

function CT_newIgnoreList_Update()
	CT_oldIgnoreList_Update();
	local ignoreOffset = FauxScrollFrame_GetOffset(FriendsFrameIgnoreScrollFrame);
	local ignoreIndex, name;

	for i=1, IGNORES_TO_DISPLAY, 1 do
		ignoreIndex = i + ignoreOffset;
		name = GetIgnoreName(ignoreIndex);
		local btn = getglobal("CT_IgnoreNotesButton" .. i);
		if ( CT_IgnoreNotes[name] ) then
			btn.note = CT_IgnoreNotes[name];
			getglobal(btn:GetName() .. "NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
		else
			getglobal(btn:GetName() .. "NormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
			btn.note = "";
		end
		btn.type = "ignore";
		btn.name = name;
	end
end

IgnoreList_Update = CT_newIgnoreList_Update;

CT_oldGuildStatus_Update = GuildStatus_Update;

function CT_newGuildStatus_Update()
	CT_oldGuildStatus_Update();
	local guildOffset = FauxScrollFrame_GetOffset(GuildListScrollFrame);
	local guildIndex, name;
	local numGuildMembers = GetNumGuildMembers();
	for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
		guildIndex = guildOffset + i;
		name = GetGuildRosterInfo(guildIndex);
		local btn = getglobal("CT_GuildNotesButton" .. i);
		if ( btn ) then
			btn:ClearAllPoints();
			local relTo = "GuildFrameButton" .. i;
			if ( FriendsFrame.playerStatusFrame ) then
				relTo = "GuildFrameGuildStatusButton" .. i;
			end
			if ( numGuildMembers > GUILDMEMBERS_TO_DISPLAY ) then
				-- Scroll
				btn:SetPoint("RIGHT", relTo, "LEFT", 295, 0);
			else
				-- No scroll
				btn:SetPoint("RIGHT", relTo, "LEFT", 320, 0);
			end
			if ( i > numGuildMembers ) then
				btn:Hide();
			else
				btn:Show();
			end
			if ( CT_GuildNotes[name] ) then
				btn.note = CT_GuildNotes[name];
				getglobal(btn:GetName() .. "NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
			else
				getglobal(btn:GetName() .. "NormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
				btn.note = "";
			end
			btn.type = "ignore";
			btn.type = "guild";
			btn.name = name;
		end
	end
end

GuildStatus_Update = CT_newGuildStatus_Update;

function CT_PlayerNotes_EditingFrame_OnShow()
	local name;
	if ( this.type == "ignore" ) then
		name = "|c00FF0000" .. this.name .. "|r";
	elseif ( this.type == "guild" ) then
		name = "|c00FFFF00" .. this.name .. "|r";
	else
		name = "|c0000FF00" .. this.name .. "|r";
	end
	getglobal(this:GetName() .. "Editing"):SetText(format(CT_PLAYERNOTES_EDITING, name));
	getglobal(this:GetName() .. "NoteEB"):SetText(this.note);
	PlaySound("UChatScrollButton");
end
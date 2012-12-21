UIPanelWindows["CT_RaidTrackerFrame"] = { area = "left", pushable = 1 };
CT_RAIDTRACKER_RAIDS = "Raids: %d";
CT_RaidTracker_Online = { };

CT_RaidTracker_Version = "v1.2";
CT_RaidTracker_Events = { };

CT_RaidTracker_LastPage = { };

CT_RaidTracker_SortOptions = {
	["method"] = "name",
	["way"] = "asc",
	["itemmethod"] = "looted",
	["itemway"] = "asc",
	["itemfilter"] = 1,
	["playerraidway"] = "desc",
	["playeritemfilter"] = 1,
	["playeritemmethod"] = "name",
	["playeritemway"] = "asc",
	["itemhistorymethod"] = "name",
	["itemhistoryway"] = "asc"
};

CT_RaidTracker_ItemTextures = {
	["Head"] = "INV_Helmet_22",
	["Neck"] = "INV_Jewelry_Necklace_11",
	["Shoulder"] = "INV_Shoulder_23",
	["Back"] = "INV_Misc_Cape_16",
	["Chest"] = "INV_Chest_Chain_05",
	["Shirt"] = "INV_Shirt_Black_01",
	["Shield"] = "INV_Shield_05",
	["Tabard"] = "INV_Misc_TabardPVP_04",
	["Wrist"] = "INV_Bracer_07",
	["Two-Hand-Other"] = "INV_Sword_39",
	["Two-Hand-Sword"] = "INV_Sword_39",
	["Two-Hand-Staff"] = "INV_Staff_30",
	["Two-Hand-Polearm"] = "INV_Spear_06",
	["Two-Hand-Axe"] = "INV_Axe_09",
	["Two-Hand-Mace"] = "INV_Hammer_04",
	["Back"] = "INV_Misc_Cape_16",
	["Off Hand"] = "INV_Misc_Book_06",
	["Held In Off-hand"] = "INV_Misc_Book_06",
	["Off Hand-Other"] = "INV_Misc_Wrench_01",
	["Gun"] = "INV_Weapon_Rifle_01",
	["Bow"] = "INV_Weapon_Bow_01",
	["Wand"] = "INV_Wand_02",
	["Projectile"] = "INV_Ammo_Arrow_01",
	["Thrown"] = "INV_Spear_07",
	["Hands"] = "INV_Gauntlets_16",
	["Waist"] = "INV_Belt_02",
	["Legs"] = "INV_Pants_11",
	["Feet"] = "INV_Boots_05",
	["Finger"] = "INV_Jewelry_Ring_30",
	["Trinket"] = "INV_Jewelry_Talisman_10",
	["Other"] = "INV_Misc_Gear_08",
	["Special-Sword"] = "INV_Sword_18",
	["Special-Dagger"] = "INV_Weapon_ShortBlade_11",
	["Special-Mace"] = "INV_Hammer_17",
	["Special-Axe"] = "INV_Axe_09",
	["Special-Fist Weapon"] = "INV_Misc_MonsterClaw_04",
	["Special-Shield"] = "INV_Shield_05",
};

CT_RaidTracker_RarityTable = {
	["ff9d9d9d"] = -1,
	["ffffffff"] = 0,
	["ff1eff00"] = 1,
	["ff0070dd"] = 2,
	["ffa335ee"] = 3,
	["ffff8000"] = 4
};


function CT_RaidTracker_GetTime(dDate)
	if ( not dDate ) then
		return nil;
	end
	local _, _, mon, day, year, hr, min, sec = string.find(dDate, "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)");
	local table = date("*t");
	table["month"] = tonumber(mon);
	table["year"] = tonumber("20" .. year);
	table["day"] = tonumber(day);
	table["hour"] = tonumber(hr);
	table["min"] = tonumber(min);
	table["sec"] = tonumber(sec);
	return time(table);
end

function CT_RaidTracker_SortRaidTable()
	table.sort(
		CT_RaidTracker_RaidLog,
		function(a1, a2)
			if ( a1 and a2 ) then
				return CT_RaidTracker_GetTime(a1.key) > CT_RaidTracker_GetTime(a2.key);
			end
		end
	);
end

function CT_RaidTracker_GetRaidTitle(id, hideid)
	if ( CT_RaidTracker_RaidLog[id] and CT_RaidTracker_RaidLog[id].key ) then
		local _, _, mon, day, year, hr, min, sec = string.find(CT_RaidTracker_RaidLog[id].key, "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)");
		if ( mon ) then
			local months = {
				"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
			};
			if ( hideid ) then
				return months[tonumber(mon)] .. " " .. day .. " '" .. year .. ", " .. hr .. ":" .. min;
			else
				return "[" .. (getn(CT_RaidTracker_RaidLog)-id+1) .. "] " .. months[tonumber(mon)] .. " " .. day .. " '" .. year .. ", " .. hr .. ":" .. min;
			end
		else
			return "";
		end
	end
	return "";
end

function CT_RaidTracker_SaveNote(id)
	local text = CT_RaidTrackerEditNoteFrameNoteEB:GetText();
	if ( strlen(text) == 0 ) then
		text = nil;
	end
	if ( CT_RaidTrackerEditNoteFrame.type == "item" ) then
		CT_RaidTracker_RaidLog[id]["Loot"][CT_RaidTrackerEditNoteFrame.itemid]["note"] = text;

	elseif ( CT_RaidTrackerEditNoteFrame.type == "raid" ) then
		CT_RaidTracker_RaidLog[id]["note"] = text;

	else
		CT_RaidTracker_RaidLog[id]["Notes"][CT_RaidTrackerEditNoteFrame.playerid] = text;

	end
	CT_RaidTracker_Update();
	CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_EditNote_OnShow()
	local text;
	if ( this.type == "raid" ) then
		text = CT_RaidTracker_RaidLog[this.id]["note"];
	elseif ( this.type == "item" ) then
		text = CT_RaidTracker_RaidLog[this.id]["Loot"][this.itemid]["note"];
	else
		text = CT_RaidTracker_RaidLog[this.id]["Notes"][this.playerid];
	end
	if ( text ) then
		getglobal(this:GetName() .. "NoteEB"):SetText(text);
		getglobal(this:GetName() .. "NoteEB"):HighlightText();
	else
		getglobal(this:GetName() .. "NoteEB"):SetText("");
	end

	getglobal(this:GetName() .. "Editing"):SetText("Editing note for " .. this.type .. " \"|c" .. this.color .. "" .. this.text .. "|r\"");
end

function CT_RaidTracker_Update()
	if ( getn(CT_RaidTracker_LastPage) > 0 ) then
		CT_RaidTrackerFrameBackButton:Enable();
	else
		CT_RaidTrackerFrameBackButton:Disable();
	end
	if ( getn(CT_RaidTracker_RaidLog) > 0 ) then
		if ( CT_RaidTrackerFrame.selected ) then
			local selected;
			if ( not CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected] ) then
				while ( not selected ) do
					if ( CT_RaidTrackerFrame.selected < 1 ) then
						selected = 1;
						CT_RaidTrackerFrame.selected = nil;
					else
						CT_RaidTrackerFrame.selected = CT_RaidTrackerFrame.selected - 1;
						if ( CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected] ) then
							selected = 2;
						end
					end
				end
			end
			if ( not selected or selected == 2 ) then
				if ( not CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected] or getn(CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected]["Loot"]) == 0 ) then
					CT_RaidTrackerFrame.type = "raids";
					CT_RaidTrackerFrameViewButton:Disable();
				else
					CT_RaidTrackerFrameViewButton:Enable();
				end
			end
		end

		CT_EmptyRaidTrackerFrame:Hide();
		CT_RaidTrackerFrameNoteButton:Enable();
		CT_RaidTrackerFrameDeleteButton:Enable();

		local hasItem;
		for k, v in CT_RaidTracker_RaidLog do
			for key, val in v["Loot"] do
				if ( val["player"] == CT_RaidTrackerFrame.player ) then
					hasItem = 1;	
					break;
				end
			end
			if ( hasItem ) then
				break;
			end
		end

		if ( CT_RaidTrackerFrame.type == "raids" or not CT_RaidTrackerFrame.type ) then
			CT_RaidTrackerFrameViewButton:SetText("View Items");
		elseif ( CT_RaidTrackerFrame.type == "items" ) then
			CT_RaidTrackerFrameViewButton:SetText("View Players");
		elseif ( CT_RaidTrackerFrame.type == "player" ) then
			if ( not hasItem ) then
				CT_RaidTrackerFrameViewButton:Disable();
			else
				CT_RaidTrackerFrameViewButton:Enable();
			end
			CT_RaidTrackerFrameViewButton:SetText("View Loot");
			CT_RaidTrackerFrameNoteButton:Disable();
			CT_RaidTrackerFrameDeleteButton:Disable();
		elseif ( CT_RaidTrackerFrame.type == "playeritems" ) then
			CT_RaidTrackerFrameViewButton:SetText("View Raids");
			CT_RaidTrackerFrameNoteButton:Disable();
			CT_RaidTrackerFrameDeleteButton:Disable();
			if ( not hasItem ) then
				CT_RaidTrackerFrame.type = "player";
				CT_RaidTracker_Update();
				CT_RaidTracker_UpdateView();
			end
		elseif ( CT_RaidTrackerFrame.type == "itemhistory" ) then
			CT_RaidTrackerFrameNoteButton:Disable();
			CT_RaidTrackerFrameDeleteButton:Disable();
			CT_RaidTrackerFrameViewButton:Disable();
		end
	else
		CT_EmptyRaidTrackerFrame:Show();
		CT_RaidTrackerDetailScrollFramePlayers:Hide();
		CT_RaidTrackerDetailScrollFrameItems:Hide();
		CT_RaidTrackerDetailScrollFramePlayer:Hide();
		CT_RaidTrackerFrameNoteButton:Disable();
		CT_RaidTrackerFrameDeleteButton:Disable();
		CT_RaidTrackerFrameViewButton:Disable();
	end

	local numRaids = getn(CT_RaidTracker_RaidLog);
	local numEntries = numRaids;

	-- Update Quest Count
	CT_RaidTrackerQuestCount:SetText(format(CT_RAIDTRACKER_RAIDS, numRaids));

	-- ScrollFrame update
	FauxScrollFrame_Update(CT_RaidTrackerListScrollFrame, numEntries, 6, 16, nil, nil, nil, CT_RaidTrackerHighlightFrame, 293, 316 );
	
	-- Update the quest listing
	CT_RaidTrackerHighlightFrame:Hide();
	for i=1, 6, 1 do
		local title = getglobal("CT_RaidTrackerTitle" .. i);
		local normaltext = getglobal("CT_RaidTrackerTitle" .. i .. "NormalText");
		local highlighttext = getglobal("CT_RaidTrackerTitle" .. i .. "HighlightText");
		local disabledtext = getglobal("CT_RaidTrackerTitle" .. i .. "DisabledText");
		local highlight = getglobal("CT_RaidTrackerTitle" .. i .. "Highlight");

		local index = i + FauxScrollFrame_GetOffset(CT_RaidTrackerListScrollFrame); 
		if ( index <= numEntries ) then
			local raidTitle = CT_RaidTracker_GetRaidTitle(index);
			local raidTag = CT_RaidTracker_RaidLog[index]["note"];
			if ( not raidTag ) then
				raidTag = "";
			else
				raidTag = " (" .. raidTag .. ")";
			end
			if ( raidTitle ) then
				title:SetText(raidTitle .. raidTag);
			else
				title:SetText("");
			end
			title:Show();
			-- Place the highlight and lock the highlight state
			if ( CT_RaidTrackerFrame.selected and CT_RaidTrackerFrame.selected == index ) then
				CT_RaidTrackerSkillHighlight:SetVertexColor(1, 1, 0);
				CT_RaidTrackerHighlightFrame:SetPoint("TOPLEFT", "CT_RaidTrackerTitle"..i, "TOPLEFT", 0, 0);
				CT_RaidTrackerHighlightFrame:Show();
				title:LockHighlight();
			else
				title:UnlockHighlight();
			end
			
		else
			title:Hide();
		end

	end
end

function CT_RaidTracker_SelectRaid(id)
	local raidid = id + FauxScrollFrame_GetOffset(CT_RaidTrackerListScrollFrame);
	CT_RaidTracker_GetPage();
	CT_RaidTrackerFrame.selected = raidid;
	if ( getn(CT_RaidTracker_RaidLog[raidid]["Loot"]) == 0 or ( CT_RaidTrackerFrame.type and CT_RaidTrackerFrame.type ~= "items" ) ) then
		CT_RaidTrackerFrame.type = "raids";
	end

	CT_RaidTracker_UpdateView();
	CT_RaidTracker_Update();
end

function CT_RaidTracker_ShowInfo(player)
	CT_RaidTracker_GetPage();

	CT_RaidTrackerFrame.type = "player";
	CT_RaidTrackerFrame.player = player;
	CT_RaidTrackerFrame.selected = nil;
	
	CT_RaidTracker_Update();
	CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_GetItemType(link)
	local types = {
		["Head"] = 1,
		["Neck"] = 1,
		["Shoulder"] = 1,
		["Back"] = 1,
		["Chest"] = 1,
		["Shirt"] = 1,
		["Tabard"] = 1,
		["Wrist"] = 1,
		["Two-Hand"] = 1,
		["One-Hand"] = 1,
		["Main Hand"] = 1,

		["Off Hand"] = 1,
		["Held In Off-hand"] = 1,
		["Gun"] = 1,
		["Bow"] = 1,
		["Wand"] = 1,
		["Projectile"] = 1,
		["Thrown"] = 1,
		["Hands"] = 1,
		["Waist"] = 1,
		["Legs"] = 1,
		["Feet"] = 1,
		["Finger"] = 1,
		["Trinket"] = 1
	};

	local special = {
		["Fist Weapon"] = 1,
		["Dagger"] = 1,
		["Shield"] = 1,
		["Sword"] = 1,
		["Axe"] = 1,
		["Polearm"] = 1,
		["Mace"] = 1,
		["Staff"] = 1
	};
	for i = 1, 30, 1 do
		getglobal("CT_RTTooltipTextLeft" .. i):SetText("");
		getglobal("CT_RTTooltipTextLeft" .. i):Hide();
		getglobal("CT_RTTooltipTextRight" .. i):SetText("");
		getglobal("CT_RTTooltipTextRight" .. i):Hide();
	end
	CT_RTTooltip:SetHyperlink(link);
	for i = 2, min(CT_RTTooltip:NumLines(), 5), 1 do
		local textleft = getglobal("CT_RTTooltipTextLeft" .. i);
		local textright = getglobal("CT_RTTooltipTextRight" .. i);
		if ( textleft and types[textleft:GetText()] ) then
			if ( ( textleft:GetText() == "Off Hand" or textleft:GetText() == "Main Hand" or textleft:GetText() == "One-Hand" or textleft:GetText() == "Two-Hand" ) and strlen(textright:GetText()) > 0 ) then
				if ( special[textright:GetText()] ) then
					if ( textleft:GetText() == "Two-Hand" ) then
						return "Two-Hand-" .. textright:GetText();
					else
						return "Special-" .. textright:GetText();
					end
				else
					return textleft:GetText().."-Other";
				end
			else
				return textleft:GetText();
			end
		elseif ( textright and types[textright:GetText()] ) then
			return textright:GetText();
		end
	end
	return "Other";
end

function CT_RaidTracker_Delete(id, type, typeid)
	if ( type == "raid" ) then
		table.remove(CT_RaidTracker_RaidLog, id);
		if ( id == CT_RaidTracker_GetCurrentRaid ) then
			CT_RaidTracker_GetCurrentRaid = nil;
		end
		if ( CT_RaidTrackerFrame.selected == id ) then
			CT_RaidTrackerFrame.selected = CT_RaidTrackerFrame.selected - 1;
			if ( CT_RaidTrackerFrame.selected < 1 ) then
				CT_RaidTrackerFrame.selected = 1;
			end
			CT_RaidTrackerFrame.type = "raids";
		end
	elseif ( type == "item" ) then
		table.remove(CT_RaidTracker_RaidLog[id]["Loot"], typeid);
	elseif ( type == "player" ) then
		for key, val in CT_RaidTracker_RaidLog[id]["Join"] do
			if ( val["player"] == typeid ) then
				CT_RaidTracker_RaidLog[id]["Join"][key] = nil;
			end
		end
		for key, val in CT_RaidTracker_RaidLog[id]["Leave"] do
			if ( val["player"] == typeid ) then
				CT_RaidTracker_RaidLog[id]["Leave"][key] = nil;
			end
		end
	end
	CT_RaidTracker_Update();
	CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_Sort(tbl, method, way)
	if ( way == "asc" ) then
		table.sort(
			tbl,
			function(a1, a2)
				return a1[method] < a2[method];
			end
		);
	else
		table.sort(
			tbl,
			function(a1, a2)
				return a1[method] > a2[method];
			end
		);
	end
	return tbl;
end

function CT_RaidTracker_SortPlayerRaids(id)
	if ( CT_RaidTrackerFrame.type == "itemhistory" ) then
		local table = { "name", "looter" };

		if ( CT_RaidTracker_SortOptions["itemhistorymethod"] == table[id] ) then
			if ( CT_RaidTracker_SortOptions["itemhistoryway"] == "asc" ) then
				CT_RaidTracker_SortOptions["itemhistoryway"] = "desc";
			else
				CT_RaidTracker_SortOptions["itemhistoryway"] = "asc";
			end
		else
			CT_RaidTracker_SortOptions["itemhistoryway"] = "asc";
			CT_RaidTracker_SortOptions["itemhistorymethod"] = table[id];
		end
	else		
		if ( CT_RaidTracker_SortOptions["playerraidway"] == "asc" ) then
			CT_RaidTracker_SortOptions["playerraidway"] = "desc";
		else
			CT_RaidTracker_SortOptions["playerraidway"] = "asc";
		end
	end
	CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_CompareItems(a1, a2)
	-- This function could probably be better, but I can't think of any better way while still maintaining functionality

	local filter, method, way = CT_RaidTracker_SortOptions["itemfilter"], CT_RaidTracker_SortOptions["itemmethod"], CT_RaidTracker_SortOptions["itemway"];
	if ( CT_RaidTrackerFrame.type == "playeritems" ) then
		filter, method, way = CT_RaidTracker_SortOptions["playeritemfilter"], CT_RaidTracker_SortOptions["playeritemmethod"], CT_RaidTracker_SortOptions["playeritemway"];
	end

	-- Check to see if it matches the rarity requirements
	if ( not CT_RaidTracker_RarityTable[a1["item"]["c"]] or CT_RaidTracker_RarityTable[a1["item"]["c"]] < filter ) then
		return false;
	elseif ( CT_RaidTracker_RarityTable[a2["item"]["c"]] < filter ) then
		return true;
	end

	if ( method == "name" ) then
		local c1, c2 = a1["item"]["name"], a2["item"]["name"];
		if ( c1 == c2 ) then
			c1, c2 = a1["player"], a2["player"];
		end
		if ( way == "asc" ) then
			return c1 < c2;
		else
			return c1 > c2;
		end
	elseif ( method == "looter" ) then
		local c1, c2 = a1["player"], a2["player"];
		if ( c1 == c2 ) then
			c1, c2 = CT_RaidTracker_RarityTable[a2["item"]["c"]], CT_RaidTracker_RarityTable[a1["item"]["c"]];
			if ( c1 == c2 ) then
				c1, c2 = a1["item"]["name"], a2["item"]["name"];
			end
		end
		if ( way == "asc" ) then
			return c1 < c2;
		else
			return c1 > c2;
		end
	elseif ( method == "looted" ) then
		if ( way == "asc" ) then
			return CT_RaidTracker_GetTime(a1["time"]) < CT_RaidTracker_GetTime(a2["time"]);
		else
			return CT_RaidTracker_GetTime(a1["time"]) > CT_RaidTracker_GetTime(a2["time"]);
		end
	else
		local c1, c2 = CT_RaidTracker_RarityTable[a1["item"]["c"]], CT_RaidTracker_RarityTable[a2["item"]["c"]];
		if ( c1 == c2 ) then
			c1, c2 = a1["item"]["name"], a2["item"]["name"];
			if ( c1 == c2 ) then
				c1, c2 = a1["player"], a2["player"];
			else
				return c1 < c2;
			end
		end
		if ( way == "asc" ) then
			return c1 < c2;
		else
			return c1 > c2;
		end
	end
end

function CT_RaidTracker_SortItem(tbl, method, way)

		table.sort(
			tbl,
			CT_RaidTracker_CompareItems
		);

	return tbl;
end

function CT_RaidTracker_SortItemBy(id)
	local table = { "name", "looted", "looter", "rarity" };
	local prefix = "";
	if ( CT_RaidTrackerFrame.type == "playeritems" ) then
		prefix = "player";
	end
	if ( CT_RaidTracker_SortOptions[prefix.."itemmethod"] == table[id] ) then
		if ( CT_RaidTracker_SortOptions[prefix.."itemway"] == "asc" ) then
			CT_RaidTracker_SortOptions[prefix.."itemway"] = "desc";
		else
			CT_RaidTracker_SortOptions[prefix.."itemway"] = "asc";
		end
	else
		CT_RaidTracker_SortOptions[prefix.."itemmethod"] = table[id];
		CT_RaidTracker_SortOptions[prefix.."itemway"] = "asc";
	end
	CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_SortBy(id)
	local table = { "name", "join", "leave" };
	if ( CT_RaidTracker_SortOptions["method"] == table[id] ) then
		if ( CT_RaidTracker_SortOptions["way"] == "asc" ) then
			CT_RaidTracker_SortOptions["way"] = "desc";
		else
			CT_RaidTracker_SortOptions["way"] = "asc";
		end
	else
		CT_RaidTracker_SortOptions["method"] = table[id];
		if ( table[id] ~= "leave" ) then
			CT_RaidTracker_SortOptions["way"] = "asc";
		else
			CT_RaidTracker_SortOptions["way"] = "desc";
		end
	end
	CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_UpdateView()
	if ( CT_EmptyRaidTrackerFrame:IsVisible() ) then
		return;
	end
	local raidid = CT_RaidTrackerFrame.selected;
	local num = 1;
	while ( getglobal("CT_RaidTrackerItem" .. num) ) do
		getglobal("CT_RaidTrackerItem" .. num):Hide();
		num = num + 1;
	end
	if ( CT_RaidTrackerFrame.type == "raids" or not CT_RaidTrackerFrame.type ) then
		CT_RaidTrackerDetailScrollFramePlayers:Show();
		CT_RaidTrackerDetailScrollFramePlayer:Hide();
		CT_RaidTrackerDetailScrollFrameItems:Hide();
		local players, str, num = { }, "", 0;
		if ( CT_RaidTracker_RaidLog[raidid] ) then

			local playerIndexes = { };
			for key, val in CT_RaidTracker_RaidLog[raidid]["Join"] do
				if ( val["player"] ) then
					local id = playerIndexes[val["player"]];
					local time = CT_RaidTracker_GetTime(val["time"]);
					if ( not id or time < players[id]["join"] ) then
						
						if ( playerIndexes[val["player"]] ) then
							players[id] = {
								["join"] = time,
								["name"] = val["player"]
							};
						else
							tinsert(players, {
								["join"] = time,
								["name"] = val["player"]
							});
							playerIndexes[val["player"]] = getn(players);
						end
					end
					id = playerIndexes[val["player"]];
					if ( not players[id]["lastjoin"] or players[id]["lastjoin"] < time ) then
						players[id]["lastjoin"] = time;
					end
				end
			end
			for key, val in CT_RaidTracker_RaidLog[raidid]["Leave"] do
				local id = playerIndexes[val["player"]];
				local time = CT_RaidTracker_GetTime(val["time"]);
				if ( id ) then
					if ( ( not players[id]["leave"] or time > players[id]["leave"] ) and time >= players[id]["lastjoin"] ) then
						players[id]["leave"] = time;
					end
				end
			end
			for k, v in players do
				if ( not v["leave"] ) then
					-- Very ugly hack, I know :(
					players[k]["leave"] = 99999999999;
				end
			end
			players = CT_RaidTracker_Sort(players, CT_RaidTracker_SortOptions["method"], CT_RaidTracker_SortOptions["way"]);
			num = 0;
			for key, val in players do
				num = num + 1;
				local name = getglobal("CT_RaidTrackerPlayerLine" .. num .. "Name");
				local number = getglobal("CT_RaidTrackerPlayerLine" .. num .. "Number");
				local join = getglobal("CT_RaidTrackerPlayerLine" .. num .. "Join");
				local leave = getglobal("CT_RaidTrackerPlayerLine" .. num .. "Leave");
				if ( name ) then
					getglobal("CT_RaidTrackerPlayerLine" .. num):Show();
					name:SetText(val["name"]);
					local iNumber = num;
					if ( iNumber < 10 ) then
						iNumber = "  " .. iNumber;
					end
					number:SetText(iNumber);
					join:SetText(date("%I:%M%p", val["join"]));
					if ( val["leave"] == 99999999999 ) then
						leave:SetText("");
					else
						leave:SetText(date("%I:%M%p", val["leave"]));
					end
				end
				
			end
			for i = num+1, 100, 1 do
				getglobal("CT_RaidTrackerPlayerLine" .. i):Hide();
			end
		end
		CT_RaidTrackerRaidText:SetText(str);
		CT_RaidTrackerParticipantsText:SetText("Participants (" .. num .. "):");
		CT_RaidTrackerDetailScrollFramePlayers:UpdateScrollChildRect();
	elseif ( CT_RaidTrackerFrame.type == "items" ) then
		CT_RaidTrackerDetailScrollFramePlayers:Hide();
		CT_RaidTrackerDetailScrollFramePlayer:Hide();
		CT_RaidTrackerDetailScrollFrameItems:Show();
		local numItems, numHidden = 0, 0;
		if ( CT_RaidTracker_RaidLog[raidid] ) then
			local loot = CT_RaidTracker_SortItem(CT_RaidTracker_RaidLog[raidid]["Loot"], CT_RaidTracker_SortOptions["itemmethod"], CT_RaidTracker_SortOptions["itemway"]);
			for key, val in loot do
				local _, _, lootTime = string.find(val["time"], " (%d+:%d+:%d+)$");
				if ( lootTime ) then
					local found;
					local i = 1;
					if ( not found ) then
						if ( CT_RaidTracker_RarityTable[val["item"]["c"]] >= CT_RaidTracker_SortOptions["itemfilter"] ) then
							numItems = numItems + 1;
							if ( getglobal("CT_RaidTrackerItem" .. numItems) ) then
								getglobal("CT_RaidTrackerItem" .. numItems).raidid = CT_RaidTrackerFrame.selected;
								getglobal("CT_RaidTrackerItem" .. numItems).itemid = numItems;
								getglobal("CT_RaidTrackerItem" .. numItems).itemname = val["item"]["name"];
								getglobal("CT_RaidTrackerItem" .. numItems):Show();
								if ( val["item"]["count"] and val["item"]["count"] > 1 ) then
									getglobal("CT_RaidTrackerItem" .. numItems .. "Count"):Show();
									getglobal("CT_RaidTrackerItem" .. numItems .. "Count"):SetText(val["item"]["count"]);
								else
									getglobal("CT_RaidTrackerItem" .. numItems .. "Count"):Hide();
								end
								if ( val["item"]["type"] and CT_RaidTracker_ItemTextures[val["item"]["type"]] ) then
									getglobal("CT_RaidTrackerItem" .. numItems .. "IconTexture"):SetTexture("Interface\\Icons\\" .. CT_RaidTracker_ItemTextures[val["item"]["type"]]);
								else
									getglobal("CT_RaidTrackerItem" .. numItems .. "IconTexture"):SetTexture("Interface\\Icons\\" .. CT_RaidTracker_ItemTextures["Other"]);
								end
								local color = val["item"]["c"];
								if ( color == "ff1eff00" ) then
									color = "11009900";
								end
								getglobal("CT_RaidTrackerItem" .. numItems .. "Description"):SetText("|c" .. color .. val["item"]["name"] .. "|r\nLooted by: " .. val["player"]);
	
								if ( val["note"] ) then
									getglobal("CT_RaidTrackerItem" .. numItems .. "NoteNormalTexture"):SetVertexColor(1, 1, 1);
								else
									getglobal("CT_RaidTrackerItem" .. numItems .. "NoteNormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
								end
							end
						else
							numHidden = numHidden + 1;
						end
					end
				end
			end
		end
		for i = numItems+1, 255, 1 do
			getglobal("CT_RaidTrackerItem" .. i):Hide();
		end
		if ( numHidden == 0 ) then
			CT_RaidTrackerItemsText:SetText("Items (" .. numItems .. "):");
		else
			CT_RaidTrackerItemsText:SetText("Items (" .. numItems .. "/" .. numHidden + numItems .. ")");
		end
		UIDropDownMenu_SetSelectedID(CT_RaidTrackerRarityDropDown, CT_RaidTracker_SortOptions["itemfilter"]);
		local colors = {
			"|c001eff00Uncommon|r",
			"|c000070ddRare|r",
			"|c00a335eeEpic|r",
			"|c00ff8000Legendary"
		};
			
		CT_RaidTrackerRarityDropDownText:SetText(colors[CT_RaidTracker_SortOptions["itemfilter"]]);
		CT_RaidTrackerDetailScrollFrameItems:UpdateScrollChildRect();
	elseif ( CT_RaidTrackerFrame.type == "player" ) then
		CT_RaidTrackerDetailScrollFramePlayers:Hide();
		CT_RaidTrackerDetailScrollFramePlayer:Show();
		CT_RaidTrackerDetailScrollFrameItems:Hide();
		CT_RaidTrackerPlayerRaidTabLooter:Hide();
		CT_RaidTrackerPlayerRaidTab1:SetWidth(300);
		CT_RaidTrackerPlayerRaidTab1Middle:SetWidth(290);
		local name = CT_RaidTrackerFrame.player;

		local raids = { };
		for k, v in CT_RaidTracker_RaidLog do
			local isInRaid;
			for key, val in v["Join"] do
				if ( val["player"] == name ) then
					tinsert(raids, { k, v });
					break;
				end
			end
		end
		
		table.sort(
			raids,
			function(a1, a2)
				if ( CT_RaidTracker_SortOptions["playerraidway"] == "asc" ) then
					return CT_RaidTracker_GetTime(a1[2]["key"]) < CT_RaidTracker_GetTime(a2[2]["key"]);
				else
					return CT_RaidTracker_GetTime(a1[2]["key"]) > CT_RaidTracker_GetTime(a2[2]["key"]);
				end
			end
		);

		for k, v in raids do
			local raid = getglobal("CT_RaidTrackerPlayerRaid" .. k);
			raid.raidid = v[1];
			raid.playername = name;
			raid.raidtitle = CT_RaidTracker_GetRaidTitle(v[1], 1);

			local iNumber = getn(CT_RaidTracker_RaidLog)-v[1]+1;
			if ( iNumber < 10 ) then
				iNumber = "  " .. iNumber;
			end

			getglobal(raid:GetName() .. "MouseOverLeft"):Hide();
			getglobal(raid:GetName() .. "MouseOverRight"):Hide();

			getglobal(raid:GetName() .. "HitAreaLeft"):Hide();
			getglobal(raid:GetName() .. "HitAreaRight"):Hide();
			getglobal(raid:GetName() .. "HitArea"):Show();
			getglobal(raid:GetName() .. "Note"):Hide();
			getglobal(raid:GetName() .. "NoteButton"):Show();
			getglobal(raid:GetName() .. "DeleteButton"):Show();
			getglobal(raid:GetName() .. "DeleteText"):Show();

			getglobal(raid:GetName() .. "Number"):SetText(iNumber);
			getglobal(raid:GetName() .. "Name"):SetWidth(200);
			getglobal(raid:GetName() .. "Name"):SetText(CT_RaidTracker_GetRaidTitle(v[1], 1));

			if ( v[2]["Notes"][name] ) then
				getglobal(raid:GetName() .. "NoteButtonNormalTexture"):SetVertexColor(1, 1, 1);
			else
				getglobal(raid:GetName() .. "NoteButtonNormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
			end
			raid:Show();
		end
		for i = getn(raids)+1, 255, 1 do
			getglobal("CT_RaidTrackerPlayerRaid" .. i):Hide();
		end
		CT_RaidTrackerPlayerText:SetText(name .. "'s Raids (" .. getn(raids) .. "):");
		CT_RaidTrackerDetailScrollFramePlayer:UpdateScrollChildRect();
	elseif ( CT_RaidTrackerFrame.type == "itemhistory" ) then
		CT_RaidTrackerDetailScrollFramePlayers:Hide();
		CT_RaidTrackerDetailScrollFramePlayer:Show();
		CT_RaidTrackerDetailScrollFrameItems:Hide();
		CT_RaidTrackerPlayerRaidTabLooter:Show();
		CT_RaidTrackerPlayerRaidTab1:SetWidth(163);
		CT_RaidTrackerPlayerRaidTab1Middle:SetWidth(155);

		local name, totalItems = CT_RaidTrackerFrame.itemname, 0;

		local items = { };
		for k, v in CT_RaidTracker_RaidLog do
			for key, val in v["Loot"] do
				if ( val["item"]["name"] == name ) then
					tinsert(items, { k, v, val });
					if ( val["item"]["count"] ) then
						totalItems = totalItems + val["item"]["count"];
					else
						totalItems = totalItems + 1;
					end
				end
			end
		end
		
		table.sort(
			items,
			function(a1, a2)
				if ( CT_RaidTracker_SortOptions["itemhistorymethod"] == "looter" ) then
					if ( CT_RaidTracker_SortOptions["itemhistoryway"] == "asc" ) then
						return a1[3]["player"] < a2[3]["player"];
					else
						return a1[3]["player"] > a2[3]["player"];
					end
				else
					if ( CT_RaidTracker_SortOptions["itemhistoryway"] == "asc" ) then
						return CT_RaidTracker_GetTime(a1[2]["key"]) < CT_RaidTracker_GetTime(a2[2]["key"]);
					else
						return CT_RaidTracker_GetTime(a1[2]["key"]) > CT_RaidTracker_GetTime(a2[2]["key"]);
					end
				end
			end
		);

		for k, v in items do
			local raid = getglobal("CT_RaidTrackerPlayerRaid" .. k);
			raid.raidid = v[1];

			local iNumber = getn(CT_RaidTracker_RaidLog)-v[1]+1;
			if ( iNumber < 10 ) then
				iNumber = "  " .. iNumber;
			end
			getglobal(raid:GetName() .. "MouseOver"):Hide();

			getglobal(raid:GetName() .. "HitAreaLeft"):Show();
			getglobal(raid:GetName() .. "HitAreaRight"):Show();
			getglobal(raid:GetName() .. "HitArea"):Hide();

			getglobal(raid:GetName() .. "NoteButton"):Hide();
			getglobal(raid:GetName() .. "Note"):Show();
			getglobal(raid:GetName() .. "DeleteButton"):Hide();
			getglobal(raid:GetName() .. "DeleteText"):Hide();

			getglobal(raid:GetName() .. "Number"):SetText(iNumber);
			getglobal(raid:GetName() .. "Name"):SetWidth(130);
			getglobal(raid:GetName() .. "Name"):SetText(CT_RaidTracker_GetRaidTitle(v[1], 1));
			getglobal(raid:GetName() .. "Note"):SetText(v[3]["player"]);
			raid:Show();
		end
		for i = getn(items)+1, 255, 1 do
			getglobal("CT_RaidTrackerPlayerRaid" .. i):Hide();
		end
		CT_RaidTrackerPlayerText:SetText(name .. " (" .. getn(items) .. "/" .. totalItems .. "):");
		CT_RaidTrackerDetailScrollFramePlayer:UpdateScrollChildRect();

	elseif ( CT_RaidTrackerFrame.type == "playeritems" ) then
		CT_RaidTrackerDetailScrollFramePlayers:Hide();
		CT_RaidTrackerDetailScrollFramePlayer:Hide();
		CT_RaidTrackerDetailScrollFrameItems:Show();
		local name = CT_RaidTrackerFrame.player;

		local loot = { };
		for k, v in CT_RaidTracker_RaidLog do
			for key, val in v["Loot"] do
				if ( val["player"] == name ) then
					tinsert(
						loot,
						{
							["note"] = val["note"],
							["player"] = val["player"],
							["time"] = val["time"],
							["item"] = val["item"],
							["ids"] = { k, key }
						}
					);
				end
			end
		end

		local numItems, numHidden = 0, 0;
		loot = CT_RaidTracker_SortItem(loot, CT_RaidTracker_SortOptions["playeritemmethod"], CT_RaidTracker_SortOptions["playeritemway"]);
		for key, val in loot do
			local _, _, lootTime = string.find(val["time"], " (%d+:%d+:%d+)$");
			if ( lootTime ) then
				local found;
				local i = 1;
				if ( not found ) then
					if ( CT_RaidTracker_RarityTable[val["item"]["c"]] >= CT_RaidTracker_SortOptions["playeritemfilter"] ) then
						numItems = numItems + 1;
						if ( getglobal("CT_RaidTrackerItem" .. numItems) ) then
							getglobal("CT_RaidTrackerItem" .. numItems).raidid = val["ids"][1];
							getglobal("CT_RaidTrackerItem" .. numItems).itemid = val["ids"][2];
							getglobal("CT_RaidTrackerItem" .. numItems).itemname = val["item"]["name"];

							getglobal("CT_RaidTrackerItem" .. numItems):Show();
							if ( val["item"]["count"] and val["item"]["count"] > 1 ) then
								getglobal("CT_RaidTrackerItem" .. numItems .. "Count"):Show();
								getglobal("CT_RaidTrackerItem" .. numItems .. "Count"):SetText(val["item"]["count"]);
							else
								getglobal("CT_RaidTrackerItem" .. numItems .. "Count"):Hide();
							end
							if ( val["item"]["type"] and CT_RaidTracker_ItemTextures[val["item"]["type"]] ) then
								getglobal("CT_RaidTrackerItem" .. numItems .. "IconTexture"):SetTexture("Interface\\Icons\\" .. CT_RaidTracker_ItemTextures[val["item"]["type"]]);
							else
								getglobal("CT_RaidTrackerItem" .. numItems .. "IconTexture"):SetTexture("Interface\\Icons\\" .. CT_RaidTracker_ItemTextures["Other"]);
							end
							local color = val["item"]["c"];
							if ( color == "ff1eff00" ) then
								color = "11009900";
							end
							getglobal("CT_RaidTrackerItem" .. numItems .. "Description"):SetText("|c" .. color .. val["item"]["name"] .. "|r\nLooted " .. CT_RaidTracker_GetRaidTitle(val["ids"][1], 1));

							if ( val["note"] ) then
								getglobal("CT_RaidTrackerItem" .. numItems .. "NoteNormalTexture"):SetVertexColor(1, 1, 1);
							else
								getglobal("CT_RaidTrackerItem" .. numItems .. "NoteNormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
							end
						end
					else
						numHidden = numHidden + 1;
					end
				end
			end
		end
		for i = numItems+1, 255, 1 do
			getglobal("CT_RaidTrackerItem" .. i):Hide();
		end
		if ( numHidden == 0 ) then
			CT_RaidTrackerItemsText:SetText(name .. "'s Loot (" .. numItems .. "):");
		else
			CT_RaidTrackerItemsText:SetText(name .. "'s Loot (" .. numItems .. "/" .. numHidden + numItems .. "):");
		end

		UIDropDownMenu_SetSelectedID(CT_RaidTrackerRarityDropDown, CT_RaidTracker_SortOptions["playeritemfilter"]);
		local colors = {
			"|c001eff00Uncommon|r",
			"|c000070ddRare|r",
			"|c00a335eeEpic|r",
			"|c00ff8000Legendary"
		};
			
		CT_RaidTrackerRarityDropDownText:SetText(colors[CT_RaidTracker_SortOptions["playeritemfilter"]]);
		CT_RaidTrackerDetailScrollFrameItems:UpdateScrollChildRect();
	end
end

function CT_RaidTracker_ColorToRGB(str)
	str = strlower(strsub(str, 3));
	local tbl = { };
	tbl[1], tbl[2], tbl[3], tbl[4], tbl[5], tbl[6] = strsub(str, 1, 1), strsub(str, 2, 2), strsub(str, 3, 3), strsub(str, 4, 4), strsub(str, 5, 5), strsub(str, 6, 6);
	
	local highvals = { ["a"] = 10, ["b"] = 11, ["c"] = 12, ["d"] = 13, ["e"] = 14, ["f"] = 15 };
	for k, v in tbl do
		if ( highvals[v] ) then
			tbl[k] = highvals[v];
		elseif ( tonumber(v) ) then
			tbl[k] = tonumber(v);
		end
	end
	local r, g, b = (tbl[1]*16+tbl[2])/255, (tbl[3]*16+tbl[4])/255, (tbl[5]*16+tbl[6])/255;
	if ( not r or r > 1 or r < 0 ) then
		r = 1;
	end
	if ( not g or g > 1 or g < 0 ) then
		g = 1;
	end
	if ( not b or b > 1 or b < 0 ) then
		b = 1;
	end
	return r, g, b;
end

function CT_RaidTracker_GetColorString(str)
	if ( not str ) then
		return 1, 1, 1;
	end
	local playerClass = UnitClass("player");
	local playerLevel = UnitLevel("player");
	local classArmor = {
		["Warrior"] = { ["Cloth"] = 1, ["Leather"] = 1, ["Mail"] = 1, ["Plate"] = 40 },
		["Paladin"] = { ["Cloth"] = 1, ["Leather"] = 1, ["Mail"] = 1, ["Plate"] = 40 },
		["Shaman"] = { ["Cloth"] = 1, ["Leather"] = 1, ["Mail"] = 40, ["Plate"] = 61 },
		["Hunter"] = { ["Cloth"] = 1, ["Leather"] = 1, ["Mail"] = 40, ["Plate"] = 61 },
		["Rogue"] = { ["Cloth"] = 1, ["Leather"] = 1, ["Mail"] = 61, ["Plate"] = 61 },
		["Druid"] = { ["Cloth"] = 1, ["Leather"] = 1, ["Mail"] = 61, ["Plate"] = 61 },
		["Warlock"] = { ["Cloth"] = 1, ["Leather"] = 61, ["Mail"] = 61, ["Plate"] = 61 },
		["Mage"] = { ["Cloth"] = 1, ["Leather"] = 61, ["Mail"] = 61, ["Plate"] = 61 },
		["Priest"] = { ["Cloth"] = 1, ["Leather"] = 61, ["Mail"] = 61, ["Plate"] = 61 },
		["Warlock"] = { ["Cloth"] = 1, ["Leather"] = 61, ["Mail"] = 61, ["Plate"] = 61 }
	};
	
	
	-- Equip:
	if ( string.find(str, "^Equip: ") ) then
		return 0, 1, 0;
		
	-- Use:
	elseif ( string.find(str, "^Use: ") ) then
		return 0, 1, 0;
		
	-- Chance on hit:
	elseif ( string.find(str, "^Chance on hit:") ) then
		return 0, 1, 0;
		
	-- Sets
	elseif ( string.find(str, "^.+ %(%d+/%d+%)$") ) then
		return 1, 0.82, 0, 1;
	
	-- Durability 0/X
	elseif ( string.find(str, "^Durability 0 / %d+$") ) then
		return 1, 0.15, 0.15;
		
	-- Wrong class
	elseif ( string.find(str, "^Classes: ") and not string.find(str, "^Classes: .*" .. playerClass) ) then
		return 1, 0.15, 0.15;
		
	-- Made by
	elseif ( string.find(str, "^<Made by .+>$") ) then
		return 0, 1, 0;
	end	
	
	-- Armor type
	if ( classArmor[playerClass][str] and classArmor[playerClass][str] > playerLevel ) then
		return 1, 0.15, 0.15;
	end
	
	-- Low level
	local iStart, iEnd, level = string.find(str, "^Requires Level (%d+)$");
	if ( level and tonumber(level) > playerLevel ) then
		return 1, 0.15, 0.15;
	end
	return 1, 1, 1;
end

function CT_RaidTrackerItem_SetHyperlink()
	local raidid = this.raidid;
	local lootid = this.itemid;
	if ( CT_RaidTracker_RaidLog[raidid] and CT_RaidTracker_RaidLog[raidid]["Loot"][lootid] ) then
		local item = CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"];
		for i = 1, 30, 1 do
			getglobal("CT_RTTooltipTextLeft" .. i):SetText("");
			getglobal("CT_RTTooltipTextLeft" .. i):Hide();
			getglobal("CT_RTTooltipTextRight" .. i):SetText("");
			getglobal("CT_RTTooltipTextRight" .. i):Hide();
		end
		if ( not item["tooltip"] ) then
			local tTooltip = { };
			CT_RTTooltip:SetHyperlink("item:" .. item["id"]);
			for i = 1, CT_RTTooltip:NumLines(), 1 do
				local tl, tr;
				if ( getglobal("CT_RTTooltipTextLeft" .. i):IsVisible() ) then
					tl = getglobal("CT_RTTooltipTextLeft" .. i):GetText();
				end
				if ( getglobal("CT_RTTooltipTextRight" .. i):IsVisible() ) then
					tr = getglobal("CT_RTTooltipTextRight" .. i):GetText();
				end
				tinsert(tTooltip, { ["left"] = tl, ["right"] = tr });
			end
			CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"]["tooltip"] = tTooltip;
			item["tooltip"] = tTooltip;
		end
		for i = 1, 30, 1 do
			getglobal("CT_RTTooltipTextLeft" .. i):SetText("");
			getglobal("CT_RTTooltipTextLeft" .. i):Hide();
			getglobal("CT_RTTooltipTextRight" .. i):SetText("");
			getglobal("CT_RTTooltipTextRight" .. i):Hide();
		end
		CT_RTTooltip:SetOwner(this, "ANCHOR_RIGHT");
		
		local hasShownSet;
		for k, v in item["tooltip"] do
			local rl, gl, bl, rr, gr, br;
			if ( k == 1 ) then
				rl, gl, bl = CT_RaidTracker_ColorToRGB(item["c"]);
			end
			if ( v["right"] ) then
				rl, gl, bl, hasShownSet = CT_RaidTracker_GetColorString(v["left"]);
				rr, gr, br = CT_RaidTracker_GetColorString(v["right"]);
				CT_RTTooltip:AddDoubleLine(v["left"], v["right"], rl, gl, bl, rr, gr, br);
			else
				if ( hasShownSet ) then
					CT_RTTooltip:AddLine(v["left"], 0.5, 0.5, 0.5);	
				else
					if ( not rl and not gl and not bl ) then
						rl, gl, bl, hasShownSet = CT_RaidTracker_GetColorString(v["left"]);
					end
					CT_RTTooltip:AddLine(v["left"], rl, gl, bl);
				end
			end
		end
		CT_RTTooltip:Show();
		return;
	end
end

function CT_RaidTrackerItem_GetChatHyperlink()
	local raidid = this.raidid;
	local lootid = this.itemid;
	if ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and CT_RaidTracker_RaidLog[raidid] and CT_RaidTracker_RaidLog[raidid]["Loot"][lootid] ) then
		local item = CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"];
		ChatFrameEditBox:Insert("|c" .. item.c .. "|Hitem:" .. item.id .. "|h[" .. item.name .. "]|h|r");
	end
end

CT_RaidTracker_RaidLog = { };
CT_RaidTracker_GetCurrentRaid = nil;

-- Debug flag

CT_RaidTracker_DebugFlag = nil;

-- Debug function(s)

function CT_RaidTracker_Debug(...)
	if ( CT_RaidTracker_DebugFlag ) then
		local sDebug = "#";
		for i = 1, arg.n, 1 do
			if ( arg[i] ) then
				sDebug = sDebug .. arg[i] .. "#";
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(sDebug, 1, 0.5, 0);
	end
end
		

-- OnFoo functions

function CT_RaidTracker_OnLoad()
	CT_RaidTrackerTitleText:SetText("CT_RaidTracker " .. CT_RaidTracker_Version);
	-- Register events
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
end

function CT_RaidTracker_OnEvent(event)
	if ( CT_RaidTracker_UpdateFrame.time and CT_RaidTracker_UpdateFrame.time <= 2 ) then
		tinsert(CT_RaidTracker_Events, event);
		return;
	end
	if ( event == "RAID_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" ) then
		if ( GetNumRaidMembers() == 0 and event == "RAID_ROSTER_UPDATE" ) then
			if ( CT_RaidTracker_GetCurrentRaid ) then
				CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["raidEnd"] = CT_RaidTracker_Date();
			end
			CT_RaidTracker_GetCurrentRaid = nil;
			CT_RaidTracker_Debug("Left raid.");
			CT_RaidTracker_Offline = { };
		elseif ( not CT_RaidTracker_GetCurrentRaid and GetNumRaidMembers() > 0 and event == "RAID_ROSTER_UPDATE" ) then
			local sDate = CT_RaidTracker_Date();
			tinsert(CT_RaidTracker_RaidLog, 1, { 
				["Loot"] = { },
				["Join"] = { },
				["Leave"] = { },
				["Notes"] = { },
				["key"] = sDate
			});
			CT_RaidTracker_SortRaidTable();
			CT_RaidTracker_GetCurrentRaid = 1;
			for i = 1, GetNumRaidMembers(), 1 do
				tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Join"],
					{
						["player"] = UnitName("raid" .. i),
						["time"] = sDate
					}
				);
				local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
				if ( not online ) then
					tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
						{
							["player"] = UnitName("raid" .. i),
							["time"] = sDate
						}
					);
				end
			end
			CT_RaidTracker_Debug("Joined new raid at " .. sDate);
			CT_RaidTracker_Update();
			CT_RaidTracker_UpdateView();
		end
		if ( not CT_RaidTracker_GetCurrentRaid ) then
			return;
		end
		local updated;
		for i = 1, GetNumRaidMembers(), 1 do
			local name, online = UnitName("raid" .. i), UnitIsConnected("raid" .. i);
			if ( name ) then
				if ( online ~= CT_RaidTracker_Online[name] ) then
					-- Status isn't updated
					if ( not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid] ) then
						CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid] = { 
							["Loot"] = { },
							["Join"] = { },
							["Leave"] = { },
							["Notes"] = { }
						};
					end
					if ( not online ) then
						tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
							{
								["player"] = name,
								["time"] = CT_RaidTracker_Date()
							}
						);
						CT_RaidTracker_Debug("OFFLINE", name);
					else
						tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Join"],
							{
								["player"] = name,
								["time"] = CT_RaidTracker_Date()
							}
						);
						CT_RaidTracker_Debug("ONLINE", name);
					end
					updated = 1;
				end
				CT_RaidTracker_Online[name] = online;
			end
		end
		if ( updated ) then
			CT_RaidTracker_Update();
			CT_RaidTracker_UpdateView();
		end
	elseif ( event == "CHAT_MSG_LOOT" and CT_RaidTracker_GetCurrentRaid ) then
		local sPlayer, sLink;
		local iStart, iEnd, sPlayerName, sItem = string.find(arg1, "([^%s]+) receives loot: (.+)%.");
		if ( sPlayerName ) then
			sPlayer = sPlayerName;
			sLink = sItem;
		else
			local iStart, iEnd, sItem = string.find(arg1, "You receive loot: (.+)%.");
			if ( sItem ) then
				sPlayer = UnitName("player");
				sLink = sItem;
			end
		end
		
		-- Make sure there is a link
		if ( sLink and sPlayer ) then
			local sColor, sItem, sName, tTooltip = CT_RaidTracker_GetItemInfo(sLink);
			if ( sColor and sItem and sName and tTooltip and CT_RaidTracker_RarityTable[sColor] ) then
				-- Insert into table
				if ( not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid] ) then
					CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid] = { 
						["Loot"] = { },
						["Join"] = { },
						["Leave"] = { },
						["Notes"] = { }
					};
				end
				local found;
				for k, v in CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"] do
					if ( v["item"]["name"] == sName and v["player"] == sPlayer ) then
						if ( v["item"]["count"] ) then
							CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"][k]["item"]["count"] = v["item"]["count"]+1;
						else
							CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"][k]["item"]["count"] = 1;
						end
						found = 1;
						break;
					end
				end
				if ( not found ) then
					tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"],
						{
							["player"] = sPlayer,
							["item"] = {						
								["c"] = sColor,
								["id"] = sItem,
								["tooltip"] = tTooltip,
								["name"] = sName,
								["count"] = 1,
								["type"] = CT_RaidTracker_GetItemType("item:"..sItem)
							},
							["time"] = CT_RaidTracker_Date()
						}
					);
				end
				CT_RaidTracker_Debug(sPlayer, sColor, sItem, sName);
				CT_RaidTracker_Update();
				CT_RaidTracker_UpdateView();
			end
		end
	elseif ( event == "CHAT_MSG_SYSTEM" and UnitName("player") and UnitName("player") ~= "Unknown Being" and CT_RaidTracker_GetCurrentRaid ) then
		local sDate = CT_RaidTracker_Date();
		local iStart, iEnd, sPlayer = string.find(arg1, "([^%s]+) has left the raid group");
		if ( sPlayer and sPlayer ~= UnitName("player") and UnitName("player") and UnitName("player") ~= "Unknown Entity" ) then
			tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
				{
					["player"] = sPlayer,
					["time"] = sDate
				}
			);
			CT_RaidTracker_Debug(sPlayer, "LEFT");
		end
		local iStart, iEnd, sPlayer = string.find(arg1, "([^%s]+) has joined the raid group");
		if ( sPlayer and sPlayer ~= UnitName("player") ) then
			tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Join"],
				{
					["player"] = sPlayer,
					["time"] = sDate
				}
			);
			CT_RaidTracker_Debug(sPlayer, "JOIN");
		end
		CT_RaidTracker_UpdateView();
		CT_RaidTracker_Update();
	elseif ( event == "VARIABLES_LOADED" ) then
		CT_RaidTracker_ConvertFormat();
	end
end

-- Item functions

function CT_RaidTracker_GetItemInfo(sItem)
	-- Thanks to Telo for the following regular expression
	local iStart, iEnd, sColor, sItemName, sName = string.find(sItem, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r");
	if ( sColor and sItemName and sName ) then
		local tTooltip = { };
		for i = 1, 30, 1 do
			getglobal("CT_RTTooltipTextLeft" .. i):SetText("");
			getglobal("CT_RTTooltipTextLeft" .. i):Hide();
			getglobal("CT_RTTooltipTextRight" .. i):SetText("");
			getglobal("CT_RTTooltipTextRight" .. i):Hide();
		end
		CT_RTTooltip:SetHyperlink("item:" .. sItemName);
		for i = 1, CT_RTTooltip:NumLines(), 1 do
			local tl, tr;
			if ( getglobal("CT_RTTooltipTextLeft" .. i):IsVisible() ) then
				tl = getglobal("CT_RTTooltipTextLeft" .. i):GetText();
			end
			if ( getglobal("CT_RTTooltipTextRight" .. i):IsVisible() ) then
				tr = getglobal("CT_RTTooltipTextRight" .. i):GetText();
			end
			tinsert(tTooltip, { ["left"] = tl, ["right"] = tr });
		end
		return sColor, sItemName, sName, tTooltip;
	end
end

SlashCmdList["RAIDTRACKER"] = function(msg)
	ShowUIPanel(CT_RaidTrackerFrame);
end

SLASH_RAIDTRACKER1 = "/raidtracker";
SLASH_RAIDTRACKER2 = "/rt";

function CT_RaidTracker_Print(msg, r, g, b)
	if ( CT_Print ) then
		CT_Print(msg, r, g, b);
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
	end
end

function CT_RaidTracker_RarityDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RaidTracker_RarityDropDown_Initialize);
	--UIDropDownMenu_SetWidth(130);
	UIDropDownMenu_SetSelectedID(CT_RaidTrackerRarityDropDown, 1);
end

-- Green = 1eff00
-- Blue = 0070dd
-- Purple = a335ee
-- Orange = ff8000

function CT_RaidTracker_RarityDropDown_Initialize()
	local info = {};
	info.text = "|c001eff00Uncommon|r";
	info.func = CT_RaidTracker_RarityDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "|c000070ddRare|r";
	info.func = CT_RaidTracker_RarityDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "|c00a335eeEpic|r";
	info.func = CT_RaidTracker_RarityDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "|c00ff8000Legendary|r";
	info.func = CT_RaidTracker_RarityDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end


function CT_RaidTracker_RarityDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(CT_RaidTrackerRarityDropDown, this:GetID());
	if ( CT_RaidTrackerFrame.type == "items" ) then
		CT_RaidTracker_SortOptions["itemfilter"] = this:GetID();
	else
		CT_RaidTracker_SortOptions["playeritemfilter"] = this:GetID();
	end
	CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_SelectItem(name)
	CT_RaidTracker_GetPage();
	CT_RaidTrackerFrame.type = "itemhistory";
	CT_RaidTrackerFrame.itemname = name;
	CT_RaidTrackerFrame.selected = nil;
	CT_RaidTracker_Update();
	CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_GetPage()
	if ( CT_RaidTrackerFrame.type or CT_RaidTrackerFrame.itemname or CT_RaidTrackerFrame.selected or CT_RaidTrackerFrame.player ) then

		tinsert(CT_RaidTracker_LastPage,
			{
				["type"] = CT_RaidTrackerFrame.type,
				["itemname"] = CT_RaidTrackerFrame.itemname,
				["selected"] = CT_RaidTrackerFrame.selected,
				["player"] = CT_RaidTrackerFrame.player
			}
		);
	end

	if ( getn(CT_RaidTracker_LastPage) > 0 ) then
		CT_RaidTrackerFrameBackButton:Enable();
	else
		CT_RaidTrackerFrameBackButton:Disable();
	end
end

function CT_RaidTracker_GoBack()
	local t = table.remove(CT_RaidTracker_LastPage);

	if ( t ) then
		CT_RaidTrackerFrame.type = t["type"];
		CT_RaidTrackerFrame.itemname = t["itemname"];
		CT_RaidTrackerFrame.selected = t["selected"];
		CT_RaidTrackerFrame.player = t["player"];
		CT_RaidTracker_Update();
		CT_RaidTracker_UpdateView();
	end
	if ( getn(CT_RaidTracker_LastPage) > 0 ) then
		CT_RaidTrackerFrameBackButton:Enable();
	else
		CT_RaidTrackerFrameBackButton:Disable();
	end
end

function CT_RaidTracker_ConvertFormat()
	-- Called because of old format used during development

	for k, v in CT_RaidTracker_RaidLog do
		if ( not v["Notes"] ) then
			CT_RaidTracker_RaidLog[k]["Notes"] = { };
		end
	end
end

if ( CT_RegisterMod ) then
	CT_RaidTracker_DisplayWindow = function()
		ShowUIPanel(CT_RaidTrackerFrame);
	end
	CT_RegisterMod("Raid Tracker", "Display window", 5, "Interface\\Icons\\INV_Chest_Chain_05", "Displays the Raid Tracker window, which tracks raid loot & attendance.", "switch", "", CT_RaidTracker_DisplayWindow);
else
	CT_RaidTracker_Print("<CTMod> CT_RaidTracker loaded. Type /rt to show the RaidTracker window.", 1, 1, 0);
end

function CT_RaidTracker_FixZero(num)
	if ( num < 10 ) then
		return "0" .. num;
	else
		return num;
	end
end

function CT_RaidTracker_Date()
	local t = date("*t");

	return CT_RaidTracker_FixZero(t.month) .. "/" .. CT_RaidTracker_FixZero(t.day) .. "/" .. strsub(t.year, 3) .. " " .. CT_RaidTracker_FixZero(t.hour) .. ":" .. CT_RaidTracker_FixZero(t.min) .. ":" .. CT_RaidTracker_FixZero(t.sec);
end

function CT_RaidTrackerUpdateFrame_OnUpdate(elapsed)
	if ( this.time ) then
		this.time = this.time + elapsed;
		if ( this.time > 2 ) then
			this.time = nil;
			for k, v in CT_RaidTracker_Events do
				CT_RaidTracker_OnEvent(v);
			end
		end
	end
end

function CT_RaidTracker_SelectRaidUpdate()
	local numEntries = getn(CT_RaidTracker_RaidLog);

	FauxScrollFrame_Update(CT_RaidTracker_SelectRaidFrameScrollFrame, numEntries, 20, 20);

	for i = 1, 20, 1 do
		local button = getglobal("CT_RaidTracker_SelectRaidFrameRaid" .. i);
		local index = i + FauxScrollFrame_GetOffset(CT_RaidTracker_SelectRaidFrameScrollFrame);
		if ( index <= numEntries ) then
			if ( numEntries <= 20 ) then
				button:SetWidth(260);
			else
				button:SetWidth(245);
			end
			button:Show();
			getglobal(button:GetName() .. "Name"):SetText(CT_RaidTracker_RaidLog[index].key);
			--getglobal(button:GetName() .. "Info"):SetText(CT_RADurability_Shown[index][2]);
		else
			button:Hide();
		end
	end

end
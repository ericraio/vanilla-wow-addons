function CT_RABoss_OnLoad()
	this.elapsed = 0;
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

-- Function to open option sets frame
function CT_RABoss_OnClick()
	CT_RAMenuFrameHome:Hide();
	ShowUIPanel(CT_RAMenuFrameBoss);
end

-- Hook old ShowHome() function to also hide boss mods
CT_RABoss_oldCT_RAMenu_ShowHome = CT_RAMenu_ShowHome;
function CT_RABoss_newCT_RAMenu_ShowHome()
	CT_RABoss_oldCT_RAMenu_ShowHome();
	CT_RAMenuFrameBoss:Hide();
end
CT_RAMenu_ShowHome = CT_RABoss_newCT_RAMenu_ShowHome;

-- Hook old OnShow() function to also scale boss mods
CT_RABoss_oldCT_RAMenu_OnShow = CT_RAMenu_OnShow;
function CT_RABoss_newCT_RAMenu_OnShow()
	CT_RABoss_oldCT_RAMenu_OnShow();
	-- Reposition the top menu button in CTRA
	CT_RAMenuFrameHomeButton1:SetPoint("TOPLEFT", 20, -208);
	CT_RAMenuFrameHomeButton7:SetScale(0.9111);
	CT_RAMenuFrameHomeButton7Description:SetText("Several features to aid you in killing raid bosses.");
	CT_RAMenuFrameHomeButton7Text:SetText("Boss Mods");
end
CT_RAMenu_OnShow = CT_RABoss_newCT_RAMenu_OnShow;

function CT_RAMenuBoss_SortTable(t1, t2)
	local locs = { };
	for k, v in CT_RABoss_Locations do
		locs[v[1]] = k;
	end
	if ( t1[2] and t2[2] ) then
		return locs[t1[1]] < locs[t2[1]];
	else
		local loc1, loc2;
		if ( t1[2] ) then
			loc1 = locs[t1[1]];
		else
			loc1 = locs[t1[4]];
		end
		if ( t2[2] ) then
			loc2 = locs[t2[1]];
		else
			loc2 = locs[t2[4]];
		end
		if ( loc1 == loc2 ) then
			if ( t1[2] or t2[2] ) then
				return (t1[2]);
			else
				return t1[1] < t2[1];
			end
		else
			return loc1 < loc2;
		end
	end
end

function CT_RAMenuBoss_CalculateEntries()
	local locIndexes = { };
	local tbl = { };
	local numPerLoc = { };
	
	-- Calculate number of mods per location
	for k, v in CT_RABoss_Mods do
		local loc = v["location"];
		if ( not loc ) then
			loc = "Other";
		end
		if ( not numPerLoc[loc] ) then
			numPerLoc[loc] = 1;
		else
			numPerLoc[loc] = numPerLoc[loc] + 1;
		end
	end
	-- Populate the locIndexes table with the locations we have
	for k, v in CT_RABoss_Locations do
		-- Only add if there are mods for it
		if ( numPerLoc[v[1]] ) then
			locIndexes[v[1]] = v[2];
			tinsert(tbl, { v[1], 1, v[2] });
		end
	end
	
	-- Calculate which records to add
	for k, v in CT_RABoss_Mods do
		if ( not v["location"] ) then
			v["location"] = "Other";
		end
		if ( locIndexes[v["location"]] and locIndexes[v["location"]] == 1 ) then
			tinsert(tbl, { k, nil, v, v["location"] });
		end
	end
	
	-- Sort the table
	table.sort(tbl, CT_RAMenuBoss_SortTable);
	
	return tbl, numPerLoc;
end

function CT_RAMenuBoss_ToggleHeader(name)
	for k, v in CT_RABoss_Locations do
		if ( v[1] == name ) then
			if ( v[2] == 1 ) then
				CT_RABoss_Locations[k][2] = 0;
			else
				CT_RABoss_Locations[k][2] = 1;
			end
			break;
		end
	end
	CT_RAMenuBoss_Update();
end

function CT_RAMenuBoss_Update()
	local tbl, numPerLoc = CT_RAMenuBoss_CalculateEntries();
	local numEntries = getn(tbl);
	-- ScrollFrame update
	FauxScrollFrame_Update(CT_RAMenuFrameBossScrollFrame, numEntries, 10, 25 );
	
	for i=1, 10, 1 do
		local obj = getglobal("CT_RAMenuFrameBossMod" .. i);
		local nameText = getglobal("CT_RAMenuFrameBossMod" .. i .. "Name");
		local descriptText = getglobal("CT_RAMenuFrameBossMod" .. i .. "Descript");
		local statusText = getglobal("CT_RAMenuFrameBossMod" .. i .. "Status");
		local line = getglobal("CT_RAMenuFrameBossMod" .. i .. "Line");
		local dropdown = getglobal("CT_RAMenuFrameBossMod" .. i .. "Menu");
		local plusMinus = getglobal("CT_RAMenuFrameBossMod" .. i .. "ShowHide");
		local prevLine = getglobal("CT_RAMenuFrameBossMod" .. i-1 .. "Line");
		
		local index = i + FauxScrollFrame_GetOffset(CT_RAMenuFrameBossScrollFrame); 
		if ( index <= numEntries ) then
			obj:Show();
			line:Hide();
			if ( not tbl[index][2] ) then
				-- Not a header
				obj.header = nil;
				nameText:SetText(tbl[index][1]);
				nameText:SetTextColor(0.5, 0.5, 0.5);
				nameText:ClearAllPoints();
				nameText:SetPoint("TOPLEFT", obj:GetName(), "TOPLEFT", 45, 0);
				plusMinus:Hide();
				if ( tbl[index][3]["status"] ) then
					statusText:SetText("On");
					statusText:SetTextColor(0, 1, 0);
				else
					statusText:SetText("Off");
					statusText:SetTextColor(1, 0, 0);
				end
				if ( tbl[index][3]["descript"] ) then
					descriptText:SetText(tbl[index][3]["descript"]);
				else
					descriptText:SetText("");
				end
				obj.index = tbl[index][1];
				if ( not obj.hasBeenInitialized ) then
					UIDropDownMenu_Initialize(dropdown,  CT_RAMenuBoss_InitDropDown, "MENU");
					obj.hasBeenInitialized = 1;
				end
			else
				if ( prevLine ) then
					prevLine:Show();
				end
				-- Header
				obj.header = 1;
				obj.headername = tbl[index][1];
				local num = numPerLoc[tbl[index][1]];
				if ( not num ) then
					num = 0;
				end
				plusMinus:Show();
				if ( tbl[index][3] == 1 ) then
					if ( obj.mouseIsOver ) then
						GameTooltip:SetText("Click to contract");
					end
					plusMinus:SetText("-");
					obj.expanded = 1;
				else
					if ( obj.mouseIsOver ) then
						GameTooltip:SetText("Click to expand");
					end
					plusMinus:SetText("+");
					obj.expanded = nil;
				end
				nameText:SetText(tbl[index][1] .. " (" .. num .. ")");
				nameText:SetTextColor(1, 1, 1);
				nameText:ClearAllPoints();
				nameText:SetPoint("LEFT", obj:GetName(), "LEFT", 12, 0);
				statusText:SetText("");
				descriptText:SetText("");
			end
		else
			obj:Hide();
		end
	end
end

function CT_RAMenuBoss_InitDropDown()
	local modName = getglobal(UIDROPDOWNMENU_INIT_MENU):GetParent().index;
	local info = {};
	
	info.text = modName;
	info.isTitle = 1;
	info.justifyH = "CENTER";
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	info.text = "Enable mod";
	info.tooltipTitle = "Enable mod";
	info.tooltipText = "Enables the mod, turning on all enabled options.";
	info.checked = CT_RABoss_Mods[modName]["status"];
	info.func = CT_RABoss_EnableMod;
	info.keepShownOnClick = 1;
	info.value = modName;
	UIDropDownMenu_AddButton(info);
	
	if ( CT_RABoss_DropDown[modName] ) then
		for k, v in CT_RABoss_DropDown[modName] do
			info = { };
			info.value = { modName, v[3] };
			info.keepShownOnClick = 1;
			if ( type(v[1]) == "string" ) then
				info.text = v[1];
			elseif ( type(v[1]) == "table" ) then
				info.text = v[1][1];
				info.tooltipTitle = v[1][1];
				info.tooltipText = v[1][2];
			end
			if ( type(getglobal(v[2])) == "function" ) then
				info.checked = getglobal(v[2])(modName, v[3]);
			else
				info.checked = getglobal(v[2]);
			end
			info.func = getglobal(v[4]);
			UIDropDownMenu_AddButton(info);
		end
	end
end

function CT_RABoss_LoadMods()
	for k, v in CT_RABoss_ModsToLoad do
		if ( getglobal(v) ) then
			getglobal(v)();
		end
	end
end

-- Slash command to enable/disable debug
CT_RA_RegisterSlashCmd("/rabossdebug", "Toggles boss mod debugging.", 15, "RABOSSDEBUG", function(msg)
	local level;
	if ( strlen(msg) > 0 and tonumber(msg) >= 1 and tonumber(msg) <= 5 ) then
		level = tonumber(msg);
	end
	if ( not level ) then
		if ( CT_RABoss_DebugLevels["enableDebug"] ) then
			CT_RA_Print("<CTRaid> Boss mod debugging is now |c00FF0000disabled|r.", 1, 0.5, 0);
			CT_RABoss_DebugLevels["enableDebug"] = false;
		else
			CT_RA_Print("<CTRaid> Boss mod debugging is now |c0000FF00enabled.", 1, 0.5, 0);
			CT_RABoss_DebugLevels["enableDebug"] = true;
		end
	else
		if ( CT_RABoss_DebugLevels[level] ) then
			CT_RA_Print("<CTRaid> Boss mod debugging for |c00FFFFFFlevel " .. level .. "|r is now |c00FF0000disabled|r.", 1, 0.5, 0);
			CT_RABoss_DebugLevels[level] = false;
		else
			CT_RA_Print("<CTRaid> Boss mod debugging for |c00FFFFFFlevel " .. level .. "|r is now |c0000FF00enabled.", 1, 0.5, 0);
			CT_RABoss_DebugLevels[level] = true;
		end
	end
end, "/rabossdebug", "/rabd");
-- Global Channel Variable
CT_CHAT_CHANNEL = "CTGlobalChat";
CT_UserMap_Notes = { };
CT_UserMap_Zone = { };
CT_UserMap_Zone["Blackrock Spire"] = 4;
CT_UserMap_Zone["Alterac Mountains"] = 1;
CT_UserMap_Zone["Arathi Highlands"] = 2;
CT_UserMap_Zone["Badlands"] = 3;
CT_UserMap_Zone["Blasted Lands"] = 5;
CT_UserMap_Zone["Tirisfal Glades"] = 6;
CT_UserMap_Zone["Silverpine Forest"] = 7;
CT_UserMap_Zone["Western Plaguelands"] = 8;
CT_UserMap_Zone["Eastern Plaguelands"] = 9;
CT_UserMap_Zone["Hillsbrad Foothills"] = 10;
CT_UserMap_Zone["The Hinterlands"] = 11;
CT_UserMap_Zone["Dun Morogh"] = 12;
CT_UserMap_Zone["Searing Gorge"] = 13;
CT_UserMap_Zone["Burning Steppes"] = 14;
CT_UserMap_Zone["Elwynn Forest"] = 15;
CT_UserMap_Zone["Darrowmere Lake"] = 16;
CT_UserMap_Zone["Deadwind Pass"] = 17;
CT_UserMap_Zone["Duskwood"] = 18;
CT_UserMap_Zone["Loch Modan"] = 19;
CT_UserMap_Zone["Redridge Mountains"] = 20;
CT_UserMap_Zone["Stranglethorn Vale"] = 21;
CT_UserMap_Zone["Swamp of Sorrows"] = 22;
CT_UserMap_Zone["Westfall"] = 23;
CT_UserMap_Zone["Wetlands"] = 24;
CT_UserMap_Zone["Stonetalon Mountains"] = 25;
CT_UserMap_Zone["Dustwallow Marsh"] = 26;
CT_UserMap_Zone["Feralas"] = 27;
CT_UserMap_Zone["Tanaris"] = 28;
CT_UserMap_Zone["Durotar"] = 29;
CT_UserMap_Zone["Mulgore"] = 30;
CT_UserMap_Zone["The Barrens"] = 31;
CT_UserMap_Zone["Teldrassil"] = 32;
CT_UserMap_Zone["Darkshore"] = 33;
CT_UserMap_Zone["Ashenvale"] = 34;
CT_UserMap_Zone["Desolace"] = 35;
CT_UserMap_Zone["Thousand Needles"] = 36;
CT_UserMap_Zone["Azshara"] = 37;
CT_UserMap_Zone["Felwood"] = 38;
CT_UserMap_Zone["Un'Goro Crater"] = 39;
CT_UserMap_Zone["Moonglade"] = 40;
CT_UserMap_Zone["Stormwind City"] = 41;
CT_UserMap_Zone["Ironforge"] = 42;
CT_UserMap_Zone["Undercity"] = 43;
CT_UserMap_Zone["Darnassus"] = 44;
CT_UserMap_Zone["Durotar"] = 45;
CT_UserMap_Zone["Orgrimmar"] = 46;
CT_UserMap_Zone["Silithus"] = 47;
CT_UserMap_Zone["Thunder Bluff"] = 48;
CT_UserMap_Zone["Winterspring"] = 49;
CT_MapMod_Options = { };

CT_UserMap_Icons = { "GreyNote", "BlueShield", "RedDot", "WhiteCircle", "GreenSquare", "RedCross", "Herb", "Ore" };
CT_UserMap_HerbIcons = { 
						"Herb_Bruiseweed", "Herb_ArthasTears", "Herb_BlackLotus", "Herb_Blindweed", "Herb_Briarthorn",
						"Herb_Dreamfoil", "Herb_Earthroot", "Herb_Fadeleaf", "Herb_Firebloom", "Herb_GhostMushroom",
						"Herb_GoldenSansam", "Herb_Goldthorn", "Herb_GraveMoss", "Herb_Gromsblood", "Herb_Icecap",
						"Herb_KhadgarsWhisker", "Herb_Kingsblood", "Herb_Liferoot", "Herb_Mageroyal", "Herb_MountainSilversage",
						"Herb_Peacebloom", "Herb_Plaguebloom", "Herb_PurpleLotus", "Herb_Silverleaf", "Herb_Stranglekelp",
						"Herb_Sungrass", "Herb_Swiftthistle", "Herb_WildSteelbloom", "Herb_Wintersbite", "Ore_CopperVein",
						"Ore_GoldVein", "Ore_IronVein", "Ore_MithrilVein", "Ore_SilverVein", "Ore_ThoriumVein", "Ore_TinVein", "Ore_TruesilverVein"
					};
	

CT_NUM_USERMAP_NOTES = 250;
CT_UserMap_CreateNote = 1;
CT_LastMessage = {};

CT_Hooked_WorldMapButton_OnClick = WorldMapButton_OnClick;
function CT_WorldMapButton_OnClickHook(mouseButton, button)
	if ( mouseButton == "LeftButton" ) then
		if ( not button ) then
			button = this;
		end
		local zone = WorldMapZoneDropDownText:GetText();
		local cX, cY = GetCursorPosition();
		local ceX, ceY = WorldMapFrame:GetCenter();
		local wmfw, wmfh = WorldMapButton:GetWidth(), WorldMapButton:GetHeight();
		
		cX = ( ( ( cX / WorldMapFrame:GetScale() ) - ( ceX - wmfw / 2 ) ) / wmfw + 22/10000 );
		cY = ( ( ( ( ceY + wmfh / 2 ) - ( cY / WorldMapFrame:GetScale() ) ) / wmfh ) - 262/10000 );

		local zone = WorldMapZoneDropDownText:GetText();

		if ( IsControlKeyDown() ) then
			local id = CT_MapMod_AddNote(cX, cY, zone, "New note", "", 1, 1);
			CT_UserMap_OptionsMenu.note = id;
			CT_UserMap_OptionsMenu.zone = zone;
			CT_UserMap_OptionsMenu:Show();
		else
			CT_Hooked_WorldMapButton_OnClick(mouseButton, button);
		end
	else
		CT_Hooked_WorldMapButton_OnClick(mouseButton, button);
	end
end

function CT_MapMod_CreateNoteOnPlayer()
	local x, y = GetPlayerMapPosition("player");
	if ( x ~= 0 and y ~= 0 ) then
		local id = CT_MapMod_AddNote(x, y, WorldMapZoneDropDownText:GetText(), "New note", "", 1, 1);
		CT_UserMap_OptionsMenu.note = id;
		CT_UserMap_OptionsMenu.zone = WorldMapZoneDropDownText:GetText();
		CT_UserMap_OptionsMenu:Show();
	end
end

WorldMapButton_OnClick = CT_WorldMapButton_OnClickHook;

CT_Hooked_WorldMapButton_OnUpdate = WorldMapButton_OnUpdate;
function CT_WorldMapButton_OnUpdateHook(arg)
	CT_Hooked_WorldMapButton_OnUpdate(arg);
	local i, y = 0;


	if ( not CT_UserMap_Notes[WorldMapZoneDropDownText:GetText()] ) then
		for i = 1, CT_NUM_USERMAP_NOTES, 1 do
			getglobal("CT_UserMap_Note" .. i):Hide();
		end
		CT_NumNotes:SetText("Map Notes: |c00FFFFFF0|r/|c00FFFFFF250|r");
		return;
	end

	-- Calculate what notes to show
	local y = 1;
	for i, var in CT_UserMap_Notes[WorldMapZoneDropDownText:GetText()] do
		if ( y > CT_NUM_USERMAP_NOTES ) then
			break;
		end		
		if ( not CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].hideGroups[CT_MAPMOD_SETS[(var.set or 1)]] and ( not CT_MapMod_Filter or string.find(strlower(var.name), strlower(CT_MapMod_Filter)) or string.find(strlower(var.descript), strlower(CT_MapMod_Filter)) ) ) then
			local note = getglobal("CT_UserMap_Note" .. y);
			local IconTexture = getglobal("CT_UserMap_Note" .. y .."Icon");
			
			if ( var.set == 7 or var.set == 8 ) then
				local offset = 0;
				if ( var.set == 8 ) then
					offset = 29;
				end
				if ( CT_UserMap_HerbIcons[var.icon+offset] ) then
					IconTexture:SetTexture("Interface\\AddOns\\CT_MapMod\\Resource\\" .. CT_UserMap_HerbIcons[var.icon+offset]);
				else
					IconTexture:SetTexture("Interface\\AddOns\\CT_MapMod\\Resource\\Herb_Bruiseweed");
				end
			else
				IconTexture:SetTexture("Interface\\AddOns\\CT_MapMod\\Skin\\" .. CT_UserMap_Icons[var.set]);
			end
			note:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", var.x*WorldMapButton:GetWidth(), -var.y*WorldMapButton:GetHeight());			
			note:Show();
			
			if ( not var.name ) then var.name = ""; end
			if ( not var.set or not CT_MAPMOD_SETS[var.set] ) then var.set = 1; end
			if ( not var.descript ) then var.descript = ""; end
	
			note.name = var.name;
			note.set = CT_MAPMOD_SETS[var.set];
			note.descript = var.descript;
			note.id = i;
			note.x = var.x;
			note.y = var.y;
			y = y + 1;
		end
	end
	CT_NumNotes:SetText("Map Notes: |c00FFFFFF" .. y-1 .. "|r/|c00FFFFFF250|r");
	for i = y, CT_NUM_USERMAP_NOTES, 1 do
		getglobal("CT_UserMap_Note" .. i):Hide();
	end
end
WorldMapButton_OnUpdate = CT_WorldMapButton_OnUpdateHook;

function CT_MapMod_AddNote(x, y, zone, text, descript, icon, set)
	local group;
	if ( tonumber(set) ) then
		group = tonumber(set);
	else
		group = set;
	end
	if ( not CT_UserMap_Notes[zone] ) then
		CT_UserMap_Notes[zone] = { };
	end
	local temp = { ["x"] = x, ["y"] = y, ["name"] = text, ["descript"] = descript, ["icon"] = icon, ["set"] = group };
	tinsert(CT_UserMap_Notes[zone], temp);
	return getn(CT_UserMap_Notes[zone]);
end

function CT_MapMod_OnNoteOver()
	local x, y = this:GetCenter();
	local parentX, parentY = WorldMapButton:GetCenter();
	if ( x > parentX ) then
		WorldMapTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		WorldMapTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	WorldMapTooltip:ClearLines();

	WorldMapTooltip:AddDoubleLine(this.name, this.set, 0, 1, 0, 0.6, 0.6, 0.6);
	if ( this.descript ) then
		WorldMapTooltip:AddLine(this.descript, nil, nil, nil, 1);
	end
	WorldMapTooltip:Show();
end

function CT_MapMod_OnClick(btn)
	if ( btn == "LeftButton" ) then return; end
	CT_UserMap_OptionsMenu.note = this.id;
	CT_UserMap_OptionsMenu.zone = WorldMapZoneDropDownText:GetText();
	CT_UserMap_OptionsMenu:Show();
end

function CT_MapMod_OptionsMenu_OnShow()
	CT_UserMapFrame:Hide();
	if ( not UIDROPDOWNMENU_OPEN_MENU ) then
		UIDROPDOWNMENU_OPEN_MENU = "CT_UserMap_OptionsMenuGroupDropDown";
	end
	local note = CT_UserMap_Notes[this.zone][this.note];
	CT_UserMap_OptionsMenuNameEB:SetText(note["name"]);
	CT_UserMap_OptionsMenuNameEB:HighlightText();
	CT_UserMap_OptionsMenuDescriptEB:SetText(note["descript"]);
	CT_UserMap_OptionsMenuSendButton:Disable();
	CT_UserMap_OptionsMenuSendEB.lastsend = "";
	CT_UserMap_OptionsMenuSendEB:SetText("");

	PlaySound("UChatScrollButton");
end

function CT_MapMod_UpdateNote()
	local name, descript, set, icon;
	name = CT_UserMap_OptionsMenuNameEB:GetText();
	descript = CT_UserMap_OptionsMenuDescriptEB:GetText();
	icon = CT_UserMap_Notes[this:GetParent().zone][this:GetParent().note]["icon"];

	if ( UIDropDownMenu_GetSelectedName(CT_UserMap_OptionsMenuGroupDropDown) ) then
		set = CT_UserMap_Notes[this:GetParent().zone][this:GetParent().note]["set"];
	else
		set = UIDropDownMenu_GetSelectedID(CT_UserMap_OptionsMenuGroupDropDown);
	end


	CT_UserMap_Notes[this:GetParent().zone][this:GetParent().note]["name"] = name;
	CT_UserMap_Notes[this:GetParent().zone][this:GetParent().note]["descript"] = descript;
	CT_UserMap_Notes[this:GetParent().zone][this:GetParent().note]["set"] = set;
	CT_UserMap_Notes[this:GetParent().zone][this:GetParent().note]["icon"] = icon;
end

function CT_MapModDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(CT_UserMap_OptionsMenuGroupDropDown, this:GetID(), 1);
end

function CT_MapModDropDown_OnShow()
	local set = CT_UserMap_Notes[this.zone][this.note]["set"];
	if ( this.zone and this.note ) then
		if ( tonumber(set) and tonumber(set) == set ) then
			UIDropDownMenu_SetSelectedName(CT_UserMap_OptionsMenuGroupDropDown, CT_MAPMOD_SETS[set], nil);
		else
			UIDropDownMenu_SetSelectedName(CT_UserMap_OptionsMenuGroupDropDown, set, nil);
		end
	end
	UIDropDownMenu_SetText(CT_MAPMOD_SETS[set], CT_UserMap_OptionsMenuGroupDropDown);
end

function CT_MapModDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CT_UserMap_OptionsMenuGroupDropDown";
	for key, val in CT_MAPMOD_SETS do
		local info = { };
		info.text = val;
		info.value = val;
		info.owner = this;
		info.func = CT_MapModDropDown_OnClick;

		UIDropDownMenu_AddButton(info);
	end
end

function CT_MapModDropDown_Initialize()
	CT_MapModDropDown_OnInit();
end

function CT_MapModDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_MapModDropDown_Initialize);
	UIDropDownMenu_SetWidth(130);
end

function CT_MapModSelectDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_MapModSelectDropDown_Initialize);
	UIDropDownMenu_SetWidth(130);
end

function CT_MapModSelectDropDown_OnClick()
	CT_GroupSelectDropDownText:SetText("Display Groups");
	if ( not CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].hideGroups ) then
		CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].hideGroups = { };
	end
	CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].hideGroups[this.value] = not CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].hideGroups[this.value];
end

function CT_MapModSelectDropDown_Initialize()
	UIDROPDOWNMENU_INIT_MENU = "CT_GroupSelectDropDown";
	for key, val in CT_MAPMOD_SETS do
		local info = { };
		info.text = val;
		info.value = val;
		if ( CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")] and ( not CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].hideGroups or not CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].hideGroups[val] ) ) then
			info.checked = 1;
		end
		info.owner = this;
		info.func = CT_MapModSelectDropDown_OnClick;

		UIDropDownMenu_AddButton(info);
	end
end

function CT_MapMod_DeleteNote()
	tremove(CT_UserMap_Notes[this:GetParent().zone], this:GetParent().note);
end

function CT_MapMod_ProcessMessage(msg, user)
	if (msg == CT_LastMessage.msg and CT_LastMessage.user == user) then return nil; end

	CT_LastMessage.msg = msg;
	CT_LastMessage.user = user;

	if ( not msg ) then return nil; end
	local Useless, Useless, xpos, ypos, zone, name, descript, group, icon = string.find(msg, "^<CTModUM> New map note received: x=(.+) y=(.+) z=(.+) n=(.*) d=(.*) g=(.+) i=(.+)$");

	if ( strsub(msg, 1, 9) ~= "<CTModUM>" ) then return nil; end
	if ( not zone or Useless == msg ) then
		Useless, Useless, name, xpos, ypos, zone = string.find(msg, "^<CTModUM> New map note: (.*) x=(.+) y=(.+) z=(.+) v=.+$");
		descript = "Received from " .. user;
		icon = 1;
		group = 1;
		if ( not zone or Useless == msg ) then return nil; end
	end

	local zonename = CT_MapMod_GetZone(zone);
	
	CT_Print("<CTMod> User Note received in zone '" .. zonename .. "' from '" .. user .. "'!", 1.0, 0.5, 0.0);

	ChatEdit_SetLastTellTarget(DEFAULT_CHAT_FRAME.editBox, user);
	
	CT_MapMod_AddNote(xpos, ypos, zonename, name, descript, tonumber(icon), group);

	return 1;
end

function CT_MapMod_GetZone(zoneid)
	if ( not tonumber(zoneid) ) then
		return "Error, please report zoneid " .. zoneid;
	end

	local zone = tonumber(zoneid);
	for key, val in CT_UserMap_Zone do
		if ( val == zone ) then
			return key;
		end
	end
	return "Error, please report zone " .. zoneid;
end

CT_MapMod_OldChatFrameHook = ChatFrame_OnEvent;

function CT_MapMod_ChatFrameHook(event)
	if ( event == "CHAT_MSG_WHISPER" and CT_MapMod_ProcessMessage(arg1, arg2) ) then
		return;
	end
	CT_MapMod_OldChatFrameHook(event);
end

ChatFrame_OnEvent = CT_MapMod_ChatFrameHook;

function CT_MapMod_SendNote()
	if ( not CT_UserMap_OptionsMenu:IsVisible() or strlen(CT_UserMap_OptionsMenuSendEB:GetText()) == 0 ) then
		return;
	end

	local name, descript, zone, group, x, y, icon;
	name = CT_UserMap_OptionsMenuNameEB:GetText();
	descript = CT_UserMap_OptionsMenuDescriptEB:GetText();
	zone = CT_UserMap_OptionsMenu.zone;

	if ( UIDropDownMenu_GetSelectedName(CT_UserMap_OptionsMenuGroupDropDown) ) then
		group = CT_UserMap_Notes[zone][CT_UserMap_OptionsMenu.note]["set"];
	else
		group = UIDropDownMenu_GetSelectedID(CT_UserMap_OptionsMenuGroupDropDown);
	end

	x = CT_UserMap_Notes[zone][CT_UserMap_OptionsMenu.note]["x"];
	y = CT_UserMap_Notes[zone][CT_UserMap_OptionsMenu.note]["y"];

	icon = CT_UserMap_Notes[zone][CT_UserMap_OptionsMenu.note]["icon"];

	SendChatMessage("<CTModUM> New map note received: x="..x.." y="..y.." z="..CT_UserMap_Zone[zone].." n="..name.." d="..descript.." g="..group .. " i=" .. icon, "WHISPER", nil, CT_UserMap_OptionsMenuSendEB:GetText());
	CT_UserMap_OptionsMenuSendEB.lastsend = CT_UserMap_OptionsMenuSendEB:GetText();
	CT_UserMap_OptionsMenuSendEB:SetText("");
	CT_UserMap_OptionsMenuSendButton:Disable();
end

function CT_MapMod_ShowEditGroups()
	CT_UserMap_OptionsMenuEditGroups:Show();
end

function CT_MapMod_EditGroups_Update()
	local numGroups = getn(CT_MAPMOD_SETS);
	FauxScrollFrame_Update(CT_UserMap_OptionsMenuEditGroupsScrollFrame, numGroups, 6, 16, CT_UserMap_OptionsMenuEditGroupsgHighlightFrame, 293, 316 );

	local i;
	for i = 1, 6, 1 do
		local btn = getglobal("CT_UserMap_OptionsMenuEditGroupsTitle" .. i);
		if ( i <= numGroups ) then
			btn:Show();
			btn:SetText(" " .. CT_MAPMOD_SETS[FauxScrollFrame_GetOffset(CT_UserMap_OptionsMenuEditGroupsScrollFrame)+i]);
		else
			btn:Hide();
		end
	end
end

function CT_UserMapEditGroup_SetSelection(id)

	local i;
	for i = 1, 6, 1 do
		getglobal("CT_UserMap_OptionsMenuEditGroupsTitle"..i):UnlockHighlight();
	end

	-- Get xml id
	local xmlid = id - FauxScrollFrame_GetOffset(CT_UserMap_OptionsMenuEditGroupsScrollFrame);
	local titleButton = getglobal("CT_UserMap_OptionsMenuEditGroupsTitle"..xmlid);

	-- Set newly selected quest and highlight it
	CT_UserMap_OptionsMenuEditGroups.selectedButtonID = xmlid;
	local scrollFrameOffset = FauxScrollFrame_GetOffset(CT_UserMap_OptionsMenuEditGroupsScrollFrame);
	if ( id > scrollFrameOffset and id <= (scrollFrameOffset + 6) and id <= getn(CT_MAPMOD_SETS) ) then
		titleButton:LockHighlight();
	end
end

function CT_MapMod_TitleButton_OnClick(button)
	if ( button == "LeftButton" ) then
		CT_UserMapEditGroup_SetSelection(this:GetID() + FauxScrollFrame_GetOffset(CT_UserMap_OptionsMenuEditGroupsScrollFrame))
		CT_MapMod_EditGroups_Update();
	end
end

-- Get old notes

function CT_MapMod_UpdateOldNotes()
	local temp = { };
	local update = false;
	for key, val in CT_UserMap_Notes do
		if ( type(key) == "number" and type(val) == "table" ) then
			update = true;
			-- Old notes 
			local tempvar = {
				["name"] = val["desc"],
				["x"] = val["x"],
				["y"] = val["y"],
				["icon"] = 1,
				["set"] = 1,
			};
			if ( val["zone"] ) then
				if ( not temp[val["zone"]]) then
					temp[val["zone"]] = { };
				end
				temp[val["zone"]][getn(temp[val["zone"]])+1] = tempvar;
			end
			CT_UserMap_Notes[key] = nil;
		end
	end
	if ( update ) then
		for key, val in temp do
			if ( not CT_UserMap_Notes[key] ) then
				CT_UserMap_Notes[key] = { };
			end
			for k, v in val do
				tinsert(CT_UserMap_Notes[key], v);
			end
		end
		CT_Print("<CTMod> Updated old notes to new format.", 1, 0.5, 0);
	end
end

function CT_MapMod_OnLoad()
	WorldMapMagnifyingGlassButton:SetText(ZOOM_OUT_BUTTON_TEXT .. "\nControl+click to add note");
	-- Set names
	CT_UserMap_OptionsMenuTitle:SetText(CT_MAPMOD_TEXT_TITLE);
	CT_UserMap_OptionsMenuNameText:SetText(CT_MAPMOD_TEXT_NAME);
	CT_UserMap_OptionsMenuDescriptText:SetText(CT_MAPMOD_TEXT_DESC);
	CT_UserMap_OptionsMenuGroupText:SetText(CT_MAPMOD_TEXT_GROUP);
	CT_UserMap_OptionsMenuSendText:SetText(CT_MAPMOD_TEXT_SEND);
	CT_UserMap_OptionsMenuOkayButton:SetText(CT_MAPMOD_BUTTON_OKAY);
	CT_UserMap_OptionsMenuCancelButton:SetText(CT_MAPMOD_BUTTON_CANCEL);
	CT_UserMap_OptionsMenuDeleteButton:SetText(CT_MAPMOD_BUTTON_DELETE);
	CT_UserMap_OptionsMenuEditButton:SetText(CT_MAPMOD_BUTTON_EDITGROUPS);
	CT_UserMap_OptionsMenuSendButton:SetText(CT_MAPMOD_BUTTON_SEND);
end
	
function CT_MapMod_OnEvent(event)
	if ( event == "CHAT_MSG_SPELL_SELF_BUFF" ) then
		CT_MapMod_ParseResource(event);
	elseif ( event == "UI_ERROR_MESSAGE" ) then
		if ( arg1 and ( string.find(arg1, "Requires Herbalism") or string.find(arg1, "Requires Mining") ) ) then
			CT_MapMod_ParseResource(event);
		end
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		if ( not CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")] ) then
			CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")] = { 
				["autoGather"] = 1,
				["hideGroups"] = { }
			};
		else
			CT_GatherNotesButton:SetChecked(CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].autoGather);
		end
	end
end

function CT_MapMod_FindResourceIcon(oldName, prefix)
	local _, _, endPoint = string.find(oldName, "([^%s]+%sVein)$");
	if ( endPoint ) then
		oldName = endPoint;
	else
		local _, _, endPoint = string.find(oldName, "([^%s]+)%sDeposit$");
		if ( endPoint ) then
			oldName = endPoint .. "Vein";
		end
	end
	local name = "";
	for i = 1, strlen(oldName), 1 do
		local l = strsub(oldName, i, i);
		if ( string.find(l, "%w") ) then
			name = name .. l;
		end
	end
	for k, v in CT_UserMap_HerbIcons do
		if ( v == prefix .. name ) then
			if ( prefix == "Herb_" ) then
				return k;
			else
				return k-29;
			end
		end
	end
	return 1;
end

function CT_MapMod_ExecuteFilter(filter)
	CT_MapMod_Filter = filter;
end

function CT_MapMod_ParseResource(event)
	if ( not CT_MapMod_Options[UnitName("player") .. "@" .. GetCVar("realmName")].autoGather ) then
		return;
	end
	local x, y = GetPlayerMapPosition("player");
	if ( x == 0 and y == 0 ) then
		return;
	end
	local zone = CT_MapMod_GetCurrentZone();
	if ( not zone or not CT_UserMap_Zone[zone] ) then
		return;
	end
	if ( not CT_UserMap_Notes[zone] ) then
		CT_UserMap_Notes[zone] = { };
	end
	for k, v in CT_UserMap_Notes[zone] do
		if ( k > CT_NUM_USERMAP_NOTES ) then
			break;
		end
		if ( abs(v.x-x) <= 0.01 and abs(v.y-y) <= 0.01 ) then
			-- Two very close herbs, most likely the same herb, we don't want to add another note then
			return;
		end
	end
	if ( string.find(event, "^CHAT_MSG" ) ) then
		if ( string.find(arg1, "^You perform Herb Gathering on") ) then
			local _,_, name = string.find(arg1, "^You perform Herb Gathering on (.+)%.$");
			if ( name ) then
				CT_MapMod_AddNote(x, y, zone, name, "", CT_MapMod_FindResourceIcon(name, "Herb_"), 7);
			end
		elseif ( string.find(arg1, "^You perform Mining on") ) then
			local _,_, name = string.find(arg1, "^You perform Mining on (.+)%.$");
			if ( name ) then
				CT_MapMod_AddNote(x, y, zone, name, "", CT_MapMod_FindResourceIcon(name, "Ore_"), 8);
			end
		end
	elseif ( string.find(event, "UI_ERROR_MESSAGE") ) then
		local name = GameTooltipTextLeft1:GetText();
		if ( name and strlen(name) > 0 ) then
			if ( string.find(arg1, "Herbalism" ) ) then
				CT_MapMod_AddNote(x, y, zone, name, "", CT_MapMod_FindResourceIcon(name, "Herb_"), 7);
			else
				CT_MapMod_AddNote(x, y, zone, name, "", CT_MapMod_FindResourceIcon(name, "Ore_"), 8);
			end
		end
	end
end

function CT_MapMod_GetZoneName(id, ...)
	return arg[id];
end

function CT_MapMod_GetCurrentZone()
	local x, y = GetPlayerMapPosition("player");
	local currC, currZ = GetCurrentMapContinent(), GetCurrentMapZone();
	SetMapToCurrentZone();
	local name = CT_MapMod_GetZoneName(GetCurrentMapZone(), GetMapZones(GetCurrentMapContinent()));
	if ( x == 0 and y == 0 ) then
		SetMapZoom(currC, currZ);
	end
	return name;
end
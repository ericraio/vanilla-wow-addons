--[[
	Magellan

	By Torgo <jimmcq@concentric.net>

	This mod will populate the the main map with MetaMap for local landmarks.
	It requires the either MetaMap or CT_MapMod AddOn to be installed.

	Feel free to use any of this code in other mods, or to modify this AddOn itself.  My only request is that you send me your modifications.

	URL: http://curse-gaming.com/mod.php?addid=994
	
	Modified for MetaMap by Devla
   ]]


Magellan_Version = "002";
Magellan_ZoneNames = {};

function Magellan_Init(...)
	if (CT_MapMod_AddNote or MiniNotePOI) then
		this:RegisterEvent("WORLD_MAP_UPDATE");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Magellan could not find either MetaMap nor CT_MapMod to update");
	end
	for i=1, arg.n, 1 do
		Magellan_LoadZones(i, GetMapZones(i));
   	end
   	SlashCmdList["MAGELLANSYSTEMSLASHMAIN"] = Magellan_Main_ChatCommandHandler;
	SLASH_MAGELLANSYSTEMSLASHMAIN1 = "/magellan";
end

function Magellan_LoadZones(...)
	j = arg[1];
	Magellan_ZoneNames[j] = {};
	for i=1, arg.n-1, 1 do
		Magellan_ZoneNames[j][i] = arg[i+1];
	end
end

function Magellan_OnEvent()
	NumMapLandmarks = GetNumMapLandmarks();
	mapZoneName = nil;
	if( GetCurrentMapContinent() == -1 ) then
	return
	end
	for landmarkIndex = 1, NumMapLandmarks, 1 do
		name, unknown, textureIndex, x, y = GetMapLandmarkInfo(landmarkIndex);
		name = Magellan_AddNote(name, textureIndex, x, y);
		if (name) then
			mapZoneName = name;
		end
	end
	if (mapZoneName and DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Magellan updated Map Notes for "..mapZoneName, 1.0, 0.5, 0.25);
		PlaySound("MapPing");
	end
end

function Magellan_AddNote(name, textureIndex, x, y)
		local continent = GetCurrentMapContinent();
			if( continent == 0 ) then
				return;
			end
		local currentZone;
		local zone;
	if( continent == -1 ) then
		if( not MetaMapNotes_Data[GetZoneText()] ) then
			MetaMapNotes_Data[GetZoneText()] = { };
		end
		currentZone = MetaMapNotes_Data[GetZoneText()];
			zone = -1;
	else
			zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()];
		if( not MetaMapNotes_Data[continent][zone] ) then
			MetaMapNotes_Data[continent][zone] = { };
	end

	currentZone = MetaMapNotes_Data[continent][zone];
	end

	if (zone == 0) then
		return;
	end

	if (MiniNotePOI ~= nil) then
	-- MetaMap AddOn found
		local id = 0;
		local icon = 9;

		if (textureIndex == 15) then
			icon = 5;
		elseif (textureIndex == 6) then
			icon = 6;
		end

	if (x == 0 and y == 0) then
		return;
	end

	local checknote = false;
		if( continent > 0 ) then
			checknote = MetaMapNotes_CheckNearNotes(continent, zone, x, y);
		end

	if (checknote == false) then
		local i = 0;
		for j, value in currentZone do
		i = i + 1;
	end
	if (i < MetaMapNotes_NotesPerZone) then
		MetaMapNotes_TempData_Id = i + 1;
		currentZone[MetaMapNotes_TempData_Id] = {};
		currentZone[MetaMapNotes_TempData_Id].name = name;
		currentZone[MetaMapNotes_TempData_Id].ncol = 6;
		currentZone[MetaMapNotes_TempData_Id].inf1 = "";
		currentZone[MetaMapNotes_TempData_Id].in1c = 0;
		currentZone[MetaMapNotes_TempData_Id].inf2 = "";
		currentZone[MetaMapNotes_TempData_Id].in2c = 0;
		currentZone[MetaMapNotes_TempData_Id].creator = "Magellan AddOn";
		currentZone[MetaMapNotes_TempData_Id].icon = icon;
		currentZone[MetaMapNotes_TempData_Id].xPos = x;
		currentZone[MetaMapNotes_TempData_Id].yPos = y;

	if( continent > 0 ) then
		return Magellan_ZoneNames[continent][zone];
	else
		return GetZoneText();
	end
	end
	end

	elseif (CT_MapMod_AddNote) then
	-- CT_MapMod AddOn found
		zonename = Magellan_ZoneNames[continent][zone];
		update = true;
	local icon = 4;

	if (textureIndex == 15) then
		icon = 1;
		elseif (textureIndex == 6) then
		icon = 3;
	end

	if (CT_UserMap_Notes[zonename] ) then
		for j, value in CT_UserMap_Notes[zonename] do
	noteName = CT_UserMap_Notes[zonename][j]["name"];
		if (noteName == name) then
	update = false;
	end
	end
	end

	if (update == true) then
		CT_MapMod_AddNote(x, y, zonename, name, "Created by Magellan AddOn", icon, 4);
		return zonename;
	end
	end
	end

function Magellan_Extract_NextParameter(msg)
	local params = msg;
	local command = params;
	local index = strfind(command, " ");
	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	return command, params;
end

function Magellan_Main_ChatCommandHandler(msg)
	local commandName, params = Magellan_Extract_NextParameter(msg);
	if ( strfind( commandName, "reset" ) ) then
		Magellan_DeleteNotes();
	end
end

function Magellan_DeleteNotes()
	local i;
	local j;
	local k;
	for i, value in MetaMapNotes_Data do
		for j, value in MetaMapNotes_Data[i] do
			for k, value in MetaMapNotes_Data[i][j] do
				if (MetaMapNotes_Data[i][j][k].creator == "Magellan AddOn") then
					Magellan_DeleteNote(i, j, k);
				end
			end
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("All Magellan Map Notes have been deleted.");
end

function Magellan_DeleteNote(continent, zone, id)
	if (id == 0) then
		MetaMapNotes_tloc_xPos = nil;
		MetaMapNotes_tloc_yPos = nil;
		return;
	elseif (id == -1) then
		MetaMapNotes_PartyNoteData.xPos = nil;
		MetaMapNotes_PartyNoteData.yPos = nil;
		MetaMapNotes_PartyNoteData.continent = nil;
		MetaMapNotes_PartyNoteData.zone = nil;
		return;
	end
	local lastEntry = Magellan_LastNote(continent, zone) - 1;
	MetaMapNotes_DeleteLines(continent, zone, MetaMapNotes_Data[continent][zone][id].xPos, MetaMapNotes_Data[continent][zone][id].yPos);
	if ((lastEntry ~= 0) and (id <= lastEntry)) then
		MetaMapNotes_Data[continent][zone][id].name = MetaMapNotes_Data[continent][zone][lastEntry].name;
		MetaMapNotes_Data[continent][zone][lastEntry].name = nil;
		MetaMapNotes_Data[continent][zone][id].ncol = MetaMapNotes_Data[continent][zone][lastEntry].ncol;
		MetaMapNotes_Data[continent][zone][lastEntry].ncol = nil;
		MetaMapNotes_Data[continent][zone][id].inf1 = MetaMapNotes_Data[continent][zone][lastEntry].inf1;
		MetaMapNotes_Data[continent][zone][lastEntry].inf1 = nil;
		MetaMapNotes_Data[continent][zone][id].in1c = MetaMapNotes_Data[continent][zone][lastEntry].in1c;
		MetaMapNotes_Data[continent][zone][lastEntry].in1c = nil;
		MetaMapNotes_Data[continent][zone][id].inf2 = MetaMapNotes_Data[continent][zone][lastEntry].inf2;
		MetaMapNotes_Data[continent][zone][lastEntry].inf2 = nil;
		MetaMapNotes_Data[continent][zone][id].in2c = MetaMapNotes_Data[continent][zone][lastEntry].in2c;
		MetaMapNotes_Data[continent][zone][lastEntry].in2c = nil;
		MetaMapNotes_Data[continent][zone][id].creator = MetaMapNotes_Data[continent][zone][lastEntry].creator;
		MetaMapNotes_Data[continent][zone][lastEntry].creator = nil;
		MetaMapNotes_Data[continent][zone][id].icon = MetaMapNotes_Data[continent][zone][lastEntry].icon;
		MetaMapNotes_Data[continent][zone][lastEntry].icon = nil;
		MetaMapNotes_Data[continent][zone][id].xPos = MetaMapNotes_Data[continent][zone][lastEntry].xPos;
		MetaMapNotes_Data[continent][zone][lastEntry].xPos = nil;
		MetaMapNotes_Data[continent][zone][id].yPos = MetaMapNotes_Data[continent][zone][lastEntry].yPos;
		MetaMapNotes_Data[continent][zone][lastEntry].yPos = nil;
		MetaMapNotes_Data[continent][zone][lastEntry] = nil;
	end
	if (continent == MetaMapNotes_MiniNote_Data.continent and zone == MetaMapNotes_MiniNote_Data.zone) then
		if (MetaMapNotes_MiniNote_Data.id > id) then
			MetaMapNotes_MiniNote_Data.id = id - 1;
		elseif (MetaMapNotes_MiniNote_Data.id == id) then
			MetaMapNotes_MiniNote_Data.id = 0;
		end
	end
end

function Magellan_LastNote(continent, zone)
	local i = 0;
	for j, value in MetaMapNotes_Data[continent][zone] do
		i = i + 1;
	end
	return (i + 1);
end
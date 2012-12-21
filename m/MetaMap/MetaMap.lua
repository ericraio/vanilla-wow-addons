-- MetaMap
-- Written by MetaHawk - aka Urshurak

METAMAP_TITLE = "MetaMap";
METAMAP_TOC = 11200;
METAMAP_VERSION = METAMAP_TOC.."-"..2;

METAMAP_NAME = METAMAP_TITLE.."  v"..METAMAP_VERSION;
METAMAPFWM_NAME = "MetaMapPOI";
METAMAP_ICON = "Interface\\WorldMap\\WorldMap-Icon";
METAMAP_MAP_PATH = "Interface\\AddOns\\MetaMap\\Maps\\";
METAMAP_ICON_PATH = "Interface\\AddOns\\MetaMap\\Icons\\";
METAMAP_IMAGE_PATH = "Interface\\AddOns\\MetaMap\\Images\\"
METAMAP_SHADER_PATH = "Interface\\AddOns\\MetaMap\\Shaders\\"
METAMAP_MAPCREDITS = "Maps created by Niflheim";
TITAN_METAMAP_ID = METAMAP_TITLE;
TITAN_METAMAP_FREQUENCY = 1;

METAMAPMENU_BUTTON_HEIGHT = 16;
METAMAPLIST_SCROLL_FRAME_BUTTON_HEIGHT = 20;
METAMAPLIST_SCROLL_FRAME_BUTTONS_SHOWN = 30;
METAMAP_SORTBY_NAME = "name";
METAMAP_SORTBY_DESC = "desc";
METAMAP_SORTBY_LEVEL = "level";
METAMAP_SORTBY_LOCATION = "location";

MetaMap_Details = {
	name = METAMAP_TITLE,
	description = METAMAP_DESC,
	version = METAMAP_VERSION,
	releaseDate = "November 26, 2005",
	author = "MetaHawk",
	email = "admin@metaserve.org.uk",
	website = "",
	category = MYADDONS_CATEGORY_MAP,
}

MetaMapOptions = {};
MetaMap_ZoneNames = {};
MetaMap_ZoneNames[0] = {};
MetaMap_ZoneNames[1] = {};
MetaMap_ZoneNames[2] = {};
MetaMap_NoteList = {};
MetaMap_NoteFilter = {};

MetaMapNotes_MiniNote_Data = {};
MetaMapNotes_PartyNoteData = {};
MetaMapNotes_Relocate = {};
MetaMapNotes_LastLineClick = {};

MetaMap_CurrentMap = 0;
MetaMap_ListOffset = 0;
MetaMap_VarsLoaded = false;
MetaMap_FilterName = "";
MetaMap_PingTime = 15;
MetaMap_FullScreenMode = false;
MetaMapContainer_CurrentFrame = nil;
MetaMap_CurrentSaveSet = 1;
MetaMap_sortDone = true;
MetaMap_sortType = METAMAP_SORTBY_NAME;

MetaMapNotes_LastNote = 0;
MetaMapNotes_LastLine = 0;
MetaMapNotes_TempData_Id = "";
MetaMapNotes_TempData_Name = "";
MetaMapNotes_TempData_Creator = "";
MetaMapNotes_TempData_xPos = "";
MetaMapNotes_TempData_yPos = "";
MetaMapNotes_TempData_Icon = "";
MetaMapNotes_TempData_TextColor = "";
MetaMapNotes_TempData_Info1Color = "";
MetaMapNotes_TempData_Info2Color = "";
MetaMapNotes_TempData_LootID = nil;
MetaMapNotes_SetNextAsMiniNote = 0;
MetaMapNotes_LastLineClick.time = 0;
MetaMapNotes_Qnote = false;
MetaMapNotes_MiniNote_IsInCity = false;
MetaMapNotes_MiniNote_MapzoomInit = false;
MetaMapNotes_vnote_xPos = nil;
MetaMapNotes_vnote_yPos = nil;
MetaMapNotes_PartyNoteSet = false;

local MetaMapNotes_Mininote_UpdateRate = 0;
local MetaMap_OrigWorldMapButton_OnClick;
local MetaMap_OrigChatFrame_OnEvent;

METAMAPMENU_LIST = {
	{name = METAMAP_OPTIONS_COORDS},
	{name = METAMAP_OPTIONS_MINICOORDS},
	{name = METAMAP_OPTIONS_SHOWNOTES},
	{name = METAMAP_ACTION_MODE},
	{name = METAMAP_OPTIONS_SAVESET},
	{name = METAMAP_OPTIONS_SHADESET},
	{name = "Spacer"},
	{name = METAMAP_OPTIONS_EXT},
	{name = METAMAP_FLIGHTMAP_OPTIONS},
	{name = METAMAP_GATHERER_OPTIONS},
	{name = METAMAP_BWP_OPTIONS},
	{name = METAMAP_OPTIONS_USEMAPMOD},
	{name = METAMAP_KB_TEXT},
	{name = METAMAP_OPTIONS_FWM}
};

function MetaMap_SetVars()
	if(MetaMapOptions.SaveSet == nil) then MetaMapOptions.SaveSet = 1; end
	if(MetaMapOptions.MetaMapAlpha1 == nil) then MetaMapOptions.MetaMapAlpha1 = 1.0; end
	if(MetaMapOptions.MetaMapAlpha2 == nil) then MetaMapOptions.MetaMapAlpha2 = 0.60; end
	if(MetaMapOptions.BDshader1 == nil) then MetaMapOptions.BDshader1 = 0.0; end
	if(MetaMapOptions.BDshader2 == nil) then MetaMapOptions.BDshader2 = 0.0; end
	if(MetaMapOptions.MetaMapScale1 == nil) then MetaMapOptions.MetaMapScale1 = 0.75; end
	if(MetaMapOptions.MetaMapScale2 == nil) then MetaMapOptions.MetaMapScale2 = 0.55; end
	if(MetaMapOptions.MetaMapTTScale1 == nil) then MetaMapOptions.MetaMapTTScale1 = 1.0; end
	if(MetaMapOptions.MetaMapTTScale2 == nil) then MetaMapOptions.MetaMapTTScale2 = 0.75; end
	if(MetaMapOptions.MetaMapCoords == nil) then MetaMapOptions.MetaMapCoords = true; end
	if(MetaMapOptions.MetaMapMiniCoords == nil) then MetaMapOptions.MetaMapMiniCoords = true; end
	if(MetaMapOptions.MetaMapButtonShown == nil) then MetaMapOptions.MetaMapButtonShown = true; end
	if(MetaMapOptions.MetaMapButtonPosition == nil) then MetaMapOptions.MetaMapButtonPosition = 220; end
	if(MetaMapOptions.TooltipWrap == nil) then MetaMapOptions.TooltipWrap = true; end
	if(MetaMapOptions.MetaMapShowAuthor == nil) then MetaMapOptions.MetaMapShowAuthor = true; end
	if(MetaMapOptions.MenuMode == nil) then MetaMapOptions.MenuMode = false; end
	if(MetaMapOptions.UseMapMod == nil) then MetaMapOptions.UseMapMod = false; end
	if(MetaMapOptions.ShowMapList == nil) then MetaMapOptions.ShowMapList = false; end
	if(MetaMapOptions.ActionMode1 == nil) then MetaMapOptions.ActionMode = false; end
	if(MetaMapOptions.ActionMode2 == nil) then MetaMapOptions.ActionMode = false; end
	if(MetaMapOptions.LastHighlight == nil) then MetaMapOptions.LastHighlight = true; end
	if(MetaMapOptions.LastMiniHighlight == nil) then MetaMapOptions.LastMiniHighlight = true; end
	if(MetaMapOptions.AcceptIncoming == nil) then MetaMapOptions.AcceptIncoming = true; end
	if(MetaMapOptions.MiniParty == nil) then MetaMapOptions.MiniParty = true; end
	if(MetaMapOptions.ListColors == nil) then MetaMapOptions.ListColors = true; end
	if(MetaMapOptions.ShadeSet == nil) then MetaMapOptions.ShadeSet = 1; end
	if(MetaMapOptions.MiniColor == nil) then MetaMapOptions.MiniColor = 4; end
	if(MetaMapOptions.MetaMapZone == nil) then MetaMapOptions.MetaMapZone = 1; end
	if(MetaMapOptions.ZoneHeader == nil) then MetaMapOptions.ZoneHeader = false; end
	if(MetaMapOptions.ZoneShiftVersion == nil) then MetaMapOptions.ZoneShiftVersion = 0; end
	if(MetaMapOptions.usePOI == nil) then MetaMapOptions.usePOI = false; end
	if(MetaMapOptions.FWMretain == nil) then MetaMapOptions.FWMretain = false; end
	if(MetaMapOptions.BWPalwaysOn == nil) then MetaMapOptions.BWPalwaysOn = false; end
	if(MetaMapOptions.WKBalwaysOn == nil) then MetaMapOptions.WKBalwaysOn = false; end
	if(MetaMapOptions.SortList == nil) then MetaMapOptions.SortList = false; end
	for i=0, 9, 1 do
		if(MetaMap_NoteFilter[i] == nil) then MetaMap_NoteFilter[i] = true; end
	end
end

function MetaMap_SetWorldMap()
	BlackoutWorld:Hide();
	WorldMapZoomOutButton:Hide();
	WorldMapFrame:SetMovable(true);
	WorldMapMagnifyingGlassButton:Hide();
	WMF_OldScript = WorldMapFrame:GetScript("OnKeyDown")
	WorldMapFrame:SetScript("OnKeyDown", nil);
	UIPanelWindows["WorldMapFrame"] =	{ area = "center",	pushable = 0 };
	SetMapToCurrentZone();
end

function MetaMapTopFrame_OnLoad()
	math.randomseed(GetTime());
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	if (IsAddOnLoaded("FuBar")) then
		MetaMap_FuBar_OnLoad();
	end
end

function MetaMapFrameDropDown_OnLoad()
	UIDropDownMenu_ClearAll(MetaMapFrameDropDown);
	UIDropDownMenu_Initialize(MetaMapFrameDropDown, MetaMapFrameDropDown_Initialize);
	UIDropDownMenu_SetWidth(175);
end

function MetaMapList_OnLoad()
	this:SetFrameLevel(WorldMapButton:GetFrameLevel()+1);
	this:SetHeight(WorldMapButton:GetHeight());
	this:SetBackdropColor(0,0,0,0.65);
end

function MetaMapContainerFrame_OnLoad()
	this:SetWidth(WorldMapButton:GetWidth() - MetaMap_MapListFrame:GetWidth()-1);
	this:SetHeight(WorldMapButton:GetHeight()-41);
end

function MetaMapNotes_OnLoad()
	MiniNotePOI.TimeSinceLastUpdate = 0;
	SlashCmdList["MAPNOTE"] = MetaMapNotes_GetNoteBySlashCommand;
	for i = 1, table.getn(METAMAPNOTES_ENABLE_COMMANDS) do
		setglobal("SLASH_MAPNOTE"..i, METAMAPNOTES_ENABLE_COMMANDS[i]);
	end
	SlashCmdList["MININOTE"] = MetaMapNotes_NextMiniNote;
	for i = 1, table.getn(METAMAPNOTES_MININOTE_COMMANDS) do
		setglobal("SLASH_MININOTE"..i, METAMAPNOTES_MININOTE_COMMANDS[i]);
	end
	SlashCmdList["MININOTEONLY"] = MetaMapNotes_NextMiniNoteOnly;
	for i = 1, table.getn(METAMAPNOTES_MININOTEONLY_COMMANDS) do
		setglobal("SLASH_MININOTEONLY"..i, METAMAPNOTES_MININOTEONLY_COMMANDS[i]);
	end
	SlashCmdList["MININOTEOFF"] = MetaMapNotes_ClearMiniNote;
	for i = 1, table.getn(METAMAPNOTES_MININOTEOFF_COMMANDS) do
		setglobal("SLASH_MININOTEOFF"..i, METAMAPNOTES_MININOTEOFF_COMMANDS[i]);
	end
	SlashCmdList["QUICKNOTE"] = MetaMapNotes_Quicknote;
	for i = 1, table.getn(METAMAPNOTES_QUICKNOTE_COMMANDS) do
		setglobal("SLASH_QUICKNOTE"..i, METAMAPNOTES_QUICKNOTE_COMMANDS[i]);
	end
end

function MetaMapTopFrame_OnShow()
	if(not MetaMap_VarsLoaded) then return; end
	MetaMap_CurrentMap = GetCurrentMapZone();
	StaticPopup1:SetFrameStrata("FULLSCREEN");
	if(MetaMap_FullScreenMode) then
		MetaMapNotesEditFrame:SetParent("WorldMapFrame");
		MetaMapNotesSendFrame:SetParent("WorldMapFrame");
	end
	local continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
	if(zone == 0) then return; end
	local pX, pY = GetPlayerMapPosition("Player");
	if(pX == 0 and pY == 0 and continent == 0) then
		MetaMapOptions.MetaMapZone = zone;
		MetaMap_Toggle(true)
	end
end

function MetaMapTopFrame_OnHide()
	SetMapToCurrentZone();
	MetaMapNotes_HideAll()
	MetaMap_Toggle(false);
	MetaMapOptions.SaveSet = MetaMap_CurrentSaveSet;
	MetaMapContainerFrame:Hide();
	StaticPopup1:SetFrameStrata("DIALOG");
	MetaMapNotesEditFrame:SetParent("UIParent");
	MetaMapNotesEditFrame:SetFrameStrata("FULLSCREEN");
	MetaMapNotesSendFrame:SetParent("UIParent");
	MetaMapNotesSendFrame:SetFrameStrata("FULLSCREEN");
end


function MetaMap_OnEvent(event)
	if(event == "ADDON_LOADED" and arg1 == "MetaMap") then
		MetaMap_SetWorldMap();
		MetaMap_SetVars();
		MetaMap_LoadZones();
		MetaMap_VerifyData();
		MetaMap_OptionsDialogInit();
		MetaMap_FilterInit();
	end
	if(event == "VARIABLES_LOADED") then
		MetaMap_CurrentSaveSet = MetaMapOptions.SaveSet;
		MetaMapOptions_Init();
		MetaMapMenu_Init();
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(MetaMap_Details);
		end
		if MetaMapNotes_MiniNote_Data.icon == "party" then
			MetaMapNotes_ClearMiniNote(true);
		end
		if MetaMapNotes_MiniNote_Data.icon ~= nil then
			MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon);
		end
		MetaMap_OrigWorldMapButton_OnClick = WorldMapButton_OnClick;
		WorldMapButton_OnClick = MetaMapNotes_WorldMapButton_OnClick;
		MetaMap_OrigChatFrame_OnEvent = ChatFrame_OnEvent;
		ChatFrame_OnEvent = MetaMap_ChatFrame_OnEvent;
		MetaMap_SetNUNtooltip();
		if(MetaMapOptions.WKBalwaysOn) then MetaMap_LoadWKB(3); end
		if(MetaMapOptions.BWPalwaysOn) then MetaMap_LoadBWP(0, 3); end
		if(MetaMapOptions.FWMretain) then MetaMap_LoadFWM(); end
		MetaMap_VarsLoaded = true;
	end
	if(event == "INSTANCE_MAP_UPDATE") then
		if(not MetaMap_VarsLoaded) then return; end
		if(IsAddOnLoaded("MetaMapWKB")) then
			MetaKB_OnEvent("INSTANCE_MAP_UPDATE");
		else
			MetaMapContainerFrame:Hide();
		end
		MetaMapNotes_HideAll();
		MetaMap_Refresh();
		MetaMap_ZoneHeader();
	end
	if(event == "WORLD_MAP_UPDATE") then
		if(not MetaMap_VarsLoaded) then return; end
		if(MetaMap_CurrentMap ~= GetCurrentMapZone() and MetaMapFrame:IsVisible()) then
			MetaMap_Toggle(false);
		end
		MetaMap_CurrentMap = GetCurrentMapZone();
		if(MetaMapOptions.usePOI) then
			MetaMapPOI_OnEvent(1);
		end
		if(not IsAddOnLoaded("MetaMapWKB")) then
			MetaMapContainerFrame:Hide();
		end
		if(MetaMap_CurrentMap ~= 0) then
			MetaMapNotes_HideAll();
		end
		MetaMapOptions_Init();
		MetaMapNotes_MapUpdate();
		MetaMap_ZoneHeader();
	end
	if(event == "ZONE_CHANGED_NEW_AREA") then
		if(not MetaMap_VarsLoaded) then return; end
		SetMapToCurrentZone();
		MetaMapNotes_MiniNote_OnUpdate(0);
		if(MetaMapOptions.usePOI) then
			MetaMapPOI_OnEvent(2);
		end
		if(WorldMapFrame:IsVisible()) then
			MetaMapNotes_MapUpdate();
		end
		MetaMapNotes_HideAll();
	end
	if(event == "PLAYER_ENTERING_WORLD") then
		if(not MetaMap_VarsLoaded) then return; end
		MetaMap_CurrentMap = GetCurrentMapZone();
		local continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
		if(zone == 0) then return; end
		local pX, pY = GetPlayerMapPosition("Player");
		if(pX == 0 and pY == 0 and continent == 0) then
			MetaMapOptions.MetaMapZone = zone;
			MetaMap_Toggle(true);
		end
	end
	if(event == "MINIMAP_UPDATE_ZOOM") then
		MetaMapNotes_MinimapUpdateZoom();
	end
end

function MetaMap_ChatFrame_OnEvent(...)
	local event = unpack(arg);
	if(strsub(event, 1, 16) == "CHAT_MSG_WHISPER" and strsub(arg1, 1, 6) == "<MapN>") then
		if(arg2 ~= UnitName("player")) then
			MetaMapNotes_GetNoteFromChat(arg1, arg2);
		end
	else
		MetaMap_OrigChatFrame_OnEvent(unpack(arg));
	end
end

function MetaMap_VerifyData()
	local TempData = {}
	for continent=0, 2, 1 do
		local numZones = table.getn(MetaMap_ZoneNames[continent]);
		TempData[continent] = {};
		for zone, zoneTable in MetaMapNotes_Data[continent] do
			if(zone <= numZones) then
				TempData[continent][zone] = {};
				local newIndex = 1;
				for i, value in MetaMapNotes_Data[continent][zone] do
					local newNote = MetaMapNotes_Data[continent][zone][i];
					if(newNote.xPos and newNote.yPos and newNote.name) then
						TempData[continent][zone][newIndex] = value;
						newIndex = newIndex +1;
					end
				end
			end
		end
	end
	for continent, value in MetaMapNotes_Data do
		if(type(continent) == "String") then
			TempData[continent] = {};
			TempData[continent] = value;
		end
	end
	MetaMapNotes_Data = {};
	MetaMapNotes_Data = TempData;
	TempData = {};
	for continent=0, 2, 1 do
		local numZones = table.getn(MetaMap_ZoneNames[continent]);
		TempData[continent] = {};
		for zone, zoneTable in MetaMapNotes_Lines[continent] do
			if(zone <= numZones) then
				TempData[continent][zone] = {};
				local newIndex = 1;
				for i, value in MetaMapNotes_Lines[continent][zone] do
					TempData[continent][zone][newIndex] = value;
					newIndex = newIndex +1;
				end
			end
		end
	end
	for continent, value in MetaMapNotes_Lines do
		if(type(continent) == "String") then
			TempData[continent] = {};
			TempData[continent] = value;
		end
	end
	MetaMapNotes_Lines = {};
	MetaMapNotes_Lines = TempData;
	TempData = nil;
end

function MetaMap_VerifyNotes()
	if(MetaMapNotes_Data == nil) then
		MetaMapNotes_Data = {};
		MetaMapNotes_Data[0] = {};
		MetaMapNotes_Data[1] = {};
		MetaMapNotes_Data[2] = {};
	end
	if(MetaMapNotes_Data[0] == nil) then
		MetaMapNotes_Data[0] = {};
	end
	if(MetaMapNotes_Data[1] == nil) then
		MetaMapNotes_Data[1] = {};
	end
	if(MetaMapNotes_Data[2] == nil) then
		MetaMapNotes_Data[2] = {};
	end
end

function MetaMap_VerifyLines()
	if(MetaMapNotes_Lines == nil) then
		MetaMapNotes_Lines = {};
		MetaMapNotes_Lines[0] = {};
		MetaMapNotes_Lines[1] = {};
		MetaMapNotes_Lines[2] = {};
	end
	if(MetaMapNotes_Lines[0] == nil) then
		MetaMapNotes_Lines[0] = {};
	end
	if(MetaMapNotes_Lines[1] == nil) then
		MetaMapNotes_Lines[1] = {};
	end
	if(MetaMapNotes_Lines[2] == nil) then
		MetaMapNotes_Lines[2] = {};
	end
end

function MetaMap_LoadZones()
	MetaMap_VerifyNotes();
	MetaMap_VerifyLines();
	for zoneKey in MetaMap_Data do
		if(MetaMapNotes_Data[0][zoneKey] == nil) then
			MetaMapNotes_Data[0][zoneKey] = {};
		end
		if(MetaMapNotes_Lines[0][zoneKey] == nil) then
			MetaMapNotes_Lines[0][zoneKey] = {};
		end
		MetaMap_ZoneNames[0][zoneKey] = MetaMap_Data[zoneKey]["ZoneName"];
	end
	for continentKey,continentName in ipairs{GetMapContinents()} do
		MetaMap_ZoneNames[continentKey] = {};
		for zoneKey,zoneName in ipairs{GetMapZones(continentKey)} do
			if(MetaMapNotes_Data[continentKey][zoneKey] == nil) then
				MetaMapNotes_Data[continentKey][zoneKey] = {};
			end
			if(MetaMapNotes_Lines[continentKey][zoneKey] == nil) then
				MetaMapNotes_Lines[continentKey][zoneKey] = {};
			end
			MetaMap_ZoneNames[continentKey][zoneKey] = zoneName;
		end
	end
end

function MetaMap_NameToZoneID(zoneText, mode)
	for continentKey in MetaMapNotes_Data do
		if zoneText == MetaMap_ZoneNames[continentKey] then
			return zoneText, 0;
		end
	end
	for continentKey in MetaMap_ZoneNames do
		for zoneKey in MetaMap_ZoneNames[continentKey] do
			if zoneText == MetaMap_ZoneNames[continentKey][zoneKey] then
				return continentKey, zoneKey;
			end
		end
	end
	if(type(zoneText) == "string" and strlen(zoneText) >0 and mode == nil) then
		if(MetaMapNotes_Data[zoneText] == nil) then
			MetaMapNotes_Data[zoneText] = {};
			MetaMapNotes_Lines[zoneText] = {};
		end
		return zoneText, 0;
	end
	return 0, 0;
end

function MetaMap_GetCurrentMapInfo()
	local continent, zone, currentZone, mapName;
	continent = GetCurrentMapContinent();
	zone = GetCurrentMapZone();
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
		mapName = MetaMap_Data[zone]["ZoneName"];
	elseif(continent == -1) then
		if(MetaMapNotes_Data[GetRealZoneText()] == nil) then
			MetaMapNotes_Data[GetRealZoneText()] = {};
			MetaMapNotes_Lines[GetRealZoneText()] = {};
		end
		currentZone = MetaMapNotes_Data[GetRealZoneText()];
		mapName = GetRealZoneText();
	elseif(continent > 0) then
		currentZone = MetaMapNotes_Data[continent][zone];
		mapName = MetaMap_ZoneNames[continent][zone];
	end
	if(continent == 1 and mapName == nil) then
		mapName = "Kalimdor";
	elseif(continent == 2 and mapName == nil) then
		mapName = "Eastern Kingdoms";
	elseif(mapName == nil) then
		mapName = "World";
	end
	return continent, zone, currentZone, mapName;
end

function MetaMap_ToggleFrame(frame)
	if frame:IsVisible() then
		HideUIPanel(frame);
	else
		ShowUIPanel(frame);
	end
end

function MetaMapContainer_ShowFrame(frame, header, footer, info)
	if(frame == nil) then
		MetaMapContainer_CurrentFrame = nil;
		MetaMapContainerFrame:Hide();
		return;
	end
	if(header ~= nil) then
		MetaMapContainer_HeaderText:SetText(header);
		MetaMapContainer_HeaderText:Show();
	else
		MetaMapContainer_HeaderText:Hide();
	end
	if(footer ~= nil) then
		MetaMapContainer_FooterText:SetText(footer);
		MetaMapContainer_FooterText:Show();
	else
		MetaMapContainer_FooterText:Hide();
	end
	if(info ~= nil) then
		MetaMapContainer_InfoText:SetText(info);
		MetaMapContainer_InfoText:Show();
	else
		MetaMapContainer_InfoText:Hide();
	end
	if(MetaMapContainer_CurrentFrame ~= nil) then
		MetaMapContainer_CurrentFrame:Hide();
	end
	MetaMapContainer_CurrentFrame = frame;
	MetaMapContainer_CurrentFrame:Show();
	MetaMapContainerFrame:Show();
end

function MetaMap_FullScreenToggle()
	local mMap = false;
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();
	if(MetaMapFrame:IsVisible()) then
		MetaMapShown = true;
	end
	if(MetaMap_FullScreenMode) then
		WorldMapFrame:SetScript("OnKeyDown", nil);
		WorldMapFrame:SetScript("OnKeyUp", nil);
		UIPanelWindows["WorldMapFrame"] =	{ area = "center",	pushable = 9 };
		MetaMapNotesEditFrame:SetParent("UIParent");
		MetaMapNotesEditFrame:SetFrameStrata("FULLSCREEN");
		MetaMapNotesSendFrame:SetParent("UIParent");
		MetaMapNotesSendFrame:SetFrameStrata("FULLSCREEN");
		MetaMapMenu:SetParent("UIParent");
		MetaMapMenu:SetFrameStrata("FULLSCREEN");
		UIPanelWindows['MetaMapMenu'] = {area = 'center', pushable = 0};
		MetaMap_FullScreenMode = false;
		BlackoutWorld:Hide();
		if(WorldMapFrame:IsVisible()) then
			CloseAllWindows();
			ShowUIPanel(WorldMapFrame);
		end
		MetaMapOptions_Init();
	else
		MetaMapMenu:SetParent("WorldMapFrame");
		MetaMapNotesEditFrame:SetParent("WorldMapFrame");
		MetaMapNotesSendFrame:SetParent("WorldMapFrame");
		WorldMapFrame:SetScale(1.0);
		WorldMapFrame:SetScript("OnKeyDown", WMF_OldScript);
		WorldMapFrame:SetScript("OnKeyUp", X_Frame:GetScript("OnKeyUp"));
		UIPanelWindows["WorldMapFrame"] =	{ area = "full",	pushable = 0 };
		BlackoutWorld:Show();
		MetaMap_FullScreenMode = true;
		if(WorldMapFrame:IsVisible()) then
			CloseAllWindows();
			ShowUIPanel(WorldMapFrame);
		end
	end
	SetMapZoom(continent, zone);
	if(MetaMapShown) then MetaMap_Toggle(true); end
end

function MetaMap_Toggle(show)
	if(show) then
		ShowUIPanel(MetaMapFrame);
		HideUIPanel(WorldMapDetailFrame);
		HideUIPanel(WorldMapButton);
		ShowWorldMapArrowFrame(0);
	else
		HideUIPanel(MetaMapFrame);
		ShowUIPanel(WorldMapDetailFrame);
		ShowUIPanel(WorldMapButton);
		ShowWorldMapArrowFrame(1);
	end
	MetaMap_OnEvent("INSTANCE_MAP_UPDATE");
end

function MiniMapCoords_OnUpdate()
	if (MetaMapOptions.MetaMapMiniCoords and Minimap:IsVisible()) then
		local continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
		local px, py = GetPlayerMapPosition("player");
		if(zone == 0) then
			MetaMapMiniCoords:SetText("Dead Zone");
		elseif((continent == GetCurrentMapContinent() and zone == GetCurrentMapZone() and px ~= 0) or (type(continent) == "string" and px ~= 0)) then
			MetaMapMiniCoords:SetText(MetaMap_round(px * 100)..","..MetaMap_round(py * 100));
		elseif(px == 0 and py == 0 and continent == 0) then --GetRealZoneText() == MetaMap_Data[MetaMapOptions.MetaMapZone]["ZoneName"]) then
			MetaMapMiniCoords:SetText("Instance");
		elseif(continent == GetCurrentMapContinent() and zone == GetCurrentMapZone()) then
			MetaMapMiniCoords:SetText("Dead Zone");
		end
		MetaMapMiniCoords:Show();
	else
		MetaMapMiniCoords:Hide();
	end
end

function MetaMapCoordsWorldMap_OnUpdate()
	if (MetaMapOptions.MetaMapCoords and WorldMapFrame:IsVisible()) then
		local continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
		local x, y = GetCursorPosition();
		local px, py = GetPlayerMapPosition("player");
		local OFFSET_X = 0.0022;
		local OFFSET_Y = -0.0262;
		local centerX, centerY = WorldMapFrame:GetCenter();
		local width = WorldMapButton:GetWidth();
		local height = WorldMapButton:GetHeight();
		x = x / WorldMapFrame:GetEffectiveScale();
		y = y / WorldMapFrame:GetEffectiveScale();
		local adjustedX = (x - (centerX - (width/2))) / width;
		local adjustedY = (centerY + (height/2) - y ) / height;
		x = 100 * (adjustedX + OFFSET_X);
		y = 100 * (adjustedY + OFFSET_Y);
		if(x < 0 or y < 0 or x > 100 or y > 100) then
			MetaMapCoordsCursor:SetText("");
		else
			MetaMapCoordsCursor:SetText("|cffffffff"..format("%d,%d",x, y));
		end
		if(zone == 0) then
			MetaMapCoordsPlayer:SetText("|cff00ff00Dead Zone");
		elseif(px == 0 and py == 0 and GetRealZoneText() == MetaMap_Data[MetaMapOptions.MetaMapZone]["ZoneName"]) then
			MetaMapCoordsPlayer:SetText("|cff00ff00Instance");
		elseif((continent == GetCurrentMapContinent() and zone == GetCurrentMapZone() and px == 0) or (type(continent) == "string" and px == 0)) then
			MetaMapMiniCoords:SetText("Dead Zone");
		elseif(px == 0 and py == 0) then
			MetaMapCoordsPlayer:SetText("");
		else
			MetaMapCoordsPlayer:SetText("|cff00ff00"..MetaMap_round(px * 100)..","..MetaMap_round(py * 100));
		end
	end
end

function MetaMap_UpdateBackDrop()
	if(MetaMapOptions.SaveSet == 1) then
		MetaMapOptions.BDshader1 = MetaMap_BackDropSlider:GetValue();
		MetaMap_MapBackDrop:SetAlpha(MetaMapOptions.BDshader1);
	else
		MetaMapOptions.BDshader2 = MetaMap_BackDropSlider:GetValue();
		MetaMap_MapBackDrop:SetAlpha(MetaMapOptions.BDshader2);
	end
	if(MetaMapOptions.ShowMapList) then
		MetaMap_MapBackDrop:SetWidth(MetaMapFrame:GetWidth() - MetaMap_MapListFrame:GetWidth() -1);
	else
		MetaMap_MapBackDrop:SetWidth(MetaMapFrame:GetWidth());
	end
	MetaMap_MapBackDrop:SetHeight(MetaMapFrame:GetHeight());
end

function MetaMap_UpdateAlpha()
	if(MetaMapOptions.SaveSet == 1) then
		MetaMapOptions.MetaMapAlpha1 = MetaMapAlphaSlider:GetValue();
		WorldMapFrame:SetAlpha(MetaMapOptions.MetaMapAlpha1);
	else
		MetaMapOptions.MetaMapAlpha2 = MetaMapAlphaSlider:GetValue();
		WorldMapFrame:SetAlpha(MetaMapOptions.MetaMapAlpha2);
	end
	MetaMapMainCoords:SetAlpha(255);
	MetaMapMenu:SetAlpha(255);
	WorldMapButton:SetAlpha(MetaMapAlphaSlider:GetValue() + 0.2);
end

function MetaMap_UpdateScale()
	if(not MetaMap_FullScreenMode) then
		if(MetaMapOptions.SaveSet == 1) then
			MetaMapOptions.MetaMapScale1 = MetaMapScaleSlider:GetValue();
			SetEffectiveScale(WorldMapFrame, MetaMapOptions.MetaMapScale1);
		else
			MetaMapOptions.MetaMapScale2 = MetaMapScaleSlider:GetValue();
			SetEffectiveScale(WorldMapFrame, MetaMapOptions.MetaMapScale2);
		end
		MetaMapTopFrame:SetWidth(WorldMapButton:GetWidth()+10);
		MetaMapTopFrame:SetHeight(WorldMapButton:GetHeight()+100);
	end
end

function MetaMap_UpdateTTScale()
	if(MetaMapOptions.SaveSet == 1) then
		MetaMapOptions.MetaMapTTScale1 = MetaMapTTScaleSlider:GetValue();
		WorldMapTooltip:SetScale(MetaMapOptions.MetaMapTTScale1);
	else
		MetaMapOptions.MetaMapTTScale2 = MetaMapTTScaleSlider:GetValue();
		WorldMapTooltip:SetScale(MetaMapOptions.MetaMapTTScale2);
	end
	MetaMap_SetNUNtooltip();
end

function MetaMapFrameDropDown_Initialize()
	local DropDownList = {};
	for zoneKey in MetaMap_Data do
		local detail = {zone = zoneKey, location = MetaMap_Data[zoneKey]["ZoneName"]};
    table.insert(DropDownList, detail);
	end
	local sort = MetaMap_sortType;
	MetaMap_sortType = METAMAP_SORTBY_LOCATION;
  table.sort(DropDownList, MetaMap_SortCriteria);
	MetaMap_sortType = sort;

	for zoneKey in DropDownList do
		local info = {
			text = DropDownList[zoneKey]["location"];
			value = DropDownList[zoneKey]["zone"];
			func = MetaMapDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
	UIDropDownMenu_SetSelectedValue(MetaMapFrameDropDown, MetaMapOptions.MetaMapZone);
end

function MetaMapDropDown_OnClick()
	local id = this:GetID();
	UIDropDownMenu_SetSelectedID(MetaMapFrameDropDown, id);
	MetaMapOptions.MetaMapZone = this.value;
	MetaMap_Toggle(true);
end

function MetaMap_Refresh()
	if(MetaMapOptions.MetaMapZone > 0 and MetaMapOptions.MetaMapZone < table.getn(MetaMap_Data)+1) then
		MetaMap_MapImage:SetTexture(METAMAP_MAP_PATH..MetaMap_Data[MetaMapOptions.MetaMapZone]["texture"]);
		MetaMapText_Instance:SetText("|cffffffff"..MetaMap_Data[MetaMapOptions.MetaMapZone]["ZoneName"]);
		MetaMapNotes_MapUpdate();
	end
end

function MetaMapMenu_Init()
	local x = 1; local y = 1;
	for i, menudata in METAMAPMENU_LIST do
		local flag = false;
		local button = getglobal("MetaMapMenu_Option"..x);
		button:SetHeight(METAMAPMENU_BUTTON_HEIGHT);
		button.shade = false;
		if(x == 1) then
			button.toggle = MetaMapOptions.MetaMapCoords;
		elseif(x == 2) then
			button.toggle = MetaMapOptions.MetaMapMiniCoords;
		elseif(x == 3) then
			button.toggle = false;
		elseif(x == 4) then
			if(MetaMapOptions.SaveSet == 1) then
				button.toggle = MetaMapOptions.ActionMode1;
			else
				button.toggle = MetaMapOptions.ActionMode2;
			end
		elseif(x == 5) then
			button.toggle = false;
			getglobal("MetaMapMenu_Option"..x.."Text"):SetText(MetaMapOptions.SaveSet)
		elseif(x == 6) then
			if(MetaMapFrame:IsVisible()) then
				button.shade = true;
				button.toggle = false;
			else
				flag = true;
			end
		elseif(x == 7) then
			-- spacer
		elseif(x == 8) then
			button.toggle = false;
		elseif(x == 9) then
			if(IsAddOnLoaded("FlightMap")) then
				button.toggle = false;
			else
				flag = true;
			end
		elseif(x == 10) then
			if(IsAddOnLoaded("Gatherer")) then
				button.toggle = false;
			else
				flag = true;
			end
		elseif(x == 11) then
				button.toggle = false;
		elseif(x == 12) then
			if(IsAddOnLoaded("CT_MapMod")) then
				button.toggle = MetaMapOptions.UseMapMod;
			else
				MetaMapOptions.UseMapMod = false;
				flag = true;
			end
		elseif(x == 13) then
			button.toggle = false;
		elseif(x == 14) then
			button.toggle = FWM_ShowUnexplored;
		end
		
		if(flag) then
			button:SetHeight(1);
			button:Hide();
			y = y - 1;
		elseif(menudata.name == "Spacer") then
			button:SetHeight(8);
			button:Hide();
		else
			if button.toggle then
				getglobal("MetaMapMenu_Option"..x.."Check"):Show();
			else
				getglobal("MetaMapMenu_Option"..x.."Check"):Hide();
			end
			if button.shade then
				getglobal("MetaMapMenu_Option"..x.."Shade"):SetTexture(METAMAP_IMAGE_PATH.."Color"..MetaMapOptions.ShadeSet);
				getglobal("MetaMapMenu_Option"..x.."Shade"):Show();
			else
				getglobal("MetaMapMenu_Option"..x.."Shade"):Hide();
			end
			button:SetText(menudata.name);
			button:Show();
		end
		x = x + 1; y = y + 1;
	end
	MetaMapMenu:SetHeight((METAMAPMENU_BUTTON_HEIGHT * y) + (METAMAPMENU_BUTTON_HEIGHT * 2));
end

function MetaMapMenu_Select(id)
	id = tonumber(id)
	local button = getglobal("MetaMapMenu_Option"..id);
	if button.toggle then
		button.toggle = false;
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	else
		button.toggle = true;
		getglobal("MetaMapMenu_Option"..id.."Check"):Show()
	end
	if(id == 1) then
		MetaMapOptions.MetaMapCoords = button.toggle;
		MetaMapOptions_Init();	
	elseif(id == 2) then
		MetaMapOptions.MetaMapMiniCoords = button.toggle;
		MetaMapOptions_Init();	
	elseif(id == 3) then
		if(MetaMapFilterMenu:IsVisible()) then
			MetaMapFilterMenu:Hide();
		else
			MetaMapFilterMenu:Show();
		end
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 4) then
		ActionMode = button.toggle;
		if(MetaMapOptions.SaveSet == 1) then
			MetaMapOptions.ActionMode1 = button.toggle;
		else
			MetaMapOptions.ActionMode2 = button.toggle;
		end
		MetaMapOptions_Init();	
	elseif(id == 5) then
		MetaMapSaveSet_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
		getglobal("MetaMapMenu_Option"..id.."Text"):SetText(MetaMapOptions.SaveSet)
		MetaMapOptions_Init();	
	elseif(id == 6) then
		MetaMapShadeSet_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
		getglobal("MetaMapMenu_Option"..id.."Shade"):SetTexture(METAMAP_IMAGE_PATH.."Color"..MetaMapOptions.ShadeSet);
		MetaMapOptions_Init();	
	elseif(id == 7) then
		-- spacer
	elseif(id == 8) then
		MetaMapExtOptions_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 9) then
		FlightMapOptions_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 10) then
		GathererOptions_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 11) then
		MetaMap_LoadBWP();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 12) then
		MetaMapOptions.UseMapMod = button.toggle;
	elseif(id == 13) then
		MetaMap_LoadWKB();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 14) then
		FWM_ShowUnexplored = button.toggle;
		MetaMap_LoadFWM(1);
	end
end

function MetaMapMenu_OnShow(mode)
	MetaMapMenu:ClearAllPoints();
	local setBottom = false;
	local x, y = GetCursorPosition();
	if(y < (UIParent:GetHeight() /2)) then setBottom = true; end
	if(MetaMap_FullScreenMode) then
		x = x / WorldMapFrame:GetEffectiveScale();
		y = y / WorldMapFrame:GetEffectiveScale();
	else
		x = x / UIParent:GetEffectiveScale();
		y = y / UIParent:GetEffectiveScale();
	end
	if(mode == "FuBar" or mode == "Titan") then
		if(mode == "FuBar") then
			y = y + 10
		end
		if(setBottom) then
			MetaMapMenu:SetPoint("BOTTOM", "UIParent", "BOTTOMLEFT", x, y);
		else
			MetaMapMenu:SetPoint("TOP", "UIParent", "BOTTOMLEFT", x, y);
		end
		MetaMapSliderMenu:Hide();
		MetaMapMenu:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 32, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
		MetaMapFilterMenu:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 32, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
	elseif(mode == "Minimap") then
		if(setBottom) then
			MetaMapMenu:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x +10, y +10);
		else
			MetaMapMenu:SetPoint("TOPRIGHT", "UIParent", "BOTTOMLEFT", x +10, y +10);
		end
		MetaMapSliderMenu:Show();
		MetaMapButtonSlider:Show();
		MetaMapAlphaSlider:Hide();
		MetaMap_BackDropSlider:Hide();
		MetaMapScaleSlider:Hide();
		MetaMapTTScaleSlider:Hide();
		MetaMapSliderMenu:SetHeight(55);
		MetaMapMenu:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
		MetaMapFilterMenu:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
	elseif(mode == "Mainmap") then
		MetaMapMenu:SetPoint("TOP", "UIParent", "BOTTOMLEFT", x, y);
		MetaMapSliderMenu:Show();
		MetaMapButtonSlider:Hide();
		MetaMapAlphaSlider:Show();
		MetaMapScaleSlider:Show();
		MetaMapTTScaleSlider:Show();
		if(MetaMapFrame:IsVisible()) then
			MetaMap_BackDropSlider:Show();
			MetaMapSliderMenu:SetHeight(130);
		else
			MetaMap_BackDropSlider:Hide();
			MetaMapSliderMenu:SetHeight(105);
		end
		MetaMapMenu:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
		MetaMapFilterMenu:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
	end
	MetaMapMenu:Show();
end

function MetaMapMenu_OnUpdate()
	if (MetaMapMenu:IsVisible()) then
		if (not MouseIsOver(MetaMapMenu) and not MouseIsOver(MetaMapButton)
			and not MouseIsOver(MetaMap_OptionsButton) and not MouseIsOver(MetaMapSliderMenu)
			and not MouseIsOver(TitanPanelMetaMapButton) and not MouseIsOver(MetaMapFilterMenu)) then
			MetaMapMenu:Hide();
			MetaMapFilterMenu:Hide();
		end
	end
end

function MetaMap_FilterInit()
	for i=0, 9, 1 do
		getglobal("MetaMapSubMenu_Option"..i):SetChecked(MetaMap_NoteFilter[i]);
		getglobal("MetaMapSubMenu_Option"..i.."Texture"):SetTexture(METAMAP_ICON_PATH.."Icon"..i);
	end
end

function MetaMap_FilterNotes(setAll)
	if(setAll ~= nil) then
		for i=0, 9, 1 do
			getglobal("MetaMapSubMenu_Option"..i):SetChecked(setAll);
			MetaMap_NoteFilter[i] = setAll;
		end
	else
		for i=0, 9, 1 do
			if(getglobal("MetaMapSubMenu_Option"..i):GetChecked()) then
				MetaMap_NoteFilter[i] = true;
			else
				MetaMap_NoteFilter[i] = false;
			end
		end
	end
	MetaMapNotes_MapUpdate();
end

function MetaMap_ToggleDialog(tab)
	local subFrame = getglobal(tab);
	MetaMap_GeneralDialog:Hide();
	MetaMap_NotesDialog:Hide();
	MetaKB_HoldingFrame:Hide();
	MetaFWM_HoldingFrame:Hide();
	MetaMap_ImportDialog:Hide();
	MetaMap_ZoneShiftDialog:Hide();
	if(MetaMapBKP_BackUpFrame ~= nil and MetaMapBKP_BackUpFrame:IsVisible()) then
		MetaMapBKP_BackUpFrame:Hide();
	end
	if(subFrame) then
		if(MetaMap_DialogFrame:IsVisible()) then
			PlaySound("igCharacterInfoTab");
			getglobal(tab):Show();
		else
			ShowUIPanel(MetaMap_DialogFrame);
			getglobal(tab):Show();
		end
	end
end

function MetaMap_OptionsTab_OnClick()
	if(this:GetName() == "MetaMap_DialogFrameTab1") then
		MetaMap_ToggleDialog("MetaMap_GeneralDialog");
	elseif(this:GetName() == "MetaMap_DialogFrameTab2") then
		MetaMap_ToggleDialog("MetaMap_NotesDialog");
	elseif(this:GetName() == "MetaMap_DialogFrameTab3") then
		MetaMap_ToggleDialog("MetaKB_HoldingFrame");
	elseif(this:GetName() == "MetaMap_DialogFrameTab4") then
		MetaMap_ToggleDialog("MetaFWM_HoldingFrame");
	elseif(this:GetName() == "MetaMap_DialogFrameTab5") then
		MetaMap_ToggleDialog("MetaMap_ImportDialog");
	elseif(this:GetName() == "MetaMap_DialogFrameTab6") then
		MetaMap_ToggleDialog("MetaMap_ZoneShiftDialog");
	end
	PlaySound("igCharacterInfoTab");
end

function MetaMapExtOptions_Toggle()
	if(MetaMap_DialogFrame:IsVisible()) then
		HideUIPanel(MetaMap_DialogFrame);
	else
		if(MetaMap_FullScreenMode) then
			MetaMap_DialogFrame:SetParent("WorldMapFrame");
		end
		ShowUIPanel(MetaMap_DialogFrame);
	end
end

function MetaMapSaveSet_Toggle()
	if(MetaMapOptions.SaveSet == 1) then
		MetaMapOptions.SaveSet = 2;
	else
		MetaMapOptions.SaveSet = 1;
	end
	MetaMapOptions_Init();
	MetaMap_CurrentSaveSet = MetaMapOptions.SaveSet;
end

function MetaMap_MapModeToggle(mode)
	MetaMapOptions.SaveSet = mode;
	MetaMap_ToggleFrame(WorldMapFrame);
end

function MetaMapShadeSet_Toggle()
	if(MetaMapOptions.ShadeSet == 1) then
		MetaMapOptions.ShadeSet = 2;
	elseif(MetaMapOptions.ShadeSet == 2) then
		MetaMapOptions.ShadeSet = 3;
	elseif(MetaMapOptions.ShadeSet == 3) then
		MetaMapOptions.ShadeSet = 4;
	elseif(MetaMapOptions.ShadeSet == 4) then
		MetaMapOptions.ShadeSet = 1;
	end
	MetaMapOptions_Init();
end

function MetaMap_OptionsDialogInit()
	MetaMap_MenuModeCheckButton:SetChecked(MetaMapOptions.MenuMode);
	MetaMap_TTWrapCheckButton:SetChecked(MetaMapOptions.TooltipWrap);
	MetaMap_MiniButtonCheckButton:SetChecked(MetaMapOptions.MetaMapButtonShown);
	MetaMap_POICheckButton:SetChecked(MetaMapOptions.usePOI);
	MetaMap_ListColorsButton:SetChecked(MetaMapOptions.ListColors);
	MetaMap_ZoneHeaderButton:SetChecked(MetaMapOptions.ZoneHeader);
	MetaMap_LastNoteHighlight:SetChecked(MetaMapOptions.LastHighlight);
	MetaMap_LastMiniHighlight:SetChecked(MetaMapOptions.LastMiniHighlight);
	MetaMap_AcceptIncoming:SetChecked(MetaMapOptions.AcceptIncoming);
	MetaMap_PartyAsMini:SetChecked(MetaMapOptions.MiniParty);
	MetaMap_ShowCreator:SetChecked(MetaMapOptions.MetaMapShowAuthor);
end

function MetaMapOptions_Init()
	local ActionMode = false;
	MetaMap_MapBackDrop:SetTexture(METAMAP_SHADER_PATH.."Shader"..MetaMapOptions.ShadeSet);
	MetaMapMiniCoords:SetTextColor(MetaMapNotes_Colors[MetaMapOptions.MiniColor].r, MetaMapNotes_Colors[MetaMapOptions.MiniColor].g, MetaMapNotes_Colors[MetaMapOptions.MiniColor].b);
	
	if(MetaMapOptions.SaveSet == 1) then
		if(MetaMapOptions.MetaMapAlpha1 < 0.15) then MetaMapOptions.MetaMapAlpha1 = 0.15; end
		MetaMapScaleSlider:SetValue(MetaMapOptions.MetaMapScale1);
		MetaMap_BackDropSlider:SetValue(MetaMapOptions.BDshader1);
		MetaMapAlphaSlider:SetValue(MetaMapOptions.MetaMapAlpha1);
		MetaMapTTScaleSlider:SetValue(MetaMapOptions.MetaMapTTScale1);
		ActionMode = MetaMapOptions.ActionMode1;
	else
		if(MetaMapOptions.MetaMapAlpha2 < 0.15) then MetaMapOptions.MetaMapAlpha2 = 0.15; end
		MetaMapScaleSlider:SetValue(MetaMapOptions.MetaMapScale2);
		MetaMap_BackDropSlider:SetValue(MetaMapOptions.BDshader2);
		MetaMapAlphaSlider:SetValue(MetaMapOptions.MetaMapAlpha2);
		MetaMapTTScaleSlider:SetValue(MetaMapOptions.MetaMapTTScale2);
		ActionMode = MetaMapOptions.ActionMode2;
	end
	if(ActionMode) then
		WorldMapButton:EnableMouse(false);
		MetaMapTopFrame:EnableMouse(false);
		MetaMapFrame:EnableMouse(false);
	else
		WorldMapButton:EnableMouse(true);
		MetaMapTopFrame:EnableMouse(true);
		MetaMapFrame:EnableMouse(true);
	end
	if(MetaMapOptions.MetaMapButtonShown) then
		MetaMapButtonSlider:SetValue(MetaMapOptions.MetaMapButtonPosition);
		MetaMapButton_UpdatePosition();
		MetaMapButton:Show();
	else
		MetaMapButton:Hide();
	end
	if(MetaMapOptions.MetaMapCoords) then
		MetaMapMainCoords:Show();
	else
		MetaMapMainCoords:Hide();
	end
	if(MetaMapOptions.MetaMapMiniCoords) then
		MetaMap_MiniCoords:Show();
	else
		MetaMap_MiniCoords:Hide();
	end
	if(MetaMapOptions.ShowMapList) then
		MetaMapList_Init();
	else
		MetaMap_MapListFrame:Hide();
	end
	MetaMap_UpdateAlpha();
	MetaMap_UpdateScale();
	MetaMap_UpdateTTScale();
	MetaMap_UpdateBackDrop();
end

function MetaMapButton_UpdatePosition()
	MetaMapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
		52 - (80 * cos(MetaMapOptions.MetaMapButtonPosition)),
		(80 * sin(MetaMapOptions.MetaMapButtonPosition)) - 52
	);
end

function MetaMap_ButtonTooltip()
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(METAMAP_TITLE, 0, 1, 0);
	GameTooltip:AddLine(METAMAP_BUTTON_TOOLTIP1, 1, 1, 1);
	if(MetaMapOptions.MenuMode) then
		GameTooltip:AddLine(METAMAP_BUTTON_TOOLTIP2, 1, 1, 1);
	end
	GameTooltip:Show();
end

function MetaMap_round(num, idp)
  local mult = 10^(idp or 0);
  return (math.floor(num * mult + 0.5) / mult);
end

function SetEffectiveScale(frame, scale)
	frame.scale = scale;
	local parent = frame:GetParent();
	if(parent) then
		scale = scale / parent:GetEffectiveScale();
	end
	frame:SetScale(scale);
end

function MiniMapCoords_OnClick()
	local mmc = MetaMapOptions.MiniColor;
	if(IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
		local msg = "My location: "..GetRealZoneText().." ("..MetaMapMiniCoords:GetText()..")";
		ChatFrameEditBox:Insert(msg);
	elseif(IsControlKeyDown()) then
		if(mmc == 9) then
			mmc = 0;
		else
			mmc = mmc +1;
		end
		MetaMapMiniCoords:SetTextColor(MetaMapNotes_Colors[mmc].r, MetaMapNotes_Colors[mmc].g, MetaMapNotes_Colors[mmc].b);
	end
	MetaMapOptions.MiniColor = mmc;
end

function MetaMapList_Init()
	if(not MetaMapOptions.ShowMapList) then
		return;
	end
	if(MetaMapOptions.SortList) then
		MetaMapList_Header:SetText(METAMAPLIST_UNSORTED);
	else
		MetaMapList_Header:SetText(METAMAPLIST_SORTED);
	end
	MetaMap_MapListFrame:Show();
	MetaMapPing_OnUpdate(30)
	FauxScrollFrame_SetOffset(MetaMapList_ScrollFrame, MetaMap_ListOffset);
	MetaMapList_BuildList();
	if(not MetaMap_NoteList[1]) then
		MetaMap_MapListFrame:Hide();
		return;
	end
	MetaMapList_UpdateScroll();
end

function MetaMapList_OnClick(button, id)
	local continent, zone, currentZone = MetaMap_GetCurrentMapInfo();
	if(button	== "LeftButton")	then
		if(IsControlKeyDown())	then
			local LootID = MetaMapNotes_Data[continent][zone][id].lootid;
			local Name = MetaMapNotes_Data[continent][zone][id].name;
			MetaMap_LoadBLT(LootID, Name);
		elseif(IsShiftKeyDown() and ChatFrameEditBox:IsVisible())	then
			if(not currentZone) then return; end
			local tname = currentZone[id].name;
			local tinf1 = currentZone[id].inf1;
			local x = MetaMap_round(currentZone[id].xPos *100);
			local y = MetaMap_round(currentZone[id].yPos *100);
			local tzone = MetaMap_ZoneNames[continent][zone];
			if(strlen(tinf1) > 0) then tinf1 = " ["..tinf1.."] "; end
			local msg = tname.." "..tinf1.." ("..tzone.." - "..x..","..y..")";
			ChatFrameEditBox:Insert(msg);
		elseif(id == 0) then
			MetaMapPing_SetPing(currentZone, id);
		else
			MetaMapPing_SetPing(currentZone, MetaMap_NoteList[this:GetID() + MetaMap_ListOffset].id);
		end
	elseif(button	== "RightButton")	then
		if(IsControlKeyDown() or IsShiftKeyDown()) then
			-- Maybe for other functions.
		else
			MetaMapNotes_Note_OnClick("LeftButton",	id);
		end
	end
end

function MetaMapList_BuildList()
	MetaMap_NoteList = {};
	local zone = GetCurrentMapZone();
	local continent = GetCurrentMapContinent();
	local selectedZone;
	MetaMapList_InfoText:Hide();
	MetaMapList_PlayerButton:Hide();

	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		selectedZone = MetaMapNotes_Data[0][MetaMapOptions.MetaMapZone];
	elseif(continent == -1) then
		selectedZone = MetaMapNotes_Data[GetRealZoneText()];
	else
		selectedZone = MetaMapNotes_Data[continent][zone];
	end
	local playerContinent, playerZone = MetaMap_NameToZoneID(GetRealZoneText());
	if(continent == playerContinent and zone == playerZone and not MetaMapFrame:IsVisible()) then
		getglobal("MetaMapList_PlayerButton".."Name"):SetText(UnitName("Player"));
		MetaMapList_PlayerButton:Show();
	elseif(MetaMapFrame:IsVisible()) then
		MetaMapList_InfoText:Show();
	end
	if(not selectedZone or zone < 0) then
		MetaMap_MapListFrame:Hide();
	else
		local index = 1;
		for i, value in selectedZone do
			if(MetaMap_NoteFilter[selectedZone[i].icon]) then
 			MetaMap_NoteList[index] = {};
			MetaMap_NoteList[index]["name"] = selectedZone[i]["name"];
			MetaMap_NoteList[index]["xPos"] = selectedZone[i]["xPos"];
			MetaMap_NoteList[index]["yPos"] = selectedZone[i]["yPos"];
			MetaMap_NoteList[index]["ncol"] = selectedZone[i]["ncol"];
			MetaMap_NoteList[index]["icon"] = selectedZone[i]["icon"];
			MetaMap_NoteList[index]["id"] = i;
			MetaMap_NoteList.lastEntry = index;
			index = index +1;
			end
		end
		if(MetaMapOptions.SortList) then
			local sort = MetaMap_sortType;
			MetaMap_sortType = METAMAP_SORTBY_NAME;
		  table.sort(MetaMap_NoteList, MetaMap_SortCriteria);
			MetaMap_sortType = sort;
		end
	end
end

function MetaMapList_UpdateScroll()
	for i = 1, METAMAPLIST_SCROLL_FRAME_BUTTONS_SHOWN, 1 do
		local buttonIndex = i + FauxScrollFrame_GetOffset(MetaMapList_ScrollFrame);
		local scrollFrameButton = getglobal("MetaMapList_ScrollFrameButton"..i);
		local NameButton = getglobal("MetaMapList_ScrollFrameButton"..i.."Name");
		if(buttonIndex < MetaMap_NoteList.lastEntry +1) then
			MetaMap_ListOffset = buttonIndex - i;
			NameButton:SetText(MetaMap_NoteList[buttonIndex]["name"]);
			getglobal("MetaMapList_ScrollFrameButton"..i.."NoteID"):SetText(MetaMap_NoteList[buttonIndex]["id"]);
			if(MetaMapOptions.ListColors) then
				local cNr = MetaMap_NoteList[buttonIndex]["ncol"]
				NameButton:SetTextColor(MetaMapNotes_Colors[cNr].r, MetaMapNotes_Colors[cNr].g, MetaMapNotes_Colors[cNr].b);
			else
				NameButton:SetTextColor(MetaMapNotes_Colors[0].r, MetaMapNotes_Colors[0].g, MetaMapNotes_Colors[0].b);
			end
			scrollFrameButton:Show();
		else
			scrollFrameButton:Hide();
		end
	end
	FauxScrollFrame_Update(MetaMapList_ScrollFrame, MetaMap_NoteList.lastEntry,
		METAMAPLIST_SCROLL_FRAME_BUTTONS_SHOWN, METAMAPLIST_SCROLL_FRAME_BUTTON_HEIGHT);
end

function MetaMapPing_SetPing(currentZone, id)
	if(MetaMapPing:IsVisible()) then
		MetaMapPing:Hide();
		return;
	end
	local x, y;
	if(id == 0) then
		MetaMapPing:SetParent(WorldMapButton);
		x, y = GetPlayerMapPosition("player");
	else
		MetaMapPing:SetParent(getglobal("MetaMapNotesPOI"..id));
		x = currentZone[id]["xPos"];
		y = currentZone[id]["yPos"];
	end
	x = (x * WorldMapButton:GetWidth()) - (WorldMapButton:GetScale() * 7);
	y = (-y * WorldMapButton:GetHeight()) - (WorldMapButton:GetScale() * 7);
	MetaMapPing:SetPoint("CENTER", WorldMapButton, "TOPLEFT", x, y);
	MetaMapPing:SetAlpha(255);
	MetaMapPing.timer = MetaMap_PingTime;
	MetaMapPing:Show();
	PlaySound("MapPing");
end

function MetaMapPing_OnUpdate(elapsed)
	if(MetaMapPing:IsVisible()) then
		if ( MetaMapPing.timer > 0 ) then
			MetaMapPing.timer = MetaMapPing.timer - elapsed;
		else
			MetaMapPing:Hide();
		end
	end
end

function MetaMap_ZoneHeader()
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
	MetaMapNotes_ZoneSearchResult:SetText(format(METAMAPNOTES_ZONESEARCH_TEXT, mapName));
	if(not MetaMapOptions.ZoneHeader) then
		MetaMap_ZoneHeaderFrame:Hide();
		return;
	end
	local realContinent, realZone = MetaMap_NameToZoneID(GetRealZoneText());
	if(realZone == nil) then realZone = 0; end
	continent = "|cfff0B300Map Continent: |cffffffff"..continent;
	zone = "   |cfff0B300Map Zone: |cffffffff"..mapName.." ("..zone..")";
	realContinent = "|cfff0B300Real Continent: |cffffffff"..realContinent;
	realZone = "   |cfff0B300Real Zone: |cffffffff"..GetRealZoneText().." ("..realZone..")";
	MetaMapZoneHeaderText1:SetText(continent..zone);
	MetaMapZoneHeaderText2:SetText(realContinent..realZone);
	MetaMap_ZoneHeaderFrame:SetWidth(WorldMapDetailFrame:GetWidth()-200);
	MetaMap_ZoneHeaderFrame:Show();
end

function MetaMap_LoadImports()
	if(not IsAddOnLoaded("MetaMapCVT")) then
		LoadAddOn("MetaMapCVT");
	end
	if(IsAddOnLoaded("MetaMapCVT")) then
		MetaMap_LoadExportsButton:Disable();
		MetaMapCVT_CheckData();
	else
		MetaMap_ImportHeader:SetTextColor(1,0,0);
		MetaMap_ImportHeader:SetText(METAMAPCVT_NOLOAD);
	end
end

function MetaMap_LoadExports()
	if(not IsAddOnLoaded("MetaMapEXP")) then
		LoadAddOn("MetaMapEXP");
	end
	if(IsAddOnLoaded("MetaMapEXP")) then
		MetaMap_LoadImportsButton:Disable();
		MetaMapEXP_CheckData();
	else
		MetaMap_ImportHeader:SetTextColor(1,0,0);
		MetaMap_ImportHeader:SetText(METAMAPEXP_NOT_ENABLED);
	end
end

function MetaMap_ZSMOnShow()
	if(GetLocale() == "deDE") then
			MetaMapZSM_TextHeader:SetText("German client detected");
	elseif(GetLocale() == "frFR") then
			MetaMapZSM_TextHeader:SetText("French client detected");
	else
		MetaMap_LoadZSMButton:Disable();
		MetaMapZSM_TextHeader:SetText("English client detected - no zoneshift required");
	end
end

function MetaMap_LoadZSM()
	if(not IsAddOnLoaded("MetaMapZSM")) then
		LoadAddOn("MetaMapZSM");
	end
	if(IsAddOnLoaded("MetaMapZSM")) then
		MetaMapZSM_TextHeader:Hide();
		MetaMap_LoadZSMButton:Hide();
	else
		MetaMap_LoadZSMButton:Disable();
		MetaMapZSM_TextHeader:SetText(METAMAPZSM_NOT_ENABLED);
	end
end

function MetaMap_LoadBKP()
	if(not IsAddOnLoaded("MetaMapBKP")) then
		LoadAddOn("MetaMapBKP");
	end
	if(IsAddOnLoaded("MetaMapBKP")) then
		MetaMap_GeneralDialog:Hide();
		MetaMapBKP_BackUpFrame:Show();
	else
		MetaMap_LoadBKP:Disable();
		MetaMapBKP_NoLoad:Show();
	end
end

function MetaMap_LoadBLT(lootID, Name)
	if(not IsAddOnLoaded("MetaMapBLT")) then
		LoadAddOn("MetaMapBLT");
	end
	if(IsAddOnLoaded("MetaMapBLT")) then
		MetaMapBLT_ClassMenu:Hide();
		MetaMapBLT_OnSelect(lootID, Name);
	else
		MetaMap_StatusPrint("MetaMapBLT addon is not enabled!", true);
	end
end
	
function MetaMap_LoadBWP(id, mode)
	if(not IsAddOnLoaded("MetaMapBWP")) then
		LoadAddOn("MetaMapBWP");
	end
	if(IsAddOnLoaded("MetaMapBWP")) then
		if(mode == nil) then
			BWP_CallMenu();
		elseif(mode == 1) then
			MetaKBMenu_RBSelect(id);
		elseif(mode == 2) then
			MetaMapNotes_RBSelect(id);
		end
	else
		MetaMap_StatusPrint(METAMAPBWP_NOT_ENABLED, true);
	end
end

function MetaMap_LoadWKB(mode)
	if(not IsAddOnLoaded("MetaMapWKB")) then
		LoadAddOn("MetaMapWKB");
	end
	if(IsAddOnLoaded("MetaMapWKB")) then
		if(mode == nil or mode == 1) then
			MetaKB_ToggleFrame(mode);
		elseif(mode == 2) then
			MetaKB_UpdateKeySelectedUnit();
		end
	else
		if(MetaKB_HoldingFrame:IsVisible()) then
			MetaKB_HoldingFrameInfo:SetText(METAKB_NOT_ENABLED);
		else
			MetaMap_StatusPrint(METAKB_NOT_ENABLED, true);
		end
	end
end

function MetaMap_LoadFWM(mode)
	if(not IsAddOnLoaded("MetaMapFWM")) then
		LoadAddOn("MetaMapFWM");
	end
	if(IsAddOnLoaded("MetaMapFWM")) then
		if(mode == nil) then
			FWM_ShowUnexplored = true;
		end 
		WorldMapFrame_Update();
	else
		FWM_ShowUnexplored = false;
		MetaMapOptions.FWMretain = false;
		if(MetaFWM_HoldingFrame:IsVisible()) then
			MetaFWM_HoldingFrameInfo:SetText(METAMAPFWM_NOT_ENABLED);
		else
			MetaMap_StatusPrint(METAMAPFWM_NOT_ENABLED, true);
		end
	end
end

function MetaMap_HelpOnEnter(header, ...)
	local myArgs = { unpack(arg) };
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(header, 0.2, 0.5, 1, true);
	for i,string in myArgs do
		GameTooltip:AddLine(string, 1, 1, 1, true);
	end
	GameTooltip:Show();
end

function MetaMap_StatusPrint(msg, display, r, g, b)
	if(not display) then return; end
	msg = "<"..METAMAP_TITLE..">: "..msg;
	if DEFAULT_CHAT_FRAME then
		if(r == nil or g == nil or b == nil) then
			r = 0.60;
			g = 0.80;
			b = 1.00;
		end
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
	end
end

function MetaMap_CreateNoteObject(noteNumber)
	local button;
	if(getglobal("MetaMapNotesPOI"..noteNumber)) then
		button = getglobal("MetaMapNotesPOI"..noteNumber);
	else
		button = CreateFrame("Button" ,"MetaMapNotesPOI"..noteNumber, WorldMapButton, "MetaMapNotes_NoteTemplate");
		button:SetID(noteNumber);
		MetaMapNotes_LastNote = MetaMapNotes_LastNote +1;
	end
	return button;
end

function MetaMap_CreateLineObject(lineNumber)
	local line;
	if(getglobal("MetaMapNotesLines_"..lineNumber)) then
		line = getglobal("MetaMapNotesLines_"..lineNumber);
	else
		MetaMapNotesLinesFrame:CreateTexture("MetaMapNotesLines_"..lineNumber, "ARTWORK");
		line = getglobal("MetaMapNotesLines_"..lineNumber);
		MetaMapNotes_LastLine = MetaMapNotes_LastLine +1;
	end
	return line
end

function MetaMapNotes_AddNewNote(continent, zone, xPos, yPos, name, inf1, inf2, creator, icon, ncol, in1c, in2c, mininote)
	if(xPos == 0 and yPos == 0) then
		MetaMap_StatusPrint(METAMAPNOTES_INVALIDZONE, true);
		return;
	end
	if(continent == nil or zone == nil or xPos == nil or yPos == nil or name == nil) then return; end
	if(inf1 == nil) then inf1 = ""; end
	if(inf2 == nil) then inf2 = ""; end
	if(icon == nil) then icon = 0; end
	if(ncol == nil) then ncol = 0; end
	if(in1c == nil) then in1c = 0; end
	if(in2c == nil) then in2c = 0; end
	if(creator == nil) then creator = unitName("player"); end
	local id = 0;
	local index = 0;
	local checkNote;
	local returnValue = true;
	local currentZone = MetaMapNotes_Data[continent][zone];
	if(continent == -1 or type(continent) == "string") then
		currentZone = MetaMapNotes_Data[continent]
	else
		index = MetaMapNotes_GetZoneTableSize(currentZone);
	end

	if(mininote == 0 or mininote == nil) then
		MetaMapNotes_SetNextAsMiniNote = 0;
	elseif(mininote == 1) then
		MetaMapNotes_SetNextAsMiniNote = 1;
	elseif(mininote == 2) then
		MetaMapNotes_SetNextAsMiniNote = 2;
	end		

	if(MetaMapNotes_SetNextAsMiniNote ~= 2) then
		checkNote = MetaMapNotes_CheckNearNotes(continent, zone, xPos, yPos);
		if(checkNote) then
			returnValue = false;
		else
			MetaMapNotes_TempData_Id = index + 1
			currentZone[MetaMapNotes_TempData_Id] = {};
			currentZone[MetaMapNotes_TempData_Id].name = name;
			currentZone[MetaMapNotes_TempData_Id].ncol = ncol;
			currentZone[MetaMapNotes_TempData_Id].inf1 = inf1;
			currentZone[MetaMapNotes_TempData_Id].in1c = in1c;
			currentZone[MetaMapNotes_TempData_Id].inf2 = inf2;
			currentZone[MetaMapNotes_TempData_Id].in2c = in2c;
			currentZone[MetaMapNotes_TempData_Id].creator = creator;
			currentZone[MetaMapNotes_TempData_Id].icon = icon;
			currentZone[MetaMapNotes_TempData_Id].xPos = xPos;
			currentZone[MetaMapNotes_TempData_Id].yPos = yPos;
			id = MetaMapNotes_TempData_Id;
			if(MetaMapNotes_MiniNote_Data ~= nil and MetaMapNotes_MiniNote_Data.name == name) then
				MetaMapNotes_MiniNote_Data.id = id;
			end
			returnValue = true;
		end
	end
	if(MetaMapNotes_SetNextAsMiniNote ~= 0) then
		for i=0, index, 1 do
		if(currentZone[i] ~= nil) then
			if(currentZone[i].name == name and currentZone[i].xPos == xPos and currentZone[i].yPos == yPos) then
				id = i;
				break;
			end
		end
		end
		MetaMapNotes_SetMiniNote(id, continent, zone, xPos, yPos, name, inf1, inf2, creator, icon, ncol, in1c, in2c);
		returnValue = returnValue;
	end
	return returnValue, checkNote;
end

function MetaMapNotes_SetMiniNote(id, continent, zone, xPos, yPos, name, inf1, inf2, creator, icon, ncol, in1c, in2c)
	if(type(continent) == "string") then
		MetaMap_StatusPrint(METAMAPNOTES_INVALIDZONE, true);
		return;
	end
	local currentZone;
	local mapName = MetaMap_ZoneNames[continent][zone];

	MetaMapNotes_MiniNote_Data.id = id;
	MetaMapNotes_MiniNote_Data.continent = continent;
	MetaMapNotes_MiniNote_Data.zone = zone;
	MetaMapNotes_MiniNote_Data.zonetext = mapName;
	MetaMapNotes_MiniNote_Data.inf1 = "";
	MetaMapNotes_MiniNote_Data.inf2 = "";
	MetaMapNotes_MiniNote_Data.in1c = 1;
	MetaMapNotes_MiniNote_Data.in2c = 1;
	MetaMapNotes_MiniNote_Data.color = 0;
	MetaMapNotes_MiniNote_Data.creator = creator;
	if(id == 0) then
		MetaMapNotes_MiniNote_Data.xPos = xPos;
		MetaMapNotes_MiniNote_Data.yPos = yPos;
		MetaMapNotes_MiniNote_Data.name = name;
		MetaMapNotes_MiniNote_Data.inf1 = inf1;
		MetaMapNotes_MiniNote_Data.inf2 = inf2;
		MetaMapNotes_MiniNote_Data.in1c = in1c;
		MetaMapNotes_MiniNote_Data.in2c = in2c;
		MetaMapNotes_MiniNote_Data.color = ncol;
		MetaMapNotes_MiniNote_Data.icon = icon;
	elseif(id == -1) then
		MetaMapNotes_MiniNote_Data.xPos = MetaMapNotes_PartyNoteData.xPos;
		MetaMapNotes_MiniNote_Data.yPos = MetaMapNotes_PartyNoteData.yPos;
		MetaMapNotes_MiniNote_Data.name = METAMAPNOTES_PARTYNOTE;
		MetaMapNotes_MiniNote_Data.icon = "party";
	elseif(id > 0) then
		currentZone = MetaMapNotes_Data[continent][zone][id];
		MetaMapNotes_MiniNote_Data.xPos = currentZone.xPos;
		MetaMapNotes_MiniNote_Data.yPos = currentZone.yPos;
		MetaMapNotes_MiniNote_Data.name = currentZone.name;
		MetaMapNotes_MiniNote_Data.inf1 = currentZone.inf1;
		MetaMapNotes_MiniNote_Data.inf2 = currentZone.inf2;
		MetaMapNotes_MiniNote_Data.in1c = currentZone.in1c;
		MetaMapNotes_MiniNote_Data.in2c = currentZone.in2c;
		MetaMapNotes_MiniNote_Data.color = currentZone.ncol;
		MetaMapNotes_MiniNote_Data.icon = currentZone.icon;
		MetaMapNotes_MiniNote_Data.creator = currentZone.creator;
	end
	MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon);
	MiniNotePOI:Show();
	MetaMapNotes_SetNextAsMiniNote = 0;
	MetaMapNotesButtonMiniNoteOff:Enable();
	MetaMapNotes_MapUpdate();
end

function MetaMapNotes_CheckNearNotes(continent, zone, xPos, yPos)
	local currentZone = MetaMapNotes_Data[continent][zone];
	if(currentZone == nil) then return; end
	for i, value in currentZone do
		local deltax = abs(currentZone[i].xPos - xPos);
		local deltay = abs(currentZone[i].yPos - yPos);
		if(deltax <= 0.0009765625 * MetaMapNotes_MinDiff and deltay <= 0.0013020833 * MetaMapNotes_MinDiff) then
			return i;
		end
	end
	return false;
end

function MetaMapNotes_GenerateSendString(version)
-- <MapN> c<1> z<1> x<0.123123> y<0.123123> t<> i1<> i2<> cr<> i<8> tf<3> i1f<5> i2f<6>
	local text = ""
	local pName = UnitName("player");
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
	if(not currentZone) then return; end
	zone = MetaMapNotes_ZoneShift[continent][zone];
	currentZone = MetaMapNotes_Data[continent][zone];
	if(version == 1) then text = "<MapN>"; end
	text = text.." c<"..continent.."> z<"..zone..">";

	if(MetaMapNotes_PartyNoteSet) then
		local xPos = floor(MetaMapNotes_PartyNoteData.xPos * 1000000)/1000000;
		local yPos = floor(MetaMapNotes_PartyNoteData.yPos * 1000000)/1000000;
		text = text.." x<"..xPos.."> y<"..yPos..">";
		text = text.." t<"..METAMAPNOTES_PARTYNOTE..">";
		text = text.." i1<>";
		text = text.." i2<>";
		text = text.." cr<"..pName..">";
		text = text.." i<0>";
		text = text.." tf<0>";
		text = text.." i1f<0>";
		text = text.." i2f<0>";
		text = text.." p<1>";
	elseif(MetaMapNotes_MiniNote_Data.id == 0) then
		local xPos = floor(MetaMapNotes_MiniNote_Data.xPos * 1000000)/1000000;
		local yPos = floor(MetaMapNotes_MiniNote_Data.yPos * 1000000)/1000000;
		text = text.." x<"..xPos.."> y<"..yPos..">";
		text = text.." t<"..MetaMapNotes_EliminateUsedChars(MetaMapNotes_MiniNote_Data.name)..">";
		text = text.." i1<"..MetaMapNotes_EliminateUsedChars(MetaMapNotes_MiniNote_Data.inf1)..">";
		text = text.." i2<"..MetaMapNotes_EliminateUsedChars(MetaMapNotes_MiniNote_Data.inf2)..">";
		text = text.." cr<"..MetaMapNotes_MiniNote_Data.creator..">";
		text = text.." i<"..MetaMapNotes_MiniNote_Data.icon..">";
		text = text.." tf<"..MetaMapNotes_MiniNote_Data.color..">";
		text = text.." i1f<"..MetaMapNotes_MiniNote_Data.in1c..">";
		text = text.." i2f<"..MetaMapNotes_MiniNote_Data.in2c..">";
	else
		if(not currentZone[MetaMapNotes_TempData_Id].creator) then
			currentZone[MetaMapNotes_TempData_Id].creator = pName;
		end
		local xPos = floor(currentZone[MetaMapNotes_TempData_Id].xPos * 1000000)/1000000; --cut to six digits behind the 0
		local yPos = floor(currentZone[MetaMapNotes_TempData_Id].yPos * 1000000)/1000000;
		text = text.." x<"..xPos.."> y<"..yPos..">";
		text = text.." t<"..MetaMapNotes_EliminateUsedChars(currentZone[MetaMapNotes_TempData_Id].name)..">";
		text = text.." i1<"..MetaMapNotes_EliminateUsedChars(currentZone[MetaMapNotes_TempData_Id].inf1)..">";
		text = text.." i2<"..MetaMapNotes_EliminateUsedChars(currentZone[MetaMapNotes_TempData_Id].inf2)..">";
		text = text.." cr<"..currentZone[MetaMapNotes_TempData_Id].creator..">";
		text = text.." i<"..currentZone[MetaMapNotes_TempData_Id].icon..">";
		text = text.." tf<"..currentZone[MetaMapNotes_TempData_Id].ncol..">";
		text = text.." i1f<"..currentZone[MetaMapNotes_TempData_Id].in1c..">";
		text = text.." i2f<"..currentZone[MetaMapNotes_TempData_Id].in2c..">";
	end
	MetaMapNotes_PartyNoteSet = false;
	return text;
end

function MetaMapNotes_EliminateUsedChars(text)
	text = string.gsub(text, "<", "")
	text = string.gsub(text, ">", "")
	return text
end

function MetaMapNotes_GetSendString(msg, who)
	local continent = gsub(msg,".*<MapN+> c<([^>]*)>.*","%1",1)+0;
	local zone = gsub(msg,".*<MapN+>%s+%w+.*z<([^>]*)>.*","%1",1)+0;
	local xPos = gsub(msg,".*<MapN+>%s+%w+.*x<([^>]*)>.*","%1",1)+0;
	local yPos = gsub(msg,".*<MapN+>%s+%w+.*y<([^>]*)>.*","%1",1)+0;
	local name = gsub(msg,".*<MapN+>%s+%w+.*t<([^>]*)>.*","%1",1);
	local inf1 = gsub(msg,".*<MapN+>%s+%w+.*i1<([^>]*)>.*","%1",1);
	local inf2 = gsub(msg,".*<MapN+>%s+%w+.*i2<([^>]*)>.*","%1",1);
	local creator = gsub(msg,".*<MapN+>%s+%w+.*cr<([^>]*)>.*","%1",1);
	local icon = gsub(msg,".*<MapN+>%s+%w+.*i<([^>]*)>.*","%1",1)+0;
	local ncol = gsub(msg,".*<MapN+>%s+%w+.*tf<([^>]*)>.*","%1",1)+0;
	local in1c = gsub(msg,".*<MapN+>%s+%w+.*i1f<([^>]*)>.*","%1",1)+0;
	local in2c = gsub(msg,".*<MapN+>%s+%w+.*i2f<([^>]*)>.*","%1",1)+0;
	zone = MetaMapNotes_ZoneShift[continent][zone];
	local setNote, nearNote = MetaMapNotes_AddNewNote(continent, zone, xPos, yPos, name, inf1, inf2, creator, icon, ncol, in1c, in2c, MetaMapNotes_SetNextAsMiniNote);
	if(who == nil) then
		if(setNote) then
			MetaMap_StatusPrint(format(METAMAPNOTES_ACCEPT_NOTE, MetaMap_ZoneNames[continent][zone]), true);
		else
			MetaMap_StatusPrint(format(METAMAPNOTES_DECLINE_NOTE, MetaMapNotes_Data[continent][zone][nearNote].name, MetaMap_ZoneNames[continent][zone]), true);
		end
	else
		if(setNote) then
			MetaMap_StatusPrint(format(METAMAPNOTES_ACCEPT_GET, who, MetaMap_ZoneNames[continent][zone]), true);
		else
			MetaMap_StatusPrint(format(METAMAPNOTES_DECLINE_GET, who, MetaMap_ZoneNames[continent][zone], MetaMapNotes_Data[continent][zone][nearNote].name), true);
		end
	end
	return setNote;
end

function MetaMapNotes_Quicknote(msg)
	local currentZone;
	local continent, zone = MetaMap_NameToZoneID(GetRealZoneText())
	if(type(continent) == "string") then
		SetMapToCurrentZone();
		tx, ty = GetPlayerMapPosition("player");
		if(tx == 0 or tx == nil) then
			MetaMap_StatusPrint(METAMAPNOTES_INVALIDZONE, true);
			return;
		end
		currentZone = MetaMapNotes_Data[continent];
	else
		currentZone = MetaMapNotes_Data[continent][zone];
	end
	local name = METAMAPNOTES_QUICKNOTE_DEFAULTNAME;
	if(msg ~= "" and msg ~= nil) then
		if(strlen(msg) == 1) then
			mode = tonumber(strsub(msg, 1, 1));
			msg = "";
		else
			local mCheck = strsub(msg, 1, 2);
			if(mCheck == "1 " or mCheck == "2 " or mCheck == "3 ") then
				mode = tonumber(strsub(msg, 1, 1));
				msg = strsub(msg, 3);
			else
				mode = MetaMapNotes_SetNextAsMiniNote;
			end
		end
	else
		mode = MetaMapNotes_SetNextAsMiniNote;
	end
	local i,j,x,y,tmp = string.find(msg,"%s*(%d+)%s*[,.]%s*(%d+)%s*([^%c]*)");
	if(x == nil or y == nil) then
		SetMapToCurrentZone();
		x, y = GetPlayerMapPosition("player");
	else
		x = x / 100;
		y = y / 100;
		msg = tmp;
	end
	if(mode == 3) then
		MetaMapNotes_vnote_xPos = x;
		MetaMapNotes_vnote_yPos = y;
		MetaMap_StatusPrint(METAMAPNOTES_VNOTE_SET, true);
		return;
	end
	if msg ~= "" and msg ~= nil then
		name = string.sub(msg,string.find(msg,"%s*([^%c]*)"));
	end
	local checkNote, nearNote = MetaMapNotes_AddNewNote(continent, zone, x, y, name, "", "", UnitName("player"), 0, 0, 0, 0, mode);
	if(checkNote) then
		if(mode ~= 2) then
			MetaMap_StatusPrint(format(METAMAPNOTES_ACCEPT_NOTE, GetRealZoneText()), true);
		end
	else
		MetaMap_StatusPrint(format(METAMAPNOTES_DECLINE_NOTE, currentZone[nearNote].name, GetRealZoneText()), true);
	end
	if(mode > 0) then
		MetaMap_StatusPrint(format(METAMAPNOTES_ACCEPT_MININOTE, GetRealZoneText()), true);
	end
	MetaMapNotes_Qnote = false;
end

function MetaMapNotes_QuickNoteShow()
	local x, y = GetPlayerMapPosition("player");
	x = MetaMap_round(x*100);
	y = MetaMap_round(y*100);
	Coords_EditBox:SetText(x..","..y);
	MiniNote_CheckButton:SetChecked(false);
	MetaMapNotes_Qnote = true;
end

function MetaMapNotes_SetQuickNote(mode)
	local msg;
	if(mode == 1) then
		msg = Coords_EditBox:GetText().." "..Note_EditBox:GetText();
	else
		msg = "3 "..Coords_EditBox:GetText();
	end
	MetaMapNotes_Quicknote(msg);
end

function MetaMapNotes_GetNoteFromChat(msg, who)
	if(not MetaMapOptions.AcceptIncoming) then
		MetaMap_StatusPrint(format(METAMAPNOTES_DISABLED_GET, who), true)
		return;
	end
	if(gsub(msg,".*<MapN+>%s+%w+.*p<([^>]*)>.*","%1",1) == "1") then -- Party Note
		local id = -1;
		local continent = gsub(msg,".*<MapN+> c<([^>]*)>.*","%1",1)+0;
		local zone = gsub(msg,".*<MapN+>%s+%w+.*z<([^>]*)>.*","%1",1)+0;
		local xPos = gsub(msg,".*<MapN+>%s+%w+.*x<([^>]*)>.*","%1",1)+0;
		local yPos = gsub(msg,".*<MapN+>%s+%w+.*y<([^>]*)>.*","%1",1)+0;
		local icon = "party";
		zone = MetaMapNotes_ZoneShift[continent][zone];
		MetaMapNotes_PartyNoteData.continent = continent;
		MetaMapNotes_PartyNoteData.zone = zone;
		MetaMapNotes_PartyNoteData.xPos = xPos;
		MetaMapNotes_PartyNoteData.yPos = yPos;
		if(MetaMapOptions.MiniParty) then
			MetaMapNotes_SetMiniNote(id, continent, zone, xPos, yPos, name, inf1, inf2, creator, icon, ncol, in1c, in2c);
			MetaMap_StatusPrint(format(METAMAPNOTES_PARTY_GET, who, MetaMap_ZoneNames[continent][zone]), true)
		end
	else
		MetaMapNotes_GetSendString(msg, who);
	end
end

function MetaMapNotes_GetNoteBySlashCommand(msg)
	if msg ~= "" and msg ~= nil then
		msg = "<MapN> "..msg;
		return MetaMapNotes_GetSendString(msg);
	else
		MetaMap_StatusPrint(METAMAPNOTES_MAPNOTEHELP, true);
		return false;
	end
end

function MetaMapNotes_Misc_OnClick(button)
	if(not MetaMapNotes_FramesHidden()) then return; end
	if button == "LeftButton" then
		if(this:GetID() == 0) then
			MetaMapNotes_TempData_Id = 0;
			MetaMapNotes_OpenEditForExistingNote(MetaMapNotes_TempData_Id);
		elseif(this:GetID() == 1) then
			MetaMapNotes_PartyNoteSet = true;
			MetaMapNotes_TempData_Id = -1;
			MetaMapNotes_ShowSendFrame(1);
		end
	end
end

function MetaMapNotes_NextMiniNote(msg)
	msg = string.lower(msg)
	if msg == "on" then
		MetaMapNotes_SetNextAsMiniNote = 1
	elseif msg == "off" then
		MetaMapNotes_SetNextAsMiniNote = 0
	elseif MetaMapNotes_SetNextAsMiniNote == 1 then
		MetaMapNotes_SetNextAsMiniNote = 0
	else
		MetaMapNotes_SetNextAsMiniNote = 1
	end
end

function MetaMapNotes_NextMiniNoteOnly(msg)
	msg = string.lower(msg)
	if msg == "on" then
		MetaMapNotes_SetNextAsMiniNote = 2
	elseif msg == "off" then
		MetaMapNotes_SetNextAsMiniNote = 0
	elseif MetaMapNotes_SetNextAsMiniNote == 2 then
		MetaMapNotes_SetNextAsMiniNote = 0
	else
		MetaMapNotes_SetNextAsMiniNote = 2
	end
end

function MetaMapNotes_MinimapUpdateZoom()
	if MetaMapNotes_MiniNote_MapzoomInit then
		if MetaMapNotes_MiniNote_IsInCity then
			MetaMapNotes_MiniNote_IsInCity = false
		else
			MetaMapNotes_MiniNote_IsInCity = true
		end
	else
		local tempzoom = 0
		if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
			if GetCVar("minimapInsideZoom")+0 >= 3 then
				Minimap:SetZoom(Minimap:GetZoom() - 1)
				tempzoom = 1
			else
				Minimap:SetZoom(Minimap:GetZoom() + 1)
				tempzoom = -1
			end
		end

		if GetCVar("minimapInsideZoom")+0 == Minimap:GetZoom() then
			MetaMapNotes_MiniNote_IsInCity = true
		else
			MetaMapNotes_MiniNote_IsInCity = false
		end

		Minimap:SetZoom(Minimap:GetZoom() + tempzoom)
		MetaMapNotes_MiniNote_MapzoomInit = true
	end
end

function MetaMapNotes_MiniNote_OnUpdate(delay)
	if(MetaMapNotes_MiniNote_Data.xPos == nil or GetRealZoneText() ~= MetaMapNotes_MiniNote_Data.zonetext) then
		MiniNotePOI:Hide();
		return;
	end
	local continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
	MiniNotePOI.TimeSinceLastUpdate = MiniNotePOI.TimeSinceLastUpdate + delay;
	if MiniNotePOI.TimeSinceLastUpdate >= MetaMapNotes_Mininote_UpdateRate then
		local x, y = GetPlayerMapPosition("player");
		if x == 0 and y == 0 then
			MiniNotePOI:Hide()
			return
		end
		local currentConst
		if(type(continent) == "string") then
			currentConst = MetaMapNotes_Const[continent]
		elseif continent > 0 and MetaMapNotes_MiniNote_Data.continent > 0 then
			local c = MetaMapNotes_MiniNote_Data.continent
			local z = MetaMapNotes_MiniNote_Data.zone
			currentConst = MetaMapNotes_Const[c][z]
		else
			MiniNotePOI:Hide();
			return;
		end
		local currentZoom = Minimap:GetZoom()
		if currentConst and x ~= 0 and y ~= 0 and currentConst.scale ~= 0 then
			local xscale,yscale
			if zone > 0 then
				xscale = MetaMapNotes_Const[MetaMapNotes_MiniNote_Data.continent][currentZoom].xscale
				yscale = MetaMapNotes_Const[MetaMapNotes_MiniNote_Data.continent][currentZoom].yscale
			else
				xscale = MetaMapNotes_Const[2][currentZoom].xscale
				yscale = MetaMapNotes_Const[2][currentZoom].yscale
			end

			if MetaMapNotes_MiniNote_IsInCity then
				xscale = xscale * MetaMapNotes_Const[2][currentZoom].cityscale
				yscale = yscale * MetaMapNotes_Const[2][currentZoom].cityscale
			end
			local xpos = MetaMapNotes_MiniNote_Data.xPos * currentConst.scale + currentConst.xoffset
			local ypos = MetaMapNotes_MiniNote_Data.yPos * currentConst.scale + currentConst.yoffset
			x = x * currentConst.scale + currentConst.xoffset
			y = y * currentConst.scale + currentConst.yoffset
			local deltax = (xpos - x) * xscale
			local deltay = (ypos - y) * yscale
			if sqrt( (deltax * deltax) + (deltay * deltay) ) > 56.5 then
				local adjust = 1
				if deltax == 0 then
					deltax = deltax + 0.0000000001
				elseif deltax < 0 then
					adjust = -1
				end
				local m = math.atan(deltay / deltax)
				deltax = math.cos(m) * 57 * adjust
				deltay = math.sin(m) * 57 * adjust
			end
			MiniNotePOI:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 105 + deltax, -93 - deltay)
			MiniNotePOI:Show()
		else
			MiniNotePOI:Hide()
		end
	end
	MiniNotePOI.TimeSinceLastUpdate = 0
end

function MetaMapNotes_MiniNote_OnClick(arg1)
	if(arg1 == "LeftButton" and IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
		local x = MetaMap_round(MetaMapNotes_MiniNote_Data.xPos *100);
		local y = MetaMap_round(MetaMapNotes_MiniNote_Data.yPos *100);
		local msg = MetaMapNotes_MiniNote_Data.name.." ("..GetRealZoneText().." - "..x..","..y..")";
		ChatFrameEditBox:Insert(msg);
	else
		if(MetaMapNotes_MiniNote_Data.id > 0) then
			SetMapToCurrentZone();
			if(not WorldMapFrame:IsVisible()) then
				MetaMapNotesEditFrame:SetParent("UIParent");
			end
			MetaMapNotes_OpenEditForExistingNote(MetaMapNotes_MiniNote_Data.id);
		elseif(MetaMapNotes_MiniNote_Data.id == 0) then
			MetaMapNotes_TempData_Id = 0;
			MetaMapNotes_ShowSendFrame(0);
		else
			MetaMapNotes_PartyNoteSet = true;
			MetaMapNotes_TempData_Id = -1;
			MetaMapNotes_ShowSendFrame(1);
		end
	end
end

function MetaMapNotes_ShowNewFrame(ax, ay)
	if(not MetaMapNotes_FramesHidden()) then return; end
	local width = WorldMapButton:GetWidth();
	local height = WorldMapButton:GetHeight();
	local xOffset,yOffset;
	MetaMapNotes_TempData_xPos = ax;
	MetaMapNotes_TempData_yPos = ay;
	MetaMapNotes_TempData_Id = nil;
	if ax*1002 >= (1002 - 195) then
		xOffset = ax * width - 176;
	else
		xOffset = ax * width;
	end
	if ay*668 <= (668 - 156) then
		yOffset = -(ay * height) - 75;
		else
		yOffset = -(ay * height) + 87;
	end
	MetaMapNotesButtonMiniNoteOff:Disable();
	MetaMapNotesButtonMiniNoteOn:Disable();
	MetaMapNotesButtonDeleteNote:Disable();
	MetaMapNotesButtonToggleLine:Disable();
	MetaMapNotesButtonSendNote:Disable();
	MetaMapNotesButtonMoveNote:Disable();
	MetaMapNotesEditFrameTitle:SetText(METAMAPNOTES_NEW_NOTE);
	MetaMapNotes_OpenEditForNewNote();
end

function MetaMapNotes_OpenEditForNewNote()
	if MetaMapNotes_TempData_Id == 0 then
		MetaMapNotes_vnote_xPos = nil
		MetaMapNotes_vnote_yPos = nil
	end
	MetaMapNotes_TempData_Id = MetaMapNotes_NewNoteSlot()
	MetaMapNotes_TempData_Creator = UnitName("player")
	MetaMapNotes_Edit_SetIcon(0)
	MetaMapNotes_Edit_SetTextColor(0)
	MetaMapNotes_Edit_SetInfo1Color(0)
	MetaMapNotes_Edit_SetInfo2Color(0)
	TitleWideEditBox:SetText("")
	Info1WideEditBox:SetText("")
	Info2WideEditBox:SetText("")
	CreatorWideEditBox:SetText(MetaMapNotes_TempData_Creator)
	MetaMapNotes_HideAll()
	MetaMapNotesEditFrame:Show()
end

function MetaMapNotes_OpenEditForExistingNote(id)
	MetaMapNotes_HideAll();
	MetaMapNotesEditFrameTitle:SetText(METAMAPNOTES_EDIT_NOTE);
	if(MetaMapNotes_MiniNote_Data.xPos == nil) then
		MetaMapNotesButtonMiniNoteOff:Disable();
	else
		MetaMapNotesButtonMiniNoteOff:Enable();
	end
	MetaMapNotesButtonMiniNoteOn:Enable();
	MetaMapNotesButtonDeleteNote:Enable();
	MetaMapNotesButtonToggleLine:Enable();
	MetaMapNotesButtonMoveNote:Enable();

	local continent, zone, currentZone = MetaMap_GetCurrentMapInfo();
	MetaMapNotes_TempData_Id = id

	if(id == 0) then
		WorldMapTooltip:Hide();
		MetaMapNotes_ShowNewFrame(MetaMapNotes_vnote_xPos, MetaMapNotes_vnote_yPos);
		return;
	elseif(id == -1) then
		WorldMapTooltip:Hide();
		MetaMapNotes_ShowNewFrame(MetaMapNotes_PartyNoteData.xPos, MetaMapNotes_PartyNoteData.yPos);
		return;
	end
	MetaMapNotes_TempData_LootID = nil;
	if(currentZone[MetaMapNotes_TempData_Id].lootid ~= nil)then
		MetaMapNotes_TempData_LootID = currentZone[MetaMapNotes_TempData_Id].lootid
	end
	MetaMapNotes_TempData_Name = currentZone[MetaMapNotes_TempData_Id].name;
	MetaMapNotes_TempData_Creator = currentZone[MetaMapNotes_TempData_Id].creator;
	MetaMapNotes_TempData_xPos = currentZone[MetaMapNotes_TempData_Id].xPos;
	MetaMapNotes_TempData_yPos = currentZone[MetaMapNotes_TempData_Id].yPos;
	MetaMapNotes_Edit_SetIcon(currentZone[MetaMapNotes_TempData_Id].icon);
	MetaMapNotes_Edit_SetTextColor(currentZone[MetaMapNotes_TempData_Id].ncol);
	MetaMapNotes_Edit_SetInfo1Color(currentZone[MetaMapNotes_TempData_Id].in1c);
	MetaMapNotes_Edit_SetInfo2Color(currentZone[MetaMapNotes_TempData_Id].in2c);
	TitleWideEditBox:SetText(currentZone[MetaMapNotes_TempData_Id].name);
	Info1WideEditBox:SetText(currentZone[MetaMapNotes_TempData_Id].inf1);
	Info2WideEditBox:SetText(currentZone[MetaMapNotes_TempData_Id].inf2);
	CreatorWideEditBox:SetText(currentZone[MetaMapNotes_TempData_Id].creator);
	MetaMapNotesEditFrame:Show();
end

function MetaMapNotes_ShowSendFrame(number)
	MetaMapNotesSendPlayer:Enable();
	MetaMapNotesSendParty:Enable();
	MetaMapNotesChangeSendFrame:Enable();
	SendWideEditBox:Show();
	MetaMapNotes_SendFrame_Player:Show();
	if(number == 0) then
		MetaMapNotesDeletePartyNote:Show();
		MetaMapNotes_ToggleSendValue = 2;
	elseif(number == 1) then
		if(MetaMapNotes_PartyNoteSet) then
			MetaMapNotesDeletePartyNote:Show();
			MetaMapNotesSendPlayer:Disable();
			MetaMapNotesChangeSendFrame:Disable();
			SendWideEditBox:Hide();
			MetaMapNotes_SendFrame_Player:Hide();
		end
		MetaMapNotesChangeSendFrame:SetText(METAMAPNOTES_SLASHCOMMAND);
		SendWideEditBox:SetText("");
		if(UnitCanCooperate("player", "target")) then
			SendWideEditBox:SetText(UnitName("target"));
		end
			MetaMapNotes_SendFrame_Title:SetText(METAMAPNOTES_SEND_NOTE);
			MetaMapNotes_SendFrame_Tip:SetText(METAMAPNOTES_SEND_TIP);
			MetaMapNotes_SendFrame_Player:SetText(METAMAPNOTES_SEND_PLAYER);
			MetaMapNotes_ToggleSendValue = 2;
	elseif(number == 2) then
		MetaMapNotesChangeSendFrame:SetText(METAMAPNOTES_SHOWSEND);
		SendWideEditBox:SetText("/mapnote"..MetaMapNotes_GenerateSendString(2));
		MetaMapNotes_SendFrame_Title:SetText(METAMAPNOTES_SEND_SLASHTITLE);
		MetaMapNotes_SendFrame_Tip:SetText(METAMAPNOTES_SEND_SLASHTIP);
		MetaMapNotes_SendFrame_Player:SetText(METAMAPNOTES_SEND_SLASHCOMMAND);
		MetaMapNotes_ToggleSendValue = 1;
	end
	if(not MetaMapNotesSendFrame:IsVisible()) then
		MetaMapNotes_HideAll();
		MetaMapNotesSendFrame:Show();
	end
end

function MetaMapNotes_Edit_SetIcon(icon)
	MetaMapNotes_TempData_Icon = icon;
	IconOverlay:SetPoint("TOPLEFT", "EditIcon"..icon, "TOPLEFT", -3, 3);
end

function MetaMapNotes_Edit_SetTextColor(color)
	MetaMapNotes_TempData_TextColor = color
	TextColorOverlay:SetPoint("TOPLEFT", "TextColor"..color, "TOPLEFT", -3, 3)
end

function MetaMapNotes_Edit_SetInfo1Color(color)
	MetaMapNotes_TempData_Info1Color = color
	Info1ColorOverlay:SetPoint("TOPLEFT", "Info1Color"..color, "TOPLEFT", -3, 3)
end

function MetaMapNotes_Edit_SetInfo2Color(color)
	MetaMapNotes_TempData_Info2Color = color
	Info2ColorOverlay:SetPoint("TOPLEFT", "Info2Color"..color, "TOPLEFT", -3, 3)
end

function MetaMapNotes_SendNote(type)
	if(type == 1) then
		SendChatMessage(MetaMapNotes_GenerateSendString(1), "WHISPER", this.language, SendWideEditBox:GetText())
		MetaMap_StatusPrint(format(METAMAPNOTES_NOTE_SENT, SendWideEditBox:GetText()), true);
	elseif(type == 2) then
		local name;
		if(GetNumRaidMembers() > 0 ) then
			for i=1, GetNumRaidMembers(), 1 do
				name = GetRaidRosterInfo(i);
				if(name ~= UnitName("player")) then
					SendChatMessage(MetaMapNotes_GenerateSendString(1), "WHISPER", this.language, name)
				end
			end
			MetaMap_StatusPrint(METAMAPNOTES_RAIDSENT, true);
		elseif(GetNumPartyMembers() > 0) then
			for i=1, GetNumPartyMembers(), 1 do
				name = UnitName("party"..i);
				if(name ~= UnitName("player")) then
					SendChatMessage(MetaMapNotes_GenerateSendString(1), "WHISPER", this.language, name)
				end
			end
			MetaMap_StatusPrint(METAMAPNOTES_PARTYSENT, true);
		else
			MetaMap_StatusPrint(METAMAPNOTES_NOPARTY, true);
		end
	end
	MetaMapNotes_HideAll()
end

function MetaMapNotes_ClearMiniNote(skipMapUpdate)
	MetaMapNotes_MiniNote_Data = {};
	if(MetaMapNotes_PartyNoteData ~= nil) then
		MetaMapNotes_DeleteNote(-1)
	end
	MiniNotePOI:Hide();
	MetaMapNotesButtonMiniNoteOff:Disable();
	if not skipMapUpdate then
		MetaMapNotes_MapUpdate();
	end
end

function MetaMapNotes_WriteNote()
	MetaMapNotes_HideAll();
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
	if(not currentZone) then return; end

	currentZone[MetaMapNotes_TempData_Id] = {};
	currentZone[MetaMapNotes_TempData_Id].name = TitleWideEditBox:GetText();
	currentZone[MetaMapNotes_TempData_Id].ncol = MetaMapNotes_TempData_TextColor;
	currentZone[MetaMapNotes_TempData_Id].inf1 = Info1WideEditBox:GetText();
	currentZone[MetaMapNotes_TempData_Id].in1c = MetaMapNotes_TempData_Info1Color;
	currentZone[MetaMapNotes_TempData_Id].inf2 = Info2WideEditBox:GetText();
	currentZone[MetaMapNotes_TempData_Id].in2c = MetaMapNotes_TempData_Info2Color;
	currentZone[MetaMapNotes_TempData_Id].creator = CreatorWideEditBox:GetText();
	currentZone[MetaMapNotes_TempData_Id].icon = MetaMapNotes_TempData_Icon;
	currentZone[MetaMapNotes_TempData_Id].xPos = MetaMapNotes_TempData_xPos;
	currentZone[MetaMapNotes_TempData_Id].yPos = MetaMapNotes_TempData_yPos;
	if(MetaMapNotes_TempData_LootID ~= nil)then
		currentZone[MetaMapNotes_TempData_Id].lootid = MetaMapNotes_TempData_LootID;
		MetaMapNotes_TempData_LootID = nil;
	end

	if(continent == MetaMapNotes_MiniNote_Data.continent and MetaMapNotes_MiniNote_Data.zone == zone and MetaMapNotes_MiniNote_Data.id == MetaMapNotes_TempData_Id) then
		MetaMapNotes_MiniNote_Data.zonetext = mapName;
		MetaMapNotes_MiniNote_Data.name = TitleWideEditBox:GetText();
		MetaMapNotes_MiniNote_Data.icon = MetaMapNotes_TempData_Icon;
		MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon);
		MetaMapNotes_MiniNote_Data.inf1 = Info1WideEditBox:GetText();
		MetaMapNotes_MiniNote_Data.inf2 = Info2WideEditBox:GetText();
		MetaMapNotes_MiniNote_Data.in1c = MetaMapNotes_TempData_Info1Color;
		MetaMapNotes_MiniNote_Data.in2c = MetaMapNotes_TempData_Info2Color;
		MetaMapNotes_MiniNote_Data.color = MetaMapNotes_TempData_TextColor;
		MetaMapNotes_MiniNote_Data.creator = CreatorWideEditBox:GetText();
	end

	if(MetaMapNotes_vnote_xPos == MetaMapNotes_TempData_xPos and MetaMapNotes_vnote_yPos == MetaMapNotes_TempData_yPos) then
		MetaMapNotes_vnote_xPos = nil;
		MetaMapNotes_vnote_yPos = nil;
	end
	MetaMapNotes_MapUpdate();
end

function MetaMapNotes_MapUpdate()
	if(WorldMapButton:IsVisible() or MetaMapFrame:IsVisible()) then
		MetaMapNotes_WorldMapButton_OnUpdate();
	end
	if(Minimap:IsVisible()) then
		Minimap_OnUpdate(0);
	end
end

function MetaMapNotes_HideAll()
	MetaMapNotesEditFrame:Hide()
	MetaMapNotesSendFrame:Hide()
	MetaMapNotes_QuickNoteFrame:Hide()
	MetaMapNotes_ClearGUI()
end

function MetaMapNotes_FramesHidden()
	if(MetaMapNotesEditFrame:IsVisible() or MetaMapNotesSendFrame:IsVisible()
			or  MetaMapNotes_QuickNoteFrame:IsVisible()) then
		return false;
	else
		return true;
	end
end

function MetaMapNotes_GetZoneTableSize(zoneTable)
	local i = 0;
	for id in zoneTable do
		i = i + 1;
	end
	return i;
end

function MetaMapNotes_OnEnter(id)
	if MetaMapNotes_FramesHidden() then
		local x, y = this:GetCenter()
		local x2, y2 = WorldMapButton:GetCenter()
		local anchor = ""
		if x > x2 then
			anchor = "ANCHOR_LEFT"
		else
			anchor = "ANCHOR_RIGHT"
		end
		WorldMapTooltip:SetOwner(this, anchor)
		if id	== 0 then
			WorldMapTooltip:SetText(METAMAPNOTES_VNOTE_DEFAULTNAME)
		elseif id	== -1 then
			WorldMapTooltip:SetText(METAMAPNOTES_PARTYNOTE)
		else
			local continent, zone, currentZone = MetaMap_GetCurrentMapInfo();
			if(not currentZone) then return; end
			local blt = "";
			local cNr = currentZone[id].ncol
			if(currentZone[id].lootid ~= nil and currentZone[id].lootid ~= "") then
				blt = "|cffff00ffBLT";
			end
			WorldMapTooltip:AddDoubleLine(currentZone[id].name, blt, MetaMapNotes_Colors[cNr].r, MetaMapNotes_Colors[cNr].g, MetaMapNotes_Colors[cNr].b, MetaMapOptions.TooltipWrap)
			if currentZone[id].inf1 ~= nil and currentZone[id].inf1 ~= "" then
				cNr = currentZone[id].in1c
				WorldMapTooltip:AddLine(currentZone[id].inf1, MetaMapNotes_Colors[cNr].r, MetaMapNotes_Colors[cNr].g, MetaMapNotes_Colors[cNr].b, MetaMapOptions.TooltipWrap)
			end
			if currentZone[id].inf2 ~= nil and currentZone[id].inf2 ~= "" then
				cNr = currentZone[id].in2c
				WorldMapTooltip:AddLine(currentZone[id].inf2, MetaMapNotes_Colors[cNr].r, MetaMapNotes_Colors[cNr].g, MetaMapNotes_Colors[cNr].b, MetaMapOptions.TooltipWrap)
			end
			if(currentZone[id].creator ~= nil and currentZone[id].creator ~= "" and MetaMapOptions.MetaMapShowAuthor) then
				WorldMapTooltip:AddDoubleLine(METAMAPNOTES_CREATEDBY, currentZone[id].creator, 0.79, 0.69, 0.0, 0.79, 0.69, 0.0);
			end
		end
		WorldMapTooltip:Show()
	else
		WorldMapTooltip:Hide()
	end
end

function MetaMapNotes_MiniNote_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
	if(MetaMapNotes_MiniNote_Data.id == -1) then
		GameTooltip:SetText(METAMAPNOTES_PARTYNOTE);
	else
		GameTooltip:SetText(MetaMapNotes_MiniNote_Data.name,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.color].r,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.color].g,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.color].b);

		GameTooltip:AddLine(MetaMapNotes_MiniNote_Data.inf1,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.in1c].r,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.in1c].g,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.in1c].b);

		GameTooltip:AddLine(MetaMapNotes_MiniNote_Data.inf2,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.in2c].r,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.in2c].g,
		MetaMapNotes_Colors[MetaMapNotes_MiniNote_Data.in2c].b);
		if(MetaMapNotes_MiniNote_Data.creator ~= nil and MetaMapNotes_MiniNote_Data.creator ~= "" and MetaMapOptions.MetaMapShowAuthor) then
			GameTooltip:AddDoubleLine(METAMAPNOTES_CREATEDBY, MetaMapNotes_MiniNote_Data.creator, 0.79, 0.69, 0.0, 0.79, 0.69, 0.0);
		end
	end
	GameTooltip:Show();
end

function MetaMapNotes_Note_OnClick(button, id)
	if(not MetaMapNotes_FramesHidden()) then return; end
	local continent, zone, currentZone = MetaMap_GetCurrentMapInfo();
	if(not currentZone) then return; end

	if MetaMapNotes_LastLineClick.GUIactive then
		id = id + 0
		local ax = currentZone[id].xPos
		local ay = currentZone[id].yPos
		if (MetaMapNotes_LastLineClick.x ~= ax or MetaMapNotes_LastLineClick.y ~= ay) and MetaMapNotes_LastLineClick.continent == continent and MetaMapNotes_LastLineClick.zone == zone then
			MetaMapNotes_ToggleLine(continent, zone, ax, ay, MetaMapNotes_LastLineClick.x, MetaMapNotes_LastLineClick.y)
		end
			MetaMapNotes_ClearGUI()
	elseif(button == "LeftButton" and IsShiftKeyDown()) then
		if (ChatFrameEditBox:IsVisible()) then
			local mode = 1;
			if(MetaMapFrame:IsVisible()) then mode = 2; end
			local tname = currentZone[id].name;
			local tinf1 = currentZone[id].inf1;
			local x = MetaMap_round(currentZone[id].xPos *100);
			local y = MetaMap_round(currentZone[id].yPos *100);
			local tzone = MetaMap_ZoneNames[continent][zone];
			if(strlen(tinf1) > 0) then tinf1 = " ["..tinf1.."] "; end
			local msg = tname.." "..tinf1.." ("..tzone.." - "..x..","..y..")";
			ChatFrameEditBox:Insert(msg);
		end
	elseif(button == "LeftButton" and IsControlKeyDown()) then
		local LootID = MetaMapNotes_Data[continent][zone][id].lootid;
		local Name = MetaMapNotes_Data[continent][zone][id].name;
		MetaMap_LoadBLT(LootID, Name);
	elseif(button == "LeftButton" and currentZone[id].icon ~= 10) then
		local width = WorldMapButton:GetWidth()
		local height = WorldMapButton:GetHeight()
		id = id + 0
		MetaMapNotes_TempData_Id = id
		local ax = currentZone[id].xPos
		local ay = currentZone[id].yPos
		if ax*1002 >= (1002 - 195) then
			xOffset = ax * width - 176
		else
			xOffset = ax * width
		end
		if ay*668 <= (668 - 156) then
			yOffset = -(ay * height) - 75
		else
			yOffset = -(ay * height) + 113
		end
		MetaMapNotesButtonSendNote:Enable()
		WorldMapTooltip:Hide()
		MetaMapNotes_OpenEditForExistingNote(MetaMapNotes_TempData_Id)
	elseif(button == "RightButton") then
		if(IsControlKeyDown()) then
			MetaMapNotes_CRBSelect(id);
		elseif(IsShiftKeyDown()) then
			MetaMapNotes_SRBSelect(id);
		else
			MetaMap_LoadBWP(this:GetID(), 2);
		end
	end
end

function MetaMapNotes_StartGUIToggleLine()
	MetaMapNotes_HideAll()
	MetaMapText_NoteTotals:SetText("|cffffffff"..METAMAPNOTES_CLICK_ON_SECOND_NOTE)
	MetaMapNotes_LastLineClick.GUIactive = true
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();

	MetaMapNotes_LastLineClick.x = MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].xPos
	MetaMapNotes_LastLineClick.y = MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].yPos
	MetaMapNotes_LastLineClick.zone = zone
	MetaMapNotes_LastLineClick.continent = continent
end

function MetaMapNotes_StartMoveNote(ID)
	MetaMapNotes_HideAll()
	MetaMapText_NoteTotals:SetText("|cffffffff"..METAMAPNOTES_CLICK_ON_LOCATION);
	local continent, zone, currentZone = MetaMap_GetCurrentMapInfo();
	MetaMapNotes_Relocate.continent = continent;
	MetaMapNotes_Relocate.zone = zone;
	MetaMapNotes_Relocate.id = ID;
end

function MetaMapNotes_MoveNote(continent, zone, id)
	local zoneTable = MetaMapNotes_Lines[continent][zone]
	local lineCount = MetaMapNotes_GetZoneTableSize(zoneTable)
	local currentX = MetaMapNotes_Data[continent][zone][id].xPos;
	local currentY = MetaMapNotes_Data[continent][zone][id].yPos;
	local centerX, centerY = WorldMapButton:GetCenter();
	local width = WorldMapButton:GetWidth();
	local height = WorldMapButton:GetHeight();
	local x, y = GetCursorPosition();
	x = x / WorldMapButton:GetEffectiveScale();
	y = y / WorldMapButton:GetEffectiveScale();
	local adjustedY = (centerY + height/2 - y) / height;
	local adjustedX = (x - (centerX - width/2)) / width;
	MetaMapNotes_Data[continent][zone][id].xPos = adjustedX;
	MetaMapNotes_Data[continent][zone][id].yPos = adjustedY;
	if(MetaMapNotes_MiniNote_Data.id == id) then
		MetaMapNotes_MiniNote_Data.xPos = adjustedX;
		MetaMapNotes_MiniNote_Data.yPos = adjustedY;
	end
	for i = 1, lineCount, 1 do
		if i <= lineCount then
			if(zoneTable[i].x1 == currentX and zoneTable[i].y1 == currentY) then
				zoneTable[i].x1 = adjustedX;
				zoneTable[i].y1 = adjustedY;
			elseif(zoneTable[i].x2 == currentX and zoneTable[i].y2 == currentY) then
				zoneTable[i].x2 = adjustedX;
				zoneTable[i].y2 = adjustedY;
			end
		end
	end
	MetaMapNotes_MapUpdate();
end

function MetaMapNotes_ClearGUI()
	MetaMapNotes_LastLineClick.GUIactive = false;
	MetaMapNotes_Relocate = {};
end

function MetaMapNotes_DrawLine(id, x1, y1, x2, y2)
	assert(x1 and y1 and x2 and y2)
	local MetaMapNotesLine = MetaMap_CreateLineObject(id);
	local positiveSlopeTexture = METAMAP_IMAGE_PATH.."LineTemplatePositive256"
	local negativeSlopeTexture = METAMAP_IMAGE_PATH.."LineTemplateNegative256"
	local width = WorldMapDetailFrame:GetWidth()
	local height = WorldMapDetailFrame:GetHeight()
	local deltax = math.abs((x1 - x2) * width)
	local deltay = math.abs((y1 - y2) * height)
	local xOffset = math.min(x1,x2) * width
	local yOffset = -(math.min(y1,y2) * height)
	local lowerpixel = math.min(deltax, deltay)
	lowerpixel = lowerpixel / 256
	if lowerpixel > 1 then
		lowerpixel = 1
	end
	if deltax == 0 then
		deltax = 2
		MetaMapNotesLine:SetTexture(0, 0, 0)
		MetaMapNotesLine:SetTexCoord(0, 1, 0, 1)
	elseif deltay == 0 then
		deltay = 2
		MetaMapNotesLine:SetTexture(0, 0, 0)
		MetaMapNotesLine:SetTexCoord(0, 1, 0, 1)
	elseif x1 - x2 < 0 then
		if y1 - y2 < 0 then
			MetaMapNotesLine:SetTexture(negativeSlopeTexture)
			MetaMapNotesLine:SetTexCoord(0, lowerpixel, 0, lowerpixel)
		else
			MetaMapNotesLine:SetTexture(positiveSlopeTexture)
			MetaMapNotesLine:SetTexCoord(0, lowerpixel, 1-lowerpixel, 1)
		end
	else
		if y1 - y2 < 0 then
			MetaMapNotesLine:SetTexture(positiveSlopeTexture)
			MetaMapNotesLine:SetTexCoord(0, lowerpixel, 1-lowerpixel, 1)
		else
			MetaMapNotesLine:SetTexture(negativeSlopeTexture)
			MetaMapNotesLine:SetTexCoord(0, lowerpixel, 0, lowerpixel)
		end
	end

	if(MetaMapFrame:IsVisible()) then
		MetaMapNotesLine:SetPoint("TOPLEFT", "MetaMapFrame", "TOPLEFT", xOffset, yOffset)
	else
		MetaMapNotesLine:SetPoint("TOPLEFT", "WorldMapDetailFrame", "TOPLEFT", xOffset, yOffset)
	end
	MetaMapNotesLine:SetWidth(deltax)
	MetaMapNotesLine:SetHeight(deltay)
	MetaMapNotesLine:Show()
end

function MetaMapNotes_DeleteLines(continent, zone, x, y)
	local zoneTable = MetaMapNotes_Lines[continent][zone]
	local lineCount = MetaMapNotes_GetZoneTableSize(zoneTable)
	local offset = 0

	for i = 1, lineCount, 1 do
		if (zoneTable[i-offset].x1 == x and zoneTable[i-offset].y1 == y) or (zoneTable[i-offset].x2 == x and zoneTable[i-offset].y2 == y) then
			for j = i, lineCount-1, 1 do
				zoneTable[j-offset].x1 = zoneTable[j+1-offset].x1
				zoneTable[j-offset].x2 = zoneTable[j+1-offset].x2
				zoneTable[j-offset].y1 = zoneTable[j+1-offset].y1
				zoneTable[j-offset].y2 = zoneTable[j+1-offset].y2
			end
			zoneTable[lineCount-offset] = nil
			offset = offset + 1
		end
	end
	MetaMapNotes_LastLineClick.zone = 0
end

function MetaMapNotes_ToggleLine(continent, zone, x1, y1, x2, y2)
	local zoneTable = MetaMapNotes_Lines[continent][zone]
	local newline = true
	local lineCount = MetaMapNotes_GetZoneTableSize(zoneTable)

	for i = 1, lineCount, 1 do
		if i <= lineCount then
			if (zoneTable[i].x1 == x1 and zoneTable[i].y1 == y1 and
					zoneTable[i].x2 == x2 and zoneTable[i].y2 == y2) or
					(zoneTable[i].x1 == x2 and zoneTable[i].y1 == y2 and
					zoneTable[i].x2 == x1 and zoneTable[i].y2 == y1) then
				for j = i, lineCount-1, 1 do
					zoneTable[j].x1 = zoneTable[j+1].x1
					zoneTable[j].x2 = zoneTable[j+1].x2
					zoneTable[j].y1 = zoneTable[j+1].y1
					zoneTable[j].y2 = zoneTable[j+1].y2
				end
				zoneTable[lineCount] = nil
				PlaySound("igMainMenuOption")
				newline = false
				lineCount = lineCount - 1
			end
		end
	end
	if(newline) then
		zoneTable[lineCount+1] = {}
		zoneTable[lineCount+1].x1 = x1
		zoneTable[lineCount+1].x2 = x2
		zoneTable[lineCount+1].y1 = y1
		zoneTable[lineCount+1].y2 = y2
	end
	MetaMapNotes_LastLineClick.zone = 0
	MetaMapNotes_MapUpdate()
end

function MetaMapNotes_NewNoteSlot()
	local continent, zone, currentZone = MetaMap_GetCurrentMapInfo();
	if(not currentZone) then return 1; end
	return MetaMapNotes_GetZoneTableSize(currentZone) + 1
end

function MetaMapNotes_SetPartyNote(xPos, yPos)
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
	xPos = floor(xPos * 1000000) / 1000000
	yPos = floor(yPos * 1000000) / 1000000
	MetaMapNotes_PartyNoteData.continent = continent
	MetaMapNotes_PartyNoteData.zone = zone
	MetaMapNotes_PartyNoteData.xPos = xPos
	MetaMapNotes_PartyNoteData.yPos = yPos
	if MetaMapNotes_MiniNote_Data.icon == "party" or MetaMapOptions.MiniParty then
		MetaMapNotes_MiniNote_Data.zonetext = mapName;
		MetaMapNotes_MiniNote_Data.id = -1;
		MetaMapNotes_MiniNote_Data.continent = continent;
		MetaMapNotes_MiniNote_Data.zone = zone;
		MetaMapNotes_MiniNote_Data.xPos = xPos;
		MetaMapNotes_MiniNote_Data.yPos = yPos;
		MetaMapNotes_MiniNote_Data.name = METAMAPNOTES_PARTYNOTE;
		MetaMapNotes_MiniNote_Data.color = 0;
		MetaMapNotes_MiniNote_Data.icon = "party"
		MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon)
		MiniNotePOI:Show()
	end
	MetaMapNotes_MapUpdate()
end

function MetaMapNotes_WorldMapButton_OnClick(...)
	if(not MetaMapNotes_FramesHidden()) then return; end
	local mouseButton, button = unpack(arg)
	local continent, zone = MetaMap_GetCurrentMapInfo();

	if(MetaMapNotes_Relocate.id ~= nil and zone > 0) then
		if(mouseButton == "LeftButton" and not IsControlKeyDown() and not IsShiftKeyDown()) then
			MetaMapNotes_MoveNote(MetaMapNotes_Relocate.continent, MetaMapNotes_Relocate.zone, MetaMapNotes_Relocate.id)
			MetaMapNotes_Relocate = {};
			return;
		end
	end

	if(MetaMapFrame:IsVisible() and mouseButton == "RightButton") then
		MetaMap_Toggle(false);
		return;
	elseif mouseButton == "RightButton" or (mouseButton == "LeftButton" and not IsControlKeyDown() and not IsShiftKeyDown()) then
		if(MetaMapFrame:IsVisible() and mouseButton == "LeftButton") then
			return;
		end
		MetaMap_OrigWorldMapButton_OnClick(unpack(arg));
		return;
	else
		if(MetaMapOptions.UseMapMod and not MetaMapFrame:IsVisible() and IsControlKeyDown()) then
			MetaMap_OrigWorldMapButton_OnClick(unpack(arg));
			return;
		end
	end

	if(continent == -1 or zone ~= 0 or MetaMapFrame:IsVisible()) then
		if not button then
			button = this
		end
		local centerX, centerY = button:GetCenter()
		local width = button:GetWidth()
		local height = button:GetHeight()
		local x, y = GetCursorPosition()
		x = x / button:GetEffectiveScale()
		y = y / button:GetEffectiveScale()
		local adjustedY = (centerY + height/2 - y) / height
		local adjustedX = (x - (centerX - width/2)) / width

		if(IsShiftKeyDown()) then
			MetaMapNotes_SetPartyNote(adjustedX, adjustedY);
		elseif(IsControlKeyDown()) then
			MetaMapNotes_ShowNewFrame(adjustedX, adjustedY);
		end
	end
end

function MetaMapNotes_WorldMapButton_OnUpdate(...)
	if(MetaMapNotes_Drawing) then
		return;
	end
	local lastNote = 0;
	local lastLine = 0;
	local showLine = true;
	local xOffset,yOffset = 0;
	local currentLineZone;
	local continent, zone, currentZone = MetaMap_GetCurrentMapInfo();
	MetaMapNotes_Drawing = true;

	if(currentZone) then
		if(continent ==-1) then
			currentLineZone = MetaMapNotes_Lines[GetRealZoneText];
		else
			currentLineZone = MetaMapNotes_Lines[continent][zone];
		end
		if(currentLineZone) then
			for i,line in currentLineZone do
				MetaMapNotes_DrawLine(i, line.x1, line.y1, line.x2, line.y2)
				lastLine = i;
			end
		end
		for i, value in currentZone do
			local temp = MetaMap_CreateNoteObject(i);
			local xPos = currentZone[i].xPos;
			local yPos = currentZone[i].yPos;
			local xOffset = xPos * WorldMapButton:GetWidth();
			local yOffset = -yPos * WorldMapButton:GetHeight();
			if(MetaMapFrame:IsVisible()) then
				temp:SetParent("MetaMapFrame");
				temp:SetPoint("CENTER", "MetaMapFrame", "TOPLEFT", xOffset, yOffset)
			else
				temp:SetParent("WorldMapButton");
				temp:SetPoint("CENTER", "WorldMapButton", "TOPLEFT", xOffset, yOffset)
			end
			getglobal("MetaMapNotesPOI"..i.."Texture"):SetTexture(METAMAP_ICON_PATH.."Icon"..currentZone[i].icon)
			getglobal("MetaMapNotesPOI"..i.."Highlight"):Hide();
			for landmarkIndex = 1, GetNumMapLandmarks(), 1 do
				local worldMapPOI = getglobal("WorldMapFramePOI"..landmarkIndex);
				if(worldMapPOI == nil) then break; end
				local metaMapPOI = getglobal("MetaMapNotesPOI"..i);
				local name, unknown, textureIndex, x, y = GetMapLandmarkInfo(landmarkIndex);
				local xPosmin = xPos - 2; local xPosmax = xPos + 2;
				local yPosmin = yPos - 2; local yPosmax = yPos + 2;
				if((x > xPosmin and x < xPosmax) and (y > yPosmin and y < yPosmax)) then
					metaMapPOI:SetFrameLevel(worldMapPOI:GetFrameLevel() +1);
				end
			end
			if(currentZone[i].icon == 10) then
				if(currentZone[i].name == MetaMap_FilterName) then
					temp:Hide();
					showLine = false;
				else
					temp:Show();
				end
			elseif(MetaMap_NoteFilter[currentZone[i].icon]) then
				temp:Show();
			else
				MetaMap_FilterName = currentZone[i].name;
				temp:Hide();
				showLine = false;
			end
			if(not showLine) then
				for line = 1, lastLine, 1 do
					if(currentLineZone[line].x1 == xPos and currentLineZone[line].y1 == yPos) then
						getglobal("MetaMapNotesLines_"..line):Hide();
					elseif(currentLineZone[line].x2 == xPos and currentLineZone[line].y2 == yPos) then
						getglobal("MetaMapNotesLines_"..line):Hide();
					end
				end
			end
			lastNote = i;
			showLine = true;
		end
		if(MetaMapOptions.LastHighlight and lastNote ~= 0 and currentZone[lastNote].icon ~= 10) then
			if getglobal("MetaMapNotesPOI"..lastNote):IsVisible() then
				getglobal("MetaMapNotesPOI"..lastNote.."Highlight"):SetTexture(METAMAP_ICON_PATH.."IconGlowRed")
				getglobal("MetaMapNotesPOI"..lastNote.."Highlight"):Show();
			end
		end
		if(MetaMapOptions.LastMiniHighlight and MetaMapNotes_MiniNote_Data.continent == continent and
			MetaMapNotes_MiniNote_Data.zone == zone and MetaMapNotes_MiniNote_Data.id > 0) then
			getglobal("MetaMapNotesPOI"..MetaMapNotes_MiniNote_Data.id.."Highlight"):SetTexture(METAMAP_ICON_PATH.."IconGlowBlue")
			getglobal("MetaMapNotesPOI"..MetaMapNotes_MiniNote_Data.id.."Highlight"):Show();
		end
		for i=lastNote+1, MetaMapNotes_LastNote, 1 do
			getglobal("MetaMapNotesPOI"..i):Hide()
		end
		for i=lastLine+1, MetaMapNotes_LastLine, 1 do
			getglobal("MetaMapNotesLines_"..i):Hide()
		end
	else
		for i=1, MetaMapNotes_LastNote, 1 do
			getglobal("MetaMapNotesPOI"..i):Hide();
		end

		for i=1, MetaMapNotes_LastLine, 1 do
			getglobal("MetaMapNotesLines_"..i):Hide();
		end
	end

	if currentZone then
		-- vNote button
		if MetaMapNotes_vnote_xPos ~= nil and zone ~= 0 then
			xOffset = MetaMapNotes_vnote_xPos * WorldMapButton:GetWidth();
			yOffset = -MetaMapNotes_vnote_yPos * WorldMapButton:GetHeight();
			if(MetaMapFrame:IsVisible()) then
				MetaMapNotesPOIvNote:SetPoint("CENTER", "MetaMapFrame", "TOPLEFT", xOffset, yOffset)
			else
				MetaMapNotesPOIvNote:SetPoint("CENTER", "WorldMapButton", "TOPLEFT", xOffset, yOffset)
			end
			MetaMapNotesPOIvNote:Show()
		else
			MetaMapNotesPOIvNote:Hide()
		end

	-- party note
		if MetaMapNotes_PartyNoteData.xPos ~= nil and zone == MetaMapNotes_PartyNoteData.zone and
				continent == MetaMapNotes_PartyNoteData.continent then
			if MetaMapOptions.LastMiniHighlight and MetaMapNotes_MiniNote_Data.icon == "party" then
				MetaMapNotesPOIpartyTexture:SetTexture(METAMAP_ICON_PATH.."Iconpartyblue")
			else
				MetaMapNotesPOIpartyTexture:SetTexture(METAMAP_ICON_PATH.."Iconparty")
			end
			xOffset = MetaMapNotes_PartyNoteData.xPos * WorldMapButton:GetWidth();
			yOffset = -MetaMapNotes_PartyNoteData.yPos * WorldMapButton:GetHeight();
			if(MetaMapFrame:IsVisible()) then
				MetaMapNotesPOIparty:SetParent("MetaMapFrame");
				MetaMapNotesPOIparty:SetPoint("CENTER", "MetaMapFrame", "TOPLEFT", xOffset, yOffset)
			else
				MetaMapNotesPOIparty:SetParent("WorldMapButton");
				MetaMapNotesPOIparty:SetPoint("CENTER", "WorldMapButton", "TOPLEFT", xOffset, yOffset)
			end
			MetaMapNotesPOIparty:Show()
		else
			MetaMapNotesPOIparty:Hide()
		end
	end
	MetaMapNotes_Drawing = nil
	MetaMapText_NoteTotals:SetText("|cff00ff00"..METAMAP_NOTES_SHOWN..": ".."|cffffffff"..(lastNote).."  ".."|cff00ff00"..METAMAP_LINES_SHOWN..": ".."|cffffffff"..(lastLine));

	if(MetaMapOptions.UseMapMod and IsAddOnLoaded("CT_MapMod")) then
		if(MetaMapFrame:IsVisible()) then
			CT_NumNotes:Hide();
			MetaMapText_NoteTotals:Show();
		else
			CT_NumNotes:Show();
			MetaMapText_NoteTotals:Hide();
		end
	else
		if(IsAddOnLoaded("CT_MapMod")) then
			CT_NumNotes:Hide();
		end
		MetaMapText_NoteTotals:Show();
	end
	MetaMapList_Init();
	MetaMap_FilterName = "";
end

function MetaMap_DeleteNotesListInit()
	local Temp_List = {};
	for continent, continentTable in MetaMapNotes_Data do
		for zone, zoneTable in continentTable do
			for index, indexTable in zoneTable do
				local currentZone = MetaMapNotes_Data[continent][zone][index];
				if(Temp_List[currentZone.creator] == nil) then
					Temp_List[currentZone.creator] = currentZone.creator;
				end
			end
		end
	end
	for index, creators in Temp_List do
		local uText;
		if(Temp_List[index] == "") then
			uText = "Unsigned";
		else
			uText = Temp_List[index];
		end
		local info = {
		checked = nil;
		notCheckable = 1;
		text = uText;
		func = MetaMap_DeleteNotesList_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
	UIDropDownMenu_JustifyText("LEFT", MetaMap_DeleteNotesList)
	UIDropDownMenu_SetText("[Click for Creator]", MetaMap_DeleteNotesList)
end

function MetaMap_DeleteNotesList_OnClick()
	local creator = this:GetText();
	if(creator == "Unsigned") then
		cFlag = "";
	else
		cFlag = creator;
	end	
	UIDropDownMenu_SetSelectedName(MetaMap_DeleteNotesList, this:GetText());
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
	StaticPopupDialogs["Delete_Notes"] = {
		text = TEXT(format(METAMAPNOTES_BATCHDELETE, mapName, creator)),
		button1 = TEXT(ACCEPT),
		button2 = TEXT(DECLINE),
		OnAccept = function()
			MetaMap_DeleteNotes(cFlag, nil, mapName);
		end,
		timeout = 60,
		showAlert = 1,
	};
	StaticPopup_Show("Delete_Notes");
end

function MetaMap_DeleteNotes(creator, name, zoneName)
	if(zoneName == nil or zoneName == "World") then
		assert(creator ~= nil, "ERROR: nil creator passed to DeleteNotesByCreatorAndName!");
		for continent, continentTable in MetaMapNotes_Data do
			for zone, zoneTable in continentTable do
				for id=MetaMapNotes_GetZoneTableSize(zoneTable), 1, -1 do
					if(zoneTable[id] ~= nil and creator == zoneTable[id].creator and (name == zoneTable[id].name or name == nil)) then
						MetaMapNotes_DeleteNote(id, continent, zone)
					end
				end
			end
		end
	else
		local continent, setZone = MetaMap_NameToZoneID(zoneName, 1);
		if(zoneName == "Kalimdor") then
			continent = 1;
		elseif(zoneName == "Eastern Kingdoms") then
			continent = 2;
		end
		for zone, zoneTable in MetaMapNotes_Data[continent] do
			for id=MetaMapNotes_GetZoneTableSize(zoneTable), 1, -1 do
				if(setZone == 0 and zoneTable[id] ~= nil and creator == zoneTable[id].creator) then
					MetaMapNotes_DeleteNote(id, continent, zone);
				elseif(setZone == zone and zoneTable[id] ~= nil and creator == zoneTable[id].creator) then
					MetaMapNotes_DeleteNote(id, continent, zone);
				end
			end
		end
	end
	if(creator == "") then creator = "Unsigned"; end
	if(zoneName ~= nil) then
		if(MetaMap_NotesDialog:IsVisible()) then
			MetaMapNotes_InfoText:SetText(format(METAMAPNOTES_DELETED_BY_ZONE, zoneName, creator), true);
			MetaMapNotes_InfoText:Show();
		else
			MetaMap_StatusPrint(format(METAMAPNOTES_DELETED_BY_ZONE, zoneName, creator), true);
		end
	elseif(name ~= nil) then
		MetaMap_StatusPrint(format(METAMAPNOTES_DELETED_BY_NAME, creator, name), true);
	else
		MetaMap_StatusPrint(format(METAMAPNOTES_DELETED_BY_CREATOR, creator), true);
	end
end

function MetaMap_CheckLinks(id)
	local continent, zone, currentZone = MetaMap_GetCurrentMapInfo();
	local name = currentZone[id].name;
	local count = 0;
	for i=1, 4, 1 do
		if(currentZone[id+i] ~= nil and currentZone[id+i].name == name and currentZone[id+i].icon == 10) then
			count = count +1;
		end
	end
	for i=1, count +1, 1 do
		MetaMapNotes_DeleteNote(id, continent, zone);
	end
end

function MetaMapNotes_DeleteNote(id, continent, zone)
	MetaMapNotes_HideAll()
	if id == 0 then
		MetaMapNotes_vnote_xPos = nil;
		MetaMapNotes_vnote_yPos = nil;
		MetaMapNotes_MapUpdate();
		return;
	elseif id == -1 then
		MetaMapNotes_PartyNoteData.xPos = nil;
		MetaMapNotes_PartyNoteData.yPos = nil;
		MetaMapNotes_PartyNoteData.continent = nil;
		MetaMapNotes_PartyNoteData.zone = nil;
		if(MetaMapNotes_MiniNote_Data.id == -1) then
			MetaMapNotes_MiniNote_Data = {};
		end
		MetaMapNotes_MapUpdate();
		return;
	end

	local currentZone
	local TempData = {};
	if(continent == -1 or zone == 0) then
		continent = GetRealZoneText();
		MetaMapNotes_Data[continent][id] = nil;
		MetaMapNotes_MapUpdate();
		return;
	else
		currentZone = MetaMapNotes_Data[continent][zone];
	end
	TempData[continent] = {};
	TempData[continent][zone] = {};
	local lastEntry = MetaMapNotes_GetZoneTableSize(currentZone);

	if(continent ~= -1 and currentZone[id] ~= nil) then
		MetaMapNotes_DeleteLines(continent, zone, currentZone[id].xPos, currentZone[id].yPos);
	end
	if(lastEntry ~= 0 and id <= lastEntry) then
		TempData[continent][zone] = MetaMapNotes_Data[continent][zone];
		MetaMapNotes_Data[continent][zone] = {};
		local newZone = TempData[continent][zone];
		for index, indexTable in newZone do
			if(index ~= id) then
				local oldData = newZone[index];
				MetaMapNotes_AddNewNote(continent, zone, oldData.xPos, oldData.yPos, oldData.name, oldData.inf1, oldData.inf2, oldData.creator, oldData.icon, oldData.ncol, oldData.in1c, oldData.in2c)
			end
		end
	end

	if continent == MetaMapNotes_MiniNote_Data.continent and zone == MetaMapNotes_MiniNote_Data.zone then
		if MetaMapNotes_MiniNote_Data.id > id then
			MetaMapNotes_MiniNote_Data.id = MetaMapNotes_MiniNote_Data.id - 1;
		elseif MetaMapNotes_MiniNote_Data.id == id then
			MetaMapNotes_ClearMiniNote(true);
		end
	end
	MetaMapNotes_MapUpdate();
end

function MetaMapPOI_OnEvent(mode)
	if(GetCurrentMapZone() == 0 or GetCurrentMapContinent() == -1) then return; end
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
	local noteAdded1, noteAdded2;
	local name, unknown, textureIndex, x, y;
	local icon = 9;
	for landmarkIndex = 1, GetNumMapLandmarks(), 1 do
		name, unknown, textureIndex, x, y = GetMapLandmarkInfo(landmarkIndex);
		if (textureIndex == 15) then
			icon = 5;
		elseif (textureIndex == 6) then
			icon = 6;
		end
		if(mode == 1) then
			if(textureIndex==6) then
				noteAdded1 = MetaMapNotes_AddNewNote(continent, zone, x, y, name, "", "", METAMAPFWM_NAME, icon, 6, 0, 0);
			end
		else
			noteAdded2 = MetaMapNotes_AddNewNote(continent, zone, x, y, name, "", "", METAMAPFWM_NAME, icon, 6, 0, 0);
		end
	end
	if(noteAdded1 and noteAdded2) then
		MetaMap_StatusPrint("MetaMapPOI updated map notes for "..GetRealZoneText(), true);
	else
		if(noteAdded2) then
			MetaMap_StatusPrint("MetaMapPOI updated map notes for "..GetRealZoneText(), true);
		end
		if(noteAdded1) then
			MetaMap_StatusPrint("MetaMapPOI set Guard note for "..name, true);
		end
	end
end

function MetaMap_SortCriteria(a, b)
	if(MetaMap_sortType == METAMAP_SORTBY_NAME) then
		if (a.name < b.name) then
			return true;
		elseif (a.name > b.name) then
			return false;
		end
	elseif(MetaMap_sortType == METAMAP_SORTBY_DESC) then
		if (a.desc < b.desc) then
			return true;
		elseif (a.desc > b.desc) then
			return false;
		end
	elseif(MetaMap_sortType == METAMAP_SORTBY_LEVEL) then
		if (a.level < b.level) then
			return true;
		elseif (a.level > b.level) then
			return false;
		end
	elseif(MetaMap_sortType == METAMAP_SORTBY_LOCATION) then
		if (a.location < b.location) then
			return true;
		elseif (a.location > b.location) then
			return false;
		end
	else
		if (a == nil) then
			if (b == nil) then
				return false;
			else
				return true;
			end
		elseif (b == nil) then
			return false;
		end
	end
end

function MetaMap_InvertList(list)
  local newlist = {};
  local count = table.getn(list);
  for i=1,count
  do
    table.insert(newlist, list[(count +1) -i]);
  end
  return newlist;
end

function MetaMap_InfoLine(button)
	if(button == "RightButton") then
		MetaMapOptions.ShowMapList = not MetaMapOptions.ShowMapList;
		MetaMapOptions_Init();
		return;
	end
	if(MetaMap_InfoLineFrame:IsVisible()) then
		MetaMap_InfoLineFrame:Hide();
		MetaMapContainerFrame:Hide();
		return;
	end
	local header, footer, info;
	if(MetaMapFrame:IsVisible()) then
		header = METAMAP_STRING_LOCATION..": ".."|cffffffff"..MetaMap_Data[MetaMapOptions.MetaMapZone]["Location"].."|r";
		header = header.."   "..METAMAP_STRING_LEVELRANGE..": ".."|cffffffff"..MetaMap_Data[MetaMapOptions.MetaMapZone]["LevelRange"].."|r";
		header = header.."   "..METAMAP_STRING_PLAYERLIMIT..": ".."|cffffffff"..MetaMap_Data[MetaMapOptions.MetaMapZone]["PlayerLimit"].."|r";
		MetaMap_InfoLineFrameText:SetText(MetaMap_Data[MetaMapOptions.MetaMapZone].infoline);
	else
		local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
		header = "|cffffffff"..mapName.."|r";
		info = "|cffffffffFurther information may be added at a later date...|r";
		MetaMap_InfoLineFrameText:SetText("|cffffffffFurther information may be added at a later date...|r");
	end
	MetaMapContainer_ShowFrame(MetaMap_InfoLineFrame, header, footer, info);
end

function MetaMap_InfoLineOnEnter()
	WorldMapTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	if(MetaMapFrame:IsVisible()) then
		WorldMapTooltip:SetText(MetaMap_Data[MetaMapOptions.MetaMapZone].ZoneName, 0, 1, 0, false);
		WorldMapTooltip:AddLine(METAMAP_STRING_LOCATION..": ".."|cffffffff"..MetaMap_Data[MetaMapOptions.MetaMapZone]["Location"], 1, 1, 0, false);
		WorldMapTooltip:AddLine(METAMAP_STRING_LEVELRANGE..": ".."|cffffffff"..MetaMap_Data[MetaMapOptions.MetaMapZone]["LevelRange"], 1, 1, 0, false);
		WorldMapTooltip:AddLine(METAMAP_STRING_PLAYERLIMIT..": ".."|cffffffff"..MetaMap_Data[MetaMapOptions.MetaMapZone]["PlayerLimit"], 1, 1, 0, false);
		WorldMapTooltip:AddLine(" ");
		WorldMapTooltip:AddDoubleLine("Saved Instances:", "ID:");
		if(GetNumSavedInstances() > 0) then
			for i=1, GetNumSavedInstances() do
				local name, ID, remaining = GetSavedInstanceInfo(i);
				remaining = SecondsToTime(remaining);
				WorldMapTooltip:AddDoubleLine(name, "|cffffffff"..ID, 0, 1, 0, false);
				WorldMapTooltip:AddLine("|cffffffff"..remaining);
			end
		else
			WorldMapTooltip:AddLine("|cffffffffNo saved instances");
		end
	else
		local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
		if(type(continent) == "string" or zone == 0) then
			WorldMapTooltip:SetText(mapName, 1, 1, 0, false);
		else
			zone = MetaMapNotes_ZoneShift[continent][zone];
			currentZone = MetaMap_ZoneLevels[continent][zone];
			local fColor = {}; local lColor = {};
			local Friendly = { r = 0.2, g = 0.9, b = 0.2 };
			local Hostile = { r = 0.9, g = 0.2, b = 0.2 };
			local Contested = { r = 0.8, g = 0.6, b = 0.4 };
			local fID = currentZone[3];
			local _, faction = UnitFactionGroup("player");
			if(fID == "Contested") then
				fColor = Contested;				
			elseif(fID == faction) then
				fColor = Friendly;
			else
				fColor = Hostile;
			end
			if(UnitLevel("player") > currentZone[2]) then
				lColor = { r = 0.5, g = 0.5, b = 0.5 };				
			elseif(UnitLevel("player") < currentZone[1]) then
				lColor = Hostile;
			else
				lColor = Friendly;
			end
			WorldMapTooltip:AddDoubleLine(mapName, fID, fColor.r, fColor.g, fColor.b, fColor.r, fColor.g, fColor.b, false);
			WorldMapTooltip:AddDoubleLine(METAMAP_STRING_LEVELRANGE, currentZone[1].." - "..currentZone[2], 1, 1, 0, lColor.r, lColor.g, lColor.b, false);
		end
	end
	WorldMapTooltip:AddLine(" ");
	WorldMapTooltip:AddLine(METAMAP_INFOLINE_HINT1, 0.75, 0, 0.75, false);
	WorldMapTooltip:AddLine(METAMAP_INFOLINE_HINT2, 0.75, 0, 0.75, false);
	WorldMapTooltip:AddLine(" ");
	WorldMapTooltip:AddLine(METAMAPNOTES_WORLDMAP_HELP_1, 0.40, 0.40, 0.40, false);
	WorldMapTooltip:AddLine(METAMAPNOTES_WORLDMAP_HELP_2, 0.40, 0.40, 0.40, false);
	WorldMapTooltip:Show()
end

function MetaKBMenu_RBSelect(id)
	-- Slot assigned to MetaMapBWP.
end

function MetaKBMenu_CRBSelect(id)
	-- Available for other mods to run their own routine.
	-- Initiated when CTRL+RightClicking on KB display item.
	-- Usage: MetaKBMenu_CRBSelect = MyFunction
end

function MetaKBMenu_SRBSelect(id)
	-- Available for other mods to run their own routine.
	-- Initiated when Shift+RightClicking on KB display item.
	-- Usage: MetaKBMenu_SRBSelect = MyFunction
end

function MetaMapNotes_RBSelect(id)
	-- Slot assigned to MetaMapBWP.
end

function MetaMapNotes_CRBSelect(id)
	-- Available for other mods to run their own routine.
	-- Initiated when CTRL+RightClicking on a map note.
	-- Usage: MetaMapNotes_CRBSelect = MyFunction
end

function MetaMapNotes_SRBSelect(id)
	-- Available for other mods to run their own routine.
	-- Initiated when Shift+RightClicking on a map note.
	-- Usage: MetaMapNotes_SRBSelect = MyFunction
end

----------------
-- FuBar Support
----------------
function MetaMap_FuBar_OnLoad()
	local tablet = TabletLib:GetInstance('1.0')
	
	MetaMapFu 		= FuBarPlugin:GetInstance("1.2"):new({
	name          = METAMAP_TITLE,
	version       = METAMAP_VERSION,
	description   = METAMAP_DESC,
	aceCompatible = 103,
	category      = "map",
	hasIcon 			= METAMAP_ICON,
	hasNoText 		= TRUE,
	})

	function MetaMapFu:OnClick()
		MetaMap_ToggleFrame(WorldMapFrame);
	end
	function MetaMapFu:UpdateTooltip()
		MetaMapMenu_OnShow("FuBar");
	end

	MetaMapFu:RegisterForLoad();
end

----------------
-- Titan Support
----------------
function TitanPanelMetaMapButton_OnLoad()
	this.registry = { 
		id = TITAN_METAMAP_ID,
		version = METAMAP_VERSION,
		menuText = METAMAP_TITLE,
		category = METAMAP_CATEGORY,
		tooltipTitle = METAMAP_TITLE ,
		tooltipTextFunction = "TitanPanelMetaMapButton_GetTooltipText",
		frequency = TITAN_METAMAP_FREQUENCY, 
		icon = METAMAP_ICON,
		iconWidth = 16,
		savedVariables = {
		ShowIcon = 1,
		}
	};
end

function TitanPanelMetaMapButton_GetTooltipText()
	if(MetaMapOptions.MenuMode) then
		retText = METAMAP_BUTTON_TOOLTIP1.."\n"..METAMAP_BUTTON_TOOLTIP2;
		return retText;
	end
end

function TitalPanelMetaMapButton_OnClick(button)
	if ( button == "LeftButton" ) then
		MetaMap_ToggleFrame(WorldMapFrame);
	end
end

---------
-- CT_Mod
---------
if(IsAddOnLoaded("CT_MapMod")) then
	CT_CoordX:Hide();
	CT_CoordY:Hide();
	CT_NumNotes:SetPoint("TOPLEFT","WorldMapDetailFrame","TOPLEFT",10,-10);
	WorldMapFrameCreateNoteOnPlayer:SetPoint("RIGHT","WorldMapContinentDropDown","LEFT",-190,0);
end

-----------
-- FlightMap
-----------
function FlightMapOptions_Toggle()
	FlightMapOptionsFrame:SetFrameStrata("FULLSCREEN");
	MetaMap_ToggleFrame(FlightMapOptionsFrame);
end

-----------
-- Gatherer
-----------
function GathererOptions_Toggle()
	GathererUI_DialogFrame:SetFrameStrata("FULLSCREEN");
	MetaMap_ToggleFrame(GathererUI_DialogFrame);
end

-------------
-- NotesUNeed
-------------
function MetaMap_SetNUNtooltip()
	if(IsAddOnLoaded("NotesUNeed")) then
		local pKey = GetCVar("realmName");
		if(MetaMapOptions.SaveSet == 1) then
			NuNSettings[pKey].mScale = MetaMapOptions.MetaMapTTScale1;
		else
			NuNSettings[pKey].mScale = MetaMapOptions.MetaMapTTScale2;
		end
	end
end

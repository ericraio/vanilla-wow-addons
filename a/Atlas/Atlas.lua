--Atlas, an instance map browser
--Author: Dan Gilbert
--Email: loglow@gmail.com
--AIM: dan5981
ATLAS_VERSION = "1.8.1";
ATLAS_DATE = "August 22, 2006";

--myAddOns data goes here
AtlasDetails = {
	name = "Atlas",
	version = ATLAS_VERSION,
	releaseDate = ATLAS_DATE,
	author = "Dan Gilbert",
	email = "loglow@gmail.com",
	website = "http://www.atlasmod.com/",
	optionsframe = "AtlasOptionsFrame",
	category = MYADDONS_CATEGORY_MAP
};

local Atlas_Vars_Loaded = nil;
ATLAS_DROPDOWN_LIST = {};
ATLAS_DROPDOWN_LIST_BG = {};
ATLAS_DROPDOWN_LIST_FP = {};
ATLAS_DROPDOWN_LIST_DL = {};
ATLAS_DROPDOWN_LIST_RE = {};

local DefaultAtlasOptions = {
	["AtlasVersion"] = ATLAS_VERSION;
	["AtlasZone"] = 1;
	["AtlasAlpha"] = 1.0;
	["AtlasLocked"] = false;
	["AtlasMapName"] = true;
	["AtlasAutoSelect"] = false;
	["AtlasButtonPosition"] = 268;
	["AtlasButtonShown"] = true;
	["AtlasReplaceWorldMap"] = false;
	["AtlasRightClick"] = false;
	["AtlasType"] = 1;
	["AtlasAcronyms"] = true;
};

function Atlas_FreshOptions()
	AtlasOptions = CloneTable(DefaultAtlasOptions);
end

--Code by Grayhoof (SCT)
function CloneTable(t)				-- return a copy of the table t
	local new = {};					-- create a new table
	local i, v = next(t, nil);		-- i is an index of t, v = t[i]
	while i do
		if type(v)=="table" then 
			v=CloneTable(v);
		end 
		new[i] = v;
		i, v = next(t, i);			-- get next index
	end
	return new;
end

--Called when the Atlas frame is first loaded
--We CANNOT assume that data in other files is available yet!
function Atlas_OnLoad()

	--Register the Atlas frame for the following events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");

	--Allows Atlas to be closed with the Escape key
	tinsert(UISpecialFrames, "AtlasFrame");
	
	--Dragging involves some special registration
	AtlasFrame:RegisterForDrag("LeftButton");
	
	--Setting up slash commands involves referencing some strage auto-generated variables
	SLASH_ATLAS1 = ATLAS_SLASH;
	SlashCmdList["ATLAS"] = function(msg)
		Atlas_SlashCommand(msg);
	end
end

--Removal of articles in map names (for proper alphabetic sorting)
--For example: "The Deadmines" will become "Deadmines"
--Thus it will be sorted under D and not under T
local function Atlas_SanitizeName(text)
   text = string.lower(text);
   if (AtlasSortIgnore) then
	   for _,v in AtlasSortIgnore do
		   local match = string.gfind(text, v)();
		   if (match) and ((string.len(text) - string.len(match)) <= 4) then
			   return match;
		   end
	   end
   end
   return text;
end

--Comparator function for alphabetic sorting of maps
local function Atlas_SortZonesAlpha(a, b)
	local aa = Atlas_SanitizeName(AtlasText[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasText[b].ZoneName);
	return aa < bb;
end

--Comparator function for alphabetic sorting of BG maps
local function Atlas_SortZonesAlphaBG(a, b)
	local aa = Atlas_SanitizeName(AtlasBG[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasBG[b].ZoneName);
	return aa < bb;
end

--Comparator function for alphabetic sorting of FP maps
local function Atlas_SortZonesAlphaFP(a, b)
	local aa = Atlas_SanitizeName(AtlasFP[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasFP[b].ZoneName);
	return aa < bb;
end

--Comparator function for alphabetic sorting of DL maps
local function Atlas_SortZonesAlphaDL(a, b)
	local aa = Atlas_SanitizeName(AtlasDL[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasDL[b].ZoneName);
	return aa < bb;
end

--Comparator function for alphabetic sorting of RE maps
local function Atlas_SortZonesAlphaRE(a, b)
	local aa = Atlas_SanitizeName(AtlasRE[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasRE[b].ZoneName);
	return aa < bb;
end

--These are the REAL level range values!
--Overrides the values that may be found in the localization files
function Atlas_UpdateLevelRanges()
	AtlasText.BlackfathomDeeps.LevelRange =		"24-32";
	AtlasText.BlackrockSpireLower.LevelRange =	"55-60";
	AtlasText.BlackrockSpireUpper.LevelRange =	"55-60";
	AtlasText.BlackrockDepths.LevelRange =		"52-60";
	AtlasText.ShadowfangKeep.LevelRange =		"22-30";
	AtlasText.ScarletMonastery.LevelRange =		"34-45";
	AtlasText.MoltenCore.LevelRange =			"60+";
	AtlasText.TheSunkenTemple.LevelRange =		"50-60";
	AtlasText.WailingCaverns.LevelRange =		"17-24";
	AtlasText.TheStockade.LevelRange =			"24-32";
	AtlasText.TheDeadmines.LevelRange =			"17-26";
	AtlasText.DireMaulNorth.LevelRange =		"56-60";
	AtlasText.DireMaulEast.LevelRange =			"56-60";
	AtlasText.DireMaulWest.LevelRange =			"56-60";
	AtlasText.Gnomeregan.LevelRange =			"29-38";
	AtlasText.RazorfenDowns.LevelRange =		"37-46";
	AtlasText.RazorfenKraul.LevelRange =		"29-38";
	AtlasText.Maraudon.LevelRange =				"46-55";
	AtlasText.OnyxiasLair.LevelRange =			"60+";
	AtlasText.BlackwingLair.LevelRange =		"60+";
	AtlasText.RagefireChasm.LevelRange =		"13-18";
	AtlasText.Scholomance.LevelRange =			"58-60";
	AtlasText.Stratholme.LevelRange =			"58-60";
	AtlasText.Uldaman.LevelRange =				"41-51";
	AtlasText.ZulFarrak.LevelRange =			"44-54";
	AtlasText.ZulGurub.LevelRange =				"60+";
	AtlasText.TheTempleofAhnQiraj.LevelRange =	"60+";
	AtlasText.TheRuinsofAhnQiraj.LevelRange =	"60+";
	AtlasText.Naxxramas.LevelRange =			"60+";
	AtlasBG.AlteracValleyNorth.LevelRange =		"51-60";
	AtlasBG.AlteracValleySouth.LevelRange =		"51-60";
	AtlasBG.ArathiBasin.LevelRange =			"20-60";
	AtlasBG.WarsongGulch.LevelRange =			"10-60";
	AtlasFP.FPAllianceEast.LevelRange =			"---";
	AtlasFP.FPAllianceWest.LevelRange =			"---";
	AtlasFP.FPHordeEast.LevelRange =			"---";
	AtlasFP.FPHordeWest.LevelRange =			"---";
	AtlasDL.DLEast.LevelRange =					"---";
	AtlasDL.DLWest.LevelRange =					"---";
	AtlasRE.Azuregos.LevelRange =				"60+";
	AtlasRE.FourDragons.LevelRange =			"60+";
	AtlasRE.Kazzak.LevelRange =					"60+";
end

--These are the REAL player limit values!
--Overrides the values that may be found in the localization files
function Atlas_UpdatePlayerLimits()
	AtlasText.BlackfathomDeeps.PlayerLimit =	"10";
	AtlasText.BlackrockSpireLower.PlayerLimit =	"10";
	AtlasText.BlackrockSpireUpper.PlayerLimit =	"10";
	AtlasText.BlackrockDepths.PlayerLimit =		"5";
	AtlasText.ShadowfangKeep.PlayerLimit =		"10";
	AtlasText.ScarletMonastery.PlayerLimit =	"10";
	AtlasText.MoltenCore.PlayerLimit =			"40";
	AtlasText.TheSunkenTemple.PlayerLimit =		"10";
	AtlasText.WailingCaverns.PlayerLimit =		"10";
	AtlasText.TheStockade.PlayerLimit =			"10";
	AtlasText.TheDeadmines.PlayerLimit =		"10";
	AtlasText.DireMaulNorth.PlayerLimit =		"5";
	AtlasText.DireMaulEast.PlayerLimit =		"5";
	AtlasText.DireMaulWest.PlayerLimit =		"5";
	AtlasText.Gnomeregan.PlayerLimit =			"10";
	AtlasText.RazorfenDowns.PlayerLimit =		"10";
	AtlasText.RazorfenKraul.PlayerLimit =		"10";
	AtlasText.Maraudon.PlayerLimit =			"10";
	AtlasText.OnyxiasLair.PlayerLimit =			"40";
	AtlasText.BlackwingLair.PlayerLimit =		"40";
	AtlasText.RagefireChasm.PlayerLimit =		"10";
	AtlasText.Scholomance.PlayerLimit =			"5";
	AtlasText.Stratholme.PlayerLimit =			"5";
	AtlasText.Uldaman.PlayerLimit =				"10";
	AtlasText.ZulFarrak.PlayerLimit =			"10";
	AtlasText.ZulGurub.PlayerLimit =			"20";
	AtlasText.TheTempleofAhnQiraj.PlayerLimit =	"40";
	AtlasText.TheRuinsofAhnQiraj.PlayerLimit =	"20";
	AtlasText.Naxxramas.PlayerLimit =			"40";
	AtlasBG.AlteracValleyNorth.PlayerLimit =	"40";
	AtlasBG.AlteracValleySouth.PlayerLimit =	"40";
	AtlasBG.ArathiBasin.PlayerLimit =			"15";
	AtlasBG.WarsongGulch.PlayerLimit =			"10";
	AtlasFP.FPAllianceEast.PlayerLimit =		"---";
	AtlasFP.FPAllianceWest.PlayerLimit =		"---";
	AtlasFP.FPHordeEast.PlayerLimit =			"---";
	AtlasFP.FPHordeWest.PlayerLimit =			"---";
	AtlasDL.DLEast.PlayerLimit =				"---";
	AtlasDL.DLWest.PlayerLimit =				"---";
	AtlasRE.Azuregos.PlayerLimit =				"40";
	AtlasRE.FourDragons.PlayerLimit =			"40";
	AtlasRE.Kazzak.PlayerLimit =				"40";
end

--Main Atlas event handler
function Atlas_OnEvent()

	if (event == "ADDON_LOADED") then
		if (strlower(arg1) == "atlas") then
			Atlas_Vars_Loaded = 1;
			Atlas_Init();
		end
	elseif (event == "VARIABLES_LOADED") then
		if (not Atlas_Vars_Loaded) then
			Atlas_Vars_Loaded = 1;
			Atlas_Init();
		end
	end
	
end

--Initializes everything relating to saved variables and data in other lua files
--This should be called ONLY when we're sure that all other files have been loaded
function Atlas_Init()

	if ( AtlasOptions == nil or AtlasOptions["AtlasVersion"] ~= ATLAS_VERSION) then
		Atlas_FreshOptions();
	end

	--Take all the maps listed in the localization files and import them into the dropdown list structure
	table.foreach(AtlasText, function(v)
		table.insert(ATLAS_DROPDOWN_LIST, v)
	end);
	table.foreach(AtlasBG, function(v)
		table.insert(ATLAS_DROPDOWN_LIST_BG, v)
	end);
	table.foreach(AtlasFP, function(v)
		table.insert(ATLAS_DROPDOWN_LIST_FP, v)
	end);
	table.foreach(AtlasDL, function(v)
		table.insert(ATLAS_DROPDOWN_LIST_DL, v)
	end);
	table.foreach(AtlasRE, function(v)
		table.insert(ATLAS_DROPDOWN_LIST_RE, v)
	end);

	--Update the level ranges and player limits
	--Overrides the values in the localization files because I'm too lazy to change them all
	--It's also nice to have all the these figures come from only one place
	Atlas_UpdateLevelRanges();
	Atlas_UpdatePlayerLimits();
	
	--Sort the lists of maps alphabetically
	table.sort(ATLAS_DROPDOWN_LIST, Atlas_SortZonesAlpha);
	table.sort(ATLAS_DROPDOWN_LIST_BG, Atlas_SortZonesAlphaBG);
	table.sort(ATLAS_DROPDOWN_LIST_FP, Atlas_SortZonesAlphaFP);
	table.sort(ATLAS_DROPDOWN_LIST_DL, Atlas_SortZonesAlphaDL);
	table.sort(ATLAS_DROPDOWN_LIST_RE, Atlas_SortZonesAlphaRE);
	
	--Now that saved variables have been loaded, update everything accordingly
	Atlas_Refresh();
	AtlasOptions_Init();
	Atlas_UpdateLock();
	AtlasButton_UpdatePosition();
	Atlas_UpdateAlpha();
	
	--myAddOns support
	if(myAddOnsFrame_Register) then
		myAddOnsFrame_Register(AtlasDetails);
	end

	--Cosmos integration
	if(EarthFeature_AddButton) then
		EarthFeature_AddButton(
		{
			id = ATLAS_TITLE;
			name = ATLAS_TITLE;
			subtext = ATLAS_SUBTITLE;
			tooltip = ATLAS_DESC;
			icon = "Interface\\AddOns\\Atlas\\Images\\AtlasIcon";
			callback = Atlas_Toggle;
			test = nil;
		}
	);
	elseif(Cosmos_RegisterButton) then
		Cosmos_RegisterButton(
			ATLAS_TITLE,
			ATLAS_SUBTITLE,
			ATLAS_DESC,
			"Interface\\AddOns\\Atlas\\Images\\AtlasIcon",
			Atlas_Toggle
		);
	end
	
	--CTMod integration
	if(CT_RegisterMod) then
		CT_RegisterMod(
			ATLAS_TITLE,
			ATLAS_SUBTITLE,
			5,
			"Interface\\AddOns\\Atlas\\Images\\AtlasIcon",
			ATLAS_DESC,
			"switch",
			"",
			Atlas_Toggle
		);
	end
end

--Simple function to toggle the Atlas frame's lock status and update it's appearance
function Atlas_ToggleLock()
	if(AtlasOptions.AtlasLocked) then
		AtlasOptions.AtlasLocked = false;
		Atlas_UpdateLock();
	else
		AtlasOptions.AtlasLocked = true;
		Atlas_UpdateLock();
	end
end

--Updates the appearance of the lock button based on the status of AtlasLocked
function Atlas_UpdateLock()
	if(AtlasOptions.AtlasLocked) then
		AtlasLockNorm:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Up");
		AtlasLockPush:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Down");
	else
		AtlasLockNorm:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Up");
		AtlasLockPush:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Down");
	end
end

--Begin moving the Atlas frame if it's unlocked
function Atlas_StartMoving()
	if(not AtlasOptions.AtlasLocked) then
		AtlasFrame:StartMoving();
	end
end

--Parses slash commands
--If an unrecognized command is given, toggle Atlas
function Atlas_SlashCommand(msg)
	if(msg == ATLAS_SLASH_OPTIONS) then
		AtlasOptions_Toggle();
	else
		Atlas_Toggle();
	end
end

--Sets the transparency of the Atlas frame based on AtlasAlpha
function Atlas_UpdateAlpha()
	AtlasFrame:SetAlpha(AtlasOptions.AtlasAlpha);
end

--Simple function to toggle the visibility of the Atlas frame
function Atlas_Toggle()
	if(AtlasFrame:IsVisible()) then
		HideUIPanel(AtlasFrame);
	else
		ShowUIPanel(AtlasFrame);
	end
end

--Refreshes the Atlas frame, usually because a new map needs to be displayed
--The zoneID variable represents the internal name used for each map
--Also responsible for updating all the text when a map is changed
function Atlas_Refresh()
	local zoneID;
	local textSource;
	
	--Just in case AtlasType hasn't been initialized
	--Added in response to a possible error
	if ( AtlasOptions.AtlasType == nil ) then
		AtlasOptions.AtlasType = 1;
	end
	
	if ( AtlasOptions.AtlasType == 1 ) then
		zoneID = ATLAS_DROPDOWN_LIST[AtlasOptions.AtlasZone];
		textSource = AtlasText;
	elseif ( AtlasOptions.AtlasType == 2 ) then
		zoneID = ATLAS_DROPDOWN_LIST_BG[AtlasOptions.AtlasZone];
		textSource = AtlasBG;
	elseif ( AtlasOptions.AtlasType == 3 ) then
		zoneID = ATLAS_DROPDOWN_LIST_FP[AtlasOptions.AtlasZone];
		textSource = AtlasFP;
	elseif ( AtlasOptions.AtlasType == 4 ) then
		zoneID = ATLAS_DROPDOWN_LIST_DL[AtlasOptions.AtlasZone];
		textSource = AtlasDL;
	elseif ( AtlasOptions.AtlasType == 5 ) then
		zoneID = ATLAS_DROPDOWN_LIST_RE[AtlasOptions.AtlasZone];
		textSource = AtlasRE;
	end
	AtlasMap:ClearAllPoints();
	AtlasMap:SetWidth(512);
	AtlasMap:SetHeight(512);
	AtlasMap:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
	AtlasMap:SetTexture("Interface\\AddOns\\Atlas\\Images\\"..zoneID);
	local ZoneNameText = textSource[zoneID]["ZoneName"];
	if ( AtlasOptions.AtlasAcronyms and textSource[zoneID]["Acronym"] ~= nil) then
		local _RED = "|cffcc6666";
		ZoneNameText = ZoneNameText.._RED.." ["..textSource[zoneID]["Acronym"].."]";
	end
	AtlasText_ZoneName:SetText(ZoneNameText);
	AtlasText_Location:SetText(ATLAS_STRING_LOCATION..": "..textSource[zoneID]["Location"]);
	AtlasText_LevelRange:SetText(ATLAS_STRING_LEVELRANGE..": "..textSource[zoneID]["LevelRange"]);
	AtlasText_PlayerLimit:SetText(ATLAS_STRING_PLAYERLIMIT..": "..textSource[zoneID]["PlayerLimit"]);
	for i = 1, 27, 1 do
		getglobal("AtlasText_"..i):SetText(textSource[zoneID][i]);
	end
end

--Function used to initialize the map type dropdown menu
--Cycle through Atlas_MapTypes to populate the dropdown
function AtlasFrameDropDownType_Initialize()
	local info;
	for i = 1, getn(Atlas_MapTypes), 1 do
		info = {
			text = Atlas_MapTypes[i];
			func = AtlasFrameDropDownType_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

--Called whenever the map type dropdown menu is shown
function AtlasFrameDropDownType_OnShow()
	UIDropDownMenu_Initialize(AtlasFrameDropDownType, AtlasFrameDropDownType_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, AtlasOptions.AtlasType);
	UIDropDownMenu_SetWidth(175, AtlasFrameDropDownType);
end

--Called whenever an item in the map type dropdown menu is clicked
--Sets the main dropdown menu contents to reflect the category of map selected
function AtlasFrameDropDownType_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, i);
	AtlasOptions.AtlasType = i;
	AtlasOptions.AtlasZone = 1;
	AtlasFrameDropDown_OnShow();
	Atlas_Refresh();
end

--Function used to initialize the main dropdown menu
--Looks at the status of AtlasType to determine how to populate the list
function AtlasFrameDropDown_Initialize()
	if ( AtlasOptions.AtlasType == 1 ) then
		AtlasFrameDropDown_Populate(AtlasText, ATLAS_DROPDOWN_LIST);
	elseif ( AtlasOptions.AtlasType == 2 ) then
		AtlasFrameDropDown_Populate(AtlasBG, ATLAS_DROPDOWN_LIST_BG);
	elseif ( AtlasOptions.AtlasType == 3 ) then
		AtlasFrameDropDown_Populate(AtlasFP, ATLAS_DROPDOWN_LIST_FP);
	elseif ( AtlasOptions.AtlasType == 4 ) then
		AtlasFrameDropDown_Populate(AtlasDL, ATLAS_DROPDOWN_LIST_DL);
	elseif ( AtlasOptions.AtlasType == 5 ) then
		AtlasFrameDropDown_Populate(AtlasRE, ATLAS_DROPDOWN_LIST_RE);
	end
end

--Populates the main dropdown menu based on the arguments given
--mapType is the name used in the localization files for the category of map
--dropList is the (hopefully) sorted list made from one of those categories
function AtlasFrameDropDown_Populate(mapType, dropList)
	local info;
	for i = 1, getn(dropList), 1 do
		info = {
			text = mapType[dropList[i]]["ZoneName"];
			func = AtlasFrameDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

--Called whenever the main dropdown menu is shown
function AtlasFrameDropDown_OnShow()
	UIDropDownMenu_Initialize(AtlasFrameDropDown, AtlasFrameDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, AtlasOptions.AtlasZone);
	UIDropDownMenu_SetWidth(175, AtlasFrameDropDown);
end

--Called whenever an item in the main dropdown menu is clicked
--Sets the newly selected map as current and refreshes the frame
function AtlasFrameDropDown_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, i);
	AtlasOptions.AtlasZone = i;
	Atlas_Refresh();
end

--Modifies the value of GetRealZoneText to account for some naming conventions
--Always use this function instead of GetRealZoneText within Atlas
function Atlas_GetFixedZoneText()
   local currentZone = GetRealZoneText();
   if (AtlasZoneSubstitutions[currentZone]) then
      return AtlasZoneSubstitutions[currentZone];
   end
   return currentZone;
end 

--Checks the player's current location against all Atlas maps
--If a match is found display that map right away
function Atlas_AutoSelect()
	local currentZone = Atlas_GetFixedZoneText();
	local currentMap = AtlasText[ATLAS_DROPDOWN_LIST[AtlasOptions.AtlasZone]]["ZoneName"];
	if(currentZone ~= currentMap) then
		for i = 1, getn(ATLAS_DROPDOWN_LIST), 1 do
			local mapName = AtlasText[ATLAS_DROPDOWN_LIST[i]]["ZoneName"];
			if(currentZone == mapName) then
				AtlasOptions.AtlasType = 1;
				AtlasOptions.AtlasZone = i;
				UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, i);
				Atlas_Refresh();
			end
		end
	end
end

--Called whenever the Atlas frame is displayed
function Atlas_OnShow()
	if(AtlasOptions.AtlasAutoSelect) then
		Atlas_AutoSelect();
	end
end

--Checks to see if the World Map should be replaced by Atlas or not
--Is the feature turned on? Is the player in an instance?
function Atlas_ReplaceWorldMap()
	if(AtlasOptions.AtlasReplaceWorldMap) then
		local currentZone = Atlas_GetFixedZoneText();
		for i = 1, getn(ATLAS_DROPDOWN_LIST), 1 do
			local mapName = AtlasText[ATLAS_DROPDOWN_LIST[i]]["ZoneName"];
			if(currentZone == mapName) then
				return true;
			end
		end
	end
	return false;
end

--Code provided by Morac
--Replaces the default ToggleWorldMap function
function ToggleWorldMap()
	if ( WorldMapFrame:IsVisible() ) then
		HideUIPanel(WorldMapFrame);
	else
		if(Atlas_ReplaceWorldMap()) then
			Atlas_Toggle();
		else
			--removed due to error in 1.12 (8/22/06)
			--SetupWorldMapScale(WorldMapFrame);
			ShowUIPanel(WorldMapFrame);
		end
	end
end

--Code provided by tyroney
--Bugfix code by Cold
--Runs when the Atlas frame is clicked on
--RightButton closes Atlas and open the World Map if the RightClick option is turned on
function Atlas_OnClick()
	if ( arg1 == "RightButton" ) then
		if (AtlasOptions.AtlasRightClick) then
			local OldAtlasOptReplWMap = AtlasOptions.AtlasReplaceWorldMap;
			AtlasOptions.AtlasReplaceWorldMap = false;
			Atlas_Toggle();
			ToggleWorldMap();
			AtlasOptions.AtlasReplaceWorldMap = OldAtlasOptReplWMap;
		end
	end
end

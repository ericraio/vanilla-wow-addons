--[[ KLH Threatmeter KLHTM_Gui.lua

local version -> to be integrated into kenco files

Lukon Mod 2: The replacement for Gui.lua and Tables.lua. Controls the GUI 
for KLH ThreatMeter, along with KTM_Frame.xml, KTM_RaidGui.lua, 
KTM_SelfGui.lua, KTM_TitleGui.lua.

There is a single main frame, which shows either raid threat data 
(KTM_RaidGui.lua) or personal threat details (KTM_SelfGui.lua). Each of 
these two frames contains column headers, data rows and a bottom bar. 
Additionally there is a title bar frame (KTM_TitleGui). The GUI elements are
contained in a table "KLHTM_Gui", populated by the CreateGuiTable(). This 
also contains some properties not set in the XML file, such as some 
dimensions and colours.

The appearance of the GUI can be customised via the "KLHTM_GuiOptions" table.
This determines the visibility of command buttons and data columns, the way 
data is displayed in the main tables, and other settings. User access to
these settings is via the options gui (KTM_OptionsFrame.xml, 
KTM_OptionsGui.lua).

The visibility and some properties of the frame as a whole are kept in the
"state" table.

NB the indexes in the tables "gui", "options", and elsewhere shouldn't be
changed. They are assumed to match by various methods.
--]]

-- ken
local mod = klhtm
local me = { }
mod.gui = me

-- The minimum period, in seconds, between data table redrawing
local Min_Redraw_Period = 0.2;

-- When the table was last redrawn
local lastRedraw = 0;
KLHTM_LastRedraw = lastRedraw;

-- Set to true when a redraw has been requested but not yet performed
local needsRedraw = false;
KLHTM_NeedsRedraw = needsRedraw;

-- Contains settings describing the way raid and self data should displayed. 
-- Loaded from saved variables or initialised by _CreateDefaultOptions()
local options = {};
KLHTM_GuiOptions = options;

-- Contains window state information. Loaded from saved variables or 
-- initialised by _CreateDefaultState().
local state = {};
KLHTM_GuiState = state;

-- Contains references to the GUI components and some additional properties
-- not specified in the XML file. Initialised by _CreateGuiTable()
local gui = {};
KLHTM_Gui = gui;

-- true if initialisation (SetupGui) has finished, and rendering is possible
local isInitialised = false;
KLHTM_IsLoaded = false;

-- the maximum change in string width allowed by KLHTM_LocaliseStringWidth()
local Max_Localisation_Factor = 2;

-- frame scale constants
KLHTM_Scale = {["min"] = 0.6, ["max"] = 1.3, ["tick"] = 0.02, ["default"] = 1.0};

-- the current dimensions of the frame and subframes. These are filled by the various
-- UpdateXFrame and Redraw methods.
local sizes = {	["raid"] = {},		["self"] = {},	["but"] = {}, 
				["string"] = {},	["title"] = {},	["frame"] = {}, };
KLHTM_GuiSizes = sizes;

-- The heights of some sizes
KLHTM_GuiHeights = {["button"] = 15, ["string"] = 12, ["header"] = 14, ["data"] = 12};

-- The texture gradient colours used by the main frame and options frame's title bar
KLHTM_TitleBarColours = {
	-- purple
	["raid"] = {["minR"] = 0.2, ["minG"] = 0.0, ["minB"] = 0.2, ["minA"] = 0.5,
				["maxR"] = 1.0, ["maxG"] = 0.0, ["maxB"] = 1.0, ["maxA"] = 0.5, },
	-- dark green
	["self"] = {["minR"] = 0.0, ["minG"] = 0.2, ["minB"] = 0.0, ["minA"] = 0.5,
				["maxR"] = 0.0, ["maxG"] = 0.7, ["maxB"] = 0.0, ["maxA"] = 0.5, },
	-- blue
	["gen"] =  {["minR"] = 0.0, ["minG"] = 0.2, ["minB"] = 0.2, ["minA"] = 0.5,
				["maxR"] = 0.0, ["maxG"] = 1.0, ["maxB"] = 1.0, ["maxA"] = 0.5, }, };
	
------------------------------------------------------------------------------
-- Prepares the GUI for use. Called after the Variables Loaded event is
-- received (see KLHTM_Frame <OnLoad>, <OnEvent>).
--
-- some patches to official KLHTM: (a) removed setupaftervariablesloaded
-- method, and its reference in ktmMain. (b) events now come from the update
-- frame. The main frame only sends the variables loaded event.
------------------------------------------------------------------------------

me.myevents = { "ADDON_LOADED" }

me.onevent = function()
	
	KLHTM_SetupGui()
	
end

me.onupdate = function()

	KLHTM_Redraw()

end

function KLHTM_SetupGui()
	
	if (isInitialised) then
		-- will this ever happen? who knows...
		return; 
	end
	
	KLHTM_LoadVariables();
	KLHTM_CreateGuiTable();
	KLHTM_SetupGuiComponents();
	
	-- apply state and options
	KLHTM_UpdateSelfFrame();
	KLHTM_UpdateRaidFrame();
	KLHTM_UpdateTitleButtons();
	KLHTM_UpdateTitleStrings();
	
	isInitialised = true;
	
	-- probably going to cause some dumb error...
	KLHTM_Redraw(true);
	
	KLHTM_UpdateFrame();
	KLHTM_SetGuiScale(options.scale);
	
	if (state.closed ~= true) then
		gui.frame:Show();
	end
end


------------------------------------------------------------------------------
-- Loads data from saved variables. If the required data is not found, default
-- settings are used instead.
------------------------------------------------------------------------------
function KLHTM_LoadVariables()
	
	if (KLHTM_SavedVariables == nil) then
		KLHTM_SavedVariables = {};
	end

	if (KLHTM_SavedVariables.gui) then
		
		if mod.out.checktrace("info", me, "savedvariables") then
			mod.out.printtrace("Loading KTM saved variables");
		end
		
		-- nb byval copies to preserve external references to KLHTM_GuiState and
		-- KLHTM_GuiOptions. Todo: more robust format
		for index, value in KLHTM_SavedVariables.gui.state do
			state[index] = value;
		end
		for index, value in KLHTM_SavedVariables.gui.options do
			options[index] = value;
		end
		
		-- todo: better saved variables upgrading
		if (options.buttonVis.min.targ == nil) then
			options.buttonVis.min.targ = false;
			options.buttonVis.max.targ = true;
		end
		if (options.buttonVis.min.clear == nil) then
			options.buttonVis.min.clear = false;
			options.buttonVis.max.clear = false;
		end
	else
		if mod.out.checktrace("info", me, "savedvariables") then
			mod.out.printtrace("Performing fresh install of KTM")
		end
		
		KLHTM_SetDefaultOptions();
		KLHTM_SetDefaultState();
	end
	
	KLHTM_SavedVariables.gui = {};
	KLHTM_SavedVariables.gui.version = mod.build;
	KLHTM_SavedVariables.gui.options = options;
	KLHTM_SavedVariables.gui.state = state;
end


------------------------------------------------------------------------------
-- Sets up the variable "KLHTM_Gui". It contains (a) references to the gui
-- components, (b) visibility data, (c) string widths, (d) some colours.
------------------------------------------------------------------------------
function KLHTM_CreateGuiTable()
	
	gui.frame = KLHTM_Frame;
	gui.topdiv = KLHTM_FrameTopDivider;
	gui.bottomdiv = KLHTM_FrameBottomDivider;
	
	KLHTM_CreateTitleTable();
	KLHTM_CreateRaidTable();
	KLHTM_CreateSelfTable();
	KLHTM_CreateOptionsTable();
end


------------------------------------------------------------------------------
-- Applies Gui component properties that are not specified in the XML.
------------------------------------------------------------------------------
function KLHTM_SetupGuiComponents()
	
	KLHTM_SetupTitleGui();
	KLHTM_SetupRaidGui();
	KLHTM_SetupSelfGui();
	KLHTM_SetupOptionsGui();
	
	-- frame
	gui.frame:RegisterForDrag("LeftButton");
	gui.frame:SetMovable(true);
	gui.frame:SetUserPlaced(true);
	gui.frame:SetBackdropColor(0.1, 0.1, 0.1);
	gui.frame:SetBackdropBorderColor(1, 1, 1);
end


------------------------------------------------------------------------------
-- Initialises the local variable "options". It contains settings describing
-- how the self and data windows and the title bar should be displayed.
------------------------------------------------------------------------------
function KLHTM_SetDefaultOptions()
	
	options.scale = KLHTM_Scale.default;
	
	KLHTM_SetDefaultRaidOptions();
	KLHTM_SetDefaultSelfOptions();
	KLHTM_SetDefaultTitleOptions();
end


------------------------------------------------------------------------------
-- Initialises the local variable "state", containing GUI display properties
------------------------------------------------------------------------------
function KLHTM_SetDefaultState()
	
	state.min = false;
	state.max = true;
	state.minmax = "max";
	
	state.raid = true;
	state.self = false;
	state.view = "raid";
	
	state.pinned = false;
	state.closed = false;
end


------------------------------------------------------------------------------
-- Changes the raid \ self view.
--
-- [newView] - either "self" or "raid"
------------------------------------------------------------------------------
function KLHTM_SetView(newView)
	
	if ((newView ~= "self") and (newView ~= "raid")) then
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to SetView is not recognised.", tostring(newView)))
		end
		return;
	end
	
	state.view = newView;
	state.raid = not state.raid;
	state.self = not state.self;
	
	KLHTM_Redraw(true);
	
	local col = KLHTM_TitleBarColours[state.view];	
	gui.title.back:SetGradientAlpha("VERTICAL", col.minR, col.minG, col.minB, col.minA, col.maxR, col.maxG, col.maxB, col.maxA);
	
	KLHTM_UpdateTitleButtons();
	KLHTM_UpdateTitleStrings();
	KLHTM_UpdateFrame();
end


------------------------------------------------------------------------------
-- Changes the minimised \ maximised state.
--
-- [newMinMax] - either "min" or "max"
------------------------------------------------------------------------------
function KLHTM_SetMinMax(newMinMax)
	
	if ((newMinMax ~= "min") and (newMinMax ~= "max")) then
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to SetMinMax is not recognised.", tostring(newMinMax)))
		end
		return;
	end
	
	state.minmax = newMinMax;
	state.min = not state.min;
	state.max = not state.max;
	
	KLHTM_Redraw(true);
	
	KLHTM_UpdateTitleButtons();
	KLHTM_UpdateTitleStrings();
	KLHTM_UpdateFrame();
end


------------------------------------------------------------------------------
-- Sets the frame visibility. Should this method even exist?
--
-- [newVisible] - set to true to show the frame
------------------------------------------------------------------------------
function KLHTM_SetVisible(newVisible)
	
	if ((newVisible ~= false) and (newVisible ~= true)) then
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument to '%s' to SetVisible is not recognised.", tostring(newVisible)))
		end
	end
	
	state.closed = not newVisible;
	
	if (newVisible) then
		KLHTM_Redraw(true);
		gui.frame:Show();
	else
		gui.frame:Hide();
	end
end


------------------------------------------------------------------------------
-- Changes the global scale of the main frame.
--
-- [newScale] - a value between 0.5 and 1.2
------------------------------------------------------------------------------
function KLHTM_SetGuiScale(newScale)
	
	local argument = newScale
	newScale = tonumber(newScale);
	
	if (newScale == nil) then
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to SetGuiScale is not a number.", tostring(argument)))
		end
		return;
	end
	
	if ((newScale < KLHTM_Scale.min) or (newScale > KLHTM_Scale.max)) then
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to SetGuiScale is outside the valid bounds.", newScale))
		end
		return;
	end
	
	-- maintain the top-right corner when resizing
	local right = gui.frame:GetRight();
	local top = gui.frame:GetTop();
	
	gui.frame:SetScale(newScale);
	
	if ((top ~= nil) and (right ~= nil)) then
		top = top * options.scale / newScale;
		right = right * options.scale / newScale;
		gui.frame:ClearAllPoints();
		gui.frame:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", right, top);
	else
		-- should occur the first time the mod is loaded
		gui.frame:ClearAllPoints();
		gui.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
	end
	
	options.scale = newScale;
end


------------------------------------------------------------------------------
-- Add an black outline to the specified FontString. This increases its 
-- legibility when viewed on a light background, eg the self view bars. It is
-- normally able to be specified via the XML, but this is not possible due to 
-- compatibility reasons with some localisations. The default minimim ouline is
-- very dark and overpowering, so the shadow's alpha is reduced (to 0, but there
-- seems to be a minimum value).
--
-- [fontstring] - a GUI FontString object
------------------------------------------------------------------------------
function KLHTM_AddOutline(fontstring)
	
	local path, height;
	path, height = fontstring:GetFont();
	
	fontstring:SetFont(path, height, "OUTLINE");
	fontstring:SetShadowColor(0,0,0,0.3);
end


------------------------------------------------------------------------------
-- Increases the space allocated to the specified string to match the localised
-- string width.
--
-- [stringData] - a table containing a [width] element and a [text] element.
-- the latter should be a FontString whose text has been set.
------------------------------------------------------------------------------
function KLHTM_LocaliseStringWidth(stringData)
	
	local width = math.ceil(stringData.text:GetStringWidth());
	
	if (width > stringData.width) then
		
		local newValue = math.min(width, stringData.width * Max_Localisation_Factor);
		
		if mod.out.checktrace("info", me, "resizing") then
			mod.out.printtrace(string.format("Extending the width of %s from %s to %s.", stringData.frame:GetName(), stringData.width, newValue))
		end
		
		stringData.width = newValue;
	end
end

------------------------------------------------------------------------------
-- Repositions the frame in the center of the screen and shows it.
------------------------------------------------------------------------------
function KLHTM_ResetFrame()
	
	local scale = options.scale;
	
	gui.frame:SetScale(1);
	gui.frame:ClearAllPoints();
	gui.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
	
	KLHTM_SetGuiScale(scale);
	KLHTM_SetVisible(true);
end

------------------------------------------------------------------------------
-- Updates the visibility of the data tables, and recalculates the frame bounds.
-- Should be called whenever the sizes of the subframes changes. ie:
--
-- a) view changes
-- b) minmax changes
-- c) column visibility changes
-- d) command button visibility changes
--
-- This method uses the widths calculated by the other methods such as 
-- Update...Table(), UpdateTitleButtons() and UpdateTitleStrings() which
-- should be called prior to this method when the affected gui components are 
-- changed.
--
-- When the frame is maximised, its width is determined by the visible data frame.
-- If it is smaller than the title bar's preferred width, then overlap can
-- occur between the title bar strings and buttons. In this case the default
-- string is replaced by the short version.
------------------------------------------------------------------------------
function KLHTM_UpdateFrame()
	
	-- raid frame
	if (state.max and state.raid) then
		sizes.frame.x = sizes.raid.x;
		gui.raid.frame:Show();
		-- height is set by the redraw method
	else
		gui.raid.frame:Hide();
	end
	
	-- self frame
	if (state.max and state.self) then
		sizes.frame.x = sizes.self.x;
		gui.self.frame:Show();
		-- height is set by the redraw method
	else
		gui.self.frame:Hide();
	end
	
	-- title frame
	sizes.title.x = sizes.string.x + sizes.but.x;
	sizes.title.y = math.max(sizes.string.y, sizes.but.y);
	gui.title.frame:SetHeight(sizes.title.y);
	
	if (state.min) then
		sizes.frame.y = sizes.title.y;
		sizes.frame.x = sizes.title.x;
		gui.frame:SetHeight(sizes.frame.y + 10); -- 10?
	end
	
	-- maintain the top-right corner when resizing
	local right = gui.frame:GetRight();
	local top = gui.frame:GetTop();
	
	gui.frame:SetWidth(sizes.frame.x + 12); -- 12: 5 inset + 1 gap * 2 for each side.
	
	if ((top ~= nil) and (right ~= nil)) then
		gui.frame:ClearAllPoints();
		gui.frame:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", right, top);
	else
		-- harmless, occurs once at startup
	end
	
	-- check for lack of horizontal space in the title bar
	if (state.max) then
		if (sizes.title.x > sizes.frame.x) then
			gui.title.string.short.frame:SetWidth(gui.title.string.short.width);
			gui.title.string.short.frame:Show();
			gui.title.string.long.frame:SetWidth(0.1);
			gui.title.string.long.frame:Hide();
		else
			gui.title.string.short.frame:SetWidth(0.1);
			gui.title.string.short.frame:Hide();
			gui.title.string.long.frame:SetWidth(gui.title.string.long.width);
			gui.title.string.long.frame:Show();
		end
		-- sometimes the anchors aren't reapplied. Not sure if this is needed now
		-- that the raid and self titles have been replaced
		gui.title.string.short.frame:GetLeft();
		gui.title.string.long.frame:GetLeft();
	end
	
end


------------------------------------------------------------------------------
-- Notifies the GUI that the frame should be updated. The frame will be redrawn
-- within Min_Redraw_Period seconds. Should be called by data-receiving modules,
-- eg networking and combat. 
--
-- [view] - set to "raid" or "self" to prevent redraw if it does not match
-- 			[state.view]. Ignored if nil.
------------------------------------------------------------------------------
function KLHTM_RequestRedraw(view)
	
	if ((view ~= nil) and (view ~= state.view)) then
		return;
	end
	if (state.closed) then
		needsRedraw = false;
		return;
	end
	
	needsRedraw = true;
end


KLHTM_RedrawDebug = {0,0,0,0,0,0,0,0,0,0};
_redrawindex = 1;
------------------------------------------------------------------------------
-- Redraws the data table contents, if needed. The redraw will only occur if:
--
-- a) [needsRedraw] is true. This is set by data-receiving modules via
-- KLHTM_RequestRedraw()
-- b) The last update was at least Min_Redraw_Period seconds ago
-- c) the frame is visible and initialised
--
-- This method is automatically called via KLHTM_GuiOnUpdate in order to track
-- processor usage. It should not be called externally; use KLHTM_RequestRedraw()
-- instead.
--
-- [forceRedraw] - if true, bypasses conditions (a) and (b) above. Use this 
-- before updating GUI element visibility to prevent flickering.
------------------------------------------------------------------------------
function KLHTM_Redraw(forceRedraw)
	
	if (not isInitialised) then
		return;
	end
	
	if (forceRedraw ~= true) then
		if ((GetTime() - lastRedraw) < Min_Redraw_Period) then
			return;
		end
		if (needsRedraw == false) then
			return;
		end
	end
	
	-- some debugging to check frequency of redraws
	KLHTM_RedrawDebug[_redrawindex] = GetTime() - lastRedraw;
	_redrawindex = _redrawindex + 1;
	if (_redrawindex == 11) then
		_redrawindex = 1;
	end
	
	lastRedraw = GetTime();
	needsRedraw = false;
	
	-- draw stuff... ? NO!
	if (state.raid) then
		KLHTM_DrawRaidFrame();
	else
		KLHTM_DrawSelfFrame();
	end
end

------------------------------------------------------------------------------
-- Abbreviates large number with the "k" suffix. Works on positive and negative
-- numbers. Non-numbers are returned as is.
------------------------------------------------------------------------------
function KLHTM_Abbreviate(input)
	
	if (type(input) ~= "number") then
		return input;
	end
	
	local isNegative = false;
	if (input < 0) then
		isNegative = true;
		input = -1 * input;
	end
	
	local answer;
	if (input < 10000) then
		answer = input;
	elseif (input < 100000) then
		answer = math.floor(input / 100 + 0.5) / 10;
		if (math.mod(answer, 1) == 0) then
			answer = answer .. ".0";
		end
		answer = answer .. "k";
	else
		answer = math.floor(input / 1000 + 0.5) .. "k";
	end
	
	if (isNegative) then
		answer = "-" .. answer;
	end
	return answer;
end


------------------------------------------------------------------------------
-- Frame dragging
------------------------------------------------------------------------------
function KLHTM_Frame_OnDragStart()
	if (gui.frame:IsMovable() and (state.pinned == false)) then 
		gui.frame:StartMoving();
	end
end
function KLHTM_Frame_OnDragStop()
	gui.frame:StopMovingOrSizing();
end

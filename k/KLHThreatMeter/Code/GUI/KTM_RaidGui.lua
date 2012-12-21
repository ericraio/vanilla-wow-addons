
--[[ KLH Threatmeter KLHTM_RaidGui.lua

Lukon Mod 2: Part of the replacement for Gui.lua and Tables.lua. 
Controls the GUI for the raid threat section of KLH ThreatMeter. 
See also KTM_Gui.xml, KTM_Gui.lua.
--]]

local mod = klhtm
local me = { }
mod.guiraid = me


-- The number of rows defined in New_Frame.xml
local Max_Rows = 20;
KLHTM_MaxRaidRows = Max_Rows;

-- If the top threat value is greater than 150% of aggro gain when no master target is set
-- then the threat100 reference value is set to the top threat value. This prevents very
-- large %threat values when mobs use secondary targetting abilities.
local Max_Aggro_Ratio = 1.5

-- Local references to some Gui variables
local options = KLHTM_GuiOptions;
local gui = KLHTM_Gui;
local sizes = KLHTM_GuiSizes;
local state = KLHTM_GuiState;
local heights = KLHTM_GuiHeights;



------------------------------------------------------------------------------
-- Sets up the instance variable "gui.raid". It contains data on the GUI
-- components in the raid threat frame.
------------------------------------------------------------------------------
function KLHTM_CreateRaidTable()
	
	gui.raid = {
		["frame"] = KLHTM_RaidFrame,
		["line"] = KLHTM_RaidFrameLine, -- dividing line between title bar and frame
		["head"] = { -- column headers
			["name"] = {
				["frame"] = KLHTM_RaidFrameHeaderName,
				["text"] = KLHTM_RaidFrameHeaderNameText,
				["width"] = 90,
				["colour"] = {["r"] = 1.0, ["g"] = 1.0, ["b"] = 1.0},
				["vis"] = function() return (options.raid.columnVis.name) end,
			},
			["threat"] = {
				["frame"] = KLHTM_RaidFrameHeaderThreat,
				["text"] = KLHTM_RaidFrameHeaderThreatText,
				["width"] = 45,
				["colour"] = {["r"] = 1.0, ["g"] = 1.0, ["b"] = 1.0},
				["vis"] = function() return (options.raid.columnVis.threat) end,
			},
			["pc"] = {
				["frame"] = KLHTM_RaidFrameHeaderPercentThreat,
				["text"] = KLHTM_RaidFrameHeaderPercentThreatText,
				["width"] = 40,
				["colour"] = {["r"] = 1.0, ["g"] = 1.0, ["b"] = 1.0},
				["vis"] = function() return (options.raid.columnVis.pc) end,
			},
		},
		["rows"] = {},
		["bottom"] = { -- bottom bar
			["frame"] = KLHTM_RaidFrameBottom,
			["line"] = KLHTM_RaidFrameBottomLine, -- dividing line between frame and bottom bar
			["tdef"] = {
				["frame"] = KLHTM_RaidFrameBottomThreatDefecit,
				["text"] = KLHTM_RaidFrameBottomThreatDefecitText,
				["width"] = 40,
			},
			["targ"] = {
				["frame"] = KLHTM_RaidFrameBottomMasterTarget,
				["text"] = KLHTM_RaidFrameBottomMasterTargetText,
				--["width"] = 50,
				-- should take up whatever remaining space there is
			},
		},
	};
	
	for x = 1 , Max_Rows do
		gui.raid.rows[x] = {
			["frame"] = getglobal("KLHTM_RaidFrameRow" .. x),
			["name"] = {
				["frame"] = getglobal("KLHTM_RaidFrameRow" .. x .. "Name"),
				["text"] = getglobal("KLHTM_RaidFrameRow" .. x .. "NameText"),
			},
			["threat"] = {
				["frame"] = getglobal("KLHTM_RaidFrameRow" .. x .. "Threat"),
				["text"] = getglobal("KLHTM_RaidFrameRow" .. x .. "ThreatText"),
			},
			["pc"] = {
				["frame"] = getglobal("KLHTM_RaidFrameRow" .. x .. "PercentThreat"),
				["text"] = getglobal("KLHTM_RaidFrameRow" .. x .. "PercentThreatText"),
			},
			["bar"] = getglobal("KLHTM_RaidFrameRow" .. x .. "Bar"),
		};
	end
end


------------------------------------------------------------------------------
-- Applies Gui component properties that are not specified in the XML
------------------------------------------------------------------------------
function KLHTM_SetupRaidGui()
	
	-- headers
	for index, header in gui.raid.head do
		header.text:SetText(mod.string.get("gui", "raid", "head", index));
		header.frame:SetHeight(heights.header);
		KLHTM_AddOutline(header.text);
		KLHTM_LocaliseStringWidth(header);
		
		for _, row in gui.raid.rows do
			row[index].text:SetTextColor(header.colour.r, header.colour.g, header.colour.b);
			row[index].frame:SetHeight(heights.data);
			KLHTM_AddOutline(row[index].text);
		end
	end
	
	-- rows
	for _, row in gui.raid.rows do
		row.frame:SetHeight(heights.data);
	end
	
	-- botton bar
	gui.raid.bottom.frame:SetHeight(heights.data);
	gui.raid.bottom.tdef.frame:SetHeight(heights.data);
	gui.raid.bottom.targ.frame:SetHeight(heights.data);
end


------------------------------------------------------------------------------
-- Sets the default options for displaying the main window and title bar strings
-- when the raid view is selected.
------------------------------------------------------------------------------
function KLHTM_SetDefaultRaidOptions()
	
	options.raid = {
		-- column visibility
		["columnVis"] = {
			["name"] = true,
			["threat"] = true,
			["pc"] = true,
		},
		-- title bar string visibility
		["stringVis"] = {
			["rank"] = false,
			["pc"] = false,
			["tdef"] = false,
		},
		-- max number of rows to show
		["rows"] = 10,
		-- if true, rows with 0 threat are not shown
		["hideZeroRows"] = true,
		-- if true, the raid window will shrink if there are fewer data rows
		-- than the specified in ["rows"]. Otherwise empty rows will be shown.
		["resize"] = false,
		-- if true, numbers 10,000 or greater are abbreviated with "k"
		["abbreviate"] = false,
		-- if true, a virtual player "aggro gain" is shown
		["showAggroGain"] = true,
		-- if true, the bottom bar will not be shown
		["hideBottomBar"] = false,
	};
end


------------------------------------------------------------------------------
-- Updates the visibility of columns the raid table and the bottom bar. The
-- contents are not rendered here. The frame width is stored in sizes.self.x.
-- Should be called: 
--
-- a) when the column visibility changes
-- b) when the number of rows to be drawn changes
------------------------------------------------------------------------------
function KLHTM_UpdateRaidFrame()
	
	sizes.raid.x = 0;
	
	for column, header in gui.raid.head do
		-- header
		if (header.vis()) then
			header.frame:SetWidth(header.width);
			sizes.raid.x = sizes.raid.x + header.width;
			header.frame:Show();
		else
			header.frame:Hide();
			header.frame:SetWidth(0.1);
		end
		-- rows
		for index, row in gui.raid.rows do
			if (header.vis()) then
				row[column].frame:SetWidth(header.width);
				row[column].frame:Show();
			else
				row[column].frame:Hide();
				row[column].frame:SetWidth(0.1);
			end
		end
	end
	
	for _, row in gui.raid.rows do
		row.frame:SetWidth(sizes.raid.x);
	end
	
	-- bottom bar
	gui.raid.bottom.tdef.frame:SetWidth(gui.raid.bottom.tdef.width);
	-- do we need this now that we have dual anchors?
	gui.raid.bottom.targ.text:SetWidth(gui.raid.bottom.targ.frame:GetWidth());
	
	if (options.raid.hideBottomBar) then
		gui.raid.bottom.frame:Hide();
	else
		gui.raid.bottom.frame:Show();
	end
end


------------------------------------------------------------------------------
-- Draws the minimised title bar strings present in the raid view.
------------------------------------------------------------------------------
function KLHTM_DrawRaidStrings(raidData, playerCount, threat100)
	
	-- update title bar strings
	local userThreat = mod.table.raiddata[UnitName("player")];
	if userThreat == nil then
		userThreat = 0
	end
	
	-- threat defecit (todo: colours?)
	local defecit = threat100 - userThreat;
	if (options.raid.abbreviate) then
		defecit = KLHTM_Abbreviate(defecit);
	end
	
	-- threat rank
	local userRank = 1;
	for _, data in raidData do
		if (data.threat > userThreat) then
			userRank = userRank + 1;
		end
	end
	
	if (threat100 == 0) then
		gui.title.string.tdef.text:SetText("0");
		gui.title.string.pc.text:SetText("0%");
		gui.title.string.rank.text:SetText("-/" .. playerCount);
	else
		gui.title.string.tdef.text:SetText(defecit);
		gui.title.string.pc.text:SetText(math.floor(userThreat * 100 / threat100 + 0.5) .. "%");
		gui.title.string.rank.text:SetText(userRank .. "/" .. playerCount);
	end
end


------------------------------------------------------------------------------
-- Draws raid the bottom bar strings
--
-- [data] - the sorted threat data
-- [threat100] - ??

-- help i am broken.
------------------------------------------------------------------------------
function KLHTM_DrawRaidBottom(data, threat100, playerCount, userThreat)
	
	-- master target
	if (mod.boss.mastertarget ~= nil) then
		gui.raid.bottom.targ.text:SetText(mod.boss.mastertarget);
	else
		gui.raid.bottom.targ.text:SetText("");
	end
	
	-- new threat defecit ... maybe... 
	if (false) then
		if ((mod.boss.mastertarget ~= nil) and (mod.boss.mttruetarget ~= nil) and
			(mod.tables.raiddata[mod.boss.mttruetarget] ~= nil)) then
			-- there is an active, valid master target and targettarget
			
			if (mod.boss.mttruetarget == UnitName("player")) then
				-- we are the MT. either someone above us, or below us
			end
		end
	end
	
	
	
	-- threat defecit. Several options here. (a) we are MT, show distance to no2. 
	-- (b) we are dps, show defecit from MT \ aggro gain. (c) all zero.
	-- How do we know what threat100 is referring to?
	
	local defecit = threat100 - userThreat;
	if (defecit == 0) then
		defecit = "";
	elseif (options.raid.abbreviate) then
		defecit = KLHTM_Abbreviate(defecit);
	end
	gui.raid.bottom.tdef.text:SetText(defecit);
	
	
	
end


-- used by GetRaidData(). Defined at the class level to reduce memory use.
local GetRaidData_data;
------------------------------------------------------------------------------
-- Makes a copy of the raid threat data from KLHTM_RaidData for use by 
-- KLHTM_DrawRaidFrame and performs some processing.
--
-- returns:
-- [data] - the sorted threat data (with zero-pruning only),
-- [playerCount] - the number of preporting players (virtual and real),
-- [threat100] - the reference value for %max threat calculations
------------------------------------------------------------------------------
function KLHTM_GetRaidData()
	
	local data = GetRaidData_data;
	
	if (data == nil) then
		data = {};
		-- 50: 40 players + room for "virtual players" eg aggro gain
		for x = 1, 50 do 
			data[x] = {["name"] = "", ["threat"] = 0, ["pc"] = 0,};
		end
		
		GetRaidData_data = data
	end
	
	-- check for aggro gain
	if (options.raid.showAggroGain) then
		mod.boss.updateaggrogain()
	else
		mod.table.raiddata[mod.string.get("misc", "aggrogain")] = nil;
	end
	
	-- copy data over
	local rowCount = 0; -- the number of rows to be rendered
	local playerCount = 0; -- the number of players found
	
	for player, threat in mod.table.raiddata do
		playerCount = playerCount + 1;
		
		-- omit "zero rows" if necessary
		if (not(options.raid.hideZeroRows and (threat == 0))) then
			rowCount = rowCount + 1;
			data[rowCount].name = player;
			data[rowCount].threat = threat;
		end
	end
	table.setn(data, rowCount);
	
	table.sort(data, function(a,b) return a.threat > b.threat; end); 
	
	-- determine the %threat reference value
	-- this part is highly suspect. Need the updated boss module, then a recode
	-- of the threat100 and related calculations.
	local threat100; local aggro;
	
	if (rowCount == 0) then
		-- there is no data availible
		threat100 = 0;
	else
		if (options.raid.showAggroGain == false) then
			-- ignore aggro gain. Wrong!
			threat100 = data[1].threat;
		else
			-- use MT if possible, or targettarget
			if (mod.boss.mastertarget == nil) then
				aggro = mod.table.raiddata[mod.string.get("misc", "aggrogain")];
			else
				aggro = mod.table.raiddata[mod.boss.mttruetarget];
			end
			-- ignore unreasonable threat100 values
			if ((aggro == nil) or (aggro * Max_Aggro_Ratio < data[1].threat)) then
				threat100 = data[1].threat;
			else
				threat100 = aggro;
			end
		end
	end
	
	return data, playerCount, threat100;
end


------------------------------------------------------------------------------
-- Updates the raid threat window (if maximised) and title bar raid strings.
-- Updates the raid threat data. A copy of KLHTM_RaidData is made, and processed.
-- If minimised, KLHTM_DrawRaidStrings is called. Otherwise all the strings in
-- the raid frame are redrawn.
------------------------------------------------------------------------------
function KLHTM_DrawRaidFrame()
	
	local data, playerCount, threat100 = KLHTM_GetRaidData();
	
	if (state.min) then
		KLHTM_DrawRaidStrings(data, playerCount, threat100);
		return;
	end
	
	local userThreat = mod.table.raiddata[UnitName("player")];
	if (userThreat == nil) then
		-- seems to happen at initialisation
		userThreat = 0;
	end
	
	-- make sure the user is visible (user may not show up with 0 threat)
	if (table.getn(data) > options.raid.rows) then
		if (userThreat < data[options.raid.rows].threat) then
			data[options.raid.rows].name = UnitName("player");
			data[options.raid.rows].threat = userThreat;
		end
		
		-- ignore rows that won't be drawn from here on
		table.setn(data, options.raid.rows);
	end
	
	-- calculate % threat
	for x = 1, table.getn(data) do
		if (threat100 == 0) then
			data[x].pc = 0;
		else
			data[x].pc = math.floor(data[x].threat / threat100 * 100);
		end
	end

	-- bar reference width (max threat)
	local barRef;
	if ((data[1] ~= nil) and (data[1].threat ~= 0)) then
		barRef = sizes.raid.x / data[1].threat;
	end
	
	-- render the rows
	for row = 1, table.getn(data) do
		for index, value in data[row] do
			if (options.raid.abbreviate) then
				gui.raid.rows[row][index].text:SetText(KLHTM_Abbreviate(value));
			else
				gui.raid.rows[row][index].text:SetText(value);
			end
		end
		-- bars
		if ((barRef == nil) or (data[row].threat == 0)) then
			gui.raid.rows[row].bar:Hide();
		else
			local colours = KLHTM_GetClassColours(data[row].name);
			gui.raid.rows[row].bar:SetWidth(data[row].threat * barRef);
			gui.raid.rows[row].bar:SetVertexColor(colours.r, colours.g, colours.b);
			gui.raid.rows[row].bar:Show();
		end
		gui.raid.rows[row].frame:Show();
	end
	
	-- bottom bar
	if (options.raid.hideBottomBar ~= true) then
		KLHTM_DrawRaidBottom(data, threat100, playerCount, userThreat);
	end

	-- hide empty rows
	for row = table.getn(data) + 1, Max_Rows do
		gui.raid.rows[row].frame:Hide();
	end
	
	-- resize frame
	if (options.raid.resize) then
		sizes.raid.y = heights.header + heights.data * table.getn(data);
	else
		sizes.raid.y = heights.header + heights.data * options.raid.rows;
	end
	
	if (options.raid.hideBottomBar ~= true) then
		sizes.raid.y = sizes.raid.y + heights.data + 2;
	end
	
	-- 14: (5 + 1) * 2 for the insets plus a gap. 
	-- Then 2 each for the title-header, header-data and (optional) data-bottom gaps.
	sizes.frame.y = sizes.raid.y + sizes.title.y + 14;
	gui.frame:SetHeight(sizes.frame.y);
end


-- used to unlocalise class names
local _classes = {"warrior", "druid", "priest", "shaman", "mage", "warlock", "rogue", "hunter", "paladin"}

------------------------------------------------------------------------------
-- Returns the class colours of the specified player
--
-- [return]: A table with .r, .g, .b values from 0 to 1.
------------------------------------------------------------------------------
function KLHTM_GetClassColours(playerName)
	
	local className;
	
	-- apply pre-defined colours
	if (playerName == UnitName("player")) then
		return {["r"] = 1.0, ["g"] = 0, ["b"] = 0};
	end
	
	if (playerName == mod.string.get("misc", "aggrogain")) then
		return {["r"] = 0, ["g"] = 0, ["b"] = 1.0};
	end
	
	className = mod.table.raidclasses[playerName];
	
	if (className == nil) then
		-- the player's class isnt stored in our table, rebuild it.
		if mod.out.checktrace("info", me, "raidcolours") then
			mod.out.printtrace(string.format("Updating class entry for %s.", playerName));
		end
		
		mod.table.redoraidclasses();
		className = mod.table.raidclasses[playerName];
	end
	
	if (className == nil) then
		-- class name could not be found. Seems to be due to people who have left
		-- the raid group?
		if mod.out.checktrace("warning", me, "raidcolours") then
			mod.out.printtrace(string.format("Updating class entry for %s.", playerName))
		end
		
		mod.table.raidclasses[playerName] = "";
		className = "";
	end
	
	className = string.upper(className)
	
	if (className == "") then
		return {["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5};
	else
		return RAID_CLASS_COLORS[className];
	end
end


------------------------------------------------------------------------------
-- Called when the user mouses over a raid string
------------------------------------------------------------------------------
function KLHTM_RaidString_OnEnter(name)
	
	if (name == "targ") then
		if (mod.boss.mastertarget ~= nil) then
			
			local text = string.format(mod.string.get("gui", "raid", "stringlong", name),
				mod.boss.mastertarget); 
				
			text = string.format("|cffffc900%s\n|r%s",
				mod.string.get("gui", "raid", "stringshort", name), text);

			GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", -100, 0);
			GameTooltip:SetText(text, 1.0, 1.0, 1.0, 1, 1);
			GameTooltip:Show();
			gui.raid.bottom[name].text:SetTextColor(1.0, 0.82, 0);
		end
	end
	
	-- threat defecit text disabled for the moment
end

function KLHTM_RaidString_OnLeave(name)
	gui.raid.bottom[name].text:SetTextColor(1.0, 1.0, 1.0);
	GameTooltip:Hide();
end
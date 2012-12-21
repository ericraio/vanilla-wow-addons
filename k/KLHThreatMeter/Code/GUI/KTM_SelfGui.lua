
--[[ KLH Threatmeter KLHTM_SelfGui.lua

Lukon Mod 2: Part of the replacement for Gui.lua and Tables.lua. 
Controls the GUI for the personal threat details section of KLH 
ThreatMeter. See also KTM_Gui.xml, KTM_Gui.lua.
--]]

local mod = klhtm
local me = { }
mod.guiself = me 

-- The number of rows defined in New_Frame.xml
local Max_Rows = 15;

-- Local references to some Gui variables
local options = KLHTM_GuiOptions;
local gui = KLHTM_Gui;
local sizes = KLHTM_GuiSizes;
local state = KLHTM_GuiState;
local heights = KLHTM_GuiHeights;


------------------------------------------------------------------------------
-- Sets up the instance variable "gui.self". It contains data on the GUI
-- components in the personal threat details frame.
------------------------------------------------------------------------------
function KLHTM_CreateSelfTable()
	
	gui.self = {
		["frame"] = KLHTM_SelfFrame,
		["line"] = KLHTM_SelfFrameLine, -- dividing line between title bar and frame
		["head"] = { -- column headers
			["name"] = {
				["frame"] = KLHTM_SelfFrameHeaderName,
				["text"] = KLHTM_SelfFrameHeaderNameText,
				["width"] = 90,
				["colour"] = {["r"] = 1.0, ["g"] = 1.0, ["b"] = 1.0},
				["vis"] = function() return (options.self.columnVis.name) end,
			},
			["hits"] = {
				["frame"] = KLHTM_SelfFrameHeaderHits,
				["text"] = KLHTM_SelfFrameHeaderHitsText,
				["width"] = 35,
				["colour"] = {["r"] = 0.5, ["g"] = 0.9, ["b"] = 0.5},
				["vis"] = function() return (options.self.columnVis.hits) end,
			},
			["rage"] = {
				["frame"] = KLHTM_SelfFrameHeaderRage,
				["text"] = KLHTM_SelfFrameHeaderRageText,
				["width"] = 35,
				["colour"] = {["r"] = 0.9, ["g"] = 0.5, ["b"] = 0.5},
				["vis"] = function() return (options.self.columnVis.rage) end,
			},
			["dam"] = {
				["frame"] = KLHTM_SelfFrameHeaderDamage,
				["text"] = KLHTM_SelfFrameHeaderDamageText,
				["width"] = 55,
				["colour"] = {["r"] = 0.9, ["g"] = 0.9, ["b"] = 0.3},
				["vis"] = function() return (options.self.columnVis.dam) end,
			},
			["threat"] = {
				["frame"] = KLHTM_SelfFrameHeaderThreat,
				["text"] = KLHTM_SelfFrameHeaderThreatText,
				["width"] = 50,
				["colour"] = {["r"] = 0.9, ["g"] = 0.5, ["b"] = 0.9},
				["vis"] = function() return (options.self.columnVis.threat) end,
			},
			["pc"] = {
				["frame"] = KLHTM_SelfFrameHeaderPercentThreat,
				["text"] = KLHTM_SelfFrameHeaderPercentThreatText,
				["width"] = 30,
				["colour"] = {["r"] = 0.9, ["g"] = 0.5, ["b"] = 0.9},
				["vis"] = function() return (options.self.columnVis.pc) end,
			},
		},
		["rows"] = {},
		["bottom"] = { -- self totals
			["frame"] = KLHTM_SelfFrameBottom,
			["line"] = KLHTM_SelfFrameBottomLine, -- dividing line between frame and bottom bar
			["reset"] = {
				-- a dummy frame used to align the bottom bar strings with the Name header
				["frame"] = KLHTM_SelfFrameBottomName,
				-- a dummy element. Referenced here only to be hidden
				["bar"] = KLHTM_SelfFrameBottomBar,
				["but"] = KLHTM_SelfFrameBottomReset,
				["text"] = KLHTM_SelfFrameBottomResetText,
				["width"] = 70,
			},
			["string"] = {
				["hits"] = {
					["frame"] = KLHTM_SelfFrameBottomHits,
					["text"] = KLHTM_SelfFrameBottomHitsText,
				},
				["rage"] = {
					["frame"] = KLHTM_SelfFrameBottomRage,
					["text"] = KLHTM_SelfFrameBottomRageText,
				},
				["dam"] = {
					["frame"] = KLHTM_SelfFrameBottomDamage,
					["text"] = KLHTM_SelfFrameBottomDamageText,
				},
				["threat"] = {
					["frame"] = KLHTM_SelfFrameBottomThreat,
					["text"] = KLHTM_SelfFrameBottomThreatText,
				},
			},
		},
	};
	for x = 1, Max_Rows do
		gui.self.rows[x] = {
			["frame"] = getglobal("KLHTM_SelfFrameRow" .. x);
			["name"] = {
				["frame"] = getglobal("KLHTM_SelfFrameRow" .. x .. "Name"),
				["text"] = getglobal("KLHTM_SelfFrameRow" .. x .. "NameText"),
			},
			["hits"] = {
				["frame"] = getglobal("KLHTM_SelfFrameRow" .. x .. "Hits"),
				["text"] = getglobal("KLHTM_SelfFrameRow" .. x .. "HitsText"),
			},
			["rage"] = {
				["frame"] = getglobal("KLHTM_SelfFrameRow" .. x .. "Rage"),
				["text"] = getglobal("KLHTM_SelfFrameRow" .. x .. "RageText"),
			},
			["dam"] = {
				["frame"] = getglobal("KLHTM_SelfFrameRow" .. x .. "Damage"),
				["text"] = getglobal("KLHTM_SelfFrameRow" .. x .. "DamageText"),
			},
			["threat"] = {
				["frame"] = getglobal("KLHTM_SelfFrameRow" .. x .. "Threat"),
				["text"] = getglobal("KLHTM_SelfFrameRow" .. x .. "ThreatText"),
			},
			["pc"] = {
				["frame"] = getglobal("KLHTM_SelfFrameRow" .. x .. "PercentThreat"),
				["text"] = getglobal("KLHTM_SelfFrameRow" .. x .. "PercentThreatText"),
			},
			["bar"] = getglobal("KLHTM_SelfFrameRow" .. x .. "Bar"),
		};
	end
end


------------------------------------------------------------------------------
-- Applies Gui component properties that are not specified in the XML.
------------------------------------------------------------------------------
function KLHTM_SetupSelfGui()
	
	-- headers and data
	for index, header in gui.self.head do
		header.text:SetText(mod.string.get("gui", "self", "head", index));
		header.frame:SetHeight(heights.header);
		header.text:SetHeight(heights.header);
		KLHTM_AddOutline(header.text);
		KLHTM_LocaliseStringWidth(header);
		
		for _, row in gui.self.rows do
			row[index].text:SetTextColor(header.colour.r, header.colour.g, header.colour.b);
			row[index].frame:SetHeight(heights.data);
			KLHTM_AddOutline(row[index].text);
		end
	end
	
	-- rows
	for _, row in gui.self.rows do
		row.frame:SetHeight(heights.data);
	end
	
	-- bottom
	gui.self.bottom.frame:SetHeight(heights.button);
	
	for _, string in gui.self.bottom.string do
		string.frame:SetHeight(heights.data);
		KLHTM_AddOutline(string.text);
	end
	
	gui.self.bottom.reset.bar:Hide();	
	gui.self.bottom.reset.but:SetHeight(heights.button);
	gui.self.bottom.reset.frame:SetHeight(heights.button);
	gui.self.bottom.reset.but:SetText(mod.string.get("gui", "self", "reset"));
	 
	local width = gui.self.bottom.reset.text:GetStringWidth();
	if (width + 10 > gui.self.bottom.reset.width) then
		gui.self.bottom.reset.width = width + 10;
	end
	
	gui.self.bottom.reset.but:SetWidth(gui.self.bottom.reset.width);
end


------------------------------------------------------------------------------
-- Sets the default options for displaying the main window and title bar strings
-- when the self view is selected.
------------------------------------------------------------------------------
function KLHTM_SetDefaultSelfOptions()
	
	options.self = {
		-- column visibility
		["columnVis"] = { 	
			["name"] = true,
			["hits"] = true,
			["rage"] = false,
			["dam"] = true,
			["threat"] = true,
			["pc"] = true,
		},
		-- title bar string visibility
		["stringVis"] = {	
			["threat"] = true,
		},
		-- if true, rows with 0 threat are not shown
		["hideZeroRows"] = true,
		-- if true, values of at least 10,000 are abbreviate with "k"
		["abbreviate"] = false,
		-- the column used to sort data rows
		["sortColumn"] = "threat",
		-- if true, values increase towards the bottom of the table
		["sortDown"] = true,
	};
	
	-- rage column
	local class;
	_, class = UnitClass("player");
	if ((class == "WARRIOR") or (class == "DRUID")) then
		options.self.columnVis.rage = true;
	end
end


------------------------------------------------------------------------------
-- Updates the visibility of columns the self table and the bottom bar. The
-- contents are not rendered here. The frame width is stored in sizes.self.x.
-- Should be called whenever the column visibility changes.
------------------------------------------------------------------------------
function KLHTM_UpdateSelfFrame()
	
	sizes.self.x = 0;
	
	for column, header in gui.self.head do
		-- header
		if (header.vis()) then
			header.frame:SetWidth(header.width);
			header.text:SetWidth(header.width);
			sizes.self.x = sizes.self.x + header.width;
			header.frame:Show();

		else
			header.frame:Hide();
			header.frame:SetWidth(0.1);
		end
		-- rows
		for index, row in gui.self.rows do
			if (header.vis()) then
				row[column].frame:SetWidth(header.width);
				row[column].frame:Show();
			else
				row[column].frame:Hide();
				row[column].frame:SetWidth(0.1);
			end
		end
	end
	
	-- bottom bar
	for name, string in gui.self.bottom.string do
		if (gui.self.head[name].vis()) then
			string.frame:SetWidth(gui.self.head[name].width);
			string.frame:Show();
		else
			string.frame:Hide();
			string.frame:SetWidth(0.1);
		end
	end
	-- a dummy frame used to align the bottom bar strings with
	-- the Name header
	gui.self.bottom.reset.frame:SetWidth(gui.self.head.name.width);
		
	for _, row in gui.self.rows do
		row.frame:SetWidth(sizes.self.x);
	end
end


------------------------------------------------------------------------------
-- Draws the minimised title bar strings present in the self view.
------------------------------------------------------------------------------
function KLHTM_DrawSelfStrings()
	
	local threat = mod.table.mydata[mod.string.get("threatsource", "total")].threat;
	threat = math.floor(threat + 0.5);
	
	if (options.self.abbreviate) then
		threat = KLHTM_Abbreviate(threat);
	end
	
	gui.title.string.threat.text:SetText(threat);
end


-- used by GetSelfData(). Defined at the class level to reduce memory use.
local GetSelfData_data;
local GetSelfData_totals;
------------------------------------------------------------------------------
-- Makes a copy of the personal threat data in KLHTM_MyData for use by
-- KLHTM_DrawSelfFrame(). KLHTM_MyData contains some non-integers created
-- by the heroic strike approximations - these are rounded off.
------------------------------------------------------------------------------
function KLHTM_GetSelfData()
	
	local data = GetSelfData_data;
	local totals = GetSelfData_totals;

	if (data == nil) then
		data = {};
		totals = {};
		for x = 1, 20 do -- 20: needs to be large enough to fit all the threat sources
						 -- that can be added to mod.table.mydata
			data[x] = {["name"] = "", ["dam"] = 0, ["hits"] = 0, ["rage"] = 0, ["threat"] = 0, ["pc"] = 0,};
		end
	end
	
	local totalData = mod.table.mydata[mod.string.get("threatsource", "total")];
	totals.hits = totalData.hits;
	totals.rage = math.floor(totalData.rage + 0.5); 
	-- nb different index names
	totals.dam = math.floor(totalData.damage + 0.5);
	totals.threat = math.floor(totalData.threat + 0.5); 
	
	-- copy the personal threat data
	local rowCount = 0;
	for ability, info in mod.table.mydata do
		
		-- omit "zero rows" if necessary
		if (not (options.self.hideZeroRows and (info.threat == 0))) then
			if (ability ~= mod.string.get("threatsource", "total")) then
				rowCount = rowCount + 1;
				data[rowCount].name = ability;
				data[rowCount].hits = info.hits;
				data[rowCount].threat = math.floor(info.threat + 0.5); 
				data[rowCount].dam = math.floor(info.damage + 0.5);
				data[rowCount].rage = math.floor(info.rage + 0.5);
				if (totals.threat == 0) then
					data[rowCount].pc = 0;
				else
					data[rowCount].pc = math.floor(data[rowCount].threat / totals.threat * 100);
				end
			end
		end
	end
	table.setn(data, rowCount);
	
	return data, totals
end


------------------------------------------------------------------------------
-- Updates the personal threat details. If the frame is minimised, only a
-- brief call to KLHTM_DrawSelfStrings() is made. Otherwise a copy of
-- KLHTM_MyData is made, processed, and used to redraw all the strings in the
-- Self frame.
------------------------------------------------------------------------------
function KLHTM_DrawSelfFrame()
	
	if (state.min) then
		KLHTM_DrawSelfStrings();
		return;
	end
	
	local data, totals = KLHTM_GetSelfData();

	table.sort(data, KLHTM_CompareSelfRows);

	-- bar reference value
	local barRef;
	
	if (table.getn(data) == 0) then
		barRef = 0;
	elseif (options.self.sortDown) then
		-- set the largest value to 100%
		barRef = data[table.getn(data)][options.self.sortColumn];
	else
		barRef = data[1][options.self.sortColumn];
	end
		
	if ((barRef == nil) or (tonumber(barRef) == nil)) then 
		barRef = 0;
	else
		barRef = sizes.self.x / barRef;
	end

	local barColours = gui.self.head[options.self.sortColumn].colour;
	
	-- truncate excess rows
	if (table.getn(data) > Max_Rows) then
		table.setn(data, Max_Rows);
	end
	
	-- render the rows
	for row = 1, table.getn(data) do
		for index, value in data[row] do
			if (options.self.abbreviate) then
				gui.self.rows[row][index].text:SetText(KLHTM_Abbreviate(value));
			else
				gui.self.rows[row][index].text:SetText(value);
			end
		end
		-- bars
		if ((barRef == 0) or (data[row][options.self.sortColumn] == 0)) then
			gui.self.rows[row].bar:Hide();
		else
			gui.self.rows[row].bar:SetWidth(data[row][options.self.sortColumn] * barRef);
			gui.self.rows[row].bar:SetVertexColor(barColours.r, barColours.g, barColours.b);
			gui.self.rows[row].bar:Show();
		end
		gui.self.rows[row].frame:Show();
	end
	
	-- bottom bar
	for index, string in gui.self.bottom.string do
		if (totals[index] == 0) then
			string.text:SetText("");
		else
			if (options.self.abbreviate) then
				string.text:SetText(KLHTM_Abbreviate(totals[index]));
			else
				string.text:SetText(totals[index]);
			end
		end
	end
	
	-- hide empty rows
	for row = table.getn(data) + 1, Max_Rows do
		gui.self.rows[row].frame:Hide();
	end
	
	-- resize the frame
	sizes.self.y = heights.header + heights.button + heights.data * table.getn(data);
	-- 5 * 2 insets. 1 title gap, 1 row gap, 1 bottom gap
	sizes.frame.y = sizes.self.y + sizes.title.y + 13; 
	gui.frame:SetHeight(sizes.frame.y);
end


------------------------------------------------------------------------------
-- Sorts two rows in the self data table according to the sorting options
------------------------------------------------------------------------------
function KLHTM_CompareSelfRows(row1, row2) 
	
	-- todo: confirm the sign of these comparisoms
	if (options.self.sortDown) then
		return row1[options.self.sortColumn] < row2[options.self.sortColumn];
	else
		return row1[options.self.sortColumn] > row2[options.self.sortColumn];
	end
end

	
------------------------------------------------------------------------------
-- Changes the column used to sort personal threat data
------------------------------------------------------------------------------
function KLHTM_SelfHeader_OnClick(name)
	
	if (name == nil) then
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to SelfHeader_OnClick is unrecognised.", tostring(name)));
		end

		return;
	end
		
	if (name == "pc") then
		-- due to a quirk in the way percent threat is calculated, sorting by threat
		-- should be done via the threat column (see DrawSelfFrame())
		name = "threat";
	end
	
	if (options.self.sortColumn == name) then
		options.self.sortDown = not options.self.sortDown;
	else
		options.self.sortColumn = name;
		options.self.sortDown = true;
	end
	
	KLHTM_Redraw(true);
end

------------------------------------------------------------------------------
-- Called when the used clicks a button in the self view
------------------------------------------------------------------------------
function KLHTM_SelfButton_OnClick(name)
	
	if (name == "reset") then
		mod.table.resetmytable();
		KLHTM_Redraw(true);
	else
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to SelfButton_OnClick is unrecognised.", tostring(name)));
		end
	end
end
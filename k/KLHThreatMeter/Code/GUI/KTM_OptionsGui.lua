
--[[ KLHThreatMeter KTM_OptionsGui.lua

	Controls a Gui for viewing and editing settings on the main window. See also 
	KTM_OptionsFrame.xml, KTM_Gui.lua.
--]]

local mod = klhtm
local me = { }
mod.guiopt = me

-- a table of the Gui components in the options frame
local gui = {};
KLHTM_OptionsGui = gui;

-- Gui options
local options = KLHTM_GuiOptions;

-- options frame visibility information
local state = {
	["closed"] = true, -- false if the frame is visible
	["frame"] = "gen", -- the visible subframe
};

-- the font size of the gui strings
local String_Font_Size = 11;
-- the font size of the button strings
local Button_Font_Size = 10;


------------------------------------------------------------------------------
-- Sets up the instance variable "gui". It contains references to the Options 
-- Gui components 
------------------------------------------------------------------------------
function KLHTM_CreateOptionsTable()

	gui.frame = KLHTM_OptionsFrame;
	
	gui.title = {
		["frame"] = KLHTM_OptionsFrameTitle,
		["back"] = KLHTM_OptionsFrameTitleBackground,
		["text"] = KLHTM_OptionsFrameTitleText,
	};

	gui.gen = {
		["frame"] = KLHTM_OptionsFrameGeneral,
		["otherhead"] = {
			["frame"] = KLHTM_OptionsFrameGeneralHeaderOther,
			["text"] = KLHTM_OptionsFrameGeneralHeaderOtherText,
		},
		["scale"] = {
			["frame"] = KLHTM_OptionsFrameGeneralScale,
			["text"] = KLHTM_OptionsFrameGeneralScaleText,
			["value"] = KLHTM_OptionsFrameGeneralScaleValue,
		},
		-- command button visibility when minimised
		["minvishead"] = {
			["frame"] = KLHTM_OptionsFrameGeneralMinimisedHeader,
			["text"] = KLHTM_OptionsFrameGeneralMinimisedHeaderText,
		},
		["minvis"] = {
			["pin"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMinimisedPin,
				["text"] = KLHTM_OptionsFrameGeneralMinimisedPinText,
			},
			["opt"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMinimisedOptions,
				["text"] = KLHTM_OptionsFrameGeneralMinimisedOptionsText,
			},
			["view"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMinimisedView,
				["text"] = KLHTM_OptionsFrameGeneralMinimisedViewText,
			},
			["targ"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMinimisedMasterTarget,
				["text"] = KLHTM_OptionsFrameGeneralMinimisedMasterTargetText,
			},
			["clear"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMinimisedClearThreat,
				["text"] = KLHTM_OptionsFrameGeneralMinimisedClearThreatText,
			},
		},
		-- command button visibility when maximised
		["maxvishead"] = {
			["frame"] = KLHTM_OptionsFrameGeneralMaximisedHeader,
			["text"] = KLHTM_OptionsFrameGeneralMaximisedHeaderText,
		},
		["maxvis"] = {
			["pin"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMaximisedPin,
				["text"] = KLHTM_OptionsFrameGeneralMaximisedPinText,
			},
			["view"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMaximisedView,
				["text"] = KLHTM_OptionsFrameGeneralMaximisedViewText,
			},
			["targ"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMaximisedMasterTarget,
				["text"] = KLHTM_OptionsFrameGeneralMaximisedMasterTargetText,
			},
			["clear"] = {
				["frame"] = KLHTM_OptionsFrameGeneralMaximisedClearThreat,
				["text"] = KLHTM_OptionsFrameGeneralMaximisedClearThreatText,
			},
		},
	};
	
	gui.self = {
		["frame"] = KLHTM_OptionsFrameSelf,
		-- column visibility
		["colhead"] = {
			["frame"] = KLHTM_OptionsFrameSelfColumnHeader,
			["text"] = KLHTM_OptionsFrameSelfColumnHeaderText,
		},
		["col"] = {
			["hits"] = {
				["frame"] = KLHTM_OptionsFrameSelfColumnHits,
				["text"] = KLHTM_OptionsFrameSelfColumnHitsText,
			},
			["rage"] = {
				["frame"] = KLHTM_OptionsFrameSelfColumnRage,
				["text"] = KLHTM_OptionsFrameSelfColumnRageText,
			},
			["dam"] = {
				["frame"] = KLHTM_OptionsFrameSelfColumnDamage,
				["text"] = KLHTM_OptionsFrameSelfColumnDamageText,
			},
			["threat"] = {
				["frame"] = KLHTM_OptionsFrameSelfColumnThreat,
				["text"] = KLHTM_OptionsFrameSelfColumnThreatText,
			},
			["pc"] = {
				["frame"] = KLHTM_OptionsFrameSelfColumnThreatPercent,
				["text"] = KLHTM_OptionsFrameSelfColumnThreatPercentText,
			},
		},
		["otherhead"] = {
			["frame"] = KLHTM_OptionsFrameSelfOtherHeader,
			["text"] = KLHTM_OptionsFrameSelfOtherHeaderText,
		},
		-- hide zero rows
		["hide"] = {
			["frame"] = KLHTM_OptionsFrameSelfHideZero,
			["text"] = KLHTM_OptionsFrameSelfHideZeroText,
		},
		-- abbreviate large numbers
		["abbreviate"] = {
			["frame"] = KLHTM_OptionsFrameSelfAbbreviate,
			["text"] = KLHTM_OptionsFrameSelfAbbreviateText,
		},
		-- title bar minimised string
		["threat"] = {
			["frame"] = KLHTM_OptionsFrameSelfMinimisedThreat,
			["text"] = KLHTM_OptionsFrameSelfMinimisedThreatText,
		},
	};
	
	gui.raid = {
		["frame"] = KLHTM_OptionsFrameRaid,
		-- column visibility
		["colhead"] = {
			["frame"] = KLHTM_OptionsFrameRaidColumnHeader,
			["text"] = KLHTM_OptionsFrameRaidColumnHeaderText,
		},
		["col"] = {
			["threat"] = {
				["frame"] = KLHTM_OptionsFrameRaidColumnThreat,
				["text"] = KLHTM_OptionsFrameRaidColumnThreatText,
			},
			["pc"] = {
				["frame"] = KLHTM_OptionsFrameRaidColumnThreatPercent,
				["text"] = KLHTM_OptionsFrameRaidColumnThreatPercentText,
			},
		},
		-- minimised string visibility
		["minvishead"] = {
			["frame"] = KLHTM_OptionsFrameRaidMinimisedHeader,
			["text"] = KLHTM_OptionsFrameRaidMinimisedHeaderText,
		},
		["minvis"] = {
			["rank"] = {
				["frame"] = KLHTM_OptionsFrameRaidMinimisedRank,
				["text"] = KLHTM_OptionsFrameRaidMinimisedRankText,
			},
			["pc"] = {
				["frame"] = KLHTM_OptionsFrameRaidMinimisedThreatPercent,
				["text"] = KLHTM_OptionsFrameRaidMinimisedThreatPercentText,
			},
			["tdef"] = {
				["frame"] = KLHTM_OptionsFrameRaidMinimisedDeficit,
				["text"] = KLHTM_OptionsFrameRaidMinimisedDeficitText,
			},
		},
		["otherhead"] = {
			["frame"] = KLHTM_OptionsFrameRaidOtherHeader,
			["text"] = KLHTM_OptionsFrameRaidOtherHeaderText,
		},
		-- hide zero rows
		["hide"] = {
			["frame"] = KLHTM_OptionsFrameRaidHideZero,
			["text"] = KLHTM_OptionsFrameRaidHideZeroText,
		},
		-- max row count
		["rows"] = {
			["frame"] = KLHTM_OptionsFrameRaidRows,
			["text"] = KLHTM_OptionsFrameRaidRowsText,
			["value"] = KLHTM_OptionsFrameRaidRowsValue,
		},
		-- resize
		["resize"] = {
			["frame"] = KLHTM_OptionsFrameRaidResize,
			["text"] = KLHTM_OptionsFrameRaidResizeText,
		},
		-- show aggro gain
		["aggro"] = {
			["frame"] = KLHTM_OptionsFrameRaidAggroGain,
			["text"] = KLHTM_OptionsFrameRaidAggroGainText,
		},
		-- abbreviate large numbers
		["abbreviate"] = {
			["frame"] = KLHTM_OptionsFrameRaidAbbreviate,
			["text"] = KLHTM_OptionsFrameRaidAbbreviateText,
		},
		-- hide bottom bar
		["bottom"] = {
			["frame"] = KLHTM_OptionsFrameRaidHideBottom,
			["text"] = KLHTM_OptionsFrameRaidHideBottomText,
		},
	};
	
	-- command buttons
	gui.but = {
		["gen"] = KLHTM_OptionsFrameControlsGeneral,
		["self"] = KLHTM_OptionsFrameControlsSelf,
		["raid"] = KLHTM_OptionsFrameControlsRaid,
		["close"] = KLHTM_OptionsFrameControlsClose,
	};
end


------------------------------------------------------------------------------
-- Applies Gui component properties that are not specified in the XML. 
------------------------------------------------------------------------------
function KLHTM_SetupOptionsGui()
	
	-- base frame
	gui.frame:RegisterForDrag("LeftButton");
	gui.frame:SetMovable(true);
	gui.frame:SetBackdropColor(0, 0, 0);
	gui.frame:SetBackdropBorderColor(1, 1, 1);
	
	-- command buttons
	for index, button in gui.but do
		button:SetText(mod.string.get("optionsgui", "buttons", index));
	end
	
	-- general frame
	for index, button in gui.gen.minvis do
		button.text:SetText(mod.string.get("optionsgui", "labels", "buttons", index));
	end
	for index, button in gui.gen.maxvis do
		button.text:SetText(mod.string.get("optionsgui", "labels", "buttons", index));
	end
	
	gui.gen.minvishead.text:SetText(mod.string.get("optionsgui", "labels", "headers", "minvis"));
	gui.gen.maxvishead.text:SetText(mod.string.get("optionsgui", "labels", "headers", "maxvis"));
	gui.gen.otherhead.text:SetText(mod.string.get("optionsgui", "labels", "headers", "other"));
	
	gui.gen.scale.frame:SetMinMaxValues(KLHTM_Scale.min * 100, KLHTM_Scale.max * 100);
	gui.gen.scale.frame:SetValueStep(KLHTM_Scale.tick * 100);
	gui.gen.scale.text:SetText(mod.string.get("optionsgui", "labels", "options", "scale"));
	
	-- self frame
	gui.self.colhead.text:SetText(mod.string.get("optionsgui", "labels", "headers", "columns"));
	
	for index, column in gui.self.col do
		column.text:SetText(mod.string.get("optionsgui", "labels", "columns", index));
	end
	
	gui.self.otherhead.text:SetText(mod.string.get("optionsgui", "labels", "headers", "other"));
	gui.self.hide.text:SetText(mod.string.get("optionsgui", "labels", "options", "hide"));
	gui.self.abbreviate.text:SetText(mod.string.get("optionsgui", "labels", "options", "abbreviate"));
	gui.self.threat.text:SetText(mod.string.get("optionsgui", "labels", "minvis", "threat"));
	
	-- raid frame
	gui.raid.colhead.text:SetText(mod.string.get("optionsgui", "labels", "headers", "columns"));
	gui.raid.col.threat.text:SetText(mod.string.get("optionsgui", "labels", "columns", "threat"));
	gui.raid.col.pc.text:SetText(mod.string.get("optionsgui", "labels", "columns", "pc"));
	
	for index, button in gui.raid.minvis do
		button.text:SetText(mod.string.get("optionsgui", "labels", "minvis", index));
	end
	gui.raid.minvishead.text:SetText(mod.string.get("optionsgui", "labels", "headers", "strings"));
	
	gui.raid.otherhead.text:SetText(mod.string.get("optionsgui", "labels", "headers", "other"));
	gui.raid.hide.text:SetText(mod.string.get("optionsgui", "labels", "options", "hide"));
	gui.raid.resize.text:SetText(mod.string.get("optionsgui", "labels", "options", "resize"));
	gui.raid.aggro.text:SetText(mod.string.get("optionsgui", "labels", "options", "aggro"));
	gui.raid.abbreviate.text:SetText(mod.string.get("optionsgui", "labels", "options", "abbreviate"));
	gui.raid.bottom.text:SetText(mod.string.get("optionsgui", "labels", "options", "bottom"));

	gui.raid.rows.text:SetText(mod.string.get("optionsgui", "labels", "options", "rows"));
	gui.raid.rows.frame:SetMinMaxValues(2, KLHTM_MaxRaidRows);
	gui.raid.rows.frame:SetValueStep(1);
	
	-- resize the strings. Due to localisation compatibility issues, this is not possible 
	-- to do via the XML.
	local function resizeGroup(input)
		for _, item in input do
			if (item.text ~= nil) then
				
				local path = item.text:GetFont();
				item.text:SetFont(path, String_Font_Size);
			end
		end
	end
	
	resizeGroup(gui.gen);
	resizeGroup(gui.gen.minvis);
	resizeGroup(gui.gen.maxvis);
	resizeGroup(gui.self);
	resizeGroup(gui.self.col);
	resizeGroup(gui.raid);
	resizeGroup(gui.raid.col);
	resizeGroup(gui.raid.minvis);
	
	-- reduce font size if the buttons aren't large enough
	local needsResize = false;
	
	for index, button in gui.but do
		-- 10: 5 pixels space for each edge
		if (button:GetTextWidth() > button:GetWidth() - 10)  then 
			needsResize = true;
		end
	end
	
	if (needsResize) then
		local path = gui.but.gen:GetFont();
		
		for index, button in gui.but do
			button:SetFont(path, Button_Font_Size);
		end
		if mod.out.checktrace("info", me, "resizing") then
			mod.out.printtrace("Resizing options GUI button fonts");
		end
	end
end


------------------------------------------------------------------------------
-- Sets the states of the options gui components to match the current settings
------------------------------------------------------------------------------
function KLHTM_SyncOptionsGui()
	
	-- general frame
	for index, button in gui.gen.minvis do
		button.frame:SetChecked(options.buttonVis.min[index]);
	end
	for index, button in gui.gen.maxvis do
		button.frame:SetChecked(options.buttonVis.max[index]);
	end
	
	-- scale slider
	local temp = gui.gen.scale.frame:GetScript("OnValueChanged");
	gui.gen.scale.frame:SetScript("OnValueChanged", nil);
	gui.gen.scale.frame:SetValue(options.scale * 100)
	gui.gen.scale.frame:SetScript("OnValueChanged", temp);
	gui.gen.scale.value:SetText(options.scale * 100 .. "%");
	
	-- self frame
	for index, column in gui.self.col do
		column.frame:SetChecked(options.self.columnVis[index]);
	end
	
	gui.self.hide.frame:SetChecked(options.self.hideZeroRows);
	gui.self.abbreviate.frame:SetChecked(options.self.abbreviate);
	gui.self.threat.frame:SetChecked(options.self.stringVis.threat);
	
	-- raid frame
	gui.raid.col.threat.frame:SetChecked(options.raid.columnVis.threat)
	gui.raid.col.pc.frame:SetChecked(options.raid.columnVis.pc)
	
	for index, button in gui.raid.minvis do
		button.frame:SetChecked(options.raid.stringVis[index]);
	end
	
	gui.raid.hide.frame:SetChecked(options.raid.hideZeroRows);
	gui.raid.resize.frame:SetChecked(options.raid.resize);
	gui.raid.aggro.frame:SetChecked(options.raid.showAggroGain);
	gui.raid.abbreviate.frame:SetChecked(options.raid.abbreviate);

	-- rows slider
	local temp = gui.gen.scale.frame:GetScript("OnValueChanged");
	gui.gen.scale.frame:SetScript("OnValueChanged", nil);
	gui.raid.rows.frame:SetValue(options.raid.rows);
	gui.gen.scale.frame:SetScript("OnValueChanged", temp);
	gui.raid.rows.value:SetText(options.raid.rows);
end


------------------------------------------------------------------------------
-- Updates the visibility of the options frame and its subframes
------------------------------------------------------------------------------
function KLHTM_UpdateOptionsFrame()
	
	if (state.closed) then
		gui.frame:Hide();
		return;
	else
		gui.frame:Show();
	end
	
	if (state.frame == "gen") then
		gui.gen.frame:Show();
	else
		gui.gen.frame:Hide();
	end
	
	if (state.frame == "raid") then
		gui.raid.frame:Show();
	else
		gui.raid.frame:Hide();
	end
	
	if (state.frame == "self") then
		gui.self.frame:Show();
	else
		gui.self.frame:Hide();
	end
	
	gui.title.text:SetText(mod.string.get("optionsgui", "labels", "titlebar", state.frame));
	
	local col = KLHTM_TitleBarColours[state.frame];
	gui.title.back:SetGradientAlpha("VERTICAL", col.minR, col.minG, col.minB, col.minA, col.maxR, col.maxG, col.maxB, col.maxA);
end


------------------------------------------------------------------------------
-- Hides or shows the options frame. Called when the user clicks on the options
-- command button on the main frame. If the options frame is being shown, the
-- contents are synchronised with the gui settings.
------------------------------------------------------------------------------
function KLHTM_ToggleOptionsGui()
	
	state.closed = not state.closed;
	if (not state.closed) then
		KLHTM_SyncOptionsGui();
	end
	
	KLHTM_UpdateOptionsFrame();
end


------------------------------------------------------------------------------
-- Called when the used clicks on one of the command buttons
------------------------------------------------------------------------------
function KLHTM_OptionsButton_OnClick(command)
	
	if (command == "General") then
		state.frame = "gen";
		KLHTM_UpdateOptionsFrame();
		
	elseif (command == "Self") then
		state.frame = "self";
		KLHTM_UpdateOptionsFrame();
		
	elseif (command == "Raid") then
		state.frame = "raid";
		KLHTM_UpdateOptionsFrame();
		
	elseif (command == "Close") then
		state.closed = true;
		KLHTM_UpdateOptionsFrame();
		
	else
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to OptionsButton_OnClick is not recognised.", tostring(command)))
		end
	end
end


-- converts the output of a checkbox GetChecked() query (1 or nil) to a boolean
local function ToBoolean(input)
	if (input) then
		return true;
	else
		return false;
	end
end

------------------------------------------------------------------------------
-- Called when the user clicks on a checkbox in the general frame
------------------------------------------------------------------------------
function KLHTM_OptionsGeneral_OnClick(command)
	
	if (command == "MinimisedPin") then
		options.buttonVis.min.pin = ToBoolean(gui.gen.minvis.pin.frame:GetChecked());
		
	elseif (command == "MinimisedView") then
		options.buttonVis.min.view = ToBoolean(gui.gen.minvis.view.frame:GetChecked());
		
	elseif (command == "MinimisedOptions") then
		options.buttonVis.min.opt = ToBoolean(gui.gen.minvis.opt.frame:GetChecked());
	
	elseif (command == "MinimisedMasterTarget") then
		options.buttonVis.min.targ = ToBoolean(gui.gen.minvis.targ.frame:GetChecked());
		
	elseif (command == "MinimisedClearThreat") then
		options.buttonVis.min.clear = ToBoolean(gui.gen.minvis.clear.frame:GetChecked());
		
	elseif (command == "MaximisedPin") then
		options.buttonVis.max.pin = ToBoolean(gui.gen.maxvis.pin.frame:GetChecked());
		
	elseif (command == "MaximisedView") then
		options.buttonVis.max.view = ToBoolean(gui.gen.maxvis.view.frame:GetChecked());
		
	elseif (command == "MaximisedOptions") then
		options.buttonVis.max.opt = ToBoolean(gui.gen.maxvis.opt.frame:GetChecked());
		
	elseif (command == "MaximisedMasterTarget") then
		options.buttonVis.max.targ = ToBoolean(gui.gen.maxvis.targ.frame:GetChecked());
		
	elseif (command == "MaximisedClearThreat") then
		options.buttonVis.max.clear = ToBoolean(gui.gen.maxvis.clear.frame:GetChecked());
			
	else
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to OptionsGeneral_OnClick is not recognised.", tostring(command)))
		end
		return;
	end
	
	KLHTM_UpdateTitleButtons();
	KLHTM_UpdateFrame();
end

------------------------------------------------------------------------------
-- Called when the user adjusts a slider in the general frame
------------------------------------------------------------------------------
function KLHTM_OptionsGeneral_OnValueChanged(command)
	
	if (command == "Scale") then
		KLHTM_SetGuiScale(gui.gen.scale.frame:GetValue() / 100);
		gui.gen.scale.value:SetText(options.scale * 100 .. "%");
	else
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to OptionsGeneral_OnValueChanged is invalid.", tostring(command)))
		end
	end
end

------------------------------------------------------------------------------
-- Called when the user clicks on a checkbox in the self frame
------------------------------------------------------------------------------
function KLHTM_OptionsSelf_OnClick(command)
	
	if (command == "ColumnHits") then
		options.self.columnVis.hits = ToBoolean(gui.self.col.hits.frame:GetChecked());
		
	elseif (command == "ColumnRage") then
		options.self.columnVis.rage = ToBoolean(gui.self.col.rage.frame:GetChecked());
		
	elseif (command == "ColumnDamage") then
		options.self.columnVis.dam = ToBoolean(gui.self.col.dam.frame:GetChecked());
		
	elseif (command == "ColumnThreat") then
		options.self.columnVis.threat = ToBoolean(gui.self.col.threat.frame:GetChecked());
		
	elseif (command == "ColumnThreatPercent") then
		options.self.columnVis.pc = ToBoolean(gui.self.col.pc.frame:GetChecked());
		
	elseif (command == "MinimisedThreat") then
		options.self.stringVis.threat = ToBoolean(gui.self.threat.frame:GetChecked());
		KLHTM_UpdateTitleStrings();
			
	elseif (command == "HideZero") then
		options.self.hideZeroRows = ToBoolean(gui.self.hide.frame:GetChecked());
		
	elseif (command == "Abbreviate") then
		options.self.abbreviate = ToBoolean(gui.self.abbreviate.frame:GetChecked());
		
	else
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to OptionsSelf_OnClick is unrecognised.", tostring(command)))
		end
		return;
	end
	
	KLHTM_UpdateSelfFrame();
	KLHTM_UpdateFrame();
	KLHTM_Redraw(true);
end

------------------------------------------------------------------------------
-- Called when the user clicks on a checkbox in the raid frame
------------------------------------------------------------------------------
function KLHTM_OptionsRaid_OnClick(command)
	
	if (command == "ColumnThreat") then
		options.raid.columnVis.threat = ToBoolean(gui.raid.col.threat.frame:GetChecked());
		KLHTM_Redraw();
		KLHTM_UpdateRaidFrame();
		KLHTM_UpdateFrame();
		
	elseif (command == "ColumnThreatPercent") then
		options.raid.columnVis.pc = ToBoolean(gui.raid.col.pc.frame:GetChecked());
		KLHTM_UpdateRaidFrame();
		KLHTM_UpdateFrame();
		
	elseif (command == "MinimisedRank") then
		options.raid.stringVis.rank = ToBoolean(gui.raid.minvis.rank.frame:GetChecked());
		KLHTM_UpdateTitleStrings();
		KLHTM_UpdateFrame();
		
	elseif (command == "MinimisedDeficit") then
		options.raid.stringVis.tdef = ToBoolean(gui.raid.minvis.tdef.frame:GetChecked());
		KLHTM_UpdateTitleStrings();
		KLHTM_UpdateFrame();
		
	elseif (command == "MinimisedThreatPercent") then
		options.raid.stringVis.pc = ToBoolean(gui.raid.minvis.pc.frame:GetChecked());
		KLHTM_UpdateTitleStrings();
		KLHTM_UpdateFrame();
		
	elseif (command == "HideZero") then
		options.raid.hideZeroRows = ToBoolean(gui.raid.hide.frame:GetChecked());
		
	elseif (command == "Resize") then
		options.raid.resize = ToBoolean(gui.raid.resize.frame:GetChecked());
		
	elseif (command == "Abbreviate") then
		options.raid.abbreviate = ToBoolean(gui.raid.abbreviate.frame:GetChecked());
		
	elseif (command == "AggroGain") then
		options.raid.showAggroGain = ToBoolean(gui.raid.aggro.frame:GetChecked());
		
	elseif (command == "HideBottom") then
		options.raid.hideBottomBar = ToBoolean(gui.raid.bottom.frame:GetChecked());
		KLHTM_UpdateRaidFrame();
		
	else
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to OptionsRaid_OnClick is unrecognised.", tostring(command)))
		end
		return;
	end
	
	KLHTM_Redraw(true);
end


------------------------------------------------------------------------------
-- Called when the user adjusts a slider in the raid frame
------------------------------------------------------------------------------
function KLHTM_OptionsRaid_OnValueChanged(command)
	
	if (command == "Rows") then
		options.raid.rows = gui.raid.rows.frame:GetValue();
		gui.raid.rows.value:SetText(options.raid.rows);
		KLHTM_Redraw(true);
	else
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to OptionsRaid_OnValueChanged is unrecognised.", tostring(command)))
		end
	end
end


------------------------------------------------------------------------------
-- Called when the user mouses-over some of the options frames
------------------------------------------------------------------------------
function KLHTM_Options_OnEnter(name)
	
	local text = mod.string.get("optionsgui", "tooltips", name);
	
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOM");
	GameTooltip:SetText(text, 1.0, 0.82, 0, 1, 1);
	GameTooltip:Show();
end
function KLHTM_Options_OnLeave()
	GameTooltip:Hide();
end


--[[ KLH Threatmeter KLHTM_TitleGui.lua

Lukon Mod 2: Part of the replacement for Gui.lua and Tables.lua. 
Controls the GUI for the title bar of KLH ThreatMeter. See also
KTM_Gui.xml, KTM_Gui.lua.
--]]

local mod = klhtm
local me = { }
mod.guititle = me

-- Local references to some Gui variables
local options = KLHTM_GuiOptions;
local gui = KLHTM_Gui;
local sizes = KLHTM_GuiSizes;
local state = KLHTM_GuiState;
local heights = KLHTM_GuiHeights;

-- the height and width of command buttons
local Button_Size = 18;

------------------------------------------------------------------------------
-- Sets up the instance variable "gui.title". It contains data on the GUI
-- components in the title bar.
------------------------------------------------------------------------------
function KLHTM_CreateTitleTable()
	
	gui.title = {
		["frame"] = KLHTM_TitleFrame,
		["back"] = KLHTM_TitleFrameBackground,
		["but"] = {		-- title bar buttons
			["close"] =  { -- close
				["frame"] = KLHTM_TitleFrameClose,
				["vis"] = function() return ((state.min and options.buttonVis.min.close)
					or (state.max and options.buttonVis.max.close)); end,
			},
			["opt"] = { -- options
				["frame"] = KLHTM_TitleFrameOptions,
				["vis"] = function() return ((state.min and options.buttonVis.min.opt)
					or (state.max and options.buttonVis.max.opt)); end,
			},
			["pin"] = { -- pin
				["frame"] = KLHTM_TitleFramePin,
				["vis"] = function() return ((not state.pinned) and 
					((state.min and options.buttonVis.min.pin)
					or (state.max and options.buttonVis.max.pin))); end,
			},
			["unpin"] = { -- unpin
				["frame"] = KLHTM_TitleFrameUnpin,
				["vis"] = function() return (state.pinned and 
					((state.min and options.buttonVis.min.pin)
					or (state.max and options.buttonVis.max.pin))); end,
			},
			["min"] = { -- minimise
				["frame"] = KLHTM_TitleFrameMinimise,
				["vis"] = function() return (state.max and options.buttonVis.max.minmax); end,
			},
			["max"] = { -- maximise
				["frame"] = KLHTM_TitleFrameMaximise,
				["vis"] = function() return (state.min and options.buttonVis.min.minmax); end,
			},
			["self"] = { -- show personal threat details
				["frame"] = KLHTM_TitleFrameSelfView,
				["vis"] = function() return (state.raid and 
					((state.min and options.buttonVis.min.view)
					or (state.max and options.buttonVis.max.view))); end,
			},
			["raid"] = { -- show raid threat
				["frame"] = KLHTM_TitleFrameRaidView,
				["vis"] = function() return (state.self and 
					((state.min and options.buttonVis.min.view)
					or (state.max and options.buttonVis.max.view))); end,
			},
			["targ"] = { -- master target
				["frame"] = KLHTM_TitleFrameMasterTarget,
				["vis"] = function() return (state.raid and ((state.min and 
					options.buttonVis.min.targ)	or (state.max and 
					options.buttonVis.max.targ))); end,
			},
			["clear"] = { -- raid threat clear
				["frame"] = KLHTM_TitleFrameClearThreat,
				["vis"] = function() return (state.raid and ((state.min and 
					options.buttonVis.min.clear) or (state.max and
					options.buttonVis.max.clear))); end,
			},
		}, -- optional strings
		["string"] = {
			["short"] = { -- a short title
				["frame"] = KLHTM_TitleFrameShortTitle,
				["text"] = KLHTM_TitleFrameShortTitleText,
				["width"] = 35,
				["vis"] = function() return state.min; end,
			},
			["long"] = { -- the maxmiised title
				["frame"] = KLHTM_TitleFrameLongTitle,
				["text"] = KLHTM_TitleFrameLongTitleText,
				["width"] = 60,
				["vis"] = function() return state.max; end,
			},
			["threat"] = { -- your total threat
				["frame"] = KLHTM_TitleFrameThreat,
				["text"] = KLHTM_TitleFrameThreatText,
				["width"] = 45,
				["vis"] = function() return (state.min and state.self and options.self.stringVis.threat); end,
			},
			["tdef"] = { -- thread defecit
				["frame"] = KLHTM_TitleFrameThreatDefecit,
				["text"] = KLHTM_TitleFrameThreatDefecitText,
				["width"] = 40,
				["vis"] = function() return (state.min and state.raid and options.raid.stringVis.tdef); end,
			},
			["pc"] = { -- percent threat
				["frame"] = KLHTM_TitleFrameThreatPercent,
				["text"] = KLHTM_TitleFrameThreatPercentText,
				["width"] = 35,
				["vis"] = function() return (state.min and state.raid and options.raid.stringVis.pc); end,
			},
			["rank"] = { -- threat rank
				["frame"] = KLHTM_TitleFrameThreatRank,
				["text"] = KLHTM_TitleFrameThreatRankText,
				["width"] = 35,
				["vis"] = function() return (state.min and state.raid and options.raid.stringVis.rank); end,
			},
		},
	};
end


------------------------------------------------------------------------------
-- Applies Gui component properties that are not specified in the XML
------------------------------------------------------------------------------
function KLHTM_SetupTitleGui()
	
	-- background
	local col = KLHTM_TitleBarColours[state.view];
	gui.title.back:SetGradientAlpha("VERTICAL", col.minR, col.minG, col.minB, col.minA, col.maxR, col.maxG, col.maxB, col.maxA);
	
	-- buttons
	for _, button in gui.title.but do
		button.frame:SetHeight(Button_Size);
	end
	
	-- strings
	for x, string in gui.title.string do
		if string.frame == nil then
			mod.out.print(x)
		end
	
		string.frame:SetHeight(heights.string);
		string.frame:RegisterForDrag("LeftButton");
	end
	
	gui.title.string.long.text:SetText(string.format(mod.string.get("gui", "title", "text", "long"), mod.release, mod.revision));
	gui.title.string.short.text:SetText(mod.string.get("gui", "title", "text", "short"));
	KLHTM_LocaliseStringWidth(gui.title.string.long);
	KLHTM_LocaliseStringWidth(gui.title.string.short);	
end


------------------------------------------------------------------------------
-- Sets the default options for displaying command buttons on the title bar.
------------------------------------------------------------------------------
function KLHTM_SetDefaultTitleOptions()
	
	options.buttonVis = {
		-- minimised button visibility
		["min"] = {
			["close"] = true,
			-- represents both minimise and maximise buttons
			["minmax"] = true,
			-- represents both pin and unpin buttons
			["pin"] = false,
			-- represents buth self view and raid view buttons
			["view"] = false,
			["opt"] = true,
			["targ"] = false,
			["clear"] = false,
		},
		-- maximised button visibility
		["max"] = {
			["close"] = true,
			["minmax"] = true,
			["pin"] = true,
			["view"] = true,
			["opt"] = true,
			["targ"] = true,
			["clear"] = false,
		},
	};
end


------------------------------------------------------------------------------
-- Updates visibility and scale of the title bar command buttons. Should be 
-- called:
--
-- a) when the minimisation state is changed
-- b) when the view or pin state is changed
-- c) when the button visibility settings are changed
------------------------------------------------------------------------------
function KLHTM_UpdateTitleButtons()

	sizes.but.x = 0;
	sizes.but.y = Button_Size;
	if (sizes.string.y ~= nil) then
		sizes.title.y = math.max(sizes.string.y, sizes.but.y);
	end

	for index, button in gui.title.but do
		if (button.vis()) then
			button.frame:Show();
			button.frame:SetWidth(Button_Size);
			sizes.but.x = sizes.but.x + Button_Size;
		else
			button.frame:Hide();
			button.frame:SetWidth(0.1);
		end
	end
end

	
------------------------------------------------------------------------------
-- Updates visibility and scale of the title bar strings. Should be called:
--
-- a) when the view state is changed
-- b) when the minimisation state is changed
-- c) when the string display options are changed
------------------------------------------------------------------------------
function KLHTM_UpdateTitleStrings()
	
	sizes.string.x = 0;
	sizes.string.y = heights.string;
	if (sizes.but.y ~= nil) then
		sizes.title.y = math.max(sizes.string.y, sizes.but.y);
	end
	
	for index, string in gui.title.string do
		if (string.vis()) then
			string.frame:Show();
			string.frame:SetWidth(string.width);
			sizes.string.x = sizes.string.x + string.width;
		else
			string.frame:Hide();
			string.frame:SetWidth(0.1);
		end
	end
end

------------------------------------------------------------------------------
-- Called when a command button is clicked
------------------------------------------------------------------------------
function KLHTM_TitleButton_OnClick(action)
	
	if (action == "close") then
		state.closed = true;
		gui.frame:Hide();

	elseif (action == "min") then
		KLHTM_SetMinMax("min");
		
	elseif (action == "max") then
		KLHTM_SetMinMax("max");
		
	elseif (action == "pin") then
		state.pinned = true;
		KLHTM_UpdateTitleButtons();
		
	elseif (action == "unpin") then
		state.pinned = false;
		KLHTM_UpdateTitleButtons();
		
	elseif (action == "self") then
		KLHTM_SetView("self");
		
	elseif (action == "raid") then
		KLHTM_SetView("raid");
		
	elseif (action == "opt") then
		KLHTM_ToggleOptionsGui();
		
	elseif (action == "targ") then
		if (UnitExists("target")) then
			mod.net.sendmastertarget();
		else
			mod.net.clearmastertarget();
		end
	
	elseif (action == "clear") then
		mod.net.clearraidthreat();
		
	else
		if mod.out.checktrace("warning", me, "invalidargument") then
			mod.out.printtrace(string.format("The argument '%s' to TitleButton_OnClick is unrecognised.", tostring(action)));
		end
	end
end
	
------------------------------------------------------------------------------
-- Displays a localised tooltip when the user mouses-over a command button
------------------------------------------------------------------------------
function KLHTM_TitleButton_OnEnter(name)
		
	local text = "|cffffc900" .. mod.string.get("gui", "title", "buttonshort", name);
	local extra = mod.string.get("gui", "title", "buttonlong", name);
	if (extra ~= "") then
		text = text .. "\n|r" .. extra;
	end
	
	GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
	GameTooltip:SetText(text, 1.0, 1.0, 1.0, 1, 1);
	GameTooltip:Show();
end
function KLHTM_Button_OnLeave()
	GameTooltip:Hide();
end


------------------------------------------------------------------------------
-- Displays a localised tooltip when the user mouses-over a title bar string.
-- Also highlights the selected string.
------------------------------------------------------------------------------
function KLHTM_TitleString_OnEnter(name)
	
	local text = "|cffffc900" .. mod.string.get("gui", "title", "stringshort", name)
				 .. "\n|r" .. mod.string.get("gui", "title", "stringlong", name);
		
	GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
	GameTooltip:SetText(text, 1.0, 1.0, 1.0, 1, 1);
	GameTooltip:Show();
	
	gui.title.string[name].text:SetTextColor(1.0, 0.82, 0);
end

function KLHTM_TitleString_OnLeave(name)
	GameTooltip:Hide();
	gui.title.string[name].text:SetTextColor(1.0, 1.0, 1.0);
end
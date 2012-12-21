--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucCommand.lua 944 2006-07-11 03:31:50Z mentalpower $

	Auctioneer command functions.
	Functions to allow setting of values, switching commands etc.

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]

--Local function prototypes
local register, convertKhaos, getKhaosDefault, setKhaosSetKeyParameter, setKhaosSetKeyValue, getKhaosLocaleList, getKhaosDurationsList, getKhaosProtectionList, getKhaosFinishList, registerKhaos, buildCommandMap, commandMap, commandMapRev, command, chatPrintHelp, onOff, clear, alsoInclude, isValidLocale, setLocale, default, getFrameNames, getFrameIndex, setFrame, protectWindow, auctionDuration, finish, genVarSet, percentVarSet, numVarSet, setFilter, getFilterVal, getFilter, findFilterClass, setFilter, getLocale


function register()
	if (Khaos) then
		if (not Auctioneer_Khaos_Registered) then
			registerKhaos();
		end
	end
end

-- Convert a single key in a table of configuration settings
function convertConfig(t, key, values, ...) --Local
	local modified = false;
	local v = nil;

	for i,localizedKey in ipairs(arg) do
		if (t[localizedKey] ~= nil) then
			v = t[localizedKey];
			t[localizedKey] = nil;
			modified = true;
		end
	end
	if (t[key] ~= nil) then v = t[key]; end

	if (v ~= nil) then
		if (values[v] ~= nil) then
			t[key] = values[v];
			modified = true;
		else
			t[key] = v;
		end
	end

	return modified;
end

-- Convert Khaos options to standardized keys and values
function convertKhaos()
	if (not Khaos_Configurations) then return; end

	-- Array that maps localized versions of strings to standardized
	local convertOnOff = {	['apagado'] = 'off',	-- esES
							['prendido'] = 'on',	-- esES
							}

	local localeConvMap = { ['apagado'] = 'default',
							['prendido'] = 'default',
							['off'] = 'default',
							['on'] = 'default',
							}

	-- Format: standardizedKey,			valueMap,		esES,						localizedKey
	local conversions = {
			-- Localized stuff to get rid of
			{ 'show-warning',			convertOnOff,	'ver-advertencia' },
			{ 'show-verbose',			convertOnOff,	'ver-literal' },
			{ 'show-stats',				convertOnOff,	'ver-estadisticas'},
			{ 'show-average',			convertOnOff,	'ver-promedio' },
			{ 'show-median',			convertOnOff,	'ver-mediano' },
			{ 'show-suggest',			convertOnOff,	'ver-sugerencia' },
			{ 'embed',					convertOnOff,	'integrado' },
			{ 'show-embed-blankline',	convertOnOff,	'ver-integrado-lineavacia' },
			{ 'pct-bidmarkdown',		convertOnOff,	'pct-menosoferta' },
			{ 'pct-markup',				convertOnOff,	'pct-mas' },
			{ 'pct-maxless',			convertOnOff,	'pct-sinmaximo' },
			{ 'pct-nocomp',				convertOnOff,	'pct-sincomp' },
			{ 'pct-underlow',			convertOnOff,	'pct-bajomenor' },
			{ 'pct-undermkt',			convertOnOff,	'pct-bajomercado' },
			{ 'autofill',				convertOnOff,	'autoinsertar' },
			{ 'show-link',				convertOnOff,	'ver-enlace' },

			-- Changed key names
			{ 'locale',					convertOnOff,	'AuctioneerLocale' },
			{ 'printframe',				convertOnOff,	'AuctioneerPrintFrame' },
			{ 'also',					convertOnOff,	'AuctioneerInclude' },
			{ 'enabled',				convertOnOff,	'AuctioneerEnable' },
		}

	-- Prepend placeholder for the table parameter
	for i,c in ipairs(conversions) do
		table.insert(c, 1, nil)
	end

	for i,config in ipairs(Khaos_Configurations) do
		if (config.configuration and config.configuration.Auctioneer) then
			local converted = false;
			-- Run the defined conversions
			for i,c in ipairs(conversions) do
				-- Replace first parameter with actual table to process
				-- Inserting here will cause problems for the second iteration
				c[1] = config.configuration.Auctioneer
				converted = convertConfig(unpack(c)) or converted
			end

			if (converted) then
				Auctioneer.Util.ChatPrint("Converted old Khaos configuration \"" .. config.name .. "\"")
			end
		end
	end
end

function getKhaosDefault(filter)
	if (filter == "also") then
		return Auctioneer.Core.Constants.FilterDefaults[filter];
	elseif (Auctioneer.Core.Constants.FilterDefaults[filter] == 'on') then
		return true;
	elseif (Auctioneer.Core.Constants.FilterDefaults[filter] == 'off') then
		return false;
	else
		return Auctioneer.Core.Constants.FilterDefaults[filter];
	end
end


function setKhaosSetKeyParameter(key, parameter, value) --Local
	if (Auctioneer_Khaos_Registered) then
		if (Khaos.getSetKey("Auctioneer", key)) then
			Khaos.setSetKeyParameter("Auctioneer", key, parameter, value)
		else
			EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): key " .. key .. " does not exist")
		end
	end
end

function setKhaosSetKeyValue(key, value) --Local
	if (Auctioneer_Khaos_Registered) then
		local kKey = Khaos.getSetKey("Auctioneer", key)

		if (not kKey) then
			EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): key " .. key .. " does not exist")
		elseif (kKey.checked ~= nil) then
			if (type(value) == "string") then value = (value == "on"); end
			Khaos.setSetKeyParameter("Auctioneer", key, "checked", value)
		elseif (kKey.value ~= nil) then
			Khaos.setSetKeyParameter("Auctioneer", key, "value", value)
		else
			EnhTooltip.DebugPrint("setKhaosSetKeyValue(): don't know how to update key ", key)
		end
	end
end

function getKhaosLocaleList() --Local
	local options = { [_AUCT('CmdDefault')] = 'default' };
	for locale, data in AuctioneerLocalizations do
		options[locale] = locale;
	end
	return options
end

function getKhaosLoadList() --Local
	return {
		[_AUCT('GuiLoad_Always')] = 'always',
		[_AUCT('GuiLoad_Never')] = 'never',
		[_AUCT('GuiLoad_AuctionHouse')] = 'auctionhouse'
	}
end

function getKhaosDurationsList() --Local
	local list = {}
	for i = 0, 3 do
		list[_AUCT('CmdAuctionDuration'..i)] = i
	end
	return list
end

function getKhaosProtectionList() --Local
	local list = {}
	for i = 0, 2 do
		list[_AUCT('CmdProtectWindow'..i)] = i
	end
	return list
end

function getKhaosFinishList() --Local
	local list = {}
	for i = 0, 3 do
		list[_AUCT('CmdFinish'..i)] = i
	end
	return list
end

function registerKhaos()

	-- Convert old Khaos settings to current optionSet
	convertKhaos();

	local optionSet = {
		id="Auctioneer";
		text="Auctioneer";
		helptext=function()
			return _AUCT('GuiMainHelp')
		end;
		difficulty=1;
		default={checked=true};
		options={
			{
				id="Header";
				text="Auctioneer";
				helptext=function()
					return _AUCT('GuiMainHelp')
				end;
				type=K_HEADER;
				difficulty=1;
			};
			{
				id="enabled";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiMainEnable')
				end;
				helptext=function()
					return _AUCT('HelpOnoff')
				end;
				callback=function(state)
					Auctioneer.Command.OnOff(state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return _AUCT('StatOn');
					else
						return _AUCT('StatOff');
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				difficulty=1;
			};
			{
				id="LoadSettings";
				type=K_PULLDOWN;
				setup = {
					options = getKhaosLoadList;
					multiSelect = false;
				};
				text=function()
					return _AUCT('GuiLoad')
				end;
				helptext=function()
					return _AUCT('HelpLoad')
				end;
				callback=function(state) end;
				feedback=function(state)
					mainHandler("load " .. state.value, "GUI")
				end;
				default={value = 'auctionhouse'};
				disabled={value = 'never'};
				difficulty=1;
			};
			{
				id="locale";
				type=K_PULLDOWN;
				setup = {
					options = getKhaosLocaleList;
					multiSelect = false;
				};
				text=function()
					return _AUCT('GuiLocale')
				end;
				helptext=function()
					return _AUCT('HelpLocale')
				end;
				callback = function(state)
				end;
				feedback = function (state)
					Auctioneer.Command.SetLocale(state.value);
					return string.format(_AUCT('FrmtActSet'), _AUCT('CmdLocale'), state.value);
				end;
				default = {
					value = Auctioneer.Command.GetLocale();
				};
				disabled = {
					value = Auctioneer.Command.GetLocale();
				};
				dependencies={enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="AuctioneerStatsHeader";
				type=K_HEADER;
				text=function()
					return _AUCT('GuiStatsHeader')
				end;
				helptext=function()
					return _AUCT('GuiStatsHelp')
				end;
				difficulty=2;
			};
			{
				id="show-stats";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiStatsEnable')
				end;
				helptext=function()
					return _AUCT('HelpStats')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("show-stats", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('ShowStats')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('ShowStats')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('show-stats')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=1;
			};
			{
				id="show-average";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiAverages')
				end;
				helptext=function()
					return _AUCT('HelpAverage')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("show-average", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('ShowAverage')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('ShowAverage')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('show-average')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="show-median";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiMedian')
				end;
				helptext=function()
					return _AUCT('HelpMedian')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("show-median", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('ShowMedian')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('ShowMedian')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('show-median')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="show-suggest";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiSuggest')
				end;
				helptext=function()
					return _AUCT('HelpSuggest')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("show-suggest", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('ShowSuggest')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('ShowSuggest')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('show-suggest')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="show-verbose";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiVerbose')
				end;
				helptext=function()
					return _AUCT('HelpVerbose')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("show-verbose", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('ShowVerbose')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('ShowVerbose')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('show-verbose')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=1;
			};
			{
				id="AuctioneerAuctionHouseHeader";
				type=K_HEADER;
				text=function()
					return _AUCT('GuiAuctionHouseHeader')
				end;
				helptext=function()
					return _AUCT('GuiAuctionHouseHeaderHelp')
				end;
				difficulty=1;
			};
			{
				id="autofill";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiAutofill')
				end;
				helptext=function()
					return _AUCT('HelpAutofill')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("autofill", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('CmdAutofill')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('CmdAutofill')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('autofill')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=1;
			};
			{
				id="auction-duration";
				type=K_PULLDOWN;
				setup = {
					options = getKhaosDurationsList;
					multiSelect = false;
				};
				text=function()
					return _AUCT('GuiAuctionDuration')
				end;
				helptext=function()
					return _AUCT('HelpAuctionDuration')
				end;
				callback=function(state)
					Auctioneer.Command.AuctionDuration(state.value);
				end;
				feedback=function(state)
					return string.format(_AUCT('FrmtAuctionDuration'), _AUCT('CmdAuctionDuration'..Auctioneer.Command.GetFilterVal('auction-duration')));
				end;
				default = { value = _AUCT('CmdAuctionDuration'..Auctioneer.Core.Constants.FilterDefaults['auction-duration']) };
				disabled = { value = _AUCT('CmdAuctionDuration'..Auctioneer.Core.Constants.FilterDefaults['auction-duration']) };
				dependencies={enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="protect-window";
				type=K_PULLDOWN;
				setup = {
					options = getKhaosProtectionList;
					multiSelect = false;
				};
				text=function()
					return _AUCT('GuiProtectWindow')
				end;
				helptext=function()
					return _AUCT('HelpProtectWindow')
				end;
				callback=function(state)
					Auctioneer.Command.ProtectWindow(state.value);
				end;
				feedback=function(state)
					return string.format(_AUCT('FrmtProtectWindow'), _AUCT('CmdProtectWindow'..Auctioneer.Command.GetFilterVal('protect-window')));
				end;
				default = { value = _AUCT('CmdProtectWindow'..Auctioneer.Core.Constants.FilterDefaults['protect-window']) };
				disabled = { value = _AUCT('CmdProtectWindow'..Auctioneer.Core.Constants.FilterDefaults['protect-window']) };
				dependencies={enabled={checked=true;}};
				difficulty=3;
			};
			{
				id="finish";
				type=K_PULLDOWN;
				setup = {
					options = getKhaosFinishList;
					multiSelect = false;
				};
				text=function()
					return _AUCT('GuiFinish')
				end;
				helptext=function()
					return _AUCT('HelpFinish')
				end;
				callback=function(state)
					Auctioneer.Command.Finish(state.value);
				end;
				feedback=function(state)
					return string.format(_AUCT('FrmtFinish'), _AUCT('CmdFinish'..Auctioneer.Command.GetFilterVal('finish')));
				end;
				default = { value = _AUCT('CmdFinish'..Auctioneer.Core.Constants.FilterDefaults['finish']) };
				disabled = { value = _AUCT('CmdFinish'..Auctioneer.Core.Constants.FilterDefaults['finish']) };
				dependencies={enabled={checked=true;}};
				difficulty=3;
			};
			{
				id="show-warning";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiRedo')
				end;
				helptext=function()
					return _AUCT('HelpRedo')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("show-warning", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('ShowRedo')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('ShowRedo')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('show-warning')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=1;
			};
			{
				id="warn-color";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiWarnColor')
				end;
				helptext=function()
					return _AUCT('HelpWarnColor')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("warn-color", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('CmdWarnColor')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('CmdWarnColor')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('warn-color')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=1;
			};
			{
				id="AuctioneerEmbedHeader";
				type=K_HEADER;
				text=function()
					return _AUCT('GuiEmbedHeader')
				end;
				helptext=function()
					return _AUCT('HelpEmbed')
				end;
				difficulty=1;
			};
			{
				id="embed";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiEmbed')
				end;
				helptext=function()
					return _AUCT('HelpEmbed')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("embed", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('CmdEmbed')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('CmdEmbed')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('embed')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=1;
			};
			{
				id="show-embed-blankline";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiEmbedBlankline')
				end;
				helptext=function()
					return _AUCT('HelpEmbedBlank')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("show-embed-blankline", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('ShowEmbedBlank')));
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('ShowEmbedBlank')));
					end
				end;
				check=true;
				default={checked=getKhaosDefault('show-embed-blankline')};
				disabled={checked=false};
				dependencies={embed={checked=true;}, enabled={checked=true;}};
				difficulty=1;
			};
			{
				id="AuctioneerClearHeader";
				type=K_HEADER;
				text=function()
					return _AUCT('GuiClearHeader')
				end;
				helptext=function()
					return _AUCT('GuiClearHelp')
				end;
				difficulty=3;
			};
			{
				id="AuctioneerClearAll";
				type=K_BUTTON;
				setup={
					buttonText=function()
						return _AUCT('GuiClearallButton')
					end;
				};
				text=function()
					return _AUCT('GuiClearall')
				end;
				helptext=function()
					return _AUCT('GuiClearallHelp')
				end;
				callback=function()
					Auctioneer.Command.Clear("all");
				end;
				feedback=function()
					return string.format(_AUCT('FrmtActClearall'),  _AUCT('GuiClearallNote'));
				end;
				dependencies={enabled={checked=true;}};
				difficulty=3;
			};
			{
				id="AuctioneerClearSnapshot";
				type=K_BUTTON;
				setup={
					buttonText=function()
						return _AUCT('GuiClearsnapButton')
					end;
				};
				text=function()
					return _AUCT('GuiClearsnap')
				end;
				helptext=function()
					return _AUCT('GuiClearsnapHelp')
				end;
				callback=function()
					Auctioneer.Command.Clear(_AUCT('CmdClearSnapshot'));
				end;
				feedback=function()
					return _AUCT('FrmtActClearsnap');
				end;
				dependencies={enabled={checked=true;}};
				difficulty=3;
			};
			{
				id="AuctioneerPercentsHeader";
				type=K_HEADER;
				text=function()
					return _AUCT('GuiPercentsHeader')
				end;
				helptext=function()
					return _AUCT('GuiPercentsHelp')
				end;
				difficulty=4;
			};
			{
				id="pct-bidmarkdown";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiBidmarkdown')
				end;
				helptext=function()
					return _AUCT('HelpPctBidmarkdown')
				end;
				callback = function(state)
					Auctioneer.Command.PercentVarSet("pct-bidmarkdown", state.value);
				end;
				feedback = function (state)
					return string.format(_AUCT('FrmtActSet'), _AUCT('CmdPctBidmarkdown'), state.value.."%");
				end;
				default = {	value = getKhaosDefault('pct-bidmarkdown') };
				disabled = { value = getKhaosDefault('pct-bidmarkdown') };
				dependencies={enabled={checked=true;}};
				difficulty=4;
			};
			{
				id="pct-markup";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiMarkup')
				end;
				helptext=function()
					return _AUCT('HelpPctMarkup')
				end;
				callback = function(state)
					Auctioneer.Command.PercentVarSet("pct-markup", state.value);
				end;
				feedback = function (state)
					return string.format(_AUCT('FrmtActSet'), _AUCT('CmdPctMarkup'), state.value.."%");
				end;
				default = {	value = getKhaosDefault('pct-markup') };
				disabled = { value = getKhaosDefault('pct-markup') };
				dependencies={enabled={checked=true;}};
				difficulty=4;
			};
			{
				id="pct-maxless";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiMaxless')
				end;
				helptext=function()
					return _AUCT('HelpPctMaxless')
				end;
				callback = function(state)
					Auctioneer.Command.PercentVarSet("pct-maxless", state.value);
				end;
				feedback = function (state)
					return string.format(_AUCT('FrmtActSet'), _AUCT('CmdPctMaxless'), state.value.."%");
				end;
				default = {	value = getKhaosDefault('pct-maxless') };
				disabled = { value = getKhaosDefault('pct-maxless') };
				dependencies={enabled={checked=true;}};
				difficulty=4;
			};
			{
				id="pct-nocomp";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiNocomp')
				end;
				helptext=function()
					return _AUCT('HelpPctNocomp')
				end;
				callback = function(state)
					Auctioneer.Command.PercentVarSet("pct-nocomp", state.value);
				end;
				feedback = function (state)
					return string.format(_AUCT('FrmtActSet'), _AUCT('CmdPctNocomp'), state.value.."%");
				end;
				default = {	value = getKhaosDefault('pct-nocomp') };
				disabled = { value = getKhaosDefault('pct-nocomp') };
				dependencies={enabled={checked=true;}};
				difficulty=4;
			};
			{
				id="pct-underlow";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiUnderlow')
				end;
				helptext=function()
					return _AUCT('HelpPctUnderlow')
				end;
				callback = function(state)
					Auctioneer.Command.PercentVarSet("pct-underlow", state.value);
				end;
				feedback = function (state)
					return string.format(_AUCT('FrmtActSet'), _AUCT('CmdPctUnderlow'), state.value.."%");
				end;
				default = {	value = getKhaosDefault('pct-underlow') };
				disabled = { value = getKhaosDefault('pct-underlow') };
				dependencies={enabled={checked=true;}};
				difficulty=4;
			};
			{
				id="pct-undermkt";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiUndermkt')
				end;
				helptext=function()
					return _AUCT('HelpPctUndermkt')
				end;
				callback = function(state)
					Auctioneer.Command.PercentVarSet("pct-undermkt", state.value);
				end;
				feedback = function (state)
					return string.format(_AUCT('FrmtActSet'), _AUCT('CmdPctUndermkt'), state.value.."%");
				end;
				default = {	value = getKhaosDefault('pct-undermkt') };
				disabled = { value = getKhaosDefault('pct-undermkt') };
				dependencies={enabled={checked=true;}};
				difficulty=4;
			};
			{
				id="AuctioneerAskPriceHeader";
				type=K_HEADER;
				text=function()
					return _AUCT('GuiAskPriceHeader')
				end;
				helptext=function()
					return _AUCT('GuiAskPriceHeaderHelp')
				end;
				difficulty=2;
			};
			{
				id="askprice";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiAskPrice')
				end;
				helptext=function()
					return _AUCT('HelpAskPrice')
				end;
				callback=function(state)
					if (state.checked) then
						Auctioneer.AskPrice.OnOff("on");
					else
						Auctioneer.AskPrice.OnOff("off");
					end
				end;
				feedback=function(state)
					if (state.checked) then
						return (_AUCT('StatAskPriceOn'))
					else
						return (_AUCT('StatAskPriceOff'))
					end
				end;
				check=true;
				default={getKhaosDefault('askprice')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="askprice-trigger";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiAskPriceTrigger')
				end;
				helptext=function()
					return _AUCT('HelpAskPriceTrigger')
				end;
				callback = function(state)
					Auctioneer.AskPrice.SetTrigger(state.value)
				end;
				feedback = function (state)
					return string.format(_AUCT('FrmtActSet'), "askprice ".._AUCT('CmdAskPriceTrigger'), state.value);
				end;
				default = { value = getKhaosDefault('askprice-trigger') };
				disabled = { value = getKhaosDefault('askprice-trigger') };
				dependencies={askprice={checked=true}, enabled={checked=true;}};
				difficulty=3;
			};
			{
				id="askprice-vendor";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiAskPriceVendor')
				end;
				helptext=function()
					return _AUCT('HelpAskPriceVendor')
				end;
				callback=function(state)
					Auctioneer.AskPrice.GenVarSet("vendor", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtAskPriceEnable'), "askprice ".._AUCT('CmdAskPriceVendor')))
					else
						return (string.format(_AUCT('FrmtAskPriceDisable'), "askprice ".._AUCT('CmdAskPriceVendor')))
					end
				end;
				check=true;
				default={getKhaosDefault('askprice-vendor')};
				disabled={checked=false};
				dependencies={askprice={checked=true}, enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="askprice-party";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiAskPriceParty')
				end;
				helptext=function()
					return _AUCT('HelpAskPriceParty')
				end;
				callback=function(state)
					Auctioneer.AskPrice.GenVarSet("party", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtAskPriceEnable'), "askprice ".._AUCT('CmdAskPriceParty')))
					else
						return (string.format(_AUCT('FrmtAskPriceDisable'), "askprice ".._AUCT('CmdAskPriceParty')))
					end
				end;
				check=true;
				default={getKhaosDefault('askprice-party')};
				disabled={checked=false};
				dependencies={askprice={checked=true}, enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="askprice-guild";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiAskPriceGuild')
				end;
				helptext=function()
					return _AUCT('HelpAskPriceGuild')
				end;
				callback=function(state)
					Auctioneer.AskPrice.GenVarSet("guild", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtAskPriceEnable'), "askprice ".._AUCT('CmdAskPriceGuild')))
					else
						return (string.format(_AUCT('FrmtAskPriceDisable'), "askprice ".._AUCT('CmdAskPriceGuild')))
					end
				end;
				check=true;
				default={getKhaosDefault('askprice-guild')};
				disabled={checked=false};
				dependencies={askprice={checked=true}, enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="askprice-smart";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiAskPriceSmart')
				end;
				helptext=function()
					return _AUCT('HelpAskPriceSmart')
				end;
				callback=function(state)
					Auctioneer.AskPrice.GenVarSet("smart", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtAskPriceEnable'), "askprice ".._AUCT('CmdAskPriceSmart')))
					else
						return (string.format(_AUCT('FrmtAskPriceDisable'), "askprice ".._AUCT('CmdAskPriceSmart')))
					end
				end;
				check=true;
				default={getKhaosDefault('askprice-smart')};
				disabled={checked=false};
				dependencies={askprice={checked=true}, enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="askprice-ad";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiAskPriceAd')
				end;
				helptext=function()
					return _AUCT('HelpAskPriceAd')
				end;
				callback=function(state)
					Auctioneer.AskPrice.GenVarSet("ad", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtAskPriceEnable'), "askprice ".._AUCT('CmdAskPriceAd')))
					else
						return (string.format(_AUCT('FrmtAskPriceDisable'), "askprice ".._AUCT('CmdAskPriceAd')))
					end
				end;
				check=true;
				default={getKhaosDefault('askprice-ad')};
				disabled={checked=false};
				dependencies={askprice={checked=true}, enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="AuctioneerOtherHeader";
				type=K_HEADER;
				text=function()
					return _AUCT('GuiOtherHeader')
				end;
				helptext=function()
					return _AUCT('GuiOtherHelp')
				end;
				difficulty=1;
			};
			{
				id="also";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiAlso')
				end;
				helptext=function()
					return _AUCT('HelpAlso')
				end;
				callback = function(state)
					Auctioneer.Command.AlsoInclude(state.value);
				end;
				feedback = function (state)
					if ((state.value == _AUCT('CmdOff')) or (state.value == "off")) then
						return _AUCT('GuiAlsoOff');
					elseif ((state.value == _AUCT('CmdAlsoOpposite')) or (state.value == "opposite")) then
						return _AUCT('GuiAlsoOpposite');
					elseif (not Auctioneer.Util.IsValidAlso(state.value)) then
						return string.format(_AUCT('FrmtUnknownArg'), state.value, _AUCT('CmdAlso'))
					else
						return string.format(_AUCT('GuiAlsoDisplay'), state.value);
					end
				end;
				default = { value = getKhaosDefault('also') };
				disabled = { value = getKhaosDefault('also') };
				dependencies={enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="printframe";
				type=K_PULLDOWN;
				setup = {
					options = Auctioneer.Command.GetFrameNames;
					multiSelect = false;
				};
				text=function()
					return _AUCT('GuiPrintin')
				end;
				helptext=function()
					return _AUCT('HelpPrintin')
				end;
				callback=function(state)
					Auctioneer.Command.SetFrame(state.value);
				end;
				feedback=function(state)
					local _, frameName = Auctioneer.Command.GetFrameNames(state.value)
					return string.format(_AUCT('FrmtPrintin'), frameName);
				end;
				default = { value = getKhaosDefault('printframe') };
				disabled = { value = getKhaosDefault('printframe') };
				dependencies={enabled={checked=true;}};
				difficulty=3;
			};
			{
				id="show-link";
				type=K_TEXT;
				text=function()
					return _AUCT('GuiLink')
				end;
				helptext=function()
					return _AUCT('HelpLink')
				end;
				callback=function(state)
					Auctioneer.Command.GenVarSet("show-link", state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_AUCT('FrmtActEnable'), _AUCT('ShowLink')))
					else
						return (string.format(_AUCT('FrmtActDisable'), _AUCT('ShowLink')))
					end
				end;
				check=true;
				default={getKhaosDefault('show-link')};
				disabled={checked=false};
				dependencies={enabled={checked=true;}};
				difficulty=3;
			};
			{
				id="DefaultAll";
				type=K_BUTTON;
				setup={
					buttonText = function()
						return _AUCT('GuiDefaultAllButton')
					end;
				};
				text=function()
					return _AUCT('GuiDefaultAll')
				end;
				helptext=function()
					return _AUCT('GuiDefaultAllHelp')
				end;
				callback=function()
					Auctioneer.Command.Default(_AUCT('CmdClearAll'));
				end;
				feedback=function()
					return _AUCT('FrmtActDefaultall');
				end;
				dependencies={enabled={checked=true;}};
				difficulty=1;
			};
			{
				id="DefaultOption";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _AUCT('GuiDefaultOption')
				end;
				helptext=function()
					return _AUCT('HelpDefault')
				end;
				callback = function(state)
					Auctioneer.Command.Default(state.value);
				end;
				feedback = function (state)
					if (state.value == _AUCT('CmdClearAll')) then
						return _AUCT('FrmtActDefaultall');
					else
						return string.format(_AUCT('FrmtActDefault'), state.value);
					end
				end;
				default = {
					value = "";
				};
				disabled = {
					value = "";
				};
				dependencies={enabled={checked=true;}};
				difficulty=4;
			};
		};
	};

	Khaos.registerOptionSet("tooltip", optionSet);
	Auctioneer_Khaos_Registered = true;
	Khaos.refresh();

	-- This setting is not actually stored in the Khaos option set and
	-- requires special treatment to be updated
	local loadType = Stubby.GetConfig("Auctioneer", "LoadType")
	if (not loadType) then loadType = "auctionhouse"; end
	setKhaosSetKeyValue("LoadSettings", loadType)
end


function buildCommandMap()
	Auctioneer.Command.CommandMap = nil;
	Auctioneer.Command.CommandMapRev = nil;

	commandMap = {
		[_AUCT('CmdOn')]				=	'on',
		[_AUCT('CmdOff')]				=	'off',
		[_AUCT('CmdHelp')]				=	'help',
		[_AUCT('CmdToggle')]			=	'toggle',
		[_AUCT('CmdDisable')]			=	'disable',
		[_AUCT('CmdClear')]				=	'clear',
		[_AUCT('CmdLocale')]			=	'locale',
		[_AUCT('CmdDefault')]			=	'default',
		[_AUCT('CmdPrintin')]			=	'print-in',
		[_AUCT('CmdAlso')]				=	'also',
		[_AUCT('CmdEmbed')]			=	'embed',
		[_AUCT('CmdPercentless')]		=	'percentless',
		[_AUCT('CmdPercentlessShort')]	=	'percentless',
		[_AUCT('CmdCompete')]			=	'compete',
		[_AUCT('CmdScan')]				=	'scan',
		[_AUCT('CmdAutofill')]			=	'autofill',
		[_AUCT('CmdWarnColor')]			=	'warn-color',
		[_AUCT('CmdAuctionDuration')]		=	'auction-duration',
		[_AUCT('CmdProtectWindow')]		=	'protect-window',
		[_AUCT('CmdFinish')]			=	'finish',
		[_AUCT('CmdBroker')]			=	'broker',
		[_AUCT('CmdBidbroker')]			=	'bidbroker',
		[_AUCT('CmdBidbrokerShort')]		=	'bidbroker',
		[_AUCT('CmdAuctionClick')]		=	'auction-click',
		[_AUCT('CmdPctBidmarkdown')]	=	'pct-bidmarkdown',
		[_AUCT('CmdPctMarkup')]			=	'pct-markup',
		[_AUCT('CmdPctMaxless')]		=	'pct-maxless',
		[_AUCT('CmdPctNocomp')]		=	'pct-nocomp',
		[_AUCT('CmdPctUnderlow')]		=	'pct-underlow',
		[_AUCT('CmdPctUndermkt')]		=	'pct-undermkt',

		--AskPrice related commands
		[_AUCT('CmdAskPriceVendor')]		=	'vendor',
		[_AUCT('CmdAskPriceGuild')]		=	'guild',
		[_AUCT('CmdAskPriceParty')]		=	'party',
		[_AUCT('CmdAskPriceSmart')]		=	'smart',
		[_AUCT('CmdAskPriceAd')]		=	'ad',

		-- Post/Search Tab related commands
		[_AUCT('CmdBidLimit')]			=	'bid-limit',
		[_AUCT('CmdUpdatePrice')]		=	'update-price',
	}

	commandMapRev = {}
	for k,v in pairs(commandMap) do
		commandMapRev[v] = k;
	end

	Auctioneer.Command.CommandMap = commandMap;
	Auctioneer.Command.CommandMapRev = commandMapRev;
end

--Cleaner Command Handling Functions (added by MentalPower)
function mainHandler(command, source)

	--To print or not to print, that is the question...
	local chatprint = nil;

	if (source == "GUI") then
		chatprint = false;

	else
		chatprint = true;
	end;

	--Divide the large command into smaller logical sections (Shameless copy from the original function)
	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");

	if (not cmd) then cmd = command; end
	if (not cmd) then cmd = ""; end
	if (not param) then	param = ""; end
	cmd = Auctioneer.Util.DelocalizeCommand(cmd);

	--Now for the real Command handling

	--/auctioneer help
	if ((cmd == "") or (cmd == "help")) then
		chatPrintHelp();

	--/auctioneer (on|off|toggle)
	elseif (cmd == 'on' or cmd == 'off' or cmd == 'toggle') then
		onOff(cmd, chatprint);

	--/auctioneer disable
	elseif (cmd == 'disable') then
		Auctioneer.Util.ChatPrint(_AUCT('DisableMsg'));
		Stubby.SetConfig("Auctioneer", "LoadType", "never");
		setKhaosSetKeyValue("LoadSettings", "never")

	--/auctioneer load (always|never|auctionhouse)
	elseif (cmd == 'load') then
		if (param == "always") or (param == "never") or (param == "auctionhouse") then
			Stubby.SetConfig("Auctioneer", "LoadType", param);
			if (chatprint) then
				Auctioneer.Util.ChatPrint("Setting Auctioneer to "..param.." load for this toon");
				setKhaosSetKeyValue("LoadSettings", param)
			end
		end

	--/auctioneer clear (all|snapshot|item)
	elseif (cmd == 'clear') then
		clear(param, chatprint);

	--/auctioneer also ReamName-Faction
	elseif (cmd == 'also') then
		alsoInclude(param, chatprint);

	--/auctioneer locale
	elseif (cmd == 'locale') then
		setLocale(param, chatprint);

	--/auctioneer default (all|option)
	elseif (cmd == 'default') then
		default(param, chatprint);

	--/auctioneer print-in (FrameName|FrameNumber)
	elseif (cmd == 'print-in') then
		setFrame(param, chatprint)

	--/auctioneer broker
	elseif (cmd == 'broker') then
		Auctioneer.Filter.DoBroker(param);

	--/auctioneer bidbroker
	elseif (cmd == 'bidbroker' or cmd == "bb") then
		Auctioneer.Filter.DoBidBroker(param);

	--/auctioneer percentless
	elseif (cmd == 'percentless' or cmd == "pl") then
		Auctioneer.Filter.DoPercentLess(param);

	--/auctioneer compete
	elseif (cmd == 'compete') then
		Auctioneer.Filter.DoCompeting(param);

	--/auctioneer scan
	elseif (cmd == 'scan') then
		Auctioneer.Scanning.RequestAuctionScan();

	--/auctioneer protect-window
	elseif (cmd == 'protect-window') then
		protectWindow(param, chatprint);

	--/auctioneer auction-duration (2h|8h|24h)
	elseif (cmd == 'auction-duration') then
		auctionDuration(param, chatprint);

	--/auctioneer finish (off|logout|exit)
	elseif (cmd == 'finish') then
		finish(param, chatprint);

	--/auctioneer low
	elseif (cmd == 'low') then
		Auctioneer.Statistic.DoLow(param);

	--/auctioneer med
	elseif (cmd == 'med') then
		Auctioneer.Statistic.DoMedian(param);

	--/auctioneer hsp
	elseif (cmd == 'hsp') then
		Auctioneer.Statistic.DoHSP(param);

	--/auctioneer askprice (vendor|guild|party|smart|trigger|ad)
	elseif (cmd == 'askprice') then
		Auctioneer.AskPrice.CommandHandler(param, source);

	--/auctioneer (GenVars)
	elseif (cmd == 'embed' or cmd == 'autofill' or cmd == 'auction-click' or
			cmd == 'show-verbose' or cmd == 'show-average' or cmd == 'show-link' or
			cmd == 'show-median' or cmd == 'show-stats' or cmd == 'show-suggest' or
			cmd == 'show-embed-blankline' or cmd == 'show-warning' or cmd == 'warn-color' or
			cmd == 'update-price') then
		genVarSet(cmd, param, chatprint);

	--/auctioneer (PercentVars)
	elseif (cmd == 'pct-bidmarkdown' or cmd == 'pct-markup' or cmd == "pct-maxless" or
			cmd == "pct-nocomp" or cmd == "pct-underlow" or cmd == "pct-undermkt") then
		percentVarSet(cmd, param, chatprint);

	--/auctioneer (NumVars)
	elseif (cmd == 'bid-limit') then
		numVarSet(cmd, param, chatprint);

	--Command not recognized
	else
		if (chatprint) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), cmd));
		end
	end
end

--Help ME!! (The Handler) (Another shameless copy from the original function)
function chatPrintHelp()
	Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtWelcome'), Auctioneer.Version), 0.8, 0.8, 0.2);

	local onOffToggle = " (".._AUCT('CmdOn').."|".._AUCT('CmdOff').."|".._AUCT('CmdToggle')..")";
	local lineFormat = "  |cffffffff/auctioneer %s "..onOffToggle.."|r |cff2040ff[%s]|r - %s";

	local _, frameName = getFrameNames(getFrameIndex());

	Auctioneer.Util.ChatPrint(_AUCT('TextUsage'));
	Auctioneer.Util.ChatPrint("  |cffffffff/auctioneer "..onOffToggle.."|r |cff2040ff["..Auctioneer.Util.GetLocalizedFilterVal("all").."]|r - " .. _AUCT('HelpOnoff'));
	Auctioneer.Util.ChatPrint("  |cffffffff/auctioneer ".._AUCT('CmdDisable').."|r - " .. _AUCT('HelpDisable'));

	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('ShowVerbose'), Auctioneer.Util.GetLocalizedFilterVal('show-verbose'), _AUCT('HelpVerbose')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('ShowAverage'), Auctioneer.Util.GetLocalizedFilterVal('show-average'), _AUCT('HelpAverage')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('ShowMedian'), Auctioneer.Util.GetLocalizedFilterVal('show-median'), _AUCT('HelpMedian')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('ShowSuggest'), Auctioneer.Util.GetLocalizedFilterVal('show-suggest'), _AUCT('HelpSuggest')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('ShowStats'), Auctioneer.Util.GetLocalizedFilterVal('show-stats'), _AUCT('HelpStats')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('ShowLink'), Auctioneer.Util.GetLocalizedFilterVal('show-link'), _AUCT('HelpLink')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAutofill'), Auctioneer.Util.GetLocalizedFilterVal('autofill'), _AUCT('HelpAutofill')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdEmbed'), Auctioneer.Util.GetLocalizedFilterVal('embed'), _AUCT('HelpEmbed')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('ShowEmbedBlank'), Auctioneer.Util.GetLocalizedFilterVal('show-embed-blankline'), _AUCT('HelpEmbedBlank')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('ShowRedo'), Auctioneer.Util.GetLocalizedFilterVal('show-warning'), _AUCT('HelpRedo')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAuctionClick'), Auctioneer.Util.GetLocalizedFilterVal('auction-click'), _AUCT('HelpAuctionClick')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdWarnColor'), Auctioneer.Util.GetLocalizedFilterVal('warn-color'), _AUCT('HelpWarnColor')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdUpdatePrice'), Auctioneer.Util.GetLocalizedFilterVal('update-price'), _AUCT('HelpUpdatePrice')));

	lineFormat = "  |cffffffff/auctioneer %s %s|r |cff2040ff[%s]|r - %s";
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdProtectWindow'), _AUCT('OptProtectWindow'), _AUCT('CmdProtectWindow'..Auctioneer.Command.GetFilterVal('protect-window')), _AUCT('HelpProtectWindow')));
--[[
	--this line is causing hangs, disabled for now pending further investigation.
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAuctionDuration'), _AUCT('OptAuctionDuration'), _AUCT('CmdAuctionDuration'..Auctioneer.Command.GetFilterVal('auction-duration')), _AUCT('HelpAuctionDuration')));
]]
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdLocale'), _AUCT('OptLocale'), Auctioneer.Util.GetLocalizedFilterVal("locale"), _AUCT('HelpLocale')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdPrintin'), _AUCT('OptPrintin'), frameName, _AUCT('HelpPrintin')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdFinish'), _AUCT('OptFinish'), _AUCT('CmdFinish'..Auctioneer.Command.GetFilterVal('finish')), _AUCT('HelpFinish')));

	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdPctMarkup'), _AUCT('OptPctMarkup'), Auctioneer.Command.GetFilterVal('pct-markup'), _AUCT('HelpPctMarkup')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdPctBidmarkdown'), _AUCT('OptPctBidmarkdown'), Auctioneer.Command.GetFilterVal('pct-bidmarkdown'), _AUCT('HelpPctBidmarkdown')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdPctNocomp'), _AUCT('OptPctNocomp'), Auctioneer.Command.GetFilterVal('pct-nocomp'), _AUCT('HelpPctNocomp')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdPctUnderlow'), _AUCT('OptPctUnderlow'), Auctioneer.Command.GetFilterVal('pct-underlow'), _AUCT('HelpPctUnderlow')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdPctUndermkt'), _AUCT('OptPctUndermkt'), Auctioneer.Command.GetFilterVal('pct-undermkt'), _AUCT('HelpPctUndermkt')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdPctMaxless'), _AUCT('OptPctMaxless'), Auctioneer.Command.GetFilterVal('pct-maxless'), _AUCT('HelpPctMaxless')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdBidLimit'), _AUCT('OptBidLimit'), Auctioneer.Command.GetFilterVal('bid-limit'), _AUCT('HelpBidLimit')));

	Auctioneer.AskPrice.ChatPrintHelp()

	lineFormat = "  |cffffffff/auctioneer %s %s|r - %s";
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdClear'), _AUCT('OptClear'), _AUCT('HelpClear')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAlso'), _AUCT('OptAlso'), _AUCT('HelpAlso')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdBroker'), _AUCT('OptBroker'), _AUCT('HelpBroker')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdBidbroker'), _AUCT('OptBidbroker'), _AUCT('HelpBidbroker')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdPercentless'), _AUCT('OptPercentless'), _AUCT('HelpPercentless')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdCompete'), _AUCT('OptCompete'), _AUCT('HelpCompete')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdScan'), _AUCT('OptScan'), _AUCT('HelpScan')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdDefault'), _AUCT('OptDefault'), _AUCT('HelpDefault')));
end
--[[
	The onOff(state, chatprint) function handles the state of the Auctioneer AddOn (whether it is currently on or off)
	If "on" or "off" is specified in the first argument then Auctioneer's state is changed to that value,
	If "toggle" is specified then it will toggle Auctioneer's state (if currently on then it will be turned off and vice-versa)

	If a boolean (or nil) value is passed as the first argument the conversion is as follows:
	"true" is the same as "on"
	"false" is the same as "off"
	"nil" is the same as "toggle"

	If chatprint is "true" then the state will also be printed to the user.
]]
function onOff(state, chatprint)
	if (type(state) == "string") then
		state = Auctioneer.Util.DelocalizeFilterVal(state);

	elseif (state == true) then
		state = 'on'

	elseif (state == false) then
		state = 'off'

	elseif (state == nil) then
		state = 'toggle'
	end

	if (state == 'on' or state == 'off') then
		setFilter('all', state);

	elseif (state == 'toggle') then
		setFilter('all', not getFilter('all'));
	end

	--Print the change and alert the GUI if the command came from slash commands. Do nothing if they came from the GUI.
	if (chatprint) then
		state = getFilter('all')
		setKhaosSetKeyValue("enabled", state)

		if (state) then
			Auctioneer.Util.ChatPrint(_AUCT('StatOn'));

		else
			Auctioneer.Util.ChatPrint(_AUCT('StatOff'));
		end
	end
end

--The following functions are almost verbatim copies of the original functions but modified in order to make them compatible with direct GUI access.
function clear(param, chatprint)
	if (not param) or (not type(param) == "string") then
		return
	end

	local aKey = Auctioneer.Util.GetAuctionKey();

	if ((param == _AUCT('CmdClearAll')) or (param == "all")) then

		AuctionConfig.info = {};
		AuctionConfig.data[aKey] = {};
		AuctionConfig.stats.histmed[aKey] = {};
		AuctionConfig.stats.histcount[aKey] = {};
		clear("snapshot");
	elseif ((param == _AUCT('CmdClearSnapshot')) or (param == "snapshot")) then

		AuctionConfig.snap[aKey] = {};
		AuctionConfig.sbuy[aKey] = {};
		Auctioneer_HSPCache[aKey] = {};
		AuctionConfig.stats.snapmed[aKey] = {};
		AuctionConfig.stats.snapcount[aKey] = {};
		Auctioneer.Core.Variables.SnapshotItemPrices = {};
	else

		local items = Auctioneer.Util.GetItems(param);
		local itemLinks = Auctioneer.Util.GetItemHyperlinks(param);

		if (items) then
			for pos,itemKey in pairs(items) do

				if (AuctionConfig.data[aKey][itemKey]) then
					AuctionConfig.data[aKey][itemKey] = nil;

					AuctionConfig.stats.snapmed[aKey][itemKey] = nil;
					AuctionConfig.stats.histmed[aKey][itemKey] = nil;
					AuctionConfig.stats.histcount[aKey][itemKey] = nil;
					AuctionConfig.stats.snapcount[aKey][itemKey] = nil;
					AuctionConfig.sbuy[aKey][itemKey] = nil;

					local count = 0;
					while (AuctionConfig.snap[aKey][count]) do
						AuctionConfig.snap[aKey][count][itemKey] = nil;
						count = count+1;
					end

					Auctioneer_HSPCache[aKey][itemKey] = nil;

					--These are not included in the print statement below because there could be the possiblity that an item's data was cleared but another's was not
					if (chatprint) then
						Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActClearOk'), itemLinks[pos]));
					end
				else
					if (chatprint) then
						Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActClearFail'), itemLinks[pos]));
					end
				end
			end
		end
	end

	if (chatprint) then
		if ((param == _AUCT('CmdClearAll')) or (param == "all")) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActClearall'), aKey));

		elseif ((param == _AUCT('CmdClearSnapshot')) or (param == "snapshot")) then
			Auctioneer.Util.ChatPrint(_AUCT('FrmtActClearsnap'));
		end
	end
end


function alsoInclude(param, chatprint)
	local localizedParam = param;
	param = Auctioneer.Util.DelocalizeFilterVal(param);
	if ((param == _AUCT('CmdAlsoOpposite')) or (param == "opposite")) then
		param = "opposite";
	end

	if (not Auctioneer.Util.IsValidAlso(param)) then
		if (chatprint) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtUnknownRf'), param));
		end
		return
	end

	setFilter('also', param);

	if (chatprint) then
		setKhaosSetKeyValue('also', param);

		if (param == "off") then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActDisable'), _AUCT('CmdAlso')));

		else
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActSet'), _AUCT('CmdAlso'), localizedParam));
		end
	end
end


function isValidLocale(param)
	return (AuctioneerLocalizations and AuctioneerLocalizations[param])
end


function setLocale(param, chatprint)
	param = Auctioneer.Util.DelocalizeFilterVal(param);
	local validLocale;

	if (param == 'default') or (param == 'off') then
		Babylonian.SetOrder('');
		validLocale = true;

	elseif (Auctioneer.Command.IsValidLocale(param)) then
		Babylonian.SetOrder(param);
		validLocale = true;

	else
		validLocale = false;
	end


	if (chatprint) then
		if (validLocale) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActSet'), _AUCT('CmdLocale'), param));
			setKhaosSetKeyValue('locale', Babylonian.GetOrder());

		else
			Auctioneer.Util.ChatPrint(string.format(_AUCT("FrmtUnknownLocale"), param));
			local locales = "    ";
			for locale, data in pairs(AuctioneerLocalizations) do
				locales = locales .. " '" .. locale .. "' ";
			end
			Auctioneer.Util.ChatPrint(locales);
		end
	end

	if (Auctioneer_Khaos_Registered) then
		Khaos.refresh(nil, nil, true)
	end

	commandMap = nil;
	commandMapRev = nil;
end


function default(param, chatprint)
	local paramLocalized

	if ( (param == nil) or (param == "") ) then
		return

	elseif ((param == _AUCT('CmdClearAll')) or (param == "all")) then
		param = "all"
		AuctionConfig.filters = {};

	else
		paramLocalized = param
		param = Auctioneer.Util.DelocalizeCommand(param)
		setFilter(param, nil);
	end

	Auctioneer.Util.SetFilterDefaults();		-- Apply defaults for settings that went missing

	if (chatprint) then
		if (param == "all") then
			Auctioneer.Util.ChatPrint(_AUCT('FrmtActDefaultall'));
			for k,v in pairs(AuctionConfig.filters) do
				setKhaosSetKeyValue(k, Auctioneer.Command.GetFilterVal(k));
			end

		else
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActDefault'), paramLocalized));
			setKhaosSetKeyValue(param, Auctioneer.Command.GetFilterVal(param));
		end
	end
end

--The following three functions were added by MentalPower to implement the /auc print-in command
function getFrameNames(index)

	local frames = {};
	local frameName = "";

	for i=1, 10 do
		local name, fontSize, r, g, b, a, shown, locked, docked = GetChatWindowInfo(i);

		if ( name == "" ) then
			if (i == 1) then
				frames[_AUCT('TextGeneral')] = 1;

			elseif (i == 2) then
				frames[_AUCT('TextCombat')] = 2;
			end

		else
			frames[name] = i;
		end
	end

	if (type(index) == "number") then
		local name, fontSize, r, g, b, a, shown, locked, docked = GetChatWindowInfo(index);

		if ( name == "" ) then
			if (index == 1) then
				frameName = _AUCT('TextGeneral');

			elseif (index == 2) then
				frameName = _AUCT('TextCombat');
			end

		else
			frameName = name;
		end
	end

	return frames, frameName;
end


function getFrameIndex()
	if (not AuctionConfig.filters) then AuctionConfig.filters = {}; end
	local value = AuctionConfig.filters["printframe"];

	if (not value) then
		return 1;
	end
	return value;
end


function setFrame(frame, chatprint)
	local frameNumber
	local frameVal
	frameVal = tonumber(frame)

	--If no arguments are passed, then set it to the default frame.
	if not (frame) then
		frameNumber = 1;

	--If the frame argument is a number then set our chatframe to that number.
	elseif ((frameVal) ~= nil) then
		frameNumber = frameVal;

	--If the frame argument is a string, find out if there's a chatframe with that name, and set our chatframe to that index. If not set it to the default frame.
	elseif (type(frame) == "string") then
		allFrames = getFrameNames();
		if (allFrames[frame]) then
			frameNumber = allFrames[frame];
		else
			frameNumber = 1;
		end

	--If the argument is something else, set our chatframe to its default value.
	else
		frameNumber = 1;
	end

	local _, frameName
	if (chatprint == true) then
		_, frameName = getFrameNames(frameNumber);
		if (getFrameIndex() ~= frameNumber) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtPrintin'), frameName));
		end
	end

	setFilter("printframe", frameNumber);

	if (chatprint == true) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtPrintin'), frameName));
		setKhaosSetKeyValue("printframe", frameNumber);
	end
end

function protectWindow(param, chatprint)
	local mode;

	if (param == 'never' or param == 'off' or param == _AUCT('CmdProtectWindow0') or param == _AUCT('CmdOff') or tonumber(param) == 0) then
		mode = 0;

	elseif (param == 'scan' or param == _AUCT('CmdProtectWindow1') or tonumber(param) == 1) then
		mode = 1;

	elseif (param == 'always' or param == _AUCT('CmdProtectWindow2') or tonumber(param) == 2) then
		mode = 2;

	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtUnknownArg'), param, Auctioneer.Util.LocalizeCommand("protect-window")));
		return
	end

	setFilter("protect-window", mode);

	if (chatprint) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtProtectWindow'), _AUCT('CmdProtectWindow' .. mode)));
		setKhaosSetKeyValue("protect-window", mode);
	end
end

function auctionDuration(param, chatprint)
	local mode;

	if (param == 'last' or param == _AUCT('CmdAuctionDuration0') or tonumber(param) == 0) then
		mode = 0;

	elseif (param == '2h' or param == _AUCT('CmdAuctionDuration1') or tonumber(param) == 1) then
		mode = 1;

	elseif (param == '8h' or param == _AUCT('CmdAuctionDuration2') or tonumber(param) == 2) then
		mode = 2;

	elseif (param == '24h' or param == _AUCT('CmdAuctionDuration3') or tonumber(param) == 3) then
		mode = 3;

	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtUnknownArg'), param, Auctioneer.Util.LocalizeCommand("auction-duration")));
		return
	end

	setFilter("auction-duration", mode);

	if (chatprint) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtAuctionDuration'), _AUCT('CmdAuctionDuration' .. mode)));
		setKhaosSetKeyValue("auction-duration", mode);
	end
end

function finish(param, chatprint)
	local mode;

	if (param == 'off' or param == _AUCT('CmdFinish0') or tonumber(param) == 0) then
		mode = 0;

	elseif (param == 'logout' or param == _AUCT('CmdFinish1') or tonumber(param) == 1) then
		mode = 1;

	elseif (param == 'exit' or param == _AUCT('CmdFinish2') or tonumber(param) == 2) then
		mode = 2;

	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtUnknownArg'), param, Auctioneer.Util.LocalizeCommand("finish")));
		return
	end

	setFilter("finish", mode);

	if (chatprint) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtFinish'), _AUCT('CmdFinish' .. mode)));
		setKhaosSetKeyValue("finish", mode);
	end
end

function genVarSet(variable, param, chatprint)
	if (type(param) == "string") then
		param = Auctioneer.Util.DelocalizeFilterVal(param);
	end

	if (param == "on" or param == "off" or type(param) == "boolean") then
		setFilter(variable, param);
	elseif (param == "toggle" or param == nil or param == "") then
		param = setFilter(variable, not getFilter(variable));
	end

	if (chatprint) then
		if (getFilter(variable)) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActEnable'), Auctioneer.Util.LocalizeCommand(variable)));
			setKhaosSetKeyValue(variable, true)
		else
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActDisable'), Auctioneer.Util.LocalizeCommand(variable)));
			setKhaosSetKeyValue(variable, false)
		end
	end
end


function percentVarSet(variable, param, chatprint)
	local paramVal = tonumber(param);
	if paramVal == nil then
		-- failed to convert the param to a number

		if chatprint then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtUnknownArg'), param, variable));
		end
		return -- invalid argument, don't do anything
	end
	-- param is a valid number, save it
	setFilter(variable, paramVal);

	--Clear the HSP Cache since the profitability numbers have been updated.
	Auctioneer_HSPCache = {};

	if (chatprint) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActSet'), variable, paramVal.."%"));
		setKhaosSetKeyValue(variable, paramVal);
	end
end

function numVarSet(variable, param, chatprint)
	local paramVal = tonumber(param);
	if paramVal == nil then
		-- failed to convert the param to a number

		if chatprint then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtUnknownArg'), param, variable));
		end
		return -- invalid argument, don't do anything
	end
	-- param is a valid number, save it
	setFilter(variable, paramVal);

	if (chatprint) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActSet'), variable, paramVal));
		setKhaosSetKeyValue(variable, paramVal);
	end
end

--This marks the end of the New Command processing code.


function setFilter(key, value)
	if (not AuctionConfig.filters) then AuctionConfig.filters = {}; end
	if (type(value) == "boolean") then
		if (value) then
			AuctionConfig.filters[key] = 'on';

		else
			AuctionConfig.filters[key] = 'off';
		end

	else
		AuctionConfig.filters[key] = value;
	end
end

function getFilterVal(type)
	if (not AuctionConfig.filters) then
		AuctionConfig.filters = {};
		Auctioneer.Util.SetFilterDefaults();
	end
	local val = AuctionConfig.filters[type];
	if (val == nil) then
		val = Auctioneer.Core.Constants.FilterDefaults[type];
	end
	return val;
end

function getFilter(filter)
	value = getFilterVal(filter);
	if ((value == _AUCT('CmdOn')) or (value == "on")) then return true;

	elseif ((value == _AUCT('CmdOff')) or (value == "off")) then return false; end
	return true;
end



function findFilterClass(text)
	local totalFilters = getn(CLASS_FILTERS);
	for currentFilter=1, totalFilters do
		if (text == CLASS_FILTERS[currentFilter]) then
			return currentFilter, totalFilters;
		end
	end
	return 0, totalFilters;
end

function filterSetFilter(checkbox, filter)
	checkbox.filterVal = filter;
	checkbox:SetChecked(getFilter(filter));
	checkbox:Show();
end

function getLocale()
	local locale = Auctioneer.Command.GetFilterVal('locale');
	if (locale == 'on') or (locale == 'off') or (locale == 'default') then
		return GetLocale();
	end
	return locale;
end


Auctioneer.Command = {
	Register = register,
	ConvertKhaos = convertKhaos,
	GetKhaosDefault = getKhaosDefault,
	RegisterKhaos = registerKhaos,
	BuildCommandMap = buildCommandMap,
	CommandMap = commandMap,
	CommandMapRev = commandMapRev,
	MainHandler = mainHandler,
	ChatPrintHelp = chatPrintHelp,
	OnOff = onOff,
	Clear = clear,
	AlsoInclude = alsoInclude,
	IsValidLocale = isValidLocale,
	SetLocale = setLocale,
	Default = default,
	GetFrameNames = getFrameNames,
	GetFrameIndex = getFrameIndex,
	SetFrame = setFrame,
	ProtectWindow = protectWindow,
	AuctionDuration = auctionDuration,
	Finish = finish,
	GenVarSet = genVarSet,
	PercentVarSet = percentVarSet,
	NumVarSet = numVarSet,
	SetFilter = setFilter,
	GetFilterVal = getFilterVal,
	GetFilter = getFilter,
	FindFilterClass = findFilterClass,
	FilterSetFilter = filterSetFilter,
	GetLocale = getLocale,
}
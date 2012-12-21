--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: EnxCommand.lua 944 2006-07-11 03:31:50Z mentalpower $

	Slash command and GUI functions.

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
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]

-- Global functions
local addonLoaded				-- Enchantrix.Command.AddonLoaded()
local auctioneerLoaded			-- Enchantrix.Command.AuctioneerLoaded()
local handleCommand				-- Enchantrix.Command.HandleCommand()
local register					-- Enchantrix.Command.Register()
local resetKhaos				-- Enchantrix.Command.ResetKhaos()
local setKhaosSetKeyValue		-- Enchantrix.Command.SetKhaosSetKeyValue()
local setKhaosSetKeyParameter	-- Enchantrix.Command.SetKhaosSetKeyParameter()

-- Local functions
local getKhaosLocaleList
local getKhaosLoadList
local registerKhaos
local registerAuctioneerOptions
local chatPrintHelp
local onOff
local clear
local default
local genVarSet
local percentLessFilter
local bidBrokerFilter
local profitComparisonSort
local bidBrokerSort
local doBidBroker
local doPercentLess
local getAuctionItemDisenchants

-- GUI Init Variables (Added by MentalPower)
Enchantrix.State.GUI_Registered = nil
Enchantrix.State.Khaos_Registered = nil

-- Local variables
local optionSet
local profitMargins

-- Local constants
local MAX_BUYOUT_PRICE = 800000;
local MIN_PROFIT_MARGIN = 1000;
local MIN_PERCENT_LESS_THAN_HSP = 20; -- 20% default
local MIN_PROFIT_PRICE_PERCENT = 10; -- 10% default

function addonLoaded()
	if IsAddOnLoaded("Khaos") then
		registerKhaos()
	end
end

function getKhaosLocaleList()
	local options = { [_ENCH('CmdDefault')] = 'default' };
	for locale, data in EnchantrixLocalizations do
		options[locale] = locale;
	end
	return options
end

function getKhaosLoadList()
	return {
		[_ENCH('GuiLoad_Always')] = 'always',
		[_ENCH('GuiLoad_Never')] = 'never',
	}
end

function registerKhaos()
	optionSet = {
		id="Enchantrix";
		text="Enchantrix";
		helptext=function()
			return _ENCH('GuiMainHelp');
		end;
		difficulty=1;
		default={checked=true};
		options={
			{
				id="Header";
				text="Enchantrix";
				helptext=function()
					return _ENCH('GuiMainHelp')
				end;
				type=K_HEADER;
				difficulty=1;
			};
			{
				id="all";
				type=K_TEXT;
				text=function()
					return _ENCH('GuiMainEnable')
				end;
				helptext=function()
					return _ENCH('HelpOnoff')
				end;
				callback=function(state)
					if (state.checked) then
						onOff('on');
					else
						onOff('off');
					end
				end;
				feedback=function(state)
					if (state.checked) then
						return _ENCH('StatOn');
					else
						return _ENCH('StatOff');
					end
				end;
				check=true;
				default={checked=Enchantrix.Config.GetFilterDefaults('all')};
				disabled={checked=false};
				difficulty=1;
			};
			{
				id="barker";
				type=K_TEXT;
				text=function()
					return _ENCH('GuiBarker') -- "Enable Barker"
				end;
				helptext=function()
					return _ENCH('HelpBarker') -- "Turn Enchantrix Barker on or off"
				end;
				callback=function(state)
					genVarSet('barker', state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return _ENCH('BarkerOn')
					else
						return _ENCH('BarkerOff')
					end
				end;
				check=true;
				default={checked=Enchantrix.Config.GetFilterDefaults('barker')};
				disabled={checked=false};
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
					return _ENCH('GuiLocale')
				end;
				helptext=function()
					return _ENCH('HelpLocale')
				end;
				callback = function(state)
				end;
				feedback = function (state)
					Enchantrix.Config.SetLocale(state.value);
					return string.format(_ENCH('FrmtActSet'), _ENCH('CmdLocale'), state.value);
				end;
				default = {
					value = Enchantrix.Config.GetLocale();
				};
				disabled = {
					value = Enchantrix.Config.GetLocale();
				};
				dependencies={all={checked=true;}};
				difficulty=2;
			};
			{
				id="LoadSettings";
				type=K_PULLDOWN;
				setup = {
					options = getKhaosLoadList;
					multiSelect = false;
				};
				text=function()
					return _ENCH('GuiLoad')
				end;
				helptext=function()
					return _ENCH('HelpLoad')
				end;
				callback=function(state) end;
				feedback=function(state)
					handleCommand("load " .. state.value, "GUI");
				end;
				default={value = 'always'};
				disabled={value = 'never'};
				difficulty=1;
			};
			{
				id="embed";
				type=K_TEXT;
				text=function()
					return _ENCH('GuiEmbed')
				end;
				helptext=function()
					return _ENCH('HelpEmbed')
				end;
				callback=function(state)
					genVarSet('embed', state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_ENCH('FrmtActEnable'), _ENCH('ShowEmbed')));
					else
						return (string.format(_ENCH('FrmtActDisable'), _ENCH('ShowEmbed')));
					end
				end;
				check=true;
				default={checked=Enchantrix.Config.GetFilterDefaults('embed')};
				disabled={checked=false};
				dependencies={all={checked=true;}};
				difficulty=1;
			};
			{
				id="terse";
				type=K_TEXT;
				text=function()
					return _ENCH('GuiTerse')
				end;
				helptext=function()
					return _ENCH('HelpTerse')
				end;
				callback=function(state)
					genVarSet('terse', state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_ENCH('FrmtActEnable'), _ENCH('ShowTerse')));
					else
						return (string.format(_ENCH('FrmtActDisable'), _ENCH('ShowTerse')));
					end
				end;
				check=true;
				default={checked=Enchantrix.Config.GetFilterDefaults('terse')};
				disabled={checked=false};
				dependencies={all={checked=true;}};
				difficulty=2;
			};
			{
				id="counts";
				type=K_TEXT;
				text=function()
					return _ENCH('GuiCount')
				end;
				helptext=function()
					return _ENCH('HelpCount')
				end;
				callback=function(state)
					genVarSet('counts', state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_ENCH('FrmtActEnable'), _ENCH('ShowCount')));
					else
						return (string.format(_ENCH('FrmtActDisable'), _ENCH('ShowCount')));
					end
				end;
				check=true;
				default={checked=Enchantrix.Config.GetFilterDefaults('counts')};
				disabled={checked=false};
				dependencies={all={checked=true;}};
				difficulty=3;
			};
			{
				id="EnchantrixValuateHeader";
				type=K_HEADER;
				text=function()
					return _ENCH('GuiValuateHeader')
				end;
				helptext=function()
					return _ENCH('HelpValue')
				end;
				difficulty=2;
			};
			{
				id="valuate";
				type=K_TEXT;
				text=function()
					return _ENCH('GuiValuateEnable')
				end;
				helptext=function()
					return _ENCH('HelpValue').."\n".._ENCH('HelpGuessNoauctioneer')
				end;
				callback=function(state)
					genVarSet('valuate', state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_ENCH('FrmtActEnable'), _ENCH('ShowValue')));
					else
						return (string.format(_ENCH('FrmtActDisable'), _ENCH('ShowValue')));
					end
				end;
				check=true;
				default={checked=Enchantrix.Config.GetFilterDefaults('valuate')};
				disabled={checked=false};
				dependencies={all={checked=true;}};
				difficulty=1;
			};
			{
				id="valuate-baseline";
				type=K_TEXT;
				text=function()
					return _ENCH('GuiValuateBaseline')
				end;
				helptext=function()
					return _ENCH('HelpGuessBaseline')
				end;
				callback=function(state)
					genVarSet('valuate-baseline', state.checked);
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_ENCH('FrmtActEnable'), _ENCH('ShowGuessBaseline')));
					else
						return (string.format(_ENCH('FrmtActDisable'), _ENCH('ShowGuessBaseline')));
					end
				end;
				check=true;
				default={checked=Enchantrix.Config.GetFilterDefaults('valuate-baseline')};
				disabled={checked=false};
				dependencies={valuate={checked=true;}, all={checked=true;}};
				difficulty=2;
			};
			{
				id="EnchantrixOtherHeader";
				type=K_HEADER;
				text=function()
					return _ENCH('GuiOtherHeader')
				end;
				helptext=function()
					return _ENCH('GuiOtherHelp')
				end;
				difficulty=1;
			};
			{
				id="EnchantrixClearAll";
				type=K_BUTTON;
				setup={
					buttonText = function()
						return _ENCH('GuiClearallButton')
					end;
				};
				text=function()
					return _ENCH('GuiClearall')
				end;
				helptext=function()
					return _ENCH('GuiClearallHelp')
				end;
				callback=function()
					clear(_ENCH('CmdClearAll'));
				end;
				feedback=function()
					return string.format(_ENCH('FrmtActClearall'),  _ENCH('GuiClearallNote'));
				end;
				dependencies={all={checked=true;}};
				difficulty=3;
			};
			{
				id="DefaultAll";
				type=K_BUTTON;
				setup={
					buttonText = function()
						return _ENCH('GuiDefaultAllButton')
					end;
				};
				text=function()
					return _ENCH('GuiDefaultAll')
				end;
				helptext=function()
					return _ENCH('GuiDefaultAllHelp')
				end;
				callback=function()
					default(_ENCH('CmdClearAll'));
				end;
				feedback=function()
					return _ENCH('FrmtActDefaultAll');
				end;
				dependencies={all={checked=true;}};
				difficulty=1;
			};
			{
				id="printframe";
				type=K_PULLDOWN;
				setup = {
					options = Enchantrix.Config.GetFrameNames;
					multiSelect = false;
				};
				text=function()
					return _ENCH('GuiPrintin')
				end;
				helptext=function()
					return _ENCH('HelpPrintin')
				end;
				callback=function(state)
					Enchantrix.Config.SetFrame(state.value);
				end;
				feedback=function(state)
					local _, frameName = Enchantrix.Config.GetFrameNames(state.value)
					return string.format(_ENCH('FrmtPrintin'), frameName);
				end;
				default = {
					value=Enchantrix.Config.GetFrameIndex();
				};
				disabled = {
					value=Enchantrix.Config.GetFrameIndex();
				};
				dependencies={all={checked=true;}};
				difficulty=3;
			};
			{
				id="DefaultOption";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function()
					return _ENCH('GuiDefaultOption')
				end;
				helptext=function()
					return _ENCH('HelpDefault')
				end;
				callback = function(state)
					default(state.value);
				end;
				feedback = function (state)
					if (state.value == _ENCH('CmdClearAll')) then
						return _ENCH('FrmtActDefaultAll');
					else
						return string.format(_ENCH('FrmtActDefault'), state.value);
					end
				end;
				default = {
					value = "";
				};
				disabled = {
					value = "";
				};
				dependencies={all={checked=true;}};
				difficulty=4;
			};
		};
	};

	Khaos.registerOptionSet("tooltip",optionSet);
	Enchantrix.State.Khaos_Registered = true;
	Khaos.refresh();

	return true;
end

function registerAuctioneerOptions()
	local insertPos
	for key, value in ipairs(optionSet.options) do
		if value.id == "valuate" then
			insertPos = key + 1
		end
	end

	if (optionSet.options[insertPos].id == 'valuate-hsp') then
		return
	end

	local AuctioneerOptions = {
		{
			id="valuate-hsp";
			type=K_TEXT;
			text=function()
				return _ENCH('GuiValuateAverages')
			end;
			helptext=function()
				return _ENCH('HelpGuessAuctioneerHsp')
			end;
			callback=function(state)
				genVarSet('valuate-hsp', state.checked);
			end;
			feedback=function(state)
				if (state.checked) then
					return (string.format(_ENCH('FrmtActEnable'), _ENCH('ShowGuessAuctioneerHsp')));
				else
					return (string.format(_ENCH('FrmtActDisable'), _ENCH('ShowGuessAuctioneerHsp')));
				end
			end;
			check=true;
			default={checked = Enchantrix.Config.GetFilterDefaults('valuate-hsp')};
			disabled={checked = false};
			dependencies={valuate={checked=true;}, all={checked=true;}};
			difficulty=2;
		};
		{
			id="valuate-median";
			type=K_TEXT;
			text=function()
				return _ENCH('GuiValuateMedian')
			end;
			helptext=function()
				return _ENCH('HelpGuessAuctioneerMedian')
			end;
			callback=function(state)
				genVarSet('valuate-median', state.checked);
			end;
			feedback=function(state)
				if (state.checked) then
					return (string.format(_ENCH('FrmtActEnable'), _ENCH('ShowGuessAuctioneerMed')));
				else
					return (string.format(_ENCH('FrmtActDisable'), _ENCH('ShowGuessAuctioneerMed')));
				end
			end;
			check=true;
			default={checked = Enchantrix.Config.GetFilterDefaults('valuate-median')};
			disabled={checked = false};
			dependencies={valuate={checked=true;}, all={checked=true;}};
			difficulty=2;
		};
	};

	optionSet.options[insertPos - 1].helptext = function() return _ENCH('HelpValue') end;

	for i, opt in ipairs(AuctioneerOptions) do
		tinsert(optionSet.options, insertPos + i - 1, opt);
	end

	Khaos.unregisterOptionSet("Enchantrix");
	Khaos.registerOptionSet("tooltip", optionSet);
	Khaos.refresh();
end

function auctioneerLoaded()
	Stubby.UnregisterAddOnHook("Auctioneer", "Enchantrix")

	-- Make sure we have a usable version of Auctioneer loaded (3.4 or higher)
	if Auctioneer and Auctioneer.Version then
		local ver = Enchantrix.Util.Split(Auctioneer.Version, ".")
		local major = tonumber(ver[1]) or 0
		local minor = tonumber(ver[2]) or 0
		if ver[3] == "DEV" then minor = minor + 1 end

		if major > 3 or (major >= 3 and minor >= 4) then
			Enchantrix.State.Auctioneer_Loaded = true
		end
	end

	if not Enchantrix.State.Auctioneer_Loaded then
		-- Old version of Auctioneer
		if not EnchantConfig.displayedAuctioneerWarning then
			-- Yell at the user, but only once
			message(_ENCH('MesgAuctVersion'))
			EnchantConfig.displayedAuctioneerWarning = true
		else
			Enchantrix.Util.ChatPrint(_ENCH('MesgAuctVersion'))
		end
		return
	end
	EnchantConfig.displayedAuctioneerWarning = nil

	if Enchantrix.State.Khaos_Registered then
		registerAuctioneerOptions()
	end
end

function setKhaosSetKeyParameter(key, parameter, value)
	if (Enchantrix.State.Khaos_Registered) then
		if (Khaos.getSetKey("Enchantrix", key)) then
			Khaos.setSetKeyParameter("Enchantrix", key, parameter, value)
		else
			EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): key " .. key .. " does not exist")
		end
	end
end

function setKhaosSetKeyValue(key, value)
	if (Enchantrix.State.Khaos_Registered) then
		local kKey = Khaos.getSetKey("Enchantrix", key)

		if (not kKey) then
			EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): key " .. key .. " does not exist")
		elseif (kKey.checked ~= nil) then
			-- EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): setting ", value, " for key ", key)
			Khaos.setSetKeyParameter("Enchantrix", key, "checked", value)
		elseif (kKey.value ~= nil) then
			Khaos.setSetKeyParameter("Enchantrix", key, "value", value)
		else
			EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): don't know how to update key ", key)
		end
	end
end

-- Cleaner Command Handling Functions (added by MentalPower)
function handleCommand(command, source)

	-- To print or not to print, that is the question...
	local chatprint = nil;
	if (source == "GUI") then
		chatprint = false;
	else
		chatprint = true;
	end;

	-- Divide the large command into smaller logical sections (Shameless copy from the original function)
	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$")
	if (not cmd) then cmd = command end
	if (not cmd) then cmd = "" end
	if (not param) then param = "" end
	cmd = Enchantrix.Locale.DelocalizeCommand(cmd)

	if ((cmd == "") or (cmd == "help")) then
		-- /enchantrix help
		chatPrintHelp();
		return;

	elseif ((cmd == "on") or (cmd == "off") or (cmd == "toggle")) then
		-- /enchantrix on|off|toggle
		onOff(cmd, chatprint);

	elseif (cmd == 'disable') then
		-- /enchantrix disable
		Enchantrix.Util.ChatPrint(_ENCH('MesgDisable'));
		Stubby.SetConfig("Enchantrix", "LoadType", "never");

	elseif (cmd == 'load') then
		-- /enchantrix load always|never
		if (param == "always") or (param == "never") then
			Stubby.SetConfig("Enchantrix", "LoadType", param);
			if (chatprint) then
				Enchantrix.Util.ChatPrint("Setting Enchantrix to "..param.." load for this toon");
				setKhaosSetKeyValue("LoadSettings", param)
			end
		end

	elseif (cmd == 'clear') then
		-- /enchantrix clear
		clear(param, chatprint);

	elseif (cmd == 'locale') then
		-- /enchantrix locale
		Enchantrix.Config.SetLocale(param, chatprint);

	elseif (cmd == 'default') then
		-- /enchantrix default
		default(param, chatprint);

	elseif (cmd == 'print-in') then
		-- /enchantrix print-in
		Enchantrix.Config.SetFrame(param, chatprint)

	elseif (cmd == 'bidbroker' or cmd == 'bb') then
		-- /enchantrix bidbroker
		doBidBroker(param);

	elseif (cmd == 'percentless' or cmd == 'pl') then
		doPercentLess(param);

	elseif (Enchantrix.Config.GetFilterDefaults(cmd) ~= nil) then
		genVarSet(cmd, param, chatprint);

	elseif (chatprint) then
		Enchantrix.Util.ChatPrint(string.format(_ENCH('FrmtActUnknown'), cmd));
	end
end

-- Help ME!! (The Handler) (Another shameless copy from the original function)
function chatPrintHelp()
	Enchantrix.Util.ChatPrint(_ENCH('FrmtUsage'));
	local onOffToggle = " (".._ENCH('CmdOn').."|".._ENCH('CmdOff').."|".._ENCH('CmdToggle')..")";
	local lineFormat = "  |cffffffff/enchantrix %s "..onOffToggle.."|r |cff2040ff[%s]|r - %s";

	Enchantrix.Util.ChatPrint("  |cffffffff/enchantrix "..onOffToggle.."|r |cff2040ff["..Enchantrix.Locale.GetLocalizedFilterVal('all').."]|r - " .. _ENCH('HelpOnoff'));

	Enchantrix.Util.ChatPrint("  |cffffffff/enchantrix ".._ENCH('CmdDisable').."|r - " .. _ENCH('HelpDisable'));

	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('CmdBarker'), Enchantrix.Locale.GetLocalizedFilterVal('barker'), _ENCH('HelpBarker')));

	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('ShowCount'), Enchantrix.Locale.GetLocalizedFilterVal('counts'), _ENCH('HelpCount')));
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('ShowTerse'), Enchantrix.Locale.GetLocalizedFilterVal('terse'), _ENCH('HelpTerse')));
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('ShowEmbed'), Enchantrix.Locale.GetLocalizedFilterVal('embed'), _ENCH('HelpEmbed')));
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('ShowValue'), Enchantrix.Locale.GetLocalizedFilterVal('valuate'), _ENCH('HelpValue')));
	if Enchantrix.State.Auctioneer_Loaded then
		Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('ShowGuessAuctioneerHsp'), Enchantrix.Locale.GetLocalizedFilterVal('valuate-hsp'), _ENCH('HelpGuessAuctioneerHsp')));
		Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('ShowGuessAuctioneerMed'), Enchantrix.Locale.GetLocalizedFilterVal('valuate-median'), _ENCH('HelpGuessAuctioneerMedian')));
	else
		Enchantrix.Util.ChatPrint(_ENCH('HelpGuessNoauctioneer'));
	end
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('ShowGuessBaseline'), Enchantrix.Locale.GetLocalizedFilterVal('valuate-baseline'), _ENCH('HelpGuessBaseline')));

	lineFormat = "  |cffffffff/enchantrix %s %s|r - %s";
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('CmdLocale'), _ENCH('OptLocale'), _ENCH('HelpLocale')));
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('CmdClear'), _ENCH('OptClear'), _ENCH('HelpClear')));

	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('CmdFindBidauct'), _ENCH('OptFindBidauct'), _ENCH('HelpFindBidauct')));
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('CmdFindBuyauct'), _ENCH('OptFindBuyauct'), _ENCH('HelpFindBuyauct')));
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('CmdDefault'), _ENCH('OptDefault'), _ENCH('HelpDefault')));
	Enchantrix.Util.ChatPrint(string.format(lineFormat, _ENCH('CmdPrintin'), _ENCH('OptPrintin'), _ENCH('HelpPrintin')));
end
--[[
	The onOff(state, chatprint) function handles the state of the Enchantrix AddOn (whether it is currently on or off)
	If "on" or "off" is specified in the "state" variable then Enchantrix's state is changed to that value,
	If "toggle" is specified then it will toggle Enchantrix's state (if currently on then it will be turned off and vice-versa)

	If a boolean (or nil) value is passed as the first argument the conversion is as follows:
	"true" is the same as "on"
	"false" is the same as "off"
	"nil" is the same as "toggle"

	If chatprint is "true" then the state will also be printed to the user.
]]
function onOff(state, chatprint)
	if (type(state) == "string") then
		state = Enchantrix.Locale.DelocalizeFilterVal(state)

	elseif (state == true) then
		state = 'on'

	elseif (state == false) then
		state = 'off'

	elseif (state == nil) then
		state = 'toggle'
	end

	if (state == 'on') or (state == 'off') then
		Enchantrix.Config.SetFilter('all', state);
	elseif (state == "toggle") then
		Enchantrix.Config.SetFilter('all', not Enchantrix.Config.GetFilter('all'))
	end

	-- Print the change and alert the GUI if the command came from slash commands. Do nothing if they came from the GUI.
	if (chatprint) then
		state = Enchantrix.Config.GetFilter('all')
		setKhaosSetKeyParameter('all', "checked", state);

		if (state) then
			Enchantrix.Util.ChatPrint(_ENCH('StatOn'));

		else
			Enchantrix.Util.ChatPrint(_ENCH('StatOff'));
		end
	end

	return state;
end

-- The following functions are almost verbatim copies of the original functions but modified in order to make them compatible with direct GUI access.
function clear(param, chatprint)
	if (param == _ENCH('CmdClearAll')) or (param == "all") then
		EnchantedLocal = {}
		if (chatprint) then
			Enchantrix.Util.ChatPrint(_ENCH('FrmtActClearall'));
		end
	else
		for link in string.gfind(param, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%b[]|h|r") do
			local sig = Enchantrix.Util.GetSigFromLink(link)
			EnchantedLocal[sig] = nil

			if (chatprint) then
				Enchantrix.Util.ChatPrint(string.format(_ENCH('FrmtActClearOk'), link))
			end
		end
	end
end

-- This function was added by MentalPower to implement the /enx default command
function default(param, chatprint)
	local paramLocalized

	if (param == nil) or (param == "") then
		return
	elseif (param == _ENCH('CmdClearAll')) or (param == "all") then
		param = "all"
		EnchantConfig.filters = {}
	else
		paramLocalized = param
		param = Enchantrix.Locale.DelocalizeCommand(param)
		Enchantrix.Config.SetFilter(param, nil)
	end

	if (chatprint) then
		if (param == "all") then
			Enchantrix.Util.ChatPrint(_ENCH('FrmtActDefaultAll'));

			for k,v in pairs(EnchantConfig.filters) do
				setKhaosSetKeyValue(k, Enchantrix.Config.GetFilter(k));
			end

		else
			Enchantrix.Util.ChatPrint(string.format(_ENCH('FrmtActDefault'), paramLocalized));
			setKhaosSetKeyValue(param, Enchantrix.Config.GetFilter(param));
		end
	end
end

function genVarSet(variable, param, chatprint)

	param = Enchantrix.Locale.DelocalizeFilterVal(param);

	if (param == 'on' or param == 'off' or param == true or param == false) then
		Enchantrix.Config.SetFilter(variable, param);

	elseif (param == 'toggle' or param == nil or param == "") then
		Enchantrix.Config.SetFilter(variable, not Enchantrix.Config.GetFilter(variable))
	end

	if (chatprint) then
		if (Enchantrix.Config.GetFilter(variable)) then
			Enchantrix.Util.ChatPrint(string.format(_ENCH('FrmtActEnable'), Enchantrix.Locale.LocalizeCommand(variable)));
			setKhaosSetKeyParameter(variable, "checked", true);

		else
			Enchantrix.Util.ChatPrint(string.format(_ENCH('FrmtActDisable'), Enchantrix.Locale.LocalizeCommand(variable)));
			setKhaosSetKeyParameter(variable, "checked", false);
		end
	end
end

---------------------------------------
--   Auctioneer dependant commands   --
---------------------------------------

function percentLessFilter(percentLess, signature)
	local filterAuction = true;
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(signature);
	local disenchantsTo = getAuctionItemDisenchants(signature, true);
	if not disenchantsTo.totals then return filterAuction; end

	local hspValue = disenchantsTo.totals.hspValue or 0;
	local medValue = disenchantsTo.totals.medValue or 0;
	local mktValue = disenchantsTo.totals.mktValue or 0;
	local confidence = disenchantsTo.totals.conf or 0;

	local myValue = confidence * (hspValue + medValue + mktValue) / 3;
	local margin = Auctioneer.Statistic.PercentLessThan(myValue, buyout/count);
	local profit = (myValue * count) - buyout;

	local results = {
		buyout = buyout,
		count = count,
		value = myValue,
		margin = margin,
		profit = profit,
		conf = confidence
	};
	if (buyout > 0) and (margin >= tonumber(percentLess)) and (profit >= MIN_PROFIT_MARGIN) then
		filterAuction = false;
		profitMargins[signature] = results;
	end

	return filterAuction;
end

function bidBrokerFilter(minProfit, signature)
	local filterAuction = true;
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(signature);
	local currentBid = Auctioneer.Statistic.GetCurrentBid(signature);
	local disenchantsTo = getAuctionItemDisenchants(signature, true);
	if not disenchantsTo.totals then return filterAuction; end

	local hspValue = disenchantsTo.totals.hspValue or 0;
	local medValue = disenchantsTo.totals.medValue or 0;
	local mktValue = disenchantsTo.totals.mktValue or 0;
	local confidence = disenchantsTo.totals.conf or 0;

	local myValue = confidence * (hspValue + medValue + mktValue) / 3;
	local margin = Auctioneer.Statistic.PercentLessThan(myValue, currentBid/count);
	local profit = (myValue * count) - currentBid;
	local profitPricePercent = math.floor((profit / currentBid) * 100);

	local results = {
		buyout = buyout,
		count = count,
		value = myValue,
		margin = margin,
		profit = profit,
		conf = confidence
	};
	if (currentBid <= MAX_BUYOUT_PRICE) and (profit >= tonumber(minProfit)) and (profit >= MIN_PROFIT_MARGIN) and (profitPricePercent >= MIN_PROFIT_PRICE_PERCENT) then
		filterAuction = false;
		profitMargins[signature] = results;
	end
	return filterAuction;
end

function profitComparisonSort(a, b)
	if (not a) or (not b) then return false; end
	local aSig = a.signature;
	local bSig = b.signature;
	if (not aSig) or (not bSig) then return false; end
	local aEpm = profitMargins[aSig];
	local bEpm = profitMargins[bSig];
	if (not aEpm) and (not bEpm) then return false; end
	local aProfit = aEpm.profit or 0;
	local bProfit = bEpm.profit or 0;
	local aMargin = aEpm.margin or 0;
	local bMargin = bEpm.margin or 0;
	local aValue  = aEpm.value or 0;
	local bValue  = bEpm.value or 0;
	if (aProfit > bProfit) then return true; end
	if (aProfit < bProfit) then return false; end
	if (aMargin > bMargin) then return true; end
	if (aMargin < bMargin) then return false; end
	if (aValue > bValue) then return true; end
	if (aValue < bValue) then return false; end
	return false;
end

function bidBrokerSort(a, b)
	if (not a) or (not b) then return false; end
	local aTime = a.timeLeft or 0;
	local bTime = b.timeLeft or 0;
	if (aTime > bTime) then return true; end
	if (aTime < bTime) then return false; end
	return profitComparisonSort(a, b);
end

function doPercentLess(percentLess)
	if not Auctioneer then
		Enchantrix.Util.ChatPrint("You do not have Auctioneer installed. Auctioneer must be installed to do an enchanting percentless scan");
		return;
	elseif not (Auctioneer.Filter or Auctioneer.Filter.QuerySnapshot) then
		Enchantrix.Util.ChatPrint("You do not have the correct version of Auctioneer installed, this feature requires Auctioneer v3.3.0.0675 or later");
		return;
	end

	if not percentLess or percentLess == "" then percentLess = MIN_PERCENT_LESS_THAN_HSP end
	local output = string.format(_ENCH('FrmtPctlessHeader'), percentLess);
	Enchantrix.Util.ChatPrint(output);

	Enchantrix.Storage.Price_Cache = {t=time()};
	profitMargins = {};
	local targetAuctions = Auctioneer.Filter.QuerySnapshot(percentLessFilter, percentLess);

	-- sort by profit based on median
	table.sort(targetAuctions, profitComparisonSort);

	-- output the list of auctions
	for _,a in targetAuctions do
		if (a.signature and profitMargins[a.signature]) then
			local quality = EnhTooltip.QualityFromLink(a.itemLink);
			if (quality and quality >= 2) then
				local id,rprop,enchant, name, count,_,buyout,_ = Auctioneer.Core.GetItemSignature(a.signature);
				local value = profitMargins[a.signature].value;
				local margin = profitMargins[a.signature].margin;
				local profit = profitMargins[a.signature].profit;
				local output = string.format(_ENCH('FrmtPctlessLine'), Auctioneer.Util.ColorTextWhite(count.."x")..a.itemLink, EnhTooltip.GetTextGSC(value * count), EnhTooltip.GetTextGSC(buyout), EnhTooltip.GetTextGSC(profit * count), Auctioneer.Util.ColorTextWhite(margin.."%"));
				Enchantrix.Util.ChatPrint(output);
			end
		end
	end

	Enchantrix.Util.ChatPrint(_ENCH('FrmtPctlessDone'));
end

function doBidBroker(minProfit)
	if not Auctioneer then
		Enchantrix.Util.ChatPrint("You do not have Auctioneer installed. Auctioneer must be installed to do an enchanting percentless scan");
		return;
	elseif not (Auctioneer.Filter and Auctioneer.Filter.QuerySnapshot) then
		Enchantrix.Util.ChatPrint("You do not have the correct version of Auctioneer installed, this feature requires Auctioneer v3.3.0.0675 or later");
		return;
	end

	if not minProfit or minProfit == "" then minProfit = MIN_PROFIT_MARGIN; else minProfit = tonumber(minProfit) * 100; end
	local output = string.format(_ENCH('FrmtBidbrokerHeader'), EnhTooltip.GetTextGSC(minProfit));
	Enchantrix.Util.ChatPrint(output);

	Enchantrix.Storage.Price_Cache = {t=time()};
	profitMargins = {};
	local targetAuctions = Auctioneer.Filter.QuerySnapshot(bidBrokerFilter, minProfit);

	-- sort by profit based on median
	table.sort(targetAuctions, bidBrokerSort);

	-- output the list of auctions
	for _,a in targetAuctions do
		if (a.signature and profitMargins[a.signature]) then
			local quality = EnhTooltip.QualityFromLink(a.itemLink);
			if (quality and quality >= 2) then
				local id,rprop,enchant, name, count, min, buyout,_ = Auctioneer.Core.GetItemSignature(a.signature);
				local currentBid = Auctioneer.Statistic.GetCurrentBid(a.signature);
				local value = profitMargins[a.signature].value;
				local margin = profitMargins[a.signature].margin;
				local profit = profitMargins[a.signature].profit;
				local bidText = _ENCH('FrmtBidbrokerCurbid');
				if (currentBid == min) then
					bidText = _ENCH('FrmtBidbrokerMinbid');
				end
				local output = string.format(_ENCH('FrmtBidbrokerLine'), Auctioneer.Util.ColorTextWhite(count.."x")..a.itemLink, EnhTooltip.GetTextGSC(value * count), bidText, EnhTooltip.GetTextGSC(currentBid), EnhTooltip.GetTextGSC(profit * count), Auctioneer.Util.ColorTextWhite(margin.."%"), Auctioneer.Util.ColorTextWhite(Auctioneer.Util.GetTimeLeftString(a.timeLeft)));
				Enchantrix.Util.ChatPrint(output);
			end
		end
	end

	Enchantrix.Util.ChatPrint(_ENCH('FrmtBidbrokerDone'));
end

function getAuctionItemDisenchants(auctionSignature, useCache)
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(auctionSignature);
	local sig = string.format("%d:%d:%d", id, enchant, rprop);
	return Enchantrix.Storage.GetItemDisenchants(sig, name, useCache);
end

Enchantrix.Command = {
	Revision					= "$Revision: 944 $",

	AddonLoaded				= addonLoaded,
	AuctioneerLoaded			= auctioneerLoaded,

	HandleCommand			= handleCommand,

	Register					= register,
	SetKhaosSetKeyValue		= setKhaosSetKeyValue,
	SetKhaosSetKeyParameter	= setKhaosSetKeyParameter,
	SetKhaosSetKeyValue		= setKhaosSetKeyValue,
}

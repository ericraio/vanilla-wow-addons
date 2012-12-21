--[[
	Informant
	An addon for World of Warcraft that shows pertinent information about
	an item in a tooltip when you hover over the item in the game.
	3.8.0 (Kangaroo)
	$Id: InfCommand.lua 854 2006-05-10 04:23:18Z mentalpower $
	Command handler. Assumes responsibility for allowing the user to set the
	options via slash command, Khaos, MyAddon etc.

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
--]]

-- function prototypes
local commandHandler, cmdHelp, onOff, genVarSet, chatPrint, registerKhaos, restoreDefault, cmdLocale, setLocale, isValidLocale
local setKhaosSetKeyValue

-- Localization function prototypes
local delocalizeFilterVal, localizeFilterVal, getLocalizedFilterVal, delocalizeCommand, localizeCommand, buildCommandMap

local commandMap = nil;
local commandMapRev = nil;

Informant_Khaos_Registered = nil

Informant.InitCommands = function()
	SLASH_INFORMANT1 = "/informant"
	SLASH_INFORMANT2 = "/inform"
	SLASH_INFORMANT3 = "/info"
	SLASH_INFORMANT4 = "/inf"
	SlashCmdList["INFORMANT"] = function(msg)
		commandHandler(msg, nil)
	end

	chatPrint(string.format(_INFM('FrmtWelcome'), INFORMANT_VERSION))

	if (Khaos) then
		registerKhaos()
	end
end

function setKhaosSetKeyValue(key, value)
	if (Informant_Khaos_Registered) then
		local kKey = Khaos.getSetKey("Informant", key)

		if (not kKey) then
			EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): key " .. key .. " does not exist")
		elseif (kKey.checked ~= nil) then
			if (type(value) == "string") then value = (value == "on"); end
			Khaos.setSetKeyParameter("Informant", key, "checked", value)
		elseif (kKey.value ~= nil) then
			Khaos.setSetKeyParameter("Informant", key, "value", value)
		else
			EnhTooltip.DebugPrint("setKhaosSetKeyValue(): don't know how to update key ", key)
		end
	end
end

function buildCommandMap()
	commandMap = {
		[_INFM('CmdOn')]			=	'on',
		[_INFM('CmdOff')]			=	'off',
		[_INFM('CmdHelp')]			=	'help',
		[_INFM('CmdToggle')]		=	'toggle',
		[_INFM('CmdDisable')]		=	'disable',
		[_INFM('CmdLocale')]		=	'locale',
		[_INFM('CmdDefault')]		=	'default',
		[_INFM('CmdEmbed')]			=	'embed',
		[_INFM('ShowIcon')]			=	'show-icon',
		[_INFM('ShowStack')]		=	'show-stack',
		[_INFM('ShowUsage')]		=	'show-usage',
		[_INFM('ShowQuest')]		=	'show-quest',
		[_INFM('ShowMerchant')]		=	'show-merchant',
		[_INFM('ShowVendor')]		=	'show-vendor',
		[_INFM('ShowVendorBuy')]	=	'show-vendor-buy',
		[_INFM('ShowVendorSell')]	=	'show-vendor-sell',
	}

	commandMapRev = {}
	for k,v in pairs(commandMap) do
		commandMapRev[v] = k;
	end
end

--Cleaner Command Handling Functions (added by MentalPower)
function commandHandler(command, source)
	--To print or not to print, that is the question...
	local chatprint = nil
	if (source == "GUI") then chatprint = false
	else chatprint = true end

	--Divide the large command into smaller logical sections (Shameless copy from the original function)
	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$")
	if (not cmd) then cmd = command end
	if (not cmd) then cmd = "" end
	if (not param) then param = "" end
	cmd = delocalizeCommand(cmd);

	--Now for the real Command handling
	if ((cmd == "") or (cmd == "help")) then
		cmdHelp()
		return

	elseif (cmd == "on" or cmd == "off" or cmd == "toggle") then
		onOff(cmd, chatprint)
	elseif (cmd == "disable") then
		Stubby.SetConfig("Informant", "LoadType", "never");
	elseif (cmd == "load") then
		if (param == "always") or (param == "never") then
			chatPrint("Setting Informant to "..param.." load for this toon");
			Stubby.SetConfig("Informant", "LoadType", param);
		end
	elseif (cmd == "locale") then
		setLocale(param, chatprint)
	elseif (cmd == "default") then
		restoreDefault(param, chatprint)
	elseif (cmd == "embed" or cmd == "show-stack" or cmd == "show-usage" or
			cmd == "show-quest" or cmd == "show-merchant" or cmd == "show-vendor" or
			cmd == "show-vendor-buy" or cmd == "show-vendor-sell" or cmd == "show-icon") then
		genVarSet(cmd, param, chatprint)
	else
		if (chatprint) then
			chatPrint(string.format(_INFM('FrmtActUnknown'), cmd))
		end
	end
end

--Help ME!! (The Handler) (Another shameless copy from the original function)
function cmdHelp()

	local onOffToggle = " (".._INFM('CmdOn').."|".._INFM('CmdOff').."|".._INFM('CmdToggle')..")"
	local lineFormat = "  |cffffffff/informant %s "..onOffToggle.."|r |cffff4020[%s]|r - %s"

	chatPrint(_INFM('TextUsage'))
	chatPrint("  |cffffffff/informant "..onOffToggle.."|r |cffff4020["..getLocalizedFilterVal('all').."]|r - " .. _INFM('HelpOnoff'))

	chatPrint("  |cffffffff/informant ".._INFM('CmdDisable').."|r - " .. _INFM('HelpDisable'));

	chatPrint(string.format(lineFormat, _INFM('ShowVendor'), getLocalizedFilterVal('show-vendor'), _INFM('HelpVendor')))
	chatPrint(string.format(lineFormat, _INFM('ShowVendorSell'), getLocalizedFilterVal('show-vendor-sell'), _INFM('HelpVendorSell')))
	chatPrint(string.format(lineFormat, _INFM('ShowVendorBuy'), getLocalizedFilterVal('show-vendor-buy'), _INFM('HelpVendorBuy')))
	chatPrint(string.format(lineFormat, _INFM('ShowUsage'), getLocalizedFilterVal('show-usage'), _INFM('HelpUsage')))
	chatPrint(string.format(lineFormat, _INFM('ShowMerchant'), getLocalizedFilterVal('show-merchant'), _INFM('HelpMerchant')))
	chatPrint(string.format(lineFormat, _INFM('ShowStack'), getLocalizedFilterVal('show-stack'), _INFM('HelpStack')))
	chatPrint(string.format(lineFormat, _INFM('ShowIcon'), getLocalizedFilterVal('show-icon'), _INFM('HelpIcon')))
	chatPrint(string.format(lineFormat, _INFM('CmdEmbed'), getLocalizedFilterVal('embed'), _INFM('HelpEmbed')))

	lineFormat = "  |cffffffff/informant %s %s|r |cffff4020[%s]|r - %s"
	chatPrint(string.format(lineFormat, _INFM('CmdLocale'), _INFM('OptLocale'), getLocalizedFilterVal('locale'), _INFM('HelpLocale')))

	lineFormat = "  |cffffffff/informant %s %s|r - %s"
	chatPrint(string.format(lineFormat, _INFM('CmdDefault'), "", _INFM('HelpDefault')))
end

--The onOff(state, chatprint) function handles the state of the Informant AddOn (whether it is currently on or off)
--If "on" or "off" is specified in the " state" variable then Informant's state is changed to that value,
--If "toggle" is specified then it will toggle Informant's state (if currently on then it will be turned off and vice-versa)
--If no keyword is specified then the functione will simply return the current state
--
--If chatprint is "true" then the state will also be printed to the user.

function onOff(state, chatprint)

	if ((state == nil) or (state == "")) then
		state = Informant.GetFilterVal("all")


	elseif ((state == _INFM('CmdOn')) or (state == "on")) then
		Informant.SetFilter("all", "on")


	elseif ((state == _INFM('CmdOff')) or (state == "off")) then
		Informant.SetFilter("all", "off")


	elseif ((state == _INFM('CmdToggle')) or (state == "toggle")) then
		Informant.SetFilter("all", not Informant.GetFilter("all"))
		state = Informant.GetFilterVal("all")


	end

	--Print the change and alert the GUI if the command came from slash commands. Do nothing if they came from the GUI.
	if (chatprint == true) then
		if ((state == _INFM('CmdOn')) or (state == "on")) then
			chatPrint(_INFM('StatOn'))

			if (Informant_Khaos_Registered) then
				Khaos.setSetKeyParameter("Informant", "enabled", "checked", true)
			end
		else
			chatPrint(_INFM('StatOff'))

			if (Informant_Khaos_Registered) then
				Khaos.setSetKeyParameter("Informant", "enabled", "checked", false)
			end
		end
	end

	return state
end

function restoreDefault(param, chatprint)
	local oldLocale = InformantConfig.filters['locale']
	local paramLocalized

	if ( (param == nil) or (param == "") ) then
		return
	elseif ((param == _INFM('CmdClearAll')) or (param == "all")) then
		param = "all";
		InformantConfig.filters = {};
	else
		paramLocalized = param
		param = delocalizeCommand(param)
		Informant.SetFilter(param, nil);
	end

	-- Apply defaults for settings that went missing
	Informant.SetFilterDefaults();

	-- Apply new locale if needed
	if (oldLocale ~= InformantConfig.filters['locale']) then setLocale(InformantConfig.filters['locale']); end

	if (chatprint) then
		if (param == "all") then
			chatPrint(_INFM('FrmtActDefaultall'));
			for k,v in pairs(InformantConfig.filters) do
				setKhaosSetKeyValue(k, Informant.GetFilterVal(k));
			end
		else
			chatPrint(string.format(_INFM('FrmtActDefault'), paramLocalized));
			setKhaosSetKeyValue(param, Informant.GetFilterVal(param));
		end
	end
end

function genVarSet(variable, param, chatprint)
	if (type(param) == "string") then
		param = delocalizeFilterVal(param);
	end

	if (param == "on" or param == "off" or type(param) == "boolean") then
		Informant.SetFilter(variable, param);
	elseif (param == "toggle" or param == nil or param == "") then
		param = Informant.SetFilter(variable, not Informant.GetFilter(variable));
	end

	if (chatprint) then
		if (Informant.GetFilter(variable)) then
			chatPrint(string.format(_INFM('FrmtActEnable'), localizeCommand(variable)))
			setKhaosSetKeyValue(variable, true)
		else
			chatPrint(string.format(_INFM('FrmtActDisable'), localizeCommand(variable)))
			setKhaosSetKeyValue(variable, false)
		end
	end
end

local function getKhaosLocaleList()
	local options = { [_INFM('CmdDefault')] = 'default' };
	for locale, data in InformantLocalizations do
		options[locale] = locale;
	end
	return options
end

function registerKhaos()
	local optionSet = {
		id="Informant";
		text="Informant";
		helptext=function() 
			return _INFM('GuiMainHelp')
		end;
		difficulty=1;
		default={checked=true};
		options={
			{
				id="Header";
				text="Informant";
				helptext=function() 
					return _INFM('GuiMainHelp')
				end;
				type=K_HEADER;
				difficulty=1;
			};
			{
				id="enabled";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiMainEnable')
				end;
				helptext=function() 
					return _INFM('HelpOnoff')
				end;
				callback=function(state)
					onOff(state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return _INFM('StatOn')
					else
						return _INFM('StatOff')
					end
				end;
				check=true;
				default={checked=true};
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
					return _INFM('GuiLocale')
				end;
				helptext=function() 
					return _INFM('HelpLocale')
				end;
				callback = function(state)
				end;
				feedback = function (state)
					setLocale(state.value);
					return string.format(_INFM('FrmtActSet'), _INFM('CmdLocale'), state.value);
				end;
				default = {
					value = getLocale();
				};
				disabled = {
					value = getLocale();
				};
				dependencies={enabled={checked=true;}};
				difficulty=2;
			};
			{
				id="InformantInfoHeader";
				type=K_HEADER;
				text=function() 
					return _INFM('GuiInfoHeader')
				end;
				helptext=function() 
					return _INFM('GuiInfoHelp')
				end;
				difficulty=1;
			};
			{
				id="show-icon";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiInfoIcon')
				end;
				helptext=function() 
					return _INFM('HelpIcon')
				end;
				callback=function(state)
					genVarSet("show-icon", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'),  _INFM('ShowIcon')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('ShowIcon')))
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				dependencies={enabled={checked=true}};
				difficulty=1;
			};
			{
				id="show-stack";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiInfoStack')
				end;
				helptext=function() 
					return _INFM('HelpStack')
				end;
				callback=function(state)
					genVarSet("show-stack", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'),  _INFM('ShowStack')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('ShowStack')))
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				dependencies={enabled={checked=true}};
				difficulty=1;
			};
			{
				id="show-usage";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiInfoUsage')
				end;
				helptext=function() 
					return _INFM('HelpUsage')
				end;
				callback=function(state)
					genVarSet("show-usage", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'),  _INFM('ShowUsage')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('ShowUsage')))
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				dependencies={enabled={checked=true}};
				difficulty=1;
			};
			{
				id="show-quest";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiInfoQuest')
				end;
				helptext=function() 
					return _INFM('HelpQuest')
				end;
				callback=function(state)
					genVarSet("show-quest", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'),  _INFM('ShowQuest')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('ShowQuest')))
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				dependencies={enabled={checked=true}};
				difficulty=1;
			};
			{
				id="show-merchant";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiInfoMerchant')
				end;
				helptext=function() 
					return _INFM('HelpMerchant')
				end;
				callback=function(state)
					genVarSet("show-merchant", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'),  _INFM('ShowMerchant')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('ShowMerchant')))
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				dependencies={enabled={checked=true}};
				difficulty=1;
			};
			{
				id="InformantVendorHeader";
				type=K_HEADER;
				text=function() 
					return _INFM('GuiVendorHeader')
				end;
				helptext=function() 
					return _INFM('GuiVendorHelp')
				end;
				difficulty=1;
			};
			{
				id="show-vendor";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiVendor')
				end;
				helptext=function() 
					return _INFM('HelpVendor')
				end;
				callback=function(state)
					genVarSet("show-vendor", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'), _INFM('ShowVendor')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('ShowVendor')))
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				dependencies={enabled={checked=true}};
				difficulty=1;
			};
			{
				id="show-vendor-buy";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiVendorBuy')
				end;
				helptext=function() 
					return _INFM('HelpVendorBuy')
				end;
				callback=function(state)
					genVarSet("show-vendor-buy", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'), _INFM('ShowVendorBuy')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('ShowVendorBuy')))
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				dependencies={["show-vendor"]={checked=true}; enabled={checked=true}};
				difficulty=2;
			};
			{
				id="show-vendor-sell";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiVendorSell')
				end;
				helptext=function() 
					return _INFM('HelpVendorSell')
				end;
				callback=function(state)
					genVarSet("show-vendor-sell", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'), _INFM('ShowVendorSell')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('ShowVendorSell')))
					end
				end;
				check=true;
				default={checked=true};
				disabled={checked=false};
				dependencies={["show-vendor"]={checked=true}; enabled={checked=true}};
				difficulty=2;
			};

			{
				id="InformantEmbedHeader";
				type=K_HEADER;
				text=function() 
					return _INFM('GuiEmbedHeader')
				end;
				helptext=function() 
					return _INFM('HelpEmbed')
				end;
				difficulty=1;
			};
			{
				id="embed";
				type=K_TEXT;
				text=function() 
					return _INFM('GuiEmbed')
				end;
				helptext=function() 
					return _INFM('HelpEmbed')
				end;
				callback=function(state)
					genVarSet("embed", state.checked)
				end;
				feedback=function(state)
					if (state.checked) then
						return (string.format(_INFM('FrmtActEnable'), _INFM('CmdEmbed')))
					else
						return (string.format(_INFM('FrmtActDisable'), _INFM('CmdEmbed')))
					end
				end;
				check=true;
				default={checked=false};
				disabled={checked=false};
				dependencies={enabled={checked=true}};
				difficulty=1;
			};
			{
				id="InformantOtherHeader";
				type=K_HEADER;
				text=function() 
					return _INFM('GuiOtherHeader')
				end;
				helptext=function() 
					return _INFM('GuiOtherHelp')
				end;
				difficulty=1;
			};
			{
				id="DefaultAll";
				type=K_BUTTON;
				setup={
					buttonText = function() 
						return _INFM('GuiDefaultAllButton')
					end;
				};
				text=function() 
					return _INFM('GuiDefaultAll')
				end;
				helptext=function() 
					return _INFM('GuiDefaultAllHelp')
				end;
				callback=function()
					restoreDefault(_INFM('CmdClearAll'))
				end;
				feedback=function()
					return _INFM('FrmtActDefaultall');
				end;
				dependencies={enabled={checked=true}};
				difficulty=1;
			};
			{
				id="DefaultOption";
				type=K_EDITBOX;
				setup = {
					callOn = {"tab", "escape", "enter"};
				};
				text=function() 
					return _INFM('GuiDefaultOption')
				end;
				helptext=function() 
					return _INFM('HelpDefault')
				end;
				callback = function(state)
					restoreDefault(state.value)
				end;
				feedback = function (state)
					if (state.value == _INFM('CmdClearAll')) then
						return _INFM('FrmtActDefaultall')
					else
						return string.format(_INFM('FrmtActDefault'), state.value)
					end
				end;
				default = {
					value = ""
				};
				disabled = {
					value = ""
				};
				dependencies={enabled={checked=true}};
				difficulty=4;
			};
		};
	};

	Khaos.registerOptionSet("tooltip",optionSet)
	Informant_Khaos_Registered = true
	Khaos.refresh();

	return true
end

function isValidLocale(param)
	return (InformantLocalizations and InformantLocalizations[param])
end

function setLocale(param, chatprint)
	param = delocalizeFilterVal(param);
	local validLocale = nil;

	if (param == 'default') or (param == 'off') then
		Babylonian.SetOrder('');
		validLocale = true;

	elseif (isValidLocale(param)) then
		Babylonian.SetOrder(param);
		validLocale = true;

	else
		validLocale = false;
	end

	BINDING_HEADER_INFORMANT_HEADER = "Informant";
	BINDING_NAME_INFORMANT_POPUPDOWN = _INFM('MesgToggleWindow');

	if (chatprint) then
		if (validLocale) then
			chatPrint(string.format(_INFM('FrmtActSet'), _INFM('CmdLocale'), param));
			setKhaosSetKeyValue('locale', param);

		else
			chatPrint(string.format(_INFM("FrmtUnknownLocale"), param));
			local locales = "    ";
			for locale, data in pairs(InformantLocalizations) do
				locales = locales .. " '" .. locale .. "' ";
			end
			chatPrint(locales);
		end
	end

	commandMap = nil;
	commandMapRev = nil;
end

function chatPrint(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 0.25, 0.55, 1.0);
	end
end

--------------------------------------
--		Localization functions		--
--------------------------------------

function delocalizeFilterVal(value)
	if (value == _INFM('CmdOn')) then
		return 'on';
	elseif (value == _INFM('CmdOff')) then
		return 'off';
	elseif (value == _INFM('CmdDefault')) then
		return 'default';
	elseif (value == _INFM('CmdToggle')) then
		return 'toggle';
	else
		return value;
	end
end

function localizeFilterVal(value)
	local result
	if (value == 'on') then
		result = _INFM('CmdOn');
	elseif (value == 'off') then
		result = _INFM('CmdOff');
	elseif (value == 'default') then
		result = _INFM('CmdDefault');
	elseif (value == 'toggle') then
		result = _INFM('CmdToggle');
	end
	if (result) then return result; else return value; end
end

function getLocalizedFilterVal(key)
	return localizeFilterVal(Informant.GetFilterVal(key))
end

-- Turns a localized slash command into the generic English version of the command
function delocalizeCommand(cmd)
	if (not commandMap) then buildCommandMap(); end
	local result = commandMap[cmd];
	if (result) then return result; else return cmd; end
end

-- Translate a generic English slash command to the localized version, if available
function localizeCommand(cmd)
	if (not commandMapRev) then buildCommandMap(); end
	local result = commandMapRev[cmd];
	if (result) then return result; else return cmd; end
end

-- Globally accessible functions
Informant.SetLocale = setLocale;

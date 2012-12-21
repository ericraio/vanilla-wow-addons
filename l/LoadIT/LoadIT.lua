--  Title:  LoadIT
--  Author: Saur of Emerald Dream (EU)
--  Original author: Ru of Frostmane
--
--  This is a simple mod to load/unload and enable/disable mods in-game
--
-- * Making a Custom GUI
-- *
-- * to make a custom GUI for LoadIT, set LoadITmenu to 1 in your mod.  This will enable
-- * support for the external UI from within LoadIT and offer the '/mods menu' command.
-- * Name the Frame for the menu, LoadITmenuFrame, and define the following function in your GUI to
-- * receive status updates from LoadIT:
-- *
-- * 		function LoadIT_UpdateMenu(func, param)
-- *
-- *			func = function being performed (see code below)
-- *			param = parameter for function (see code below)
-- *
-- * Be sure to declare LoadIT as a dependency in your .toc, so you can overwrite the value of
-- * LoadITmenu, by forcing your mod to load after LoadIT
-- *
LoadITmenu = nil;

local LO_VERSION	= '11200.1';
local LO_RELEASE_DATE = "August 24, 2006";

LOADIT_VERSION = 'LoadIT ' .. LO_VERSION;

-- myAddons support
local LoadITDetails = 
{
	name = "LoadIT",
	version = LO_VERSION,
	releaseDate = LO_RELEASE_DATE,
	author = "Saur (originally by Ru)",
	email = "pkj@axis.com",
	website = "http://www.curse-gaming.com/mod.php?addid=3512",
	category = MYADDONS_CATEGORY_OTHERS
};

local LO_RED      = '|cffff0000';
local LO_GREEN    = '|cff00ff00';
local LO_BLUE     = '|cff0000ff';
local LO_MAGENTA  = '|cffff00ff';
local LO_YELLOW   = '|cffffff00';
local LO_CYAN     = '|cff00ffff';
local LO_WHITE    = '|cffffffff';
local LO_GREY     = '|ccccccccc';
local LO_GREY_HI  = '|ceeeeeeee';
local LO_BLUE_LOW = '|cff5e9ae4';
local LO_BEIGE    = '|cffffffa0';

local LO_PREFIX = LO_GREY_HI .. 'LoadIT ' .. LO_YELLOW .. ':: ' .. LO_GREY;
local LO_HELP = {
	LOADIT_VERSION .. ', by Saur (originally by Ru) :: Help Menu',
	'list .......................... display list of addons',
	'load <name> ......... load addon',
	'disable <name/#> . disable an addon',
	'disable_all ............. disable all addons',
	'enable <name/#> .. enable & load an addon',
	'enable_all ............. enable all addons',
	'reset_all ................ reset all disabled addons',
	'info <name/#> ....... display details for module',
	'brief ....................... toggle verbose profile loading',
	'reload or rl ............. same as /console reloadui',
	'defaults [save]........ clear all settings [save profiles]',
	'',
	'Add-on profiling Commands:',
	'profiles .................. list all profiles',
	'savep <profile> ..... save profile',
	'loadp <profile> ...... load profile',
	'showp <profile> .... show a profile',
	'delp <profile> ........ delete a profile',
	'rl <profile> ............ load profile and reload console',
	'class ...................... list all class profiles',
	'savec <profile> ..... save module states to class profile',
	'loadc <profile> ...... load a class profile',
	'showc <profile> .... show a class profile',
	'delc <profile> ........ delete a class profile',
	'rlc <profile> ........... load class profile and reload console',
};

local LO_HELP2 = {
	'',
	'menu ..................... configuration menu',
	'menu reset ............ reset menu position',
};

local LO_TEXT_YELLOW = {r = 1.0, g = 1.0, b = 0.0};
local LO_DEFAULT_POSITION   = { x = 0, y = 0 };

LoadITglo = {};			-- storage for session globals

function LoadIT_OnLoad()

--	RegisterForSave("LoadITcf");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED"); 

	LoadIT_Defaults();

	SlashCmdList["LOADIT"] = LoadIT_command;
	SLASH_LOADIT1 = '/mods';
	SLASH_LOADIT2 = '/loadit';

	LoadIT_Print(LOADIT_VERSION .. ', by Saur (originally by Ru) :: Type ' .. LO_CYAN .. '/mods' .. LO_GREY .. ' for Help');
end

function LoadIT_OnEvent(event, arg1)
	if (event == "ADDON_LOADED" and arg1 == "LoadIT") then
		if (myAddOnsFrame_Register) then
			myAddOnsFrame_Register(LoadITDetails);
		end
	end

	-- * add player's class profiles if not found
	if (event == "VARIABLES_LOADED") then
		local class = UnitClass("player");
		local toon = LoadIT_Who();
		if (not LoadITcf.Classes) then LoadITcf.Classes = {}; end
		if (not LoadITcf.Classes[class]) then LoadITcf.Classes[class] = {}; end
		if (not LoadITcf.Characters) then LoadITcf.Characters = {}; end
		if (not LoadITcf.Characters[toon]) then LoadITcf.Characters[toon] = {}; end
	end
end

function LoadIT_Defaults(arg)

	local classes, sets;

	--*  save profiles
	if (arg == 'save') then
		sets = LoadITcf.Sets;
		classes = LoadITcf.Classes;
	end
	
	-- * set configuration defaults
	LoadITcf = {};
	LoadITcf.Position = LO_DEFAULT_POSITION;
	LoadITcf.BTReloadUI = 1;
	LoadITcf.Verbose = 1;
	LoadITcf.LockMenu = 1;
	LoadITcf.Sets = {};
	LoadITcf.Classes = {};					-- default global sets
	LoadITcf.Classes[UnitClass("player")] = {};	-- default set for char class

	LoadITcf.TTdetails = 1;			-- default display addon details tooltip
	LoadITcf.TTbuttons = 1;			-- default display button tooltips

	--*  save profiles
	if (arg == 'save') then
		LoadITcf.Sets = sets;
		LoadITcf.Classes = classes;
	end

	--*  character specific settings
	LoadITcf.Characters = {};
end

--
--	LoadIT_Who() - returns character-specific identity
--
function LoadIT_Who()
	local toon = GetCVar("realmName") .. ':' .. UnitName("player");
	return toon;
end

--
--	LoadIT_Print(msg, silent) - displays a message in chat window
--
--	  msg = message to display
--	  silent = does not display message when true; used in profiles to silence output of other calls
--
function LoadIT_Print(msg, silent)
	if (silent) then return; end
	DEFAULT_CHAT_FRAME:AddMessage(LO_PREFIX .. msg .. '|r');
end

--
--	LoadIT_Show_Addons() - displays list of all addons
--
function LoadIT_Show_AddOns()

	local count = GetNumAddOns();

	if (count) then
		LoadIT_Print( 'List of AddOns:  Enabled = Green, Disabled = Red' );

		local i = 1;
		while (i <= count) do
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
			local loaded = IsAddOnLoaded(i);

			if (not title) then title = name; end
			if (not reason) then reason = ''; end
			if (not security) then security = ''; end

			local s = string.format("%2d", i);

			if (loaded) then
				s = s .. LO_BLUE_LOW .. ' <L> ' .. LO_GREY;
			else
				s = s .. ' <-> ';
			end

			if (enabled) then s = s .. LO_GREEN; else s = s .. LO_RED; end

			s = s .. ' ' .. title;
			if (notes) then s = s .. LO_GREY .. ' - ' .. notes; end;

			LoadIT_Print(s .. ' (' .. name .. ')');
			i = i + 1;
		end
	end
end

--
--	LoadIT_ShowProfiles() - displays list of all profiles
--
function LoadIT_ShowProfiles(type)

	local key,s;
	local count = 0;
	local tmplist = {};
	local tmp = '';

	local class = UnitClass("player");
	if (type == 'class') then
		tmplist = LoadITcf.Classes[class];
		tmp = class .. ' ';
	else
		tmplist = LoadITcf.Sets;
	end

	for key,_ in tmplist do count = count + 1; end;

	if (count > 0) then
		LoadIT_Print(LO_YELLOW .. 'You have ' .. count .. ' saved ' .. tmp .. 'profiles:');
		for key,_ in tmplist do
			LoadIT_Print('Profile :: ' .. key);
		end
	else
		LoadIT_Print(LO_RED .. 'No saved ' .. tmp .. 'profiles');
	end

end

--
--	LoadIT_DeleteProfile() - removes the specified profile
--
function LoadIT_DeleteProfile(p, type)
	local tmp = '';
	if (type == 'class') then
		local class = UnitClass("player");
		LoadITcf.Classes[class][p] = nil;
		tmp = class .. ' ';
	else
		LoadITcf.Sets[p] = nil;
	end
	LoadIT_Print(LO_YELLOW .. 'Removed ' .. tmp .. 'profile: ' .. p);

	--  ** LoadITmenu:  update GUI
	if (LoadITmenu) then LoadIT_UpdateMenu('deleteprofile', p); end
end


--
--	LoadIT_LoadProfile() - loads the specified profile
--
function LoadIT_LoadProfile(p, type)

	local key, s;
	local count = 0;
	local tmp = '';

	local reload_dis = nil;
	local reload_ena = nil;

	local Verbose = nil;
	if (not LoadITcf.Verbose) then Verbose = 1; end

	local class = UnitClass("player");
	if (type == 'class') then
		tmp = class .. ' ';
	end

	if ((not p) or (p == '')) then
		LoadIT_Print(LO_RED .. 'No ' .. tmp .. 'profile name specified');
		return;
	end

	local modules = {};
	if (type == 'class') then
		if (LoadITcf.Classes[class][p]) then
			modules = LoadITcf.Classes[class][p].Modules;
		else
			LoadIT_Print(LO_RED .. 'No ' .. tmp .. 'profile ' .. p .. ' exists');
			return;
		end
	else
		if (LoadITcf.Sets[p]) then
			modules = LoadITcf.Sets[p].Modules;
		else
			LoadIT_Print(LO_RED .. 'No profile ' .. p .. ' exists');
			return;
		end
	end

	LoadIT_Print(LO_YELLOW .. 'Loading ' .. tmp .. 'profile:  ' .. p);
	for key,s in modules do

		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(key);

		if ((enabled) and (s == 0)) then
			if (LoadIT_Disable(name, Verbose, 1)) then reload_dis = 1; end
			count = count + 1;
		elseif ((not enabled) and (s == 1)) then
			if (not LoadIT_Enable(name, Verbose, 1)) then reload_ena = 1; end
			count = count + 1;
		end
	end
	LoadIT_Print('Loaded ' .. tmp .. 'profile:  ' .. p);
	LoadIT_Print('Total:  ' .. count .. ' changes were made');
	if (reload_dis) then LoadIT_Reload(0); end
	if (reload_ena) then LoadIT_Reload(1); end

	--  ** LoadITmenu:  update GUI
	if (LoadITmenu) then LoadIT_UpdateMenu('loadprofile', p); end
	return 1;
end

--
--	LoadIT_ShowProfile(p, type) - displays the specified profile
--
function LoadIT_ShowProfile(p, type)

	local key, s;
	local count = 0;
	local errors = 0;
	local tmp = '';

	local class = UnitClass("player");
	if (type == 'class') then
		tmp = class .. ' ';
	end

	if ((not p) or (p == '')) then
		LoadIT_Print(LO_RED .. 'No ' .. tmp .. 'profile name specified');
		return;
	end

	local modules = {};
	if (type == 'class') then
		if (LoadITcf.Classes[class][p]) then
			modules = LoadITcf.Classes[class][p].Modules;
		else
			LoadIT_Print(LO_RED .. 'No ' .. tmp .. 'profile ' .. p .. ' exists');
			return;
		end
	else
		if (LoadITcf.Sets[p]) then
			modules = LoadITcf.Sets[p].Modules;
		else
			LoadIT_Print(LO_RED .. 'No profile ' .. p .. ' exists');
			return;
		end
	end

	LoadIT_Print('');
	LoadIT_Print(LO_YELLOW .. 'Begin Display Profile:  ' .. LO_CYAN .. p);

	for key,enabled in modules do

		local name, title, notes, _, loadable, reason, security = GetAddOnInfo(key);
		local s = '';

		if (not name) then						-- module missing
			name = '** (' .. key .. ') **';
			errors = errors + 1;
		elseif (title) then
			name = title;
		end

		if (enabled == 1) then
			s = LO_GREEN .. '  ' .. name;
		else
			s = LO_RED .. '  ' .. name;
		end

		LoadIT_Print(s);
		count = count + 1;
	end
	LoadIT_Print('Total:  ' .. count .. ' addons in profile');
	if (errors > 0) then
		LoadIT_Print(LO_RED ..    'Error:  ' .. errors .. ' addons missing in profile');
	end
	LoadIT_Print(LO_YELLOW .. 'End Display ' .. tmp .. 'Profile:  ' .. LO_CYAN .. p);
end

--
--	LoadIT_SaveProfile() - saves the specified profile
--
function LoadIT_SaveProfile(p, type)

	local modules = {};

	if ((not p) or (p == '')) then
		LoadIT_Print(LO_RED .. 'No profile name specified');
		return;
	end

	local count = GetNumAddOns();

	if (count) then

		local tmplist = {};

		local i = 1;
		while (i <= count) do
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
			if (not enabled) then enabled = 0; end
			modules[name] = enabled;
			i = i + 1;
		end

		local tmp = '';
		if (type == 'class') then
			local class = UnitClass("player");
			LoadITcf.Classes[class][p] = {};
			LoadITcf.Classes[class][p].Modules = modules;
			tmp = class .. ' ';
		else
			LoadITcf.Sets[p] = {};
			LoadITcf.Sets[p].Modules = modules;
		end
		LoadIT_Print(LO_YELLOW .. 'Saved current module state to ' .. tmp .. 'profile:  ' .. p);

		--  ** LoadITmenu:  update GUI
		if (LoadITmenu) then LoadIT_UpdateMenu('saveprofile', p); end
	else
		LoadIT_Print(LO_RED .. 'No modules to save.');
	end
end

function LoadIT_AddOnSeparator(arg, c)
	if (arg) then
		local s = LO_GREY;
		if (not c) then
			s = s .. ', ';
		end
		local loaded = IsAddOnLoaded(arg);
		if (loaded) then
			s = s .. arg;
		else
			s = s .. LO_RED .. arg .. "|r";
		end
		return s;
	else
		return '';
	end
end

function LoadIT_DependencyString(name)
	local s = '';
	local key, tmp;
	local deps = { GetAddOnDependencies(name) };
	if (deps[1]) then
		local first = 1;
		for key, tmp in deps do
			s = s .. LoadIT_AddOnSeparator(tmp, first);
			if (first) then first = nil; end
		end
	end
	return s;
end

--
--	LoadIT_Details(addon) - displays details for specified addon
--
function LoadIT_Details(addon)

	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addon);

	if (not title) then
		LoadIT_Print(LO_RED .. 'Error detailing module ' .. addon .. '; Reason: ' .. reason);
		return;
	end

	local loaded = IsAddOnLoaded(addon);

	LoadIT_Print(LO_YELLOW .. 'Begin Module Details: ' .. LO_BLUE_LOW .. name);

	if (enabled) then enabled = 'Yes'; else enabled = 'No'; end
	if (loadable) then loadable = 'Yes'; else loadable = 'No'; end
	if (loaded) then loaded = 'Yes'; else loaded = 'No'; end

	if (title) then    LoadIT_Print('Title ......... ' .. title); end
	if (notes) then    LoadIT_Print('Notes ....... ' .. notes); end
	if (security) then LoadIT_Print('Security .... ' .. security); end

	local loadondemand = IsAddOnLoadOnDemand(name);

	LoadIT_Print('Loadable .. ' .. loadable);
	if (reason) then    LoadIT_Print('Reason ....... ' .. reason); end
	LoadIT_Print('Loaded .... ' .. loaded);
	LoadIT_Print('Enabled .... ' .. enabled)
	if (loadondemand) then LoadIT_Print('(LoadOnDemand Supported)'); end

	local s = LoadIT_DependencyString(name);
	if (s ~= '') then
		LoadIT_Print('Dependencies: ' .. s);
	end

	LoadIT_Print(LO_YELLOW .. 'End Module Details: ' .. LO_BLUE_LOW .. name);

end

--
--	LoadIT_Disable(p, silent, bulk) - disables an addon
--	  p = addon to disable
--	  silent = disables output when true
--	  bulk = disables reload messages during bulk operations
--
--	  return 1 = module was disabled
--	  return nil = module not disabled
--
function LoadIT_Disable(p, silent, bulk)
	if (p) then
		DisableAddOn(p);

		--  ** LoadITmenu:  update GUI
		if ((LoadITmenu) and (not silent)) then LoadIT_UpdateMenu('disable', p); end

		local name, _, _, enabled, _, _, _ = GetAddOnInfo(p);
		if (not enabled) then
			LoadIT_Print(LO_GREEN .. 'DISABLED module ' .. name, silent);
			local loaded = IsAddOnLoaded(name);
			if ((loaded) and (not silent) and (not bulk)) then
				LoadIT_Reload(0);
			end
			return 1;
		else
			LoadIT_Print(LO_RED .. 'Failed to disable module ' .. name);
		end
	else
		LoadIT_Print(LO_RED .. 'No addon name was specified');
	end
end

--
--	LoadIT_Reload(s, silent) - displays message to user to reload ui
--
--	  s = 1 to notify ~enabled modules | 0 to notify ~disabled modules
--	  silent = disables output when true
--
function LoadIT_Reload(s, silent)
	if (silent) then return; end
	if (s == 0) then
		LoadIT_Print(LO_YELLOW .. "You must type '/mods rl' to remove disabled modules from memory");
	else
		LoadIT_Print(LO_YELLOW .. "You must type '/mods rl' to load enabled modules that are not dynamically loadable");
	end
end

--
--	LoadIT_Enable(p, silent, bulk) - enables an addon
--
--	  p = addon to enable
--	  silent = disables output when true
--	  bulk = disables reload messages during bulk operations
--
--	  return 1 = module was enabled
--	  return nil = module not enabled
--
function LoadIT_Enable(p, silent, bulk)
	if (p) then
		EnableAddOn(p);

		--  ** LoadITmenu:  update GUI
		if ((LoadITmenu) and (not silent)) then LoadIT_UpdateMenu('enable', p); end

		local name, _, _, enabled, loadable, reason, _ = GetAddOnInfo(p);
		if (enabled) then
			LoadIT_Print(LO_GREEN .. 'ENABLED module ' .. name, silent);
--
-- disabled auto-loading until a method is available to check if a module supports load-on-demand
--
			local loaded = IsAddOnLoaded(name);
--			if (not loaded) then
--				return LoadIT_Load(name, silent);
--			end
--			return 1;
			if ((not loaded) and (not silent) and (not bulk)) then
				LoadIT_Reload(1);
			end
			return 1;
		else
			LoadIT_Print(LO_RED .. 'Failed to enable ' .. p .. '; Reason: ' .. reason);
		end
	else
		LoadIT_Print(LO_RED .. 'No addon name was specified');
	end
end

--
--	LoadIT_Load(p, silent) - load an addon
--
--	  p = addon to load
--	  silent = disables output when true
--
--	  return 1 = module was loaded
--	  return nil = module not loaded
--
function LoadIT_Load(p, silent)
	if (p) then
		local name, _, _, _, loadable, _, _ = GetAddOnInfo(p);
		if (not loadable) then
			LoadIT_Print(LO_RED .. 'Module is DISABLED or not dynamically loadable: ' .. name, silent);
			return;
		end
		local loaded,reason = LoadAddOn(p);

		--  ** LoadITmenu:  update GUI
		if ((LoadITmenu) and (not silent)) then LoadIT_UpdateMenu('load', p); end

		if (loaded) then
			LoadIT_Print(LO_GREEN .. 'Loaded ' .. name, silent);
			return 1;
		else
			LoadIT_Print(LO_RED .. 'Failed to load ' .. name .. '; Reason: ' .. reason, silent);
		end
	else
		LoadIT_Print(LO_RED .. 'No addon name was specified', silent);
	end
end

function LoadIT_ResetMenu()
	LoadITmenuFrame:ClearAllPoints();
	LoadITmenuFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
end

function LoadIT_OffScreen()
	local left = LoadITmenuFrame:GetLeft();
	local right = LoadITmenuFrame:GetRight();
	
	if (left and right) then
--		left, right = left - (right - left), right + (right - left);
	else
		return 1;		-- off screen
	end

	if (left and left < UIParent:GetLeft()) then
		return 1;		-- off screen
	end
	if (right and right > UIParent:GetRight()) then
		return 1;		-- off screen
	end
end

function LoadIT_command(msg)

	local key,s, enabled, name, reason;
	local _,_,c,p = string.find(msg,"([%w%p]+)%s*(.*)$");

	if (c == 'list') then
		LoadIT_Show_AddOns();
	elseif (c == 'brief') then
		if (LoadITcf.Verbose) then
			LoadITcf.Verbose = nil;
			LoadIT_Print(LO_YELLOW .. 'Verbose mode DISABLED');
		else
			LoadITcf.Verbose = 1;
			LoadIT_Print(LO_YELLOW .. 'Verbose mode ENABLED');
		end
	elseif (c == 'info') then
		LoadIT_Details(p);
	elseif (c == 'defaults') then
		LoadIT_Defaults(p);
		if (p == 'save') then
			LoadIT_Print(LO_RED .. 'RESET all settings and SAVE profiles');
		else
			LoadIT_Print(LO_RED .. 'RESET all settings and profiles');
		end
		if (LoadITmenu) then LoadIT_UpdateMenu('defaults'); end
	elseif (c == 'load') then
		LoadIT_Load(p);
	elseif (c == 'disable') then
		LoadIT_Disable(p);
	elseif (c == 'enable') then
		LoadIT_Enable(p);
	elseif (c == 'disable_all') then
		DisableAllAddOns();
		LoadIT_Print('All addons have been ' .. LO_RED .. 'DISABLED');
	elseif (c == 'enable_all') then
		EnableAllAddOns();
		LoadIT_Print('All addons have been ' .. LO_GREEN .. 'ENABLED');
	elseif (c == 'reset_all') then
		ResetDisabledAddOns();
		LoadIT_Print('All disabled addon states have been ' .. LO_RED .. 'RESET');
	elseif ((c == 'profile') or (c == 'profiles')) then
		LoadIT_ShowProfiles();
	elseif ((c == 'class') or (c == 'cp')) then
		LoadIT_ShowProfiles('class');
	elseif ((c == 'del') or (c == 'delp')) then
		LoadIT_DeleteProfile(p);
	elseif (c == 'delc') then
		LoadIT_DeleteProfile(p, 'class');
	elseif ((c == 'savec') or (c == 'saveclass')) then
		LoadIT_SaveProfile(p, 'class');
	elseif ((c == 'loadc') or (c == 'loadclass')) then
		LoadIT_LoadProfile(p, 'class');
	elseif ((c == 'savep') or (c == 'saveprofile')) then
		LoadIT_SaveProfile(p);
	elseif ((c == 'loadp') or (c == 'loadprofile')) then
		LoadIT_LoadProfile(p);
	elseif ((c == 'showp') or (c == 'showprofile')) then
		LoadIT_ShowProfile(p);
	elseif (c == 'showc') then
		LoadIT_ShowProfile(p, 'class');
	elseif ((c == 'rl') or (c == 'reload')) then
		if ((p) and (p ~= '')) then
			if (not LoadIT_LoadProfile(p)) then
				return;
			end
		end
		ReloadUI();
	elseif (c == 'rlc') then
		if ((p) and (p ~= '')) then
			if (not LoadIT_LoadProfile(p, 'class')) then
				return;
			end
		end
		ReloadUI();
	elseif ((c == 'menu') or (LoadITcf.ShortcutMenu and (not c)))then
		if (LoadITmenu) then
			if (((p) and (p == 'reset')) or LoadIT_OffScreen()) then
				LoadIT_ResetMenu();
			end
			ShowUIPanel(LoadITmenuFrame);
		else
			LoadIT_Print(LO_RED .. 'LoadITmenu is not loaded');
		end
	else
		for key,s in LO_HELP do
			LoadIT_Print(s);
		end
		if (LoadITmenu) then
			for key,s in LO_HELP2 do
				LoadIT_Print(s);
			end
		end
		LoadIT_Print('');
		if (LoadITcf.Verbose == 1) then
			LoadIT_Print('Verbose profile loading is ' .. LO_GREEN .. 'ON');
		else
			LoadIT_Print('Verbose profile loading is ' .. LO_RED .. 'OFF');
		end
	end
end
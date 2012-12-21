--[[

Sea Hooks (mostly Sea.util)

A Mini-Library for standardized function and frame script element hooks.

Compiler:
	AnduinLothar (karlkfi@cosmosui.org)

Contributors:
	Thott (thott@thottbot.com)
	Legorol (legorol@cosmosui.org)
	Mugendai (mugekun@gmail.com)
	

==Installation/Utilization==

Embedding:
- Drop the SeaHooks folder into your Interface\AddOns\YourAddon\ folder
- Add Sea and SeaHooks as optional dependancies
- Add the following line to the end of your TOC file, before your addon files:
SeaHooks\SeaHooks.lua

Standard:
- Drop the SeaHooks folder into your Interface\AddOns\ directory
- Add SeaHooks a required dependancy


Change Log:
v0.7
- Added an inclusive argument to split to catch empty strings
- Changed lua file name
v0.6
- Fixed bug preventing propper unhooking
- Synced with Sea v1.11
v0.5
- Only one replace hook is now called for each hook call, unless it returns true as arg1
- Old style table passing of return arguments as a table is again honored, but not encouraged. All other return value must be nil except fro arg1 (non-nil) and arg2 (argument table)
v0.4
- Optimized split, getValue and setValue for speed and GC (thanks Iriel and krka)
- Removed cleanArgs. Slow and pointless.
- Changed internal SeaHooks_debugErrorPrint syntax to match Sea.io.dprintfc syntax for easy conversion to Sea
- Code Synced with Sea 1.07
v0.3
- Fixed Bug: causing no return from hooked functions where no return replacement was supplied
- Fixed Oversight: causing a return to Frame Script Elements (which don't take any)
- Fixed Oversight: sloppy Sea.util.unhook mirroring
- Hook definitions now use an object refrence rather than a name to save on indexing (Thanks Iriel for suggestion)
- Added Feature: You can now modify return values from either a 'replace' that hides the orig func or an 'after' hook
- Added Feature: Added Error Debug and Vebose Debug by hook function name
/script Sea.util.debugHooks(enabled, verboseHookName)
enabled - boolean, verboseHookName - string equal to 'orig' passed to hook function (nil to disable)
Note: enabling debug usually incurs a heavier proc load and can cause slow down when used with OnUpdate hooks.
- Added Feature: current return values from a hooked function are availible to 'after' hooks via global return variables: Sea.util.returnArgs[1-20]
Note: These arguments are only availible for the durration of the 'after' hook call.
Also, if you call any function within the 'after' hook that would lead to the call of another 'after' hook call then the global Sea.util.returnArgs would most likely change.
Thus it is highly recommend you grab whatever return arguments you need at the beginning of the function call and assign them to local variables.
This method preserves reverse compatibility as well as avoids table creation and thus does not effect GC.
You can also use Sea.util.getReturnArgs() to unpack them for you.  Ex: local arg1, arg2 = Sea.util.getReturnArgs();
- Cleaned up comments and code readability
- Added Feature: Sea.util.cleanArgs eliminates trailing nils in a list of arguments. Used in the hook functions to mask the 20 arguments utilized to avoid GC.
Ex: Sea.util.cleanArgs("a", nil, "b", nil, nil) == "a", nil, "b"
- Now stores a refrence of the hooked function handler in the database to facilitate future overhook recognition
v0.2
- Added input argument modification using a 'before' hook. 
If you return true as the the first arg from a before hook function
the subsequent arguments will be the arguments fed to each hook function called afterwards as well as the orig function.
EX: if your before hook returned (true, nil, 10) then the next hook would be called as func(nil, 10), as would the orig(nil, 10)
This allows you to modify a function output without destroying or hiding the orig function, allowing additional hooks to be called without conflicting functionality.
v0.1 (Alpha)
- SeaHooks Forked into Mini-Library from the main Sea. Still backwards compatible.


	$LastChangedBy: karlkfi $
	$Rev: 2577 $
	$Date: 2005-10-10 14:44:01 -0700 (Mon, 10 Oct 2005) $
]]--

local SEA_HOOKS_VERSION = 0.70;
local loadThisEmbeddedInstance;
local SeaHooks_hookInit, SeaHooks_getDynamicHookHandler, SeaHooks_hookHandler, SeaHooks_hookHandlerQuick, SeaHooks_hookHandlerDebug, SeaHooks_assignReturnArgs, SeaHooks_debugErrorPrint;
SEA_HOOKS_DEBUG = nil;
SEA_HOOKS_DEBUG_VERBOSE = nil;

------------------------------------------------------------------------------
--[[ Embedded Sub-Library Load Algorithm ]]--
------------------------------------------------------------------------------

if(not Sea) then
	Sea = {};
	Sea.versions = {};
	Sea.versions.SeaHooks = SEA_HOOKS_VERSION;
	loadThisEmbeddedInstance = true;
	Sea.util = {};
	Sea.util.Hooks = {};
	Sea.util.valueTable = {};
	Sea.util.returnArgs = {};
else
	if(not Sea.versions) then
		Sea.versions = {};
	end
	if (not Sea.versions.SeaHooks) or (Sea.versions.SeaHooks < SEA_HOOKS_VERSION) then
		Sea.versions.SeaHooks = SEA_HOOKS_VERSION;
		loadThisEmbeddedInstance = true;
	end
	if(not Sea.util) then
		Sea.util = {};
	end
	if(not Sea.util.Hooks) then
		--Is preserved from any previously loaded embedded SeaHook to so that OnLoad triggered hooks from already loaded addons are not lost.
		Sea.util.Hooks = {};
	end
	if ( not Sea.util.valueTable ) then
		Sea.util.valueTable = {};
	end
	if ( not Sea.util.returnArgs ) then
		Sea.util.returnArgs = {};
	end
end

if (loadThisEmbeddedInstance) then
	loadThisEmbeddedInstance = nil;


------------------------------------------------------------------------------
	--[[ Function and Frame Script Element Hooking - User Functions ]]--
------------------------------------------------------------------------------
	
	--
	-- Sea.util.hook( string originalFunctionNameOrFrameName, string newFunction, string hooktype, string scriptElementName )
	--
	-- 	Hooks a function.
	--
	-- 	Example: 
	-- 		Sea.util.hook("some_function","my_function","hide|before|replace|after");
	--		Sea.util.hook("some_frame_name","my_function","hide|before|replace|after", "some_script_element_name");
	--		
	--	Hook types :
	--	"hide" - call "my_function" instead of "some_function". If you return true, subsequent hooks will be called afterwards, otherwise no further hooks nor the orig function will be called.
	--	"before" - call "my_function" before "some_function". If you return true, the subsequent args will be fed into the calls of the orig function as well as any other functions that hook "some_function".
	--	"replace" - call instead of "some_function". If you return true, the orig function will be called afterwards, otherwise subsequent args will be returned by the hooked function call.
	--	"after" - called after "some_function". If you return true subsequent args will be returned by the hooked function call.
	-- 	
	--
	-- Written by Thott (thott@thottbot.com)
	-- Rewritten by AnduinLothar (karlkfi@cosmosui.org)
	Sea.util.hook = function ( orig, new, hooktype, scriptElementName )
		if(not hooktype) then
			hooktype = "before";
		end
		local compoundOrig = orig;
		if (scriptElementName) then
			compoundOrig = orig.."."..scriptElementName;
		end
		SeaHooks_debugErrorPrint((SEA_HOOKS_DEBUG and (SEA_HOOKS_DEBUG_VERBOSE==compoundOrig)), nil, NORMAL_FONT_COLOR, "SeaHooks Progress: Hooking ", orig, " to ", new, ", hooktype ", hooktype, ", scriptElementName ", scriptElementName);
		local newFunc = new;
		if ( type(new) ~= "function" ) then
			newFunc = Sea.util.getValue(new);
		end
		
		local hookObj = Sea.util.Hooks[compoundOrig];
		if(not hookObj) then
			hookObj = SeaHooks_hookInit(orig, compoundOrig, scriptElementName);
		else
			for key,value in hookObj[hooktype] do
				-- NOTE THIS SHOULD BE VALUE! VALUE! *NOT* KEY! (checking if the functions are the same, even if the names are different)
				-- If the function is found previously inserted, it will not rehook
				-- If the function is not found, the new function will be inserted at the end
				if(value == newFunc) then
					SeaHooks_debugErrorPrint((SEA_HOOKS_DEBUG and (SEA_HOOKS_DEBUG_VERBOSE==compoundOrig)), nil, NORMAL_FONT_COLOR, "SeaHooks Progress: Already hooked '", compoundOrig, "' with '", new, "' skipping.");
					return;
				end
			end
		end
		-- intentionally will error if bad hooktype is passed
		local currKey = table.getn(hookObj[hooktype])+1;
		table.insert(hookObj[hooktype], currKey, newFunc);
		hookObj.count = hookObj.count + 1;	--increment hook counter
		
		-- Adds a ["#Info"] table for preserving reverse compatibility while passing the frame name of the frame that called the hook, for debug.
		local infoKey = currKey.."Info";
		local embeddedTable = hookObj[hooktype][infoKey];
		if (type(embeddedTable) ~= "table") then
			embeddedTable = {};
		end
		if (this) and (this:GetName()) then
			embeddedTable.parent = this:GetName();
		else
			embeddedTable.parent = 'unknown';
		end
		embeddedTable.name = new;
		hookObj[hooktype][infoKey] = embeddedTable;	--repackage current hook info into hookObj
		
		Sea.util.Hooks[compoundOrig] = hookObj;	--repackage all hook types
	end
	
	-- 
	-- Sea.util.unhook( string originalFunctionNameOrFrameName, string newFunction, string hooktype, string scriptElementName )
	-- 
	--	Unhooks a function
	--
	--	Example:
	-- 		Sea.util.unhook("some_blizzard_function","my_function","before|after|hide|replace");
	--		Sea.util.unhook("some_frame_name","my_function","before|after|hide|replace", "some_script_element_name");
	--
	-- 	This will remove a function hooked by Sea.util.hook.
	-- 
	-- Written by Thott (thott@thottbot.com)
	-- Rewritten by AnduinLothar (karlkfi@cosmosui.org)
	Sea.util.unhook = function ( orig, new, hooktype, scriptElementName )
		if(not hooktype) then
			hooktype = "before";
		end
		local compoundOrig = orig;
		if (scriptElementName) then
			compoundOrig = orig.."."..scriptElementName;
		end
		SeaHooks_debugErrorPrint((SEA_HOOKS_DEBUG and (SEA_HOOKS_DEBUG_VERBOSE==compoundOrig)), nil, NORMAL_FONT_COLOR, "SeaHooks Progress: Unhooking ", orig, " to ", new, ", hooktype ", hooktype, ", scriptElementName ", scriptElementName);
		local newFunc = new;
		if ( type(new) ~= "function" ) then
			newFunc = Sea.util.getValue(new);
		end
		local hookObj = Sea.util.Hooks[compoundOrig];
		if(not hookObj) then
			hookObj = SeaHooks_hookInit(orig, compoundOrig, scriptElementName);
		else
			local foundIt;
			for key,value in hookObj[hooktype] do
				-- NOTE THIS SHOULD BE VALUE! VALUE! *NOT* KEY! (checking if the functions are the same, even if the names are different)
				-- If the function is found it will be unhooked
				if(value == newFunc) then
					foundIt = true;
					break;
					--exit loop since found hook
				end
			end
			if (not foundIt) then
				SeaHooks_debugErrorPrint((SEA_HOOKS_DEBUG and (SEA_HOOKS_DEBUG_VERBOSE==compoundOrig)), nil, NORMAL_FONT_COLOR, "SeaHooks Progress: '", compoundOrig, "' not hooked with '", new, "' skipping.");
				--hooked function not found so nothing to do
				return;
			end
		end
		local info = hookObj[hooktype]; --Sea.util.Hooks[compoundOrig][hooktype]
		for key,value in info do
			if (type(value) == "function") and (value == newFunc) then
				info[key] = nil;
				local embeddedTable = info[key.."Info"];
				if (type(embeddedTable) == "table") then
					embeddedTable.parent = nil;
					embeddedTable.name = nil;
				end
				info[key.."Info"] = embeddedTable;
				hookObj[hooktype] = info;
				hookObj.count = hookObj.count - 1;	--decrement hook counter
				Sea.util.Hooks[compoundOrig] = hookObj	--repackage all hook types
				SeaHooks_debugErrorPrint((SEA_HOOKS_DEBUG and (SEA_HOOKS_DEBUG_VERBOSE==compoundOrig)), nil, NORMAL_FONT_COLOR, "SeaHooks Progress: Found and unhooked '", new, "' from '", compoundOrig, "'.");
				return;
			end
		end
		-- No Complete Unhooking - Incompatible with Frame Script Element Hooks - Also liable to erase function hooks loaded after the first hook.
		
		Sea.util.Hooks[compoundOrig] = hookObj	--repackage all hook types
	end
	
	-- 
	-- Sea.util.getReturnArgs()
	-- 
	--	Get the current return values of a hooked function from within an 'after' hook. 
	--
	--	Example:
	-- 		local arg1, arg2 = Sea.util.getReturnArgs();
	--
	-- 	This will return nil if called outside of an 'after' hook.
	--	Also, if you call any function within the 'after' hook that would lead to the call of another 'after' hook call then the global Sea.util.returnArgs would most likely change.
	--	Thus it is highly recommend you grab whatever return arguments you need at the beginning of the function call and assign them to local variables.
	--	This method preserves reverse compatibility as well as avoids table creation and thus does not effect GC.
	-- 
	-- Written by AnduinLothar (karlkfi@cosmosui.org)
	Sea.util.getReturnArgs = function()
		return unpack(Sea.util.returnArgs);
	end
	
	--
	-- Sea.util.debugHooks( boolean enable , string verboseFunctionName )
	--
	-- 	Enable standard or verbose error logging. (Prints to the default chat frame)
	--
	-- 	Examples: 
	-- 		On: Sea.util.debugHooks(1);
	-- 		Verbose: Sea.util.debugHooks(1, "ChatFrame_OnLoad");
	-- 		Off: Sea.util.debugHooks(); 
	-- 	
	-- Args:
	-- 	(boolean) enable - true/false
	-- 	(string) verboseFunctionName - the name of a hooked function to enable verbose progress debugging on.
	-- 	
	-- 	/script Sea.util.debugHooks(enabled, verboseHookName)
	--	enabled - boolean, verboseHookName - string equal to 'orig' passed to hook function (nil to disable)
	--	Note: enabling debug usually incurs a heavier proc load and can cause slow down when used with OnUpdate hooks.
	--
	-- Written by AnduinLothar (karlkfi@cosmosui.org),
	Sea.util.debugHooks = function ( enable, verboseFunctionName )
		if (enable) then
			SEA_HOOKS_DEBUG = true;
			if (verboseFunctionName) then
				SEA_HOOKS_DEBUG_VERBOSE = verboseFunctionName;
			else
				SEA_HOOKS_DEBUG_VERBOSE = nil;
			end
		else
			SEA_HOOKS_DEBUG = nil;
			SEA_HOOKS_DEBUG_VERBOSE = nil;
		end
	end
	
------------------------------------------------------------------------------
	--[[ String Parsing - User Functions ]]--
------------------------------------------------------------------------------
	
	-- 
	-- Sea.util.split(string text, string separator [, table oldTable [, boolean noPurge [, boolean inclusive] ] ] )
	--
	-- 	Efficiently splits a string into a table by separators
	--
	-- Args:
	--  (string text, string separator, table oldTable, boolean noPurge, boolean inclusive)
	-- 	text - string containing input
	-- 	separator - separators
	--  oldTable (optional) - table to fill with the results
	--  noPurge (optional) - do not clear extraneous entries in oldTable
	--	inclusive (optional) - catch empty strings, rather than merge them with the next string
	--
	-- Returns:
	-- 	(table)
	-- 	table - the table containing the exploded strings, which is freshly
	-- 		created if oldTable wasn't passed
	--
	-- Aliases:
	-- 	Sea.string.split
	--
	-- Notes:
	-- 	In the interests of avoiding garbage generation, whenever possible pass
	-- 	a table for split to reuse. Also, dont use [ or % in the separator as it
	--	will conflict with the regex.
	--
	-- Written by Thott (thott@thottbot.com)
	-- Modified by Legorol (legorol@cosmosui.org)
	-- Optimized by AnduinLothar (with suggestions from Iriel and krka)
	Sea.util.split = function ( text, separator, t, noPurge, inclusive ) 
		local value;
	   	local mstart, mend = 1;
		local oldn, numMatches = 0, 0;
		local regexKey;
		if (inclusive) then
			regexKey = "([^"..separator.."]*)";
		else
			regexKey = "([^"..separator.."]+)";
		end
		local sfind = strfind;	-- string.find if not in WoW (n calls)
		
		if ( not t ) then
			t = {};
		else
			oldn = table.getn(t);
		end
		
		-- Using string.find instead of string.gfind to avoid garbage generation
		mstart, mend, value = sfind(text, regexKey, mstart);
	   	while (value) do
			numMatches = numMatches + 1;
			t[numMatches] = value
			mstart = mend + 1;
			mstart, mend, value = sfind(text, regexKey, mstart);
	   	end
		
		if ( not noPurge ) then
			for i = numMatches+1, oldn do
				t[i] = nil;
			end
		end
		
		table.setn(t, numMatches);
		
		return t;
	end
	
	-- Aliasing
	if (not Sea.string) then
		Sea.string = {};
	end
	Sea.string.split = Sea.util.split;
	Sea.string.explode = Sea.util.split;
	
	
------------------------------------------------------------------------------
	--[[ Indexed Variable Referencing - User Functions ]]--
------------------------------------------------------------------------------
	
	--
	-- Sea.util.getValue( string variableName )
	--
	-- 	Obtains the value of a variable given its name.
	--
	-- 	Examples: 
	-- 		Sea.util.getValue("ChatFrame_OnLoad");
	-- 		Sea.util.getValue("Class.subclass.element");
	-- 	
	-- Args:
	-- 	(string) variableName - the name of the variable
	-- 	
	-- Returns:
	-- 	value - the value that variable has
	-- 	
	-- 	This function obtains the value that variableName contains.
	-- 	It is able to return the value for both a global variable or for
	-- 	the element of a table. If variableName doesn't exist, it returns nil.
	--
	-- Concept by Mugendai
	-- Written by Legorol (legorol@cosmosui.org)
	-- Optimized by AnduinLothar (with suggestions from Iriel and krka) Increased speed by 170% !
	Sea.util.getValue = function ( variableName ) 
		if ( type(variableName) ~= "string" ) then
			return;
		end
	
		local sfind = strfind; 
		local strsub = strsub;
		
		local sstart = 2;
		local value;
		-- Split the variable name at ".", first field is a global name
		local match = sfind(variableName, '.', sstart, true);
		if ( match ) then
			value = getglobal(strsub(variableName, 0, match-1));
		else
			return getglobal(variableName);
		end
			
		while true do
			if (type(value) ~= "table") then
				-- Returns nil rather than trying to index a non-table
				return;
			end
	                sstart = match + 1;
			match = sfind(variableName, '.', sstart, true);
	
			if ( match ) then
				-- next one (there are more)
				value = value[strsub(variableName, sstart, match-1)];
			else
				-- last one
				return value[strsub(variableName, sstart)];
			end
	   	end
	end
	
	--
	-- Sea.util.setValue( string variableName, value )
	--
	-- 	Sets the value of a variable given its name.
	--
	-- 	Examples: 
	-- 		Sea.util.setValue("ChatFrame_OnLoad", MyChatFrame_OnLoad);
	-- 		Sea.util.setValue("Class.subclass.element", 5);
	-- 		Sea.util.setValue("Class.subclass.function", function() dostuff; end);
	-- Args:
	-- 	(string) variableName - the name of the variable to change
	-- 	value - the new value of the variable
	-- 	
	-- Returns:
	-- 	(boolean) success - true if the operation succeeded
	-- 	
	-- 	This function sets the value of variableName.
	-- 	It is able to set the value for both a global variable or for
	-- 	the element of a table, including functions. If variableName
	-- 	already exists, it is overwritten.
	--
	-- Concept by Mugendai
	-- Written by Legorol (legorol@cosmosui.org)
	-- Optimized by AnduinLothar (with suggestions from Iriel and krka)
	Sea.util.setValue = function ( variableName, newValue ) 
		if ( type(variableName) ~= "string" ) then
			return;
		end
	
		local sfind = strfind; 
		local strsub = strsub;
		
		local sstart = 2;
		local value;
		-- Split the variable name at ".", first field is a global name
		local match = sfind(variableName, '.', sstart, true);
		if ( match ) then
			value = getglobal(strsub(variableName, 0, match-1));
		else
			setglobal(variableName, newValue);
			return true;
		end
			
		while true do
			if (type(value) ~= "table") then
				-- Returns nil rather than trying to index a non-table
				return false;
			end
	                sstart = match + 1;
			match = sfind(variableName, '.', sstart, true);
	
			if ( match ) then
				-- next one (there are more)
				value = value[strsub(variableName, sstart, match-1)];
			else
				-- last one
				value[strsub(variableName, sstart)] = newValue;
				return true;
			end
	   	end
	   	
	   	-- Error occured, subtable is not a table
		return false;
	end


------------------------------------------------------------------------------
	--[[ Function and Frame Script Element Hooking - Internal Functions ]]--
------------------------------------------------------------------------------
	
	--
	-- Hook Initialization
	--
	--	Create a database instantiation the first time a hook is registered for a function. Stores the original function and establishes hook tables.
	-- 
	-- Written by AnduinLothar (karlkfi@cosmosui.org)
	SeaHooks_hookInit = function ( orig, compoundOrig, scriptElementName )
		SeaHooks_debugErrorPrint((SEA_HOOKS_DEBUG and (SEA_HOOKS_DEBUG_VERBOSE==compoundOrig)), nil, NORMAL_FONT_COLOR, "SeaHooks Progress: Hook Init  - storing '", compoundOrig, "' orig and replacing with hookHandler.");
		local hookObj = {
			name = compoundOrig;
			count = 0;
			before = {};
			after = {};
			hide = {};
			replace = {};
		};
		-- Set up the hook the first time
		if (scriptElementName) then
			local origFrame = Sea.util.getValue(orig);
			hookObj.orig = origFrame:GetScript(scriptElementName);
			hookObj.hookFunction = SeaHooks_getDynamicHookHandler(compoundOrig);
			origFrame:SetScript(scriptElementName, hookObj.hookFunction);
			Sea.util.setValue(orig, origFrame);	--Reasign refrenced and modified origFrame
		else
			hookObj.orig = Sea.util.getValue(orig);
			hookObj.hookFunction = SeaHooks_getDynamicHookHandler(compoundOrig);
			Sea.util.setValue(orig, hookObj.hookFunction);
		end
		return hookObj;
	end
	
	SeaHooks_getDynamicHookHandler = function ( databaseID )
		return function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return SeaHooks_hookHandler(databaseID,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) end;
	end
	
	--
	-- Hook Handler
	--
	-- Handles the name and the argument table.
	-- An instantiated copy of this function is set to all hooked functions, passing the name of the original function staticly and any arguments dynamicly.
	-- 
	-- Written by Thott (thott@thottbot.com)
	-- Rewritten by AnduinLothar (karlkfi@cosmosui.org)
	SeaHooks_hookHandler = function (hookInfo,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		hookInfo = Sea.util.Hooks[hookInfo]	--hookInfo passed in as string, exported as table on demand.
		if (SEA_HOOKS_DEBUG) then
			return SeaHooks_hookHandlerDebug(hookInfo,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
		end
		return SeaHooks_hookHandlerQuick(hookInfo,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
	end
	
	--Quick (non-debug) Hook Handler.  Called for each hook function to iterate over hook functions and original.
	SeaHooks_hookHandlerQuick = function (hookObj,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		if (type(hookObj) ~= "table") then
			hookObj = Sea.util.Hooks[hookObj];
			if (not hookObj) then
				return;
			end;
		end
		if (hookObj.count == 0) then
			if (hookObj.orig) then
				return hookObj.orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
			end
			return;
		end
		local ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;	--return args
		local toggle;
		for key, value in hookObj.hide do
			if(type(value) == "function") then
				toggle,ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				if(not toggle) then
					return ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;
				end
			end
		end
		local ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20;	--temp args
		for key, value in hookObj.before do
			if(type(value) == "function") then
				toggle,ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				if(toggle) then
					a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20 = ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20;
				end
			end
		end
		toggle = true;
		for key, value in hookObj.replace do
			if(type(value) == "function") then
				toggle,ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				if(not toggle) then
					ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20;
					break;
				end
			end
		end
		if (toggle) and (hookObj.orig) then
			ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = hookObj.orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
		end
		for key,value in hookObj.after do
			if(type(value) == "function") then
				SeaHooks_assignReturnArgs(true,ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20);
				toggle,ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				SeaHooks_assignReturnArgs();
				if(toggle) then
					ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20;
				end
			end
		end
		if ( (type(ra1) == "table") and ( ( ra2 and ra3 and ra4 and ra5 and ra6 and ra7 and ra8 and ra9 and ra10 and ra11 and ra12 and ra13 and ra14 and ra15 and ra16 and ra17 and ra18 and ra19 and ra20 ) == nil ) ) then
			return unpack(ra1);
		end
		return ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;
	end
	
	--Debug Hook Handler.  Called for each hook function to iterate over hook functions and original.
	SeaHooks_hookHandlerDebug = function (hookObj,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		--assumes SEA_HOOKS_DEBUG
		local name, parent, hookFuncName;
		if (type(hookObj) ~= "table") then
			name = hookObj;
			hookObj = Sea.util.Hooks[hookObj];
			-- Quick exit since there's nothing to do!
			if (not hookObj) then
				SeaHooks_debugErrorPrint(true, nil, RED_FONT_COLOR, "SeaHooks Error: SeaHooks_hookHandler called with no defined hook parameters for '", name, "'.");
				return;
			end;
		else
			name = hookObj.name or 'unknown';
		end
		local debugVerbose = (SEA_HOOKS_DEBUG_VERBOSE) and (SEA_HOOKS_DEBUG_VERBOSE == name);
		if (hookObj.count == 0) then
			--Quickly Exit if no hooks exist
			if (hookObj.orig) then
				SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: No known hooks for '", name, "'. Calling orig.");
				return hookObj.orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
			end
			SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: No known hooks or orig for '", name, "'. Exiting.");
			return;
		end
		local ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;	--return args
		local toggle; -- used for first arg returns from hooks
		-- Itterate over and call 'hide' hooks. If there are none the for loop is skipped.
		for key, value in hookObj.hide do
			if(type(value) == "function") then
				if (type(hookObj.hide[key.."Info"]) == "function") then
					parent = hookObj.hide[key.."Info"].parent;
					hookFuncName = hookObj.hide[key.."Info"].name;
				end
				SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: calling 'hide' hook #", key, ": '", hookFuncName,"' for '", name, "', registered by '", parent,"'.");
				--toggle (true) used to call orig function
				toggle,ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				if(not toggle) then
					if (SEA_HOOKS_DEBUG) then
						SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: 'hide' hook #", key, " for '", name, "' has hidden all subsequent hook and original function calls.");
						local numHideHooks = table.getn(hookObj.hide);
						SeaHooks_debugErrorPrint((numHideHooks > key), nil, RED_FONT_COLOR, "SeaHooks Error: detected ", numHideHooks, " 'hide' hooks for '", name, "', one of which has hidden another. This will most likely cause addon conflicts.");
					end
					--exit after first hide unless it says to call orig
					return ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;
				end
			end
		end
		local ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20;	--temp args
		-- Itterate over and call 'before' hooks. If there are none the for loop is skipped.
		for key, value in hookObj.before do
			if(type(value) == "function") then
				SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: calling a 'before' hook for '", name, "'.");
				--toggle (true) used to override the input args
				toggle,ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				if(toggle) then
					-- Last 'before' hook that modifies input overrides all previous 'before' hooks for input values.
					-- Keep in mind any previous input modification will modify the input of subsequent 'before' hooks as well as all the subsequent hook and orig function calls
					a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20 = ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20;
					SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: 'before' hook #", key, " for '", name, "' has returned argument(s) to be passed to subsequent hook and original function calls.");
				end
			end
		end
		toggle = true; -- if no 'replace' hooks are called, calls the orig
		-- Itterate over and call 'replace' hooks. If there are none the for loop is skipped.
		for key, value in hookObj.replace do
			if(type(value) == "function") then
				SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: calling a 'replace' hook for '", name, "'.");
				--toggle (true) used to call the orig
				toggle,ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				if(not toggle) then
					-- Last 'replace' hook that modifies output (not toggle) overrides all previous 'replace' hooks for return values.
					-- Theorhetically it would be nice if 'replace' hooks that fequently returned true to continue were called before ones that didn't.
					-- That could be done by reordering the 'replace' list. Is it worth it?  It might still conflict on first call.  It might be better to just inform the debugger and let the programmer unhook and rehook in the order he wants.
					ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20;
					--We should only call one replace hook that doesn't request the origional be called.  Otherwise we will perform multiple versions of the main function, which would likely be worse, than not calling the extras at all.
					break;
				end
			end
		end
		if (toggle) and (hookObj.orig) then		--Frame Script Elements do not necissarily have an orig function
			SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: calling the 'orig' function for '", name, "'.");
			-- If the 'orig' is called use its return values, overrides any 'replace' return values defined before a final continuing one.
			ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = hookObj.orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
		end
		-- Itterate over and call 'after' hooks. If there are none the for loop is skipped.
		for key,value in hookObj.after do
			if(type(value) == "function") then
				SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: calling an 'after' hook for '", name, "'.");
				--toggle (true) used to override the return args
				--Current function return args availible via global pass vars
				SeaHooks_assignReturnArgs(true,ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20);
				toggle,ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				SeaHooks_assignReturnArgs(); --nil pass vars
				if(toggle) then
					-- Last 'after' hook that modifies output overrides all other hooks for return values.
					ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = ta1,ta2,ta3,ta4,ta5,ta6,ta7,ta8,ta9,ta10,ta11,ta12,ta13,ta14,ta15,ta16,ta17,ta18,ta19,ta20;
					SeaHooks_debugErrorPrint(debugVerbose, nil, NORMAL_FONT_COLOR, "SeaHooks Progress: 'after' hook for '", name, "' has returned argument(s) to be passed to subsequent hook and original function calls.");
				end
			end
		end
		--Only unpack ra1 if it is the only return argument passed.
		if ( (type(ra1) == "table") and ( ( ra2 and ra3 and ra4 and ra5 and ra6 and ra7 and ra8 and ra9 and ra10 and ra11 and ra12 and ra13 and ra14 and ra15 and ra16 and ra17 and ra18 and ra19 and ra20 ) == nil ) ) then
			SeaHooks_debugErrorPrint(SEA_HOOKS_DEBUG, nil, RED_FONT_COLOR, "SeaHooks Error: Return argument #1 is a table for '", name, "'. This can be used to pass return arguments from a replace/after hook. If that is not the intention of your hook then pass an additional non-nil argument to avoid unpacking.");
			return unpack(ra1);
		end
		return ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;
	end
	
	-- Assigns up to 20 arguments to a global table so as to save on table creation and still allow return argument passing to 'after' hooks
	-- Written by AnduinLothar (karlkfi@cosmosui.org)
	SeaHooks_assignReturnArgs = function( toggle,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20 )
		local temp = Sea.util.returnArgs;
		if (toggle) then
			temp[1]=a1;temp[2]=a2;temp[3]=a3;temp[4]=a4;temp[5]=a5;temp[6]=a6;temp[7]=a7;temp[8]=a8;temp[9]=a9;temp[10]=a10;
			temp[11]=a11;temp[12]=a12;temp[13]=a13;temp[14]=a14;temp[15]=a15;temp[16]=a16;temp[17]=a17;temp[18]=a18;temp[19]=a19;temp[20]=a20;
			local n=0;
			for i=1, 20 do
				if temp[i] then
					n=i;
				end
			end
			table.setn(temp,n);
		else
			for i=1, 20 do
				temp[i]=nil;
			end
			table.setn(temp,0);
		end
		Sea.util.returnArgs = temp;
	end
	
	-- Quick Sea print bypass for speed. (only makes 1 table) Won't cause as much slow down on debug. But don't try to vebose debug any OnUpdate functions.
	-- Written by AnduinLothar (karlkfi@cosmosui.org)
	SeaHooks_debugErrorPrint = function( toggle, frameUnused, color, ... )
		--frameUnused is a placeholder to match Sea.io.dprintfc syntax
		if (toggle) then
			local msg = "";
			for key, value in arg do
				if (type(key) == "number") then
					if ( value == nil ) then
						msg = msg .. "(nil)";
					else
						local currType = type(value);
						if (currType == "boolean" ) then 
							msg = msg .. "(";
							if (value) then
								msg = msg .. "true";
							else
								msg = msg .. "false";
							end
							msg = msg .. ")";
						elseif (currType ~= "string" and currType ~= "number") then
		        			msg = msg .. "(" .. currType .. ")";
						else
							msg = msg .. value;
						end
					end
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(msg, color.r, color.g, color.b);
		end
	end
	
	
	--New Database Style: Sea.util.Hooks[compoundOrig][hooktype][embeddedKey][infoTypes]
	--Update old style hook database (Immediate Execution)
	for origName, info in Sea.util.Hooks do
		if (type(info) == "table") then
			Sea.util.Hooks[origName].count = 0;
			for hookType, hookTable in info do
				if (type(hookTable) == "table") then
					if (type(hookTable.n) == "number") then
						table.setn(Sea.util.Hooks[origName][hookType], hookTable.n);
						SeaHooks_debugErrorPrint((SEA_HOOKS_DEBUG and SEA_HOOKS_DEBUG_VERBOSE), nil, NORMAL_FONT_COLOR, "SeaHooks Progress: Updating Hook Registry for '", origName, "' - '", hookType, "' hooks, ", hookTable.n, " found. If possible, these hooks might benifit if their addons optionally required SeaHooks.");
						Sea.util.Hooks[origName][hookType].n = nil;
					end
					local i=1;
					while (type(hookTable[i]) == "function") do
						Sea.util.Hooks[origName].count = Sea.util.Hooks[origName].count + 1;
						i=i+1;
					end
				end
			end
		end
	end
	
end

